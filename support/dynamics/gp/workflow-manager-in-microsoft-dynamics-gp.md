---
title: Workflow Manager in Microsoft Dynamics GP
description: Introduces Workflow Manager do in Microsoft Dynamics GP.
ms.reviewer: 
ms.date: 03/13/2024
---
# Workflow Manager in Microsoft Dynamics GP

This article introduces the Workflow Manager in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4053565

The **Workflow Manager** for all workflow types will function the same. Being the workflow manager primarily makes your user the failsafe approver for when a workflow doesn't meet any conditions and is required t o be assigned to someone. There is a brief explanation in the GP 2013 R2 new feature documentation for Workflow.

[New Workflow in Microsoft Dynamics GP 2013 R2](https://community.dynamics.com/blogs/post/?postid=fd778606-5dff-4cba-9c13-56febce618af)

Here is an expanded explanation of what the Workflow Manager is able to do:

1. The WF Manager can make **edits** to the workflow setup. If you are not WF manager and not a POWERUSER, then you cannot make edits to workflow setup as the modules will not appear to the user in Workflow Maintenance.

2. If an approval is required and it can't find the approver, or the alternate approver is the originator and not allowed to approve their own workflow, or no Alternate Final approver is selected, the Workflow Manager will be assigned the Approval task as a **last-option default approver**.

3. The Workflow Manager has the ability to approve any document **that they have security to pull up in GP** for that specific Workflow Type. Keep in mind that WF Manager users don't have access to other employee's Timecards, Timesheets, PO Reqs, and so on. by default. Being workflow manager does not give you access to these documents, it only gives the ability to approve documents that you already have security to access. There are separate setups within modules that dictate whether a user has access to certain documents or not.
