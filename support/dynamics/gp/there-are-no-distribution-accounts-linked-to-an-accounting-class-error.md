---
title: There are no distribution accounts linked to an Accounting Class error in Analytical Accounting
description: When you post a transaction in Microsoft Dynamics GP, you receive an error message that states there are no distribution accounts linked to an Accounting Class.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Analytical Accounting
---
# "There are no distribution accounts linked to an Accounting Class" error in Analytical Accounting for Microsoft Dynamics GP

This article provides resolutions for the error that may occur when you try to post a transaction in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2535754

## Symptoms

The below error message occurs when posting a transaction in Microsoft Dynamics GP:

> There are no distribution accounts linked to an Accounting Class.

## Cause 1

The account is not linked to an Accounting Class. See Resolution 1 below.

## Cause 2

The aaBrowseType may be incorrect for the account within the AAG20001 subledger distribution table. See Resolution 2 below.

## Cause 3

The Account Master table in Analytical Accounting (AAG00200) has not been populated or is missing accounts. See Resolution 3 below.

## Cause 4

Records exist in the AAG20000 series tables with an invalid header ID. See Resolution 4 below.

## Cause 5

The next available number in the AAG00102 table is out of sync with the last used number in the actual AA transaction table. Although with this method, they should also be experience Duplicate Key errors. See Resolution 5.

## Cause 6

Also received this message when trying to post GL batch:

> "The stored procedure aagValidateGLBatch returned the following results: DBMS: 245" followed by "There are no distribution accounts linked to an accounting class."

Missing records in the AAG10001 table.

## Resolution

Depending on the cause for this error message, refer to the appropriate resolution as follows:

### Resolution 1

Verify that the account is marked as being linked to an Accounting Class. To do this, select **Cards**, point to **Financial**, point to **Analytical Accounting** and select **Account**. Enter the account number. Verify that Class ID field is populated.

### Resolution 2

In SQL Server Management Studio, review the AAG20001 (aaSubledgerDist) table that stores all the distribution records associated with a particular subledger transaction. Each transaction should have at least two or more distributions (debit and credit) associated with it. You can cross-reference the Account Index to the GL00100 Account Master table in GL to be sure you are viewing the correct distribution line. Review the value listed in the aaBrowseType column. To be able to add AA data to this distribution line, you would want this field to show a '1' if the account is linked to AA.

The values in the aaBrowseType column mean:

0 - Not linked
1 - Required or Optional codes allowed
2 - AA Code is set to Required, but not filled in

A good starting point is to look for missing required codes (value of '2') and update those to a '1' to see if that resolves it.

```sql
select * from AAG20001 where aaBrowsetype = 2
```

> [!NOTE]
> To obtain a script (AA_Update_aaBrowsetype.sql) that will update the aaBrowseType column for all linked accounts to match the current setup for that account/class, you would have to open a support case for further assistance. To open a chargeable support case, you may call Microsoft Technical Support at 1-888-477-7877.

### Resolution 3

In SQL Server Management Studio, make sure the Account Master table (AAG00200) in Analytical Accounting has been populated.  This table should have the same number of records as the Account Master (GL00100) table and the Account Index Master (GL00500) in GL.

To repopulate the AAG00200 table, you can run the script below. This script will insert any missing accounts into the AAG00200 Account Master table that exist in the GL00100 Account Master table.

```sql
Insert into AAG00200 (ACTINDX,aaAcctClassID,aaChangeDate,aaChangeTime) select ACTINDX,0,convert(char(10),getdate(),111),convert(Char(12), getdate(),114) from GL00100 where ACTINDX not in (select ACTINDX from AAG00200)
```

> [!NOTE]
> If you delete the AAG00200 table and then run the script to repopulate it entirely, you will lose the link to the Accounting Class. In that case, all the accounts must be linked to the Accounting Class again.

### Resolution 4

If there are records in the AAG20000 subledger tables in AA with an invalid header ID of '0', this could cause issues. If there are invalid records in the AAG20000 series tables, the validation process checks to see if the distributions are linked to an Accounting Class, and may see these records as not linked and produce the error message above.

You can correct the problem by clearing out the records with an invalid header ID from the AAG20000 tables. Execute the scripts below in a query window in SQL Server Management Studio against the company database to see if there are any invalid records and if so, you may remove them:

```sql
Select * from AAG20000 where aaSubLedgerHdrID = 0 Select * from AAG20001 where aaSubLedgerHdrID = 0 Select * from AAG20002 where aaSubLedgerHdrID = 0 Select * from AAG20003 where aaSubLedgerHdrID = 0
```

> [!NOTE]
> Make sure to have a current backup that you can restore to before running any delete statements, in case you would need to restore for any reason.

### Resolution 5

For more information or steps on how to update the next available number in the AAG00102 table, see [Error message when you try to post Analytical Accounting transactions or save a Master record in Microsoft Dynamics GP: "Cannot insert duplicate key in object 'AAGXXXXX'"](https://support.microsoft.com/topic/error-message-when-you-try-to-post-analytical-accounting-transactions-or-save-a-master-record-in-microsoft-dynamics-gp-cannot-insert-duplicate-key-in-object-aagxxxxx-ac88e317-b184-91d6-1e58-5ccd7806ea4a).

### Resolution 6

Obtain the results of the GL10000, GL00001, AAG10000, AAG10001, AAG10002, and AAG10003 tables.  Review data and make sure the records are all there in the AA tables. May need to use insert script or run Distcorrect.sql to fix.

## More information

If you need further assistance with any of the resolutions listed above, please open a support case by contacting Microsoft Dynamics GP Technical Support at 1-888-477-7877. The support case will be chargeable.
