---
title: Determine the license type of your Microsoft Office product 
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 04/02/2021
audience: Admin
ms.topic: article
ms.prod: office-365
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft 365
- Office 2019 suites
- Office 2016 suites
- Office 2013 suites
- Excel for Microsoft 365 for Mac 
- Word for Microsoft 365 for Mac 
- Outlook for Microsoft 365 for Mac
- PowerPoint for Microsoft 365 for Mac 
- Office 2019 for Mac 
- Excel 2019 for Mac 
- PowerPoint 2019 for Mac 
- Word 2019 for Mac
- Office for Business 
- Microsoft 365 for Home 
- Office 365 Small Business 
- Office 2016 for Mac 
- Microsoft 365 for Mac 
- Outlook 2019 for Mac
ms.custom: 
- CI 122291
- CSSTroubleshoot 
ms.reviewer: joselr
description: Describes how to determine the license type of your Microsoft Office product.
---

# How to determine the license type of your Microsoft Office product

## Summary

This article helps you to determine the licensing type of your Microsoft Office product, whether it is Microsoft 365, Office 2019, Office 2016, or Office 2013.

## License types

## [Windows](#tab/windows)

To determine whether you have a retail edition or a volume license edition, use one of the following methods, depending on which version of Microsoft Office product you have installed.

### Microsoft 365

If you are using a Microsoft 365 product, see View Microsoft 365 licenses and services with PowerShell, and follow the steps to find your license type and other details about your version of Office.

### Office 2019 and Office 2016 

1. Press Windows logo key+X on your keyboard to open the quick action menu.
2. Select Command Prompt (Admin).

     :::image type="content" source="media/determine-office-license-type/determine-office-license-type-1.png" alt-text="Select Command Prompt (Admin).":::
3. If a security prompt window is displayed, select **Allow**.

#### Using the command line to check your license type

1. Open an elevated Command Prompt window.
2. Type the following command to navigate to the Office folder.

    **For 32-bit (x86) Office**

    `cd c:\Program Files (x86)\Microsoft Office\Office16\`

    **For 64-bit (x64) Office**

    `cd c:\Program Files\Microsoft Office\Office16\`

3. Type the following command, and then press Enter:

    `cscript ospp.vbs /dstatus`

    :::image type="content" source="media/determine-office-license-type/determine-office-license-type-2.png" alt-text="The screen will display the license type. ":::

4. In this example, the screen displays the **Retail type** license. If you have a volume license (VL) product, the license type is displayed as **VL** or **Volume Licensing**.

### Office 2013

#### Method 1: Search DVD or ISO file for Admin folder

This method requires that you have access to the DVD or ISO file that was used to install your Office product.

1. Open File Explorer, and navigate to the DVD or ISO file.
2. Search for a folder that’s named **Admin**.

   - If the Admin folder exists, this disc is a **volume license** (VL) edition.
   - If the Admin folder does not exist, this disc is a retail edition.

    > [!NOTE]
    > Retail media includes a lowercase "r" before the ".WW" in the folder name and before the "WW.msi" in the MSI file name.
        :::image type="content" source="media/determine-office-license-type/determine-office-license-type-3.png" alt-text="ProPlus will have the letter R before WW. ":::
    For example, the installation file for Proplus retail is Proplus**r**WW.msi in the Proplus**r**WW folder. Proplus non-retail is ProplusWW.msi in the PlusplusWW.

#### Method 2: Use the command line interface

1. Open an elevated Command Prompt window**

   - **Windows 10, Windows 8.1, or Windows 8**

     1. Press Windows logo key+X on your keyboard to open the quick action menu.
     2. Select **Command Prompt (Admin)**.

        :::image type="content" source="media/determine-office-license-type/determine-office-license-type-1.png" alt-text="Select the Command Prompt (Admin).":::
     3. If a security prompt window is displayed, select **Allow**.

   - **Windows 7**

     1. Select **Start**, and type **cmd**.
     2. On the **Start** menu, right click **Command Prompt**, and then select **Run as administrator**.
     3. If a security prompt window is displayed, select **Allow**.
2. Type the following command to navigate to the Office folder:

   - **For 32-bit (x86) Office**

     `cd c:\Program Files (x86)\Microsoft Office\Office15\`

   - **For 64-bit (x64) Office**

     `cd c:\Program Files\Microsoft Office\Office15\`
3. At the command prompt, type `cscript ospp.vbs /dstatus`, and then press **Enter**.

    :::image type="content" source="media/determine-office-license-type/determine-office-license-type-2.png" alt-text="The screen displays the license type. ":::

   In this example, the license channel is reflected as **RETAIL** or **VOLUME**.

## [Mac](#tab/mac)

### Volume licenses

To determine the Office volume license type on a Mac, open an Office app (such as PowerPoint), select the name of the app in the menu, and then **About (app)**.

:::image type="content" source="media/determine-office-license-type/determine-office-license-type-4.png" alt-text="Select the Office product name from the menu.":::

The license type will be listed below the Product ID. 

:::image type="content" source="media/determine-office-license-type/determine-office-license-type-6.png" alt-text="Select the About menu item for that product.":::

### Subscription licenses

To determine the Office subscription license type, open an open an Office app (such as PowerPoint), select the name of the app in the menu, and then **About (app)**.

:::image type="content" source="media/determine-office-license-type/determine-office-license-type-4.png" alt-text="The Volume License type will be displayed. ":::

The license type will be listed below the Product ID.

:::image type="content" source="media/determine-office-license-type/determine-office-license-type-5.png" alt-text="The Subscription license type will be displayed.":::

---

## More information

For more information, see [Find details for other versions of Office](https://support.microsoft.com/office/find-details-for-other-versions-of-office-8e83dd74-3b83-4528-bda6-6ff6118f8293).

To get support for your Microsoft product, you can go to the [Office product page](https://www.office.com/?auth=1), and log in to your My [Account panel](https://account.microsoft.com/services/). Within the panel, you can find your product details, support options, and information about any subscriptions that you have.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
