---
title: Pictures cannot be shown but shown as red X
description: This article provides a resolution for the issue that pictures are not shown and displayed as red X in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: v-yeche, wbrandt
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# Pictures cannot be displayed and are shown as red X in Outlook

_Original KB number:_ &nbsp; 2638687

## Symptoms

When you open an email message that contains images in Microsoft Office Outlook, the image areas are blocked. These areas display a red X placeholder. Additionally, the images are sent or received as email attachments.

## Resolution

To resolve this problem, make sure that the Temporary Internet Files folder is valid.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, select **Run** (Or press Windows Key and R on your keyboard at the same time), type *regedit.exe*, and then press Enter.

   (If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.)

   :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/open-regedit-exe.png" alt-text="Screenshot of the Run window when you type regedit.exe." border="false":::

2. Locate the following registry subkey:

   Office 2010: `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Security`  
   Office 2007: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Security`  
   Office 2003: `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Security`

   :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/locate-security-registry-subkey.png" alt-text="Screenshot of the Security subkey in the registry subkey list and its path in the bottom of the window.":::

3. In the right side window, double-click **OutlookSecureTempFolder**. Verify whether the folder noted is valid. You can copy and paste the folder path in Windows Explorer to verify this.

   - If you do not see the `OutlookSecureTempFolder` entry, go to the next step.
   - If the folder does not exist on your computer, change the **OutlookSecureTempFolder** value to a valid folder path, for example **C:\temp0\**.

   :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/change-the-outlooksecuretempfolder-value.png" alt-text="Screenshot of the value of OutlookSecureTempFolder registry key.":::

   :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/path.png" alt-text="Screenshot of the Windows Explorer.":::

4. If the **OutlookSecureTempFolder** registry entry does not exist, you must create it manually. To do this, follow these steps:
   1. Right-click an empty area, point to **New**, and then select **String Value**.

      :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/string-value.png" alt-text="Screenshot of the String Value option of the New menu.":::

   2. Double-click **OutlookSecureTempFolder**, and then enter a valid folder path, for example **C:\temp0\\**.

      :::image type="content" source="media/pictures-not-displayed-and-shown-as-red-x/enter-valid-folder-path.png" alt-text="Screenshot of the Edit String window for OutlookSecureTempFolder.":::

5. Restart Outlook.

Your opinion is important to us! Do not hesitate to tell us what you think of this article using the comment field located at the bottom of the document. This will allow us to improve the content. Thank you in advance!
