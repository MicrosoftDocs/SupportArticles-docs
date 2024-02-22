---
title: Cannot start Outlook in cached mode
description: Describes an issue in which you receive a Cannot start Microsoft Outlook error when trying to start Outlook in cached mode or create a new cached mode profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# You cannot start Outlook in cached mode or create a new cached mode profile

_Original KB number:_ &nbsp; 3046189

## Symptom

When you start Microsoft Outlook in cached mode, you receive the following error message:

> Cannot start Microsoft Outlook. Cannot open the Outlook window. The set of folders cannot be opened. There is not enough memory available to perform the operation.

> [!NOTE]
> This error message is also displayed when you try to create a new Outlook profile that is configured to use cached mode.

## Cause

This problem occurs because the hidden `PR_OST_OSTID` property in your mailbox is larger than 32 kilobytes (KB).

This property is located on Top of Information Store in the default store. Every time that you create a new cached mode profile for the mailbox, approximately 20 bytes of data is added to this property. Eventually, the size of the data in the property exceeds approximately 32,720 bytes, and you start to receive the error.

## Resolution

To resolve this problem, remove the data in the PR_OST_OSTID binary property. To do this, follow these steps:

1. Download and extract the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/) tool.
2. Launch Mfcmapi.exe, and then select **OK**  to move through the introduction screen.
3. On the **Tools** menu, select **Options**.
4. Enable the following options, and then select **OK**:
   - **Use the MDB_ONLINE flag when calling OpenMsgStore**  
   - **Use the MAPI_NO_CACHE flag when calling OpenEntry**

5. On the **Session** menu, select **Logon**.
6. Select the Outlook cached mode profile for the mailbox, and then select **OK**.
7. Double-click the email address that represents the mailbox in question.
8. In the navigation pane, expand **Root Container**, and then select **Top of Information Store**.
9. In the right-side pane, locate the `PR_OST_OSTID` property.

    > [!NOTE]
    > You may see `PR_OST_OSTID` under the Property names column or the **Other names** column. If it is found under the Property names column, the value under the Tag column is 0x7C040102. If `PR_OST_OSTID` is found under the **Other names** column, the value under the **Tag** column is 0x7C04000A.
    >
    > 1. If the value under the **Tag** column is 0x7C040102, then double-click `PR_OST_OSTID` to open the Property Editor.
    > 2. If the value under the **Tag** column is 0x7C04000A, then right-click `PR_OST_OSTID`, select **Edit as stream**, and then select **Binary**.

10. Right-click the data in the **Binary** section of Property Editor, and then select **Select All**.

    :::image type="content" source="media/cannot-start-outlook-in-cached-mode-or-create-profile/binary-section-of-property-editor.png" alt-text="Screenshot of the PR_OST_OSTID binary property." border="false":::

11. Right-click the selected data in the **Binary** section, and then select **Delete**.
12. Select **OK**.
13. Exit the MFCMAPI tool, and then start Outlook.

## More information

There are several scenarios in which this situation might occur:

1. Many users sign in to the mailbox repeatedly. (For example, many users sign in to a mailbox that is used to answer public or service communications.)
2. Many users open a shared resource mailbox when **Download shared folders** is enabled in the Outlook profile.
3. Someone is creating new cached mode profiles for their mailbox repeatedly. (This occurs only rarely.)
