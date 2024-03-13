---
title: Can't see an expected document to approve in Project Time and Expense
description: This article describes what to do when you are using Project Time and Expense for Business Portal and are approving timesheets or expenses and you do not see a document that you need to approve.
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You do not see an expected document to approve in Project Time and Expense

This article provides a solution to an issue where you can't see an expected document to approve in Project Time and Expense.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2645374

## Symptom

You are set up to use approvals for your timesheet and employee expenses. However, when the manager goes to approve the document for the employee, he is not seeing it in the **Project Document Approval** window.

## Cause 1

Approval information was set up after the transaction was entered. See [Resolution 1](#resolution-1).

## Cause 2

Approvals are not required. See [Resolution 2](#resolution-2).

## Cause 3

The document has not yet been submitted or has already been approved. See [Resolution 3](#resolution-3).

## Resolution 1

The manager and supervisor assigned to the employee is attached to the transaction at the time it is entered by the employee. If the manager or supervisor has been changed recently, the document may be assigned to an unexpected user.

Use one of the following ways to check this setup.

### Option 1

1. Log into Personal Data Keeper as a user who has been granted Administrator Privileges.

2. Open the Timesheet Approval or Employee Expense Approval window by answering Yes to the prompt:

    > You have Administrator privileges as well as organizational approval privileges. Would you like to use your Administrator privileges?

    To open the approval window on the **Transactions** menu, click **Timesheet Approval** or **Expense Report Approval**.

3. Find the document you are trying to approve and highlight the **Document Number** field.

4. Click the icon to the right of Approvals to open the **Approval Status** window.

5. Verify the Manager and Supervisor who is assigned to this document.

Only those people will see the document in Project Document Approval to be able to approve it. In addition, the PDK user with Administrative Privileges is able to approve this document within PDK.

### Option 2

Use SQL to verify who is assigned as the manager and supervisor of this document. To do that run one of the following statements against the company database depending on if it is a timesheet or an employee expense.

Timesheets:

```sql
select PDK_Document_Status, MANAGER, Manager_Approval_Status, SUPERVISOR, Sup_Approval_Status, Administrator, Admin_Approval_Status, * from PDK10000 where PDK_TS_No = 'xx'
```

Employee Expenses:

```sql
select PDK_Document_Status, MANAGER, Manager_Approval_Status, SUPERVISOR, Sup_Approval_Status, Administrator, Admin_Approval_Status, * from PDK10500 where PDK_EE_No = 'xx'
```

> [!NOTE]
> Replace the "xx" in the above statements with the document number in question.

If the MANAGER/SUPERVISOR field is blank, or has an unexpected user's name in it, then only those people can approve the document in Business Portal. In addition, the PDK user with Administrative Privileges is able to approve the document within PDK.

## Resolution 2

Verify in **User Setup** that the **Manager** or **Supervisor** checkbox is marked in the **Expense Report Approvals** or **Timesheet Approvals** areas. If neither of the checkboxes are marked, then approvals are not required and the document may already be in Project Accounting. To open the **User Setup** window log into Personal Data Keeper as the sa user and from the **Setup** menu, point to **System**, and then click **User**.

Also verify whether or not the Either/Or OK for **Submittal** checkbox is marked. If it is marked, then whoever is first between the Manager and Supervisor to do the approval will see the document. However, once it is approved by one of them, the other will not see it.

## Resolution 3

Verify the status of the document in question. To do so run the queries listed in "Option 2" of [Resolution 1](#resolution-1) above.

If the document was just submitted, I would expect the value in the **PDK_Document_Status** field to be a 5 (submitted). Verify that the status of the document is not already 7, 8 or 9 which would indicate it has already been approved.

Refer to [KB article 855415](https://support.microsoft.com/topic/document-statuses-in-pdk-fca80151-629f-28a3-deb4-73b13ee79f78) for the meanings of the Document Statuses (PDK_Document_Status) field.
