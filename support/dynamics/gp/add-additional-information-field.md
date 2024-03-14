---
title: Add the Additional Information field from Internet Information
description: Describes how to add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form report and to the POP Purchase Order Blank Form report in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form report and to the POP Purchase Order Blank Form report in Microsoft Dynamics GP

This article describes how to add the **Additional Information** field from the Internet Information window to the SOP Blank Invoice Form report and to the POP Purchase Order Blank Form report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859780

## Introduction

This article describes how to add the **Additional Information** field from the Internet Information window to the following reports:

- SOP Blank Invoice Form

- POP Purchase Order Blank Form

This article applies to the following products:

- Microsoft Dynamics GP

- Microsoft Business Solutions - Great Plains

## Step 1: Back up the Reports.dic file, and then start Report Writer

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.

    2. If you're prompted to type the system password, type the system password.

    3. Use the appropriate step:

        - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.

    4. > [!NOTE]
       > The path that appears in the **Reports** box.

    5. Select **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.

3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.

    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

4. Select **Reports**.

5. If it's the first time that the SOP Blank Invoice Form report has been modified, or if it's the first time that the POP Purchase Order Blank Form report has been modified, follow these steps:
    1. In the **Original Reports** list, select the **SOP Blank Invoice Form** report or the **POP Purchase Order Blank Form** report.
    2. Select **Insert**.
    3. In the **Modified Reports** list, select the **SOP Blank Invoice Form** report or the **POP Purchase Order Blank Form** report.
    4. Select **Open**.

## Step 2: Link the Purchase Order Line Rollup Temp table to the Purchase Order Line table

> [!NOTE]
> This step applies only to the POP Purchase Order Blank Form report.

1. In the Reports Definitions Window, select **Tables.**  
2. In the Report Table Relationships window, select **Purchase Order Line Rollup Temp**, and then select **New**.
3. In the Related Tables window, select **Purchase Order Line**, and then select **OK**.
4. Select **Close**.
5. In the Report Definition window, select **Layout**.

## Step 3: Create the calculated field for the first "Additional Information" field

> [!NOTE]
> This step applies to the SOP Blank Invoice Form report and to the POP Purchase Order Blank Form report.

1. In the Report Definition window, select **Layout**.
2. In the Toolbox window, select **Calculated Fields**, and then select **New**.
3. In the **Name** field, type **Internet Window Additional Information Field Line 1**.
4. In the **Result Type** list, select **String**, and then select **Calculated** in the **Expression Type** area.
5. Select the **Functions** tab, and then select **User-Defined**.
6. In the **Core** list, select **System**, select **RW_GetInternetText** in the **Function** list, and then select **Add**.
7. Select the **Constants** tab, select **String** in the **Type** list, type **ITM** in the **Constant** field, and then select **Add**.
8. Follow the appropriate step:

    - For the SOP Blank Invoice Form report, select the **Fields** tab, select **Sales Transaction Amounts Work** in the **Resources** list, select **Item Number** in the **Fields** list, and then select **Add**.

    - For the POP Purchase Order Blank Form report, select the **Fields** tab, select **Purchase Order Line** in the **Resources** list, select **Item Number** in the **Fields** list, and then select **Add**.

9. Select the **Constants** tab, select **String** in the **Type** list, and then select **Add**.

10. Select **Integer** in the **Type** list, type 50 in the **Constant** field, and then select **Add**.

11. Type **1** in the **Constant** field, and then select **Add**.

    The calculated expression should be displayed as follows:

    - For the SOP Blank Invoice Form report.

      `FUNCTION_SCRIPT(RW_GetInternetText"ITM"SOP_LINE_WORK.Item Number""501 )`

    - For the POP Purchase Order Blank Form report.

      `FUNCTION_SCRIPT(RW_GetInternetText"ITM"POP_POLine.Item Number""501 )`

12. Select **OK**.

13. Repeat steps 1 through step 12 in this section if you want to print other lines from the **Additional Information** field. In step 11, replace 1 with the number of the other line that you want to print. For example, if you want to print the second line of the **Additional Information** field, type **2**.

## Step 4: Add fields to the layout of the report

1. In the Toolbox window, select **Calculated Fields**, and then select **Internet Window Additional Information Field Line 1**.

2. Drag the field to the appropriate section:
   - For the SOP Blank Invoice Form report, drag the field to the H2 section.
   - For the POP Purchase Order Blank Form report, drag the field to the H4 section.

3. Double-click **Internet Window Additional Information Field Line 1**.
4. In the **Display Type** list, select **Data**.
5. Select **OK**.

## Step 5: Save the modified report

1. Close the report. When you're prompted to save the changes, select **Save**.

2. In the Report Definition window, select **OK**.

3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.

    - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 6: Assign security permissions to the modified report

To do it, use one of the following methods.

### Method 1: Use Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.

2. Select **View**, and then select **by Alternate, Modified and Custom**.

3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

4. Expand the following nodes:

    - Reports
       - Purchasing or Sales
       - Expand the folder for the report that you modified.

5. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.

6. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional entities. For example, you can select additional users in the **User** area of the Advanced Security window. You can also select additional companies in the **Company** area of the Advanced Security window.

### Method 2: Use Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.

2. In the **User ID** list, select the user ID of the user who will access the report.

3. In the **Type** list, select **Modified Reports**.

4. In the **Series** list, select **Purchasing** or **Sales**.

5. In the **Access List** box, double-click the report that you modified, and then select **OK**.

    > [!NOTE]
    > After you select **OK**, an asterisk appears next to the report name.
