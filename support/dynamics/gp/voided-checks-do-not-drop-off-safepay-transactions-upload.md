---
title: Voided checks do not drop off SafePay Transactions Upload window
description: Voided checks do not drop off SafePay Transactions Upload window in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Voided checks not dropping off SafePay Transactions Upload window in Microsoft Dynamics GP

This article provides a resolution to get the voided checks to drop off the Safepay Transactions Upload window.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 2837937

## Symptoms

Voided checks don't drop off the Safe Pay Transactions Upload window and are included in each Safe Pay file generated going forward. The TRX Date may be displayed in the Safe Pay Transactions Upload window as 0/0/0000.

## Cause

This will happen if the following is true:

- The check was voided AFTER it was reconciled in Bank Rec.
- The void date was changed on the void from the original check date.

  This issue isn't considered a bug because checks that have been cashed and reconciled with the bank statement, shouldn't be voided. Instead, this idea is considered a product suggestion.

## Resolution

Going forward, the customer should investigate why they're voiding a check that has already been cashed and reconciled with the bank.

Workaround: If a reconciled check still needs to be voided, the user should leave the default check date as the void date, and this issue won't happen. Don't change the dates when voiding. This issue only happens when the void date is changed from the default check date.

Steps:

To get the checks to drop off the Safepay window, you'll need to update the date on the voided transaction to have the same check date as the original check.

1. Make a backup and set up in a test environment first, before doing this setup in your live database. If you don't have a test company, refer to this article for steps to set up a test company:

    [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211)

2. Open SQL Server Management Studio. Select the **new query** button at the top and select the company database.

3. Copy the below script into the query window and execute against the company database to find the check date (TRXDATE) for the original check: (You should find that the reconciled field (RECOND) is marked off (1), but the VOIDED field isn't (0) because when you void a reconciled check, it makes a new record in this table with a negative amount.) Note the TRXDATE for the original check.

    ```sql
    select RECOND, VOIDED, * from CM20200 where CMTRXNUM = 'xxx'
    
    --insert in the check number for the xxx placeholder above.
    ```

4. Now execute these scripts to view the dates for this check in all the tables:

    ```sql
    select TRXDATE, * from CM20200 where CMTRXNUM = 'xxx' 
    select TRXDATE, * from ME123504 where CMTRXNUM = 'xxx' and CMTRXTYPE = 4 
    select VOIDDATE, * from ME123506 where CMTRXNUM = 'xxx' 
    
    --insert the check number for the xxx placeholder in the scripts above before executing.
    ```

5. Then run these scripts to find the corresponding records update the corresponding void records to also have this same date as you found in the prior step:

    ```sql
    update CM20200 set TRXDATE = 'YYYY-MM-DD' where CMTRXNUM = 'xxx' 
    update ME123504 set TRXDATE = 'YYYY-MM-DD' where CMTRXNUM = 'xxx' and CMTRXTYPE = 4 
    update ME123506 set VOIDDATE = 'YYYY-MM-DD' where CMTRXNUM = 'xxx' 
    
    --insert the date you found in step 3 in for the YYYY-MM-DD placeholder and 
    the check number for the xxx placeholder in the scripts above before executing.
    ```

6. Now generate the Safe Pay file, and both the void and the check should be listed again, but will then drop off the window after that and be gone from the window going forward.

7. If you get the wanted results, then do the same steps in your live database.
