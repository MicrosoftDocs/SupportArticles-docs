---
title: How to modify SOP Blank Order Form report from Extender window
description: Describes how to modify the SOP Blank Order Form report from an Extender window.
ms.reviewer: theley, kvogel
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to modify the SOP Blank Order Form report from an Extender window

This article describes how to modify the SOP Blank Order Form report to include information from an Extender window for the Sales Transaction Entry window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

> [!NOTE]
 You can apply this concept to other reports in Report Writer in Microsoft Dynamics GP and in Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898983

## More information

To modify the SOP Blank Order Form report in this manner, follow these steps.

### Create the Extender window

1. On the **Tools** menu, select **Extender**, and then select **Extender**.
2. In the Extender window, select **Windows**, and then select **New**.
3. In the Extender Windows window, specify the following settings:

    - **Window ID**: SOP_EXTRA_WINDO
    - **Description**: SOP Extra Window
    - **Product**: **Great Plains**
    - **Series**: **Sales**
    - **Form**: **Sales Transaction Entry**
    - **Window**: **Line_Scroll**

### Add the Extender key fields

1. Expand **Key Fields**.
2. Select the down arrow next to **View**, and then select **Line_Scroll**.
3. Select the **Line Item Sequence** field.
4. Choose **Select**.
5. Expand **Key Fields**.
6. Select the down arrow next to **View**, and then select **Sales Transaction Entry**.
7. Select the **SOP Number** field.
8. Choose **Select**.
9. Type the appropriate information in the fields that you want to use for the sales line items.
10. Select **Save**.

### Create an order, and then open the report

1. Create an order in the Sales Transaction Entry window.
2. Select a line item.
3. On the **Extras** menu, point to **Additional**, and then select **SOP Extra Window**.
4. Type the additional information for the line item.
5. In the SOP Extra Window extender window, select **Save**.
6. In the Sales Transaction Entry window, select **Save**.
7. Close the Sales Transaction Entry window.
8. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
9. In the Microsoft Business Solutions - Great Plains window, select **Great Plains** in the **Product** list.
10. On the menu bar, select the **Reports** button.
11. In the **Original Reports** list, select **SOP Blank Order Form**, and then select **Insert**.
12. In the **Modified Reports** list, select **SOP Blank Order Form**, and then select **Open**.
13. In the Report Definition window, select **Layout**.

### Create two new calculated fields

#### Calculated field 1

1. In the resource list in the Toolbox window, select **Calculated Fields**, and then select **New**.
2. In the Calculated Field Definition window, specify the following settings:

    - **Name**: myKeyField
    - **Result Type**: **String**
    - **Expression Type**: **Calculated**

3. Select the **Functions** tab.
4. In the **Function** list, select **LNG_STR**, and then select **Add**.
5. Select the **Fields** tab.
6. In the **Resources** list, select **Sales Transaction Amounts Work**. In the **Field** list, select **Line Item Sequence**, and then select **Add**.
7. In the **Calculated Expression** field, select to the right of the closing parenthesis.
8. In the **Operators** area, select **CAT**.
9. Select the **Functions** tab.
10. In the **Function** list, select **STRIP**, and then select **Add**.
11. Select the **Fields** tab.
12. In the **Resources** list, select **Sales Transaction Work**. In the **Field** list, select **SOP Number**, and then select **Add**.

The first calculated field appears as the following string.

LNG_STR(SOP_LINE_WORK.Line Item Sequence ) # STRIP(SOP_HDR_WORK.SOP Number )

#### Calculated field 2

1. In the resource list in the Toolbox window, select **Calculated Fields**, and then select **New**.
2. In the Calculated Field Definition window, specify the following settings:

    - **Name**: Extender Field
    - **Result Type**: **String**
    - **Expression Type**: **Calculated**

3. Select the **Functions** tab.
4. Select **User-Defined**.
5. In the **Core** list, select **System**.
6. In the **Function** list, select **rw_TableHeaderString**, and then select **Add**.
7. Select the **Constants** tab.
8. In the **Type** list, select **Integer**.
9. In the **Constants** field, type *3107*, and then select **Add**.
10. Select the **Constants** tab.
11. In the **Type** list, select **String**.
12. In the **Constants** field, type SOP_EXTRA_WINDO, and then select **Add**.
13. Select the **Fields** tab.
14. In the **Resources** list, select **Calculated Field**. In the **Field** list, select **myKeyField**, and then select **Add**.
15. Select the **Constants** tab.
16. In the **Type** list, select **Integer**.
17. In the **Constants** field, type *0*, and then select **Add**.
18. Select the **Constants** tab.
19. In the **Type** list, select **Integer**.
20. In the **Constants** field, type *1*, and then select **Add**.

    > [!NOTE]
    > When the value in the **Constants** field is **1**, the first field for the line item in the SOP Extra Window extender window will be printed. When the value in the **Constants** field is **2**, the second field for the line item in the SOP Extra Window extender window will be printed, and so on.

The second calculated field appears as the following string.

FUNCTION_SCRIPT(rw_TableHeaderString3107"SOP_EXTRA_WINDO"myKeyField 0 1 )

### Add the calculated fields to the report

1. In the Toolbox window, select **Calculated Fields** in the list.
2. Select **Extender Field**, and then drag the field to the H2 section of the Report Layout window.

### Save your report, and then exit Report Writer

1. Close the Report Layout window. If you are prompted to save changes, select **Save**.
2. In the Report Definition window, select **OK**.
3. On the **File** menu, select **Microsoft Business Solutions - Great Plains**.

### Grant access to the report

#### Method 1 - Use the Advanced Security tool

1. Select **Tools**, point to **Setup**, point to **System**, and then select **Advanced Security**. Type the system password if you are prompted.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand the following nodes:

    - **Great Plains**
    - **Reports**
    - **Sales**
    - **SOP Blank Order Form**
4. Select **Great Plains (Modified)**.
5. Select **Apply**, and then select **OK**.

   > [!NOTE]
   > By default, when you open the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

#### Method 2 - By using standard security

1. Select **Tools**, point to **Setup**, point to **System**, and then select **Security**. If you are prompted, type the system password.
2. In the **User ID** list, select the user ID for the user whom you want to have access to the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Sales**.
5. In the **Access List** box, double-select **SOP Blank Order Form**, and then select **OK**. An asterisk (*) appears next to the report name.
