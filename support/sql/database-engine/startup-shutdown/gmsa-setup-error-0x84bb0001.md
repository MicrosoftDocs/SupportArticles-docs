---
title: Resolve SQL Server Setup Error 0x84BB0001 With a gMSA
description: Resolve SQL Server Setup error 0x84BB0001 or "Access is denied" when a remote SAM or Active Directory lookup blocks the Setup identity during a gMSA install.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ai-usage: ai-assisted
---

# SQL Server Setup fails with error 0x84BB0001 when you use a gMSA

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you resolve SQL Server Setup error 0x84BB0001 ("Access is denied") when you install SQL Server with a group managed service account (gMSA). The error occurs when an Active Directory or remote Security Account Manager (SAM) lookup blocks the identity that runs Setup, even though the gMSA itself is valid. The article explains how to identify the denied identity, review the remote SAM Group Policy setting, and correct Active Directory or cluster-object permissions.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Symptoms

- Setup reports `0x84BB0001` or "Access is denied".
- `Detail.txt` contains `LookupADEntry`, `DirectoryEntries.Find`, or `UnauthorizedAccessException`.
- Changing permissions on SQL Server data folders doesn't resolve the failure.

## Cause

An Active Directory or remote SAM lookup can block the identity running Setup. The gMSA itself can be valid while the Setup account or the effective security policy blocks the required lookup.

## Diagnose error 0x84BB0001

1. Identify the denied identity from `Detail.txt`.
1. Search Setup logs for `0x84BB0001`, `LookupADEntry`, `DirectoryEntries.Find`, `UnauthorizedAccessException`, and `RestrictRemoteSAM`.

    Run the following command in PowerShell.

    ```powershell
    Get-ChildItem 'C:\Program Files\Microsoft SQL Server\*\Setup Bootstrap\Log' -Recurse -File |
      Select-String -Pattern '0x84BB0001|LookupADEntry|DirectoryEntries.Find|UnauthorizedAccessException|RestrictRemoteSAM'
    ```

    _**Expected result:**_ the search identifies the earliest relevant log entry and the denied identity.

1. Review the effective **Network access: Restrict clients allowed to make remote calls to SAM** policy.
1. For failover cluster instance (FCI) Setup, review permissions for the cluster computer object and the virtual computer object.

## Resolve error 0x84BB0001

> [!CAUTION]
> Don't broadly weaken domain security policy or grant permanent local administrator rights to the gMSA as a workaround.

### Authorize the Setup identity through the approved security policy

The **Network access: Restrict clients allowed to make remote calls to SAM** policy controls which users and groups can make remote calls to SAM and Active Directory. Its access-control entries can explicitly allow or deny defined principals. Keep the policy in place and add only the required account to its remote-access allow list.

1. Use `Detail.txt` to identify the account that received the access-denied error. Don't assume that the denied identity is the gMSA, because SQL Server Setup might be failing while it uses the identity that launched Setup.
1. Generate an effective Group Policy report on the affected server.

    ```powershell
    New-Item -ItemType Directory -Path C:\Temp -Force
    gpresult /h C:\Temp\gpresult.html
    ```

1. Open `C:\Temp\gpresult.html`, identify the Group Policy object (GPO) that configures **Network access: Restrict clients allowed to make remote calls to SAM**, and have the security or Group Policy administrator review that authoritative GPO.
1. If the Setup logs confirm that this policy blocks the required lookup, add only the identified Setup identity or an approved security group to the policy's remote-access allow list. Don't disable the policy broadly or grant access to a large, unrelated group. Preserve your organization's security baseline.

    1. In **Group Policy Management**, edit the authoritative GPO.
    1. Go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
    1. Open **Network access: Restrict clients allowed to make remote calls to SAM**.
    1. Select **Edit Security**, add the approved identity or group, and grant **Remote Access**.
    1. Apply the policy according to your organization's change-management process.

1. On the affected server, refresh Group Policy and generate another result report.

    ```powershell
    gpupdate /force
    gpresult /h C:\Temp\gpresult-after.html
    ```

For more information, see [Network access: Restrict clients allowed to make remote calls to SAM](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls).

### Correct Active Directory or cluster-object permissions

For a standalone installation, use the first `UnauthorizedAccessException`, `LookupADEntry`, or `DirectoryEntries.Find` entry in `Detail.txt` to identify the directory object and denied operation. Have an Active Directory administrator grant only the permission required for that operation on the applicable object or organizational unit.

For an FCI installation, follow these steps:

1. Identify the cluster name object and the virtual computer object involved in the failed Setup operation.
1. In **Active Directory Users and Computers**, select **View** > **Advanced Features**.
1. Locate the affected computer object or the organizational unit in which Setup must create or update the object.
1. In the object's **Properties**, select **Security** > **Advanced**, and verify that the cluster name object or approved provisioning identity has only the permissions required by the organization's cluster-object provisioning model.
1. If the virtual computer object was prestaged, verify that it isn't disabled and that the cluster name object has the organization-approved control permissions on it.
1. If Setup must create the object, verify the approved create-computer-object permissions on the target organizational unit.

Don't grant broad permissions based only on error 0x84BB0001. Correlate the directory object and denied operation with `Detail.txt`, Group Policy results, and cluster evidence first.

### Verify that policy and directory changes replicated before you retry Setup

1. After the administrator updates Group Policy or Active Directory permissions, run the following commands.

    ```powershell
    gpupdate /force
    repadmin /replsummary
    repadmin /showrepl *
    ```

1. If the change involved the authorized principals of the gMSA, verify the value from the affected host.

    ```powershell
    Get-ADServiceAccount -Identity 'SQLgMSA' `
      -Properties PrincipalsAllowedToRetrieveManagedPassword

    Test-ADServiceAccount -Identity 'SQLgMSA'
    ```

_**Expected result:**_

- The effective Group Policy report contains the approved SAM remote-access entry, when applicable.
- Active Directory replication reports no error affecting the changed object or policy.
- The intended authorized principals are returned for the gMSA.
- `Test-ADServiceAccount` returns `True`.
- A new SQL Server Setup attempt no longer records the same access-denied operation.

If different domain controllers return different gMSA or permission information, don't repeatedly retry Setup. Resolve the replication error first. The `repadmin /replsummary` command identifies domain controllers that have inbound or outbound replication failures. For more information, see [Repadmin /replsummary](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835092(v=ws.11)).

If Setup fails after user rights were tightened in your environment, see [SQL Server installation fails after default user rights are removed](../install/windows/installation-fails-if-remove-user-right.md).

## Collect diagnostic data

If Setup still fails with error 0x84BB0001 after you complete these steps, collect diagnostic data, including `Detail.txt` and `gpresult` output, for the same failure interval. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [Troubleshoot SQL Server setup and upgrade failures with gMSAs](gmsa-setup-upgrade-failures.md)
- [Troubleshoot SQL Server failover cluster instance failures with gMSAs](gmsa-failover-cluster-instance-failures.md)
- [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
