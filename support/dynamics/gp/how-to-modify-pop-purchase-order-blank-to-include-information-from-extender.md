---
title: Modify POP Purchase Order Blank to have info from Extender
description: How to modify the POP Purchase Order Blank form to include information from the Extender window in Microsoft Great Plains.
ms.reviewer: kvogel
ms.topic: how-to
ms.date: 04/22/2021
---
# How to modify the POP Purchase Order Blank form to include information from the Extender window

This article describes how to modify the POP Purchase Order Blank form to include information from the Extender window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 904575

## Create the Extender window

1. Select **Tools**, select **Extender**, and then select **Extender**.
2. Select **Windows**.
3. Specify the following options:

    - **Window ID**: POP_LINE
    - **Description**: POP Extra Window
    - **Product**: Great Plains
    - **Series**: Purchasing
    - **Form**: Purchase Order Entry
    - **Window**: Line_Scroll

## Add the Extender key fields

1. Expand **Key Fields**.
2. Select the down arrow next to **View**, and then select **Purchase Order Entry**.
3. Select **Ord**.

   > [!NOTE]
   > If you select **Line Number**, the report modification will not work.
4. Choose **Select**.
5. Expand **Key Fields** again.
6. Select the down arrow next to **View**, and then select **Purchase Order Entry**.
7. Select **PO Number**.
8. Choose **Select**.
9. Enter the appropriate information for the purchase order line items.
10. Select **Save**.

## Create a purchase order, and then open the report

1. Create a purchase order in Microsoft Great Plains. Select the line item, select **Extras**, select **Additional**, and then select **POP Extra Window**.
2. Fill in the appropriate information for the line.
3. Save the purchase order.
4. Select **Tools**, select **Customize**, and then select **Report Writer**. In the **Product** box, select **Great Plains**.
5. On the top menu bar, select the **Reports** button.
6. Under **Original Reports**, select **POP Purchase Order Blank Form**, and then select **Insert**.
7. Under **Modified Reports**, select the same report, and then select **Open**.
8. In the Report Definition window, select **Layout**.

## Create two calculated fields

### Calculated field 1

1. In the **Toolbox**, select **Calculated Fields**, and then select **New**.
2. In the Calculated Field Definition window, type *myKeyField* as the name.
3. In the **Result Type** list, select **String**.
4. In the **Expression Type** list, select **Calculated**.
5. Put the pointer in the **Expressions Calculated** box.
6. Select the **Functions** tab.
7. Select in the **Functions** box, and then select **LNG_STR**.
8. Select **Add**.
9. Select the **Fields** tab.
10. Select in the **Resources** box, and then select **Purchase Order Line Rollup Temp**.
11. Select in the **Field** box, select **Ord**, and then select **Add**.
12. In the **Expressions Calculated** box, put the pointer to the right side of the closing parenthesis.
13. In the **Operators** section, select **CAT**.
14. Select the **Functions** tab.
15. Select in the **Functions** box, and then select **STRIP**.
16. Select **Add**.
17. Select the **Fields** tab.
18. Select in the **Resources** box, and then select **Purchase Order Work**.
19. Select in the **Field** box, select **PO Number**, and then select **Add**.
20. Select **OK**.

> [!NOTE]
> In step 19, the first calculated field appears as the following string.
>
> LNG_STR(popPOLineRollupTemp.Ord ) # STRIP(POP_PO.PO Number )

### Calculated field 2

1. In the **Toolbox**, select **Calculated Fields**, and then select **New**.
2. In the Calculated Field Definition window, type Extender Field as the name. In the **Result Type** list, select **String**.
3. Select the **Functions** tab.
4. Select **User-Defined**.
5. Select in the **Core** box, and then select **System**.
6. Select in the **Functions** box, select **rw_TableHeaderString**, and then select **Add**.
7. Select the **Constants** tab.
8. Select in the **Type** box, and then select **Integer**.
9. In the **Constant** box, type *3107*, and then select **Add**.
10. Select in the **Type** box, and then select **String**.
11. In the **Constant** box, type *POP_LINE*, and then select **Add**.
12. Select the **Fields** tab.
13. Select in the **Resources** box, and then select **Calculated Fields**.
14. Select in the **Field** box, select **myKeyField**, and then select **Add**.
15. Select the **Constants** tab.
16. Select in the **Type** box, and then select **Integer**.
17. In the **Constant** box, type **0**, and then select **Add**.
18. Select in the **Type** box, and then select **Integer**.
19. In the **Constant** box, type a value of 1, and then select **Add**.

    > [!NOTE]
    > This value prints the first field in the **POP Extra Window** window for the line item. Type *2* if you want the second line to print, and so on.
20. Select **OK**.
21. In the **Toolbox**, select **Calculated Fields**.
22. Use the scroll box to find **Extender Field**. Then, drag **Extender Field** to the **H3** section of the report.

> [!NOTE]
> In step 19, the second calculated field appears as the following string.
>
> FUNCTION_SCRIPT(rw_TableHeaderString3107"POP LINE"MyKeyField01 )
