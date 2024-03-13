---
title: How to add employee name to Checkbook Register Report
description: Introduces how to add the employee name to the Checkbook Register Report in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add the employee name to the Checkbook Register Report in Microsoft Dynamics GP

This article describes how to add the employee name to the Checkbook Register Report in Microsoft Dynamics GP. To do this, replace the Payroll Check field with the Employee Name field in the Checkbook Register Report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865514

## More information

To change the Checkbook Register Report in Report Writer so that the Employee name field replaces the Payroll check field, follow these steps.

> [!NOTE]
> In many business practices, the accounting administrator may not want the individual in charge of Bank Reconciliation to see how much other employees are earning. If the employee name was displayed in Bank Reconciliation for each payroll check, employee confidentiality would be lost.

### Step 1 - Open Report Writer

1. On the **Microsoft Dynamics GP** menu, select **Tools**, point to **Customize**, and then select **Report Writer**.
2. In the **Product** list, select **Microsoft Dynamics GP**.
3. Select **OK**.

### Step 2 - Create a table relationship between the CM Transaction table and the Payroll Check History table

1. Select **Tables**, and then select **Tables**.
2. Select **CM_Transaction**, and then select **Open**.
3. Select **Relationships**, and then select **New**.
4. Select the Secondary Table ellipsis button (...), select **Payroll Check History**, and then select **OK**.
5. In the **Secondary Table Key** list, select **UPR_Check_HIST_Key1**.
6. In the **Primary Table** column list, select **Audit Trail Code** to match to the Audit Trail Code field.
7. In the **Primary Table** column list, select **CM Trx Number** to match to the CM Trx Number field.
8. Select **OK**.
9. Close the Table Relationship window.
10. In the **Table Definition** window, select **OK**, and then close the Tables window.

### Step 3 - Open the report

1. Select **Reports**.
2. In the **Original Reports** pane, select **Checkbook Register**, and then select **Insert**.
3. In the **Modified Reports** pane, select **Checkbook Register**, and then select **Open**.
4. Select **Tables**.
5. Select **CM Transaction**, and then select **New**.
6. Select **Payroll Check History**, and then select **OK**.

### Step 4 - Add a restriction

1. Select **Restrictions**, and then select **New**.
2. In the **Report Restriction Definition** window, type Payroll in the **Restriction Name** field.
3. In the **Report Table** list, select **Payroll Check History**.
4. In the **Table Fields** list, select **Employee Name**.
5. Select **Add Field**.
6. In the **Operators** area, select the Equality operator button (=).
7. Select **Add Field**.
   > [!NOTE]
   > The restriction should resemble the following:UPR_Check_HIST.EmployeeName = UPR_Check_HIST.EmployeeName
8. Select **OK**.
9. Close the Report Restrictions window.

### Step 5 - Create a calculated field

1. Select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
3. Select **New**.
4. In the **Name** field, type *Paid To*.
5. In the **Result Type** list, select **String**.
6. In the **Expression Type** area, select **Conditional**.
7. Select the **Fields** tab, select **CM Transaction** in the **Resources** list, select **Source Document** in the **Field** list, and then select **Add**.
8. Select the Equality operator button (=).
9. On the **Constants** tab, select **String** in the **Type** list, type UPRCC in the **Constant** field, and then select **Add**.
10. Select the **True Case** box, select **Payroll Check History** in the **Resources** list.
11. Select the **Fields** tab.
12. In the **Field** list, select **Employee Name**, and then select **Add**.
13. Select the **False Case** box, select the **Fields** tab, select **CM Transaction** in the **Resources** list, select **Paid ToRcvd From** in the **Field** list, and then select **Add**.

    > [!NOTE]
    > The expression should resemble the following:  
    > Conditional: SM_Transaction.Source Document = "UPRCC"  
    > True Case: UPR_Check_HIST.Employee Name  
    > False Case: CM_Transaction.Paid ToRcvd From

14. Select **OK** to save the new field.

### Step 6 - Add the new field to the report

1. In the Toolbox window, select **Paid To** in the resource list, and then drag **Paid To** to the B section of the report.
2. Remove the Paid ToRcvd From field from the report.
3. Close the report. Select **Save** when you are prompted to save your changes.

### Step 7 - Grant security to the report

#### Use security in Microsoft Dynamics GP

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the alternate or modified forms and reports ID that is associated with the user who will print this changed report.

   This ID is the ID that is assigned to the user in the User Security Setup window. To open the User Security Setup window, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **User Security**.

3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand **Financial**.
6. Expand the folder for the **Checkbook Register** report.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
10. In the **User** list, select a user ID.
11. In the **Company** list, select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, select the ID that you typed in step 2 of this section.
