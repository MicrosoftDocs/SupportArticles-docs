---
title: Guidelines to generate EFT files
description: Describes troubleshooting tips to use when you generate Electronic Funds Transfer (EFT) files or EFT Prenote files.
ms.reviewer: Lmuelle, cwaswick
ms.date: 03/31/2021
---
# Guidelines to follow when you generate EFT files or EFT prenote files in Electronic Funds Transfer for Payables Management or Receivables Management in Microsoft Dynamics GP

This article contains guidelines to follow when you generate Electronic Funds Transfer (EFT) files or EFT prenote files in Electronic Funds Transfer for Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945955

## Introduction

The guidelines are for Payables Management in Microsoft Dynamics GP 10.0 and higher versions, and Receivables Management in Microsoft Dynamics GP 2010 and higher versions.

## More information

Follow these guidelines to generate EFT files or EFT prenote files:

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

- **OPTION 1: Preauthorization required for EFT**

    If you selected the **Payables Prenote Required** check box or **Receivables Prenote Required** checkbox, the EFT prenote file will need to be generated first before the system will generate a regular EFT file. To generate an EFT prenote file, follow these steps:

    1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
    2. In the Checkbook Maintenance window, enter the appropriate checkbook ID in the **Checkbook ID** box, and then select **EFT Bank**.
    3. In the Checkbook EFT Bank Maintenance window, select
    **Payables Options**. (or **Receivables Options**)
    4. In the **EFT Payables Options** (or Receivables Options) area, verify if the **Payables Prenote Required** (or **Receivables Prenote Required**) check box is selected. If the **Payables Prenote Required** (or **Receivables Prenote Required**) check box is selected, follow the appropriate method:
        - Method 1: Select to clear the **Payables Prenote Required** (or **Receivables Prenote Required**) check box to not require a prenote file.
        - Method 2: Select **Generate Prenotes** to continue to generate the prenote file if required by the bank.
    5. Select **OK** two times to close the windows, and then select **Save**.

- **OPTION 2: EFT Payment does not pull for vendor**

    Certain fields between the checkbook and vendor (or customer) must match in order for the EFT file or EFT prenote file to generate. These fields include the Currency ID (if you have multicurrency installed), Country/Region Code, and Bank Country/Region. These fields aren't required, but if they're filled in on either side, the other side must match. To verify, use one the following steps:

    1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
    2. In the Checkbook Maintenance window, select the appropriate checkbook ID in the **Checkbook ID** box.
    3. Verify if a Currency ID is filled in or not on the Checkbook Maintenance window. Take note of the Currency ID field.
    4. Select **EFT Bank**.
    5. In the Checkbook EFT Bank Maintenance window, take note of what the Bank Country/Region field is set to, and if a Country/Region Code is filled in.
    6. Select **OK** to close the window, and then select **Save**.
    7. Now verify that these fields have the same values on the Vendor or Customer. Follow the method below depending on whether you're trying to generate an EFT file for Payables or Receivables:
        - Payables: On the **Cards** menu, select **Purchasing** and select **Vendor**.
        - Receivables: On the **Cards** menu, select **Sales** and select **Customer**.
    8. In the Vendor Maintenance (or Customer Maintenance) window, select the appropriate Vendor ID (or Customer ID).
    9. Select the **Address** button and select the appropriate Address ID used for EFT.
    10. Verify the value in the Country/Region Code field matches what you found on the checkbook above. (It isn't a required field, so it must match or be blank on both sides.)
    11. Select **EFT Bank**.
    12. In the Vendor (or Customer) EFT Bank Maintenance window, verify what value is in the Bank Country/Region field and the Currency ID field to make sure these values match what you found on the checkbook. Change any values as needed.
    13. Select **OK** to close the Vendor (or Customer) EFT Bank Maintenance window. Select **Save** to close the Vendor (or Customer) Address Maintenance window.
    14. In the Vendor Maintenance (or Customer Maintenance) window, select the **Options** button.
    15. Verify the value in the Currency ID field, and the Checkbook ID field.

        > [!NOTE]
        > For Receivables, you will find the Checkbook ID on the **Accounts** tab, not the **Options** tab.
    16. Select **OK** to close the window. Select **Save** to close the Vendor Maintenance window.
    17. Now test the EFT file or EFT prenote file again.

- **OPTION 3: Error when trying to generate EFT file**

    If you don't specify a bank file format, you receive the following error message when you try to generate the EFT file:

    > The selected checkbook is not set up with the payables file format. The EFT file cannot be generated.  
    > The selected checkbook is not set up with the receivables file format.  The EFT file cannot be generated.

    You must specify a bank file format to generate the EFT file. To do it, follow these steps:
  1. On the **Cards** menu, point to
 **Financial**, and then select **Checkbook**.
  2. In the Checkbook Maintenance window, enter the appropriate checkbook ID in the **Checkbook ID** box.
  3. Select **EFT Bank**, and then select **Payables Options** (or Receivables Options depending on if you're working with EFT for Payables or EFT for Receivables).
  4. In the **File Format** area, select the lookup button to select an EFT file format ID for the Single Format if only using one format for all vendors (or customers) or Based on Vendor if you're using different formats for different vendors (or customers).

      > [!NOTE]
      >  Select the blue expansion arrow button next to the format fields to drill back to the EFT File Format Maintenance window. Or you can key a new ID right in this window and the system will prompt you if you would like to add this as a new format. Or to navigate directly to the EFT File Format window, point to **Financial** on the **Cards** menu, and then select **EFT File Format**.
  5. Select **OK** two times to close the windows, and then select **Save**.

- **OPTION 4: Error when trying to generate EFT file**

    If you don't specify a path of the location where you want to save the EFT file output or the prenote file output, you receive the following error message when you try to generate the EFT file:

    > The EFT file could not be generated in the path specified for Payables Prenote File in Checkbook EFT Payables Options.  
      The EFT file could not be generated in the path specified for Receivables Prenote File in Checkbook EFT Receivables Options.

    You must specify the path of the location where you want to save the EFT file output or the prenote file output. To do it, use the steps below:

    1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
    2. In the Checkbook Maintenance window, enter the appropriate checkbook ID in the **Checkbook ID** box.
    3. Select **EFT Bank**.
    4. Select **Payables Options** (or **Receivables Options** depending on if you're using EFT for Payables or EFT for Receivables).
    5. In the **Default Output Files** area, specify the location where you want to save the EFT output file to for all three lines even if you won't be using them.
        - > [!NOTE]
          > If this is a new setup, we recommend to always generate the test EFT files to a **local drive** first to make sure the file will generate while you test. Once the file generates to a local drive, then you can change the paths for the output files to a shared drive if needed and verify it still works. This method takes any permissions issues with the shared drive out of the picture while you test.
        - > [!NOTE]
          > In the output path that you choose, make sure the folders or file name you save to do not have any spaces, periods, numbers or special characters (periods, dashes, etc). For example, if you named the file *prenote1.txt* or *prenote 1.txt*, you should make it *prenote.txt* instead (removing the number). Or if the path is *J://Payables/Payments/Jane.Doe/Payment.txt*, the period in the Jane.Doe folder would cause an issue. Test saving to just *J://Payables/Payments/payment.txt* instead to make sure it works at this folder level on the same drive.
        - Make sure the path isn't too many folders deep. (fewer than three folders)
        - Make sure the path isn't longer than the visible length of the field in the GP window.
        - If using Web client, make sure to test on the thick client.
        - > [!NOTE]
          > If you would like the filename to have an extension, enter it right in the output file path. For example, name the file as *prenotex.txt* if you want the .txt extension on the out put file.
        - If using a mapped drive, make sure the user can save any other file to that location manually.
        - If using a mapped drive, make sure the drive is mapped to the same letter on each workstation.
        - If using a mapped drive, make sure the drive is mapped on the network to the same letter.
        - Consult your local IT staff for further assistance with permissions within your own environment to shared locations. Users should have 'full control' access.
    6. Select **OK** two times to close the windows, and then select **Save**.

- **OPTION 5: EFT file does not generate for specific checkbook ID**

    If the checkbook ID contains any special characters, such as a dash (-), a slash mark (/), or an apostrophe ('), use a different checkbook ID or create a new checkbook ID that has no special characters. After you generate EFT files or EFT prenote files by using a different checkbook ID or a new checkbook ID, you must change the checkbook ID in all tables. To do it, use one of the following methods.

  - Method 1

    Use the checkbook modifier tool to change the checkbook ID in all tables by using the Professional Services Tools Library.

  - Method 2

    Use an SQL query tool to change the checkbook ID in all tables. To do it, follow these steps:

      1. Start SQL Server Management Studio.
      2. Run the following script to locate all tables that contain the Checkbook ID field (CHEKBKID).

          ```sql
          select * from sysobjects o, syscolumns c
          where o.id = c.id
          and o.type = 'U'
          and c.name = 'CHEKBKID'

          order by o.name
          ```

      3. Run the following script to change the value of the checkbook ID on all tables that use the checkbook ID.

          ```sql
          update <Table_Name> set CHEKBKID = '<XXX>' where CHEKBKID = '<YYY>'
          ```

          > [!NOTE]
          > In this script, the *\<XXX>* placeholder is a placeholder for the new checkbook ID that has no special characters. The *\<YYY>* placeholder is a placeholder for the previous checkbook ID.

- **OPTION 6: Error when generating EFT file**

    If you recently upgraded to Microsoft Dynamics GP 10.0 or GP 2010, you may receive the following error message:

    > The bank country/region assigned to the vendor's remit-to address is missing or inactive. Assign the bank country/region to the address or activate the format.

    If you receive this error message, check the PM20000 (PM_Transaction_Open) table to make sure that the vendor addresses in the VADCDTRO column are the same addresses for the vendors in the earlier version. The VADCDTRO column in the PM20000 table must match the VADCDTRO column in the PM00200 (PM_Vendor_Master) table for each vendor. To determine which vendor generates the error message, use one of the following methods.

  - Method 1

    1. In Microsoft Dynamics GP, point to **Purchasing** on the **Cards** menu, and then select **Vendor**.
    2. In the Vendor Maintenance window, enter the appropriate vendor ID in the **Vendor ID** box.
    3. In the **Address IDs** area, select the
    **Remit To** hyperlink, and then select an address ID in the pop-up window.

  - Method 2

    1. Start SQL Server Management Studio.
    2. Run the following script against the company database.

        ```sql
        Update PM20100 set VADCDTRO='REMIT TO' where VENDORID='<XXX>'
        ```

        > [!NOTE]
        > In this code, the *\<XXX>* placeholder is a placeholder for the actual vendor ID.

    3. Make sure that the VADCDTRO (Vendor Address Code - Remit To) column in the PM20000 table matches the VADCDTRO column in the PM00200 table. Additionally, make sure that the VADCDTRO column in the PM20100 (PM_Apply_To_OPEN_OPEN_temporary) table matches the VADCDTRO column in the PM00200 table and in the PM20000 (PM_Transaction_Open) table.

- **OPTION 7: EFT file does not generate, no error**

    If you recently upgraded to Microsoft Dynamics GP 10.0 or GP 2010 from a GP 9.0 or prior version, you must manually enter the bank name in the **Bank Name** box.

    > [!NOTE]
    > The **Bank Name** box does not exist in Microsoft Dynamics GP 9.0 and prior versions.

    To manually enter the bank name in the **Bank Name** box, follow these steps:

    1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
    2. In the Vendor Maintenance window, enter the appropriate vendor ID in the **Vendor ID** box.
    3. Select **Address**, and then select **EFT Bank**.
    4. In the **Bank Name** box, enter the appropriate name.
    5. Select **OK**, and then select **Save**.
    6. Close the Vendor Address Maintenance window.
    7. In the Vendor Maintenance window, select **Save**.

## Commonly Asked Questions

Q1: When does a support case for EFT assistance become a consulting expense? How long can I keep an EFT support case open?

A1: Setting up the EFT file format would be considered a consulting expense. Each support incident should be scoped to address one field or error message per case. Each new question or error message that can be researched separately from the original scope defined in the case should be put on a new support case. So if the bank rejects the test EFT file and gives you a new error message to troubleshoot, we ask that you open a new support case for the new issue. These guidelines are published in the Ebanking configurator section of [Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement for Report Writer, SSRS, Word Templates,SmartList Builder/Designer, SQL scripts, Business Alerts, VB Script, Modifier/VBA & Configurators, Workflow](https://support.microsoft.com/help/850201).

Q2: How do you install EFT for Payables or EFT for Receivables? And how do you verify it's working?

A2: EFT for Payables was moved into the core dictionary in Microsoft Dynamics GP 10.0 and higher versions, and EFT for Receivables was moved into the core dictionary in Microsoft Dynamics GP 2010 and higher. So there's no separate installation anymore. The only requirement is that the module is listed in your registration keys.

To activate EFT, select **Tools** under the Microsoft Dynamics GP menu, point to **Setup**, point to **System** and select **Registration**. Make sure the appropriate module of EFT Payables or EFT Receivables is marked as appropriate.

To verify it's working for the respective module, select **Cards**, point to **Purchasing** (or **Sales**), and select **Vendor** (or **Customer**). Enter a Vendor ID (or Customer ID) and select the **Address** button. If you see a button named **EFT BANK** in the lower right corner of the Vendor (or Customer) Address Maintenance window, then EFT is working.

Q3: Are you able to send invoice information in the EFT file?

A3: Yes, it's called the **Addenda** line. You'll need to map out the Line Type for the **Addenda** line on the EFT file format according to your bank's specifications. As many addenda lines will print for however many invoices make up the payment. Addenda lines on a standard NACHA format typically start with a record type code of '7'.

Q4: Are you able to send multiple addenda lines in the EFT file?

A4: The functionality for addenda lines works differently in different versions of Dynamics GP, so the answer will depend on what version you're using. In GP 10.0, you're able to send only 0 or 1 addenda line per payment. GP 10.0 doesn't have functionality to include multiple addenda lines for one payment. In GP 2010 RTM, you're only able to send 0 or All addenda lines per payment. However in GP 2010 SP2, another functionality was added so you can send 0, 1, or All addenda records for each payment by using the newly added checkbox for **Detail Line Addenda** found on the EFT File Format Maintenance window. More information on this topic can be found in [Multiple addenda lines in the EFT file in Microsoft Dynamics GP](https://support.microsoft.com/help/2551488).

Q5: Are you able to put multiple invoice numbers in one addenda line?

A5: No. Each addenda line would store the information for each invoice that makes up the payment. So for example, if you have six invoices that make up the payment, you would get six addenda lines if you chose to include all the addenda lines. There's no functionality to include all six invoice numbers on the same addenda line at this time.

Q6: Are you able to configure any EFT file format to produce a Check Printing File format? (Many banks are now offering this service to print checks and require an XML format where each addenda line would be in its own remittance format.)

A6: You're on your own to test. At this time, Microsoft Dynamics GP doesn't offer or support Check Printing File formats since it's a customized file and not a true EFT file format. It's for a different service that is provided by your bank. The EFT functionality in Dynamics GP is coded to achieve the EFT file formats that are included out of the box, so there may be some requirements you may or may not be able to achieve. You would need to test on your own to see if the format you need can be done in Dynamics GP with the current EFT functionality, or not. If you open a support case, you can expect the same assistance with advising on one field or one error message per support incident. Oftentimes a dexterity customization may be needed, which is outside of regular support guidelines.

One requirement we've seen for an xml format, where each remittance information is listed in its own grouping would need a dexterity customization to achieve. We encourage you to vote on this product suggestion in the [Microsoft Ideas product suggestion database](https://experience.dynamics.com/ideas/) so this functionality can be reviewed for a future enhancement.

Q7: Does the EFT banking information flow through an upgrade?

A7: The banking information on the vendor and the checkbook are brought through the upgrade. The banking information on the vendor will be written to the SY06000 table and will use the vendor's main address found on the Vendor Maintenance card. The only information that isn't brought through the upgrade is the EFT file format. You'll need to reset up the EFT file format in GP 10.0 or GP 2010, by either setting it up from scratch yourself, or picking from one of the standard formats already supplied in the pick-list. It may be helpful to make screen prints of the file format setup in GP 9.0 to refer to. GP 10 and GP 2010 have standard file formats available to choose from, as published by the National Automated Clearing House (NACHA). We code to these standard published formats, so if your bank requires any other format, or a customization to the standard format, we would consider that to be a consulting request.

Q8: What EFT file formats are supplied in GP 2010 and GP 2013?

A8: GP 10.0 and GP 2010 and GP 2013 offer 10 standard EFT file formats that are published according to the standard requirements set by the federal banking agencies and National Automated Clearing House (NACHA). One user-defined file format is also available so the user can set it up however they wish.

Q9: What if my bank uses a file format that varies slightly from one of the standard formats offered in GP?

A9: The EFT file formats available in Microsoft Dynamics GP are set up to follow the US Government and NACHA (National Automated Clearing House Association) published formats. They're published standard requirements. The file formats currently offered in Microsoft Dynamics GP are coded to achieve the required **** fields in these standard formats. So if your bank requires a format that varies slightly from one of the standard formats offered in GP, or a more updated version of a format, you may need to pursue a consulting service for the customization. In the meantime, you could check with the bank to see if they would make an exception, or accept any other formats that Dynamics GP can do (such as one of the standard NACHA formats), or edit the EFT file in Notepad before sending it to the bank.

You can search the [Microsoft ISV Central](https://www.microsoft.com/licensing/licensing-programs/isv-program) to find an ISV that may offer an EFT product compatible with Dynamics GP or could help you achieve a customization to meet your needs:

Also enter a Product Suggestion in the [Ideas](https://experience.dynamics.com/ideas/) link so Microsoft can track it and consider this new functionality for a future enhancement.

Q10: My bank doesn't use any of the EFT File formats listed in GP. How can I create a new format to follow my bank?

A10: You can use the user-defined EFT file format to create your own format. However, you are responsible for setting it up and testing it. Microsoft is not able to support your custom format. We will help you with one field or error message per case. You can also try to set up the format yourself. If you tackle this yourself, we suggest setting up another sample format using one of the formats in the system such as the PPD or CCD file format and use that as a reference so you can see how the fields are mapped and you can mirror your format the same way (or start with the PPD or CCD format and modify it as needed). This should help you accomplish most fields. However, all the fields you need may not be available, or may appear to be available but don't work (such as counts or totals). Just because you can select a table/field in a line doesn't mean that it will work. (For example putting check information in an addenda line.) You would have to test it to verify. You will need to test on your own to verify what fields work in what lines. The format in Dynamics GP were coded according to the required fields in each line per the standard published formats by the National Automated Clearing House Association (NACHA). You can visit NACHA.org to view the required fields for each standard format.

Q11: How do you set up settlement lines for the EFT File format? (Or the bank is asking for a total debit or credit line in the footer that will offset the file.)

A11: A settlement line is basically where the bank is asking for debit and credit lines in the EFT file that will balance each other out. You can have one settlement line per detail line, or one settlement line for the whole file. For more information about how to correctly set up one settlement line for the whole file, see [Settlement Line calculates incorrectly in the Electronic Funds Transfer (EFT) file for Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/2026313).

Q12: What is an IAT format?

A12: The IAT formats are provided to accommodate changes in the IAT (International ACH Transaction) rules as mandated by the NACHA and OFAC organizations for use with international ACH files.

The IAT format contains seven addenda lines, where each line is coded to include specific Transaction, company or vendor information. The **Remittance addenda** line wasn't coded in this format since it isn't required information in the standard published format. You wouldn't be able to substitute any of the other seven addenda lines to include the remittance information (invoices that make up the payment.) Visit NACHA.org to view the standard published format and required fields.

Q13: What does PPD and CCD mean for the standard US NACHA files? What does the + mean next to each?

A13: These types mean:

- PPD means Prearranged payment and deposits. Used to credit or debit a consumer account. Popularly used for payroll direct deposits and pre-authorized bill payments.
- CCD means Corporate credit or debit. Primarily used for business to business transactions.
- The + next to each file format means that the file format includes mapping for the Addenda Line Type.

Q14: Why is the Bank/Transit Routing number in the EFT file set to 10 digits if most US routing numbers are only nine digits long? Where do I enter the check digit for the bank routing number?

A14: The Transit Routing number field is meant to hold the nine digits of the routing number, plus the 1 Check Digit number behind it, for a total of 10 digits in the Bank Transit routing number field. The bank may split these two fields separately on your bank specifications, so you can choose if you want to lump them together in one field in your EFT file mapping (as 10 digits), or split them out as two fields. For example, map the bank transit routing number as one field that is nine digits long, and then map another field as one digit and hard-code it as a constant to the value you need (usually 1).

Q15: How do I handle the Bank Transit Routing number when it's only eight digits long in Canada?

A15: Canada used to have an eight digit routing number, but changed it to nine digits to match the United States. They just added a 0 in the front of the existing eight digit routing number.

Also, it may flip the routing number around in RM/PM EFT file formats for Canada. You can only key eight characters and it assumes you are entering it directly from a Canadian cheque, where the MICR number listed is BBBBBAAA, where BBBB is a five digit transit or branch number, and the AAA is the institution number. So Dynamics GP assumes it was entered this way and flips around for you so it is 0+AAA+BBBBB in the EFT file. (And right-justified and padded with a leading zero to be nine digits long.) So be aware that the last three digits will be moved to the front, with the padded leading zero. So if you enter 45678123 (BBBBBAAA), it will get flipped around to 0 + 123 + 45678 in the file. You will want to enter it in Dynamics GP with the first three digits at the end. So if you have 12345678, you will enter 45678123 (BBBBBAAA) in Dynamics GP.

Q16: Why don't the count lines work in all the line type rows?

A16: Unfortunately, the count fields may be available to select in the mapping for any line, but they don't work in all the Line Types at this time.

Addenda Count - only works in the Addenda Line type. This count field doesn't work in the Detail line, or Batch Control line or File Control line.

Line Count, Detail Count, Detail + Addenda Count, Detail Count, Total Number of Debits, Total Number of Credits will only work in the Batch Control and File Control lines. These fields won't work in File header, Detail, or Addenda lines.

It's currently by design and will be considered as a future enhancement.

Q17: The bank is asking me to add pad blocks or block count 10 to the EFT file format. What does that mean?

A17: Pad Blocking or 'block counts' requires EFT files to have some lines in it or multiple of lines in the file created. For example, if they require a Pad Block of 10, this means that they want the file to be in multiples of 10 lines. So if the file is 22 lines, the system will need to add eight dummy lines so the total line count of the file is 30. Or, if the file is 49 lines long, then the system would only need to add one dummy line to get the file to be 50 lines. The total number of lines of the file needs to be in a multiple of 10.

1. Open the EFT File format in Dynamics GP (**Cards** > **Financial** > **EFT file format**).
2. Select the file format ID.
3. In the upper right section, mark the checkbox for 'Add Pad Blocks'.
4. Define the pad character, number of padded characters and block count required by your bank. The most common scenario is to pad a '9' character in blocks of 10. This would be entered as:

    ```output
    Pad character:   9
    Number of pad chars:  94   (width of line needed)
    Pad lines in multiple of: 10   (block count)
    ```

Q18: If a value doesn't fill the entire field in the EFT file, how do you fill the rest of the field with zeroes or spaces?

A18: In the EFT File Maintenance window, there's a Pad Char field on each line. Leave this field blank if you want the field to have spaces. Or put a 0 in this field, if you wish for the unused portion of the field to be padded with 0's. The zeroes will be padded in the remainder of the field based on whether you set the data in the field to be right or left justified.

Q19: In the PM Paid Transaction History file, there is a field called the 'Transaction Description'. This field prints blank and doesn't pull the description from the invoice. How can I get the transaction description from the invoice in the Addenda line? (or the PO#, or the full document amount of the invoice, etc.)

A19: The EFT file is for electronic payments, and therefore is always looking for the mapped fields from the perspective of the payment record. So if you pull the **Transaction Description** field from the PM Paid transaction history file on to the Addenda line, it is looking for the payment, not the invoice, so it will print blank (since the payment is not posted yet). The only invoice information you can get to pull on to the Addend line is the invoice information that is on the apply record to the payment in the **PM Apply to History** table. This includes only the Invoice document number, invoice date, discounts and net paid amount. You can't get to the transaction description associated with the invoice, or PO#, or full document amount, because these are not supported at this time. For more information, see [Custom data fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP](custom-data-fields-for-electronic-funds-transfer-formats.md).

Q20: How do you get the document number for the invoice to print in the addenda line?

A20: To get the Document Number for the invoice, you'll need to map it as follows:

TABLE: PM APPLY TO HISTORY FILE
FIELD: APPLY TO DOCUMENT NUMBER

For more information, see [Custom data fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP](custom-data-fields-for-electronic-funds-transfer-formats.md).

Q21: I have keyed multiple invoices to one vendor in Microsoft Dynamics GP. Some of the invoices were keyed to an Address ID with banking information and some of the invoices were keyed to an Address ID without EFT banking information. When I build the check batch or EFT batch, it doesn't work the way I expect. How do the invoices pull into the check and EFT batches?

A21: The functionality for how check and EFT batches pull has changed across versions of Microsoft Dynamics GP as follows:

- Microsoft Dynamics GP 10.0 - If you build the check batch first, both the check and EFT invoices will pull in. The workaround is to build the EFT batch first and then the check batch can be built last.
- Microsoft Dynamics GP 10.0 SP2 - The system will read and use the REMIT TO Address ID saved on the Vendor Maintenance card. Unfortunately, it doesn't read the Address ID keyed on the specific invoice. It was logged as quality issue #64038.
- Microsoft Dynamics GP 2010 RTM and later versions (last tested on GP 2018) - If a vendor has both a check and EFT type invoice keyed, then nothing will pull in if you build the check batch first. You must build the EFT batch first and then the check batch. It's the current design. If you would like to see this design changed in future versions, log a product suggestion.

Q22: How do you log a product suggestion?

A22: The Development team has created a product suggestion database named MS Connect. They do read each and every product suggestion entered and give it a priority rating based on several criteria such as:

- Is it data damaging?
- How many customers have voted for it?
- Is there a work-around?
- Will it conflict or break other functionality?
- Does it violate any federal or standard regulations?

After each suggestion is given a priority rating, it stays in the database so that other customers can also vote on it over time. The more votes it gets, the higher in priority it will go, so your votes do count and are important. This database is used to determine what enhancements customers would like to see in future versions so log product suggestions in the [Ideas product suggestion](https://experience.dynamics.com/ideas/) database.

Q23: How do I get the File Creation Date in Julian date format? (For example, the Julian date format is '0yyddd' where yy is the last two digits of the year and the ddd is the day of the year that that date falls on out of 365 days. So for example, September 24, 2011 would be in 011267 in Julian format.)

A23: To accomplish the Julian date format, you would have to use two fields as follows:

1. Open the EFT file format and select the File Header line type.

1. Select the File Creation Date field. Set it to a length of **1** and map it to a Constant value of 0.

1. Select to put your cursor on the next line and in the top menubar select **Edit** and choose Insert Row and it will insert a new row above the line your cursor is on.

1. In the new field, name it **File Creation Day** and map it as System Date. Then expand the line and for the Date Format, choose either YY+Day Number or just Day Number as needed. (Not all banks require the YY.)

Q24: When I key a manual payment in Payables and mark the EFT checkbox, why are these showing up in the SafePay file as a check?

A24: If the vendor isn't set up for EFT, then the system will treat the manual payment as a check and include it in the Safe Pay file, even if you mark it as an EFT type when you keyed the manual payment. It will still be treated as a check no matter what for vendors not set up with EFT. The workarounds are to use the 'cash' type instead of EFT for non-EFT vendors, or set up the vendor with EFT and then rekey the manual payment. The 'cash' type isn't included in the Safe Pay upload.

If the vendor is set up for EFT, the system will default to the EFT checkbox automatically and it won't be included in the Safe Pay file.

Q25: Can Microsoft provide a list of banks that use specific EFT File formats?

A25: Microsoft isn't able to certify which banks use which formats, because of liability reasons and also because banks are ever-changing that formats they use, which makes managing that information impossible. Certain banks also may require specific fields that aren't required on the standard published format. So you must contact the bank directly to see what formats they'll accept and provide you with a requirements document for the format they require. Then you'll have to modify a format in the EFT File Format window in Microsoft Dynamics GP to see if the deviated field is possible or not. Contact Microsoft Dynamics GP for a consulting engagement if you need to have the file customized to pull information that isn't readily available.

Q26: The bank won't accept my EFT file because the sequence number in the EFT file name is -0001 and we already uploaded an EFT file with that same sequence number today. The next file we generated was also generated with the same -0001 sequence number.

Q26: The naming convention for the EFT files (on Microsoft Dynamics GP 10.0 and higher versions for EFT Payables, and Microsoft Dynamics GP 2010 and higher for EFT Receivables) is comprised as follows:

`EFT FILENAME + CHECKBOOK ID + DATE + SEQUENCE NUMBER + EXTENSION (if designated)`

The EFT FILENAME is pulled from the filename designated in the **Payables Options** or **Receivables Options** tab for the output paths on the checkbook. If no extension such as `.txt` is designated here, then no extension will be added to the resulting EFT file generated.

The CHECKBOOK ID is the Checkbook ID used on the checkrun.

The DATE is the system date.

The SEQUENCE NUMBER will increment off the other EFT files saved to the same path/folder with the same name. The sequence number will increment accordingly for the next EFT file generated. So if you generated an EFT file today with the sequence number of -0001. Another EFT file-generated today will increment to -0002 saved to the same location. However, if you delete the first file with the -0001 sequence number first, then the second file won't see it and start over and use the -0001 sequence number again. It's a problem with most banks as they will consider it a duplicate file. When you generate a file the next day, the date will change, so it will start over at -0001 again. So be sure not to delete the EFT files from the location the files are being saved to if you generate more than one EFT file per day.

Q27: Can I have credit memo's show on the EFT file?

A27: No. The credit memo is applied to the invoice as a separate process. The EFT file is only paying the 'net amount' remaining that is due. So the credit memo information is stored in a different table and not available to be pulled into the EFT file.

Q28: If I void the EFT payment, will the credit memo automatically unapply from the invoice too?

A28: In Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010, when you void a payment, only the net amount of the payment will become open again. The credit memo remains intact against the invoice.
> [!NOTE]
> This functionality was changed in Microsoft Dynamics GP 2013.

In Microsoft Dynamics GP 2013, when you void the EFT payment, the credit memo will also be unapplied from the invoice at the same time.

Q29: In the Checkbook EFT Bank Maintenance window, how does the Communication Type and Application fields work? Will GP automatically upload my file directly to the bank?

A29: Microsoft Dynamics GP has no automatic way to send the file to your bank. The Communication Type is used to either launch the program to use to upload the EFT to the bank, or open the internet link for your bank to upload the EFT file. GP is just opening the software or link for you, but can't go any further. Your program or bank's software will take over at that point, or you must manually continue to upload the file. You should check with your bank, as some bank's software may have functionality to automatically grab the file from a specified location, but that accomplished for the functionality present in your bank's software.

Q30: When I import in an EFT File format for Payables, the Payables tables aren't listed. Receivables tables are listed for Table Name. Is it a bug?

A30: This issue #61119 was corrected in SP3 for Microsoft Dynamics GP 2010. Or you can update the SERIES column on the EFT File Format directly in the SQL Table to point to Payables Management, by executing the below script against the company database in SQL Server Management Studio:

```sql
update CM00103 set SERIES = 4 where EFTFormatID = 'XXX'
```

--Enter the EFT File Format ID for the XXX Placeholder above before executing this script. For the Series, Payables = 4 and Receivables = 3.

Q31: What version of the ISO 20022 format is available in Microsoft Dynamics GP?

A31: Only Version 1 of the ISO 20022 format (PAIN 001.001.01) is currently available in Microsoft Dynamics GP. Unfortunately, Version 2 or Version 3 isn't available at this time and would be considered a product enhancement. If you would like to see the newer versions of this format added to Microsoft Dynamics GP in the future, such as Version 3 (PAIN 001.001.03), select the link below and enter a [product suggestion](https://experience.dynamics.com/ideas/idea/?ideaid=48e420e7-2199-e911-80e8-0003ff68cb40) and add any comments to this can be reviewed and considered for a future release.

Q32: How do you get a Unique File Creation Number generated for each new EFT file?

A32: The Unique File Number functionality is a unique number per EFT file generated. If selected on several line types, the same number will print in each line, and increment each time a new EFT file is generated. This number is already available in Microsoft Dynamics GP by mapping the field as follows:

*EFT Next File Number*  
Maps to: Data Field
Table: Checkbook Electronic Funds Transfer Master
Field: EFT Next File Number

> [!NOTE]
> The bank prenote file generated will print zeroes in this field.

For more information, see [Custom data fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP](custom-data-fields-for-electronic-funds-transfer-formats.md).

Q33: What are some other custom fields commonly requested for EFT?

A33: Information on other custom fields commonly requested for EFT file can be found in [Custom Data Fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP](custom-data-fields-for-electronic-funds-transfer-formats.md).

Q34: Can I get an addenda count in the Detail line to achieve the CTX file format?

A34: No, at this time, you aren't able to count/sum until after the lines are listed. So you wouldn't be able to count the addenda lines in the Detail line since they're printed after the Detail line, so you wouldn't be able to achieve the CTX format. Your options would include:

1. Run 'one check per invoice' instead of 'one check per vendor', and hard code the addenda count =1 in the EFT file format.
1. Ask the bank if they would make an exception or accept any other NACHA format such as the CCD or PPD format. (Many banks have accepted the 'detail + addenda' count in a footer line instead.)
1. Seek out a third-party product that allows this functionality or 4) a dexterity customization.
