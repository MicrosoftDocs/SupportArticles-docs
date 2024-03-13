---
title: Add Special Depreciation Allowance Amount via Report Writer or SmartList
description: How to use Report Writer or SmartList to add the Special Depreciation Allowance Amount field as a separate line item in Microsoft Dynamics GP.
ms.reviewer: theley, ryanklev
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use Report Writer or SmartList to add the "Special Depreciation Allowance Amount" field as a separate line item

This article describes how to use Report Writer or SmartList to add the **Special Depreciation Allowance Amount** field as a separate line item in a Fixed Assets Management report or in a SmartList view.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858296

## How to add the "Special Depreciation Allowance Amount" field to a report

You can add the **Special Depreciation Allowance Amount** field to most depreciation activity reports. To do this, follow these steps:

1. Print the report to which you want to add the **Special Depreciation Allowance Amount** field. When you do this, print the report to the screen.
2. Select **Modify**.
3. In the Toolbox window in the resource list, select **Asset Book Master**.
4. Drag the **Special Depreciation Allowance Amount** field from the Toolbox window to the **B** section of the report.
5. On the **File** menu, select **Microsoft Dynamics GP**. When you are prompted to save changes, select **Save**.
6. Grant security to the modified report. To do this, use one of the following methods:

    - Method 1 - Use Advanced Security

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. Type the system password if you are prompted to do this.
      2. Select **View**, and then select **by Alternate, Modified and Custom**.
      3. Expand the following nodes:

         - Reports
         - Financial
         - The Fixed Asset Management report that you modified

      4. Select **Fixed Assets (Modified)**.
      5. Select **Apply**, and then select **OK**.

         > [!NOTE]
         > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are made for the current user and for the current company. However, you can select additional users and companies in the following areas of the Advanced Security window:
         >
         > - User
         > - Company

    - Method 2 - Use Dynamics GP Security

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. Type the system password if you are prompted to do this.
      2. In the **User ID** list, select the user ID for the user to whom you want to give access to the report.
      3. In the **Product** list, select **Fixed Assets**.
      4. In the **Type** list, select **Modified Reports**.
      5. In the **Series** list, select **Financial**.
      6. In the **Access List** box, double-click the report that you modified, and then select **OK**. An asterisk (*) appears next to the report name.

## How to add the "Special Depreciation Allowance Amount" field to a SmartList view

To add the **Special Depreciation Allowance Amount** field to a SmartList view, follow these steps:

1. On the **View** menu, select **SmartList**.
2. Select **Fixed Assets Books**.
3. Select **Columns** to open the **Change Column Display** dialog box.
4. Select **Add** to open the **Columns** dialog box.
5. Select **Special Depreciation Allowance Amount**, and then select **OK**.
6. Select **OK**.
7. Save this view. To do this, follow these steps:

    1. Select **Favorites**.
    2. In the **Name** box, type with Special Depreciation Allowance Amount.
    3. Select **Add**.
