---
title: The Linked image cannot be displayed error
description: Describes an issue that triggers an error about image display in Outlook 2010 or Outlook 2013. This issue involves the BlockHTTPimages registry value. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Images or links blocked in email messages
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# The Linked image cannot be displayed error in an Outlook email message

_Original KB number:_ &nbsp; 3096277

## Symptoms

In Microsoft Outlook 2010 or Outlook 2013, images are not displayed in some email messages. Instead, you see a red **x** and the following text:

> Right-click here to download pictures. To help protect your privacy, Outlook prevented automatic download of this picture from the Internet.

:::image type="content" source="media/the-linked-image-cannot-be-displayed-error/right-click-here-to-download-pictures-error.png" alt-text="Screenshot of the Right-click here to download pictures error detail.":::

Additionally, when you right-click the image and select **Download Pictures**, the following error is displayed instead of the original text:

> The linked image cannot be displayed. The file may have been moved, renamed, or deleted. Verify that the link points to the correct file and location.

:::image type="content" source="media/the-linked-image-cannot-be-displayed-error/the-linked-image-cannot-be-displayed-error.png" alt-text="Screenshot of the linked image cannot be displayed error detail.":::

## Cause

This issue occurs when the `BlockHTTPimages` registry value is set to **1** and the images in the email message have a source that points to a URL.

## Resolution

To resolve this issue, follow these steps.

Important: Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following methods, as appropriate for your situation:
   - Windows 8 or Windows 10: Press Windows Key+R to open a **Run** dialog box.
   - Windows 7 or Windows Vista: Select **Start**, and then select **Run** to open a **Run** dialog box.

3. Type *regedit.exe*, and then press Enter.
4. Locate and select the following subkey.

    - Without Group Policy:

      Key: HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common  
      DWORD: BlockHTTPimages  
      Value: 1

    - With Group Policy:

      Key: HKEY_CURRENT_USER\Software\policies\Microsoft\Office\x.0\Common  
      DWORD: BlockHTTPimages  
      Value: 1

5. Right-click the `BlockHTTPimages` key, and then select **Delete**.
6. When you are prompted to confirm the deletion, select **Yes**.
7. On the **File** menu, select **Exit** to exit Registry Editor.

> [!NOTE]
> If the registry value is located under the Policies hive, it may have been configured by Group Policy. If it was configured by Group Policy, it will be restored when this policy is refreshed on the computer. Your administrator must change the policy to change this setting.
