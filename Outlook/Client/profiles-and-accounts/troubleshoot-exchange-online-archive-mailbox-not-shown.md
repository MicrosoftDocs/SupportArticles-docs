---
title: Exchange Online Archive mailbox not shown
description: This article provides six steps trying to help you fix that the archive mailbox isn't appeared in the Outlook client in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, vijayde
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 03/14/2024
---
# How to troubleshoot an Exchange Online Archive mailbox that is not displayed in Outlook

_Original KB number:_ &nbsp; 4492055

## Symptoms

The Exchange Online Archive mailbox isn't displayed in the Microsoft Outlook client.

## Resolution Method 1 - Verify that your installation of Outlook is up to date

To verify that your installation is up to date:

1. Determine the version of Outlook that is installed. For more information about how to determine the installed Outlook version, see [What version of Outlook do I have](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c).

2. Determine whether there is a more recent version of Outlook available.

   1. If you used Click-to-Run (C2R) to install Office, see [Update history for Microsoft 365 Apps (listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).

   2. If you installed Office by using the Windows Installer (MSI), see [Outlook and Outlook for Mac: Update File Versions](https://social.technet.microsoft.com/wiki/contents/articles/31133.outlook-and-outlook-for-mac-update-file-versions.aspx).

## Resolution Method 2 - Verify that the correct license type is assigned to Office

A Microsoft 365 Apps for enterprise license is required for archive mailboxes. To verify the license type that is assigned to the affected user, open the Microsoft 365 admin center, and examine the user's license type. For more information about how to use the Microsoft 365 Admin center, see [Resolve license conflicts](/microsoft-365/admin/manage/resolve-license-conflicts?view=o365-worldwide&preserve-view=true).

For more information about license requirements, see [Outlook license requirements for Exchange features](https://support.microsoft.com/office/outlook-license-requirements-for-exchange-features-46b6b7c5-c3ca-43e5-8424-1e2807917c99).

## Resolution Method 3 - Verify that Full Access permission is correctly granted

If a user needs full mailbox access to another user's primary and archive mailboxes, you must grant them the Full Access permission. When they have the Full Access permission, automapping automatically displays the primary and online archive in Outlook Web App and Outlook. For more information about how to grant the Full Access permission, see [Use the EAC to assign permissions to individual mailboxes](/exchange/recipients-in-exchange-online/manage-permissions-for-recipients#use-the-eac-to-assign-permissions-to-individual-mailboxes).

> [!NOTE]
> Make sure that Full Access and Outlook Delegate permissions aren't granted at the same time. For more information, see [Conflicting permission sets when working with shared or delegated folders](https://techcommunity.microsoft.com/t5/outlook-global-customer-service/conflicting-permission-sets-when-working-with-shared-or/ba-p/388842).

## Resolution Method 4 - Verify that the Full Mailbox Access permission isn't assigned through a security group

If you assign full mailbox access to a specific set of mailboxes through a security group, the members of the assigned group won't see the mailbox automapped to their Microsoft Outlook profile. For more information about the issue and resolution, see [Mailboxes to which your account has full access aren't automapped to Outlook profile](/outlook/troubleshoot/profiles-and-accounts/full-access-mailbox-not-automapped-outlook-profile).

## Resolution Method 5 - Verify that the Automatically detect settings option isn't checked on your browser

To verify the setting of the option:

- In Internet Explorer:
  1. On the **Tools** menu, select **Internet Options**.
  2. Select the **Connections** tab, and then select the **Settings** button. If the **Automatically detect settings** check box is selected, clear it, and then restart Outlook.
- In Edge:
  1. Select **Settings**, and then select **Advanced** in the left pane.
  2. Select the **Open proxy settings** button.
  3. If **Automatically detect settings** is set to **On**, set it to **Off**, and then restart Outlook.

To check the if **Automatically detect settings** is checked, refer the following steps:

1. In Internet Explorer, go to **Internet Options**. If yes, clear it then restart Outlook.
2. In Edge, go to **Settings** then **Advanced** icon on left pane. Select **Open proxy settings**, check whether **Automatically detect settings** is on. If it's checked, clear it then restart Outlook.

## Resolution Method 6 - Scan Outlook by using the Microsoft Support and Recovery Assistant tool

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../../includes/sara-note-new-outlook.md)]

If the issue occurs for a user who is trying to access the Online Archive mailbox of another user, you can use the Support and Recovery Assistant (SaRA) tool to scan Outlook and review advanced diagnostics for known problems and details about the Microsoft Outlook configuration. For more information about how to use SaRA, see [How to scan Outlook by using the Microsoft Support and Recovery Assistant](https://support.microsoft.com/help/4098558/how-to-scan-outlook-by-using-the-sara-tool).
