---
title: Set up a company in Management
description: Describes how to set up a company in Multicurrency Management.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# How to set up a company in Multicurrency Management in Microsoft Dynamics GP

This article describes how to set up a company in Multicurrency Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858730

## Set up default Multicurrency Setup information in the Multicurrency Setup window

1. Open the Multicurrency Setup window. To do it, follow the appropriate step:

    - Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Multicurrency**.

2. In the **Functional Currency** list, select the currency that you want to use.

    > [!NOTE]
    > You can't change the functional currency after transactions have been posted against the selected functional currency.

3. In the **Reporting Currency** list, select the currency that you want to use.

## Set up Multicurrency Rate Types in the Multicurrency Rate Types window

1. Open the Multicurrency Setup window. To do it, follow the appropriate step:
   - Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Rate Types**.
2. In the Multicurrency Rate Types window, follow these steps:

    1. Determine which rate types are associated with each currency's exchange rate table.
    2. Note different exchange rates on the same exchange rate table for different purposes, such as for buying and for selling.

3. Set up your default Multicurrency Posting Accounts in the following order:
   - Rate Type

        1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Rate Types**.
        2. Select your **Exchange Table ID**, and then select the **Accounts** button.
        3. Assign your default posting accounts.

   - Currency ID

        1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Currency**.
        2. Select your **Currency ID**, and then select the **Accounts** button.

        3. Assign your default posting accounts.

   - Posting Accounts Setup

        1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Posting**, and then select **Posting**.
        2. Assign your default posting accounts.

    After you set up the accounts, the accounts are searched in the same order in which you set them up.

## Assign currency access to your GL accounts

Use one of the following methods.

### Method 1: Use the Select Account Currencies window

1. On the **Cards** menu, point to **Financial**, and then select **Account**.
2. Select **Currency**.
3. Assign currency for your GL accounts.

### Method 2: Use the Multicurrency Mass Account Update window

1. On the **Cards** menu, point to **Financial**, and then select **Currency Account Update**.
2. Assign currency access to your GL accounts.

### Method 3: Use the Multicurrency Account History window to enter historical multicurrency information for your GL accounts

1. On the **Cards** menu, point to **Financial**, and then select **Currency Account History**.

2. Use the Multicurrency Account History window to enter historical multicurrency information for accounts.

## Enter a default Currency ID for your customers

Use one of the following methods.

### Method 1

If you use Customer Classes in the Sales series, enter a default Currency ID at the customer class level. Then, roll this Currency ID down to each of your customers who is assigned to this customer class. To do it, follow these steps:

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Sales**, and then select **Customer Class**.
2. In the **Class ID** box, select your class ID, select the **Default** check box, and then select **Save**.

    > [!NOTE]
    > After you assign a currency ID, you receive the following message when you select **Save**:
    > Do you want to roll down changes to customers in this class?

    If you select **No**, the currency ID won't be saved to existing customers. But the currency ID will be saved for future customer records that are assigned to the Customer Class. If you select **Yes**, the currency ID will be saved and then rolled down to all existing customers who are assigned to this Customer Class.

### Method 2

Assign a default Currency ID to your customers in the Sales series. To do it, follow these steps:

1. On the **Cards** menu, point to **Sales**, and then select **Customer**.
2. In the **Customer ID** box, select the customer ID, and then select **Options**.
3. In the **Currency ID** box, select a currency ID, select **OK**, and then select **Save**.

## Enter a default Currency ID for your vendors

Use one of the following methods.

### Method 1: Enter a default Currency ID

If you use Vendor Classes in the Purchasing series, enter a default Currency ID at the vendor class level. Then, roll this Currency ID down to each of your vendors that is assigned to this vendor class. To do it, follow these steps:

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then select **Vendor Class**.
2. In the **Class ID** box, select your class ID, select the **Default** check box, and then select **Save**.

    > [!NOTE]
    > After you assign a currency ID, you receive the following message when you select **Save**:
    > Do you want to roll down changes to vendors in this class?

    If you select **No**, the currency ID won't be saved to existing vendors. But the currency ID will be saved for future vendor records that are assigned to the Vendor Class. If you select **Yes**, the currency ID will be saved and then rolled down to all existing vendors that are assigned to the Vendor Class.

### Method 2: Assign a default currency ID to your vendors

Assign a default currency ID to your vendors in the Purchasing series. To do it, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
2. In the **Vendor ID** box, select a vendor ID, and then select **Options**.
3. In the **Currency ID** box, select a currency ID, select **OK**, and then select **Save**.
