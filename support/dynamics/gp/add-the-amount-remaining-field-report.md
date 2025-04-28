---
title: Add the Amount Remaining field to report
description: How to add the Amount Remaining field to the RM Statement on Blank Paper report in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# How to add the Amount Remaining field to the "RM Statement on Blank Paper" report in Microsoft Dynamics GP

This article describes how to add the **Amount Remaining** field to the RM Statement on Blank Paper report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912126

## Step 1: Back up the Reports.dic file, and then start Report Writer

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Use the appropriate step:

        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.

    2. If you're prompted, type the system password.
    3. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
    4. > [!NOTE]
       > The path that appears in the **Reports** box.
    5. To close the Edit Launch File window, select **OK**.
2. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.
3. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**

## Step 2: Create the table relationship

1. Select **Tables** two times.
2. Select **RM_Statements_TRX_TEMP**, and then select **Open**.
3. Select **Relationships**, and then select **New**.
4. Select the ellipsis button (...) next to the **Secondary Table** field, select **RM Open File**, and then select **OK**.
5. In the **Secondary Table Key** list, select **RM_OPEN_Key1**
6. Select the values in the **Primary Table** column that match the values in the **Secondary Table** column, and then select **OK**.
7. In the Table Relationship window, select **Close**.
8. In the Table Definition window, select **OK**.
9. Close the Tables window.

## Step 3: Modify the report

1. Select **Reports**.
2. If it's the first time that the "RM Statement on Blank Paper" report has been modified, follow these steps:
    1. In the **Original Reports** list, select **RM Statement on Blank Paper**.
    2. Select **Insert**.
    3. In the Modified Reports window, select **RM Statement on Blank Paper**.
    4. Select **1**.
3. Select **Tables**.
4. Select **RM Statements Transactions Temporary File**, and then select **New**.
5. Select **RM Open File**, and then select **OK**.
6. Close the Report Table Relationships window.

## Step 4: Create a conditional field

1. Select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
3. In the **Name** field, type Amount Remaining.
4. In the **Result Type** list, select **Currency**.
5. In the **Expression Type** area, select **Conditional**.
6. Select the **Fields** tab.
7. In the **Resources** list, select **RM Open File**.
8. In the **Field** list, select **RM Document Type-All**, and then select **Add**.
9. In the **Operators** area, select **>=**.
10. Select the **Constants** tab.
11. In the **Type** list, select **Integer**.
12. In the **Constant** box, type 7, and then select **Add**.
13. Select the **True Case** field, and then select the **Fields** tab.
14. In the **Resources** list, select **RM Open File**.
15. In the **Field** list, select **Current Trx Amount**, and then select **Add**.
16. In the **Operators** area, select *.
17. Select the **Constants** tab.
18. In the **Type** list, select **Currency**.
19. In the **Constant** box, type -1.00000, and then select **Add**.
20. Select the **False Case** field, and then select the **Fields** tab.
21. In the **Resources** list, select **RM Open File**.
22. In the **Field** list, select **Current Trx Amount**, and then select **Add**.

    > [!NOTE]
    > The **Expressions Calculated** field should contain the following formula.  
    > Conditional: RM_OPEN.RM Document Type-All >= 7  
    True Case: RM_OPEN.Current Trx Amount * -1.00000  
    False Case: RM_OPEN.Current Trx Amount

23. Select **OK**.

## Step 5: Add the calculated field to the RM Statement on Blank Paper report

1. In the Toolbox window, select **Calculated Fields** in the resource list.
2. Drag the **Amount Remaining** field to the **B** area of the report. The B area of the report is the body area of the report
3. Double-click the **Amount Remaining** field to open the Report Field Options window.
4. In the **Display Options** list, select **Visible**.
5. In the **Display Type** list, select **Data**.
6. In the **Format Field** area, select **RM Statement Transaction Temp**, and then select **OK**.

## Step 6: Exit Report Writer

1. Close the report. When you're prompted to save the changes, select **Save**.
2. In the Report Definition window, select **OK**.
3. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 7: Grant access to the "RM Statement on Blank Paper" report

**Method 1**: Use security in Microsoft Dynamics GP 10.0

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports.**
2. In the **ID** box, type the user ID of the user who will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the **Sales** folder.
6. Expand the folder for the report that you modified.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
10. In the **User** list, select a user ID.
11. In the **Company** list, select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, select the ID that you typed in step 2 earlier in this section.

**Method 2**: Use the Advanced Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the Advanced Security window, select **View**, and then select **By Alternate, Modified and Custom**.
4. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Sales**, and then expand the report that you modified.
6. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified).**
7. Select **Apply**, and then select **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

**Method 3**: Use the Standard Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the **User ID** list, select the ID of the user who you want to have access to the modified report.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Sales**.
6. In the **Access List** box, double-click the report that you modified, and then select **OK**.
    > [!NOTE]
    > An asterisk (*) appears next to the report name.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
