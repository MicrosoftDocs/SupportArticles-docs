---
title: Page setup dialog might be unexpectedly closed when Print Support App is installed
description: Provides a workaround for an issue where the page setup dialog is unexpectedly closed when Print Support App is installed.
ms.date: 09/02/2024
ms.custom: sap:Graphics and Multimedia development\Printing and the Print Spooler API
ms.reviewer: davean, v-sidong
ms.topic: troubleshooting
---
# Page setup dialog might be unexpectedly closed when Print Support App is installed

## Symptoms

Consider the following scenario:

- You're using Windows 10 22H2.
- You're developing a Print Support App (PSA) for IPP based printer.
- You're using Notepad or Paint application.

If your system installs Print Support App, toggling the page orientation setting might cause the host application to crash. For example, in *notepad.exe*, you can see the issue in the page settings dialog as shown in the following picture.

:::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/toggle-page-orientation-setting.png" alt-text="Screenshot of toggling the page orientation setting.":::

## Cause

Microsoft has confirmed that this issue is a problem with the common dialog.

## Workaround

To work around this issue, follow these steps to switch page orientation setting:

1. Select **File** menu and then select **Print...**.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/select-file-print.png" alt-text="Screenshot of selecting the File and Print button in Notepad.":::

1. Select the printer you want to use, and then select the **Preferences** button.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/select-printer-preferences.png" alt-text="Screenshot of selecting printer and Preferences in the Print dialog.":::

1. Once you have confirmed that PSA has been launched, you can modify the page orientation setting there.

   :::image type="content" source="media/page-setup-dialog-closed-print-support-app-installed/toggle-page-orientation-setting.png" alt-text="Screenshot of toggling the Orientation setting.":::
