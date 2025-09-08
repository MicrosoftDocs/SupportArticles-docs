---
title: How manual payments, credit memos appear
description: Describes how manual payments, credit memos, and returns appear on the Payables Management check stub.
ms.reviewer: theley, lmuelle
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# Information about how manual payments, credit memos, and returns appear on the check stub when you run the Select Checks process in Microsoft Dynamics GP

This article describes how manual payments, credit memos, and returns appear on the Payables Management check stub.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860395

## Introduction

This article also describes when the manual payments, credit memos, and returns are removed from the PM20000 table and from the PM20100 table when you run the **Select Checks** process to pay outstanding vendor invoices in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

## More information

The Payables Management check stub displays the following information:

- Invoices that are paid by a manual payment, a credit memo, or a return are displayed with a $0 remittance amount.
- Manual payments, credit memos, and returns are displayed with a negative value and with a $0.00 remittance amount.
- Invoices that are paid by a check are displayed with the appropriate remittance amount.

Manual payment, credit memo, and return information isn't printed on the computer check posting journal reports. During the posting process, the following vendor records are removed from the PM20000 (PM Transaction Open File) table and from the PM20100 (PM Apply To OPEN OPEN Temporary File) table:

- Invoices that are paid in full during the **Select Checks** process
- Manual payments, credit memos, and returns that are applied to invoices
- Invoices that are paid in full by manual payments, credit memos, and returns

The following example shows how manual payments, credit memos, and returns are displayed on the Payables Management check stub. The following example also shows when records are removed from the PM20000 table and from the PM20100 table during the **Select Checks** process.

For manual payments, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.

2. Type a vendor ID in the **Vendor ID** list, and then create an invoice.

3. Post the invoice. When you post the invoice, a record is created in the PM20000 (PM Transaction Open File) table.

4. On the **Transactions** menu, point to **Purchasing**, and then select **Manual Payments**.

5. Type a vendor ID in the **Vendor ID** list, and then create a manual payment for the same vendor and for the same value as in step 2.

6. In the Payables Manual Payment Entry window, select **Apply**, and then apply the payment to the invoice that you created in step 2.

7. Post the manual payment. When you post the manual payment, the following actions occur:
   - The invoice record is removed from the PM20000 (PM Transaction Open File) table.
   - A manual payment record is created in the PM20100 (PM Apply To OPEN OPEN Temporary File) table with the **Key Source** field equal to **REMITTANCE**.
   - The invoice record and the payment record are created in the PM30200 (PM Paid Transaction History File) table.
   - An apply record is created in the PM30300 (PM Apply To History File) table.

8. On the **Inquiry** menu, point to **Purchasing**, and then select **Transactions by Vendor**.

9. Select the appropriate vendor in the **Vendor ID** list. The payment and the invoice display the value **HIST** in the **Origin** field.

10. On the **Transactions** menu, point to **Purchasing**, and then select **Select Checks**.

11. Type a batch ID in the **Batch ID** field.
12. Restrict the **Select Payables Checks** process to the vendor from step 2.

13. In the Select Payables Checks window, select **Build Batch**. The **Build Batch** process creates a new record in the PM20100 (PM Apply To OPEN OPEN Temporary File) table for the invoices that are selected for the **Select Checks** process.

    When the batch is created, the **Payment_To_Print_On_Stub** field in the PM20100 table is populated with the voucher number that is used to create the check batch.
14. After the batch is created, select **Print Checks** to begin the check printing process.

15. In the Print Payables Checks window, select **Print** to print the checks. The check stub displays the following information:

    - The invoice that was paid by the manual payment is displayed with a $0 remittance amount.
    - The manual payment is displayed with a negative value and with a $0.00 remittance amount.
    - Invoices that are paid by the check are displayed with the appropriate remittance amount.

16. After the check is printed, the Post Payables Checks window opens. Select **Process** to post the checks. The posting journals print the distributions for invoices paid by the checks. Manual payment information doesn't print on the posting journals.

17. During the posting process, the following vendor records are removed from the PM20000 (PM Transaction Open File) table and from the PM20100 (PM Apply To OPEN OPEN Temporary File) table:

    - Invoices that are paid in full during the **Select Checks** process
    - Manual payments that are applied to invoices
    - Invoices that are paid in full by manual payments

For credit memos, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.

2. Type a vendor ID in the **Vendor ID** list, and then create an invoice.

3. Post the invoice. When you post the invoice, a record is created in the PM20000 (PM Transaction Open File) table.

4. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.

5. Type a vendor ID in the **Vendor ID** list, and then create a credit memo for the same vendor and for the same value as in step 2.

6. In the Payables Manual Payment Entry window, select **Apply**, and then apply the credit memo by selecting to select the check box beside the invoice that you created in step 2.

7. Post the credit memo. When you post the credit memo, the following actions occur:
   - The invoice record is removed from the PM20000 (PM Transaction Open File) table.
   - A credit memo record is created in the PM20100 (PM Apply To OPEN OPEN Temporary File) table with the **Key Source** field equal to **REMITTANCE**.
   - The invoice record and the credit memo record are created in the PM30200 (PM Paid Transaction History File) table.
   - An apply record is created in the PM30300 (PM Apply To History File) table.

8. On the **Inquiry** menu, point to **Purchasing**, and then select **Transactions by Vendor**.

9. Select the appropriate vendor in the **Vendor ID** list. The credit memo and the invoice display the value **HIST** in the **Origin** field.

10. On the **Transactions** menu, point to **Purchasing**, and then select **Select Checks**.

11. Type a batch ID in the **Batch ID** field.
12. Restrict the **Select Payables Checks** process to the vendor from step 2.

13. In the Select Payables Checks window, select **Build Batch**. The **Build Batch** process creates a new record in the PM20100 (PM Apply To OPEN OPEN Temporary File) table for the invoices that are selected for the **Select Checks** process.

    When the batch is created, the **Payment_To_Print_On_Stub** field in the PM20100 table is populated with the voucher number that is used to create the check batch.
14. After the batch is created, select **Print Checks** to begin the check printing process.

15. In the Print Payables Checks window, select **Print** to print the checks. The check stub displays the following information:

    - The invoice that was paid by the credit memo is displayed with a $0 remittance amount.
    - The credit memo is displayed with a negative value and with a $0.00 remittance amount.
    - Invoices that are paid by the check are displayed with the appropriate remittance amount.

16. After the check is printed, the Post Payables Checks window opens. Select **Process** to post the checks. The posting journals print the distributions for invoices paid by the checks. Credit memo information doesn't print on the posting journals.

17. During the posting process, the following vendor records are removed from the PM20000 (PM Transaction Open File) table and from the PM20100 (PM Apply To OPEN OPEN Temporary File) table:

    - Invoices that are paid in full during the Select Checks process
    - Credit memos that are applied to invoices
    - Invoices that are paid in full by credit memos

For returns, follow these steps

1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.

2. Type a vendor ID in the **Vendor ID** list, and then create an invoice.

3. Post the invoice. When you post the invoice, a record is created in the PM20000 (PM Transaction Open File) table.

4. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.

5. Type a vendor ID in the **Vendor ID** list, and then create a return for the same vendor and for the same value as in step 2.

6. In the Payables Manual Payment Entry window, select **Apply**, and then apply the return to the invoice that you created in step 2.

7. Post the return. When you post the return, the following actions occur:
    - The invoice record is removed from the PM20000 (PM Transaction Open File) table.
    - A return record is created in the PM20100 (PM Apply To OPEN OPEN Temporary File) table with the **Key Source** field equal to **REMITTANCE**.
    - The invoice record and the return record are created in the PM30200 (PM Paid Transaction History File) table.
    - An apply record is created in the PM30300 (PM Apply To History File) table.

8. On the **Inquiry** menu, point to **Purchasing**, and then select **Transactions by Vendor**.

9. Select the appropriate vendor in the **Vendor ID** list. The return and the invoice display the value **HIST** in the **Origin** field.

10. On the **Transactions** menu, point to **Purchasing**, and then select **Select Checks**.

11. Type a batch ID in the **Batch ID** field.
12. Restrict the **Select Payables Checks** process to the vendor from step 2.

13. In the Select Payables Checks window, select **Build Batch**. The **Build Batch** process creates a new record in the PM20100 (PM Apply To OPEN OPEN Temporary File) table for the invoices that are selected for the **Select Checks** process.

    When the batch is created, the **Payment_To_Print_On_Stub** field in the PM20100 table is populated with the voucher number that is used to create the check batch.

14. After the batch is created, select **Print Checks** to begin the check printing process.

15. In the Print Payables Checks window, select **Print** to print the checks. The check stub displays the following information:
    - The invoice that was paid by the return is displayed with a $0 remittance amount.
    - The return is displayed with a negative value and with a $0.00 remittance amount.
    - Invoices that are paid by the check are displayed with the appropriate remittance amount.
16. After the check is printed, the Post Payables Checks window opens. Select **Process** to post the checks. The posting journals print the distributions for invoices paid by the checks. Return information doesn't print on the posting journals.

17. During the posting process, the following vendor records are removed from the PM20000 (PM Transaction Open File) table and from the PM20100 (PM Apply To OPEN OPEN Temporary File) table:

    - Invoices that are paid in full during the Select Checks process
    - Returns that are applied to invoices
    - Invoices that are paid in full by returns

## References

For more information about how to keep the payment information from printing and about how to remove it from the PM20100 table, see [How to prevent zero dollar remittances from printing in Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/855957).
