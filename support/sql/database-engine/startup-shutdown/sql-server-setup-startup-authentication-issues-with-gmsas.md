---
title: SQL Server gMSA Setup, Startup, and Authentication Failures
description: Validate a SQL Server group managed service account (gMSA) with a checklist, and then resolve setup, startup, SQL Server Agent, cluster, or Kerberos failures.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---

# Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article is the entry point for SQL Server installation, upgrade, service startup, SQL Server Agent, failover cluster instance (FCI), Kerberos, linked server, and availability group failures that occur when SQL Server services run under a group managed service account (gMSA). Most of these symptoms have the same root causes whether or not a gMSA is involved, so each scenario article isolates the gMSA-specific checks and links to the canonical troubleshooting article for the rest.

Start with the [quick validation checklist](#quick-validation-checklist). Then use the [troubleshooting path](#choose-a-troubleshooting-path) that matches the observed failure to find the scenario article that has the diagnostic and resolution steps. For background on selecting and configuring service accounts for SQL Server, including managed service accounts and gMSAs, see [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions). For gMSA creation and management in Active Directory, see [Manage group managed service accounts](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/manage-group-managed-service-accounts).

## Prerequisites

- Local administrative access to each affected SQL Server host or cluster node.
- Access to [SQL Server Setup Bootstrap logs](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files), the [SQL Server error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log), the [SQL Server Agent error log](/ssms/agent/sql-server-agent-error-log), and the [Windows application and system logs](/sql/tools/configuration-manager/viewing-the-windows-application-log).
- The Active Directory PowerShell module for [`Get-ADServiceAccount`](/powershell/module/activedirectory/get-adserviceaccount) and [`Test-ADServiceAccount`](/powershell/module/activedirectory/test-adserviceaccount). If the module isn't present, see [Install and manage Remote Server Administration Tools in Windows](/windows-server/administration/install-remote-server-administration-tools).
- Appropriate Active Directory permissions, or assistance from an Active Directory administrator, to validate password retrieval, service principal names (SPNs), delegation, and authorized hosts.
- Permission to run Transact-SQL diagnostic queries when the Database Engine is available. The diagnostic queries in this article and in the scenario articles read server-scoped dynamic management views and catalog views. For the required permissions, which vary by version, see [System dynamic management views and functions](/sql/relational-databases/system-dynamic-management-objects/system-dynamic-management-objects#permissions).

> [!IMPORTANT]
> Collect evidence before you change service accounts, security policy, registry values, SPNs, or failover cluster settings. Record the failure time and the server time zone. Run the host validation commands locally on every affected standalone server, cluster node, or replica, and then compare the results. Replace the example account, service, instance, and domain names with values from your environment.

## Quick validation checklist

Run these checks on every affected host before you open a scenario-specific article. For an FCI or availability group, run them on every possible owner node or replica and compare the results.

1. Confirm the configured SQL Server and SQL Server Agent service identities by reviewing the **Log On As** value in SQL Server Configuration Manager and the `SERVICE_START_NAME` output from `sc.exe qc`.

    For a default instance, run the following commands.

    ```cmd
    sc.exe qc MSSQLSERVER
    sc.exe qc SQLSERVERAGENT
    ```

    _**Expected result:**_ `SERVICE_START_NAME` identifies the intended gMSA. For a named instance, use `MSSQL$<InstanceName>` and `SQLAgent$<InstanceName>`. Replace `<InstanceName>` with the instance name.

1. Confirm that Active Directory can find the gMSA by running `Get-ADServiceAccount` and verifying that it returns the intended account.

    Run the following command in an elevated PowerShell session.

    ```powershell
    Get-ADServiceAccount -Identity 'SQLgMSA' -Properties PrincipalsAllowedToRetrieveManagedPassword
    ```

    _**Expected result:**_ `Get-ADServiceAccount` returns the intended account and lists the host.

1. Confirm that the host computer account, or a group that contains it, is listed in `PrincipalsAllowedToRetrieveManagedPassword`.
1. Test password retrieval from every affected host or possible owner node by running `Test-ADServiceAccount` locally and confirming that it returns `True`.

    Run the following command in an elevated PowerShell session.

    ```powershell
    Test-ADServiceAccount -Identity 'SQLgMSA'
    ```

    _**Expected result:**_ `Test-ADServiceAccount` returns `True` on every host that can run the SQL Server service.

1. Confirm that Service Control Manager treats the service account as managed by running `sc.exe qmanagedaccount` for the exact SQL Server or SQL Server Agent service name and verifying that it reports `TRUE`.

    For a default instance, run the following commands.

    ```cmd
    sc.exe qmanagedaccount MSSQLSERVER
    sc.exe qmanagedaccount SQLSERVERAGENT
    ```

    _**Expected result:**_ `qmanagedaccount` reports `TRUE`.

1. Confirm DNS, domain-controller discovery, secure-channel health, and time synchronization.

    Run the following commands. Replace `contoso.com` with the Active Directory domain name.

    ```cmd
    nltest /dsgetdc:contoso.com
    nltest /sc_verify:contoso.com
    w32tm /query /status
    ```

    _**Expected result:**_ a domain controller is discovered, the secure channel succeeds, and time status is healthy.

1. If SQL Server starts, confirm the current authentication scheme by querying `sys.dm_exec_connections` from a remote Windows-authenticated session.

For additional host-level gMSA checks that aren't specific to SQL Server, see [Troubleshoot gMSAs for Windows containers](/virtualization/windowscontainers/manage-containers/gmsa-troubleshooting).

## Choose a troubleshooting path

| Observed symptom | Refer to |
| --- | --- |
| Setup rejects the gMSA or can't validate it | [Troubleshoot setup and upgrade failures with gMSAs](gmsa-setup-upgrade-failures.md) |
| Setup fails with 0x84BB0001 or "Access is denied" | [Setup fails with error 0x84BB0001](gmsa-setup-error-0x84bb0001.md) |
| Error 1069, Event ID 7041, or Event ID 7038 | [Troubleshoot service startup failures with gMSAs](gmsa-service-startup-failures.md) |
| Service fails only during boot | [Troubleshoot service startup failures with gMSAs](gmsa-service-startup-failures.md#correlate-a-boot-time-only-failure) |
| `IsManagedAccount` or `qmanagedaccount` is `FALSE` | [Troubleshoot service startup failures with gMSAs](gmsa-service-startup-failures.md) |
| SQL Server Agent starts but jobs fail | [Troubleshoot SQL Server Agent job failures with gMSAs](gmsa-sql-server-agent-job-failures.md) |
| FCI setup, add-node, startup, or failover fails | [Troubleshoot failover cluster instance failures with gMSAs](gmsa-failover-cluster-instance-failures.md) |
| NTLM fallback, SPN error, ANONYMOUS LOGON, or availability group endpoint authentication failure | [Troubleshoot Kerberos and authentication failures with gMSAs](gmsa-kerberos-authentication-failures.md) |
| Upgrade fails with error 29569 | [SQL Server upgrade fails with error 29569](../install/windows/sql-server-upgrade-failed-error-29569.md) |

## Collect diagnostic data

If the quick validation checklist and the scenario-specific checks don't isolate the cause, collect the following diagnostic data before you continue the investigation or open a support case. Gather every artifact from the same failure interval so that the evidence correlates.

Collect the following gMSA-specific evidence from every affected host, node, or replica:

- `Get-ADServiceAccount` output, including `PrincipalsAllowedToRetrieveManagedPassword`.
- `Test-ADServiceAccount` result.
- `sc.exe qc` and `sc.exe qmanagedaccount` output for the SQL Server and SQL Server Agent services.
- `nltest /dsgetdc`, `nltest /sc_verify`, and `w32tm /query /status` output.
- Effective user-right assignments and `gpresult` output.
- SPN ownership and duplicate checks for the gMSA.
- For an FCI, the cluster log covering the resource transition.

Collect the following standard SQL Server diagnostic data for the same interval:

- Setup logs, including `Summary.txt`, `Detail.txt`, and feature-specific logs. See [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).
- Current and archived SQL Server error logs, SQL Server Agent logs, and failed job history.
- System, Application, and relevant Security event logs.

For tool selection and automated collection, see [Troubleshooting and diagnostic tools for SQL Server](../../tools/sql-support-troubleshooting-diagnostic-tools.md). You can use [SQL LogScout](https://github.com/microsoft/SQL_LogScout) to automate collection when it's appropriate for the investigation.

## Related content

- [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions)
- [Manage group managed service accounts](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/manage-group-managed-service-accounts)
- [Error 1069 occurs when you start SQL Server Service](error-1069-service-cannot-start.md)
- [SQL Server startup errors on a standalone server](sql-server-startup-errors.md)
- [Change the service startup account](/sql/database-engine/configure-windows/scm-services-change-the-service-startup-account)
