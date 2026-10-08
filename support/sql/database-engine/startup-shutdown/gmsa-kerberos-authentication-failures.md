---
title: Resolve SQL Server gMSA Kerberos, SPN, and Delegation Failures
description: Resolve SQL Server Kerberos failures under a gMSA, including NTLM fallback, SPN errors, double-hop ANONYMOUS LOGON, and availability group endpoint access.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---

# Troubleshoot SQL Server Kerberos and authentication failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot Kerberos, linked server, and availability group authentication failures when SQL Server runs under a group managed service account (gMSA). These failures have the same causes whether the service account is a gMSA or a domain user account. For a full diagnostic path, use the following references:

- [Cannot generate SSPI context](../connect/cannot-generate-sspi-context-error.md)
- [Consistent authentication issues in SQL Server](../connect/consistent-authentication-connectivity-issues.md)

Use the following sections for the differences that apply only to gMSAs, such as service principal name (SPN) ownership, delegation, and endpoint permissions.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Kerberos or SPN failures

### Check SPNs for the gMSA

- **List SPNs with the computer-account form of the name.** A gMSA is a computer-class object, so the account name requires a trailing dollar sign.

  ```cmd
  setspn -L CONTOSO\SQLgMSA$
  setspn -Q MSSQLSvc/sql01.contoso.com:1433
  ```

- **Confirm that automatic SPN registration can succeed.** SQL Server registers its SPN at startup only if the service account can write to its own `servicePrincipalName` attribute. If the gMSA doesn't have that permission, the SQL Server error log reports that the SPN couldn't be registered, and an administrator must register it manually. For more information, see [Register a service principal name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections).

- **Recheck SPN ownership after a service-account change.** SPNs that were registered on the previous account remain on that account. Move or remove them so that the expected `MSSQLSvc` SPN has exactly one owner: the gMSA that now runs SQL Server.

### Verify Kerberos authentication for the gMSA

1. Run the following command on the client before you retest.

    ```cmd
    klist purge
    ```

1. Reconnect from a remote Windows-authenticated session and run the following query.

    ```sql
    SELECT c.auth_scheme, c.net_transport, c.client_net_address
    FROM sys.dm_exec_connections AS c
    WHERE c.session_id = @@SPID;
    ```

    _**Expected result:**_ a new remote Windows-authenticated connection reports `KERBEROS`.

For missing, duplicate, or misplaced SPNs and for Kerberos Configuration Manager, see the following references:

- [Cannot generate SSPI context](../connect/cannot-generate-sspi-context-error.md)
- [Explicit misplaced SPN](../connect/explicit-spn-is-misplaced.md)
- [Use Kerberos Configuration Manager](../connect/using-kerberosmngr-sqlserver.md)

## Linked server or double-hop failures

A linked server that uses the current security context fails with `NT AUTHORITY\ANONYMOUS LOGON` when the second hop can't delegate the user identity. You need correct SPNs, but they don't enable the second hop by themselves.

### Check delegation for the gMSA

- Configure constrained delegation on the _gMSA object_ by setting `msDS-AllowedToDelegateTo`, or by configuring resource-based constrained delegation on the destination. Delegation configured on a user account doesn't apply.
- If you changed the service account from a domain user account to a gMSA, confirm that the delegation settings were re-created on the gMSA. Delegation doesn't transfer with the SPN.

Verify the first hop before you investigate delegation.

```sql
SELECT ORIGINAL_LOGIN() AS original_login, SUSER_SNAME() AS execution_login, c.auth_scheme
FROM sys.dm_exec_connections AS c
WHERE c.session_id = @@SPID;
```

_**Expected result:**_ the first hop reports `KERBEROS`.

For the full double-hop diagnostic path, see the following references:

- [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon)
- [Linked server connectivity errors in SQL Server](../connect/linked-server-account-mapping-error.md)
- [You can't use Kerberos unconstrained delegation in certain versions of Windows](../connect/windows-prevents-unconstrained-delegation.md)

## Availability group replica authentication failures

Availability group connectivity depends on endpoint state, URL and port, firewall, DNS, `CONNECT` permission, and service-account authentication. Validate these separately from client Kerberos, and use SPN evidence only when the error specifically indicates Kerberos or SSPI.

### Check endpoint permissions for the gMSA

- Grant `CONNECT` on the database mirroring endpoint to the gMSA login in the `[CONTOSO\SQLgMSA$]` form on every replica. A login created for the previous service account doesn't authorize the gMSA.
- If replicas run under different gMSAs, confirm that each replica has a login and `CONNECT` permission for every partner service account.

```sql
SELECT ar.replica_server_name, ars.role_desc, ars.connected_state_desc, ars.synchronization_health_desc
FROM sys.availability_replicas AS ar
LEFT JOIN sys.dm_hadr_availability_replica_states AS ars ON ar.replica_id = ars.replica_id;

SELECT name, state_desc, type_desc, port
FROM sys.tcp_endpoints
WHERE type_desc = 'DATABASE_MIRRORING';
```

_**Expected result:**_ the endpoint is `STARTED`, the port is reachable, and replica state progresses to `CONNECTED`.

For endpoint, firewall, and connectivity troubleshooting that isn't specific to the service account, see [Availability replica is disconnected within an Always On availability group](../availability-groups/availability-replica-is-disconnected.md) and [Troubleshoot Always On availability groups configuration](/sql/database-engine/availability-groups/windows/troubleshoot-always-on-availability-groups-configuration-sql-server).

## Collect diagnostic data

If authentication still fails after you complete these steps, collect diagnostic data from the SQL Server host and every affected replica for the same failure interval. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [Register a service principal name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections)
- [Cannot generate SSPI context](../connect/cannot-generate-sspi-context-error.md)
