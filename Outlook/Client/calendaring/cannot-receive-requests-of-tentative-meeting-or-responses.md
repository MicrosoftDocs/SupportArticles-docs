---
title: Cannot receive tentative meetings requests or responses
description: Describes an issue in which a user doesn't receive meeting invitations in their inbox but the meetings appear in the user's calendar as Tentative.  Or, meeting responses from other users don't appear in the user's inbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: shahmul, chrispol
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Meetings are Tentative but not receiving requests or meeting responses from others don't show in inbox

_Original KB number:_ &nbsp; 2966790

## Symptoms

A user experiences one or both the following symptoms in Outlook:

- The user doesn't receive meeting requests in their inbox. However, the meetings appear in the user's calendar as Tentative.
- When the user creates a meeting request, the user doesn't see meeting responses from attendees. However, tracking information for the meeting is updated in the user's calendar.

In this scenario, the user does not have a delegate set up.

## Cause

This issue occurs if the meeting requests were processed incorrectly in the user's mailbox and they get delivered to the user's Deleted Items folder instead of the Inbox folder or the meeting requests were processed incorrectly as if a delegate was set up.

This can occur if the Receive folder for the `IPM.SCHEDULE.MEETING` message class was changed to the /Schedule folder or if the `PR_RULE_MSG_PROVIDER` property of messages that have as message class of `IPM.Rule.Version2.Message` is set to **Schedule+ EMS Interface**.

## Resolution

To resolve this issue, start by following the steps in resolution 1. Depending on the scenario, you may have to use the steps in resolution 2. You will not know which solution applies to the user until you start troubleshooting by using the steps in resolution 1.

> [!NOTE]
> The exact steps will vary based on the version of the MFCMAPI tool that you're using. Use caution when you modify mailboxes by using MFCMAPI. Using this tool incorrectly can cause permanent damage to a mailbox.

### Resolution 1

1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Start MFCMAPI.
3. On the **Session** menu, select **Logon**.
4. Select the user's online mode Outlook profile, and then select **OK**.

    > [!NOTE]
    > If the user doesn't have an online mode profile, create a profile. Or, on the **Tools** menu, select **Options**, and then make sure that both the **Use the MBD_ONLINE flag when calling OpenMsgStore** check box and the **Use the MAPI_NO_CACHE flag when calling OpenEntry** check box are selected.

5. In the list, double-click the user's primary mailbox.
6. In the new window that appears, on the **MDB** menu, point to **Display**, and then select **Receive folder table**.
7. In the window, look for IPM.SCHEDULE.MEETING. Then, do one of the following:
   - If IPM.SCHEDULE.MEETING is not present, go to resolution 2.
   - If IPM.SCHEDULE.MEETING is present, go to step 8 of this procedure.
8. Expand the **Root** container.
9. Right-click **Schedule**, select **Advanced**, and then select **Set Receive Folder**.
10. Enter *IPM.SCHEDULE.MEETING* in the box.
11. Select **Delete Association**, and then select **OK**.
12. Repeat step 6 and 7 to make sure that the IPM.SCHEDULE.MEETING association is removed from the list.
13. Test to see whether the user can receive meeting responses and meeting requests in their inbox.

### Resolution 2

1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Start MFCMAPI.
3. On the **Session** menu, select **Logon**.
4. Select the user's online mode Outlook profile, and then select **OK**.

    > [!NOTE]
    > If the user doesn't have an online mode profile, create a profile. Or, on the **Tools** menu, select **Options**, and then make sure that both the **Use the MBD_ONLINE flag when calling OpenMsgStore** check box and the **Use the MAPI_NO_CACHE flag when calling OpenEntry** check box are selected.

5. In the list, double-click the user's primary mailbox.
6. Expand the **Root** container, and then expand **Top of Information Store**.
7. Right-click **Inbox**, and then select **Open Associated Contents Table**.
8. In the upper part of the window, scroll to locate the **Message Class** column.
9. Select **Message Class** to sort the Message Class column.
10. Look for all messages that have a message class of `IPM.Rule.Version2.Message`.
11. Select each message that has a message class of `IPM.Rule.Version2.Message`, and then in the lower part of the window, look for a property that's called `PR_RULE_MSG_PROVIDER`.
12. Check whether the `PR_RULE_MSG_PROVIDER` property has a value of **Schedule+ EMS Interface**.
13. In the upper part of the window, delete messages whose `PR_RULE_MSG_PROVIDER` property has a value of **Schedule+ EMS Interface**.
14. Test to see whether the user can receive meeting responses and meeting requests in their inbox.

## More information

For more information about Receive folders, see [MAPI Receive Folders](/office/client-developer/outlook/mapi/mapi-receive-folders).
