---
title: Page setup dialog might unexpectedly close after PSA is installed
description: Provides a workaround for an issue where the page setup dialog closes unexpectedly after installing the print support app.
ms.date: 06/11/2025
ms.custom: sap:Graphics and Multimedia development\Printing and the Print Spooler API
ms.reviewer: riwaida, jinsshi, jiannche, sarpuri, mamanian, niclar, v-sidong
ms.topic: troubleshooting
---
# Page setup dialog might unexpectedly close after the print support app is installed

## Symptoms

Consider the following scenario:

- You're using Windows 10, version 22H2.
- You're developing a print support app (PSA) for IPP-based printers.
- You're using the Notepad or Paint application.

In this scenario, after you install the PSA on the system, toggling the page orientation setting might cause the host application to crash. For example, in *notepad.exe*, you can see the issue in the **Page Setup** dialog, as shown in the following screenshot.

:::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/toggle-page-orientation-setting.png" alt-text="Screenshot of toggling the page orientation setting.":::

## Cause

This issue occurs because of a problem with the common dialog.

## Workaround

To work around this issue, follow these steps to switch the page orientation setting:

1. Select the **File** menu, and then select **Print**.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/select-file-print.png" alt-text="Screenshot of selecting the File and Print buttons in Notepad.":::

1. Select the printer you want to use, and then select the **Preferences** button.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/select-printer-preferences.png" alt-text="Screenshot of selecting a printer and Preferences in the Print dialog.":::

1. Once you confirm that the PSA has been launched, you can modify the page orientation setting there.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/modify-page-orientation-setting.png" alt-text="Screenshot of modifying the Orientation setting.":::
