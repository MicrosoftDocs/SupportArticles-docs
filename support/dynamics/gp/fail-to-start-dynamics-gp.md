---
title: Error when you try to start Dynamics GP
description: Describes an issue that occurs when an incorrect setting exists in the Dynamics.set file for Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you try to start Microsoft Dynamics GP: "Data Dictionary Memory Allocation Error"

This article provide a solution to an error that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866722

## Symptoms

When you try to start Microsoft Dynamics GP, you receive the following error message:

> Data Dictionary Memory Allocation Error

## Cause

This issue occurs for one of the following reasons.

### Cause 1

One or more products that are listed in the Dynamics.set file use the same product ID as another product that is listed in the Dynamics.set file. To resolve this problem, see [Resolution 1](#resolution-1).

### Cause 2

One or more products that are listed in the Dynamics.set file have a product ID of 1. However, the number 1 is reserved for the Dex.dic file. To resolve this problem, see [Resolution 2](#resolution-3).

### Cause 3

A FORMS dictionary or a REPORTS dictionary has the same name as another dictionary that is listed in the Dynamics.set file. To resolve this problem, see [Resolution 3](#resolution-3).

## Resolution

To resolve this issue, locate and then open the Dynamics.set file in Notepad, and then see the appropriate resolution. By default, the Dynamics.set file is in the Microsoft Dynamics GP code folder. The Microsoft Dynamics GP code folder is in the following locations:

- Microsoft Dynamics GP 9.0 and later versions code folder:

    C:/Program Files/Microsoft Dynamics/GP

- Microsoft Business Solutions - Great Plains 8.0 code folder:

    C:/Program Files/Microsoft Business Solutions/Great Plains

    > [!NOTE]
    > Make sure that you have valid and complete backups of the Dynamics.set file before you continue.

### Resolution 1

Make sure that no product that is listed in the Dynamics.set file has the same product ID as another product. You can find the product IDs over the name of the product in the Dynamics.set file.

For example, the product ID for Microsoft Dynamics GP is 0, and the product ID for Project Accounting is 258 in the following example of the Dynamics.set file.

> 0  
> Microsoft Dynamics GP  
> 258  
> Project Accounting

If you find two products that are listed in the Dynamics.set file that have the same product IDs, follow these steps:

1. In the Microsoft Dynamics GP code folder, locate the product dictionary files that match the two products in the Dynamics.set file.
2. Right-click each product dictionary file, and then click **Properties**.
3. Click the **Dictionary** tab, and then note the dictionary ID. This ID is also the product ID for the dictionary.
4. In the Dynamics.set file, make sure that the product ID is the same as the dictionary ID that you noted in step 3 for each product.
5. If the product ID is different, change the product ID to match the dictionary ID.

    If both product dictionaries do have the same dictionary IDs, contact Microsoft Dynamics GP Support.

### Resolution 2

Examine the Dynamics.set file, and look for any product ID of 1. If you find a product ID of 1, follow these steps:

1. In the Microsoft Dynamics GP code folder, locate the product dictionary file that has the product ID of 1 in the Dynamics.set file.
2. Right-click the product dictionary file, and then click **Properties**.
3. Click the **Dictionary** tab, and then note the dictionary ID. This ID is also the product ID for the dictionary.
4. In the Dynamics.set file, make sure that the product ID is the same as the dictionary ID that you noted in step 3.
5. If the product ID is different, change the product ID to match the dictionary ID.

    If the product does have a dictionary ID of 1, contact Microsoft Dynamics GP Support.

### Resolution 3

Make sure that the Dynamics.set file does not use the same file name for the FORMS dictionary or for the REPORTS dictionary and for different applications.

The FORMS dictionary, the REPORTS dictionary, and their paths are found in the Windows section of the Dynamics.set file after the Product list.

For example, the FORMS dictionary and the REPORTS dictionary for Microsoft Dynamics GP are named the FORMS.DIC file and the REPORTS.DIC file. Additionally, the FORMS dictionary and the REPORTS dictionary for Project Accounting are named the PAFORM.DIC file and the PAREPT.DIC file. You can see this in the following example Dynamics.set file.

> Windows  
:C:Program Files/Microsoft Dynamics/GP/Dynamics.dic  
:C:Program Files/Microsoft Dynamics/GP/Data/FORMS.DIC  
:C:Program Files/Microsoft Dynamics/GP/Data/REPORTS.DIC  
:C:Program Files/Microsoft Dynamics/GP/PA258.DIC  
:C:Program Files/Microsoft Dynamics/GP/Data/PAFORM.DIC  
:C:Program Files/Microsoft Dynamics/GP/Data/PAREPT.DIC

If the Dynamics.set file does list products that have the same file name, follow these steps:

1. In the Microsoft Dynamics GP code folder, locate the product dictionary file.
2. Make sure that the file names for the FORMS dictionary and for the REPORTS dictionary match the file names that are listed in the Dynamics.set file.
3. If the file names do not match, change the file names in the Dynamics.set file to match the file names for the FORMS dictionary and for the REPORTS dictionary in the Microsoft Dynamics GP code folder.
4. If the FORMS dictionary or the REPORTS dictionary has the same file name as another dictionary, rename one of the dictionaries by using a different file name, and then make the same change to the file name in the Dynamics.set file.
