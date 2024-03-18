---
title: Can't restore an Outlook form that's deleted from the organizational forms library
description: Resolves an issue in which you can't restore an Outlook form that's deleted from the organizational forms library.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 180570
ms.reviewer: bhartley, batre, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Can't restore an Outlook form that's deleted from the organizational forms library

## Symptoms

You can't restore a Microsoft Outlook form that's deleted from the [organizational forms library](/exchange/troubleshoot/administration/how-to-create-organizational-forms-library) in Microsoft Exchange Online.

## Cause

When you save an Outlook form to the organizational forms library, Exchange Online stores the form in the non-IPM subtree of the public folder hierarchy. When you delete an Outlook form from the organizational forms library, Exchange Online moves that form to the dumpster folder for the organizational forms library. That folder is another public folder in the non-IPM subtree, and isn't visible from any email client.

## Resolution

To restore a deleted Outlook form from the dumpster folder for the organizational forms library, follow these steps.

> [!NOTE]
> Run the procedure on a computer that has Outlook installed. Use an Outlook profile that can access public folders.

1. Run the following command to connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   Connect-ExchangeOnline
   ```

2. Run the following command to get the non-IPM subtree path of the dumpster folder that contains the deleted form:

   ```PowerShell
   Get-PublicFolder (Get-PublicFolder -Identity "\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational Forms Library").DumpsterEntryId | FL Identity
   ```

   The command output should resemble the following example folder path:

   ```Output
   Identity : \NON_IPM_SUBTREE\DUMPSTER_ROOT\DUMPSTER_EXTEND\RESERVED_1\RESERVED_1\956b7daa-0f13-4b0a-a944-7774818b6dec
   ```

3. Use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool to restore the deleted Outlook form to the organizational forms library. Follow these steps:

   1. Determine whether the Outlook installation is a [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version by checking **File** \> **Office account** \> **About Outlook**.

   2. Download and extract the latest 32-bit or 64-bit [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) release to match the Outlook installation.
  
      [!INCLUDE [Important MFCMAPI alert](../../../includes/mfcmapi-important-alert.md)]
  
   3. Make sure that Outlook is closed, and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it.

   4. Select **Tools** \> **Options** to open the **Options** window.

   5. Select both the following options, and then select **OK**:

      - Use the MDB_ONLINE flag when calling OpenMsgStore

      - Use the MAPI_NO_CACHE flag when calling OpenEntry

   6. Select **Session** \> **Logon** to open the **Choose Profile** window.

   7. Select an Outlook profile that can access public folders, and then select **OK**.

   8. In the left pane, double-click **Public Folders** to open the **Property Editor** window.

   9. In the left pane, expand **Root Container**, and then navigate to the dumpster folder at the path that you found in step 2.

   10. Right-click the dumpster folder, and then select **Open associated contents table**. The table lists deleted items.

   11. Identify the Outlook form that you want to restore. Outlook forms have a value of `IPM.Microsoft.FolderDesign.FormsDescription` in the `Message Class` column. Select a form to view its name at the top of the associated contents table.

   12. Right-click the form that you want to restore, and select **Copy Messages**.

   13. In another MFCMAPI window, navigate to the `\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational Forms Library` folder.

   14. In the left pane, right-click the folder, and then select **Paste**.

   15. In the **Copy Message** prompt that asks you to confirm the copy and paste operation, you can optionally choose to move the form instead of copying it. Select **OK**.

       > [!NOTE]
       > To see the restored form, right-click the `Organizational Forms Library` folder, and then select **Open associated contents table**.

   16. Close all MFCMAPI windows to exit the application.

   17. Start Outlook, and verify that the previously deleted Outlook form is restored to the organizational forms library.
