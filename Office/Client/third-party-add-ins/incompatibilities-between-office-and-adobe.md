---
title: Incompatibilities between Adobe Acrobat PDFMaker Office COM add-in and Office programs
description: This article describes how to verify that the PDFMaker add-in is installed on your computer.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Add-Ins\Centralized Deployment of Add-Ins
  - DownloadInstall\AdvancedConfiguration\AddInsOrIntegratedApps
  - CSSTroubleshoot
ms.reviewer: gregmans
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Excel 2016
  - Outlook 2016
  - PowerPoint 2016
  - Word 2016
  - Excel 2013
  - Word 2013
  - Outlook 2013
  - Access 2013
  - Visio Professional 2013
  - Visio Standard 2013
  - Excel 2010
  - Microsoft Word 2010
  - PowerPoint 2010
  - Microsoft Outlook 2010
  - Access 2010
  - Publisher 2010
  - Visio Professional 2010
  - Visio Standard 2010
ms.date: 06/06/2024
---

# Incompatibilities between Office programs and Adobe Acrobat PDFMaker Office COM Add-in

## Summary

If you have the Adobe Acrobat PDFMaker Office COM add-in installed on your computer and your Office programs are crashing or not responding, it might mean that the version of PDFMaker you have installed is incompatible with your version of Office.

## More information

To verify that the PDFMaker add-in is installed on your computer, follow this step:

- Office 2010: Open any Office application, and then select **File** > **Add-Ins**.
- Office 2013 and later versions, select **File** > **Options** > **Add-Ins**. Next to **Manage COM Add-ins** select **Go**. You'll see a dialog box that resembles the following screenshot:

:::image type="content" source="media/incompatibilities-between-office-and-adob/add-ins-outlook-options.png" alt-text="Screenshot to check the add-ins in the Outlook Options window.":::

To resolve this issue, use one of the following methods:

### Method 1: Upgrade your Adobe product

> [!NOTE]
> Fees may apply when you upgrade your Adobe product.

See [Compatible web browsers and PDFMaker applications](https://helpx.adobe.com/acrobat/kb/compatible-web-browsers-pdfmaker-applications.html) to determine which version of the Adobe Acrobat PDFMaker Office COM add-in is compatible with your Office version. If your version isn't compatible, try to upgrade your Adobe product to a later version that's compatible with your Office version.

If you're an advanced user and want to check the PDFMOfficeAddin.dll version compatibility, see the following table.

|Office version|Supported PDFMaker add-in versions (check PDFMOfficeAddin.dll version)|
|--|--|
|2010 (32-bit)|10.x and later|
|2010 (64-bit)|10.1 and later|
|2013 (32-bit)|11.0.1 and later|
|2013 (64-bit)|11.0.1 and later|
|2016 (32-bit)|11.0.16 and later|
|2016 (64-bit)|11.0.16 and later|

### Method 2: Manually disable Acrobat PDFMaker Office COM Add-in

If you have administrative permissions, you can also disable the add-in by following these steps in each Office program:

1. Open the Office program, and then select**File** > **Options** > **Add-ins**.
2. In the Manage drop-down list, select **COM Add-Ins**, and then select **Go**.
3. Clear the **Acrobat PDFMaker Office COM Addin** check box, as follows (Office 2010 screenshot), and then select **OK**.

:::image type="content" source="media/incompatibilities-between-office-and-adob/disable-add-in.png" alt-text="Screenshot to clear the Acrobat PDFMaker Office COM Add-in check box.":::

If you can't disable the add-in by following these steps, use one of the following methods.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

First, exit the Office program that you're having issues with when the PDFMaker add-in is loaded, and then use one of the following methods to start Registry Editor.

#### Windows 8

From the Start screen, type CMD. In the results pane, swipe down on Command Prompt to reveal the charm bar, then select **Run as administrator** on the charm bar. If you're using a mouse, right-click the **Command Prompt** to reveal the charm bar.

#### Windows 7, Windows Vista, or Windows XP

1. Select **Start** > **All Programs** > **Accessories**.
2. Right-click the **Command Prompt**, and then select **Run as administrator**.

Select the Office program that you're having problems with, and then use the appropriate method, as follows, to manually disable the PDFMaker add-in.

#### Access, Excel, Word, PowerPoint, or Publisher

> [!NOTE]
> The \<_Office program_\> placeholder represents the name of the Office program that you're having issues with when the PDFMaker add-in was installed.

1. Locate and select the following registry key:

   HKEY_CURRENT_USER\software\microsoft\office\\\<Office program\>\addins\Pdfmaker.OfficeAddin

   1. If the PDFmaker.\<Office program\>Addin key exists, modify the **Load Behavior** value under the key to 0, and then go to step 2.
   2. If the PDFmaker.\<Office program\>Addin key doesn't exist, go to step 2.

2. Repeat step 1 with each of the following registry keys:

   - HKEY_LOCAL_MACHINE\Software\Microsoft\Office\\\<Office program\>\Addins\PDFMaker.OfficeAddin
   - HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\\\<Office program\>\Addins\PDFMaker.OfficeAddin

3. Exit Registry Editor, and then start the Office program.

#### Outlook

1. Locate and select the following registry key:

   HKEY_CURRENT_USER\software\microsoft\office\Outlook\addins\PdfmOutlook.PDFMOutlook

   1. If the PdfmOutlook.PDFMOutlook key exists, modify the **Load Behavior** value under the key to 0, and then go to step 2.
   2. If the PdfmOutlook.PDFMOutlook key doesn't exist, go to step 2.

2. Repeat step 1 with each of the following registry keys:

   - HKEY_LOCAL_MACHINE\software\microsoft\office\Outlook\addins\PdfmOutlook.PDFMOutlook
   - HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Outlook\Addins\PdfmOutlook.PDFMOutlook

3. Exit Registry Editor, and then start Outlook.

#### Visio

1. Find and select the following key in the registry:

   HKEY_CURRENT_USER\software\microsoft\Visio\addins\PDFMVisio.PDFMVisioCOMAddin

   1. If the PDFMVisio.PDFMVisioCOMAddin exists, modify the **Load Behavior** value under the key to 0, and then go to step 2.
   2. If the PDFMVisio.PDFMVisioCOMAddin key doesn't exist, go to step 2.
   > [!NOTE]
   > This registry path does not include the \Office subkey as do the registry paths used by other Office programs.
2. Repeat step 1 with each of the following registry keys:

   - HKEY_LOCAL_MACHINE\software\microsoft\Visio\addins\PDFMVisio.PDFMVisioCOMAddin
   - HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Visio\addins\PDFMVisio.PDFMVisioCOMAddin

3. Exit the Registry Editor and open Visio.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

## Other resources

[I get a "stopped working" error when I start Office applications on my PC](https://support.office.com/article/i-get-a-stopped-working-error-when-i-start-office-applications-on-my-pc-52bd7985-4e99-4a35-84c8-2d9b8301a2fa)

[Excel not responding, hangs, freezes, or stops working](https://support.microsoft.com/office/excel-not-responding-hangs-freezes-or-stops-working-37e7d3c9-9e84-40bf-a805-4ca6853a1ff4)
