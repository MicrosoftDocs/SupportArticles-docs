---
title: Meeting requests or responses don't appear in the Inbox
description: Provides a resolution for an issue in which a user doesn't receive meeting requests or responses in the Outlook Inbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Other
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 193685
ms.reviewer: mburuiana, meerak, v-shorestris
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016.
search.appverid: MET150
ms.date: 09/13/2024
---

# Meeting requests or responses don't appear in the Inbox

_Original KB number:_ &nbsp; 2966790

## Symptoms

A user who doesn't have a mailbox delegate encounters one or both of the following issues in Microsoft Outlook:

- When a meeting request is sent to the user, the meeting correctly appears as Tentative in the user's calendar, but Outlook doesn't route the request to the Inbox. For example, the request appears in the Deleted Items folder.

- When an attendee responds to a meeting request that the user creates, the meeting tracking information in the user's calendar correctly reflects the response, but Outlook doesn't route the response to the Inbox. For example, the response appears in the Deleted Items folder.

## Cause

The issues can occur for the following reasons.

### Cause 1

The [MAPI Receive folder](/office/client-developer/outlook/mapi/mapi-receive-folders) that holds inbound messages for the **IPM.SCHEDULE.MEETING** message class isn't set to the Inbox folder. Instead, meeting items appear in the Deleted Items folder.

You can use [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to test for this cause. Use either of the following methods.

> [!NOTE]
> Both methods provide useful information. For example, method A shows how many meeting items were misdirected to the Deleted Items folder, and method B confirms which folder a specific item was delivered to.

#### Method A

Run the following [Get-MailboxFolderStatistics](/powershell/module/exchange/get-mailboxfolderstatistics) PowerShell cmdlet:

```PowerShell
Get-MailboxFolderStatistics -Identity <user ID> -FolderScope NonIpmRoot -IncludeOldestAndNewestItems | ? Name -eq "Schedule" | FL Name,FolderType,NewestItemReceivedDate,ItemsInFolder
```

The following screenshot shows an example of the cmdlet output.

:::image type="content" source="media/cannot-receive-requests-of-tentative-meeting-or-responses/get-mailboxfolderstatistics.png" border="false" alt-text="Screenshot of the command output from the Get-MailboxFolderStatistics cmdlet." lightbox="media/cannot-receive-requests-of-tentative-meeting-or-responses/get-mailboxfolderstatistics.png":::

For this cause, the **ItemsInFolder** count value is nonzero and the **NewestItemReceivedDate** timestamp value matches the date and time of the most recent misdelivered meeting item.

#### Method B

Run the following [Get-MessageTrace](/powershell/module/exchange/get-messagetrace) and [Get-MessageTraceDetail](/powershell/module/exchange/get-messagetracedetail) PowerShell cmdlets: 

```PowerShell
Get-MessageTrace -StartDate <search start date> -EndDate <search end date> | ? Subject -match <item subject> | Get-MessageTraceDetail
```

The following screenshot shows an example of the command output.

:::image type="content" source="media/cannot-receive-requests-of-tentative-meeting-or-responses/get-messagetrace.png" border="false" alt-text="Screenshot of the command output from the Get-MessageTraceDetail cmdlet." lightbox="media/cannot-receive-requests-of-tentative-meeting-or-responses/get-messagetrace.png":::

For this cause, the value of the **Detail** parameter for the deliver event is: `The message was successfully delivered to the folder: DefaultFolderType:LegacySchedule`.

### Cause 2

For messages that have an **IPM.Rule.Version2.Message** message class, the value of the **PR_RULE_MSG_PROVIDER** property is incorrectly set to `Schedule+ EMS Interface`.

## Resolution

If you tested for Cause 1 in Exchange Online PowerShell and found that Cause 1 isn't applicable, start at [Resolution for Cause 2](#resolution-for-cause-2). Otherwise, start at [Resolution for Cause 1](#resolution-for-cause-1).

### Resolution for Cause 1

> [!NOTE]
> To use the following procedure, you must be the user or have full access permissions to the user's mailbox. Run the procedure on a Microsoft Windows-based computer that has the Outlook desktop client installed and an Outlook profile for the mailbox. 

1. In Outlook, select **File** > **Office account** > **About Outlook** to determine whether the desktop client is the [32-bit or 64-bit version](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c).

2. Download and extract the latest version of [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases), either 32-bit or 64-bit to match the Outlook installation.

   > [!IMPORTANT]
   > Although the MFCMAPI editor is supported, be careful when you use it to edit mailbox settings. Using the MFCMAPI editor incorrectly can permanently damage a mailbox.

3. Close Outlook and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it. 

4. Select **Tools** > **Options** to open the **Options** window.

5. Select both of the following options to set MFCMAPI to online mode, and then select **OK**:

   - **Use the MDB_ONLINE flag when calling OpenMsgStore**
   - **Use the MAPI_NO_CACHE flag when calling OpenEntry**

   > [!IMPORTANT]
   > Make sure that you complete step 5.

6. Select **Session** > **Logon** to open the **Choose Profile** window.

7. Select the Outlook profile for the affected user, and then select **OK**.

8. Double-click the applicable mailbox in the **Display Name** column to open it.

9. In the new window that appears, select **MDB** > **Display** > **Receive folder table**.

10. In the **Receive Folder Table** window, verify that the **Message Class** column has an **IPM.SCHEDULE.MEETING** entry. The following example screenshot shows that entry.

    :::image type="content" source="media/cannot-receive-requests-of-tentative-meeting-or-responses/receive-folder-table.png" border="true" alt-text="Screenshot of the IPM.SCHEDULE.MEETING entry in the Receive Folder Table window.":::

    If the **Receive Folder Table** window doesn't contain an **IPM.SCHEDULE.MEETING** entry, double-check that you completed step 5 (sets MFCMAPI to online mode). If you did complete step 5, skip the remaining steps and instead try [Resolution for Cause 2](#resolution-for-cause-2) if you haven't already done so.

11. Expand the **Root** container.

12. Right-click **Schedule**, and then select **Advanced** > **Set receive folder** to open the **SetReceiveFolder** window.

13. Enter _IPM.SCHEDULE.MEETING_ in the **Class** field, select **Delete association**, and then select **OK**.

14. Refresh the **Receive Folder Table** window, and then verify that the **IPM.SCHEDULE.MEETING** entry no longer exists.

15. Check whether the issue is resolved for the user. If the issue persists, try [Resolution for Cause 2](#resolution-for-cause-2) if you haven't already done so.

### Resolution for Cause 2

1. Complete steps 1-8 in [Resolution for Cause 1](#resolution-for-cause-1) to initialize MFCMAPI.

2. Expand the **Root** container, and then expand **Top of Information Store**.

3. Right-click **Inbox**, and then select **Open associated contents table**.

4. In the upper pane, select the **Message Class** column header to sort the column.

5. For each message in the **Message Class** column that has a value of `IPM.Rule.Version2.Message`:

   1. Select the message.

   2. In the lower pane, check the value of the **PR_RULE_MSG_PROVIDER** property.

   3. If the **PR_RULE_MSG_PROVIDER** property value is `Schedule+ EMS Interface`, delete the message in the upper pane.

   The following example screenshot shows how to delete a message that has a message class of `IPM.Rule.Version2.Message` and a **PR_RULE_MSG_PROVIDER** property value of `Schedule+ EMS Interface`.

   :::image type="content" source="media/cannot-receive-requests-of-tentative-meeting-or-responses/mfcmapi-messageclass.png" border="true" alt-text="Screenshot of the Inbox associated contents table that shows a message of message class 'IPM.Rule.Version2.Message' and a PR_RULE_MSG_PROVIDER property value of 'Schedule+ EMS Interface'.":::

6. Check whether the issue is resolved for the user. If the issue persists, try [Resolution for Cause 1](#resolution-for-cause-1) if you haven't already done so.
