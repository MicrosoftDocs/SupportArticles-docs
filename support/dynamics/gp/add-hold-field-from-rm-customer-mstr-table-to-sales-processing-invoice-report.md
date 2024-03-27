---
title: Add the Hold field from the RM Customer MSTR table to the Sales Order Processing Invoice report form when you use Manufacturing in Dynamics GP
description: Contains step-by-step instructions about how to add the Hold field from the RM Customer MSTR table to the Sales Order Processing Invoice report form in Manufacturing in Microsoft Dynamics GP 9.0.
ms.topic: how-to
ms.reviewer: theley, aeckman
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# How to add the Hold field from the RM Customer MSTR table to the Sales Order Processing Invoice report form when you use Manufacturing in Dynamics GP

This article describes how to add the **Hold** field from the RM Customer MSTR table to the Sales Order Processing Invoice report form when you use Manufacturing in Microsoft Dynamics GP 9.0.

> [!NOTE]
> This procedure works for all Sales Order Processing report forms for Manufacturing in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918947

To add the **Hold** field from the RM Customer MSTR table to a Sales Order Processing Invoice report form, follow these steps.

## Add the RM Customer MSTR table to the report

1. On the **Tools** menu, point to **Customize**, and then **click Report Writer**.
2. In the **Product** list, click **Manufacturing**, and then click **OK**.
3. Click **Reports**.
4. In the **Original Reports** list, click the Sales Order Processing invoice that you want to modify, and then click **Insert**.
5. In the **Modified Reports** list, click the Sales Order Processing invoice that you want to modify, and then click **Open**.
6. In the **Report Definition** window, click **Tables** to open the Report Table Relationships window.
7. Click **Customer Master Address File**, and then click **New**.
8. In the **Related Tables** window, click **RM Customer MSTR**, and then click **OK**.
9. In the **Report Table Relationships** window, click **Close**.

## Add the Hold field to the report layout

1. In the **Report Definition** window, click **Layout**.
2. The **Layout** tab of the Toolbox window contains two lists. In the upper list, click **RM Customer MSTR**.
3. From the lower list, drag the **Hold** field name to the **Page Header** area of the report layout.
4. From the lower list, drag the **Hold** field name to the **Report Header** area of the report layout.

After you follow these steps, the following conditions will be true in the **Page Header** and the **Report Header** areas of the report:

- If the customer is on hold, an "X" character is printed.
- If the customer is not on hold, an "X" character is not printed.

## Add the word "Hold" to the report

If you want the word "Hold" to appear in the printed document instead of an "X" character, you must create a conditional field. To do this, follow these steps:

1. In the list on the **Layout** tab of the Toolbox window, click **Calculated Fields**.
2. In the **Calculated Field Definition** window, type *Hold* in the **Name** box.
3. In the **Result Type** list, click **String**.
4. In the **Expression Type** area, click **Conditional**.
5. On the **Fields** tab, click **RM Customer MSTR** in the **Resources** list, click **Hold** in the **Field** list, and then click **Add**.
6. In the **Operators** area, click the equal sign (=).
7. Click the **Constants** tab.
8. In the **Type** list, click **Integer**, type 0 (zero) in the **Constant** box, and then click **Add**. The calculated expression appears as follows:

    RM _Customer_MSTR.HOLD = 0

9. Click the **True Case** box.
10. Click the **Constants** tab.
11. In the **Type** list, click **String**, leave the **Constant** box blank, and then click **Add**.
12. Click the **False Case** box.
13. Click the **Constants** tab.
14. In the **Type** list, click **String**, type Hold in the **Constant** box, and then click **Add**.
15. Click **OK** to save the new conditional field.
16. From the list that appears under the **Calculated Fields** option in the **Toolbox** window, drag the **Hold** field to the **Page Header** area of the report layout.
17. From the list that appears under the **Calculated Fields** option in the **Toolbox** window, drag the **Hold** field to the **Report Header** area of the report layout.

## Save the modified report

1. Close the **Report Layout** window. If you are prompted to save the changes to the report layout, click **Save**.
2. In the **Report Definition** window, click **OK**.
3. On the **File** menu, click **Microsoft Dynamics GP**.

## Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box. Then click **OK**.
3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
4. Expand **Manufacturing**, expand **Reports**, expand **Sales**, and then expand **formName**, where **formName** represents the name of the report that you modified. For example, expand **SOP Blank Invoice Form**.
5. Click **Manufacturing (Modified)**, click **Apply**, and then click **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users and companies in the **Company Name** area of the Advanced Security window and in the **Users** area of the Advanced Security window.

### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box. Then click **OK**.
3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
4. In the **Product** list, click **Manufacturing**.
5. In the **Type** list, click **Modified Alternate Dynamics GP Reports**.
6. In the **Series** list, click **Sales**.
7. In the **Access List** box, double-click the report that you modified, and then click **OK**.

> [!NOTE]
> An asterisk (*) appears next to the report name.
