---
title: Billing documents show as applied
description: Provides a solution to an issue where billing documents from Project Accounting show as being fully paid and applied.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Billing documents from Project Accounting show as applied in Receivables Management but not in Project Accounting on Microsoft Dynamics GP

This article provides a solution to an issue where billing documents from Project Accounting show as being fully paid and applied.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2278974

## Symptom

When you inquire on the billing invoice in Receivables Management, the document shows as being fully paid and applied. However, when you view that same document in the Billings and Payments Inquiry within Project Accounting, it doesn't reflect the payment as having been applied. The value in the Receipts field in Project Maintenance  also may be understated.

## Cause

**Cause 1**: Security hasn't been given to the alternate windows for Project for the user who did the apply process. See [Resolution 1](#resolution-1).

**Cause 2**: The PABILLTRXT field isn't set to a value of 1 for the billing transaction in the PA01901. See [Resolution 2](#resolution-2).

**Cause 3**: The CURTRXAMT field in one or more billing tables is incorrect. See [Resolution 3](#resolution-3).

## Resolution 1

In order for the Project Accounting tables to be updated when an invoice and payment are applied, the user who is doing the applying must have access to the Apply Projects window in both Apply Sales Documents and Cash Receipts Entry. The Apply Projects window can be found by selecting the expansion arrow on the Apply Amount field in the Apply Sales Documents window.

Unapply the documents, grant security to the window, and then apply the documents again to make sure the Project tables are updated.

To ensure access has been granted to the Apply Projects window, use one of the following methods.

### Method 1 Use the Security tool in Microsoft Dynamics GP 10.0 or GP2010 (and higher versions)

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.

2. In the ID box, select the ID for the alternate form or for the alternate report.
    > [!NOTE]
    > The default ID is **DEFAULTUSER**.

3. In the Product list, select **Project Accounting**.

4. In the Type list, select **Windows**.

5. Expand the Sales folder.

6. Expand each folder.

7. Select **Project Accounting** for each folder.

8. Select **Save**.

9. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.

10. In the **User** box, select a user ID.

11. In the **Company** field, select the company.

12. In the Alternate/Modified Forms and Reports ID field, add the ID that you selected in step 2. It grants the user ID access to the alternate window so they can get to the Apply Projects window.

13. Select Save.  

### Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **System**, and then select **Advanced Security**. If you're prompted, type the system password.

2. Select the **View** box, and then select by **Alternate, Modified and Custom**.

3. Expand the following nodes, and then expand each window:

    - Project Accounting
    - Forms
    - Sales

4. Select **Project Accounting**.

5. Select **Apply**, and then select **OK**.

6. In the Product list, select **Project Accounting**.

### Method 3: Use the Standard Security tool in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you're prompted, type the system password.

2. In the Security Setup window, specify the following settings:

    - User ID: UserID
    - Company: CompanyName
    - Product: Project Accounting
    - Type: Alternate Dynamics GP windows
    - Series: Sales

3. Select **Mark All**.

4. Select **OK** to close the Security Setup window.

## Resolution 2

The PABILLTRXT field in the PA keys master (PA01901) table should always be a 1 for a billing document. If this value is something other than a 1, then use SQL to update it. Once that is completed, then use Apply Sales Documents to apply the billing invoice and payment together.

## Resolution 3

If the CURTRXAM (current transaction amount) field in the Project Billing Open tables has already been updated, when the payment is applied it won't apply at the project level. As a result, it will show as being applied in Receivables Management, but not Project Accounting. To correct it, use these steps.

1. Unapply the document using the Apply Sales Document window. Which should set the CURTRXAM field equal to the original document amount on the billing invoice.

2. Use SQL to verify that is the case by entering the invoice number in the following select statements.

    ```sql
    select PABillingAmount, CURTRXAM, PAOrigBillAmount, ORCTRXAM, * from PA23200 where PADocnumber20 = 'your billing#'
    
    select ORTRXAMT, CURTRXAM, ORORGTRX, ORCTRXAM, * from PA23201 where PADocnumber20 = 'your billing #'
    
    select ORTRXAMT, CURTRXAM, ORORGTRX, ORCTRXAM, * from PA23202 where PADocnumber20 = 'your billing #'
    
    select ORTRXAMT, CURTRXAM, ORORGTRX, ORCTRXAM, * from PA23203 where PADocnumber20 = 'your billing #'
    ```

    > [!NOTE]
    > In the above queries, the fields represent the following:
    >
    > PABillingAmount refers to the full amount of the invoice.  
    > ORTRXAMT refers to the full amount of the invoice.  
    > CURTRXAM refers to the amount of the invoice that still needs to be paid. Since Step 1 was to unapply the document, the value in this field should represent the full amount of the invoice.  
    > PAOrigBillAmount refers to the full amount of the invoice in originating currency amount.  
    > ORORGTRX refers to the full amount of the invoice in originating currency amount.  
    > ORCTRXAM refers to the amount of the invoice that still needs to be paid in originating currency amount. Since Step 1 was to unapply the document, the value in this field should represent the full amount of the invoice.

3. Use SQL to update the CURTRXAM amount as appropriate.

4. In Apply Sales Document, apply the payment to the invoice. Use the expansion arrow on the Apply Amount field to open the Apply Projects window to ensure that the project record has been updated. The Cost Cat. Apply Amount and/or Fee Apply Amount and Applied Amount fields should be updated with the value that has been applied.

## More information

When the above items are set correctly, and the document is applied in Receivables Management, then the PA23000 and PA23010 tables will be populated. These tables need to be populated for the Billings and Payment Inquiry window to be updated with the apply information. It also needs to be populated for the Receipts field in Project Maintenance to be updated.

If the apply records are in the PA23000 and PA23010 table, and the Receipts amount in Project Maintenance isn't correct, then run PA Reconcile on Cash Apply for the related customer. The PA Reconcile Utility is found on the Microsoft Dynamics GP Tools menu under Utilities, then Project.
