---
title: Resolve upload errors and warnings related to employee ID updates
description: Fix errors and warnings that occur when you update employee IDs by uploading a file to Microsoft Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 12/10/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - sap:User Management\Add or Remove or Update users
  - CSSTroubleshoot
  - CI2675
---

# Resolve upload errors and warnings related to employee ID updates

When you try to [update employee IDs](/viva/glint/setup/id-update#update-employee-ids-in-bulk) by uploading a file to Microsoft Viva Glint, you receive one of the following error or warning messages. Select the message that you receive from the list at the top of the article and follow the appropriate resolution.

## CONFIGURATION_ERROR: Columns

**Message:**

> This file must contain the First Name, Last Name, Email Address, and New Employee ID.  All of these columns must be present, with no additional columns.  Please correct and resubmit.

**Issue type:** File-level error

This error occurs if the uploaded file contains extra columns in addition to the required columns.

### Resolution

To fix the issue, remove all columns except the following required columns from the file:

- First Name
- Last Name
- Email Address
- Employee ID

Then, try again to upload the file to Viva Glint.

## MISSING_COLUMN

**Message:**

> Missing mandatory column \<attribute name\>. Add this column of data to your file and reupload.

**Issue type:** File-level error

This error occurs if one of the following required columns is missing from the uploaded file:

- First Name
- Last Name
- Email Address
- Employee ID

### Resolution

To fix the issue, add the missing column and its data to the file. Then, try again to upload the file to Viva Glint.

## UNEXPECTED_ATTRIBUTE

**Message:**

> The following attribute/attributes '\<attribute name 1\>', '\<attribute name 2\>' are in file but not configured in Glint. If this is a new attribute, use the self-serve feature in Glint by navigating to Settings -> Configure -> People and add new attributes or email support.

**Issue type:** File-level error

This issue is caused by a mismatch between the attribute header in the uploaded file and the attribute names that are specified in Viva Glint.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Review attribute names that are specified in Viva Glint:

    1. In the admin dashboard, select the **Configuration** icon, and then select **People** in the **Employees** section.
    1. Select **Actions** > **Manage User Attributes**.
    1. Review the attribute names that are marked as **Required** in the **Active Attributes** section.
1. For each column that's listed in the error message, update its value in the header row of the file to match the corresponding attribute name in Viva Glint.
1. Save the file, and then try again to upload it to Viva Glint.

## CONFIGURATION_ERROR: No new values

**Message:**

> All Employee Ids match the existing values for all users. Please upload a different data file and resubmit.

**Issue type:** File-level error

This error occurs if all employee IDs in the uploaded file are identical to values that are already in Viva Glint.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Review and update the values in the **Employee ID** field. Make sure that all new ID values are included.
1. Save the file, and then try again to upload it to Viva Glint.

## CONFIGURATION_ERROR: Blank IDs

**Message:**

> This file has a missing Employee Id at line \<x\>.  Please correct and resubmit.

**Issue type:** File-level error

This error occurs if an employee record in the uploaded file is missing the employee ID value.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the error message, and then enter the correct value in the **Employee ID** field.

    > [!NOTE]
    > The header row isn't included in the row count. For example, if the error message indicates line 20, go to row 21.
1. Save the file, and then try again to upload it to Viva Glint.

## NO_EMPLOYEE_RECORD

**Message:**

> Line \<x\> with email user@contoso.com does not correspond to any existing user in Viva Glint. Please correct and resubmit.

**Issue type:** File-level error

This error occurs if the uploaded file contains email addresses that aren't associated with any user in Viva Glint.

## Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. In the admin dashboard, select the **Configuration** icon, and then select **People** in the **Employees** section.
1. For each row that's listed in the error message, follow these steps:

    > [!NOTE]
    > The header row isn't included in the row count. For example, if the error message indicates line 20, go to row 21.

    1. On the **People** page, search for the associated user by their first and last name.
    1. Select the user to open their profile.
    1. Copy the email address and use it to replace the value in the **Email Address** field in the file.
1. Save the file, and then try again to upload it to Viva Glint.

## SUSPICIOUS_VALUE

**Message:**

Warning at line \<x\>: The First Name of \<y\> does not match the stored value of \<z\>.

Or:

Warning at line \<x\>: The Last Name of \<y\> does not match the stored value of \<z\>.

**Issue type:** Line-level warning

This warning message occurs if a user's first or last name doesn't match the values in Viva Glint. This warning doesn't cause the employee ID update to fail.

### Resolution

If names changes are expected, you can ignore the warning. Otherwise, [upload an employee data file](/viva/glint/setup/upload-employee-attributes#process-for-import-of-employee-attributes) to correct the user names in Viva Glint.

## DUPLICATE_IN_FILE

**Message:**

> Lines \<x\> and \<y\> contain the same Employee ID of \<z\>. Each ID must be unique. Please correct and resubmit.

**Issue type:** File-level error

This error occurs if multiple users have the same employee ID in the uploaded file.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. For each row that’s listed in the error message, enter a unique employee ID in the **Employee ID** field.

    > [!NOTE]
    > The header row isn't included in the row count. For example, if the error message indicates line 20, go to row 21.
1. Save the file, and then try again to upload it to Viva Glint.

## DUPLICATE_ID

**Message:**

> The Employee ID \<ID value\> on line \<y\> is already associated with user@contoso.com. Please correct and resubmit.

**Issue type:** File-level error

This issue occurs if an employee ID in the uploaded file is already assigned to a different user in Viva Glint.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the error message, and then enter a unique employee ID that's not associated with any other users in Viva Glint.

    > [!NOTE]
    > The header row isn't included in the row count. For example, if the error message indicates line 20, go to row 21.
1. Save the file, and then try again to upload it to Viva Glint.
