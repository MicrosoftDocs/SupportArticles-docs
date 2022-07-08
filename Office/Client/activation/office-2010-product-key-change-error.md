---
title: Office 2010 product key change error step by step
description: Fixes an issue in which the previously installed version of Office 2010 prompts the user to change the product key.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - CI 162524
appliesto: 
  - Office Home and Student 2010
  - Office Home and Business 2010
  - Office Professional 2010
  - Office Professional Plus 2010
ms.date: 3/31/2022
---

# Office 2010 product key change error step by step

## Symptoms

The previously installed version of Office 2010 prompts the user to change the product key. The screen then disappears, and shows no response when product key change is clicked.

:::image type="content" source="media/office-2010-product-key-change-error/product-key-change.png" alt-text="Screenshot to prompt the user to change the product key." border="false":::

## Cause

This may be caused when the product keys of Office 2010 programs do not match.

## How to fix

This issue can be resolved by removing the Office 2010 registry values.

:::image type="icon" source="media/office-2010-product-key-change-error/alert-icon.png"::: The following describes how to modify the registry. Incorrect registry modification can cause serious problems, so please proceed with extra caution. For additional protection, you are recommended to back up the registry before modifying it. This allows you to restore the registry if a problem occurs. For more information about backing up the registry, see [Back up the registry](https://support.microsoft.com/help/322756).

1. Click Start :::image type="icon" source="media/office-2010-product-key-change-error/windows-icon.png"::: and enter regedit in the search pane. At the top of the program list, click regedit.

     :::image type="content" source="media/office-2010-product-key-change-error/enter-regedit-in-the-search-pane.png" alt-text="Screenshot shows steps to click the regedit item." border="false":::

    :::image type="icon" source="media/office-2010-product-key-change-error/alert-icon.png"::: If the user account control message appears, enter the administrator password, or click Yes.

2. In Registry Editor, go to the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Registration path.

     :::image type="content" source="media/office-2010-product-key-change-error/registry-editor.png" alt-text="Screenshot of the Registration path in the Registry Editor window." border="false":::

    > [!TIP]
    > If the operating system is Windows 7 64-bit, go to the HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Registration path.

3. There are several GUID (Globally Unique Identifiers), consisting of a combination of alphanumeric characters, in the Registration subpath. Each GUID specifies the program that is installed on your computer. Click each GUID to view the registry entries in the right pane, and find and select the GUID that contains the relevant Office program version.

    :::image type="content" source="media/office-2010-product-key-change-error/view-the-registry-entries.png" alt-text="Screenshot to click each GUID to view the registry entries in the right pane, and find and select the GUID that contains the relevant Office program version." border="false":::

4. After selecting the GUID that contains the Office program version, find and right-click DigitalProductID and click delete.
    
     :::image type="content" source="media/office-2010-product-key-change-error/registry-guid.png" alt-text="Screenshot shows steps to delete the DigitalProductID." border="false":::

    :::image type="icon" source="media/office-2010-product-key-change-error/alert-icon.png"::: Click Yes when the confirm value delete message appears.

5. Find and right-click ProductID and click delete.
     
     :::image type="content" source="media/office-2010-product-key-change-error/product-id.png" alt-text="Screenshot shows steps to delete the ProductID." border="false":::

    :::image type="icon" source="media/office-2010-product-key-change-error/alert-icon.png"::: Click Yes when the confirm value delete message appears.
6. Close Registry Editor and restart the computer.

7. When you run any Office 2010 program, the Enter your product key screen will appear. Enter the correct product key to complete product key change.

    :::image type="content" source="media/office-2010-product-key-change-error/office-2010-program-enter.png" alt-text="Screenshot of the Enter your product key screen after running any Office 2010 program." border="false":::

### Issue resolved?

- Determine if the issue has been resolved. If the issue has been resolved, the process described in this section is finished. If the issue is not resolved, you can [contact technical support](https://support.microsoft.com/contactus).  
- Thank you for your comments. To submit feedback or any problems found in the approach to resolving this issue, please send an [E-mail](mailto:fixit4me@microsoft.com?Subject=KB).

## Reference materials

- [Change your Office product key](https://support.microsoft.com/office/change-your-office-product-key-d78cf8f7-239e-4649-b726-3a8d2ceb8c81)

## Send us feedback

Microsoft Help and support site values your opinion. Please send us feedback below to give us your valuable opinion.
