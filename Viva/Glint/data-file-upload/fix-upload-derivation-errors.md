---
title: Resolve file upload errors related to derived attributes
description: Fix errors that occur when you upload employee attribute data to Microsoft Viva Glint. These errors are related to derived attributes.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 06/20/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI190683
localization_priority: Normal
---

# Resolve file upload errors related to derived attributes

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following derivation error messages. Select the error that you experience from the list at the top of the article, and follow the appropriate resolution to fix the error.

## The date format is incorrectly configured

Error message:

> DERIVATION_ERROR: The date format is incorrectly configured for the following columns: (Hire Date). We're expecting \<date format, such as mm/dd/yyyy\>. For Microsoft Excel files, ensure that cells are in Text format.

This issue occurs because the date format in the file that you upload doesn't match the format that's specified when you set up attributes in Viva Glint.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. For each date format column that's listed in the error message, follow these steps:
   1. To the right of the column (for example column A), insert a new column (column B) that's formatted as **General**.
   1. Select the first cell of the new column (cell B1), enter the following formula, and then press Enter:

      =TEXT(\<The first cell of the original date column, such as A1\>,"\<Expected date format in the error message, such as mm/dd/yyyy"\>)

      For example, enter this formula:

      =TEXT(A1,"mm/dd/yyyy")
   1. [Fill the formula](https://support.microsoft.com/office/fill-a-formula-down-into-adjacent-cells-041edfe2-05bc-40e6-b933-ef48c3f308c6) into the cells in the new column (column B).
   1. Copy the date values from the new column (column B), and then paste the values into the original date column (column A) by using the **Paste** > **Paste Special** > **Values** [option](https://support.microsoft.com/office/paste-options-8ea795b0-87cd-46af-9b59-ed4d8b1669ad).
   1. Delete the new column that contains the formula.
1. Save the file, and then upload it again to Viva Glint.

## Attribute headers in the uploaded file don't match Viva Glint configuration

Error message:

> DERIVATION_ERROR: Attribute headers in the uploaded file don't match your Viva Glint configuration. Ensure that all attribute header names match and are included in your file. Include columns Hire Date and Birth Year. These columns are used for deriving attributes Tenure, Age Group.

This issue is caused by a mismatch between the attribute header in the uploaded file and the attribute names that are specified in Viva Glint. Attribute headers must match the attribute names in Viva Glint exactly, including the case and spaces.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file in Microsoft Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. Review attribute names that are specified in Viva Glint:

    1. In the admin dashboard, select the **Configure** icon, then select **People** in the **Employees** section.
    1. Select **Actions** > **Manage User Attributes**.
    1. Review the attributes in the following sections:
       - Active Attributes
       - Derived Attributes

          **Note**: In this section, review the attributes that are used by Viva Glint to create the derived attributes. These attributes are listed in the **Calculate From** field.
       - Optional System Attributes
       - Hierarchy Attributes
1. For each attribute that's identified in step 2c, compare its name in Viva Glint with the value in the header row of the data file, and then fix any mismatches. Make sure that:
    - There is no case inconsistency. For example, **EMPLOYEE ID** and **Employee ID** don't match.
    - There are no extra spaces. For example, **" Status"** and **"Status"** don't match.
    - There are no spelling errors.
    - There are no extra characters. For example, **Email_Address** and **EmailAddress** don't match.
    - There are no characters that are added by UTF-8 by using BOM encoding, such as \<BOM\>.

    To fix mismatches, [rename attributes in Viva Glint](/viva/glint/setup/update-attributes#edit-attribute-names) or update the attribute headers in the file.
1. Save the file, and then upload it again to Viva Glint.

## File isn't UTF-8 encoded

Error message:

> DERIVATION_ERROR: File isn't UTF-8 encoded. Error found near lines \<x-y\>. Format the file with UTF-8 encoding and then reupload.

This issue occurs because the .csv file that you upload isn't saved by using UTF-8 encoding.

### Resolution

To fix the issue, follow these steps in Microsoft Excel or a text editor to resave the file by using UTF-8 encoding:

- In Microsoft Excel:

    1. [Import the .csv file in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
    1. Select **File** > **Save As**.
    1. In the **Save As** dialog box, select **CSV UTF-8 (Comma delimited)** from the **Save as type** dropdown box, and then select **Save**.
- In a text editor, such as Notepad or Notepad++:
    1. Open the .csv file.
    1. Select **File** > **Save as**.
    1. In the **Save as** dialog box, enter a file name in the **File name** box,  select **All files** from the **Save as type** dropdown box, select **UTF-8** from the **Encoding** dropdown box, and then select **Save**.

Then, upload the file again to Viva Glint.

**Note**: To avoid this issue in the future, work with your Human Resources Information System (HRIS) team to make sure that all files that are automatically sent to Viva Glint are encoded using UTF-8 rather than **UTF-8 with BOM**.

## File is in an unexpected format

Error messages:

- > DERIVATION_ERROR: File is in an unexpected format. Expecting csv file format. Check to see if the file passed is a csv file with UTF-8 encoding and comma delimited values.
- > DERIVATION_ERROR: File is in an unexpected format. Expecting xlsx file format. Check to see if the file passed is a xlsx file with no formulas and no additional sheets.

This issue occurs because the file that you upload isn't in the format that's specified when you set up attributes in Viva Glint.

### Resolution

To fix the issue, resave the file in the expected format and upload it again to Viva Glint.

- If the expected format is CSV:
  - Resave the file as a CSV file by using UTF-8 encoding, not **UTF-8 with BOM**.
  - Separate values by using commas. If any values contain commas, enclose them in double quotation marks (for example, "Manager, Customer Success").
- If the expected format is XLSX:
  - Resave the file as an XLSX file.
  - Remove any passwords.
  - Make sure that the file contains no formulas.
  - Keep only one sheet of data.

## Derivation failed due to invalid data

Error message:

> DERIVATION_ERROR: Processing the file failed. Derivation failed due to invalid data in \<attribute, such as Hire Date\>. Review and reupload file.

This issue occurs because the file you that upload contains invalid data, such as:

- 00/00/0000
- 01/01/1900
- #N/A
- #REF

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. For the attribute that's listed in the error message, check the values and identify any invalid data.
1. Correct or remove invalid data.
1. Save the file, and then upload it again to Viva Glint.

## Row length doesn't match header's length

Error message:

> ENRICHMENT_FAILURE: Row \<line number, such as 100\> length doesn't match header's length. Can't create file.

### Resolution

  align with the number of columns in the file's header row.

To fix the issue, follow these steps:

1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. Review the row that's specified in the error message.
1. Update the data that's in that row to match the number of columns in the header row.
1. Save the file, and then upload it again to Viva Glint.

## MANAGER_HIERARCHY_UPDATE_ERROR

Error message:

> MANAGER_HIERARCHY_UPDATE_ERROR: There should be at least one employee record with no manager, otherwise the reporting hierarchy may be invalid. Leave the Manager ID empty for the CEO/top level leader.

This issue occurs if the CEO or top-level person has a **Manager ID** value assigned.

### Resolution

To fix the issue, follow these steps:

1. In the employee attribute data file, locate the CEO or top-level person, and then remove their Manager ID value.

    **Note**: Make sure that the **Manager ID** field is blank. Don't enter a space or "NULL" as the value.
1. Save the file, and then upload it again to Viva Glint.

To avoid this issue in the future, work with your Human Resources Information System (HRIS) team to make sure that the **Manager ID** field is blank for the CEO or top-level person in the employee attribute data.

## MANAGER_HIERARCHY_ERROR

Error message:

> MANAGER HIERARCHY ERROR: Manager Email address snguyen@contoso.com is mentioned more than once in chain of commands, creating a cycle. They either are reporting to themselves or are creating a circular reporting with another user that needs to be resolved.

This error occurs if the employee attribute data shows that one or more managers either report to themselves or have a circular reporting relationship with other managers.

### Resolution

To fix the issue, follow these steps:

1. In the admin dashboard, select the **Configure** icon, then select **Activity Audit Log** in the **Client Settings** section.
1. In the log, locate the file that didn't upload, and then select **Download errors file** in the **Details** column. The rows in the downloaded errors file represent both direct and indirect reports for each manager.
1. [Find and remove duplicate data](https://support.microsoft.com/office/find-and-remove-duplicates-00e35bea-b46a-4d5d-b28e-66a552dc138d) from the **Description** column of the errors file.
1. Identify the distinct manager email addresses that are noted in the errors file as problematic.
1. For each manager email address that's identified in step 4, review the employee attribute data to determine whether the following circular reporting relationships appear to exist:

   - A manager reports to themselves. Therefore, their employee ID and manager ID are the same.
   - Two or more managers report to each other and create a reporting loop. For example, manager A reports to manager B, and manager B reports to manager A.
1. Correct all apparent circular reporting relationships.

   > [!NOTE]
   >
   > - The CEO or top-level person in your organization shouldn't be shown as reporting to themself. Their **Manager ID** field should always be blank.
   > - If a manager is displayed as reporting to themself because their manager position has to be filled, specify the manager ID of their skip-level manager, instead.

1. Save the file, and then upload it again to Viva Glint.
