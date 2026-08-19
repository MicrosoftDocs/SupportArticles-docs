---
title: Purchase Requisition Submit, Workflow, or Approval Unavailable
description: Learn why purchase requisition Submit, Workflow, or approval actions are unavailable for a user. Follow these steps to check state, security, and workflow processing.
ms.date: 08/11/2026
ms.search.form: PurchReqTable
ms.reviewer: kamaybac, sugaur
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase requisitions
ai-usage: ai-assisted
---

# Purchase requisition Submit, Workflow, or approval actions are unavailable

## Summary

This article helps you diagnose why purchase requisition **Submit**, **Workflow**, or approval actions are unavailable for a specific user in Microsoft Dynamics 365 Supply Chain Management. It covers draft requisition eligibility, workflow state and work item assignment, user security, and the **Workflow message processing** batch job.

## Symptoms

One or more of the following symptoms occur for a specific user:

- The **Workflow** or **Submit** button is disabled for a draft purchase requisition.
- Approval actions don't appear after a purchase requisition is submitted.

Other users in the same legal entity can complete the same action.

## Solution

First, verify the document context:

- For **Submit** or **Workflow**, open a draft requisition and verify that it meets the configured workflow's submission conditions.
- For approval actions, verify that the requisition was submitted, the workflow work item is assigned to the affected user or queue, and the requisition is in the expected workflow state.

If **Submit** is unavailable before submission, don't use workflow batch processing as a remedy. Verify the draft document's state, required data, workflow activation, submission conditions, and the user's intended access. Compare the user's assigned duties and privileges with a working user only when both users should have equivalent responsibilities. Preserve least-privilege access; don't assign a broad role as a troubleshooting shortcut. Contact Microsoft Support if those conditions are met but the action remains unavailable.

If the requisition was submitted but workflow processing isn't advancing:

1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Search for **Workflow message processing**.
1. Verify that the batch job exists and is in a runnable state.
1. Review its batch history and resolve any workflow-message processing errors.

The **Workflow message processing** batch job progresses workflow messages after submission. It doesn't determine whether a draft requisition is eligible for submission. After processing resumes, verify that the workflow reaches the expected state and that the action appears for the assigned user. Due-date processing controls time-based workflow processing; don't use it as a fix for a missing **Submit** action unless a due-date condition is the identified problem.

For more information about the workflow batch job, see [Configure the Workflow message processing batch job as critical](/dynamics365/fin-ops-core/dev-itpro/organization-administration/workflow-batch-job-critical). Contact Microsoft Support if the document state, work-item assignment, security, and workflow processing are all correct but the action remains unavailable.
