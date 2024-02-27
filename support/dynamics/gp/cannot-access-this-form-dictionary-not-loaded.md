---
title: Cannot access this form because the dictionary containing it is not loaded error when you open a window in Microsoft Dynamics GP 
description: Describes a problem in which you receive the Cannot access this form because the dictionary containing it is not loaded error when you open a window in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/19/2024
---
# "Cannot access this form because the dictionary containing it is not loaded" error when you open a window in Microsoft Dynamics GP

This article provides methods to resolve the "Cannot access this form because the dictionary containing it is not loaded" error in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851052

## Symptoms

When you open a window in Microsoft Dynamics GP, you receive the following error message:

> Cannot access this form because the dictionary containing it is not loaded.

## Cause 1

If a previously installed module is removed, Microsoft Dynamics GP doesn't assign an alternate existing form. See [Resolution 1](#resolution-1).

## Cause 2

If a forms dictionary has been removed or has become corrupt, Microsoft Dynamics GP can't open the assigned form. See [Resolution 2](#resolution-2).

## Resolution 1

To resolve this problem, use one of the following methods.

### Method 1 of Resolution 1

Reinstall the module that was removed. This action re-creates the product dictionary that Microsoft Dynamics GP must access.

### Method 2 of Resolution 1

Select a form for Microsoft Dynamics GP to use. To do it, use the appropriate option.

1. Open the **Alternate/Modified Forms and Reports** window. To do it, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** list, select the appropriate ID.
3. In the **Product** list, select **All Products**.
4. In the **Type** list, select **Windows**.
5. In the **Alternate/Modified Forms and Reports List** area, expand the appropriate node based on the window you want to access.
6. Expand the appropriate window, and then select **Microsoft Dynamics GP** or the appropriate option.
7. Select **Save**.
8. Close the **Alternate/Modified Forms and Reports** window.

> [!NOTE]
> By default, when you open the **Advanced Security** window, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select more companies in the **Company Name** area. You can select more users in the **User** area of the **Advanced Security** window.

## Resolution 2

To resolve this problem, follow one of the following methods.

### Method 1 of Resolution 2

Re-create the _Form.dic_ file if the Forms dictionary is corrupt.

For more information about how to re-create the _Forms.dic file_, see [How to re-create the Forms.dic file in Microsoft Dynamics GP](re-create-the-forms-dot-dic-file.md).

### Method 2 of Resolution 2

Select a form for Microsoft Dynamics GP to use. To do it, use the appropriate option.

1. Open the **Alternate/Modified Forms and Reports** window. To do it, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** list, select the appropriate ID.
3. In the **Product** list, select **All Products**.
4. In the **Type** list, select **Windows**.
5. In the **Alternate/Modified Forms and Reports List** area, expand the appropriate node based on the window you want to access.
6. Expand the appropriate window, and then select **Microsoft Dynamics GP** or the appropriate option.
7. Select **Save**.
8. Close the **Alternate/Modified Forms and Reports** window.

> [!NOTE]
> By default, when you open the **Advanced Security** window, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select more companies in the **Company Name** area. You can select more users in the **User** area of the **Advanced Security** window.
