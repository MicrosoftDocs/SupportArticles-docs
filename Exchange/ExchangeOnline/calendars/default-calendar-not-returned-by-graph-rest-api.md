---
title: Default Outlook calendar isn't returned by the Graph REST API
description: Resolves an issue in which the default Outlook calendar isn't returned by the Graph REST API when you request all calendars from a user mailbox in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 190677
ms.reviewer: moabozei, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 06/10/2024
---

# Default Outlook calendar isn't returned by the Graph REST API

## Symptoms

You use the [Microsoft Graph REST API](/en-US/graph/api/overview) to request all calendars from a user mailbox in Exchange Online. The response returns HTTP status code `200 OK`, but the [calendar list](/graph/api/user-list-calendars?tabs=http#example) in the response body omits the default calendar (named "Calendar"). If the mailbox has nondefault calendars, only those are listed.

## Cause

The issue occurs because the calendar object cache in the mailbox is corrupted.

## Resolution

> [!NOTE]
> To use the following procedure, you must be the cloud user or have full access permissions to the cloud mailbox. Run the procedure on a Microsoft Windows-based computer that has the Outlook desktop client installed and an Outlook profile for the mailbox.

To fix the issue, remove and re-create the calendar object cache in the mailbox. Follow these steps:

1. In Microsoft Outlook, select **File** > **Office account** > **About Outlook** to determine whether the desktop client is the [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version.

2. Download and extract the latest 32-bit or 64-bit version of [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) to match the bitness of the Outlook installation.

   > [!IMPORTANT]
   > Although the MFCMAPI editor is supported, be careful when you use it to edit mailbox settings. Using the MFCMAPI editor incorrectly can permanently damage a mailbox.

3. Close Outlook (and Outlook on the web, if it's open), and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it.

4. Select **Tools** > **Options** to open the **Options** window.

5. Select both the following options, and then select **OK**:

   - "Use the MDB_ONLINE flag when calling OpenMsgStore"

   - "Use the MAPI_NO_CACHE flag when calling OpenEntry"

6. Select **Session** > **Logon** to open the **Choose Profile** window.

7. Select the Outlook profile name for the mailbox, and then select **OK**.

8. Double-click the applicable mailbox in the **Display Name** column to open it.

9. In the left pane, navigate to **Root Container** > **Common Views**.

10. Right-click **Common Views**, and then select **Open associated contents table**.

11. For each table entry that has the value `Calendar` in the **Subject** column, back up the calendar object cache:

    1. Right-click the entry, and then select **Export message** to open the **Save Message To File** dialog.

    2. Select **OK** to open the **Save As** dialog.

    3. Choose a backup folder, and then select **Save**.

12. For each table entry that has the value `Calendar` in the **Subject** column, remove the calendar object cache:

    1. Right-click the entry, and then select **Delete message** to open the **Delete Item** dialog.

    2. Select **OK**.

    After you complete this step, verify that there are no table entries that have the value `Calendar` in the **Subject** column.

13. Open Outlook on the web, sign in to the applicable mailbox, and then view the default calendar. This step re-creates the calendar object cache in the mailbox.

14. In MFCMAPI, verify that one or more table entries have the value `Calendar` in the **Subject** column.

15. Close all MFCMAPI windows to exit the application.

16. Wait five minutes for the calendar object cache to fully refresh in the mailbox, and then retry your calendar request.
