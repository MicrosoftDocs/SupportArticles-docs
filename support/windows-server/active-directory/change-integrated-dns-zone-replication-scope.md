---
title: Can't change replication scope of AD-integrated zone
description: Describes an issue where you receive an error message when you try to change the replication scope of an Active Directory-integrated DNS zone. Resolution involves the assignment of permissions to the built-in administrator account.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, roblane, sagiv
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# You cannot change the replication scope of an Active Directory integrated DNS zone in Windows Server

This article provides a solution to an error that occurs when you change the replication scope of an Active Directory integrated domain name system (DNS) zone.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 842560

## Symptoms

When you try to change the replication scope of an Active Directory integrated DNS zone, you may receive an error that is similar to the following error message:

> The replication scope could not be set.  
There was a server failure.

## Cause

This issue may occur if the system account does not have the SeSecurityPrivilege permission that is provided by the built-in administrator account.

## Resolution

To resolve this issue, you must add the built-in administrators group account to the manage auditing and security log user permission. The manage auditing and security log user permission is located in the default domain controller policy. After you add the built-in administrators group account, change the replication scope of the required DNS zone.

To add the built-in administrators group account to the manage auditing and security log user permission, follow these steps:

1. Open the Group Policy Management Console snap-in.
2. Navigate to the **Domain Controllers** organizational unit (OU).
3. Right-click **Default Domain Controllers Policy**, and then select **Edit**.
4. In the left pane, expand **Computer Configuration** > **Windows Settings** > **Security Settings**.
5. Expand **Local Policies**, and then select **User Rights Assignment**.
6. In the right pane, double-click **Manage auditing and security log**, and then select **Add User or Group** > **Advanced**.
7. Select **Find Now**, and then select **Administrator** in the **Search results** box.
8. Select **OK** four times to close the Group Policy Object Editor.
9. Wait five minutes (the default interval time of Domain Controller Group Policy processing) or invoke Group Policy Processing by running the `GPUPDATE /Force` command from an elevated command prompt.
10. Close the Group Policy Management Console snap-in.
11. Change the replication scope of the Active Directory integrated DNS zone.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
