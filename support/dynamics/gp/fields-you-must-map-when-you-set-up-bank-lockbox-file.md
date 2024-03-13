---
title: Fields you must map when you set up a bank lockbox file
description: Lists what fields are required to be mapped when you set up a bank lockbox file in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Fields you must map when you set up a bank lockbox file in Microsoft Dynamics GP

This article describes the fields that you must map when you set up a bank lockbox file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858289

## More information

The Lockbox Maintenance window is used to set up mapping specifications for bank lockbox files. You can use this window to map each field in your bank file to its corresponding field in Microsoft Dynamics GP.

### Step 1 - Set up the Lockbox ID information

To access the Lockbox Maintenance window, point to **Sales** on the **Cards** menu, and then select **Lockbox**.

- Lockbox ID - Enter the name of the Lockbox ID for your reference only.
- Description - Enter a description for the Lockbox ID for your reference only.
- Checkbook ID - Select the Checkbook ID to deposit the cash receipts to.

### Step 2 - Indicate what lockbox file to read and tell the system how to read and apply it

- Location of Lockbox File - Navigate out to the cash receipt file from the bank that you will be importing in to Microsoft Dynamics GP. The file should be either a .txt or .csv type. The rows in the file cannot be more than 255 characters wide. Also make sure the file is not set to read-only.
- File Format Type - Select if the file will be a Fixed Length, Tab-delimited, or Comma-delimited based on the type of file received from the bank. This type will tell the system how to read the fields on each line within the file.
- Lockbox Format Type - Depending on the type of file that you receive from your bank, you should select whether the file uses a single-line or multiple-line format. A Single-line file will have one check per line in the file, where one check is applied to only one invoice. A Multiple-Line File format type will have one check in a header row that will be applied to multiple detail rows or multiple invoices. For the Multiple-Line type, the Header Row Indicator and Detail Row Indicator fields will become available. Enter the Indicator value as defined by your bank, which will tell the system which row is a header record and which rows are detail rows. (According to the US NACHA format, the indicator for a Header Row will be 6, and the indicator value for a detail row will be 4.)
- Decimal Places on Amounts - Enter up to five decimal places to be added to the amount indicated in the Lockbox File to be imported. (Generally 0 is entered, as 2 will place a .00 to the end of the amount indicated in the file.)
- Lockbox Apply Method - Select how you want the system to apply the Cash Receipts to invoices:

  - None - The cash receipts are brought in, but not applied until you manually apply them.
  - Document Number - Cash receipts are first applied to the lowest document number, regardless of type.
  - Invoice Number - Cash receipts are first applied to invoices, starting with the lowest document number.
  - Due Date/Oldest Document - Cash receipts are first applied to any document with the oldest due date.
  - Due Date/Oldest Invoice - Cash receipts are first applied to invoice type documents with the oldest due date.
  - Document Date - Cash receipts are first applied to the document with the oldest document date.
  - Specific Invoices - Cash receipts are applied only to the invoice number you specify. If the specific invoice number is not found, you can define an Alternate Apply Method to be used.

> [!NOTE]
> The most common Lockbox Apply Method is **Specific Invoices** with an Alternate Apply Method of **None**.

If this is grey, it could be due to your currency.

Lockbox is designed to function in the same manner as the Cash Receipts Entry - Apply Sales Documents window (**Transactions** > **Sales** > **Cash Receipts** > **Apply** button).

Since you cannot apply a payment to a multicurrency transaction from this window, it works the same in Lockbox.

This is the reason that the Lockbox Apply Method is grayed out, is because you need to do the apply manually. You can apply payments to multicurrency invoices use the Apply Sales Documents window directly (**Transactions** > **Sales** > **Apply Sales Documents**) but just not using lockbox or the Cash Receipts Entry - Apply Sales Documents window (**Transactions** > **Sales** > **Cash Receipts** > **Apply** button).

- Omit Start Import Records - Select the number of rows at the beginning of the import file that you want to be skipped. (For example, if you mapped the fields only for the Detail row, you may want the system to skip over all the header rows in the file.) If you don't want any lines in the file to be skipped, enter *0*.
- Omit End Import Records - Enter the number of rows to be skipped at the end of the import file. (For example, if there is a File Control line or footer in the file, and you have not mapped the fields for this row, you may choose to have the system skip over these lines.) If you don't want any lines to be skipped, enter *0*.

### Step 3 - In the Lockbox Maintenance window, review the layout of the Lockbox File you will be import in

Next to View Row, use the scroll buttons to scroll through each line in the Lockbox import file.

Depending on the file format type, you must map these fields for lockbox processing to import transactions correctly. For example, the following is a list of the file format types and the fields to which they must correspond:

- For Single-line import files: The **Check Number** and **Check Amount** fields, along with a method of locating the Customer, such as Customer Name, Customer ID, or Bank routing number and bank account number.
- For Multiple-line import files: The header row must include the **Check Number** and **Check Amount** fields. If you map the **Invoice Number** field, you must also map the **Invoice Apply Amount** along with a method of locating the Customer, such as Customer Name, Customer ID or Bank routing number and bank account number in the header row. The detail row would only need to contain the Invoice Apply Amount and Invoice number. The Header row should contain the check information and the first invoice to apply to. The detail rows will only include additional invoices to apply the check to, beyond the first invoice that is listed in the header row.

For a Mutliple-line file, a suggested format to use would be:

- Header - Row Indicator (6), Invoice Apply Amount, Invoice Number, Check Amount, Check Number, Bank Account Number, Bank Routing Number, Customer Name*
- Detail - Row Indicator (4), Invoice Apply Amount, Invoice Number

*Note - The file will still import in without the Customer Name  as shown above in the suggested Header line format. However, if there is a chance that multiple customers may happen to use the exact same check number in this file, then the system also needs another unique field to bring in all the checks with the same check number. If you don't use another unique field, then the system will only bring in the first check and skip over the other checks in the file with the same check number and you will not be notified that the other checks with the same check number did not import in. For the unique field, you can use either Customer Name or Customer ID, however, most banks are not willing to pass a Customer ID value. So if you use the Customer Name, make sure that the name on the customer's bank account is exactly how you have their name on the Customer Maintenance card in Microsoft Dynamics GP. The Customer Name or Customer ID listed on the lockbox import file needs to match exactly to how it is written in Microsoft Dynamics GP in order for the system to make match on this field.

> [!NOTE]
> On a single line file format, it is not expected to have the same check number listed multiple times or duplicated. For example, if the same customer has the same check number listed in lines 1 and 2 of the single line import file, the system will skip line 2 as the system sees it as a duplicate. However, if the same customer has the same check number listed in lines 1 and 3 of the file, then the system will read it. if they are not listed consecutively. However, different customers could have the same check number by chance. If the same check number is for different customers, it will read a consecutive line if CUST NAME or CUST ID is also mapped in the configurator. (But remember, if these fields are mapped, then the value in these fields on the import file must match exactly what GP has, as the system will validate on these fields if they are included in the mapping.)
>
> If you get the message: "There was an error opening the import file.  Please verify file name." make sure to check the properties and that it is not set to Read-only, and you have Full Control and Modify permissions on it.

### Step 4 - Map the fields

For a Fixed-Length file, you must map the fields in each required row of the Lockbox Import file to the field to which it corresponds in Microsoft Dynamics GP. You must also indicate the start and end position for each field. The fields should be listed in the order in which they appear in the row in the Lockbox import file. For unused spaces in the file, map to the field of **None** so the system skips over it. For a multiple line file, the same fields between the header and detail rows should be in the same positions in both rows.

For a tab delimited or comma-delimited file, you need to map the fields in the same order they appear in the Lockbox import file, but you do not need to specify any Start and End positions, as that is dictated by the tabs or commas in the file itself. For blank or unused fields, map to the field of **None** so the system skips over that field in the import file.

When you map fields from the bank lockbox file, you are specifying the Microsoft Dynamics GP fields to which they correspond. You can map the bank lockbox file to the following Microsoft Dynamics GP fields:

- **Bank Account Number**
- **Bank Routing Number**
- **Check Amount** - Note that the amount should be in Number or Text format. No commas!  It can include dollar signs and periods. Set the decimal field appropriately in the Lockbox Configurator file.
- **Check Number**
- **Checkbook Bank Acct No.**
- **Customer ID**
- **Customer Name**
- **Deposit Date (MM/DD/YY)** - Note that the date in the import file can be 04/05/17 or 4/5/17 or 4/5/2017 or 04/05/2017 and it will work, but the forward slashes are needed.
- **Deposit Date - Day**
- **Deposit Date - Month**
- **Deposit Date - Year** - For a four-digit year, map to the last two digits of the year only for a fixed-length file.
- **Invoice Apply Amt.**
- **Invoice Number**
- **None**
- **Row Type Indicator** - Use the Value as supplied on your bank's specifications.
- **Transaction Description**

### Step 5 - Save

Other helpful hints in setting up a lockbox file format:

1. Make sure to read the difference between the lockbox Apply Methods of Specific Invoices and Invoice Number to make sure you have selected the correct one. (Usually, Specific Invoices is the most commonly used, with **None** as the alternate method.)

2. The lockbox setup (**Cards** > **Sales** > **Lockbox**) will point to one specific location, so you should save the lockbox file you download from the bank to that location each time, or else you will need to edit the location in the Lockbox file each time if you do not.

3. When testing importing in a Lockbox file, use a unique batch ID. Using the same batch ID over and over again to test bringing in the same Lockbox Import file could result in scrambled results after a few attempts.

4. If the error report after importing in the file shows *'unused row type'*, this means that there were blank lines at the end of the file that were not omitted and the system could not read them. This message would be acceptable to see on the error report.

5. Only the detailed rows on the Lockbox import file would be required to import in. The header and footer rows are not required to be mapped. You can skip these lines by utilizing the **Omit Start Import Records** and **Omit End Import Records** fields in the Lockbox Maintenance.

6. Use the suggested format listed above for the multiple-file lockbox type. Banks are usually pretty good about setting up the file in the format you request. The first invoice applied to is recommended to be in the header record, along with the check information (but not necessary).

7. Why is the DATA column only reading a few fields in the Lockbox Maintenance window, when I have mapped more than that? Or only bringing in a few fields when I have mapped more fields than that? The system will look to the *1st row in the import file* is as a guide. For example, let's say the first line in the file only has two fields. In the Lockbox Maintenance, you mark to omit line 1, and map out seven fields. However, the DATA column only shows data in the first two fields. To correct this, you will need to add more fields to line 1 in the import file (even though it is skipped). Make sure the first line in the import file contains the *same as or more fields* than you have mapped in the Lockbox Maintenance window.

8. The best method to have the lockbox file match to a customer is to match by the Bank Routing Number and Bank Account number for the customer. However, not all banks are willing to pass a Customer ID, but will pass a Customer Name. If you do not have this information, see [How to use the bank account number and bank routing number instead of the customer ID in Lockbox Processing in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-use-the-bank-account-number-and-bank-routing-number-instead-of-the-customer-id-in-lockbox-processing-in-microsoft-dynamics-gp-f6c3ec0b-247b-738b-0ea1-1535cc60fbe9) for how to import in the banking information for the customer from the Lockbox file.

9. Error **Invalid date for Lockbox** on the Exception report is caused by the date format in the Lockbox format not matching the date format in the Lockbox import file. For example, the Deposit Date format is MM/DD/YY, and therefore the date in the import file should be 04/12/17 or 4/12/17, or 04/12/2017. If the slashes are missing, it will cause this message.

10. There is a **line width limit of 255 characters per line**. If your line is longer than this, then nothing will come in and no error messages are thrown.
