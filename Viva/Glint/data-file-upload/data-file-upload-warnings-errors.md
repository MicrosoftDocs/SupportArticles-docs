---
title: Handle Data File Upload Warnings and Errors in Viva Glint
description: Overview of how to handle data file upload warnings and errors in Viva Glint. 
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 05/22/2025
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI 1120
---

# Handle data file upload warnings and errors in Viva Glint

To upload your employee data to Viva Glint, use one of the following methods:

- [Import the data from the People page](/viva/glint/setup/upload-employee-attributes)
- [Import the data through Secure File Transfer Protocol (SFTP)](/viva/glint/setup/sftp-data-automation)

After the file upload process is completed, you might receive error or warning messages. Errors or warnings can occur at the file level or the line level.

- **File level:** File level issues relate to data across all records in your file or the file itself.
- **Line level:** Line level issues relate to rows of data in your file. The message might provide line numbers to indicate where the issue exists or it might describe conditions where you can find affected rows.
- **Warnings:** Warnings are informational and might require your attention to determine whether corrections are necessary. These records are uploaded to Viva Glint but don't pass validation or might not function as expected because of invalid data.
- **Errors:** Errors are issues that prevent data from being uploaded to Viva Glint. A file-level error prevents the entire file from being uploaded, and a line-level error prevents only specific lines from being uploaded.

> [!NOTE]
> A file-level error means that the upload process failed and stopped. If the file is affected by more issues, those issues don't appear until the existing file-level error is fixed. You might experience further warnings or errors after you fix an error and reupload the data file.

For more information about these issues and how to resolve them, see the following articles:

- [Resolve file upload errors related to attributes](/viva/troubleshoot/glint/data-file-upload/fix-upload-attributes-errors?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload errors related to derived attributes](/viva/troubleshoot/glint/data-file-upload/fix-upload-derivation-errors?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to duplicate data](/viva/troubleshoot/glint/data-file-upload/fix-upload-duplicate-data-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to invalid or unexpected values](/viva/troubleshoot/glint/data-file-upload/fix-upload-invalid-unexpected-values-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve file upload warnings related to manager hierarchy](/viva/troubleshoot/glint/data-file-upload/fix-upload-manager-hierarchy-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)
- [Resolve upload errors and warnings related to employee ID updates](/viva/troubleshoot/glint/data-file-upload/fix-employee-id-updates-errors-warnings?toc=/viva/glint/toc.json&bc=/viva/breadcrumb/toc.json)

If you still can't resolve the issues, [contact Microsoft Support](../contact-support/get-support-viva-glint.md) for further assistance.

## Email notification

When warnings or errors occur during SFTP file uploads, Viva Glint users are notified by email. To manage users that receive notifications, see [Manage SFTP settings](/viva/glint/setup/sftp-data-automation#manage-sftp-settings).

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

> [!NOTE]
> SFTP upload notification messages can contain up to 100 lines of warnings and errors.

## Activity Audit Log

Viva Glint admins can use the [Activity Audit Log](/viva/glint/setup/activity-audit-log) to download a complete list of errors and warnings for data upload failures, and review other data import activities.

> [!NOTE]
> The downloadable error files in the Active Audit Log contain a maximum of 1,000 rows per error category. For example, if there are more than 1,000 warnings for DUPLICATED_EMAIL, only the first 1,000 warnings are included in the file.
