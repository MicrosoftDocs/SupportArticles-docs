---
title: Default folder is missing
description: Documenting issue where folders appear to be missing.  Resolution is provided.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Outlook for Office 365
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# Default folder is missing in Outlook and Outlook on the web

_Original KB number:_ &nbsp; 2992093

## Symptoms

In Microsoft Outlook and in Outlook on the web, you may find that a folder appears to be missing from your mailbox.

## Cause

This behavior can occur if the `PR_ATTR_HIDDEN` property of the affected folder is set to **True**. The default value for the `PR_ATTR _HIDDEN` property for mailbox folders is **False**.

## Resolution

Use the steps below to confirm that you are facing this issue, and to reset the `PR_ATTR_HIDDEN` property of the affected folder.

1. Download and extract the [MFCMAPI](https://archive.codeplex.com/?p=mfcmapi) tool.
2. Launch mfcmapi.exe and select **OK** through the intro screen.
3. On the **Session** menu, select **Logon**.
4. Select the Outlook profile for the affected mailbox, and select **OK**.
5. Double-click the email address that represents the desired mailbox.
6. In the left pane, navigate to the affected folder using the appropriate steps below for the type of Outlook profile you are using.

    Cached Mode

    1. Expand Root - Mailbox
    2. Expand IPM_SUBTREE

    Online Mode

    1. Expand Root Container
    2. Expand Top of information Store

7. Locate and select the folder that appears missing in Outlook, and check the value of the `PR_ATTR_HIDDEN` to determine if it is set to **True**, as shown in the following figure:

   :::image type="content" source="media/default-folder-is-missing/check-the-value-of-pr_attr_hidden.jpg" alt-text="check the value of the PR_ATTR_HIDDEN" border="false":::

8. If `PR_ATTR_HIDDEN` shows a value of **True**, right-click the `PR_ATTR_HIDDEN` property and select **Edit Property**.
9. Uncheck the Boolean checkbox and select **OK**.
10. Close all MFCMAPI windows, and restart Outlook.

## More information

While you are looking at the folder properties, you should also check `PR_ATTR_SYSTEM`. Its default value is also **False**, so if you find it currently set to **True**, after completing steps 1 through 9 above, you should change this value as well, using the additional steps below.

1. If `PR_ATTR_SYSTEM` shows a value of **True**, right-click the `PR_ATTR_SYSTEM` property and select **Edit Property**.
2. Uncheck the **Boolean** checkbox and select **OK**.
3. Close all MFCMAPI windows, and restart Outlook.
