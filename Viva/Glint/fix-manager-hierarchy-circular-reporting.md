---
title: Resolve manager hierarchy error in Viva Glint
description: Fix issues that cause circular reporting in manager hierarchy when you upload employee attribute data to Microsoft Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 8/25/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI180068
localization_priority: Normal
---

# Resolve manager hierarchy error in Viva Glint

## Symptoms

You receive the following error message when you upload employee attribute data to Microsoft Viva Glint:

> MANAGER HIERARCHY ERROR: Manager Email address snguyen@example.com is mentioned more than once in chain of commands, creating a cycle. They either are reporting to themselves or are creating a circular reporting with another user that needs to be resolved.

## Cause

This error occurs if one or more managers either report to themselves or create a circular reporting relationship with other managers.

## Resolution

To fix the issue, follow these steps:

1. From the admin dashboard, select the **Configure** symbol, then select **Activity Audit Log** in the **Client Settings** section.
2. In the log, locate the file that failed to upload and select **Download errors file** from the **Details** column. The rows in the downloaded errors file represent both direct and indirect reports for each manager.
3. [Find and remove duplicates](https://support.microsoft.com/office/find-and-remove-duplicates-00e35bea-b46a-4d5d-b28e-66a552dc138d) from the **Description** column of the errors file.
4. Identify the distinct manager emails that are noted as problematic in the errors file.
5. For each manager email address that's identified in step 4, review the employee attribute data to determine whether the following circular reporting relationships exist:

   - A manager reports to themselves, so their employee ID and manager ID are the same.
   - Two or more managers report to each other and create a reporting loop. For example, manager A reports to manager B, and manager B reports to manager A.
6. Correct all circular reporting relationships.

   > [!NOTE]
   >
   > - The CEO or top-level person in your organization shouldn't report to themselves. Their manager ID should always be blank.
   > - If a manager displays as reporting to themselves because their manager's position needs to be filled, have them report to their skip-level manager.

7. Reupload the file to Viva Glint.
