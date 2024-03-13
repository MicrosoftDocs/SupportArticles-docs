---
title: How to use bank account and bank routing numbers in Lockbox
description: Describes how to use the bank account number and bank routing number instead of the customer ID in Lockbox Processing in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use the bank account number and bank routing number instead of the customer ID in Lockbox Processing in Microsoft Dynamics GP

This article describes how to create an association between the Customer ID and the customer's banking information (account number and bank routing number) in a lockbox file in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856094

## More information

To create an association between the Customer ID and the customer's bank account number and bank routing number, use one of the following methods.

### Method 1 - Create a dummy lockbox file

You can create a dummy lockbox import file that will include the Customer ID and the customer's banking information. When you create this dummy file, the customer's banking information is written to the Lockbox Bank Details window to create an association between the Customer ID and the banking information. To do this, follow these steps.

> [!NOTE]
> You will delete the cash receipt batch that is created.

1. Create an example lockbox file in comma delimited (*.csv) format. Include the following fields in the file:
   - Customer ID
   - Bank Routing Number
   - Bank Account Number
   - Check Number (dummy)
   - Check Amount (dummy amount such as .01)
2. Open the Lockbox Maintenance window. To do this, point to **Sales** on the **Cards** menu, and then select **Lockbox**.
3. Create a lockbox ID that maps the information on the new file to the fields in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0. Select **None** in the **Lockbox Apply Method** list.

    > [!NOTE]
    > Make sure that you map all five fields that are listed in step 1.

4. Open the Lockbox Entry window. To do this, point to **Sales** on the **Transactions** menu, and then select **Lockbox Entry**.
5. Select the lockbox ID that you created in step 3. In the **Lockbox Import File** field, type the path of the example file that you created in step 1.
6. Type a batch ID in the **Batch ID** field, and then select **Transactions** to import the records.
7. In the Lockbox Transactions window, correct any errors that are marked by a red X.
8. After all the errors are fixed, select **Create Batch**.
9. To verify that the banking information is updated for each customer in the lockbox file, open the Lockbox Bank Details window. To do this, point to **Sales** on the **Cards** menu, and then select **Lockbox Bank Details**.
10. In the **Customer ID** list, select an appropriate customer. Verify that the correct information exists in the **Bank Routing Number** column and in the **Bank Account Number** column.
11. Delete the example cash receipt batch. To do this, point to **Sales** on the **Transactions** menu, and then select **Receivables Batches**. In the **Batch ID** list, select the appropriate cash receipt batch, and then select **Delete**.

    > [!NOTE]
    > After you complete step 11, you can import lockbox files that do not contain a Customer ID in the file. Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0 make the association to the correct customer to which the cash receipt applies.

### Method 2 - Manually match the lockbox file to each customer

You can manually match the cash receipt from the lockbox file to the appropriate Customer ID. When you do this, Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0 will write the banking information for the appropriate customer in the Lockbox Bank Details window. Use the invoice information in the lockbox file to determine the appropriate Customer ID. To manually match the receipts to Customer IDs, follow these steps:

1. Import the lockbox cash receipt file that is provided from the bank. To do this, point to **Sales** on the **Transactions** menu, and then select **Lockbox Entry**.
2. In the **Lockbox ID** list, select the appropriate lockbox ID.

    > [!NOTE]
    > The path of the **Lockbox Import File** should automatically populate in the list from the lockbox ID setup. If the path does not appear, browse to the folder in which the lockbox file is saved.

3. Type a batch ID in the **Batch ID** field, and then select **Transactions** to import the cash receipt transactions.
4. In the Lockbox Transactions window, double-click the unmatched cash receipt transactions to open the Edit Lockbox Customer window.

    > [!NOTE]
    > Transactions that were not matched are marked by a red X to signify an error.

5. In the **Customer ID** list, select the appropriate Customer ID, select **Select**, and then select **OK**.
6. Double-click the cash receipt transaction to open the Apply Sales Document window.
7. Select the appropriate document in which to apply the cash receipt transaction, and then select **OK**.

    > [!NOTE]
    > The cash receipt does not have to be applied.

8. In the Cash Receipts Entry window, select **Save**.

9. After all the errors are corrected, select **Create Batch**. (Create Batch is what updates the Lockbox Bank Details window [PA00010]. Only select **OK** if you want to close the window and work on the batch again later. The OK button does not update the banking information on the customer.)

10. Post the cash receipt batch that is created. To do this, follow these steps:

    1. Select the **Transactions** menu, point to **Sales**, and then select **Receivables Batches**.
    2. Select the batch ID, and then select **Post**.

11. To verify that the banking information is updated for each record in the lockbox file, follow these steps:

    1. Open the Lockbox Bank Details window. To do this, select the **Cards** menu, point to **Sales**, and then select **Lockbox Bank Details**.
    2. In the **Customer ID** list, select an appropriate customer.
    3. Verify that the correct information exists in the **Bank Routing Number** column and in the **Bank Account Number** column.

> [!NOTE]
> After you complete step 11, the association between the Customer ID and the banking information is made automatically when you import lockbox files.
