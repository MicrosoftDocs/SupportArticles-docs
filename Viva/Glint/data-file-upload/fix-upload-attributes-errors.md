---
title: Resolve file upload errors related to attributes
description: Fix errors that occur when you upload employee attribute data to Microsoft Viva Glint. These errors are related to attributes.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 01/19/2025
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI190687
---

# Resolve file upload errors related to attributes

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following error messages. Select the error that you experience from the list at the top of the article, and follow the appropriate resolution to fix the error.

## DUPLICATE_COLUMN

Error message:

> DUPLICATE_COLUMN: Column \<Attribute Name\> appears 2 times. Column \<Attribute Name\> can only appear once.

### Resolution

To fix the issue, delete the extra column, and then upload the file again to Viva Glint.

> [!NOTE]
> If Viva Glint creates a column that's based on the source data (for example, **Tenure** from **Hire Date**), don't include the derived field as a column in the employee attribute data file.

## MISSING_COLUMN

Error message:

> MISSING_COLUMN: Missing required column '\<Attribute Name\>'. Add this column of data to your file and reupload.

This issue occurs if one or more of the following required columns are missing from the file that you upload:

- First name
- Last name
- Email address
- Employee ID
- Status

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Check whether the missing column that's listed in the error message is included in the file.

   If the column isn't included, add the column and its data, and then go to step 5. Otherwise, go to step 3.
1. Review attribute names that are specified in Viva Glint:

    1. In the admin dashboard, select the **Configuration** icon, and then select **People** in the **Employees** section.
    1. Select **Actions** > **Manage User Attributes**.
    1. Review the attribute names that are marked as **Required** in the **Active Attributes** section.
1. For each column that's listed in the error message, compare its value in the header row of the file to the corresponding attribute name in step 3c, and then fix any mismatches. Make sure that:
    - There is no case inconsistency. For example, **EMPLOYEE ID** and **Employee ID** don't match.
    - There are no extra spaces. For example, **" Status"** and **"Status"** don't match.
    - There are no spelling errors.
    - There are no extra characters. For example, **Email_Address** and **EmailAddress** don't match.

    To fix mismatches, [rename attributes in Viva Glint](/viva/glint/setup/update-attributes#edit-attribute-names) or update the attribute headers in the file.
1. Save the file, and then upload it again to Viva Glint.
