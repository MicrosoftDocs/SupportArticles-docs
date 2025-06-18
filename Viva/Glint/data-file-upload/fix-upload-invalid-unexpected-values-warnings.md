---
title: Resolve file upload warnings related to invalid or unexpected values
description: Fix issues that cause invalid or unexpected values when you upload employee attribute data to Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 05/12/2025
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - sap:User Management\Import or Export users
  - CSSTroubleshoot
  - CI190695
  - CI192293
---

# Resolve file upload warnings related to invalid or unexpected values

When you upload employee attribute data to Microsoft Viva Glint, you receive one of the following warning messages. Select the warning that you experience from the list at the top of the article, and follow the appropriate resolution to fix the issue.

## RECORD_STAGING_FAILURE

Warning message:

> RECORD_STAGING_FAILURE: Found \<x\> existing record that has been previously deleted corresponding to line number \<y\>.

This issue occurs if users are deleted from Microsoft Entra ID and their corresponding records in Viva Glint are marked as **Deleted**. The [Disregard Employee IDs of previously deleted employees](/viva/glint/setup/manage-general-settings#disregard-employee-ids-of-previously-deleted-employees) setting manages how Viva Glint processes deleted user records.

### Resolution

To fix the issue, use one of the following methods:

- If you upload the data by using **Import** on the **People** page, confirm the upload. This way records that are marked as deleted in Microsoft Entra ID and Viva Glint will be skipped. All other data without other errors or warnings will be imported into Viva Glint.

  > [!NOTE]
  > If you upload the data by using Viva Glint Secure File Transfer Protocol (SFTP), records that are marked as deleted will be automatically skipped.
- Remove the deleted records and upload the file again. Follow these steps:

  1. If necessary, work with your Microsoft 365 or Entra ID administrator to confirm the users that are deleted from Microsoft Entra ID.
  1. Open the employee attribute data file. Use the appropriate method depending on the file type:
  
       - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
       - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
  1. Remove the rows that are listed in the warning message.

     > [!NOTE]
     > The header row isn't included in the row count. For example, if the warning indicates line 20, go to row 21.
  1. Save the file, and upload it again to Viva Glint.

## INVALID_EMPLOYEE_DATA: unsupported characters

Warning message:

> INVALID_EMPLOYEE_DATA: Skipping line number \<x\> because column \<y\> contains unsupported characters.

This issue occurs because the file that you uploaded contains old Kanji characters. Viva Glint supports only modern Kanji characters.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the warning message.

    > [!NOTE]
    > The header row isn't included in the row count. For example, if the warning indicates line 20, go to row 21.
1. Review the value in the column that's listed in the warning message.
1. Replace all old Kanji characters with modern Kanji characters. Or, delete the old Kanji characters.
1. Save the file, and upload it again to Viva Glint.

## MISSING_REQUIRED_VALUE

Warning message:

> MISSING_REQUIRED_VALUE: Line \<x\> is missing a required value for Employee First Name, Employee Last Name, and Email address for user ID \<ID\>.

This issue occurs if an employee record in your file is missing values for one or more of the following required fields:

- First name
- Last name
- Email address
- Employee ID
- Status

### Resolution

To fix the issue, follow these steps:

1. Review the employee attribute data file to identify rows in which values are missing for the required fields.
1. Complete the affected fields with valid values.

    > [!NOTE]
    > For employees that have only a first name provided, populate the **Last name** field with a hyphen (-) or a period (.).
1. Save the file, and upload it again to Viva Glint.

## INVALID_EMAIL

Warning message:

> INVALID_EMAIL: There are \<number\> employees without a valid Work Email, which could be related to employees with an Employee ID sent as the email value.

### Resolution

To fix the issue, verify that email addresses are in a valid format, including the at sign (@) and a domain. If you've intentionally populated the **Email** attribute by using the Employee ID, consider appending *@\<your organization's domain\>* to the Employee ID value to satisfy this validation.

## FIELD_TOO_BIG_FATAL

Warning messages:

> FIELD_TOO_BIG_FATAL: Required field \<Attribute Name\> can't be longer than 64 characters.

### Resolution

To fix the issue, check for fields that might be accidentally strung together. Review the file and verify that all required attributes have values that are less than 64 characters.

> [!NOTE]
> For the **Status** field, the limit is 32 characters.

## CHAR_LIMIT_EXCEED_NON_MANDATORY

Warning message:

> CHAR_LIMIT_EXCEED_NON_MANDATORY: Non-Required field \<Attribute Name\> is longer than 64 characters. As a result, the value has been truncated to 64 characters, which is what will be shown in reporting. (Number of employees impacted: \<number\>)

### Resolution

To fix the issue, check for fields that might be accidentally strung together. Review the file and verify that these attributes have values that are less than 64 characters. Shorten any truncated values ​​as necessary, and then upload the file to Viva Glint.

## SUSPICIOUS_VALUE

Warning message:

> SUSPICIOUS_VALUE: Value of Employee \<Attribute Name\> for Employee ID \<ID\> contains suspicious characters. Check for special/unexpected characters that may have been corrupted and reupload your file to correct.

### Resolution

To fix the issue, check the file for the following characters and remove them if necessary:

- Uncommon characters, such as ? or _
- Special language characters that might be corrupted

Then, upload the file again to Viva Glint.

## INVALID_STATUS

Warning message:

> INVALID_STATUS: Status value 'LEAVE' is invalid. This value needs to be exactly "ACTIVE" or "INACTIVE", in all caps.

### Resolution

To fix the issue, make sure that the value of the **Status** attribute contains only ACTIVE or INACTIVE (all uppercase).

## UNEXPECTED_ATTRIBUTE

Warning message:

> UNEXPECTED_ATTRIBUTE: The following attribute/attributes '\<Attribute Name\>' are in the file but not configured in Viva Glint.

This issue occurs in one of the following situations:

- There is a new attribute in the uploaded file, but it isn't included in the attributes that are set up in Viva Glint.
- There is an existing attribute whose label is changed in the header row of the uploaded file. For example, **Department** is changed to **Division**.
- The **Status** attribute isn't saved correctly in Viva Glint and is listed in the warning message.

### Resolution

To fix the issue, use one of the following methods, depending on the cause:

- If there is a new attribute in the uploaded file, [add the attribute](/viva/glint/setup/update-attributes#add-new-attributes-to-viva-glint) to Viva Glint.
- If there is an existing attribute that's renamed in the uploaded file, [rename the attribute](/viva/glint/setup/update-attributes#edit-attribute-names) in Viva Glint.
- If the **Status** attribute is listed in the warning message, follow these steps in Viva Glint:

    1. Rename the attribute to a temporary value, and save the change.
    1. Revert the name to the correct value.

After you update the attributes, upload the file again to Viva Glint.

## INVALID_LOCALE

Warning message:

> INVALID_LOCALE: Line \<x\> the Locale value \<locale\> is not a valid locale string.

This issue occurs if the file that you upload contains invalid language code values.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the warning message.

   > [!NOTE]
   > The header row isn't included in the row count. For example, if the warning indicates line 20, go to row 21.
1. Replace the invalid **Locale** value with a valid value. For a list of valid language code values, see [Viva Glint supported languages](/viva/glint/setup/supported-languages).
1. Save the file, and upload it again to Viva Glint.

## INVALID_USER_TIMEZONE

Warning message:

> INVALID_USER_TIMEZONE: Line \<x\> the User Timezone value \<timezone\> is not a valid international timezone string.

This issue occurs if the file that you upload contains invalid time zone values.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the warning message.

   > [!NOTE]
   > The header row isn't included in the row count. For example, if the warning indicates line 20, go to row 21.
1. Replace the invalid **User Timezone** value with a valid value. For a list of valid time zone values, see [Viva Glint supported time zones](/viva/glint/setup/supported-time-zones).
1. Save the file, and upload it again to Viva Glint.

## INVALID_PERSONAL_EMAIL

Warning message:

> INVALID_PERSONAL_EMAIL: Line \<x\> the Personal Email value '\<email address\>' is not formatted like a valid email address.

This issue occurs because the file that you tried to upload contains invalid values for the personal email address attribute.

### Resolution

To fix the issue, follow these steps:

1. Open the employee attribute data file. Use the appropriate method depending on the file type:

    - If the data file has an *.xls* or a *.xlsx* extension, open it in Microsoft Excel.
    - If the data file has a *.csv* extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
1. Locate the row that's listed in the warning message.

   > [!NOTE]
   > The header row isn't included in the row count. For example, if the warning indicates line 20, go to row 21.
1. Replace the invalid **Personal Email** value with a valid value. A valid email address uses the following syntax:

   \<username\>@\<email domain\>

   For example, john@outlook.com.
1. Save the file, and upload it again to Viva Glint.

   > [!NOTE]
   > You can confirm the current upload, and add the corrected addresses in a future upload. However, until they are corrected, personal email addresses that are in an invalid format will remain associated with the affected users in Viva Glint.
