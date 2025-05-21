---
title: Set up tax-free import creditors
description: Describes how to set up tax-free import creditors for Australian Goods and Services Tax (GST) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# How to set up tax-free import creditors for Australian GST in Microsoft Dynamics GP

This article describes how to set up tax-free import creditors for Australian Goods and Services Tax (GST) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944226

## Introduction

You can use the Australian Taxation Information Setup Wizard that is installed as a part of the Business Activity Statement (BAS) to create all the tax schedules and all the tax details that are needed for Australian GST. The Australian Taxation Information Setup Wizard is enabled when you select the **Enable GST for Australia** check box in the Company Setup Options window.

## More information

To open the Company Setup Options window in Microsoft Dynamics GP 10.0, follow these steps:

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Company**, and then select **Company**.
2. In the Company Setup window, select **Options**.

To open the Company Setup Options window in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Company**, and then select **Company**.
2. In the Company Setup window, select **Options**.

The Australian Taxation Information Setup Wizard creates the tax schedules and the tax details for most of the situations that Australian companies need. It includes a setup for export debtors. One situation that is currently not supported is when Australian companies purchase a good that doesn't enter Australia or a service that doesn't occur in Australia. In this situation, no GST is charged, and this transaction is classified as GST free.

To set up tax-free import creditors for Australian GST, follow these steps:

1. Open the Tax Detail Maintenance window. To do it in Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Tax Details**.

    To do it in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Company**, and then select **Tax Details**.
2. Create a new tax detail. To do it, specify the following settings:

    - **Tax Detail ID**: AUSGST+IMP
    - **Description**: GST Tax Free Import Supply
    - **Type**: **Purchases**  
    - **Account**: Account number for the GST paid
    - **Based On**: **Percent of Sale/Purchase**  
    - **Percentage**: 0.00000%
    - **Round**: **To the Nearest Currency Decimal Digit**  
    - **Print on Documents**: Select this check box
    - **BAS Assignments**: **G14**  

        > [!NOTE]
        > When you select **G14**, **G11** is automatically selected.
    - The box next to the **Print on Documents** check box: G
3. Select **Save**.
4. Create another new tax detail. To do it, specify the following settings:

    - **Tax Detail ID**: AUSGSTI+IMP
    - **Description**: GST Inc Tax Free Import Supply
    - **Type**: **Purchases**  
    - **Account**: Account number for the GST paid
    - **Based On**: **Tax Included with Item Price**  
    - **Percentage**: 0.00000%
    - **Round**: **To the Nearest Currency Decimal Digit**  
    - **Print on Documents**: Select this check box
    - **BAS Assignments**: **G14**  

        > [!NOTE]
        > When you select **G14**, **G11** is automatically selected.
    - The box next to the **Print on Documents** check box: G
5. Select **Save**.
6. Close the Tax Detail Maintenance window.
7. Open the Tax Schedule Maintenance window. To do it in Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Tax Schedules**.

    To do it in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Company**, and then select **Tax Schedules**.
8. Create a new tax schedule. To do it, specify the following settings:
   - **Tax Schedule ID**: AUSGST-IMP
   - **Description**: GST Import Creditor
   - **Selected Tax Details**: **AUSGST+IMP** and **AUSGSTI+IMP**
9. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGST-FRE**, insert the **AUSGST+IMP** tax detail ID, and then select **Save**.
10. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGST-GST**, insert the **AUSGST+IMP** tax detail ID, and then select **Save**.
11. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGST-INP**, insert the **AUSGST+IMP** tax detail ID, and then select **Save**.
12. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGSTI-FRE**, insert the **AUSGSTI+IMP** tax detail ID, and then select **Save**.
13. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGSTI-GST**, insert the **AUSGSTI+IMP** tax detail ID, and then select **Save**.
14. Select the **lookup** button next to the **Tax Schedule ID** field, select **AUSGSTI-INP**, insert the **AUSGSTI+IMP** tax detail ID, and then select **Save**.
15. Close the Tax Schedule Maintenance window.

    > [!NOTE]
    > You can add the appropriate AUSGST+IMP tax detail ID or the appropriate AUSGSTI+IMP tax detail ID to the other tax schedules for purchases. This includes any of the following domestic tax schedules:
    >
    > - Private use
    > - Reduced input tax credits
    > - Capital acquisitions
    > - Input taxed
    > - Luxury car tax
    > - Wine equalization tax

    However, it's unlikely that you'll use an international creditor together with these domestic tax schedules.

16. In the Creditor Maintenance window or in the Creditor Address Maintenance window, assign the AUSGST-IMP tax schedule ID to the appropriate creditor IDs.

    To open the Creditor Maintenance window, point to **Purchasing** on the **Cards** menu, and then select **Creditors**.

    To open the Creditor Address Maintenance window, point to **Purchasing** on the **Cards** menu, and then select **Addresses**.

> [!NOTE]
> The naming conventions that are used in this article follow the default naming conventions that the wizard uses.
