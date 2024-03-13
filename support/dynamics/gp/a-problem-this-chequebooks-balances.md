---
title: A problem with this Chequebook's balances 
description: Provides a solution to an error that occurs when opening the Bank Statement Reconcile window.
ms.reviewer: cwaswick, jegrant 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Cashbook Management Reconciliation Error: "There is a problem with this Chequebook's balances"

This article provides a solution to an error that occurs when opening the Bank Statement Reconcile window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3151337

## Symptoms

Cashbook Management Reconciliation Error when opening the Bank Statement Reconcile window:

> "There is a problem with this Chequebook's balances"

## Cause

This error usually occurs in CBM when the prior reconcile event for the Chequebook in question was interrupted or didn't complete successfully. The CBM reconcile tables may be in varied states of update and/or possibly missing data because of the incomplete prior activity.

Review this data: (Update the XXXX placeholder with your chequebook ID)

```sql
select * from CB900025 where CHEKBKID = 'XXXX' order by CB_Period

select * from CB900035 where CHEKBKID = 'XXXX ' order by CB_Reconciled_Date

select * from CB200001 where CHEKBKID = 'XXXX' order by DATE1

select * from CB400005 where CHEKBKID = 'XXXX'

select * from CB900036 where CHEKBKID = 'XXXX'
```

## Resolution

It's always a good idea to do so in a TEST environment before updating the LIVE in the same manner.

The main SQL tables involved in the CBM Reconcile Process are the following ones:  

- CB900025 (Cashbook Periods)
- CB110001 (Recon Details Master)
- DYNAMICS..CBINT605 (DYNAMICS Reconciled amounts)
- CB600005 (Company Reconciled amounts)
- CB600001 (Reconcile Setup)
- CM00100 (Checkbook Master)
- CB200001 (Recon Transaction)
- CB400005 (History Recon Transaction)
- CB900035 (Enquiry Transactions)
- CB111005 (History Recon Cheque Trn)
- CB333555 (History Recon Deposit Transaction)

Of the tables, the CB900025 is the main table and contains field values that are calculated when the CBM Reconcile window is opened.

If the current and calculated field values in CB900025 don't tie out correctly, the error above will occur and the user can't continue with the reconcile.

To troubleshoot the cause of this error, the following SQL statement can be ran against the erring company db:

> [!NOTE]
> Replace XXX with the chequebook in question and ### with the period being reconciled.

```sql
DECLARE @CHEKBKID CHAR(15)
DECLARE @PERIOD int

SELECT @CHEKBKID = 'XXX'
SELECT @PERIOD = ###

select (CB_Opening_Balance - CB_Payments + CB_Deposits) as calc1,
(CB_Statement_Balance - CB_Outstanding_Payments + CB_Outstanding_Deposits) as calc2,
((CB_Opening_Balance - CB_Payments + CB_Deposits) -
(CB_Statement_Balance - CB_Outstanding_Payments + CB_Outstanding_Deposits)) as diff
from CB900025 where CHEKBKID = @CHEKBKID and cb_period = @PERIOD
```

If the **diff** value returned by the SQL script isn't **0**, it would outline why the Problem error is occurring when attempting the new reconcile.

The most common correction route would be to use SQL update the CB_Opening_Balance field for the amount of the difference of the calc1/calc2 values so the **diff** amount equals **0**, the next time the reconcile window is populated for the chequebook.

It's the only SQL option for CB900025 as the rest of the referenced fields are calculated values that will reset once the reconciliation attempt begins.  

Recommended SL scripting to change the **diff** value automatically:

> [!NOTE]
> Replace XXX with the chequebook in question

```sql
DECLARE @CHEKBKID CHAR(15)
SELECT @CHEKBKID = 'XXX'

update CB900025
set CB_Opening_Balance = CB_Opening_Balance -
((CB_Opening_Balance - CB_Payments + CB_Deposits) -
(CB_Statement_Balance - CB_Outstanding_Payments + CB_Outstanding_Deposits))
where CHEKBKID = @CHEKBKID and CB_Open_Closed=1
```

Running the above scripting should allow the user to open the window without error and start completing the new reconcile to determine what the needed correction route would be.

For example, because of the failed prior process, there may more items to include in the Reconcile or expected items completely missing.

In this state, the user can fill the new reconcile as much as possible with the existing data before saving the reconcile and selecting 'Final Reconcile', which will then populate the Bank Statement Balance for the user.

The amount difference between the Cashbook Balance and the Statement Balance will outline the adjustment needed to match the CBM Balance with the Balance from the Bank Statement to complete the reconcile effectively.

For instance, say you open the window and meet the Problem error so you run the SQL statement above to resolve the error.

When you complete the reconciliation (including all associated new & old entries), you find the calculated Statement Balance of $100 doesn't match with the Statement Balance provided by the bank of $150.

When the $150 figure is entered manually by the user and they attempt to complete the reconcile, Microsoft dynamics GP will generate the following error:

> - Bank statement balance is not equal to Calculated statement balance. This recon cannot be posted.

To correct this issue and insure the CBM amount matches with the bank, you can do the following steps:

1. Close the reconcile window without doing a Final Reconcile.
1. Do a dummy GL Deposit transaction in CBM for $50:

    - Insure you use the same date as the current reconcile for the transaction.
    - Use the GL Type option so new transactions aren't created in other modules (other than GL).
    - Delete or void the resulting GL transaction created with the dummy entry.
1. Reopen the reconcile and include the dummy transaction in the reconcile.
1. Complete the Final Reconcile.

As far as missing data, there isn't a tool or utility to replace the missing item(s) effectively in the CBM tables. Our data-fixing support options would also be limited as the extent of the interruption may make such data replacement an infeasible activity.

As such it's always the best recommendation to:

1. Insure a new backup is made of the company db before Final Reconcile being selected, and

1. Restore from the backup if any posting/processing interruption occurs during the Final Reconcile / posting activity.

The following content is additional information to note on the SQL tables involved in the CBM reconcile process:

1. CB900025 (Cashbook Periods):

    - CB_Opening_Balance=CB_Closing_Balance amount of the prior period
    - Current CB_Period: CB_Closing_Balance=0
    - Current CB_Period: CB_Payments=0
    - or - sum(CB_Recon_Paid_AMT) in CB200001 with DATE1 value less than current reconcile date
    - Current CB_Period: CB_Deposits=0
    - or - sum(CB_Recon_Received_AMT) in CB200001 with DATE1 value less than current reconcile date
    - Current CB_Period: CB_Closing_Date=0,
    - CB_Opening_Date=CB_Closing_Date of prior CB_Period
    - Current CB_Period: CB_Satement_Balance=CB_Closing Balance - CB_Outstanding_Deposits + CB_Outstanding Payments
    - Current CB_Period: CB_Opening_Statement_Bal=CB_Closing_Balance amount of prior CB_Period
    - CB_Open_Closed=0 (All prior CB_Periods); CB_Open_Closed=1 (Current CB_Period)
    - Current CB_Period: CB_Outstanding_Deposits=sum(CB_Recon_Received_AMT) of CB200001 for DATE1 value less than 'Include Transactions to' date of current reconcile (calculated when Transaction Reconcile window opened)
    - Current CB_Period: CB_Outstanding_Payments=sum(CB_Recon_Paid_AMT) of CB200001 for DATE1 value less than 'Include Transactions to' date of current reconcile (calculated when Transaction Reconcile window opened).

2. CB110001 (Recon Details Master):

    - CB_Date_Last_reconciled=CB_Closing_Date of last successful CB_Period in CB900025.

3. DYNAMICS..CBINT605 (DYNAMICS Reconciled amounts):
    - DATE1=CB_Closing_Date of corresponding CB900025 record
    - CB_GL_Balance=CB_Closing_Balance of corresponding CB900025 record
    - Note: Current CB_Period won't have a record in this table.

4. CB600005 (Company Reconciled amounts):
    - DATE1=CB_Closing_Date of corresponding CB900025 record
    - CB_GL_Balance=CB_Closing_Balance of corresponding CB900025 record
    - Note: Current CB_Period won't have a record in this table.

5. The CB600001 (Reconcile Setup):
    - CB_Last_Statement_Balance=CB_Closing_Balance of last successful CB_Period in CB900025
    - DATE1=CB_Closing_Date of last successful CB_Period in CB900025.

6. CM00100 (Checkbook Master):
    - Last_Reconciled_Date=CB_Closing_Date of last successful CB_Period in CB900025
    - Last_Reconciled_Balance=CB_Closing_Balance of last successful CB_Period in CB900025.

7. CB200001 (Recon Transaction):
    - Contains CBM records that will be available for selection of current CB_Period reconciliation.
    - Records pushed to CB400005 after successful reconciliation.

8. CB400005 table (History Recon Transaction):
    - Contains CBM records from prior reconciliations.

9. CB900035 table (Enquiry Transactions):
    - CB_Period=CB_Period of corresponding reconcile event.
    - CB_Status=1 (Not Reconciled); 2 (Reconciled)

> [!NOTE]
> Table can be recreated by deleting it with SQL and selecting **Update from Recon** from the **Transaction Enquiry / Void window (Enquiry | Financial | Bank Management | Transaction Enquiry)**.

## More information

The above information was published externally in [Cashbook Management Reconciliation Error: "There is a problem with this Chequebook's balances"](https://community.dynamics.com/blogs/post/?postid=e9e4c726-6147-406e-80d6-0d049696a3c0).
