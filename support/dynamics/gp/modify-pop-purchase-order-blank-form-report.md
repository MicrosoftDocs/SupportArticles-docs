---
title: How to modify the POP Purchase Order Blank Form report to print the 
description: Describes how to modify the POP Purchase Order Blank Form report to print the "purchase order line item quantity ordered" note if you use Project Accounting.
ms.topic: how-to
ms.reviewer: mnissen
ms.date: 03/13/2024
---
# How to modify the POP Purchase Order Blank Form report to print the "purchase order line item quantity ordered" note if you use Project Accounting in Microsoft Dynamics GP

This article describes how to modify the POP Purchase Order Blank Form report to print the "purchase order line item quantity ordered" note if you use Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944890

To modify the POP Purchase Order Blank Form report to print the "purchase order line item quantity ordered" note if you use Project Accounting, follow these steps.

> [!NOTE]
> The procedure in this article also works for the POP Purchase Order Other Form report.

## Step 1: Add the Purchase Order Line table to the POP Purchase Order Blank Form report

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
    - In Microsoft Dynamics GP 9.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.

2. In the **Product** list, click **Microsoft Dynamics GP**, and then click **OK**.
3. Open Report Writer. If the popPOLineRollupTemp table is not already linked to the Purchase Order Line table, follow these steps:

    1. Click **Tables**, click **Tables**, select **popPOLineRollupTemp**, and then click **Open**.
    2. In the Table Definition window, click **Relationships**, and then click **New**.
    3. In the **Secondary Table** field, select **Purchase Order Line**, and then click **OK**.
    4. In the **Secondary Table Key** field, select **POP_POLineIdxItemID**.
    5. Select the primary table values that match the secondary table values that are listed, and then click **OK.**  
    6. Close the Table Relationship window, click **OK**, and then close the Tables window.

4. When the table link is completed, click **Microsoft Dynamics GP** on the **File** menu.
5. Open Report Writer again, and then select **Project Accounting** as the product.
6. Click **Reports**, select **POP Purchase Order Blank Form** under **Original Reports**, and then click **Insert**.
7. Under **Modified Reports**, select **POP Purchase Order Blank Form**, and then click **Open**.
8. Click **Tables**, select **Purchase Order Line Rollup Temp** under **Report Table Relations**, and then click **New**.
9. Select **Purchase Order Line** under **Tables**, and then click **OK**.
10. Close the Report Table Relationships window.

## Step 2: Add the note to the POP Purchase Order Blank Form report

1. In the Report Definition window for the POP Purchase Order Blank Form report, click **Layout**.
2. In the Toolbox window, click **Calculated Fields** in the list, and then click **New**.
3. In the Calculated Field Definition window, specify the following fields:

    - **Name**: Quantity Ordered Note
    - **Result Type**: **String**  
    - **Expression Type**: **Calculated**

4. Click the **Functions** tab, and then follow these steps:

    1. Specify the following fields:

        - **User-Defined**: Select this option
        - **Core**: **System**  
        - **Function**: **RW_GetNoteText**

    2. Click **Add**.

5. Click the **Fields** tab, and then follow these steps:

    1. Specify the following fields:

        - **Resources**: **Purchase Order Line**  
        - **Field**: **PO Line Note ID Array**  

    2. Click **Add**.

6. When you are prompted for an array index, enter **5**.
7. Click **OK**.
8. Click the **Constants** tab, and then follow these steps:

    1. Specify the following fields:

        - **Type**: **Integer**  
        - **Constants**: Type the number of characters that you want to be printed

    2. Click **Add**.

9. Click the **Constants** tab, and then follow these steps:

    1. Specify the following fields:

        - **Type**: **Integer**  
        - **Constants**: 1
    2. Click **Add**. This line is the first line of the note.

    The following expression should be displayed in the Expression Calculated field.

    FUNCTION_SCRIPT(RW_GetNoteTextPOP_POLine.PO Line Note ID Array[5]501)

    > [!NOTE]
    > If you want the **Quantity Ordered Note** field to contain multiple line items, repeat steps 3 through 9 in this section. But, change step 9a to reflect all the additional line items that you want to be printed. For example, if you want the **Quantity Ordered Note** field to contain three line items, you must add two additional calculated fields. For one of the calculated fields, enter 2 in the **Constant** field. For the other calculated field, enter 3 in the **Constant** field.

10. Click **OK**.
11. Put the **Quantity Ordered Note** calculated field into the **H3** section of the report.
12. When you close the layout, click **Save**.
13. On the **File** menu, click **Microsoft Dynamics GP**. When you are prompted, click **Save** to save the report.

### Step 3: Assign security permissions to the modified report

- Method 1: Use security in Microsoft Dynamics GP 10.0

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
    2. In the **ID** box, select the "Alternate/Modified Forms and Reports" ID that you can assign to users. The default ID is **DEFAULTUSER**.
    3. In the **Product** list, click **Project Accounting**.
    4. In the **Type** list, click **Reports**.
    5. Expand the **Purchasing** folder.
    6. Expand the **Report_Name** folder.

        > [!NOTE]
        > *Report_Name* is a placeholder for the name of the report.
    7. Click **Project Accounting (Modified)**.
    8. Click **Save**.

- Method 2: Use Advanced Security in Microsoft Dynamics GP 9.0

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. If you are prompted, type the system password.
    2. Click **View**, and then click **by Alternate, Modified and Custom**.
    3. Expand **Project Accounting**.
    4. Expand the following nodes:

        - **Reports**  
        - **Purchasing**  
        - **Report_Name**
    5. Click **Project Accounting (Modified)**.
    6. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the User area of the Advanced Security window. You can select additional companies in the Company area of the Advanced Security window.

- Method 3: Use security in Microsoft Dynamics GP 9.0

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted, type the system password.
    2. In the **User ID** list, click the user ID of the user who will access the report.
    3. In the **Product** list, click **Project Accounting**.
    4. In the **Type** list, click **Modified Alternate Dynamics GP Reports**.
    5. In the **Series** list, click **Purchasing**.
    6. In the **Access List** box, double-click **Report_Name**, and then click **OK**.

    > [!NOTE]
    > After you click **OK**, an asterisk appears next to the report name.
