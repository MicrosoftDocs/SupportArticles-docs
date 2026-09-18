---
title: Troubleshoot SQL Server setup, startup, and authentication issues with gMSAs
description: Diagnose and fix SQL Server setup, startup, and authentication failures when SQL Server services run under a group managed service account (gMSA).
ms.reviewer: prmadhes, jopilov
ms.topic: troubleshooting-general
ms.date: 09/16/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---

# Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you diagnose SQL Server installation, upgrade, service startup, SQL Server Agent, failover cluster instance, Kerberos, linked server, and availability group authentication failures when SQL Server services use a group Managed Service Account (gMSA). Start with the quick validation checklist, choose the path that matches the observed failure, and then follow the diagnostic and resolution steps. For information about selecting and configuring service accounts for SQL Server, including managed service accounts and gMSAs, see [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions).

## Prerequisites

- Local administrative access to each affected SQL Server host or cluster node.
- Access to SQL Server Setup Bootstrap logs, SQL Server error logs, SQL Server Agent logs, and Windows event logs.
- The Active Directory PowerShell module (RSAT-AD-PowerShell) for Get-ADServiceAccount and Test-ADServiceAccount.
- Appropriate Active Directory permissions, or assistance from an Active Directory administrator, to validate password retrieval, SPNs, delegation, and authorized hosts.
- Permission to run Transact-SQL diagnostic queries when the Database Engine is available.

> [!IMPORTANT]
> Collect evidence before you change service accounts, security policy, registry values, service principal names (SPNs), or failover cluster settings. Record the failure time and the server time zone. Run the host validation commands locally on every affected standalone server, cluster node, or replica, and then compare the results. Replace the example account, service, instance, and domain names with values from your environment.

## Quick validation checklist

1. Confirm the configured SQL Server and SQL Server Agent service identities by reviewing the Log On As value in SQL Server Configuration Manager and the SERVICE_START_NAME output from sc.exe qc.
1. Confirm that Active Directory can find the gMSA by running Get-ADServiceAccount and verifying that it returns the intended account.
1. Test password retrieval from every affected host or possible owner node by running Test-ADServiceAccount locally and confirming that it returns True.
1. Confirm that Service Control Manager treats the service account as managed by running sc.exe qmanagedaccount for the exact SQL Server or SQL Server Agent service name and verifying that it reports TRUE.
1. Check Event ID 7041, Event ID 7038, and record the complete Error 1069 message and failure time.
1. Confirm DNS, domain-controller discovery, secure-channel health, and time synchronization by reviewing the results of nltest /dsgetdc, nltest /sc_verify, and w32tm /query /status.
1. If SQL Server starts, confirm the current service identity and authentication scheme  by querying sys.dm_exec_connections from a remote Windows-authenticated session.
1. For an FCI or availability group, run the same identity, managed-account, domain-connectivity, and authentication checks on every possible owner node or replica, and compare the results for differences.

**Validate the gMSA from an elevated PowerShell session:**
```PowerShell
Get-ADServiceAccount -Identity 'SQLgMSA' -Properties PrincipalsAllowedToRetrieveManagedPassword
Test-ADServiceAccount -Identity 'SQLgMSA'
```

_**Expected result:**_ Test-ADServiceAccount returns True on every host that can run the SQL Server service.

Check the default-instance services:
```cmd
sc.exe qc MSSQLSERVER
sc.exe qmanagedaccount MSSQLSERVER
sc.exe qc SQLSERVERAGENT
sc.exe qmanagedaccount SQLSERVERAGENT
```
_**Expected result:**_ SERVICE_START_NAME identifies the intended gMSA and qmanagedaccount reports TRUE. For a named instance, use MSSQL$InstanceName and SQLAgent$InstanceName.

Validate domain connectivity:
```cmd
nltest /dsgetdc:contoso.com
nltest /sc_verify:contoso.com
w32tm /query /status
```
_**Expected result:**_ a domain controller is discovered, the secure channel succeeds, and time status is healthy.

## Choose a troubleshooting path

| Observed symptom | Go to |
|---|---|
| Setup rejects the gMSA or cannot validate it | [Troubleshoot setup and upgrade failures with gMSAs](#troubleshoot-setup-and-upgrade-failures-with-gmsas) |
| Setup fails with 0x84BB0001 or Access is denied | [Setup fails with error 0x84BB0001](#setup-fails-with-error-0x84bb0001) |
| Upgrade fails with error 29569 | [Upgrade fails with error 29569](#upgrade-fails-with-error-29569) |
| Error 1069, Event ID 7041, or Event ID 7038 | [Troubleshoot service startup failures with gMSAs](#troubleshoot-service-startup-failures-with-gmsas) |
| Service fails only during boot | [Service fails during startup but starts manually later](#service-fails-during-startup-but-starts-manually-later) |
| IsManagedAccount or qmanagedaccount is FALSE | [Managed-account state is incorrect](#managed-account-state-is-incorrect) |
| SQL Server Agent starts but jobs fail | [Troubleshoot SQL Server Agent job failures with gMSAs](#troubleshoot-sql-server-agent-job-failures-with-gmsas) |
| FCI setup, add-node, startup, or failover fails | [Troubleshoot failover cluster instance failures with gMSAs](#troubleshoot-failover-cluster-instance-failures-with-gmsas) |
| NTLM fallback, SPN error, ANONYMOUS LOGON, or AG endpoint authentication failure | [Troubleshoot Kerberos and authentication failures with gMSAs](#troubleshoot-kerberos-and-authentication-failures-with-gmsas) |

## Troubleshoot setup and upgrade failures with gMSAs

### Symptoms

- Setup reports that the service account is invalid or account validation failed.
- The gMSA exists, but Setup cannot configure SQL Server or SQL Server Agent.
- The failure occurs during installation, repair, add-features, add-node, or upgrade.

### Cause

Setup must resolve the account and validate that the host can retrieve and use its managed password. Common causes include incomplete Active Directory replication, incorrect authorized principals, or domain connectivity failures.

### Diagnostic steps

- Run the Active Directory validation commands on the affected host.
- Confirm that the host computer account or an authorized group is listed in PrincipalsAllowedToRetrieveManagedPassword.
- Validate DNS, domain-controller discovery, secure-channel health, and time synchronization.
- Search Summary.txt and Detail.txt for the first service-account validation failure.

**Commands**
```PowerShell
Get-ADServiceAccount -Identity 'SQLgMSA' -Properties PrincipalsAllowedToRetrieveManagedPassword
Test-ADServiceAccount -Identity 'SQLgMSA'
```
```cmd
nltest /dsgetdc:contoso.com
nltest /sc_verify:contoso.com
```
_**Expected result:**_
- Get-ADServiceAccount returns the intended account and authorized principals.
- Test-ADServiceAccount returns True.

### Resolution

- Correct the authorized-principals configuration through the approved Active Directory process.
- Resolve directory replication, DNS, secure-channel, or domain-controller connectivity failures.

Retry Setup only after Test-ADServiceAccount returns True on the affected host.

## Setup fails with error 0x84BB0001

### Symptoms

- Setup reports 0x84BB0001 or Access is denied.
- Detail.txt contains LookupADEntry, DirectoryEntries.Find, or UnauthorizedAccessException.
- Changing permissions on SQL data folders does not resolve the failure.

### Cause

The identity running Setup can be blocked during an Active Directory or remote Security Account Manager lookup. The gMSA itself can be valid while the Setup account or effective security policy blocks the required lookup.

### Diagnostic steps
- Identify the denied identity from Detail.txt.
- Search Setup logs for 0x84BB0001, LookupADEntry, DirectoryEntries.Find, UnauthorizedAccessException, and RestrictRemoteSAM.
- Review the effective Network access: Restrict clients allowed to make remote calls to SAM policy.
- For FCI Setup, review permissions for the cluster computer object and virtual computer object.

**Search Setup logs from PowerShell**
```PowerShell
Get-ChildItem 'C:\Program Files\Microsoft SQL Server\*\Setup Bootstrap\Log' -Recurse -File |
  Select-String -Pattern '0x84BB0001|LookupADEntry|DirectoryEntries.Find|UnauthorizedAccessException|RestrictRemoteSAM'
```
_**Expected result:**_
- The search identifies the earliest relevant log entry and denied identity.

### Resolution

- Authorize the Setup identity through the organization-approved policy.
- Correct applicable directory or cluster-object permissions.
- Allow policy and directory replication to complete, and then retry Setup.

> **Caution:** Do not broadly weaken domain security policy or grant permanent local administrator rights to the gMSA as a workaround.

## Upgrade fails with error 29569

### Symptoms

- Setup reports error 29569.
- Upgrade fails while restoring or identifying an installed feature or instance.

### Cause
Setup cannot restore required instance metadata when InstanceId or related uninstall metadata is missing or inconsistent.

### Diagnostic steps

- Review Summary.txt and the Database Engine feature log for error 29569.
- Export the relevant uninstall registry key before making any change.
- Confirm that InstanceId and installed-feature metadata match the affected instance.

**List SQL Server uninstall metadata**
```PowerShell
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' |
  Where-Object { $_.DisplayName -like '*SQL Server*' } |
  Select-Object DisplayName, DisplayVersion, PSChildName
```
_**Expected result:**_
- The output provides candidate installed-product entries for comparison with Setup logs.

### Resolution

- Restore only confirmed missing metadata from a validated source or under Microsoft Support guidance.
- Retry the upgrade after installed-instance metadata is consistent.

## Troubleshoot service startup failures with gMSAs

### Error 1069 and Event ID 7041

#### Symptoms

- SQL Server or SQL Server Agent reports Error 1069.
- The System log contains Service Control Manager Event ID 7041.

#### Cause

Event ID 7041 indicates that the service identity does not have a required logon right, commonly Log on as a service, or is affected by a deny assignment.

#### Diagnostic steps

- Export and review effective user-right assignments.
- Identify the Group Policy object that owns the assignment.
- Confirm that the gMSA is not covered by Deny log on as a service.
- Recheck Event ID 7041 after policy refresh.

**Export effective security policy**
```PowerShell
secedit /export /cfg C:\Temp\effective-security-policy.inf
Select-String -Path "C:\Temp\effective-security-policy.inf" `
  -Pattern "SeServiceLogonRight|SeDenyServiceLogonRight"

**Identify applied policies**
```PowerShell
gpresult /h C:\Temp\gpresult.html /f
```
_**Expected result:**_
- The gMSA or an applicable group is present in SeServiceLogonRight and absent from SeDenyServiceLogonRight.

#### Resolution

- Assign the required right through the authoritative Group Policy.
- Remove any conflicting deny assignment through the approved security process.
- Refresh policy, restart the service, and confirm that Event ID 7041 does not recur.

### Error 1069 and Event ID 7038

#### Symptoms

- SQL Server or SQL Server Agent reports Error 1069.
- The System log contains Event ID 7038.
- The event text refers to an invalid account, password, domain, or logon failure.

#### Cause

Event ID 7038 can indicate an incorrect service identity, failed gMSA password retrieval, incorrect managed-account state, or domain connectivity failure.

#### Diagnostic steps

- Read the complete Event ID 7038 message.
- Confirm the configured service identity.
- Run Test-ADServiceAccount locally.
- Check qmanagedaccount for the affected service.
- Validate domain-controller discovery and the computer secure channel.

Default instance
```cmd
sc.exe qc MSSQLSERVER
sc.exe qmanagedaccount MSSQLSERVER
PowerShell -NoProfile -Command "Test-ADServiceAccount -Identity 'SQLgMSA'"
nltest /dsgetdc:contoso.com
nltest /sc_verify:contoso.com
```
Named instance example
```cmd
sc.exe qc MSSQL$SQL20xx
sc.exe qmanagedaccount MSSQL$SQL20xx
```

_**Expected result:**_
- SERVICE_START_NAME is correct.
- qmanagedaccount reports TRUE.
- Test-ADServiceAccount returns True.

#### Resolution

- Correct the specific account, password-retrieval, managed-account, or domain condition identified by the evidence.
- Use SQL Server Configuration Manager for supported service-account changes.
- Restart the service and verify that Event ID 7038 does not recur.

## Service fails during startup but starts manually later

### Symptoms

- The service fails automatically after reboot.
- Event ID 7038 states that the domain cannot be contacted.
- Manual startup succeeds after networking and domain services become available.

### Cause

The service attempts to authenticate before DNS, Netlogon, time synchronization, or domain-controller discovery is ready.

### Diagnostic steps

- Correlate server boot, DNS, Netlogon, domain discovery, and SQL startup timestamps.
- After the server is fully online, validate domain discovery, secure channel, and gMSA password retrieval.
- Determine whether the service is standalone or cluster-managed.

**Connectivity checks**
```cmd
nltest /dsgetdc:contoso.com
nltest /sc_verify:contoso.com
w32tm /query /status
PowerShell -NoProfile -Command "Test-ADServiceAccount -Identity 'SQLgMSA'"
```
_**Expected result:**_
- All checks succeed after host initialization. A difference between boot-time and later results supports a startup-order investigation.

### Resolution

- Correct slow DNS, secure-channel, or domain-controller discovery.
- For a standalone instance, evaluate Automatic (Delayed Start) only if appropriate for the environment.
- For an FCI, retain cluster-managed startup and troubleshoot WSFC dependencies.

## Managed-account state is incorrect

### Symptoms

- sc.exe qmanagedaccount reports FALSE.
- The service registry configuration is missing ServiceAccountManaged.
- Reassigning the same gMSA temporarily restores startup.

### Cause

Service Control Manager is not treating the service identity as a managed account and can rely on stale locally stored information.

### Diagnostic steps

- Verify that Test-ADServiceAccount succeeds before changing service state.
- Run qmanagedaccount for the exact service name.
- Confirm that the configured identity is the intended gMSA.

**Default instance**
```cmd
sc.exe managedaccount MSSQLSERVER TRUE
sc.exe qmanagedaccount MSSQLSERVER
```
Named instance example
```cmd
sc.exe managedaccount MSSQL$SQL2022 TRUE
sc.exe qmanagedaccount MSSQL$SQL2022
```
_**Expected result:**_
- qmanagedaccount reports TRUE.

### Resolution

- Set the managed-account state for the affected service.
- Confirm that qmanagedaccount reports TRUE.
- Restart the service and validate a controlled reboot.

## Troubleshoot SQL Server Agent job failures with gMSAs

### Symptoms

- Agent starts, but SSIS, Maintenance Plan, backup, PowerShell, or CmdExec job steps fail.
- Errors identify a missing component, file, proxy, credential, share, or NTFS permission.

### Cause

Separate component or runtime failures from external-resource access failures. A failure after an account change is not automatically a gMSA password-management problem.

### Diagnostic steps

- Identify the failing job-step subsystem and first actionable error.
- Review the most recent failed job history.
- For network paths, validate share and NTFS permissions for the actual execution identity.
- Review Agent proxy and credential configuration where applicable.
- Validate installed Integration Services components and runtime architecture for SSIS failures.

Review recent failed jobs
```sql
SELECT TOP (100) j.name, h.step_id, h.step_name, h.run_date, h.run_time, h.message
FROM msdb.dbo.sysjobhistory AS h
JOIN msdb.dbo.sysjobs AS j ON h.job_id = j.job_id
WHERE h.run_status = 0
ORDER BY h.instance_id DESC;
```
_**Expected result:**_
- The message column identifies the failing subsystem, file, component, or destination.

### Resolution

- Install or repair only confirmed missing components.
- Correct SSIS deployment or runtime compatibility.
- Grant only required destination-resource permissions.
- Correct the Agent proxy, credential, or job-step execution context.

## Troubleshoot failover cluster instance failures with gMSAs

### Symptoms

- FCI Setup fails during account validation.
- An add-node operation reports inconsistent service-account information.
- SQL Server starts from the command line but not through the cluster.
- Failover fails because node-specific startup parameters or configuration are missing.

### Cause

FCI failures can involve password retrieval, incomplete Setup metadata, node-specific startup parameters, rights that differ by node, storage access, or Cluster Service health checks.

### Diagnostic steps

- Run gMSA validation on every possible owner node.
- Compare service identity, managed-account state, effective rights, and startup parameters across nodes.
- Review Setup history for canceled or incomplete add-node operations.
- Collect SQL Server error log and Cluster log for the same resource transition.
- Confirm that -d, -e, and -l startup parameters reference valid shared-storage paths.

Run on every node
``PowerShell
Test-ADServiceAccount -Identity 'SQLgMSA'
sc.exe qmanagedaccount MSSQLSERVER
Get-ClusterResource | Format-Table Name, ResourceType, State, OwnerGroup -AutoSize
```
Generate a cluster log
```PowerShell
Get-ClusterLog -UseLocalTime -Destination C:\Temp
```

_**Expected result:**_
- Test-ADServiceAccount returns True on every possible owner node.
- Service configuration and startup parameters are consistent for the same FCI.

### Resolution

- Authorize every possible owner node to retrieve the managed password.
- Correct confirmed node-specific rights, startup parameters, or incomplete Setup state.
- Correct the storage, permission, or health-check condition found in the logs.
- Perform controlled failover and failback validation.

> **Caution:** Do not copy registry values between unrelated instances. Verify the instance ID, shared-storage paths, clustered role, and node before making a change.

## Troubleshoot Kerberos and authentication failures with gMSAs

### Kerberos or SPN failures

#### Symptoms

- SQL Server cannot register an MSSQLSvc SPN.
- Remote Windows authentication uses NTLM when Kerberos is expected.
- Connectivity changed after a service-account change.

#### Cause

Kerberos requires the expected MSSQLSvc SPN to be registered on the identity running SQL Server. Missing, duplicate, or incorrectly owned SPNs prevent correct Kerberos authentication.

#### Diagnostic steps

- List SPNs registered on the gMSA.
- Query each expected MSSQLSvc SPN and check for duplicates.
- Connect from a remote client and query auth_scheme.
- After directory corrections, purge the client ticket cache and reconnect.

List and query SPNs
```cmd
setspn -L CONTOSO\SQLgMSA$
setspn -Q MSSQLSvc/sql01.contoso.com:1433
setspn -X
```
Verify the current SQL connection
```sql
SELECT c.auth_scheme, c.net_transport, c.client_net_address
FROM sys.dm_exec_connections AS c
WHERE c.session_id = @@SPID;
```
Refresh client tickets
```cmd
klist purge
```
_**Expected result:**_
- The expected SPN has one owner: the SQL Server service identity.
- A new remote Windows-authenticated connection reports KERBEROS.

#### Resolution

- Register missing SPNs on the correct service identity through the approved process.
- Remove only validated duplicate or obsolete SPNs.
- Reacquire Kerberos tickets and verify auth_scheme.

### Linked-server or double-hop failures

#### Symptoms

- A linked server that uses the current security context fails with NT AUTHORITY\ANONYMOUS LOGON.
- The first hop succeeds, but the second hop cannot delegate the user identity.

#### Cause

A genuine client-to-SQL-to-destination path requires correct SPNs and approved delegation. SPNs alone do not enable the second hop.

#### Diagnostic steps

- Document the client, source SQL Server, destination service, and execution identity.
- Verify Kerberos on the client-to-source connection.
- Validate SPNs for both services.
- Review approved delegation configuration for the source service identity.
- Test the destination independently to separate delegation from destination permissions.

Check the first hop
```sql
SELECT ORIGINAL_LOGIN() AS original_login, SUSER_SNAME() AS execution_login, c.auth_scheme
FROM sys.dm_exec_connections AS c
WHERE c.session_id = @@SPID;
```
Inspect cached tickets on the client
```cmd
klist
```
_**Expected result:**_
- The first hop reports KERBEROS and the delegated destination is explicitly allowed.

#### Resolution

- Correct SPN ownership first.
- Configure approved constrained delegation for the required destination service.
- Reacquire tickets and retest from the original remote client.

### Availability group replica authentication failures

#### Symptoms

- A replica cannot establish an authenticated endpoint connection.
- Logs include SPN, endpoint, login, firewall, or connection errors.

#### Cause

Availability group connectivity depends on endpoint state, URL and port, firewall, DNS, CONNECT permission, and service-account authentication. Validate these separately from client Kerberos.

#### Diagnostic steps

- Review replica and endpoint state.
- Confirm endpoint URL, listening port, and STARTED state.
- Validate name resolution and TCP reachability between replicas.
- Confirm CONNECT permission for the partner service identity.
- Use SPN evidence only when the error specifically indicates Kerberos or SSPI.

Review replicas and endpoints
```sql
SELECT ar.replica_server_name, ars.role_desc, ars.connected_state_desc, ars.synchronization_health_desc
FROM sys.availability_replicas AS ar
LEFT JOIN sys.dm_hadr_availability_replica_states AS ars ON ar.replica_id = ars.replica_id;

SELECT name, state_desc, type_desc, port
FROM sys.tcp_endpoints
WHERE type_desc = 'DATABASE_MIRRORING';
```
Test endpoint TCP reachability from PowerShell
```PowerShell
Test-NetConnection -ComputerName sql02.contoso.com -Port 5022
```
_**Expected result:**_
- The endpoint is STARTED, the port is reachable, and replica state progresses to CONNECTED.

#### Resolution

- Start or correct the endpoint if required.
- Correct endpoint URL, firewall, DNS, or CONNECT permission.
- Correct validated SPN ownership issues independently.

## Collect advanced diagnostic data

Use this section when the quick checklist and scenario-specific evidence do not isolate the cause. Capture all artifacts from the same failure interval.

### SQL Server Setup and servicing details and logs

- Summary.txt, Detail.txt, and feature-specific Setup logs.
- Windows Installer and servicing logs for the failed operation.
- Version, edition, instance name, node, action, service identity, and failure time.
- For an FCI, logs from every participating node.

### SQL Server and SQL Server Agent logs

- Current and archived SQL Server error logs.
- SQL Server Agent logs and failed job history.
- For availability groups, error logs from all replicas.
- Startup progress indicators, including recovery, network initialization, and readiness for client connections.

### Windows and domain information

- System, Application, and relevant Security event logs.
- Service Control Manager, Netlogon, DNS, Group Policy, and domain authentication events.
- gpresult output, effective user-right assignments, service configuration, and relevant registry exports.
- Get-ADServiceAccount and Test-ADServiceAccount results from every affected host.

### Cluster and authentication information

- Cluster log covering the resource transition.
- SPN ownership and duplicate checks.
- Client Kerberos tickets and connection authentication scheme.
- For double hop, the complete client-to-source-to-destination path.
- For availability groups, endpoint configuration, port reachability, state, and permissions.

Use [SQL LogScout](https://github.com/microsoft/SQL_LogScout) to automate collection of requested SQL Server diagnostic data when it is appropriate for the investigation.

## More information

- [Configure Windows Service Accounts and Permissions](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions?view=sql-server-ver17)
- [Error 1069 when starting SQL Server Service](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/startup-shutdown/error-1069-service-cannot-start)
- [Change the Service Startup Account (SQL Server Configuration Manager)](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/scm-services-change-the-service-startup-account?view=sql-server-ver17)
- [SQL Server startup errors](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/startup-shutdown/sql-server-startup-errors)
- [Create new Failover Cluster Instance - SQL Server Always On](https://learn.microsoft.com/en-us/sql/sql-server/failover-clusters/install/create-a-new-sql-server-failover-cluster-setup?view=sql-server-ver17)
- [Register a Service Principal Name for Kerberos Connections](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections?view=sql-server-ver17)
- [Using Kerberos Configuration Manager for SQL Server](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/using-kerberosmngr-sqlserver)