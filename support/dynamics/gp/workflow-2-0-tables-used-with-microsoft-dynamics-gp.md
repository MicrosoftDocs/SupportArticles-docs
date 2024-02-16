---
title: Workflow tables used with Microsoft Dynamics GP
description: Workflow tables used with Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/16/2023
---
# Workflow tables used with Microsoft Dynamics GP

This article outlines the Workflow tables used with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3091940

## Summary

The workflow tables are as follows:

WF00100 - Workflow Setup  
WF00104 - Workflow User Security  
WF100001 - Workflow Type Table  
WF100002 - Workflow Master  
WF100003 - Workflow Step Table

WF30100 - Workflow History  
WF40200 - Workflow Users  
WF40201 - Workflow Roles  
WF40202 - Workflow Template Fields  
WF40300 - Workflow Calendar  
WF40310 - Workflow Calendar Down Days  
WF40400 - Workflow Email Notifications  
WF40500 - Workflow User Delegation Master  
WF40510 - Workflow User Delegation Line

WFI10002 - Workflow Instance Master  
WFI10003 - Workflow Step Instance Table  
WFI10004 - Workflow Tasks Table  
WFI10005 - Workflow Step Instance Users

## More information

Below lists each table, what information it holds, and what information is written to the tables along the workflow process.

By default, using Microsoft Dynamics GP 2015 R2 as an example, before Workflow 2.0 is set up at all, only these tables will have any records in them: By default, using Microsoft Dynamics GP 2015 R2 as an example, before Workflow 2.0 is set up at all, only these tables will have any records in them:

--WF100001 = One record for each of the 15 possible types of Workflow that are available. (This could be different depending on what features and version of Microsoft Dynamics GP you are on.)

--WF40201 = Each of the 3 to 5 roles that are available for each of the 15 Workflow types that are available, including Workflow originator, Workflow Approver, Alternate final approver, Requested by, and other roles specific to the workflow types, such as Employee.

--WF40202 = Each field that is available for each of the Workflow email notifications that are available for the 15 different types of workflows.

After setting up SMTP email information and Web Services information in the Workflow Setup window, the following tables get populated:

--WF00100 = A record is written to include the Web Services and SMTP email setup information from the Workflow Setup window.

After saving a new workflow, for example, the Purchase Order Approval workflow, with a name and description:

--WF00104 = 1 record holding the Purchase Order Approval workflow name and user account that saved the changes, such as `sa`.

--WF100002 = 1 record holding the Purchase Order Approval workflow name and setup information such as whether it's active or not. Settings are specified as either 0 (not setup) or 1 (setup).

--WF40300 = One record for each of the seven weekdays, indicating whether they're a work day or not, as set up in the Workflow Calendar by default.

After setting up and saving a new workflow step for the Purchase Order Approval workflow:

--WF100003 = One record with the workflow step's name, description, approver GUID for whom the step is assigning to for approval and other setup information.

--WF40200 = One record for the approver's GUID, name, display name, alias, domain, login, and other information related to this Active Directory approver account.

After adding a manager to the Purchase Order Approval workflow type and saving changes:

--WF40200 = Another record gets added with the manager's GUID, name, display name, alias, domain, login, and other information for this Active Directory manager account.

After activating the Purchase Order Approval workflow type and saving changes:

--WF100002 = record for the Purchase Order Approval workflow type gets updated to show the workflow is active for this company database.

After submitting a purchase order for approval through Workflow 2.0 and verifying, the PO shows as pending approval from the approver we setup:

--WF30100 = One record is created for the PO being submitted for approval (Workflow_Action = 1), who submitted the PO, the name of the workflow and the step, as well as due date the approver has to approve by.

--WFI10002 =One record is created for the workflow, the purchase order number submitted for approval, Workflow_Status (4=Pending User Action), the originator of the PO, the corresponding table (POP10100 in this case) and Document Drill Down information.

--WFI10003 = One record with the name of the workflow and step again, the Workflow_Step_Status value (2 = Pending User Action) and the Workflow_Step_Assigned_To GUID, indicating the user from WF40200, that the PO was assigned to for approval.

--WFI10004 =This record also holds the workflow name and step name, as well as who the workflow task was assigned to, and the due date for when the approver has to approve it.

Lastly, I final approve the purchase order so it's *completed* and not pending any further approval information: Lastly, I final approve the purchase order so it's *completed* and not pending any further approval information:

--WF30100 = Another record gets written, this time with the Workflow_Action value of 10 (final approved) and the name of the approver in the Workflow_History_User column.

--WFI10002 = The one record gets updated to show a Workflow_Status of 6, meaning *Completed*.

--WFI10003 = The one record gets updated to have a Workflow_Step_Status = 4, meaning *Completed*.

The Workflow_Action values for the WF30100 table are:

1- Submit  
2- Resubmit  
3- Approve  
4- Task Complete  
5- Reject  
6- Delegate  
7- Recall  
8- Escalate  
9- Edit  
10- Final Approve

The Workflow_Status values for the WFI10002 table are:

1- Not Submitted  
2- Submitted (Deprecated)  
3- No Action Needed  
4- Pending User Action  
5- Recalled  
6- Completed  
7- Rejected  
8- Workflow Ended (Depricated)  
9- Not Activated  
10- Deactivated (Depricated)

The Workflow_Step_Status values for the WFI10003 table are:

1- No Action Needed  
2- Pending User Action  
3- Rejected  
4- Completed  
5- Recalled  
6- Failed

As you can see, all of the information for Workflow 2.0 is available, it's just found in multiple tables that you would need to link together to create, for example, a SQL View, that could then be used in a custom report pulling this type of information.

For example, here's a quick example script that will give the workflow name, who the task is assigned to, the workflow step and workflow status, and the workflow originator. Using this example, you could potentially filter it to pull in the specific information you want for a customer report:

```sql
SELECT a.Workflow_Name, a.WorkflowInstanceID, a.WorkflowTaskAssignedTo, b.Workflow_Step_Status, 
b.Workflow_Step_Assign_To, c.Workflow_Status, c.Workflow_Originator
FROM <companydb>.dbo.WFI10004 a
JOIN
<companydb>.dbo.WFI10003 b
ON a.WorkflowInstanceID=b.WorkflowInstanceID
JOIN
<companydb>.dbo.WFI10002 c
ON a.WorkflowInstanceID=c.WorkflowInstanceID
```
