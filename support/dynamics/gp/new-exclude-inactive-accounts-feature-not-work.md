---
title: The new Exclude Inactive Accounts feature does not work
description: This article provides a resolution for the problem where the new feature to Exclude Inactive Accounts in Account Lookups does not work in all modules in Microsoft Dynamics GP 2010.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# The new Exclude Inactive Accounts feature does not work in all modules in Microsoft Dynamics GP 2010

This article helps you resolve the problem where the new feature to Exclude Inactive Accounts in Account Lookups does not work in all modules in Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2441584

## Symptoms

The new feature to **Exclude Inactive Accounts in Accounts Lookup window** does not work in all modules in Microsoft Dynamics GP 2010. The What's New pdf for Microsoft Dynamics GP 2010 states under General Ledger:

Exclude inactive accounts in Accounts Lookup

You can now exclude all inactive records from the Accounts lookup window.

## Cause

The new feature to Exclude Inactive Accounts in Accounts Lookup window works in General Ledger, and does not work for the account lookups in other submodules such as Payables Management, Receivables Management or Inventory.

## Resolution

When an account is inactivated, it will still show up in the lookups in the Account Maintenance window to allow the user to activate it back or make other changes to it. The Exclude Inactive Accounts functionality will work in the lookups under the Financial series. The account lookups in other modules will still show the inactive accounts, so you must create a Smartlist to use as a view when looking at the account list in other modules.

The work-around to not show inactive accounts in PM, RM, or Inventory is to build a Smartlist Favorite for active accounts only using these steps:

1. Go to the **SmartList** window. (Click on **SmartList** under Microsoft Dynamics GP).

2. On the **Smartlist** window, click on the **+** icon beside the *Financial* folder.

3. Then click on the **+** sign beside the *Accounts* folder. Then click on the * under Accounts.

4. The window will load with default results, so we'll need to add more columns. So click on the **Columns**  button at the top. On the Change Column Display window click on **Add**, and look for the column named **Active**. Click on the **Active** column to select it and click **OK**. This will add the new column to the column list. Click **OK** again to close the Change Column Display window.

5. Now let's add a restriction for this column. Click on the **Search** button, and choose the Column Name **Active**. Set filter to **is equal to** and **Value** to **Yes**. Then click **OK**.

   The window should repopulate to only show active accounts now.

6. Let's save this Smartlist as a new favorite. To do this, click on the **Favorites** button at the top, Name it such as **Active Accounts Only** and set the visibility. Then click **Add** and then click **Add Favorite**.

7. You can test by clicking on Transactions, point to Purchasing and click on **Transaction Entry**. Enter an invoice, click on the **Distributions** button and click on the **Account lookup** button. In the header, click on the drop-down list next to **View**, and click on **Favorites** and then click on the favorite name created for Active Accounts Only. The account list shown in the window should automatically repopulate to restrict out the inactive accounts.

   > [!NOTE]
   > Unfortunately you are not able to set this Favorite as your default view in the sub-module, so the user would need to select this Favorite each time.

## More information

If you would like to see this functionality extended to submodules, please log a product suggestion in the MS Connect database. The suggestions entered are reviewed and tallied and used to set a priority level for which enhancements will be included in future patch releases. The link to the MS Connect Product Suggestion database is:

[Microsoft Connect Has Been Retired](/collaborate/connect-redirect)
