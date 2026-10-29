---
title: Resolve file upload warnings related to manager hierarchy
description: Fix warnings that occur when you upload employee attribute data to Microsoft Viva Glint. These warnings are related to manager hierarchy calculation.
manager: dcscontentpm
ms.reviewer: amywheater, ahosabettu
ms.date: 10/29/2026
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
- CSSTroubleshoot
- CI190692
---

# Resolve file upload warnings related to manager hierarchy

When you upload employee attribute data to Microsoft Viva Glint, you may receive one of the following warning messages. To fix the issue, select the relevant error, and follow the appropriate resolution.

## MANAGER_HIERARCHY_SELF_REFERENCE_WARNING (employee ID matches manager ID) 

**Message:**

> MANAGER_HIERARCHY_SELF_REFERENCE_WARNING: There are {count} employee records where EmployeeID is the same as ManagerID. These records will be treated as the CEO/top of the hierarchy.

**Issue type:** Line-level warning

This warning occurs when an employee's Employee ID and Manager ID contain the same value. This creates a self-reference in the manager hierarchy, because the employee is identified as their own manager. 

Viva Glint treats employees with this condition as the CEO or top-level person in the manager hierarchy. 

### Resolution

To fix the issue, follow these steps: 

1. In the employee attribute data file, identify employees whose Employee ID is the same as their Manager ID. 
1. Review the reporting relationship for each identified employee. 
1. If the employee reports to another employee, replace the Manager ID with the Employee ID of their correct manager. 
1. If the employee is the CEO or top-level person in the organization, leave the Manager ID field blank. 
1. Upload the corrected employee attribute data file to Viva Glint. 

## MANAGER_HIERARCHY_UPDATE_WARNING (no manager ID assigned)

**Message:**

> MANAGER_HIERARCHY_UPDATE_WARNING: There are \<number\> employee records without a manager. The CEO/top of hierarchy shouldn't have a Manager ID. Employees without a Manager won't be reported in Manager reports, their scores/response won't roll up into any manager. The first 20 records: user1@contoso.com, user2@contoso.com...

**Issue type:** Line-level warning

> [!NOTE]
> Results for employees without a Manager ID won't appear in the manager hierarchy results but will still be aggregated to other attributes and the overall organization score.

This issue occurs if employees other than the CEO or top-level person aren't assigned a **Manager ID** value. Only the CEO or top-level person should have a blank Manager ID field.

### Resolution

To fix the issue, follow these steps:

1. In the employee attribute data file, review all employees whose **Manager ID** field is blank, except the CEO or top-level person.
1. Enter their Manager ID values.

   > [!NOTE]
   > If there are employees whose manager role has to be entered, use the Manager ID of their skip-level manager.

1. Upload the file again to Viva Glint.

## MANAGER_HIERARCHY_UPDATE_WARNING (missing manager record)

**Message:**

> MANAGER_HIERARCHY_UPDATE_WARNING: external user id \<x\> is mapped to manager reference \<y\> which is not on file or system. This will cause your manager's hierarchy to be incomplete and employee results don't roll into Manager Hierarchy views in reporting.

**Issue type:** Line-level warning

This issue occurs if the uploaded file contains employees who are shown to report to a manager whose Manager ID doesn't have a corresponding employee record.

### Resolution

To fix the issue, follow these steps:

1. In the admin dashboard, select the **Configuration** icon, then select **Activity Audit Log** in the **Service Configuration** section.
1. In the log, locate the file that didn't upload, and then select **Download errors file** in the **Details** column.
1. In the errors file, identify the Manager IDs that are listed as nonexistent.
1. For each Manager ID that's identified in step 3, add corresponding employee records in the original employee attribute data.

   > [!NOTE]
   > If there are managers (non-CEO level) who aren't part of the regular employee upload (for example, they are on leave or are contractors), set their **Status** value to **INACTIVE** in the employee attribute data file to complete your manager hierarchy.

1. Upload the file again to Viva Glint.
