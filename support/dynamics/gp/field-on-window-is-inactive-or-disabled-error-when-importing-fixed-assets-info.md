---
title: Field on window is inactive or disabled error when importing fixed assets info 
description: When you import fixed assets information in Microsoft Dynamics GP, receive an error message that states Field on window is inactive or disabled. Provides a resolution.
ms.reviewer: Lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Field on window is inactive or disabled. (Line #26)" error when you import fixed assets information

This article provides a resolution for the issue that you can't import fixed assets information in Microsoft Dynamics GP due to the **Field on window is inactive or disabled (Line #26)** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935389

## Symptoms

When you import fixed assets information, you receive the following error message:

> Field on window is inactive or disabled. (Line #26)

## Cause

This problem occurs if the fixed assets import file contains a fixed asset record that is already in the Fixed Assets table. When you import fixed assets information, Microsoft Dynamics GP reads the information from a fixed assets import file. Then, it imports this information to the Fixed Assets table.

## Resolution

To resolve this problem, use one of the following methods.

**Method 1**:

Delete the fixed assets record from the fixed assets import file. Then, import the fixed assets information.

**Method 2**:

Delete the fixed assets record from the Fixed Assets table. Then, import the fixed assets information. To delete the fixed assets record from the Fixed Assets table, follow these steps:

1. On the **Tools** menu, point to **Utilities**, point to **Fixed Assets**, and then select **Delete**.
2. In the Asset Delete Utility window, type the identifier of the fixed assets record in the **Asset ID** field.

   > [!NOTE]
   > You can also select the lookup button next to the **Asset ID** field. Then, double-click the fixed assets record in the Asset Lookup window.

3. Select **Delete**.
4. Close the Asset Delete Utility window.

## More information

For more information about how to import fixed assets information, see [GP Import for asset information fails for Fixed Asset Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/gp-import-for-asset-information-fails-for-fixed-asset-management-in-microsoft-dynamics-gp-0bc6997d-0725-3ef7-0ad6-5e9ad14d6fb7).
