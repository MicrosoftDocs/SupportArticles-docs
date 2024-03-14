---
title: Inventory Stock count errors
description: Inventory Stock count errors in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, Aeckman
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# Inventory Stock count errors in Microsoft Dynamics GP

This article provides a resolution for the inventory Stock count errors in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4093724

## Symptoms

With year-end or month-end, many of us use stock counts to update inventory quantities. Sometimes the count gives us trouble and you end up with one of the following errors and are unable to post:

> There is a shortage of item XXX at site YY.

> The net lot variance and the variance on the stock count line do not match.

> The lot number could not be allocated because enough quantities are no longer available.

> The calculated variance quantity will be adjusted because the on-hand quantity would be less than the allocated quantity or less than zero.  Do you want to continue or cancel?

> Or if variances aren't matching.

## Resolution

The main goal is to get the stock count posted without delay, but these errors can sometimes stop us. There are many reasons for these errors and you may have to sift through data to determine how to fix the data or run IV reconcile to fix it. That takes time and sometimes time isn't on our side. So, my solution is to remove the problematic item(s) off the count and post the stock count with the *good* items on it only to get inventory up to date. In my experience, running IV reconcile fixes 95% of the issues. Once completed, a new stock count can be created for the items that originally had errors and hopefully post without issues.

Via the front end however, you are unable to remove the *bad* item(s) off the count unless you cancel the count under the Stock Count Schedule window (**Inventory** > **Transactions** > **Stock Count Schedule**). And when you stop the count, it wipes out all the data you entered in the Stock Count Entry window. Yikes! So, we don't want to do that. Unless you are okay losing your current work and/or barely any has been done. Running IV reconcile without removing the item off the count won't help either. The values are all recorded in the IV stock count tables at the time you START the count and if reconcile changes anything with the purchase receipts tables/quantities, there will be no impact on the Stock count data by leaving the items on the stock count. As far as deleting the items, since we don't want to delete the items off the stock count via the front end while the stock count is **started**, it must be done via the backend in SQL. The steps later below will help you do this.

The problem with stock counts typically stem from the fact that users do not stop processing transactions after they start the stock count, and as a result the serial/lots get messed up. Or many times the data is in a bad state prior to starting the count and maintenance just need to be run to fix it. In my experience to help alleviate these types of issues in the future, run IV reconcile before starting a stock count AND while stock counts are started, do not continue processing for those items. If reconcile does not fix the issue, then more investigation into the inventory tables will be needed to determine what the problem is.

Below are my recommendations and first thing to try before having to contact support for assistance.

First - make a backup and restore into test to run through the steps. At a minimum, make a backup if you are doing in LIVE.

1. Run the following select statements against the company database for the items/site/stock count with the errors. Fill in the appropriate fields if you have them:

    **XXX** represents your item number  
    **YYY** represents your site  
    **ZZZ** represents your stock count ID

    For item: **XXX** (NOTE: MAKE SURE THE ITEM/LOCATION CODE/STOCK COUNT ID ARE ALL SPELLED CORRECTLY.)  

    ```sql
    SELECT * FROM IV10301 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'
    ```

    ```sql
    SELECT * FROM IV10302 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'
    ```

    ```sql
    SELECT * FROM IV10303 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'--MAY NOT HAVE ANYTHING IN THIS TABLE.
    ```

2. After you verified the SELECT DATA from step 1 are related to the specific stock count and item/site combination you are having an issue with, run the deletes to remove them off the count. Below are *deletes* to accomplish this.

    ```sql
    DELETE IV10301 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'
    ```

    ```sql
    DELETE IV10302 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'
    ```

    ```sql
    DELETE IV10303 WHERE ITEMNMBR = 'XXX' AND LOCNCODE = 'YYY' AND STCKCNTID = 'ZZZ'--MAY NOT HAVE ANYTHING IN THIS TABLE
    ```

3. Run the same set of SELECT and DELETE statements for any other items you have issues with on the count. Substitute the following Item/Site/Stock count information.

4. Post your stock count for all the *good* items if you like.
5. Run IV reconcile on item XXX.

   **Inventory** > **Utilities** > **Reconcile**

6. Create a new stock count schedule for item XXX and start the count.

   **Inventory** > **Transactions** > **Stock Count Schedule**

7. Count the items again and record your findings.

   **Inventory** > **Transactions** > **Stock Count Entry**

8. Post the stock count if no errors.

## More information

The information above was taken from this blog article:

[Stock count errors in Microsoft Dynamics GP](https://community.dynamics.com/blogs/post/?postid=a428f39b-c2d9-44ac-8b80-168ab59b8516)
