---
title: Error when adding contacts to contacts folder
description: Provides a workaround for the issue that you receive an error when you try to add contacts to a contacts folder in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tafa
appliesto: 
  - Outlook
  - Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# You don't have permission to create an entry in this folder error when you add contacts to a contacts folder

_Original KB number:_ &nbsp; 4514534

## Symptoms

After a G Suite migration to Microsoft 365, users receive the following error message when they try to create or edit their contacts in the Outlook desktop client:

> You don't have permission to create an entry in this folder.  Right-click the folder, and then click Properties to check your permissions for the folder.  See the folder owner or your administrator to change your permissions.

:::image type="content" source="media/you-donnot-have-permission-to-create-an-entry-error/error-details.png" alt-text="Screenshot of the Outlook error message.":::

## Cause

This error occurs because the Contacts folder was flagged as ReadOnly by the service during the migration.

## Status - Service fix

A service side fix has been deployed. The fixed version is 15.20.2132.000​ or a later version.

> [!NOTE]
> The service side fix will be available only for new migrations. Migrations that are run before this update must follow the workaround steps in this article.

## Workaround

To work around this issue, manually set this property for affected users through **MFCMAPI**. To do this, follow these steps:

1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/tag/19.0.19115.01).
2. Start the MfcMapi.exe program that you downloaded, and then select **OK**.
3. On the **Tools** menu, select **Options**.

4. Select the check boxes next to the following options, and then select **OK**:
   - Use the MDB_ONLINE flag when calling Open MsgStore
   - Use the MAPI_NO_CACHE flag when calling OpenEntry

5. On the **Session** menu, select **Logon**.
6. In the Profile Name list, select the profile for the mailbox, and then select **OK**.
7. Double-click the appropriate **Microsoft Exchange Message Store**.
8. In the navigation pane, select **Root Container**.
9. In the navigation pane, expand **Root Container**, expand **Top of Information Store**, and then select **Contacts**.
10. In the properties pane on the right, look for the `PR_EXTENDED_FOLDER_FLAGS` property, double-click it, set the binary value to **010400001000**, and then select **OK**.
