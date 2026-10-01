---
title: SQL Server Setup or Upgrade Can't Validate a gMSA
description: Resolve SQL Server Setup and upgrade failures when Setup rejects a group managed service account (gMSA) or the host can't retrieve the managed password.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ai-usage: ai-assisted
---

# Troubleshoot SQL Server setup and upgrade failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot SQL Server Setup and upgrade failures that occur when Setup rejects or can't validate a group managed service account (gMSA) for the SQL Server or SQL Server Agent service. It explains how to check the principals that are authorized to retrieve the managed password, test password retrieval, and resolve Active Directory replication, DNS, secure-channel, and time synchronization problems.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Symptoms

- Setup reports that the service account is invalid or that account validation failed.
- The gMSA exists, but Setup can't configure SQL Server or SQL Server Agent.
- The failure occurs during installation, repair, add-features, add-node, or upgrade.

## Cause

Setup must resolve the account and validate that the host can retrieve and use its managed password. Common causes include incomplete Active Directory replication, incorrect authorized principals, or domain connectivity failures.

Setup failures that aren't related to the service account have separate guidance. Before you continue, confirm from the Setup logs that the first failure is a service-account validation failure. For general Setup failure triage, see [SQL Server installation errors](../install/windows/error-install-sql-server.md), and for log locations and structure, see [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).

## Diagnose gMSA setup and upgrade failures

1. Run the [quick validation checklist](sql-server-setup-startup-authentication-issues-with-gmsas.md#quick-validation-checklist) commands on the affected host.
1. Confirm that the host computer account, or an authorized group, is listed in `PrincipalsAllowedToRetrieveManagedPassword`.
1. Search `Summary.txt` and `Detail.txt` for the first service-account validation failure.

_**Expected result:**_ `Get-ADServiceAccount` returns the intended account and authorized principals, and `Test-ADServiceAccount` returns `True`.

## Resolve gMSA setup and upgrade failures

Use the solution that matches the condition you identified. Retry Setup only after `Test-ADServiceAccount` returns `True` on the affected host.

### Correct the principals authorized to retrieve the gMSA password

1. From a management computer that has the Active Directory PowerShell module installed, review the current configuration.

    ```powershell
    Get-ADServiceAccount -Identity 'SQLgMSA' `
      -Properties PrincipalsAllowedToRetrieveManagedPassword |
      Select-Object Name, PrincipalsAllowedToRetrieveManagedPassword
    ```

1. Confirm that the affected SQL Server computer account, or a security group that contains that computer account, is listed. If the affected SQL Server host or an approved security group isn't listed in `PrincipalsAllowedToRetrieveManagedPassword`, update the gMSA configuration through your organization's approved Active Directory process:

    - If your organization manages authorized hosts through an Active Directory security group, have an Active Directory administrator add the affected computer account to that approved group. For example:

      ```powershell
      Add-ADGroupMember -Identity 'SQL-gMSA-Hosts' `
        -Members 'SQL01$'
      ```

    - If your organization authorizes principals directly on the gMSA, have an Active Directory administrator update the gMSA with the complete approved principal list. For example:

      ```powershell
      Set-ADServiceAccount -Identity 'SQLgMSA' `
        -PrincipalsAllowedToRetrieveManagedPassword `
        'CONTOSO\SQL-gMSA-Hosts'
      ```

      > [!CAUTION]
      > The `PrincipalsAllowedToRetrieveManagedPassword` value is a complete authorized-principal list. Before you use `Set-ADServiceAccount`, review the existing value and include every principal that must remain authorized. Don't unintentionally remove other SQL Server hosts or cluster nodes.

1. If you changed a security-group membership, refresh the affected computer's group membership according to your organization's change process.
1. On every host that can run SQL Server, verify the result.

    ```powershell
    Get-ADServiceAccount -Identity 'SQLgMSA' `
      -Properties PrincipalsAllowedToRetrieveManagedPassword

    Test-ADServiceAccount -Identity 'SQLgMSA'
    ```

    _**Expected result:**_ the intended computer account or approved group appears in `PrincipalsAllowedToRetrieveManagedPassword`, and `Test-ADServiceAccount` returns `True`.

For more information, see the following articles:

- [Get-ADServiceAccount](/powershell/module/activedirectory/get-adserviceaccount)
- [Set-ADServiceAccount](/powershell/module/activedirectory/set-adserviceaccount)
- [Manage group managed service accounts](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/manage-group-managed-service-accounts)

### Resolve directory replication, DNS, secure-channel, or domain-controller connectivity failures

1. On the affected SQL Server host, run the following checks from an elevated PowerShell session. Replace `contoso.com` with the Active Directory domain name.

    ```powershell
    Resolve-DnsName -Name '_ldap._tcp.dc._msdcs.contoso.com' `
      -Type SRV
    ```

    ```cmd
    nltest /dsgetdc:contoso.com
    nltest /sc_verify:contoso.com
    w32tm /query /status
    ```

1. Correct the condition that the checks identify:

    - If DNS resolution or domain-controller discovery fails, correct the host's DNS client configuration and verify that it uses DNS servers that can resolve the Active Directory domain.
    - If `nltest /sc_verify` reports a secure-channel failure, have a Windows or Active Directory administrator repair the computer's domain secure channel through the organization-approved process.
    - If the time status is unhealthy, correct time synchronization before you retest, because Active Directory authentication depends on accurate time.
    - If the authorized-principal change isn't visible on the domain controller that the SQL Server host contacts, have an Active Directory administrator check replication. For example:

      ```cmd
      repadmin /replsummary
      repadmin /showrepl *
      ```

      Active Directory replication depends on network connectivity, DNS name resolution, authentication and authorization, time accuracy, the directory database, and the replication topology. Use `repadmin /showrepl` and `repadmin /replsummary` to identify Active Directory replication failures.

1. After the underlying condition is corrected, rerun `Test-ADServiceAccount`.

    ```powershell
    Test-ADServiceAccount -Identity 'SQLgMSA'
    ```

    _**Expected result:**_ a domain controller is discovered, secure-channel verification succeeds, time synchronization is healthy, the gMSA configuration is visible from the contacted domain controller, and `Test-ADServiceAccount` returns `True`.

## Collect diagnostic data

If Setup still can't validate the gMSA after you complete these steps, collect diagnostic data from the affected host for the same failure interval. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [SQL Server Setup fails with error 0x84BB0001 when you use a gMSA](gmsa-setup-error-0x84bb0001.md)
- [SQL Server upgrade fails with error 29569](../install/windows/sql-server-upgrade-failed-error-29569.md)
- [SQL Server installation errors](../install/windows/error-install-sql-server.md)
