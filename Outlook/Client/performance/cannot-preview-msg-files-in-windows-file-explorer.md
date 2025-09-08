---
title: Cannot preview .msg files in Windows File Explorer
description: Fixes an issue that prevents you from previewing .msg files in Windows File Explorer. Occurs if you have the 64-bit version of Outlook installed. Workarounds are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Install, Update, Activate, and Deploy\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't preview .msg files in Windows File Explorer with 64-bit Outlook

_Original KB number:_ &nbsp; 3189902

## Symptoms

You have an `.msg` file saved in a folder on your computer. In Windows File Explorer, you select the `.msg` file to view it in the Preview Pane. In this situation, you receive the following error message:

> Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.

:::image type="content" source="media/cannot-preview-msg-files-in-windows-file-explorer/mail-client-error.png" alt-text="Screenshot of the mail client error details." border="false":::

After you select **OK**, the following error message is displayed in the Preview Pane:

> This file can't be previewed because of an error in the Windows e-mail previewer.

:::image type="content" source="media/cannot-preview-msg-files-in-windows-file-explorer/file-preview-error.png" alt-text="Screenshot of file preview error details." border="false":::

## Cause

This issue occurs when you have the 64-bit version of Microsoft Outlook installed. The Windows preview host requires a 32-bit application previewer. When 32-bit Outlook is installed, it acts as the previewer. Without 32-bit Outlook installed, there is no previewer available for `.msg` files.

## Workaround Method 1 - Disable the Windows Explorer Preview Pane, and open the .msg file to view it in Outlook

1. Open Windows File Explorer.
2. On the **View** tab, select the **Preview** pane to disable it.
3. To view the `.msg` file, double-click it to open it in Outlook.

## Workaround Method 2 - Use 32-bit Outlook

If you prefer to preview `.msg` files in Windows File Explorer, install the 32-bit version of Outlook instead of the 64-bit version.
