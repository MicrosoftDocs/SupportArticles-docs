---
title: Modify the SOP Blank Invoice Form or the SOP Blank Order Form
description: Describes how to add the Credit Card Number information from Sales Payment Entry to the SOP Blank Invoice Form or to the SOP Blank Order Form.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to modify the SOP Blank Invoice Form or the SOP Blank Order Form in Report Writer to include the Credit Card Number information from the Sales Payment Entry window

This article describes how to modify the Microsoft Business Solutions - Great Plains Sales Ordering Processing (SOP) SOP Blank Invoice Form or the SOP Blank Order Form in Report Writer to include the Credit Card Number information in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850166

## Introduction

If you want to include the credit card number on the SOP Blank Invoice Form or on the SOP Blank Order Form, you can't have Serial/Lot information on the same form.

## More information

To modify the SOP Blank Invoice Form or the SOP Blank Order Form in Report Writer, follow these steps:

1. Open Report Writer:

    - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, select **Tools**, select **Customize**, and then select **Report Writer**.

    - In Microsoft Business Solutions - Great Plains 8.0 and in Microsoft Dynamics GP 9.0, select **Tools**, point to **Customize**, and then select **Report Writer**.

2. Create the relationship between the Sales Transaction Amounts Work and the Sales Payment Work and History tables:
    1. Select the **Tables** menu, and then select **Tables** from the drop-down list.
    2. Select **SOP_LINE_WRK** from the list of tables, and then select **Open**.
    3. In the **Table Definition** window, select **Relationships**.
    4. In the **Table Relationship** window, select **New**.
    5. Select the ellipsis button, select **Sales Payment Work and History** from the drop-down list, and then select **OK**.
    6. Select **SOP_Payment_WORK_HIST_Key1** from the **Secondary Table Keys** list.
    7. In the **Primary Table** drop-down list, select **SOP Type**, select the **SOP Number** fields, and then select **OK**. Leave the third drop-down list value blank.
    8. Select **OK** or the Close button to close all windows.

3. Replace the Sales Serial/Lot Work and History table with the Sales Payment Work and History table:
    1. On the **Reports** menu, select **SOP Blank Invoice Form/SOP Blank Order Form** from the list of original reports, and then select **Insert**.
    2. Select **SOP Blank Invoice Form/SOP Blank Order Form** from the list of modified reports, and then select **Open**.
    3. In the **Report Definition** window, select **Tables**.
    4. In the **Report Table Relationships**, select the **Sales Serial/Lot Work and History** table, and then select **Remove**.
    5. Select **OK** when you're prompted.
    6. Select the **Sales Transaction Amounts Work** table, and then select **New**.
    7. From the list of **Related Tables**, select **Sales Payment Work and History**, and then select **OK**.
    8. Select **OK** to close the window and return to the **Report Definition** window.

4. Remove the Serial/Lot restriction and create a new restriction that involves the Sales Payment Work and History table:
    1. In the **Report Definition** window, select **Restrictions**.
    2. In the **Report Restrictions** windows, select the **Type and Number of SOP_Serial_Lot = self** restriction, and then select **Delete**.
    3. Select **New** to create a new restriction.
    4. Type Dummy as the name for the restriction.
    5. Select **Sales Payment Work and History** and **Report Table and Amount Paid** as the **Table Field**.
    6. Select **Add Field**.
    7. Select the **=** button.
    8. Select **Amount Paid** as the **Table Field**, and then select **Add Field**. The Restriction Expression should now resemble the following example:  
        **SOP_Payment_WORK_HIST.AmountPaid = SOP_Payment_WORK_HIST.AmountPaid**  
    9. Select **OK** or the **Close** button to close all windows, and then go back to the **Report Definition** window.

5. Remove any instances of the Serial/Lot Work and History table in the layout of the report:
    1. Select **Layout**.
    2. Remove the **Serial/Lot Number** field and the **(C) Serial/Lot Quantity** field in the **B** section of the report.
    3. In the toolbox, select **Calculated Fields** from the drop-down list.
    4. Select **(C) Serial Lot Band** from the list of calculated fields, and then select **Open**.
    5. Set **Integer** as the **Result Type**.
    6. In the **Calculated Expression**, select the **SOP_Serial_Lot_WORK_HIST.Serial/Lot Number** expression, and then select **Remove**.
    7. On the **Constants** tab, select **Integer** as the **Type**, and then select **0** as the **Constant**.
    8. Select **Add**.
    9. Select **OK** to save the **Calculated Field**.
    10. Select **(C) Serial Lot Quantity** from the list of calculated fields, and then select **Open**.
    11. Set **Integer** as the **Result Type**, and then select **Calculated** as the **Expression Type**.
    12. Select **Yes** when you're prompted.
    13. Remove everything in the **Calculated Expression** section of the report by highlighting the fields and then selecting **Remove**.
    14. On the **Constants** tab, select **Integer** as the **Type**, and then **0** as the **Constant**.
    15. Select **Add**.
    16. Select **OK**.

6. Add the required fields into the report layout:
    1. In the toolbox, select **Sales Payment Work and History** from the drop-down list.
    2. Select **Receipt Number Credit Card** from the list of fields.
    3. Drag the **Receipt Number Credit Card** field to the **H2** section on the report.
    4. Double-click the **Receipt Number Credit Card** field to open the **Report Field Options** window.
    5. Under **Visibility**, select **Hide When Empty**, and then select **Display Type** as **Data** value.
    6. Select **OK**.
    7. Save the changes to your report.

After you save the report, you'll have to assign security permissions to the modified report to use the report in Microsoft Dynamics GP. To assign security permissions to the modified report, use one of the following methods.

## Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.

2. In the **ID** box, type the user ID that will print this modified report.

3. In the **Product** list, select **Microsoft Dynamics GP**.

4. In the **Type** list, select **Reports**.

5. Expand the **Sales** folder and then expand the folder that contains the report that you modified.

6. Select the **Microsoft Dynamics GP (Modified)** report.

7. Select **Save**.

8. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.

9. In the **User** list, select a user ID that will print this modified report.

10. In the **Company** list, select a company.

11. In the **Alternate/Modified Forms and Reports ID** list, select the ID that you used in step 2.

## Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.

3. In the **Advanced Security** window, select **View**, and then select **By Alternate, Modified and Custom**.

4. Select the modified report:

    For Microsoft Dynamics GP 9.0:

      1. Expand **Microsoft Dynamics GP**, expand **Reports**, expand **Sales**, and then expand the folder that contains the report that you modified.

      2. Select the **Microsoft Dynamics GP (Modified)** report.

    For Microsoft Business Solutions - Great Plains 8.0:

      1. Expand **Great Plains**, expand **Reports**, expand **Sales**, and then expand the folder that contains the report that you modified.

      2. Select the **Great Plains (Modified)** report.

5. Select **Apply**, and then select **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0 will select the current user and the current company. Any changes that you make will affect the current user and the current company. However, you can select additional users in the **Users** area of the **Advanced Security** window. You can select additional companies in the **Company Name** area of the **Advanced Security** window.

## Method 3: Use the Standard Security tool in a version earlier than Microsoft Business Solutions - Great Plains 8.0

> [!NOTE]
> An asterisk (*) will appear next to the report name.

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.

3. In the **User ID** list, select the ID of the user or users that you want to have access to the modified report.

4. In the **Type** list, select **Modified Reports**.

5. In the **Series** list, select **Sales**.

6. In the **Access List** box, double-click the report that you modified, and then select **OK**.
