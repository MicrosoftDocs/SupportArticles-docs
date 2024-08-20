---
title: DLP policy tips for PDF attachments not shown
description: Describes an issue in which Outlook 2016 or 2013 doesn't display a Data Loss Prevention policy tip for PDF attachments in Windows 7. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\DLP
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans, tasitae, meshel
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook doesn't display DLP policy tips for PDF attachments in Windows 7

_Original KB number:_ &nbsp; 3001881

## Symptoms

You're running Microsoft Outlook 2016 or Outlook 2013 on Windows 7. You attach a PDF file to an email message that should trigger a Data Loss Prevention (DLP) policy tip. However, no policy tip is displayed in Outlook.

## Cause

This issue can occur if version 10 or later of Adobe PDF iFilter (AcroIF.dll) is installed.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, use one of the following methods:

Method 1: Upgrade to a later version of Windows, such as Windows 10.

Method 2: Try another third-party iFilter.

Possible third-party alternatives are Foxit and Tracker. The third-party iFilter must be the same bitness as Office.

If you use a third-party iFilter, add the `TecDisableHardMemoryLimit` subkey to the registry. Follow these steps:

1. Exit Outlook.
2. Start Registry Editor. In Windows 7, select **Start**, type *regedit.exe* in the search box, and then press Enter.
3. Locate and then select the following registry subkey, where the *x.0* placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013).

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\PolicyNudges`

    > [!NOTE]
    > If the `PolicyNudges` subkey doesn't exist, create it.

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type *TecDisableHardMemoryLimit*, and then press Enter.
6. Right-click **TecDisableHardMemoryLimit**, and then select **Modify**.
7. In the **Value** data box, type *1*, and then select **OK.**
8. Exit Registry Editor.

## More information

For more information about Foxit iFilter and Tracker iFilter, see [Foxit iFilter](https://www.foxitsoftware.com/) and [PDF-XChange Shell Extensions and iFilter](https://www.tracker-software.com/shell_ext.html).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
