---
title: Credit limit includes sales invoice tax and excludes order tax
description: Describes that the credit limit includes sales invoice taxes but excludes order taxes in Sales Order Processing in Microsoft Dynamics GP. Provides a formula to determine whether a document will put a customer over the credit limit.
ms.reviewer: theley, v-tarak
ms.date: 03/13/2024
---
# The credit limit includes sales invoice tax and excludes order tax in Sales Order Processing

This article provides a formula to determine whether a document will put a customer over the credit limit.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943960

## Symptoms

If you set a credit limit for a customer, and then you have documents held in a batch for an invoice for the customer, Microsoft Dynamics GP includes taxes for the invoice. However, if you set the credit limit for the customer, and then you have documents held in a batch for an order for this customer, Microsoft Dynamics GP excludes taxes for the order.

## More information

To determine whether a document will put a customer over the credit limit, Microsoft Dynamics GP uses the following formula for a credit check:

> (Current Document Amount + Customer Balance + Unposted Sales Amount + On Order Amount) - Unposted Payments and Deposits

To obtain each amount in this formula, open the **Customer Summary** window. To open the **Customer Summary** window, select **Cards**, point to **Sales**, and then select **Summary**.

These amounts are defined as follows.

|Amount|Definition|Notes|
|---|---|---|
|Current Document Amount|The value that is in the **Amount** column for the Current period|To retrieve information about the customer from the Receivables Transaction Inquiry window, select the Current period, and then select the **Amount** link.|
|Customer Balance|The value that is in the **Balance** field|
|Unposted Sales Amount|The value that is in the **Sales/Debits** field under **Unposted**|
|Unposted payments and deposits|The value that is in the **Cash/Credits** field under **Unposted**|
  
  If you have a document held in a batch, orders update the On Order Amount value by using the remaining subtotal that is in the document. This remaining subtotal does not include the following amounts:

- Trade discount
- Freight
- Miscellaneous
- Tax

If the remaining subtotal did include the amounts that are in this list, the On Order Amount value would be inaccurate. Therefore, Microsoft Dynamics GP does not consider the amounts in this list when the credit check is completed.

### Steps to reproduce the behavior

> [!NOTE]
> The following steps refer to the Fabrikam company. Fabrikam is a fictitious company name that is used for demonstration in Microsoft Dynamics GP.

1. Create a customer. To do this, select **Cards**, select **Sales**, select **Customer**, and then specify the following settings:

   - **Customer ID**: Credit Test
   - **Name**: Credit Limit Test
   - **Address**: Primary

2. Set a credit limit. To do this, select **Options** in the **Customer Maintenance** window, and then specify the following setting:

   **Credit Limit**: Select the **Amount** option, and then type _$106.00_ in the field that becomes active.

3. Select **OK**.
4. Select **Save**. Then, close the **Customer Maintenance** window.
5. Create a sales order. To do this, select **Transaction**, select **Sales**, select **Sales Transaction Entry**, and then specify the following settings:
   - **Type/Type ID**: **Order**
   - **Document No.**: This field is populated by the default value.
   - **Customer ID**: **Credit Test**
   - **Batch ID**: **SOP ORDERS**
   - **Currency ID**: **Z-US$**
   - **Item Number**: **128 SDRAM**
   - **Unit Price**: 100.00
   - **Tax**: 5.00

6. In the Sales Tax Summary Entry window, specify the following settings:

   - **Tax Detail ID**: **AUSSTE-PS20N0**
   - **Tax Amount**: $5.00

7. Select **OK**.
8. In the **Sales Transaction Entry** window, select **Save**.
9. Create a sales invoice. To do this, select **Transaction**, select **Sales**, select **Sales Transaction Entry**, and then specify the following settings:

   - **Type/Type ID**: **Invoice**
   - **Document No.**: This field is populated by the default value.
   - **Customer ID**: **Credit Test**
   - **Batch ID**: **SOP ORDERS**
   - **Currency ID**: **Z-US$**
   - **Item Number**: **128 SDRAM**
   - **Unit Price**: 2.00
   - **Tax**: 7.00

10. In the Sales Tax Summary Entry window, specify the following settings:

    - **Tax Detail ID**: **AUSSTE-PS20N0**
    - **Tax Amount**: **$7.00**
    - Select **OK**.

11. In the Sales Transaction Entry window, select **Save**.

    > [!NOTE]
    > In this second credit check, the override credit limit does not appear until after you complete steps 10 and 11. The tax amount on the order is not applied to the credit limit.

12. Delete the SOP ORDERS batch. To do this, select **Sales** on the **Transaction** menu, and then select **Sales Batches**.
13. In the **Sales Batches Entry** window, select **SOP ORDERS** in the **Batch ID** field, select **Delete**, and then close the Sales Batches Entry window.
14. Create a sales invoice. To do this, select **Sales** on the **Transaction** menu, select **Sales Transaction Entry**, and then specify the following values:

    - **Type/Type ID**: **Invoice**
    - **Document No.**: This field is populated by the default value.
    - **Customer ID**: **Credit Test**
    - **Batch ID**: **SOP INVOICES**
    - **Currency ID**: **Z-US$**
    - **Item Number**: **128 SDRAM**
    - **Unit Price**: 100.00
    - **Tax**: 5.00

15. In the Sales Tax Summary Entry window, specify the following information:

    - **Tax Detail ID**: **AUSSTE-PS20N0**
    - **Tax Amount**: $5.00

16. Select **OK**.
17. In the **Sales Transaction Entry** window, select **Save**.
18. Create a sales invoice. To do this, select **Transaction**, select **Sales**, select **Sales Transaction Entry**, and then specify the following settings:

    - **Type/Type ID**: **Invoice**
    - **Document No**: This field is populated by the default value.
    - **Customer ID**: **Credit Test**
    - **Batch ID**: **SOP INVOICES**
    - **Currency ID**: **Z-US$**
    - **Item Number**: **128 SDRAM**
    - **Unit Price**: 2.00

    > [!NOTE]
    > In this second credit check, the override credit limit appears.
