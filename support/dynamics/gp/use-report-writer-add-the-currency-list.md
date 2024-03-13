---
title: Use Report Writer to add the currency list
description: Describes how to use Report Writer to add the functional currency list price to the SOP Blank Invoice Form in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use Report Writer to add the functional currency list price to the SOP Blank Invoice Form in Microsoft Dynamics GP

This article describes how to use Report Writer to add the functional currency list price to the SOP Blank Invoice Form or to other non-options forms in Sales Order Processing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852962

## Step 1: Back up the report

If you've any modified reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

1. Use the appropriate method:
    - In Microsoft Dynamics GP 10, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.
1. If you're prompted for the password, type the system password.
1. Use the appropriate method:
    - In Microsoft Dynamics GP, select **Microsoft Dynamics GP** in the Edit Launch File window.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
1. > [!NOTE]
    > The path that appears in the **Reports** box.
1. Select **OK** to close the Edit Launch File window.

## Step 2: Open the report

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.
2. Use the appropriate method:
    - In Microsoft Dynamics GP, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.
3. Select **Reports**.
4. In the **Original Reports** area, select the report that you want to modify, and then select **Insert**.
5. In the **Modified Reports** area, select the report, and then select **Open**.

## Step 3: Create a calculated field

1. Select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
3. In the **Name** field, type **List Price**.
4. In the **Result Type** list, select **String**.
5. In the **Expression Type** area, select **Calculated**.
6. Select the **Functions** tab, and then select **User-Defined**.
7. In the **Core** list, select **Inventory**.
8. In the **Functions** list, select **rw_ivGetFuncListPrice**, and then select **Add**.
9. Select the **Fields** tab. In the **Resources** list, select **Sales Transaction Amounts Work**.
10. In the **Field** list, select **Item Number**.
11. Select **Add**, and then select **OK**. The following expression appears:  
    `FUNCTION_SCRIPT(rw_ivGetFuncListPriceSOP_LINE_WORK.Item Number)`
12. Select **OK**.

## Step 4: Add the new fields to the report

1. In the Toolbox window, select **Calculated Field** in the resource list, and then select **List Price**.
2. Drag the **List Price** field to the **H2** section of the report.
3. If you want to edit the field, select **Tools**, and then select **Drawing Options**.

## Step 5: Save the modified report

1. Close the report. Select **Save** when you're prompted to save your changes.
2. In the **Report Definition** window, select **OK**.
3. Use the appropriate method:
    - In Microsoft Dynamics GP, select **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 6: Assign security permissions to the modified report

**Method 1**: Use Microsoft Dynamics GP 10.0 security

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID that will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the **Sales** folder.
6. Expand the **report_name** folder.

    > [!NOTE]
    > *Thereport_nameplaceholder* is a placeholder for the name of the report.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.

**Method 2**: Use Advanced Security in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. Type the system password if you're prompted.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**
4. Expand the following nodes:
    - Reports
    - Sales
    - **report_name**
5. Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**
6. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

**Method 3**: Use Microsoft Dynamics GP 9.0 security or Microsoft Business Solutions - Great Plains 8.0 security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > If you're prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Sales**.
5. In the **Access List** box, double-click **report_name**, and then select **OK**.

    > [!NOTE]
    > After you select **OK**, an asterisk appears next to the report name.
