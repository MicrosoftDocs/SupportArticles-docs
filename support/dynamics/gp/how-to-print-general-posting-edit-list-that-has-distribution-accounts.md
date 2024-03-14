---
title: Print General Posting Edit List with distribution accounts
description: Explains how to print the General Posting Edit List with distribution accounts for variable and fixed allocation accounts in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# How to print a General Posting Edit List that includes distribution accounts for variable and fixed allocation accounts in Microsoft Dynamics GP

This article describes how to use Report Writer in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0 to print a General Posting Edit List that includes distribution accounts for variable and fixed allocation accounts.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 931452

You can use Report Writer in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0 to print a General Posting Edit List that has distribution accounts for variable and fixed allocation accounts. To do this, add the General Posting Edit List to the report, create new fields, and then add the fields to the report.

## Step 1 - Back up the report

If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
   2. Type the system password if you are prompted.
   3. If you are using Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.

      If you are using Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.

   4. Note the path that appears in the **Reports** box.
   5. Select **OK** to close the Edit Launch File window.

## Step 2 - Add tables and sort definitions to the report

1. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. If you are using Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.

   If you are using Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

3. Select **Reports**.
4. In the **Original Reports** area, select **General Posting Edit List**, and then select **Insert**.
5. In the **Modified Reports** area, select **General Posting Edit List**, and then select **Open**.
6. In the Report Definition window, select **Tables**.
7. Select **Allocation Amounts Temporary**, select **New**, select **Account Master**, and then select **OK**.
8. Select **Account Master**, and then select **New**.
9. Select **Variable Allocation Master** or **Fixed Allocation Master**, and then select **OK**.
10. Select **Close**.
11. In the Report Definition window, select **Sort**.
12. In the Sorting Definition window, select **Posting Definitions Master** in the **Report Table** list, select **Batch Number** in the **Table Fields** list, and then select **Insert**.

    > [!NOTE]
    > In the **Sort By** list, select the sort definition that you added before you insert the next sort definition. When you do this, the next sort definition is inserted under the first sort definition that you added.

13. In the **Report Table** list, select **Transaction Work**, select **Journal Entry** in the **Table Fields** list, and then select **Insert**.
14. In the **Report Table** list, select **Allocation Amounts Temporary**, select **Sequence Line** in the **Table Fields** list, and then select **Insert**.
15. In the **Report Table** list, select **Account Master**, select **Account Index** in the **Table Fields** list, and then select **Insert**.
16. In the **Report Table** list, select **Variable Allocation Master** or **Fixed Allocation Master**, select **Distribution Account Index** in the **Table Fields** list, and then select **Insert**.
17. In the **Report Table** list, select **Posting Definitions Master**, select **Batch Number** in the **Table Fields** list, and then select **Insert**.
18. Select **OK** to close the Sorting Definition window.

## Step 3 - Create a calculated field and a conditional field

1. Select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
3. In the **Name** field, type *Account Index Blank*.
4. In the **Result Type** list, select **Integer**.
5. In the **Expression Type** area, select **Calculated**.
6. Select the **Constants** tab, select **Integer** in the **Type** list, select **Add**, and then select **OK**.
7. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
8. In the **Name** field, type *Distribution Account*.
9. In the **Result Type** list, select **Integer**.
10. In the **Expression Type** area, select **Conditional**.
11. Select the **Fields** tab.
12. In the **Resources** list, select **Account Master**.
13. In the **Field** list, select **Fixed or Variable**, and then select **Add**.
14. In the **Operators** area, select **=**.
15. Select the **Constants** tab, select **Integer** in the **Result Type** list, and then select **Add**.
16. Select the **True Case** box, select the **Constants** tab, select **Integer** in the **Type** list, and then select **Add**.
17. Select the **False Case** box, select the **Constants** tab, and then select **Integer** in the **Type** list. In the **Constant** field, type *1*, and then select **Add**.

    > [!NOTE]
    > The following expression appears:
    >
    > Conditional: GL_Account_MSTR.Fixed or Variable = 0
    >
    > True Case: 0
    >
    > False Case: 1

18. Select **OK** to close the Calculated Field Definition window.

## Step 4 - Create a calculated field

1. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
2. In the **Name** field, type *Get Dist Account Num*.
3. In the **Result Type** list, select **String**.
4. In the **Expression Type** area, select **Calculated**.
5. Select the **Functions** tab, and then select **User-Defined**.
6. In the **Core** list, select **Financial**.
7. In the **Function** list, select **RW_AccountNumber**.
8. Select **Add**, and then select the **Fields** tab.
9. In the **Resources** list, select **Variable Allocation Master** or **Fixed Allocation Master**.
10. In the **Field** list, select **Distribution Account Index**.
11. Select **Add**.

    > [!NOTE]
    > The following expressions appear:
    >
    >  - Calculated: FUNCTION_SCRIPT(RW_AccountNumberGL_Allocation_Variable_MSTR.Distribution Account Index )
    >  - Calculated: FUNCTION_SCRIPT(RW_AccountNumberGL_Allocation_Fixed_MSTR.Distribution Account Index )

12. Select **OK** to close the Calculated Field Definition window.

## Step 5 - Create another calculated field

1. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
2. In the **Name** field, type *Get Dist Account Desc*.
3. In the **Result Type** list, select **String**.
4. In the **Expression Type** area, select **Calculated**.
5. Select the **Functions** tab, and then select **User-Defined**.
6. In the **Core** list, select **Financial**.
7. In the **Function** list, select **RW_AccountDescription**.
8. Select **Add**, and then select the **Fields** tab.
9. In the **Resources** list, select **Variable Allocation Master** or **Fixed Allocation Master**.
10. In the **Field** list, select **Distribution Account Index**.
11. Select **Add**.

    > [!NOTE]
    > The following expressions appear:
    >
    >  - Conditional: FUNCTION_SCRIPT(RW_AccountDescriptionGL_Allocation_Variable_MSTR.Distribution Account Index )
    >  - Conditional: FUNCTION_SCRIPT(RW_AccountDescriptionGL_Fixed_Variable_MSTR.Distribution Account Index )

12. Select **OK** to close the Calculated Field Definition window.

## Step 6 - Add headers

1. Select **Tools**, and then select **Section Options**.
2. Create a variable account header. To do this, follow these steps:

   1. In the Report Section Options window, select **Currency ID**, and then select **New**.
   2. In the **Header Name** field, type *Variable Account or Fixed Account*.
   3. In the **Report Table** list, select **Account Master**.
   4. In the **Field** list, select **Account Index**.
   5. Select to select the **Suppress When Field is Empty** check box, select **Account Index Blank** in the **Calculated Field** list, and then select **OK**.
3. Create a distribution account header. To do this, follow these steps:

   1. In the Report Section Options window, select **Variable Account** or **Fixed Account**, and then select **New**.
   2. In the **Header Name** field, type *Distribution Account*.
   3. In the **Report Table** list, select **Variable Allocation Master** or **Fixed Allocation Master**.
   4. In the **Field** list, select **Distribution Account Index**.
   5. Select to select the **Suppress When Field is Empty** check box, select **Distribution Account** in the **Calculated Field** list, and then select **OK**.
   6. Select **OK** to close the Report Section Options window.

## Step 7 - Add the new fields to the report

1. In the Toolbox window, select **Calculated Field** in the resource list, and then select **Account Index Blank**.
2. Drag the **Account Index Blank** field to the **H4** section of the report.
3. Double-select **Account Index Blank** in the report, select **Invisible** in the **Visibility** list, and then select **OK**.
4. In the Toolbox window, select **Calculated Field** in the resource list, and then select **Distribution Account**.
5. Drag the **Distribution Account** field to the **H5** section of the report.
6. In the report, double-select **Distribution Account**, select **Invisible** in the **Visibility** list, and then select **OK**.
7. In the Toolbox window, select **Calculated Field** in the resource list, and then select **Get Dist Account Num**.
8. Drag the **Get Dist Account Num** field to the **H5-Distribution Account** section of the report.
9. In the Toolbox window, select **Calculated Field** in the resource list, and then select **Get Dist Account Desc**.
10. Drag the **Get Dist Account Desc** field to the **H5-Distribution Account** section of the report.

## Step 8 - Save the modified report

1. Close the report. Select **Save** when you are prompted to save your changes.
2. In the Report Definition window, select **OK**.
3. If you are using Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.

   If you are using Microsoft Business Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 9 - Assign security permissions to the modified report

Use either of the following methods to assign security permissions to the modified report.

### Method 1 - Use Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

    > [!NOTE]
    > Type the system password if you are prompted.

2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. If you are using Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

   If you are using Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
4. Expand the following nodes:
   - **Reports**
   - **Financial**
   - **General Posting Edit List**
5. If you are using Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.

   If you are using Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
6. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. And, you can select additional companies in the **Company** area of the Advanced Security window.

### Method 2 - Use Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > Type the system password if you are prompted.

2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Financial**.
5. In the **Access List** box, double-select **General Posting Edit List**, and then select **OK**.

    > [!NOTE]
    > After you select **OK**, an asterisk (*) appears next to the report name.
