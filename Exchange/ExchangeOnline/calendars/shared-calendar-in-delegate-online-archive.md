---
title: Shared Calendar Appears in a Delegate's Online Archive Folder
description: Provides a workaround for an issue in which Outlook displays a shared calendar in a delegate's Online Archive folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 173134
  - CI 5553
ms.reviewer: benwinz, tylewis, gbratton, meerak, v-trisshores
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Microsoft 365
  - Outlook for Windows
  - Outlook for Mac
  - Outlook for Mac for Microsoft 365
search.appverid: MET150
ms.date: 04/25/2025
---

# Shared calendar appears in delegate's Online Archive folder

## Symptoms

Consider the following scenario:

- User A and User B both have mailboxes in Microsoft Exchange Online.

- You grant User A delegate access to User B's mailbox.

- User A's mailbox has a Microsoft [messaging records management](/exchange/security-and-compliance/messaging-records-management/messaging-records-management) (MRM) retention policy that applies a [default policy tag](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies) (DPT) to archive the entire mailbox.

- User A's Microsoft Outlook client has [shared calendar improvements](https://support.microsoft.com/office/shared-calendars-updates-in-outlook-for-windows-7b856d16-840f-41cc-997d-a95dab7a6414) enabled.

  **Note:** Shared calendar improvements are enabled by default in all recent versions of Outlook and all channels for Outlook for Microsoft 365.

In this scenario, User A's Outlook client might display:

- User B's archived shared calendar in User A's [Online Archive](https://support.microsoft.com/office/manage-email-storage-with-online-archive-mailboxes-1cae7d17-7813-4fe8-8ca2-9a5494e9a721) folder.

- The following folder under **My Calendars** or **Shared Calendars**:

  `<User B's calendar name> - Online Archive - <User A's email address>`

  **Note**: Only Outlook desktop clients and Outlook on the web display the Online Archive folder. MRM archives any shared calendar items based on the DPT retention period.

## Cause

After the retention period, MRM archives any shared calendar folders that are in a delegate's mailbox (including those that are listed under **My Calendars** and **Shared Calendars**) if both of the following conditions are met:

- Outlook has shared calendar improvements enabled.

- The MRM retention policy applies a DPT to archive the entire mailbox.

**Note:** If you revoke delegate access to the shared calendars, MRM doesn't remove the archived shared calendars from the delegate's Online Archive mailbox.

## Workaround

To work around this issue, choose from the following options:

- To prevent shared calendar items from being archived, you can use either of the following methods:

  - Unassign the default MRM retention policy that archives the delegate's entire mailbox. However, this approach might not be compatible with your organization's mailbox retention requirements.

  - Disable shared calendar improvements in Outlook. However, this approach disables important calendar features such as [instant sync](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4), and reduces Outlook's overall performance. Also, new features won't be added to the legacy shared calendar model.

  **Note**: If shared calendar items are already archived, removing the MRM policy or disabling shared calendar improvements won't remove the archived shared calendar items or the archived shared calendar folders.

- To hide shared calendars that appear in a delegate's Online Archive folder in Outlook, follow these steps:

  > [!NOTE]
  > To use the following procedure, you must be the owner of the delegate's mailbox or have full access permissions to it. Run the procedure on a Microsoft Windows computer that has the Outlook desktop client installed and an Outlook profile for the delegate's mailbox.
  
  1. Determine whether your Outlook installation is a [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version by checking **File** \> **Office** **account** \> **About** **Outlook**.
  
  2. Download and extract the latest 32-bit or 64-bit [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) release to match your Outlook installation.
  
     [!INCLUDE [Important MFCMAPI alert](../../../includes/mfcmapi-important-alert.md)]
  
  3. Make sure that Outlook is closed, and then run *MFCMapi.exe*. If the MFCMAPI startup screen appears, close it.

  4. Open the **Choose Profile** window by selecting **Session** \> **Logon**.
  
  5. Select the Outlook profile for the delegate's mailbox, and then select **OK**.
  
  6. Open the online archive store by double-clicking **Online Archive**.
  
  7. In the left pane, expand **Root Container** \> **Top of Information Store** \> **Calendar**, and then select the shared calendar folder.
  
  8. In the right pane, open the **Property Editor** window by double-clicking the **PR_ATTR_HIDDEN** property.
  
  9. Select the **Boolean** checkbox, and then select **OK**.
 
      **Note:** If you need to hide additional calendars, repeat steps 9 to 11 for each calendar.
       
  10. Exit the application by closing all MFCMAPI windows.
  
  11. Start Outlook and verify that the delegate's Online Archive folder no longer displays the shared calendar.
