---
title: How taxes are calculated in Receivables Management, Sales Order Processing and Invoicing in Microsoft Dynamics GP
description: Describes how taxes are calculated in the Receivables Management, Sales Order Processing, and the Invoicing modules in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# How taxes are calculated in Receivables Management, Sales Order Processing, and Invoicing in Microsoft Dynamics GP

This article describes how taxes are calculated in the following modules in Microsoft Dynamics GP:

- Receivables Management
- Sales Order Processing
- Invoicing

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872674

## General information

Generally, taxes are calculated based on the following:

1. The shipping method that is assigned to the Receivables Management transaction or to each Sales Order Processing or Invoicing line item affects how taxes will be calculated.

   1. The shipping type (Delivery or Pickup) of the shipping method assigned to a transaction or a Sales line item will dictate which sales tax schedules will be compared only if the **Use Shipping Method When Selecting Default Tax Schedule** check box is selected in the Company Setup Options window.

      To open the Company Setup Options window:

      - In Microsoft Dynamics GP, select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Company**, select **Company** and then select the **Options** button in the Company Setup window.

      > [!NOTE]
      > If you decided not to use the shipping method to determine the default tax schedule and you unmark this option, the tax schedule assigned in the Vendor Maintenance window or the tax schedule assigned in the Customer Maintenance window will be the default tax schedule.

   2. If you've marked the Specify Tax Details for Automatic Tax Calculations option in the Company Setup Options window, tax calculations are based on the tax details marked as Auto-Calc. for the tax schedule. You can select as many tax details as you want to calculate tax for the schedule on the Tax Schedule Maintenance window. Mark the Auto-Calc. option to include the tax detail to include tax calculations in the tax detail entry window. If this option isn't marked, the tax detail won't be included in the tax calculation. If Auto-Calc. is unmarked and you want the tax detail to be included in the calculation in the tax detail entry window, you'll have to enter the tax detail and the tax amount. The details are listed, but empty. If the Specify Tax Details for Automatic Tax Calculations option isn't marked, the Auto-Calc. field isn't available and all the tax details assigned to the tax schedule are used to determine the tax amount.

   3. For Sales Order Processing or Invoicing only, the Tax Calculations setting that is selected in the Sales Order Processing Setup Options window or in the Invoicing Setup Options window (Advanced or Single Schedule) will also affect whether the shipping method will be considered in tax calculations.

      To open the Sales Order Processing Setup Options window:

      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Sales**, select **Sales Order Processing**, and then select the **Options** button in the Sales Order Processing Setup window.
  
      To open the Invoicing Setup Options window:

      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Sales**, select **Invoicing**, and then select the **Options** button in the Invoicing Setup window.

        > [!NOTE]
        > The Single Schedule setting does not take shipping methods and Item Sales Tax Options into consideration. All Sales invoices will calculate taxes that depend on the tax details assigned to the single schedule.

2. The sources of the tax details that will be used to assess taxes for each Sales line item in Sales Order Processing/Invoicing depend on whether the Inventory Control module is registered or not.

3. The Non-Inventoried flag in the SOP10200 (Sales Transaction Amounts Work) table or the IVC10101 (Invoicing Transaction Amounts Work) also affects how taxes are calculated for each Sales line item. The term *inventoried* means that the line item is also stored in an item card in Inventory Control.

   The Tax Option selected in the **Non Inventory Items** field on the Sales Order Processing Setup Options window or on the Invoicing Setup Options window (Taxable, Nontaxable, and Base on Customers) will affect the taxes that will be calculated for non-inventoried items. The Sales Tax Option selected items maintained in item cards (Taxable, Nontaxable, and Base on Customers) will also affect how taxes will be calculated for sales line item. To open the Item Maintenance window, select **Cards**, point to **Inventory**, and then select **Items**.

## Information about tax calculations

### Receivables management

1. If the shipping method assigned to the transaction has a shipping type of Delivery:

   1. The tax schedule assigned to the customer will default into the Receivables Transaction Entry window. To find the tax schedule assigned to the customer, select **Cards**, point to **Sales**, and then select **Customer**.
   2. The tax schedule specified in the **Sales** field of the Receivables Setup Options window is then compared with the tax schedule of the transaction.

      To open the Receivables Setup Options window, follow these steps:

      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Sales**, select **Receivables**, and then select the **Options** button on the Receivables Management Setup window.
   3. Taxes will be calculated for Sales tax details that are found in both tax schedules that are compared.

2. If the shipping method assigned to the transaction has a shipping type of Pickup:

   1. The tax schedule selected in the **Sales Tax Schedule** field of the Company Setup window will default into the Receivables Transaction Entry window.

      To open the Company Setup window, follow these steps:

      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company**, and then select **Company**.
   2. The tax schedule specified in the **Sales** field of the Receivables Setup Options window is then compared with the tax schedule of the transaction.

   3. Taxes will be calculated for Sales tax details that are found in both tax schedules that are compared.

## Sales order processing and invoicing

### Single schedule tax calculation

If the *Single Schedule* Tax Calculations setting is selected on the Sales Order Processing Setup Options window or on the Invoicing Setup Options window, taxes will be calculated for each tax detail assigned to tax schedule that is in turn selected in the **Single Schedule** field. The Single Schedule setting does not take shipping methods and Item Sales Tax Options into consideration. All Sales invoices will calculate taxes depending on the tax details assigned to the assigned single schedule.

### Advanced tax calculation (Taxable, Nontaxable, Base on Customers)

1. If the **Taxable** tax option is selected:

   1. If the shipping type of the shipping method that is used on the line items is Pickup:

      - For non-inventoried items and if Inventory is registered, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Site Tax schedule and the line item's Item Tax Schedule. The Site Tax schedule defaults from the Sales tax schedule of the line item's Site ID. To view this, select **Cards**, point to **Inventory**, and then select **Site**. The line item's Item Tax Schedule will default from the tax schedule selected in **Non Inventory Items** field of the Sales Order Processing Setup Options window or of the Invoicing Setup Options window.
      - For non-inventoried items and if Inventory is not registered, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Site Tax schedule and the line item's Item Tax Schedule. The line item's Site Tax schedule defaults from the tax schedule that is selected in the **Sales Tax Schedule** field of the Company Setup window. The line item's Item Tax Schedule will default from the tax schedule selected in the **Non Inventory Items** field of the Sales Order Processing Setup Options window or of the Invoicing Setup Options window.
      - For inventoried items and if Inventory is registered, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Site Tax schedule and the line item's Item Tax Schedule. The line item's Site Tax schedule defaults from the Sales tax schedule of the line item's Site ID. To view this, select **Cards**, point to **Inventory**, and then select **Site**. The line item's Item Tax Schedule defaults from the tax schedule that is selected in the **Tax Schedule ID** field under the **Sales Tax Option** field of the Item Maintenance window.
      - For inventoried items and if Inventory is not registered, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Site Tax schedule and the line item's Item Tax Schedule. The line item's Site Tax schedule defaults from the tax schedule that is selected in the **Sales Tax Schedule** field of the Company Setup window. The line item's Item Tax Schedule defaults from the tax schedule that is selected in the **Tax Schedule ID** field under the **Sales Tax Option** field of the Item Maintenance window.

   2. If the shipping type of the shipping method used on the line items is Delivery:
  
      - For non-inventoried items, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Ship To Tax schedule ID and the line item's Item Tax Schedule. The line item's Ship To Tax schedule ID will default from the tax schedule assigned to the Ship To address of the customer. To view this, select **Cards**, point to **Sales**, point to **Customer**, and then select the **Ship To** link. The line item's Item Tax Schedule will default from the tax schedule selected in **Non Inventory Items** field of the Sales Order Processing Setup Options window or that of the Invoicing Setup Options window.
      - For inventoried items, taxes will be calculated based on the similar tax details that are found by Microsoft Dynamics GP when comparing the line item's Ship To Tax schedule ID and the line item's Item Tax Schedule. The line item's Ship To Tax schedule ID will default from the tax schedule that is assigned to the Ship To address of the customer. To view this, select **Cards**, point to **Sales**, point to **Customer**, and then select the **Ship To** link. The line item's Item Tax Schedule defaults from the tax schedule that is selected in the **Tax Schedule ID** field under the **Sales Tax Option** field of the Item Maintenance window.

   3. If the line item is not assigned a shipping method, no taxes will automatically be calculated for the line item.
   4. If no similar tax details are found between tax schedules being compared for a line item, no taxes will be calculated for the line item.

2. If the **Nontaxable** tax option is selected, no taxes will be calculated for the Sales line item.

3. If the **Base on Customers** tax option is selected, no tax schedule comparison is made. Instead, the following occurs:

   1. If the shipping type of the shipping method that is used on the line items is **Pickup**:
      - If Inventory is registered, all tax details in the line item's Site Tax schedule will be used to assess a tax amount for the line item. The line item's Site Tax schedule defaults from the Sales tax schedule of the line item's Site ID. To find this, select **Cards**, point to **Inventory**, and then select **Site**.
      - If Inventory is not registered, all tax details in the line item's Site Tax schedule will be used to assess a tax amount for the line item. The line item's Site Tax schedule defaults from the tax schedule selected in the **Sales Tax Schedule** field of the Company Setup window.

   2. If the shipping type of the shipping method that is used on the line items is Delivery, all tax details in the Ship To Tax schedule ID will be used to assess a tax amount for the line item. The Ship To Tax schedule ID defaults from the tax schedule that is assigned to the Ship To address of the customer. To view this, select **Cards**, point to **Sales**, point to **Customer**, and then select the **Ship To** link.

### Freight tax

1. If the **Taxable** tax option is selected:

   1. If the shipping type of the shipping method assigned to the **Shipping Method** field of the Sales Customer Detail Entry window or of the Invoice Customer Detail Entry window is set to **Pickup**, the following occurs.

        > [!NOTE]
        > To view the Sales Customer Detail Entry window, select **Transactions**, point to **Sales**, point to **Sales Transaction Entry**, and then select the **Customer ID** expansion button. To view the Invoice Customer Detail Entry window, select **Transactions**, point to **Sales**, point to **Invoice Entry**, and then select the **Customer ID** expansion button.

      - If Inventory is registered, the **Tax Schedule ID** field will default from the Sales tax schedule of the Default Site ID of the Sales transaction. This will then be compared with the Freight tax schedule selected in the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Freight Amount of the Sales transaction.
      - Inventory is not registered, the **Tax Schedule ID** field will default the Sales Tax Schedule of the Company Setup window. This will then be compared with the Freight tax schedule selected in the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Freight Amount of the Sales transaction.

   2. If the shipping type of the shipping method that is assigned to the **Shipping Method** field of the Sales Customer Detail Entry window or of the Invoice Customer Detail Entry window is set to Delivery, the **Tax Schedule ID** field will default the Tax Schedule assigned to the Ship To address of the customer. This will then be compared with the Freight tax schedule selected on the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Freight Amount of the Sales transaction.

2. If the **Nontaxable** tax option is selected, no taxes will be calculated for the Freight amount of the Sales transaction.
3. If the **Base on Customers** tax option is selected, no tax schedule comparison is made. Instead, the following occurs:

   1. If the shipping type of the shipping method that is assigned to the transaction is set to **Pickup**:
      - If Inventory is registered, the **Tax Schedule ID** field will default from the Sales tax schedule of the Default Site ID of the Sales transaction. All of its tax details will be used to assess taxes for the Freight Amount of the Sales transaction.
      - If Inventory is not registered, the **Tax Schedule ID** field will default from the Sales Tax Schedule of the Company Setup window. All of its tax details will be used to assess taxes for the Freight Amount of the Sales transaction.
   2. If the shipping type of the shipping method that is used on the line items is Delivery, all tax details in the **Tax Schedule ID** field, which will default from the tax schedule assigned to the Ship To address of the customer, will be used to assess taxes for the Freight Amount of the Sales transaction.

### Miscellaneous tax

1. If the **Taxable** tax option is selected:

   1. If the shipping type of the shipping method assigned to the **Shipping Method** field of the Sales Customer Detail Entry window or of the Invoice Customer Detail Entry window is set to **Pickup**:
      - If Inventory is registered, the **Tax Schedule ID** field will default from the Sales tax schedule of the Default Site ID of the Sales transaction. This will then be compared with the Miscellaneous tax schedule selected on the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Miscellaneous Amount of the Sales transaction.
      - Inventory is not registered, the **Tax Schedule ID** field will default from the Sales Tax Schedule of the Company Setup window. This will then be compared with the Miscellaneous tax schedule selected on the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Miscellaneous Amount of the Sales transaction.
   2. If the shipping type of the shipping method that is assigned to the **Shipping Method** field of the Sales Customer Detail Entry window or that of the Invoice Customer Detail Entry window is set to **Delivery**, the **Tax Schedule ID** field will default the Tax Schedule assigned to the Ship To address of the customer. This will then be compared with the Miscellaneous tax schedule selected on the Sales Order Processing Setup Options window to come up with the tax amount that will be assessed against the Miscellaneous Amount of the Sales transaction.

2. If the **Nontaxable** tax option is selected, no taxes will be calculated for the Miscellaneous amount of the Sales transaction.
3. If the **Base on Customers** tax option is selected, no tax schedule comparison is made. Instead, the following occurs:

   1. If the shipping type of the shipping method that is assigned to the transaction is set to **Pickup**:
      - If Inventory is registered, the **Tax Schedule ID** field will default from the Sales tax schedule of the Default Site ID of the Sales transaction. All of its tax details will be used to assess taxes for the Miscellaneous Amount of the Sales transaction.
      - If Inventory is not registered, the **Tax Schedule ID** field will default from the Sales Tax Schedule of the Company Setup window. All of its tax details will be used to assess taxes for the Miscellaneous Amount of the Sales transaction.

   2. If the shipping type of the shipping method that is used on the line items is Delivery, all tax details in the Tax Schedule ID, which will default from the tax schedule assigned to the Ship To address of the customer, will be used to assess taxes for the Miscellaneous Amount of the Sales transaction.
