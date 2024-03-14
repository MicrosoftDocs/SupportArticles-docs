---
title: Information about the Change Decimal Places window
description: Introduces the Change Decimal Places window in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Information about the Change Decimal Places window in Microsoft Dynamics GP

This article contains information about the Change Decimal Places window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856120

Before you change decimal places for inventory items in the Change Decimal Places utility window, review the following information:

1. No **unposted** transactions can exist in the Inventory module, in the Invoicing module, in the Sales Order Processing module, or in the Purchase Order Processing module.
2. The **quantity** allocated for the inventory item must be **zero**. (To view the Quantity Allocated for the item, select **Inquiry** > **Inventory** > **Item**.)

- The item cannot be included in a stock count.
- The item can only have an **Item Type** of Sales Inventory or Discontinued.  (**Cards** > **Inventory** > **Item**)

> [!NOTE]
> Make sure to have a current backup of the company database before using this utility. It is recommended to do this in a Test company first. See [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211) for information on how to set up a test company.

Use the **Change Decimal Places** utility to change the number of decimal places used to track currency amounts and quantities for a range of items, descriptions, generic descriptions or classes. When using this utility, all item records, purchase receipts, quantities, vendor information, serial numbers, lot numbers and kits will be updated. The Decimal Places Change Audit Report will print automatically when you change decimal places and list the old and new decimal places, the amounts that posting accounts need to be adjusted by due to the rounding, and the price lists and unit of measure schedules that may no longer be valid. If price lists or unit of measure schedules are invalid, they will be removed from the item records, and you'll need to assign the item to another. If you prefer, you can create new price lists or unit of measure schedules that reflect the new decimal place settings you are using now and assign them to the items.

To change the decimal places for currency or quantity on an item:

1. Make sure there are no unposted transactions that contain the item.
2. Go to **Microsoft Dynamics GP** > **Tools** > **Utilities**> **Inventory** > **Change Decimal Places**.
3. Mark the checkbox for **Change Quantity Decimal Places** or **Change Currency Decimal Places** as desired.

    You may receive a warning message "Changing the **quantity** decimals will clear the U of M schedule, price list and purchasing options for each item included in the range. Do you want to continue?" For more information, press F1 and view the 'Handling effects of changing quantity decimals for items' topic in the Microsoft Dynamics GP Help.

    You may receive a warning message "Changing the **currency** decimals will round the amounts in the price list for each item included in the range. Do you want to continue?" For more information, press F1 and view the 'Effects of changing decimal places for currencies for items' topic in the Microsoft Dynamics GP Help.  Prices are rounded or padded with zeroes.

4. Enter the number of decimal places desired.
5. If you are using Multi-currency, specify the **Currency ID** you want the change to apply to.
6. Restrict to the Item Number, Description, Generic Description, or Class ID as desired. The changes will be made only for the items that meet ALL of the selected criteria.
7. You can select **Print** to print the Decimal Places Change Audit Report and review.
8. Select **Process** to update the item records. (Make sure to have a current backup of the company database before doing this.)
9. The Decimal Places Change Audit Report will automatically print. Review to see what items were changed.

This method does not change the decimals in the Manufacturing module. See [How to change the currency decimal places or quantity decimal places in Manufacturing in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-change-the-currency-decimal-places-or-quantity-decimal-places-in-manufacturing-in-microsoft-dynamics-gp-b3168cf3-bf83-f598-7898-67c351b142b1) for more information.

> [!NOTE]
> Updating decimal places directly in the SQL tables is not supported.
