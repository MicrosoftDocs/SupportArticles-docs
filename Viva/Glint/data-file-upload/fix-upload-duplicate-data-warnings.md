---
title: Resolve file upload warnings related to duplicate data
description: Fix warnings that occur when you upload employee attribute data to Microsoft Viva Glint. These warnings are caused by duplicate data.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 06/21/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI190691
localization_priority: Normal
---

# Resolve file upload warnings related to duplicate data

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following warning messages that are caused by duplicate data. Select the warning that you experience from the list at the top of the article, and follow the appropriate resolution to fix the warning.

## INVALID_EMPLOYEE_DATA: Email is assigned to multiple users

Warning message:

> INVALID_EMPLOYEE_DATA: Email \<Email address, such as user@contoso.com\> is assigned to multiple users in the file.

This issue occurs because multiple users in the uploaded file share the same email address. Email addresses must be unique in the employee attribute data.

### Resolution

To fix the issue, follow these steps:

1. In the admin dashboard, select the **Configuration** icon, then select **Activity Audit Log** in the **Service Configuration** section.
1. In the log, locate the file that didn't upload, and then select **Download errors file** in the **Details** column.
1. Open the errors file, identify the users who are assigned the email address that's mentioned in the warning message.
1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. For each user that's identified in step 3, enter a unique email address.

    **Note**: For employees who aren't assigned an email address yet, use the following value as their email address:

    \<Employee ID\>@\<your organization's domain\>
1. Save the employee attribute data file, and then upload it again to Viva Glint.

## DUPLICATED_EMAIL

Warning message:

> DUPLICATED_EMAIL: The Email Address \<Email address, such as user@contoso.com\> in the user file is already assigned to a different user in your Viva Glint People Database.

This issue occurs because one or more users in the uploaded file are assigned an email address that's already associated with a different user in Viva Glint. Email addresses must be unique in the employee attribute data.

### Resolution

To fix the issue, follow these steps:

1. In the admin dashboard, select the **Configure** icon, then select **People** in the **Employees** section.
1. Locate the user that's associated with the email address that's mentioned in the warning message, and then select the user to view their profile.

    **Note**: If the user status is **INACTIVE** and your organization recycles email addresses for employees who have left, we recommend that you change their email address to their Employee ID so that the email address can be assigned to a new employee. This action is also recommended when you deactivate a user in Viva Glint.
1. Open the employee attribute data file in Excel. If the file is in .csv format, [import it in Excel](https://support.microsoft.com/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) to preserve the data in the expected format.
1. Identify all users that are assigned the email address that's mentioned in the warning message in the data file.
1. For each user that's identified in step 4, compare their Employee ID to the Employee ID of the user that's found in step 2. If the Employee ID is different, enter a unique email address for the user in the data file.
1. Save the employee attribute data file, and then upload it again to Viva Glint.

## DUPLICATED_EXTERNAL_USER_ID

Warning message:

> DUPLICATED_EXTERNAL_USER_ID: The Employee ID \<ID\> in the user file is already assigned to another employee with Email Address \<Email address, such as user@contoso.com\> in the Viva Glint database.

### Resolution

To fix the issue, identify the correct Employee ID for the associated employee records. Compare the employees in your user file to the **People** section in Viva Glint, and then upload the user file again after it's corrected.
