---
title: Understand file upload errors and warnings in Viva Glint
description: When a file upload error occurs en-route to Viva Glint, a message directs you to the Activity Audit log for remedial information.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/16/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI183996
localization_priority: Normal
---

# Understand file upload errors and warnings in Viva Glint

When a file upload error occurs, you're directed to the **Error Messages** section on the **Activity Audit Log** page within your admin dashboard for full details of the error.

Viva Glint file upload messages indicate:

- file errors that prevent any data from processing.
- line/field warnings that prevent certain rows of data from processing.

Refer to the following tables to understand and resolve errors and warnings.

## Address file errors

### Address file errors related to attributes derived by Viva Glint

| **Category** | **Sample Message** | **Action** |
| --- | --- | --- |
| DERIVATION_ERROR | *The date format is incorrectly configured for the following columns: (Hire Date). We're expecting mm/dd/yyyy. For Microsoft Excel files, ensure that cells are in Text format.* | Update the date fields in your file to match what's configured for your organization. Be sure to use the same formatting. |
| DERIVATION_ERROR | *Attribute headers in the uploaded file don't match your Viva Glint configuration. Ensure that all attribute header names match and are included in your file. Include columns Hire Date and Birth Year. These columns are used for deriving attributes Tenure, Age Group.* | Make sure that all attribute header names match your configuration and are included in your file. Check for case sensitivity and extra spaces between the header row in your file and your Viva Glint setup. |
| DERIVATION_ERROR | *File isn't UTF-8 encoded. Error found near lines 4405-4605. Format the file with UTF-8 encoding and then reupload.* | Resave your file with UTF-8 encoding and reupload. If you're unable to provide UTF-8 encoding, upload it as an .xlsx file instead. |
| DERIVATION_ERROR | *File is in an unexpected format. Expecting csv file format. Check to see if the file passed is a csv file with UTF-8 encoding and comma delimited values.* | Viva Glint expects csv or xlsx file format. Check whether the passed file is in the correct format. |
| DERIVATION_ERROR | *Processing the file failed. Derivation failed due to invalid data in Hire Date. Review and reupload file.* | Correct invalid values in the specified attributes (for example, 1/1/1900 or #N/A) and reupload the file. |
| ENRICHMENT_FAILURE | *Row 100 length doesn't match header's length. Can't create file.* | Review the row specified in the uploaded csv file and update to align with the number of columns in the file's header row. |
| MANAGER_HIERARCHY_UPDATE_ERROR | *There should be at least one employee record with no manager, otherwise the reporting hierarchy may be invalid. Leave the Manager ID empty for the CEO/top level leader.* | The Manager Hierarchy can't be created unless the CEO's Manager ID value is blank. Remove the Manager ID value for the CEO or top-level manager in the file and reupload. |
| MANAGER_HIERARCHY_ERROR | *Manager Email address `snguyen@example.com` is mentioned more than once in chain of commands, creating a cycle.* | Make sure that no manager reports to themselves or creates a circular reporting relationship with another user. No employee should be listed as managing themselves. |

### Address file errors related to attributes

| **Category** | **Sample Message** | **Action** |
| --- | --- | --- |
| DUPLICATE_COLUMN | *Column Tenure appears 2 times. Column Tenure can only appear once.* | Columns can only appear once. Delete the extra column. If Viva Glint creates a column based on source data (for example, Tenure from Hire Date), don't include the derived field as a column. |
| MISSING_COLUMN | *Missing required column Email Address. Add this column of data to your file and reupload.* | Confirm that all five required fields (Employee ID, Email, First Name, Last Name, Status) and all fields Viva Glint uses to derive other fields are included in the file. |

## Address line or field warnings

### Address line or field warnings related to duplicated data

| **Category** | **Sample Message** | **Action** |
| --- | --- | --- |
| INVALID_EMPLOYEE_DATA | *Email `joe@example.com` is assigned to multiple users in the file.* | Verify that the uploaded file contains employees with duplicate Email Addresses or duplicate Employee IDs. Remove duplicates and reload files. |
| DUPLICATED_EMAIL | *The Email Address `launa@example.com` in the user file is already assigned to a different user in your Viva Glint People Database.* | Verify and correct email addresses. Compare the ID associated with the email address in Viva Glint, under **Configure** > **People**, to the ID associated with the email address in your uploaded file (the Employee IDs need to match). If no email address for the employee exists, populate the employee's Employee ID. |
| DUPLICATED_EXTERNAL_USER_ID | *The Employee ID 1234 in the user file is already assigned to another employee with Email Address `sdd@example.com` in the Viva Glint database.* | Identify the correct ID for the associated employee records. Compare the employees in your user file against the **People** section in Viva Glint and then reupload your user file after it's corrected. |

### Address line or field warnings related to invalid or unexpected values

| **Category** | **Sample Message** | **Action** |
| --- | --- | --- |
| INVALID_EMPLOYEE_DATA | *Skipping line number 26 because column contains unsupported characters.* | View the line number (not including the file header in line counts) and column specified in the warning for special characters, most often older Kanji characters. Viva Glint supports only modern Kanji characters, remove, or replace before reuploading. |
| MISSING_REQUIRED_VALUE | *Line 250 is missing a required value for Employee First Name, Employee Last Name, and Email address for user ID EMP123.* | Review the file and add a value for the required attribute (Employee ID, Email, First Name, Last Name, Status). |
| INVALID_EMAIL | *There are 125 employees without a valid Work Email, which could be related to employees with an Employee ID sent as the email value.* | Verify that email addresses are in a valid format, including `@` and a domain. If you've intentionally populated the Employee ID into the Email attribute, consider appending `@example.com` to the Employee ID value to satisfy this validation. |
| FIELD_TOO_BIG_FATAL | *Required field Email can't be longer than 64 characters.* | Check for fields that may be accidentally strung together. Review the file and confirm that all required attributes have values fewer than 64 characters. **Note:** For **Status**, the character limit is 32. |
| CHAR_LIMIT_EXCEED_NON_MANDATORY | *Non-Required field Department is longer than 64 characters. As a result, the value has been truncated to 64 characters, which is what will be shown in reporting. (Number of employees impacted: 23)* | Check for fields that may be accidentally strung together. Review the file and confirm that attributes have values fewer than 64 characters. Shorten any truncated values as needed and reupload the file. |
| SUSPICIOUS_VALUE | *Value of Employee Last Name for Employee ID 1234 contains suspicious characters. Check for special/unexpected characters that may have been corrupted and reupload your file to correct.* | Review data and delete uncommon characters, such as `?` or `_` if needed. Special language characters may be corrupted. |
| INVALID_STATUS | *Status value 'LEAVE' is invalid. This value needs to be exactly "ACTIVE" or "INACTIVE", in all caps.* | Verify that the **Status** attribute contains only ACTIVE or INACTIVE. Check for capitalization. |
| UNEXPECTED_ATTRIBUTE | *The following attribute/attributes 'Personnel Area' are in the file but not configured in Viva Glint.* | If this is a new attribute, navigate to **Settings** > **Configure** > **People** to update your configuration. |

### Address line or field warnings related to manager hierarchy calculation

| **Category** | **Sample Message** | **Action** |
| --- | --- | --- |
| MANAGER_HIERARCHY_UPDATE WARNING | *There are 25 employee records without a manager. The CEO/top of hierarchy shouldn't have a Manager ID. Employees without a Manager won't be reported in Manager reports, their scores/response won't roll up into any manager. The first 20 records: `jsmith@example.com`, `dlopez@example.com`...* | These employees' responses won't be included in manager hierarchy-based report views. Review data to make sure that all employees except the CEO have a Manager ID value assigned. |
| MANAGER_HIERARCHY_UPDATE WARNING | *INVALID_MANAGER_HIERARCHY: User id 01234 has a nonexistent Manager ID 56789. This will cause your manager's hierarchy to be incomplete.* | The manager ID doesn't exist - there's no employee with that ID in the system. Review all assigned Manager IDs in your file and ensure that each manager has a corresponding employee record. |
