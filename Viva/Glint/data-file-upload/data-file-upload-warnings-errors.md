---
title: Handle data file upload warnings and errors in Viva Glint
description: Overview of how to handle data file upload warnings and errors in Viva Glint. 
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 10/28/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI 1120
---

# Handle data file upload warnings and errors in Viva Glint

To upload your employee data to Viva Glint, you can use one of the following methods:

- [Import the data from the People page](/viva/glint/setup/upload-employee-attributes)
- [Import the data through Secure File Transfer Protocol (SFTP)](/viva/glint/setup/sftp-data-automation)

Once the file upload process is complete, you might receive error or warning messages. Errors or warnings may occur at the file level or at the line level. Depending on the type of message, take appropriate next steps:

- **File level:** File level issues relate to data across all records in your file or the file itself.
- **Line level:** Line level issues relate rows of data in your file. The message may give line numbers where the issue exists or describe conditions where you can find impacted rows.
- **Warnings:** Warnings are informational may require your attention to determine what, if any, corrections are needed. These records upload into Viva Glint but don't pass validation or may not function as expected due to invalid data.
- **Errors:** Errors are issues that prevent data from uploading to the platform. A file level error prevents the entire file from being uploaded while a line level error prevents only the mentioned lines from being uploaded.

**Note**: A file level error means that the upload process failed and stopped. If the file is affected by more issues, those issues don't appear until the existing file level error is fixed. You might experience further warnings or errors after you fix an error and reupload the data file.

For more information about these issues and how to resolve them, see the following articles:

- [Resolve file upload errors related to attributes](/viva/troubleshoot/glint/data-file-upload/fix-upload-attributes-errors?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload errors related to derived attributes](/viva/troubleshoot/glint/data-file-upload/fix-upload-derivation-errors?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to duplicate data](/viva/troubleshoot/glint/data-file-upload/fix-upload-duplicate-data-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to invalid or unexpected values](/viva/troubleshoot/glint/data-file-upload/fix-upload-invalid-unexpected-values-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to manager hierarchy](/viva/troubleshoot/glint/data-file-upload/fix-upload-manager-hierarchy-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve upload errors and warnings related to employee ID updates](/viva/troubleshoot/glint/data-file-upload/fix-employee-id-updates-errors-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)

If you still can't resolve the issues, [contact Microsoft Support](../contact-support/get-support-viva-glint.md) for further assistance.

## Email notification

When warnings or errors occur during SFTP file uploads, Viva Glint users are notified by email. To manage users that receive notifications, see: [Manage SFTP settings](/viva/glint/setup/sftp-data-automation#manage-sftp-settings).

### Upload from the People page

If the data file is uploaded from the **People** page in Viva Glint, users receive an email message that summarizes data changes and errors when the upload is ready for review and confirmation. To download an error list, open the **People** page, and then select **Review Upload** > **download errors**.

### Upload through SFTP

If the data file is uploaded through SFTP, users who are specified by the admin receive an email message that indicates **Load succeeded** or **Load FAILED** in the subject line when the upload is completed. If the upload is successful but contains warnings, the warnings are included in the body of the email message.

The following table lists possible status values for SFTP file uploads, indicates whether the email message contains warnings or errors, and specifies the actions that are required for admins.

| File upload status | Warnings or errors | Admin action |
| ------ | ------ | ------ |
|Succeeded|No|None|
|Succeeded|Yes|Review and resolve warnings|
|Failed|Yes|Review and resolve errors|

**Note**: SFTP upload notification messages can contain up to 100 lines of warnings and errors.

## Activity Audit Log

Viva Glint admins can use the [Activity Audit Log](/viva/glint/setup/activity-audit-log) to download a complete list of errors and warnings for data upload failures and review other data import activities.

**Note**: The downloadable error files in the Active Audit Log contain a maximum of 1,000 rows per error category. For example, if there are more than 1,000 warnings for DUPLICATED_EMAIL, only the first 1,000 warnings are included in the file.
