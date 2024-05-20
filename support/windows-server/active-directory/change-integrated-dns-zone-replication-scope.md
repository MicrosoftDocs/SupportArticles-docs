---
title: Can't change replication scope of AD-integrated zone
description: Describes an issue where you receive an error message when you try to change the replication scope of an Active Directory-integrated DNS zone. Resolution involves the assignment of permissions to the built-in administrator account.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, roblane
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# You cannot change the replication scope of an Active Directory integrated DNS zone in Windows Server 2003

This article provides a solution to an error that occurs when you change the replication scope of an Active Directory integrated domain name system (DNS) zone.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 842560

## Symptoms

When you try to change the replication scope of an Active Directory integrated DNS zone, you may receive an error that is similar to the following error message:

> The replication scope could not be set.  
There was a server failure.

## Cause

This issue may occur if the system account does not have the SeSecurityPrivelige permission that is provided by the built-in administrator account.

## Resolution

To resolve this issue, you must add the built-in administrators group account to the manage auditing and security log user permission. The manage auditing and security log user permission is located in the default domain controller policy. After you add the built-in administrators group account, change the replication scope of the required DNS zone.

To add the built-in administrators group account to the manage auditing and security log user permission, follow these steps:

1. Start the Group Policy Managment Console snap-in.

1. Navigate to the **Domain Controllers** OU.

1. Right-Click on the **Default Domain Controllers Policy**, and then click **Edit**.
1. In the left pane, expand **Computer Configuration**, expand **Windows Settings**, and then expand **Security Settings**.
5. Expand **Local Policies**, and then click **User Rights Assignment**.
6. In the right pane, double-click **Manage auditing and security log**, and then click **Add User or Group**.
7. Click **Browse**, and then click **Advanced**.
8. Click **Find Now**, and then click **Administrators** in the **Search Results** box.
1. Click **OK**, click **OK**, click **OK**, and then click **OK** to quit Group Policy Object Editor.
1. Wait for 5 Minutes (The default interval time of Domain Controller Group Policy processing ) or invoke Group Policy Processing by running **GPUPDATE /Force** from elevated Command Prompt.

1. Quit the Group Policy Managment Console snap-in.

13. Change the replication scope of the Active Directory integrated DNS zone.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
