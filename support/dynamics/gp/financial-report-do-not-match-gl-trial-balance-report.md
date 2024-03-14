---
title: Financial Reports from Management Reporter don't match the General Ledger Trial Balance Reports
description: Provides steps to solve the issue that financial reports from Management Reporter don't match the General Ledger Trial Balance reports in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Financial Reports from Management Reporter don't match the General Ledger Trial Balance Reports in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2910626

## Symptoms

Many different reporting tools can be used to prepare Financial reports used to balance to the GL Trial Balance Report in Microsoft Dynamics GP. So you must determine if your Financial reports are reading from GL data only, or if AA data is also being used. If AA data is being used to prepare the Financial reports, they may be skewed if the data in the AA tables doesn't match the data in the GL tables.

- Management Reporter with Data Mart will read from AA tables if AA has been activated. This is by design in versions up to CU9.
- Management Reporter with Legacy provider allows you to choose if you want to pull from an AA company or a GL company.

## Cause

Financial reporting may be incorrect, if AA data was used to assemble the report, and your AA data doesn't match GL data. Records may be missing from AA tables, or may be skipped if they differ from the corresponding record in GL.

There are several reasons that the AA data may not match the GL data or have issues, including:

- The Analytical Accounting module hasn't been installed on all workstations, where users are keying/posting transactions. Therefore, the record exists in GL, but not AA.
- Users are disabling the Analytical Accounting module if they received any error referencing 'aa', so AA tables aren't updated.
- Records are being imported directly into GL tables, and not AA tables. Or users are disabling AA if they receive any 'aa' errors during the import process.
- Users are closing the GL year on a workstation where AA hasn't been installed. As a result the AA records aren't moved to history and no Balance Brought Forward journal entry is created in the AA tables.
- Management Reporter may not read the AA record if the currency ID differs between the AA record and the corresponding record in GL, which could be caused by importing records, activating Multicurrency, or any quality issues with currency IDs that have since been fixed.
- The Dynamics database was restored over itself, causing the 'Next Available Number' (in the AAG00102 table) to be set back to a value that has already been used. This system will increment off of this value for the next header ID value as it inserts new records into the table, and so it can duplicates if it's inserting in a heard ID value that has already been used.
- If you upgrade to Microsoft Dynamics GP 2013 and set a functional currency ID, but aren't registered for Multicurrency, or you don't run check links as instructed after setting up the functional currency.
- Posting interruptions

## Resolution

If you need assistance to correct any of the results returned from the scripts below, open a support incident using the categories below to reach the correct Support Engineer Team. Include the information as noted within each step.

- To open a support incident online, use this link: [https://serviceshub.microsoft.com/supportforbusiness](https://serviceshub.microsoft.com/supportforbusiness).
- Use the Support Topic: Financial - Analytical Accounting, and the Sub-Topic: Data Consistency Issues.
- To reach the Message Center to open a support incident, call 1-888-477-7877. And provide as many details as you can.
- Note that the support incident may be time consuming so please allow ample time to work with the Engineer.
- The support incident will be chargeable unless the only cause is determined to be a known quality issue in Microsoft Dynamics GP. If multiple issues are addressed, the case will remain chargeable.
- The scope of the support incident will include fixing all the data returned by the SQL scripts below, within the guidelines of what we can do in a regular support case. If additional assistance is needed to find the "root-cause", this will require a new support incident to be opened. Some of the causes are common as explained in the Cause section above. However, for example, if you determine a currency ID difference exists on records that were imported into Microsoft Dynamics GP, this would require a new support incident to be opened to work with the eConnect/Integration Manager Support Team. The engineer maintains the discretion to advise when a new support incident is needed or when it may become a consulting engagement.
- One support case can be opened initially, with the results of all of the scripts from steps 1-10 below. The Engineer will work with you in ONE company, and you'll be expected to correct the other companies on your own, using the same steps as the Engineer provided you for the first company. Additional assistance with multiple companies may require a new case and is up to the Engineer's discretion.

### Steps

- Copy/download the SQL scripts below, and execute against the company database in SQL Server Management Studio. Data returned by any of these SQL scripts below will cause Financial Reports in MR-Data Mart not to balance with GL Trial Balance reports.

  > [!IMPORTANT]
  > Make a current backup of the company database before running any scripts that will update data.

- For more information, see [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](set-up-a-test-company.md).

> [!NOTE]
> To view the results of each script in Text, you can press ALT - T (or select **Query** in the top menubar, point to **Results To**, and select **Results to Text**) and then execute the script again. This will provide more details for each section of results returned.
>
> The KB_AllAAFindScripts.zip file contains all the scripts for steps 2,3,4,6 and 9, so you only need to download it once, but the same link is provided in all of these steps.

#### Step 1 - Distinct years

Run the scripts below to verify that the years are distinct in each table and don't overlap with each other, and also are consistent with the years in the GL tables. The same years should be in the AAG30000 as the GL20000 table, and the AAG40000 table with the GL30000 table. No years should overlap between the AA tables, or between the GL tables. If you find the same year listed in both open and history tables or scrambled between the tables, or not consistent with the years in the GL tables, open a support case for further assistance and include the results of all scripts.

```sql
select distinct(YEAR1) from AAG30000 order by YEAR1
select distinct(YEAR1) from AAG40000 order by YEAR1
select distinct(OPENYEAR) from GL20000 order by OPENYEAR
select distinct(HSTYEAR) from GL30000 order by HSTYEAR
```

#### Step 2 - Find currency ID discrepancies

Download KB_AllAAFindScripts.zip* file and use the AA_FindCurrencyDiscrepancy.sql script for Step 2 to identify transactions where the Currency ID doesn't match between GL and AA tables in both open and history:

[https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411](https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411)

(*The zip file contains the scripts for steps 2, 3, 4, 6, and 9.)

- If you don't use Multicurrency, or just use only one currency ID, you can update the **CURNCYID** and **CURRNIDX** fields directly in the AA (AAG30001/AAG40002) or GL (GL20000/GL30000) tables. Test to make sure the currency ID is matching on recently keyed transactions to ensure there isn't an ongoing issue. Open a support incident if you need assistance to update the **CURNCYID** directly in the SQL table, or if you're able to recreate this on a current transaction.

- If Multicurrency is being used, open a support incident and include the following:

  - Provide the results of the script in text format. We need to know which table had the currency ID and which table didn't. And are these older or newer transactions? If older transactions and you just installed Multicurrency Management, did you run check links on Multicurrency Setup? Check links should go back and update the currency ID on all existing transactions.

  - What version of Microsoft Dynamics GP are you using?
  - Where did the transactions come from? Test to see if this is an ongoing issue. Verify if Multicurrency Management is marked in the **Registration** window (under Microsoft Dynamics GP, go to **Tools** > **Setup** > **System** > **Registration**.)
  - What is your functional currency? How many currency IDs do you use?

#### Step 3 - Find unmatched distributions

Download the KB_AllAAFindScripts.zip* file and use AA_FindUnmatchedDists.sql script for Step 3 to identify if any detailed data doesn't match between the AA and GL tables. If any results are returned, open a support case for further assistance. And attach the file of results in text format. These problem records are usually due to importing issues, or users working on a workstation where AA was disabled or not installed.  

[https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411](https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411)

(*The zip file contains the scripts for steps 2, 3, 4, 6, and 9.)

> [!NOTE]
> This script should not be used for versions lower than Microsoft Dynamics GP 10.0 SP2, or where you have not yet completed a GL year-end close on a version higher than that (ie. where pre-SP2 AA data has not yet been moved to history at all).
>
> be aware that "result totals" may show in-between the sections and are misleading. These result totals are a factor of how the script was written and can be ignored. You only need to be concerned with "result totals" that are immediately following a "section" and returned actual data.

#### Step 4 - Find duplicate AA code IDs

Download the KB_AllAAFindScripts.zip* file and find the AA_FindDupaaTrxDimCodeID_AAG00401.sql script for step 4 to see if any AA code IDs are duplicated (due to being imported). If any results are returned, please open a support case for further assistance. Attach the results of the script in text format, and also the contents of the AAG00401 table. We can provide you the steps to resolve this, but having Microsoft do this for you may be a consulting expense. This issue is caused by importing, or by restoring an older copy of the Dynamics database over itself.

[https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411](https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411)

(*The zip file contains the scripts for steps 2, 3, 4, 6, and 9.)

#### Step 5 - Find duplicate AA header IDs

Execute the below script to determine if you have header IDs duplicated between the AA open and historical tables. We can provide the steps to resolve this, but having Microsoft do this for you may be a consulting expense. This issue is caused by importing, or by restoring an older copy of the Dynamics database over itself, or a posting interruption.

```sql
select aaGLHdrID from AAG30000 where aaGLHdrId in (select aagLHDrId from AAG40000)
```

or

```sql
select a.aaGLHdrID, a.JRNENTRY as OPEN_JE#,a.YEAR1 as 'OPEN_YEAR1',
b.JRNENTRY as 'HIST_JE#', b.YEAR1 as 'HIST_YEAR1' From AAG30000 a (nolock)
join AAG40000 b (nolock) on a.aaGLHdrID = b.aaGLHdrID
where a.JRNENTRY <> b.JRNENTRY
```

If any results are returned, please open a support case and include the following information:

- Results of the script in text format.
- Research the records and advise if they're the exact same record, or if they're different records, but just have the same Header ID only.

#### Step 6 - Find mismatched Sequence Numbers (for P&L entries)

Download the KB_AllAAFindScripts.zip* file and run the AA_FindYEC_RetainedEarnings.sql script to look for records where the Sequence Numbers don't match between AA and GL between open and history tables for the Retained Earnings journal entry (SOURCDOC ='P&L'). If any results are returned, open a support case and include the results of the script in text format. (Note that if you had any results in Step 3 above for the 'GLSEQNMBR' sections, we'll want to have you fix those first and then run this script again for step 6, so we don't need your results now for step 6 if you had results in Step 3.)

[https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411](https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411)

(*The zip file contains the scripts for steps 2, 3, 4, 6, and 9.)

> [!NOTE]
> It is possible to get results with this script above if you currently have P&L entries with multiple distribution lines with the same ACTINDX, and the data is actually valid. You should compare the SEQNUMBR between the AAG30001 and GL20000 (or AAG40001 and GL30000) for your results returned, and if the SEQNUMBR matches, then you may ignore the MR validation errors for the SEQNUMBR and proceed.

#### Step 7 - Find missing BBF entries

If you find that your Financial reports are off by the amount of the beginning balances, the Balance Brought Forward (BBF) entries may be missing from the AA tables. Run the scripts below to determine if the BBF entries in GL are missing from AA tables. This is caused by the user closing the GL year on a workstation where AA was disabled or not installed. For Microsoft Dynamics GP 2013 SP2 and prior versions, you'll need to have a consulting service opened to reopen the GL year. If you're Microsoft Dynamics GP 2013 R2 or later versions, you can use the **Reverse Historical Year** checkbox in the GL year-end closing routine to reopen the year, and then reclose it again on a machine where the AA code is installed, so the BBF's entries are created in both the AA and GL tables.

```sql
PRINT 'OPEN year missing BBF'
Select distinct (JRNENTRY) from GL20000
where JRNENTRY not in (select JRNENTRY from AAG30000)
and SOURCDOC in ('BBF','P/L')
PRINT 'HISTORY year missing BBF'
Select distinct (JRNENTRY) from GL30000
where JRNENTRY not in (select JRNENTRY from AAG40000)
and SOURCDOC in ('BBF','P/L')
```

#### Step 8 - Known issue for AA budgets (in Microsoft Dynamics GP 2010 and Microsoft Dynamics GP2013 only)

In Microsoft Dynamics GP 2013 and Microsoft Dynamics GP 2010, there was a known quality issue (#69354 TFS/69692 PS) where the top level of the budget tree will have an incorrect value in the AAG00902 table (`aaLvlCodeString` field) if you proceed to modify the budget. Management Reporter looks for a blank value in this field to identify the main record for the budget tree and so this incorrect value causes MR reports to fail and no AA budget data is returned. This issue was fixed in Microsoft Dynamics GP 2013 R2 (12.00.1745). SQL scripts are provided below to execute against the company database to look for this issue and also to resolve it.

```sql
Select * from AAG00902 where aaLvlCodeString <> '' and aaLevel = 0
```

If the above script returns any results, you can resolve the issue by running this script against the company database:

```sql
update AAG00902 set aaLvlCodeString = '' where aaLevel = 0
```

#### Step 9 - AAG30002/AAG40002 sum totals don't match AAG30001/AAG40001

The sum of the allocated records in the AAG30002/AAG40002 tables should match the sum of the amounts in the AAG30001/AAG40001 distribution tables per transaction. If the amounts are allocated to several AA codes, you can have a different number of records between these tables, but the important part is that they match in 'sum' total per transaction. MR reports won't read the records if the sum totals don't match between these tables for each transaction. Download the "find and compare" scripts for the open and historical years below and execute against the company database.

> [!NOTE]
> If you had any results in Step 3 above for the 'AAG30002/AAG40002' sections, we will want to have you fix those first and then run this script again for step 9, so we don't need your results now for step 9 if you had results in Step 3.

Download the KB_AllAAFindScripts.zip* file from the link below and use the AA_CompareAAG30001AndAAG30002SummaryValues.sql for the current open AA year for Step 9 and the AA_CompareAAG40001AndAAG40002SummaryValues.sql script for the historical year for Step 9.

[https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411](https://mbs2.microsoft.com/fileexchange/?fileID=622816f0-ae1d-4768-a914-e710ec50f411)

(*The zip file contains the scripts for steps 2, 3, 4, 6, and 9.)

If any results are returned from either script, save the results to an `.rpt` file and open a support case for further assistance. Attach the results for review.

#### Step 10 - Debits/credits on same distribution line

MR isn't able to read records where both the debit and credit fields are populated on the same distribution line. Known causes may be "importing" in the records in that condition, or having used the Standard Cost Utility in Inventory with an override. You can run the SQL query scripts below against the company database to help identify these records. To fix the records, you'll need to update the record directly in the GL/AA SQL tables to "net" the amount on either the debit or credit field, as only one of these fields should be populated. It's suggested to fix each record manually one by one using the Dex_Row_Id. (If you need scripts to do this in mass, please consult your Microsoft Partner for assistance.) Use the scripts below to find the problem records:

```sql
select JRNENTRY,CRDTAMNT,DEBITAMT,ORCRDAMT,ORDBTAMT,* from GL10001 where (CRDTAMNT<>0 and DEBITAMT<>0) or (ORCRDAMT<>0 and ORDBTAMT<>0) 
select JRNENTRY,CRDTAMNT,DEBITAMT,ORCRDAMT,ORDBTAMT,* from GL20000 where (CRDTAMNT<>0 and DEBITAMT<>0) or (ORCRDAMT<>0 and ORDBTAMT<>0) 
select JRNENTRY,CRDTAMNT,DEBITAMT,ORCRDAMT,ORDBTAMT,* from GL30000 where (CRDTAMNT<>0 and DEBITAMT<>0) or (ORCRDAMT<>0 and ORDBTAMT<>0) 
--if using AA, also compare the AA tables:

select AAG0.JRNENTRY  from AAG30001 AAG1
join AAG30000 AAG0 on AAG0.aaGLHdrID = AAG1.aaGLHdrID
where ((AAG1.DEBITAMT <> 0 and AAG1.CRDTAMNT <> 0) or (AAG1.ORDBTAMT <> 0 and AAG1.ORCRDAMT <> 0)) and AAG1.SOURCDOC not in ('BBF','P/L')

select AAG0.JRNENTRY  from AAG40001 AAG1 join AAG40000 AAG0 on AAG0.aaGLHdrID = AAG1.aaGLHdrID 
where ((AAG1.DEBITAMT <> 0 and AAG1.CRDTAMNT <> 0) 
or (AAG1.ORDBTAMT <> 0 and AAG1.ORCRDAMT <> 0)) 
and AAG1.SOURCDOC not in ('BBF','P/L')
```

#### Step 11 - Rebuild the data mart

After all of the results have been fixed above, rerun each script to make sure no results are no longer returned.

Then rebuild the Data Mart in Management Reporter and generate your Financial reports again. (With SQL Change Tracking, some changes may update automatically, but not all, and therefore we consider it best practice to rebuild the Data Mart if any changes were made directly in SQL to ensure all changes are recognized.) Here are the steps to do this (as a precaution, you can back up the DDM database, as this will be deleted and re-created):

1. Open the Configuration Console on the server from the **Start** menu.
2. In the left hand navigation pane, select **ERP Integrations**.
3. Select the integration being used (note the server name and the database names), and disable the integration with the "Disable Integration" button.
4. Select **Remove** to remove the ERP Integration.
5. Select the **Management Reporter Services** in the left hand navigation and stop both of the Management Reporter Services.
6. Delete the DDM database in SQL (you can make a backup first, if needed).
7. Start the Management Reporter Services.
8. Configure the ERP Integration again by going to **File** > **Configure**.
9. Once the setup is completed, enable the ERP integrations.

With the AA data corrected, and the DDM updated MR should pull in the correct values.

#### Step 12 - Verify report balances

Determine if the report balances to the GL Trial Balance report or not. If not, see if you can determine what the difference is. Is the difference still related to the Balance Brought Forward Entries not being correct? If so, open a support incident for further assistance.

## More information

For more information, see [The Year-end close procedures for Analytical Accounting in Microsoft Dynamics GP](https://support.microsoft.com/help/960356).
