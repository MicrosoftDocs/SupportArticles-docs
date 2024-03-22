---
title: Bad datatype for SCRIPT_CMD_COLUMNOFTABLE error
description: When you create an EFT file, you receive an SCRIPT_CMD_COLUMNOFTABLE error. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Bad datatype for "SCRIPT_CMD_COLUMNOFTABLE" error when creating EFT file in Microsoft Dynamics GP

This article provides options to solve the **SCRIPT_CMD_COLUMNOFTABLE** error that occurs when creating an EFT file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4043888

## Symptoms

When generating an EFT file, this error message is received:

> Unhandled script exception:  
> Bad Datatype detected for operation EXCEPTION_CLASS_SCRIPT_BAD_TYPE  
> SCRIPT_CMD_COLUMNOFTABLE

## Cause

The COLUMNOFTABLE means that there is a column mapped in the configurator that does not exist in the corresponding table that is selected for that field. Unfortunately, there is not an easy way to identify which line/field in the configurator file the mismatched table/field is in.

## Resolution

To resolve this issue, review the below options:

**Option 1** - The best way is to open the EFT File format and go through each Data Type field where a table name and Field name are mapped. Simply reselect the Field Name using the Lookup button for each field. You will run into a field at some point that is not in the lookup button because it is not in the table that is listed.

1. Open the EFT configurator file (**Cards** > **Financial** > **EFT File Format**) and select the **EFT Format ID** being used.
2. Select the first Line Type of **File Header**, and select **expand** the detailed line mappings below.
3. For each **Data Field** line type, the Table Name and Field Name are listed. Simply select the **Lookup** button for **Field Name**, and reselect the Field name from the pick-list. Do this for all the Data Field lines.
4. Repeat for the next line type (**Batch Header, Detail**, and so on) and reselect the **Field Name** for all the Data Type lines. You will eventually find one in the file where the field is not in the pick-list, and this is the cause. Select the appropriate table/field and then you can **save** your changes and test again. (Typically users only have one, so test at this point before checking the rest of the lines in the file.)

**Option 2** - **All the tables** in the lookup button are for the **wrong module**.

If you are in a **Payables** EFT file format and see only **Receivables** tables in the table pick-list, or are in a **Receivables** file format and see only **Payables** tables listed in the configurator, then there was a problem when the file was imported, and the incorrect **SERIES** value is stored on the file format.

> [!NOTE]
> This is not typically the user's issue. This is usually only an issue for the user who **imported** the file in. So if you run into this because you imported the file in, use the steps below to fix it, and then most likely still need to do Option 1 above.

1. Run this script in SQL Server Management Studio against the Company database to view the EFT File Format ID's:

    ```sql
    select SERIES, * from CM00103
    ```

2. Review the **SERIES** value for your EFT File Format ID.

   - 3 - Receivables
   - 4 - Payables

3. If the incorrect Series is referenced, you can simply update the series, so you see the correct table in the front end.

   ```sql
   select update CM00103 set SERIES = 4 where EFTFORMATID = 'xxx'
   ```

   update the EFTFormatID to your configurator file name for the xxx. Modify the Series value to 3 or 4 as needed.
