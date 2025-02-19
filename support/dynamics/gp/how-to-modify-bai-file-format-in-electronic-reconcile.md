---
title: Steps to modify BAI file format in Electronic Reconcile
description: This article explains how to set up and modify the BAI file format in Electronic Reconcile in Microsoft Dynamics GP 2013 to use the standard Version 2 BAI file format.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Steps to modify the BAI file format in Electronic Reconcile in Microsoft Dynamics GP

This article contains steps to set up and/or modify the BAI (Bank Administration Institute) file format with Electronic Reconcile to comply with the Version 2 standard BAI format as published by the BAI Institute.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 2872105

## Summary

The default BAI format in Microsoft Dynamics GP contains 9 fields across in the Detail line. The standard published Version 2 BAI format contains 7 fields in the Detail line, so the configurator may need to be modified to match your bank file. (Be sure to check your bank file, as banks may vary on how many fields they provide in the Detail line.) If you do not have the same number of fields in the line, Microsoft Dynamics GP will hang or crash. You will most likely need to modify your file for the Detail **16** line.

> [!NOTE]
> In Microsoft Dynamics GP 2013 (RTM and SP1 versions), there was a known Quality Issue PS #69688 where if you had the check number as the last field in the detail line followed by the slash delimiter ('/') and Microsoft Dynamics GP would bring in the slash as part of the check number. This issue was fixed in Service Pack 2 (12.00.1482) for Microsoft Dynamics GP 2013. The work-around was to remove the slash from the file as Microsoft Dynamics GP didn't need it (if your file contained a carriage return at the end of each line, which is often found in .txt or .csv files).
>
> There was a known issue (TFS 70443) where files with .bai or .dat extensions (which typically may not have carriage returns at the end of each line) will cause Microsoft Dynamics GP to crash. This issue was fixed in Microsoft Dynamics GP 2013 R2 (12.00.1745), and there is no other work-around.

## Resolution

Set up or modify the BAI configurator as follows:

1. First, very that each Bank Account number used in the bank import file matches the Bank Account Number on one of the Checkbooks that you have tied to this Bank Download ID in the Download Maintenance window in Microsoft Dynamics GP. To do this:

    1. Save the bank import file to your desktop or another location of your choice. Right-click on your bank import file and open it with Notepad.
    2. Look for all the Account Header lines in the file (lines that begin with code '03') in the file.
    3. The 2nd field in the Account Header line contains the Bank Account Number. Jot down all the Bank Account Numbers from all of the Account Header Lines in the file. You will need to verify that each account number exists on a checkbook in Microsoft Dynamics GP.

    4. In Microsoft Dynamics GP, select **Cards**, point to **Financial**, and select **Checkbook**. Select the Checkbook ID you want to use and verify that the BANK ACCOUNT field matches the Bank Account Number you found in the bank file. (It must match *exactly*, so if the Bank Account number has leading zeroes in the bank file, you must also key those on the checkbook setup.) You should have one checkbook ID per Bank Account Number used in the file.
    5. Now select Microsoft Dynamics GP, point to **Tools**, point to **Routines**, point to **Financial**, point to **Electronic Reconcile**, and select **Download Maintenance**. Select the Bank Download ID you are working with, and verify that each Checkbook ID is added that contains the Bank Account Numbers that are used in the bank file you are trying to import in.

       - If you import in a file that has a Bank Account on an Account Header line that doesn't exist on one of the checkbooks tied to this Bank Download ID, the Unprocessed Data Records Report will show the message:

         > Bank Account number from the text file could not be matched to a checkbook account number.

2. When you have the bank import file open with Notepad, also verify the following:

    - Ensure that no lines are longer than 244 characters. *GP will crash on character 245 within a line*. This is the current design, and not a quality issue. You may choose to shorten lines longer than 244 characters, or inquire to the bank to not create lines longer than 244 characters. If any concerns, log a product suggestion. For testing, you can shorten the description field in the line, to make the line shorter than 244 characters.
    - Look for any lines that do not begin with one of the Record Type codes in the configurator file (see next step). Blank lines are okay.
    - It is okay to have the same Bank Account number in more than one Account Header line (begins with '03'), as long as only ONE checkbook ID has this account number. The system will not read the line if the same bank account number is on more than one checkbook ID in Microsoft Dynamics GP.

3. Create a new configurator using the BAI format. To do this,

    1. Select Microsoft Dynamics GP, point to **Tools**, point to **Routines**, point to **Financial**, point to **Electronic Reconcile** and select **Configurator**.
    2. Enter a name for the Bank Format and a Description (as desired).
    3. For the File Format, select **BAI**, and the rest of the file will automatically populate.
    4. Map the Detail line of the configurator to match your bank file. To do this:

        1. In the configurator, select the **DETAIL** line (in the middle section, that has a Record Type Code of '16').
        2. In the far right column for this line, change the # of Fields from '9' to '7' (or as needed per your bank file). (In Notepad, review the Detail rows [rows that begin with code 16] in the bank file, and verify how many fields across you will need, as it may not necessarily be 7.)

           - When you tab off the line, you will get prompted **Fields will be removed from the bottom of the list. Is this OK?** Select **Remove** to have the respective number of fields removed.

4. Next, remap the Detail line in the configurator, to match your bank file. To do this:

    1. In the configurator, select the Detail line again [line that begins with 16] to select it and the number of fields will display below.
    2. Select Field 5 and change the Bank Cleared Date to Filler/Ignore. if the bank file doesn't have an actual date in this field (or map it to the correct field type per your bank file.)
    3. Remap the Check/Serial Number field to the correct line, as needed per your bank file.

5. Still in the configurator, do the steps below to set up the Transaction codes:

    1. In the configurator, select the **CODES ENTRY** button.
    2. If this is a brand new install, you must select the CHECK PAID transaction type and select **Save**. Then select DEPOSIT CLEARED transaction type and select **Save** again. You must do this on a brand new install the very first time, so it will recognize the default codes for these transaction types. So save these codes once, and you will not need to do this again on this Microsoft Dynamics GP install again, even if you set up other configurators, or delete any existing configurators. This is a one-time step needed, (but never hurts anything to press SAVE in these windows either). This action will have the default codes be recognized by the system.

    3. In the Codes Entry window, verify that all the Transaction Type Codes used in your bank file (the second field in each Detail line [that is, line that begins with '16']) exists in one of the Transaction Types. Be aware that not all codes are supplied by the default format in Microsoft Dynamics GP, so you may need to add some.

        - The Transaction Code is the second field in the Detail line (line begins with '16'). Make sure all these codes used in the file are represented in the Codes Entry window under one of the categories. If you have a type that doesn't exist, use the Other category and you will have to manually reconcile this transaction in your Bank reconciliation.
        - Transfer Credit and Transfer Debit do not have any default codes included in the format, so you will have to add those codes if needed if you have bank transfers in the file. (The code 277 is common for Transfers Credits, and 577 is common for Transfer Debits, but these codes may vary by bank.)
        - If there are any codes in the file that do not exist in the Codes Entry in the configurator, the Unprocessed Data Records Report will show the message:

          > Transaction Code Type match not found for detail record. Code not found = XXX

          The XXX will indicate to you what code should be added.

6. IMPORTANT: If you are using Microsoft Dynamics GP 2013 (RTM or SP1 versions) and have the Check Number mapped as the last field of the Detail line, and it is immediately followed by the slash delimiter in the bank import file, the slash will come in as part of the check number. This was fixed in Microsoft Dynamics GP 2013 SP2. So if you are using Microsoft Dynamics GP 2013 RTM or SP1, you may need to do these extra steps:

    > [!NOTE]
    > You can skip this step if you are using Microsoft Dynamics GP 2013 (SP2 or later versions).

    - Open the configurator file and unmark the checkbox next to Record Delimiter.
    - Open the bank import file and do a Find/Replace ALL. Find the slash '/' and replace it with a comma ','

7. Test importing in the bank file. Note the following:

    - Review the Unprocessed Data Records Report for additional errors.
    - If GP hangs, review the ME142804 table in SQL Server Management Studio to determine what record it is having an issue with. This will give a hint on what line it is failing on and where to start looking.
    - Also, if you are testing Electronic Reconcile for the first time and are not using it in any other checkbook yet, we suggest going the Download Summary window, select the Bank Download ID and select **DELETE ALL** in between each time you try to bring in the same file. If you don't remove the prior download, it will cause issues with bringing in the same file again.

## More information

Q1: When I try to bring in the Bank file, GP just hangs or doesn't bring in any records. What should I check first:

A1: There are many reasons that GP can hang, but it is usually because the bank account number in the file doesn't match any of the checkbooks mapped, or the number of fields in the Detail line of the bank file doesn't match the number of fields for this line in the configurator file. Check the following:

1. Make sure the Bank Account Number on each '03' line in the bank file *exactly matches* the Bank Account number on a Checkbook ID that is linked in Download Maintenance window. Any leading zeroes must also match.
2. Make sure the Bank Account number is used on only ONE checkbook ID in Microsoft Dynamics GP.
3. Make sure the DETAIL ('16' line) in the Configurator file has the same number of fields as all the '16' lines in the bank file. Count how many fields are in the '16' line in the bank file, and be sure to look at a check and a deposit line.
4. Make sure that all the lines in the Bank File start with a Record Type code that the configurator has mapped. (I've seen some lines start with a '--' and this would cause the system to hang.) Blank lines should be okay.
5. Make sure you have gone into the configurator file, and clicked SAVE for the Check Paid and Deposit Cleared types. This must be done *once* on a new install of Microsoft Dynamics GP to have the system recognize the default codes.
6. Make sure the file does not have lines longer than 244 characters wide.
7. Make sure that you clear out the Electronic Reconcile tables in between each attempt. Select **DELETE ALL** in the Summary History window for Electronic Reconcile (only IF you aren't successfully using Electronic Reconcile yet for ANY checkbook, or you'll delete all of your history.)
8. Blank lines at the end of your import file can also cause the system to hang. To remedy this, open your bank file with Notepad, select CTRL- END and the cursor will move to the last line of the file. If it moves to a blank line, press Backspace until you get the cursor to the end of the last line with data. Save the modified file.
9. Refer to the ME142804 table to see what line it is failing on.

Q2: In between testing, how can I clear out the tables so I can start over?

A2: If you haven't used the Electronic Reconcile successfully yet for any import for any checkbook, you can clear out the Electronic Reconcile tables completely by using one of the two methods below to remove all eRec history for all checkbooks:

- Method 1: In the Electronic Reconcile Download Summary History window, select a Bank Download ID and click the DELETE ALL button at the top. (This deletes all history for all download ID's and not just the selected one.)
- Method 2: You can run these scripts in SQL Server Management Studio against the company database to delete all data in the Electronic Reconcile tables for all checkbooks:

```sql
Delete ME142804
Delete ME142806
Delete ME142807
Delete ME142815
Delete ME142818
```

> [!CAUTION]
> If you have used Electronic Reconcile successfully used Electronic Reconcile in ANY checkbook, you cannot run the scripts above or you will remove your history. You would need to add restrictions for the Upload ID (MEARDLID) to restrict to only the specific imports you want to remove.

Q3: When I bring in the bank file, the DATE column isn't correct. Why won't the dates import in correctly?

A3: This can be caused by two reasons:

1. Either the date format in the configurator file doesn't match exactly how the date is written in the bank file. For example, if the date in the bank file is MMDDYYYY, then it should also be mapped to MMDDYYYY in the configurator file for that date field. Having it mapped as MMDDYY or MM/DD/YYYY in the configurator file would cause this issue.

2. And the second reason is that the bank file was opened in Excel and resaved, so Excel striped out the leading zeroes on the date (for the month and the day). So for example, if the bank file that was imported in has 1/5/2015, and the configurator file has MM/DD/YYYY, then it would cause an issue. The date in the bank file should be 01/05/2015 to come in correctly. Check the original bank file and you should find that the original file from the bank had leading zeroes. For this reason, be sure to open/edit any file with Notepad, instead of Excel so leading zeroes are not stripped off.
