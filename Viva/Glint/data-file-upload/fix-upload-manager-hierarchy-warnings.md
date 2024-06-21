---
title: Resolve file upload warnings related to manager hierarchy
description: Fix warnings that occur when you upload employee attribute data to Microsoft Viva Glint. These warnings are related to manager hierarchy calculation.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 06/21/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI190692
localization_priority: Normal
---

# Resolve file upload warnings related to manager hierarchy

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following warning messages. Select the warning that you experience from the list at the top of the article, and follow the appropriate resolution to fix the warning.

## MANAGER_HIERARCHY_UPDATE_WARNING

Warning message:

> MANAGER_HIERARCHY_UPDATE_WARNING: There are \<number\> employee records without a manager. The CEO/top of hierarchy shouldn't have a Manager ID. Employees without a Manager won't be reported in Manager reports, their scores/response won't roll up into any manager. The first 20 records: user1@contoso.com, user2@contoso.com...

**Note**: Results for employees without a Manager ID won't appear in the manager hierarchy results but will still be aggregated to other attributes and the overall organization score.

This issue occurs if employees other than the CEO or top-level person aren't assigned a **Manager ID** value. Only the CEO or top-level person should have a blank Manager ID field.

### Resolution

To fix the issue, follow these steps:

1. In the employee attribute data file, review all employees whose **Manager ID** field is blank, except the CEO or top-level person.
1. Enter their Manager ID values.

   **Note**: If there are employees whose manager role has to be entered, use the Manager ID of their skip-level manager.
1. Upload the file again to Viva Glint.

## INVALID_MANAGER_HIERARCHY

Warning message:

> INVALID_MANAGER_HIERARCHY: User id \<ID\> has a nonexistent Manager ID \<manager ID\>. This will cause your manager's hierarchy to be incomplete.

This issue occurs if the uploaded file contains employees who are shown to report to a manager whose Manager ID doesn't have a corresponding employee record.

### Resolution

To fix the issue, follow these steps:

1. In the admin dashboard, select the **Configuration** icon, then select **Activity Audit Log** in the **Service Configuration** section.
1. In the log, locate the file that didn't upload, and then select **Download errors file** in the **Details** column.
1. In the errors file, identify the Manager IDs that are listed as nonexistent.
1. For each Manager ID that's identified in step 3, add corresponding employee records in the original employee attribute data.

   **Note**: If there are managers (non-CEO level) who aren't part of the regular employee upload (for example, they are on leave or are contractors), set their **Status** value to **INACTIVE** in the employee attribute data file to complete your manager hierarchy.
1. Upload the file again to Viva Glint.
