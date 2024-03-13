---
title: Workflow is locked and cannot be edited
description: Provides a solution to an error that occurs when trying to modify a workflow type in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This workflow is locked by another user and cannot be edited. Please try again later." when trying to modify a workflow type in Microsoft Dynamics GP

This article provides a solution to an error that occurs when trying to modify a workflow type in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4012573

## Introduction

When trying to modify workflow, you're getting this message:  

> This workflow is locked by another user and cannot be edited. Please try again later.

## Cause

This message is typically caused by a user making a change to the workflow type at the same time, or the change is stuck in the workflow table. When making a change, the workflow type is locked down in the WF00104 table, and when the change is saved, the record is dropped from this table.

## Resolution

Use these steps in SQL Server Management Studio against the company database:

1. Review the workflow table to see if the name of the workflow you're using is listed, to indicate the record is locked.

    ```powershell
    select * from WF00104 where Workflow_Type_Name = 'xxxxxxxxxxxxx'
    ```

    --modify the placeholder for the workflow name

    Example:

    ```powershell
    select * from WF00104 where Workflow_Type_Name = 'Payables Transaction Approval'
    ```

2. If you found a record in this table and no other users are currently editing the workflow type, you can remove it from the table:

    ** *Make sure to have a current backup of the company database before doing this step*, and that no other user is actually modifying the workflow at the same time.

    ```powershell
    Delete WF00104 where Workflow_Type_Name = '
    
    xxxxxxxxxxxxx
    
    '
    ```

    --modify the placeholder for the workflow name

    Example:

    ```powershell
    Delete WF00104 where Workflow_Type_Name = 'Payables Transaction Approval'
    ```

3. Now have the user go back into the Workflow Maintenance window and try to modify the workflow again.
