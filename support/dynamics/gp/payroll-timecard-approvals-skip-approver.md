---
title: Payroll employee self service timecard approvals skip approver
description: Provides a solution to an issue where payroll employee self service timecard approvals aren't going to correct approver in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/12/2024
ms.custom: sap:Payroll
---
# Payroll employee self service timecard approvals aren't going to correct approver in Microsoft Dynamics GP

This article provides a solution to an issue where payroll timecard approvals aren't going to correct approver in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4132654

## Symptoms

Payroll employee self service timecard approvals aren't going to correct approver in Microsoft Dynamics GP, or skipping direct managers.

## Cause

Workflow will route to the manager defined in Active Directory, not the supervisor ID assigned to the Employee in Dynamics GP on the Employee Maintenance card.

> [!NOTE]
> If someone else resubmits a workflow, the system would consider the Windows user sign-in on that machine as the requestor.

If the system is unable to find the approver, it will be routed to the workflow manager by default.

## Resolution

Workflow is driven by Active Directory, the supervisor field in Payroll isn't used in this process. The manager that will be used for workflow is the manager listed in Active Directory under the **Organization** tab of the user, when you select **Properties**. You may need to add the managers in Active Directory, not on the supervisor of the employee.

[Employee to Direct Manager Workflow: How it works](https://community.dynamics.com/blogs/post/?postid=58486234-57cd-42af-b825-323a6434ad72) is a blog article that explains how this process works as well.
