---
title: Cannot transfer encumbrances for XXXX
description: Provides a solution to an error that occurs in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# "You can't transfer encumbrances for XXXX when there are outstanding encumbrance amounts for a prior fiscal year." error displays in Microsoft Dynamics GP (Blog)

This article provides a solution to an error that occurs in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4567109

## Issue

The blog article can be found [here](https://community.dynamics.com/blogs/post/?postid=a59bf1e9-7e94-4fbe-8b96-4e4508fcc715).

The Year End Encumbrance Transfer window is used to transfer encumbrance balances on open Purchase orders (POs) from the current year to the next year. The transfer process automatically liquidates encumbered amounts in the current year and updates open purchase orders with the remaining amounts that will be delivered in the next year.

Encumbrance Year End transfer window is located by going to **Purchasing > Routines > Year End Encumbrance Transfer.**  
When running this process, you may receive the following error:
> You can't transfer encumbrances for XXXX when there are outstanding encumbrance amounts for a prior fiscal year

## Cause

There are many reasons for experiencing the error.

1. Sometimes users backdate a transaction that fell within a year that was already transferred. In that case, you simply need to go back to that year of the transaction and transfer those old transaction values forward. Other times it isn't as simple.
2. There are many third parties, integrations, and customization that integrate with Purchase Order Processing and sometimes the data may not be in a state that Microsoft Dynamics GP is expecting, thus causing the error.
3. Also, if you experienced any interruptions with posting, the data may be corrupt that could cause the error. In these cases, the issue may be with the ENC10111 table as it may not have all the ins and outs for the transaction. It's also possible the Purchase Order data in general is damaged causing the Purchase Order not to transfer.

## Resolution

There are a few options to try resolving this error. I always recommend that you move a copy of your LIVE data into a TEST company for testing. This blog assumes the user running these steps is familiar with the Encumbrance and Purchase Order data and how the tables should look in the backend. If you aren't familiar, you may need to reach out to your partner or create a support case for assistance. In a support case, we can assist with one or two problem Purchase Orders and give guidance, but if you have issues with more than a couple Purchase Orders, you may need to create separate cases for each PO as each one may have a different condition that requires separate analysis of data.

**OPTION 1:** Run the Year End transfer through all the years in the past to ensure there isn't a Purchase Order that was entered/encumbered in a previous that needs to be transferred.

Go to **Purchasing > Routines > Year End Encumbrance Transfer.**  
Start with the current year, then continue to move backward year by year to find if there's a Purchase Order that needs to be transferred. If there's a PO that is "stuck" and continues to stay on the report even after the transfer, that Purchase Order needs to be dug into by running the ALL PO and Receipt script (link listed later in this blog) to determine what is wrong with the PO. Many times, the ENC10111 isn't in the right state that causes the Purchase Order not to not move forward to the next year. If that is the case, you may be able to run Option 4 to get the PO to transfer.

**OPTION  2:** Remove Completed POs and remove history.

Use this option if you have a specific data condition where a Purchase Order on the transfer report just won't move AND the Purchase Order is in a Closed or Canceled status. It could be that the PO is damaged and just needs to be deleted from GP.  If you're okay with this option, do the following steps.

1. Navigate to **Purchasing > Utilities > Remove Purchasing History.** Which will allow you to delete the purchase order, receipt, account distribution, and journal history for the damaged Purchase Order. I know it may seem drastic but at this point, the Purchase Order is damaged and is closed or canceled, there's nothing that can be done with them going forward excepting fixing them one by one. So removing it may be the best option to try.

    - > [!NOTE]
      > If your Purchase order isn't in history to remove, use the Remove Completed Purchase Order routine to move the PO to the history file. Navigate to **Purchasing > Routines > Remove Completed Purchase Orders**.
    - The Completed PO Removal Report will print after the process has completed. If a purchase order won't be removed (for example, if it's in use or has damaged data), a message will print on the Completed PO Removal Report indicating that the purchase order wasn't removed. In this case, you need to review the ALL PO and receipts script results to determine what is wrong and fix it or delete it via the backend. If it DOES move to history, you continue with the next step.
    - You can now use the Remove Purchasing History window to delete purchase order history.

1. Next, run the tool to repair the ENC data. (**Microsoft Dynamics GP menu > Maintenance > Encumbrance Management > Routine Maintenance**) You'll want to use the **Detail based on Purchase Order** and then **Summary based on Detail.**

1. Attempt to transfer the year again, if you still get the error, continue with the data check steps that is OPTION 3.

**OPTION 3:** Data check script

We have a script below you can use to try and identify the culprit PO(s) causing the transfer to error. Many POs can be in the list returned but focus on the first one returned that is listed. Not all POs listed are necessarily bad. It just stops after it identifies the first corrupt Purchase Order and lists the rest after that. If we fix the first corrupt Purchase Order, the hope is the rest of the PO get removed off the list and the transfer goes through without an issue. If not, you'll need to repeat the process until the list is cleared.

Action of Option 3 overall will be:

1. Run the script below,
2. Run the ALL PO and Receipt script on the first PO in the list.
3. Fix the first PO's data in the list,
4. Try the transfer again.

You must first find a year that has no affected POs. To do it, you need to identify two things.

- Determine if you're a fiscal or calendar year. It's important! Navigate to **Administration >> Setup >> Company >> Fiscal Periods**; note the starting and ending dates of the years.
- What year are you getting the error in when running the Year-end transfer? For example, if you're transferring 2017 to 2018, note that.

Once you know #1 and #2, you now can run the script below to find the problem PO(s). To run the script, you need to run it for a date range that matches your fiscal/calendar years plus 1 extra day.

Use the script below. The key is entering the correct dates.

If you're calendar, then you would be 1/1/2017 to 1/1/2018. Let's assume you're set up for a Fiscal year starting May1st, instead so that is my example below.

If my first period started on May 1, 2017, and the year ended on April 30, 2018, my script would look like it:

```sql
declare @FROM varchar(10) set @FROM ='05/01/2017'
declare @TO varchar(10) set @TO ='05/01/2018'
declare @FROMDATE DATETIME set @FROMDATE = CONVERT(DATETIME, @FROM, 101)
declare @TODATE DATETIME set @TODATE = CONVERT(DATETIME, @TO, 101)
select *
from ( select ENC10110.PONUMBER, ENC10110.POLNENUM,
ENC10110.ENCBSTAT, ENC10110.INVINDX,
ENC10110.REQDATE,
(SUM(ENC10111.ENCMBAMT) - ISNULL(
(
select SUM(LIQUDAMT)
from ENC10500
where (GLPOSTDT>=@FROMDATE and GLPOSTDT<@TODATE) AND
ENC10110.PONUMBER = ENC10500.PONUMBER AND
ENC10110.POLNENUM = ENC10500.POLNENUM),0)
) AS REMAMT
from ENC10111
inner join ENC10110
ON ENC10111.PONUMBER = ENC10110.PONUMBER AND
ENC10111.POLNENUM = ENC10110.POLNENUM
where (ENC10111.TRXDATE>=@FROMDATE and ENC10111.TRXDATE<@TODATE) AND
ENC10110.ENCBSTAT<>3
  GROUP by  ENC10110.PONUMBER, ENC10110.POLNENUM,
      ENC10110.ENCBSTAT, ENC10110.INVINDX,
      ENC10110.REQDATE
) AS ENC
where REMAMT<>0
```

The key is to understand what dates you should be running. If you don't use the correct date restrictions, you could get results that you think are wrong, but actually they're correct and only display because of the way you ran the date restrictions. I always recommend that you start with the year you're trying to transfer, then go back year after year until you receive no results.  If you're using the last example setup, you would start with:

```sql
declare @FROM varchar(10) set @FROM ='05/01/2017'
declare @TO varchar(10) set @TO ='05/01/2018'
```

Then this:

```sql
declare @FROM varchar(10) set @FROM ='05/01/2016'
declare @TO varchar(10) set @TO ='05/01/2017'
```

Then this:

```sql
declare @FROM varchar(10) set @FROM ='05/01/2015'
declare @TO varchar(10) set @TO ='05/01/2016'
```

And so on, until the results are zero. If I received no results for 2015 to 2016, then I would run the previous script for 2016 to 2017 and that is where I would start troubleshooting. The purpose of the exercise is to find where the problem started.
Again, typically, you would then get the results from the ALL PO and Receipt scripts for the FIRST purchase order in the list and review the data to determine what is wrong. Once you determine the issue and fix the data, you should be able to rerun the Encumbrance Routine Maintenance and then transfer the year.

**IT IS IMPERATIVE that all Encumbrance users are on a version of GP equal to or greater than 11.00.1799.**  

> [!NOTE]
> Support can help with one or two problem PO(s) and look through the data to give advice on how to fix them, but if you have MANY POs, you will need to work with your partner to fix the data or create separate cases to assist analyzing the data issues. Each PO has MANY tables to analyze so one or two Purchase orders in a support case is acceptable to dig through, but after that the case is more consulting and needs your partner's assistance to work through.

Instructions for gathering the ALL PO and Receipts script.

Script found in [here](https://mbs2.microsoft.com/fileexchange/?fileID=71b0741f-cf46-4e27-bba6-8b64e5490f3e)

Run it in text using instructions below.

The goal of this statement is to review ALL data related to a specific Purchase Order. It's only a SELECT statement. It won't update/delete data.

```sql
declare @PONUMBER char(20)
select @PONUMBER = 'POXXXX'
```

1. Enter your Purchase Order number in place of **POXXXX** in the script.
2. Press (**Ctrl + T**) or select the **Results To Text** Button on the menu bar before executing to send the results to Text.
3. Execute the results against your company database.
4. Right-click the **results**, and Save As .rpt.

**OPTION 4:** Remove data in the ENC10111 for specific Purchase Orders (or all ENC10111) that are damaged and run reconcile on encumbrance and try the transfer again.

1. Run the tool to repair data to see if the tool fixes any of the POs. Then see if the transfer goes through. (**Microsoft Dynamics GP menu > Maintenance > Encumbrance Management > Routine Maintenance**) You'll want to use the **Detail based on Purchase Order**  and then **Summary based on Detail**. If not, move on to step 2.
1. Remove the ENC10111 table by running the following IN TEST.  I want to stress that you could be removing data that is fine in this step but you still have the integrity of the PO tables if research needs to be done for some reason. The reason the transfer can't complete is because there's a discrepancy between the ENC tables so it's the easiest way to rule this out. GP will replace this table with **net** amounts for each PO.

    ```sql
    -----------------
     DELETE ENC10111
    -----------------
    ```

    > [!NOTE]
    > If you only have one PO that won't transfer or clear off the transfer report, you can specify the specific PO to delete.

    ```sql
    DELETE ENC10111 WHERE PONUMBER = 'XXX'
    ```

1. Once the data in the table is removed, run the utility to repopulate the ENC10111 table. (Microsoft Dynamics GP menu > Maintenance > Encumbrance Management > Routine Maintenance). You'll want to use the **Detail based on Purchase Order**  and then **Summary based on Detail**  and try the Year End transfer again.
1. If you still have issues with the transfer, use the check data script from OPTION 3 and see if that PO is listed. Then continue with steps in that Option to fix the data.

The ultimate goal is to have the script in Option 3 run, year by year, and have no data returned which would mean that the year end transfer process can be processed without error.

**OPTION 5:** Disable and reenable encumbrance

If there's a large amount of corruption found, the best option may be to consider disabling encumbrance, moving all closed/cancelled Purchase Orders to history and then re-enabling encumbrance.
> [!NOTE]
> To move closed/canceled POs to history, use the Remove Completed Purchase Order routine to move the PO to the history file. Navigate to **Purchasing > Routines > Remove Completed Purchase Orders**.

You don't lose ANY purchase order processing data as long as you're set up to maintain history in POP setup. You only lose some of the old encumbrance  detail from historical years for Pos that are in history. You'll still be left with current outstanding encumbrances for the current years you have open purchase orders for.
