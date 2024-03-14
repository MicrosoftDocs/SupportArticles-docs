---
title: Reminder emails for Workflow new feature
description: Introduces the reminder emails for Workflow this new feature to Microsoft Dynamics GP 2018.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Reminder emails for Workflow - new feature to Microsoft Dynamics GP 2018

This article introduces the new feature **Reminder emails for Workflow** in Microsoft Dynamics GP 2018.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4078040

## Symptoms

Reminder emails for Workflow are now available in Microsoft Dynamics GP 2018.

Refer to the full [BLOG](https://support.microsoft.com/topic/reminder-emails-for-workflow-new-feature-to-microsoft-dynamics-gp-2018-c44be89a-8ab6-4109-3c1b-9a85db2e7cb6) article.

## More information

In Microsoft Dynamics GP 2018, workflow reminder emails can now be sent to users who have a workflow transaction pending their approval.

A new Option for Reminders will be available under each Workflow Step in the Workflow Maintenance window. (See Screen print in blog link above.)

> Reminder:     X     Y

where enter the Amount for X such as **1** and Y is a selection from the drop-down list such as **Hours**, in which the user would then get a reminder email 1 hour before the assigned task is due.

> [!NOTE]
> This feature is dependent on the SQL Job _Scan for Workflow Tasks For All Companies (DYNAMICS) to send reminder_ which runs once every 15 minutes to send reminder emails.  If you are not receiving reminder emails, you will want to make sure that your SQL Server Agent is started.

### Table changes

New columns were added to the Workflow Step (WF100003), Workflow Step Instance (WFI10003), and Workflow Task (WFI10004) will have a new column Workflow Status that will update according to the current workflow status on the transaction.

|Table Physical Name|Table Technical Name|New Field|
|---|---|---|
|WF100003|Workflow_Step|WFStepReminderTimeLimit|
|WF100003|Workflow_Step|WFStepRemTImeLimitUofM|
|WFI10003|Workflow_Step_Instance|WFStepReminderTimeLimit|
|WFI10003|Workflow_Step_Instance|WFStepRemTimeLimitUofM|
|WFI10004|Workflow_Task|WFReminderDueDate|
|WFI10004|Workflow_Task|WFReminderDueTime|
|WFI10004|Workflow_Task|WorkflowReminderSent|
