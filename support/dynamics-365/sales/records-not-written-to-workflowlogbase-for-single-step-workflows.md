---
title: Records not written to Workflowlogbase for single-step workflows
description: Describes optimization changes in Update Rollup 1 for Microsoft Dynamics CRM 2011, after which records are not always written to the Workflowlogbase table for single-step workflows.
ms.reviewer: chanson
ms.topic: article
ms.date: 3/31/2021
---
# Records not written to Workflowlogbase for single-step workflows after Update Rollup 1 for Microsoft Dynamics CRM 2011 is installed

This article introduces an optimization update in Update Rollup 1 for Microsoft Dynamics CRM 2011 to reduce database round trips and to save disk space. This optimization only applies to workflows that are created in the web application.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2526154

## Summary

When you have a single-step workflow that does not include Wait, Condition, or Stage steps and the Automatically delete completed workflow jobs (to save disk space) option is selected, records will not be written to the **Workflowlogbase** table.

## More information

After Update Rollup 1 for Microsoft Dynamics CRM 2011 is installed, any workflows that are triggered and that get evaluated as a single-step workflow that does not include Wait, Condition, or Stage steps will not log any information to the **Workflowlogbase** table. If you have existing single-step workflows that are currently in a Wait state when Update Rollup 1 is installed, those workflows will still write to the **Workflowlogbase** table.

Because of this change, a red **X** will no longer appear next to a step that failed in your single-step workflows.
