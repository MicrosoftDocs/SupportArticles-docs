---
title: Resolve file upload errors related to attributes
description: Fix errors that occur when you upload employee attribute data to Microsoft Viva Glint. These errors are related to attributes.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 06/21/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI190687
localization_priority: Normal
---

# Resolve file upload errors related to attributes

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following error messages. Select the error that you experience from the list at the top of the article, and follow the appropriate resolution to fix the error.

## DUPLICATE_COLUMN

Error message:

> DUPLICATE_COLUMN: Column \<Attribute Name\> appears 2 times. Column \<Attribute Name\> can only appear once.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. For the column that's listed in the error message, delete the extra column.
1. Save the file, and then upload it again to Viva Glint.

**Note**: If Viva Glint creates a column based on the source data (for example, **Tenure** from **Hire Date**), don't include the derived field as a column in the employee attribute data file.

## MISSING_COLUMN

Error message:

> MISSING_COLUMN: Missing required column '\<Attribute Name\>'. Add this column of data to your file and reupload.

This issue occurs if one or more of the following required columns are missing from the file you upload:

- First name
- Last name
- Email address
- Employee ID
- Status

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file in Microsoft Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. Check whether the missing column that's listed in the error message is included in the file.

   If the column isn't included, add the column and its data, then go to step 5. Otherwise, go to step 3.
1. Review attribute names that are specified in Viva Glint:

    1. In the admin dashboard, select the **Configure** icon, then select **People** in the **Employees** section.
    1. Select **Actions** > **Manage User Attributes**.
    1. Review the attribute names that are marked as **Required** in the **Active Attributes** section.
1. For each column that's listed in the error message, compare its value in the header row of the file with the corresponding attribute name in step 3c, and then fix any mismatches. Make sure that:
    - There is no case inconsistency. For example, **EMPLOYEE ID** and **Employee ID** don't match.
    - There are no extra spaces. For example, **" Status"** and **"Status"** don't match.
    - There are no spelling errors.
    - There are no extra characters. For example, **Email_Address** and **EmailAddress** don't match.
    - There are no characters that are added by UTF-8 by using BOM encoding, such as \<BOM\>.

    To fix mismatches, [rename attributes in Viva Glint](/viva/glint/setup/update-attributes#edit-attribute-names) or update the attribute headers in the file.
1. Save the file, and then upload it again to Viva Glint.
