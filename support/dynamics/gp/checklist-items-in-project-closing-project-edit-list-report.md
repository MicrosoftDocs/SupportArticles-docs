---
title: Checklist items in Project Closing Edit List report
description: Contains information about the checklist items in the Project Closing Edit List report in Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Information about checklist items in the Project Closing Edit List report in Project Accounting in Microsoft Dynamics GP

This article contains information about the checklist items in the Project Closing Edit List report in Project Accounting in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. The report contains the following checklist items.

For more information about how to close a project without following the closing procedure, see [How To Close a Project Without Doing the Closing Procedure](https://support.microsoft.com/topic/how-to-close-a-project-without-doing-the-closing-procedure-ab03ebd7-517e-586e-df1f-fe870a60b1b3).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 940833

## General steps for each message

### Time and materials checklist

- All cost transaction posted

  No unposted / work cost transactions

- All transactions billed; Billings = Project Amount

  No unposted / work billing transactions  
  Actual Billings = Project Amount  
  Cost of Earnings = Actual Total Cost

- All biller documents applied or written off

  (Actual Receipts + Actual Write off + Actual Discount Taken Amount + Actual Discount Dollar Amount - Actual Write off Tax Amount - Actual Terms Taken Tax Amount) = Actual Billings

- All retainers applied or refunded

  Account Amount = 0.00

- All cost of revenues recognized

  Actual Total Cost = Cost of Earnings

- All Purchases received and matched or canceled

  Work / HIST POs must not have a Line Status of Released, Change Order, Received  
  No records in table PA_PO_ReceiptLine for the specified project  
  If there are no POs attached, Quantities shipped = Quantities invoiced

- All revenues recognized; Earnings = Project Amount

  Earnings = Project Amount  
  If When Billed, Actual Total Cost = Cost of Earnings

### Cost plus/fixed price checklist

- All cost transaction posted

  No unposted / work cost transactions

- All transactions billed; Billings = Project Amount

  No unposted / work billing transactions  
  Actual Billings = Project Amount

- All biller documents applied or written off

  (Actual Receipts + Actual Write off + Actual Discount Taken Amount + Actual Discount Dollar Amount - Actual Write off Tax Amount - Actual Terms Taken Tax Amount) = Actual Billings

- All retainers applied or refunded

  Account Amount = 0.00

- All cost of revenues recognized

  Actual Recognized Revenue = Project Amount  
  Actual Total Cost = Cost of Earnings

- All Purchases received and matched or canceled

  Work / HIST POs must not have a Line Status of Released, Change Order, Received  
  No records in table PA_PO_ReceiptLine for the specified project  
 If there are no POs attached, Quantities shipped = Quantities invoiced

- All revenues recognized; Earnings = Project Amount; all BEE / EEB adjustments done

  Actual Recognized Revenue = Project Amount  
  Actual BIEE Amount = 0; Actual EIEB Amount = 0 per each Cost Category on the Project.  
  Actual Total Cost = Cost of Earnings

- All receivables retentions billed

  All cost transactions posted checkbox must be marked  
  All retentions must be billed and posted or Actual Retention Amount of Project Master = Actual Billed Retention of the retention fee in Project Fee Totals Master

> [!NOTE]
>
> 1. Recognized Revenues/BIEE/EIEB are all updated in the Revenue Recognition Entry window.
>
> 2. Cost of Earnings or Cost of Revenues are updated in Cost Transactions if TM: When Performed; in Billing Entry if TM: When Billed; in Revenue Recognition Entry if CP/FP: Cost to Cost/Eff. Expended/ Completed

## Detailed resolution steps for each message

### All cost transactions posted

This item verifies that all cost transactions that have been entered have also been posted. If this item check box is unmarked, follow these steps:

1. Open the following inquiry windows to determine which transactions prohibit the closing.

    > [!NOTE]
    > Transactions that are unposted prohibit the closing.

    Timesheet-Detail

    - On the **Inquiry** menu, point to **Project**, point to **PA Transaction Documents**, and then select **Timesheet-Detail**.
    - Select the **Unposted** option. Then, select **Redisplay**.
    - Restrict by project.

    Equipment Log-Detail

    - On the Inquiry menu, point to Project, point to PA Transaction Documents, and then select Equipment Log-Detail.
    - Restrict by project.
    - Select the **Unposted** option. Then, select **Redisplay**.

    Miscellaneous Log-Detail

    - On the **Inquiry** menu, point to **Project**, point to **PA Transaction Documents**, and then select **Miscellaneous Log-Detail**.
    - Restrict by project.
    - Select the **Unposted** option. Then, select **Redisplay**.

    Employee Expense-Detail

    - On the **Inquiry** menu, point to **Project**, point to **PA Transaction Documents**, and then select **Employee Expense-Detail**.
    - Restrict by project.
    - Select the **Unposted** option. Then, select **Redisplay**.

    Inventory Transfer-Detail

    - On the **Inquiry** menu, point to **Project**, point to **PA Transaction Documents**, and then select **Inventory Transfer-Detail**.
    - Restrict by project.
    - Select the **Unposted** option. Then, select **Redisplay**.

    Purchases Materials

    - On the **Inquiry** menu, point to **Project**, point to **PA Transaction Documents**, and then select **Purchases Materials**.
    - Restrict by project.
    - Select the **Unposted** option. Then, select **Redisplay**.

2.  After you determine which transactions prohibit the closing, open the appropriate batch window or series post. Then, post the transactions. If the transactions should not be included in the actual cost of the project, you would choose to delete them, so their costs are not posted.

3.  If all cost transactions have been posted or deleted, and if this item check box is still unmarked, reconcile cost transactions for the customer associated with this project. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, select **PA Reconcile**, and then select **Cost Transactions**.

### All transactions billed; Billings = Project Amount

This item verifies that all billing transactions have been posted. If this item check box is unmarked, follow these steps:

1. Follow these steps:
   1. In the Inquiry window, point to **Project**, point to **PA Transaction Documents**, and then select **Billed Projects**.
   2. Restrict by project.
   3. Select the **Work** check box. Then, select **Redisplay**.
2. After you determine which transactions are not posted, post the transactions in either the Billing Batches window or the Series Posting window.
3. If all billing transactions have been posted, and if this item check box is still unmarked, reconcile billing transactions for the customer associated with this project. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, select **PA Reconcile**, and then select **Billing Transactions**.
4. On the **Cards** menu, point to **Project**, and then select **Project**.
5. In Project Maintenance, verify that the amount that is in the **Billings To Date** field is equal to the amount that is in the **Project Amount** field. If it is necessary, adjust the forecast budget values or the fee amounts to correct the project amount to equal what has been billed.

### All biller documents applied or written off

This item verifies that all billing documents have been paid or have been correctly written off. If this item check box is unmarked, follow these steps:

1. Open the Billings and Payments Inquiry window to see which document must be paid or must be written off. To do this, select **Inquiry**, point to **Project**, point to **PA Transaction Documents**, and then select **Billings and Payments**.
2. Follow these steps:

    - Enter the project number in the **Project Number** field.
    - Select **Redisplay**.
    - Select each billing document. Make sure that the amount in the **Amount Due** field at the bottom of the window is $0 (zero). Also, make sure that the correct payment information populates the **Payments** area.

3. Verify that the user has access to the alternate window for applying sales documents.

**Why is this step important?**

Consider the following scenario. Project Accounting shows that the document is not applied. However, Receivables Management shows that the document is applied. In this scenario, the user who applied the payment to the invoice in Receivables Management did not have the required access to the alternate window. To correct these documents, you must unapply the document and then reapply the document in Receivables Management. To follow this step, you must have access to the required windows to update the Project Accounting apply information.

To do check this, use the follow steps:

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, select **User Security.**
2. In the **ID** field, type the user ID.
3. Select the corresponding **Company**.
4. At the bottom of the window, select the underlined **Alternate Modified Forms and Reports** link, which you will open a new window.
5. In the **Product** list, select **Project Accounting**.
6. In the **Type** list, select **Windows**.
7. Expand the **Sales** node, expand the **Apply Sales Documents** node, and then make sure that the option for **Project Accounting** is selected.
8. After you have verified security, open the **Apply Sales Documents** window. To do this, on the Transactions menu, point to **Sales**, and then select **Apply Sales Documents**.
9. Apply or write off the documents from step 2 that you determined were not applied correctly or were written off.
10. If all transactions have been applied, and if the checklist item is still unmarked, reconcile cash apply for the customer associated with this project. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, select **Project**, point to **PA Reconcile**, and then select **Cash Apply**.

### All retainers applied or refunded

This item verifies that the retainer either has been applied to invoices or has been refunded to the customer. If this item check box is unmarked, follow these steps:

1. In the Project Maintenance window, verify the **On Account** amount.
2. On the **Cards** menu, point to **Project**, and then select **Project**.
3. Select the project.
4. If there is an amount in the **On Account** field for the project, you must enter an additional billing invoice, and then apply the retainer to the invoice.

   If the billing amount for the project does not require correction, you may have to return or adjust an existing billing document so that you are not overstating your billing amount.

### All cost of revenues recognized

This item verifies that the accumulated cost of all revenues has been correctly recognized. If this item check box is unmarked, follow these steps:

1. In the **Project Inquiry** window, compare the amount in the **Total Costs Incurred** field and in the **Cost of Revenues** field.
2. On the **Inquiry** menu, point to **Project**, and then select **Project**.
3. Select the project.
4. If any values are incorrect, reconcile the earnings and the cost of earnings for the customer. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, select **PA Reconcile**, and then select **Earnings and Cost of Earnings**.
5. If this project has a type of **Fixed Price** or **Cost Plus**, run the Revenue Recognition procedure. To do this, follow these steps:
   1. On the **Transactions** menu, point to **Project**, point to **Billing**, and then select **Revenue Recognition**.
   2. Verify that there are distributions. Then, post the distributions.
   3. If step a and step b do not resolve the issue, run the PA Reconcile Periodic procedure for this customer, and then run Revenue Recognition again. To run the PA Reconcile Periodic procedure, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, and then select **PA Reconcile Periodic**.

### All Purchases received and matched or canceled

This item verifies either that all purchase orders have been received and invoiced or that all purchase orders have been canceled. If this item check box is unmarked, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
2. Print the Purchase Order Status report for a range that includes this project only. Verify that no line items have a status of **Released**, of **Change Order**, or of **Received**.
3. If you find line items with a status of **Released**, of **Change Order**, or of **Received**, receive and invoice the line items. Otherwise, cancel the line items.
4. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
5. Print the Received/Not Invoiced report. If any printed line items relate to this project, these line items must be invoiced.

> [!NOTE]
> To receive or to invoice a purchase order, point to **Purchasing** on the **Transactions** menu, and then select **Receivings Transaction Entry** or **Enter/Match Invoices**.  
> To cancel a purchase order, point to **Purchasing** on the **Transactions** menu, and then select **Edit Purchase Orders**.

### All revenues recognized; Earnings = Project Amount

This item verifies that revenues have been correctly recognized and that the BIEE and EIEB are 0 for each individual budget on the project.  If this item check box is unmarked, follow these steps:

1. On the **Inquiry** menu, point to **Project**, and then select **Project**.
2. Enter the project number.
3. Compare the amount that is in the **Revenues Earned** field to the amount that is in the **Billed to Date** field in the Project Inquiry window for each individual Cost Category/Budget.
4. Compare the amount that is in the **Billed to Date** field to the amount that is in the **Project amount** field. If the amount that is in the **Project amount** field is incorrect, you may have to make adjustments to forecasts.
5. If any amounts that appear in step 2 or in step 3 are incorrect, reconcile the earnings and the cost of earnings for the customer. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, select **PA Reconcile**, and then select **Earnings and Cost of Earnings**.

### All revenues recognized; Earnings = Project Amount; all BEE / EEB adjustments done

This item verifies that revenues have been correctly recognized and that the BIEE and EIEB are 0 for each individual budget on the project. If this item check box is unmarked, follow these steps:

1. On the **Inquiry** menu, point to **Project**, and the select **Project**.
2. Enter the project number.
3. Compare the amount that is in the **Revenues Earned** field to the amount that is in the **Billed to Date** field in the Project Inquiry window for each individual Cost Category/Budget.
4. Compare the amount that is in the **Billed to Date** field to the amount that is in the **Project amount** field. If the amount that is in the **Project amount** field is incorrect, you may have to make adjustments to forecasts.
5. These three fields should be equal. If any amounts that appear in step 2 or in step 3 are incorrect, reconcile the earnings and the cost of earnings for the customer. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, select **PA Reconcile**, and then select **Earnings and Cost of Earnings**.
6. If the project has a project type of **Fixed Price** or of **Cost Plus**, run Revenue Recognition. To do this, point to **Project** on the **Transactions** menu, point to **Billing**, and then select **Revenue Recognition**.
7. Post the distributions. If the check box for this item is still unmarked, follow these steps:
8. Run the PA Reconcile procedure for the customer. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, and then select **PA Reconcile Periodic**.
9. Repeat step 5 to run Revenue Recognition again.

### All receivables retentions billed

This item verifies that all retention fees have been billed for this project. If this item check box is unmarked, follow these steps:

1. Make sure that the project has a status of **Completed**.
2. Create a final billing for this project.
3. Create an invoice to bill the remaining retention fee. To do this, point to **Project** on the **Transactions** menu, point to **Billing**, and then select **Billing Entry**.

> [!NOTE]
>
> 1. Recognized Revenues/BIEE/EIEB are all updated in the Revenue Recognition Entry window.
>
> 2. Cost of Earnings or Cost of Revenues are updated in Cost Transactions if TM: When Performed; in Billing Entry if TM: When Billed; in Revenue Recognition Entry if CP/FP: Cost to Cost/Eff. Expended/ Completed
