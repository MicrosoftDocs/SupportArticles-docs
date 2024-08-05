---
title: Reconcile FA to verify balances are right
description: Describes how to reconcile Fixed Assets to verify that the balances are correct in General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# How to reconcile Fixed Assets to verify that the balances are correct in General Ledger in Microsoft Dynamics GP

This article describes how to reconcile Fixed Assets to verify that the balances are correct in General Ledger in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857464

## Introduction

1. Run the **Fixed Assets to General Ledger Reconciliation** report. To run this report, point to **Fixed Assets** on the **Reports** menu, and then select **Activity**. In the **Reports** list, select **Fixed Assets to General Ledger Reconciliation**, and then press ENTER.
2. Run the **Fixed Assets Inventory List by Class** report. To run this report, select **Fixed Assets** on the **Reports** menu, and then select **Inventory**. In the **Reports** list, select **Fixed Assets Inventory List by Class**.
3. Run the **Annual Activity** report. To run this report, select **Fixed Assets** on the **Reports** menu, and then select **Activity**. In the **Reports** list, select **Annual Activity**, and then press ENTER.

In the following scenarios, errors may cause the entries in Fixed Assets to be out of balance with General Ledger:

- An asset is deleted in Fixed Assets. This asset was interfaced with General Ledger. And, a general entry wasn't created in General Ledger to back out the information for the asset. When you delete an asset, a report is automatically printed. This report tells you what activity has occurred for the asset. If the line item has been interfaced with General Ledger, the report contains a batch number.

- The correct General Ledger account isn't setup in Fixed Assets to default on the transactions.

- An incorrect book is set up as the Corporate Book in the Fixed Assets Company Setup window.

- Typically, the balances are already in General Ledger during the initial setup of Fixed Assets. The balances may have been entered as Payables Management transactions. Or, the balances may have been entered manually in General Ledger. After you add all the assets into the system, run a dummy General Ledger interface. When you do it, enter 0000-000 in the **Begin Date** field and in the **End Date** field of the period through which the assets are currently depreciated. Then, delete the batch in General Ledger. This step updates each asset and uses the flag with which the assets were interfaced. However, because the batch is deleted, it doesn't affect the General Ledger. If you forget to create and delete the dummy batch, there's a risk that you'll run an interface in the future that will update General Ledger again.
- You use the interface from the Payables window or from the Purchase Order Processing window, and you don't add all the assets into Fixed Assets. If you use a true clearing account in purchasing, the balance remains in the clearing account. You can check this account to verify that all the assets have been entered into Fixed Assets. If you don't use a true clearing account, view the FA-AP Post Table Inquiry window to verify that all the assets have been added. To do it, use one of the following steps:

  - In Microsoft Business Solutions - Great Plains Dynamics 7.0 and in later versions, select **Inquiry**, select **Fixed Assets**, and then select **Purchasing Transactions**.
  - In Great Plains 6.0, select **Inquiry**, select **Fixed Assets**, and then select **FA-AP Post Table**.

- If you use the Purchase Order Processing by receipt line, the clearing account should be the same account that is debited in Purchase Order Processing. The clearing account is the account that is credited when an asset is added in Fixed Assets. For example, if you use the Fixed Assets account in Purchase Order Processing, the clearing account should be set up as the Fixed Assets account. If the clearing account isn't set up as the Fixed Assets account, the Fixed Assets account is debited two times.

## More information

Example

The following tables describe the accounts that are used when you post an invoice in Purchase Order Processing in Microsoft Dynamics GP.

|Module|DR/CR|Account type|Account number|
|---|---|---|---|
|Purchase Order Processing|DR|Fixed Assets account|000-1500-00|
|Purchase Order Processing|CR|Accounts Payable|000-2100-00|
|Fixed Assets|DR|Cost account|000-1500-00|
|Fixed Assets|CR|Clearing account|000-1590-00|
  
> [!NOTE]
> The 000-1500-00 Fixed Assets account would be debited two times. To prevent it, the clearing account should be the Fixed Assets account. This setup would result in a debit entry and a credit entry to the Fixed Assets account when the asset is added in Fixed Assets. So the Fixed Assets account is only debited one time. Consider the following example.

|Module|DR/CR|Account Type|Account Number|
|---|---|---|---|
|Purchase Order Processing|DR|Fixed Assets account|000-1500-00|
|Purchase Order Processing|CR|Accounts Payable|000-2100-00|
|Fixed Assets|DR|Cost account|000-1500-00|
|Fixed Assets|CR|Clearing account|000-1500-00|
  
- The FA-AP Post account is set up as one account, and the clearing account is set up as a different account. These two accounts should be the same account number. This account is frequently known as the trigger account.
- There may have been adjustments made directly to a Fixed Asset account in the General Ledger. These adjustments aren't reflected in Fixed Assets.
