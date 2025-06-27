---
title: Archive mailbox doesn't appear in Outlook or Outlook on the web
description: Provides resolutions for scenarios in which the archive mailbox in Exchange Online doesn't appear in Outlook for Windows or Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 191676
ms.reviewer: shtahir, mhaque, gbratton, sfellman, meerak, v-shorestris
appliesto: 
  - Exchange Online
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook on the web
  - New Outlook for Windows
search.appverid: MET150
ms.date: 02/27/2025
---

# Archive mailbox doesn't appear in Outlook or Outlook on the web

You enable a user's archive mailbox in Microsoft Exchange Online, but for some users or delegates the archive mailbox doesn't appear in one or more of the following Microsoft products:

- Classic Outlook for Windows
- New Outlook for Windows
- Outlook on the web

The following sections provide troubleshooting steps for each of these products. Select the applicable section depending on which product doesn't display the archive mailbox. If the troubleshooting steps don't help you to resolve the issue, contact [Microsoft Support](https://support.microsoft.com/contactus/).

## Archive mailbox doesn't appear in classic Outlook for Windows

To troubleshoot the issue, follow these steps:

1. Instruct the affected user to [upgrade their Outlook for Windows client](https://support.microsoft.com/office/install-office-updates-2ab296f3-7f03-43a2-8e50-46de917611c5) to the latest version.

2. Verify that the affected user has an [Exchange Online license that supports archive mailboxes](/office365/servicedescriptions/exchange-online-archiving-service-description/exchange-online-archiving-service-description#exchange-online-archiving-plans).

3. If the affected user is a mailbox delegate, verify that the delegate has [Full Access permission](/exchange/recipients-in-exchange-online/manage-permissions-for-recipients#use-exchange-online-powershell-to-assign-the-full-access-permission-to-mailboxes) on the mailbox. Full Access permission is required for a delegate to access an archive mailbox. For delegates who have Full Access permission, Outlook automatically automaps the primary and archive mailboxes to their Outlook profile.

   **Note**: [Don't assign Full Access permission on the mailbox through a security group](/outlook/troubleshoot/profiles-and-accounts/full-access-mailbox-not-automapped-outlook-profile) because Outlook won't automap the primary and archive mailboxes to the Outlook profile of each group member.

4. Instruct the affected user to run the [Classic Outlook Advanced Diagnostics troubleshooter](https://aka.ms/SaRA-OutlookAdvDiagExpExp-sarahome) to help diagnose the issue.

    > [!NOTE]
    >
    > - The troubleshooter doesn't work in new Outlook for Windows.
    > - To run the troubleshooter, make sure that the user is using the same Windows device that classic Outlook is installed on. Additionally, make sure that their device is running Windows 10 or a later version.

## Archive mailbox doesn't appear in new Outlook for Windows or Outlook on the web

Select the applicable scenario depending on your Exchange deployment.

### Scenario: Exchange Online mailboxes in a nonhybrid deployment

To fix the issue, follow these steps:

1. Run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the `ArchiveName` property value:

   ```PowerShell
   Get-Mailbox <user mailbox ID> | FL ArchiveName
   ```

   **Note**: If the `ArchiveName` property value is empty, the command output displays the value `{}`.

2. The `ArchiveName` property value should be `In-Place Archive -<display name of user mailbox>`. If it isn't set to that value, run the following PowerShell cmdlets in Exchange Online PowerShell to set it:

   ```PowerShell
   $dn=Get-Mailbox <user mailbox ID> | Select -ExpandProperty DisplayName
   Set-Mailbox <user mailbox ID> -ArchiveName "In-Place Archive -$dn"
   ```

3. Wait a few minutes for the archive mailbox to appear in new Outlook for Windows or Outlook on the web.

### Scenario: Exchange Online mailboxes in a hybrid deployment

To fix the issue, use one of the following methods. Method A is simpler than Method B but can only be used if your hybrid environment has an on-premises Exchange server. Method B can be used in any hybrid environment.

> [!NOTE]
> For information about how to configure archive mailboxes in a hybrid deployment, see [Archive provisioning in an Exchange hybrid environment](https://techcommunity.microsoft.com/t5/exchange-team-blog/what-happens-during-archive-provisioning-in-exchange-hybrid/ba-p/3300464).

#### Method A

1. Run the following PowerShell cmdlet in the on-premises Exchange Management Shell (EMS) to get the `ArchiveName` property value:

   ```PowerShell
   Get-RemoteMailbox <user mailbox ID> | FL ArchiveName
   ```

   **Note**: If the `ArchiveName` property value is empty, the command output displays the value `{}`.

2. The `ArchiveName` property value should be `In-Place Archive -<display name of user mailbox>`. If it isn't set to that value, run the following PowerShell cmdlets in the EMS to set it:

   ```PowerShell
   $dn=Get-RemoteMailbox <user mailbox ID> | Select -ExpandProperty DisplayName
   Set-RemoteMailbox <user mailbox ID> -ArchiveName "In-Place Archive -$dn"
   ```

3. If you updated the `ArchiveName` property value in step 2:

   1. [Sync](/entra/identity/hybrid/connect/how-to-connect-sync-feature-scheduler#delta-sync-cycle) Active Directory to Exchange Online.

   2. Wait a few minutes for the archive mailbox to appear in new Outlook for Windows or Outlook on the web.

#### Method B

> [!WARNING]
> If you incorrectly edit the attributes of Active Directory objects by using Active Directory Users and Computers, ADSI Edit snap-in, LDP utility, or any other LDAP client, you can cause serious problems. Microsoft can't guarantee that those problems can be resolved. Proceed with caution when modifying attributes and always document the original values before making changes so that they can be reversed if needed.

1. On a domain-joined server, open Active Directory Users and Computers.

2. Select **View**, and then make sure that **Advanced Features** is selected.

3. Expand the domain, select **Users**, and then locate and double-click the user mailbox to open the **Properties** window.

4. On the **Attribute Editor** tab, locate and double-click the `msExchArchiveName` attribute to open the **Multi-valued String Editor** window.

5. The `msExchArchiveName` attribute value should be `In-Place Archive -<display name of user mailbox>`. If it isn't set to that value, update it. For example, if the display name of the mailbox is `Kayla Lewis`, the `msExchArchiveName` attribute value should be `In-Place Archive -Kayla Lewis`.

6. If you updated the `msExchArchiveName` attribute value in step 5:

   1. [Sync](/entra/identity/hybrid/connect/how-to-connect-sync-feature-scheduler#delta-sync-cycle) Active Directory to Exchange Online.

   2. Wait a few minutes for the archive mailbox to appear in the new Outlook for Windows or Outlook on the web.

