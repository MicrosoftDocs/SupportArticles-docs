---
title: Resolved or Canceled Cases Reopen Unexpectedly
description: Resolved or canceled cases reopen unexpectedly in Dynamics 365 Customer Service. Use audit history to find and correct the automation that reactivates them.
ms.reviewer: mgandham, nenellim
ai-usage: ai-assisted
ms.date: 09/08/2026
ms.custom: sap:Incident (Case) table, DFM
---
# Resolved or canceled cases reopen unexpectedly

## Summary

Resolved or canceled cases reopen unexpectedly in Dynamics 365 Customer Service when a rule, a cloud flow, or a case merge changes the case status reason. This article shows how to use the case audit history to identify and correct the configuration or automation that caused the reactivation.

## Symptoms

- A resolved case reopens shortly after an inbound email is received.
- Multiple cases reactivate at the same time.
- A canceled case reopens.
- A child case reopens after a case merge.
- In the case audit history, **Modified By** identifies an application user instead of a person.

## Cause

This issue occurs when a configuration or automation reactivates the case. The following table lists the likely causes and where to investigate them.

| Symptom | Likely cause | Where to check |
| --- | --- | --- |
| A case reopens shortly after an inbound email is received. | An automatic record creation and update rule includes a condition that reopens the case. | In **Customer Service admin center**, review the email-to-case rule under **Case Settings** > **Automatic Record Creation and Update Rules**. |
| Multiple cases reactivate at the same time. | A Power Automate cloud flow includes an action that updates the state of the **Case** table. | In Power Automate, review the flow run history at the time the cases reactivated. |
| **Modified By** identifies an application user instead of a person. | An automatic record creation and update rule, a Power Automate cloud flow, or a service-level agreement (SLA) action reactivated the case. | Review the case audit history. |
| A canceled case reopens. | A status reason transition allows a transition from **Canceled** to **Active**, or a Power Automate cloud flow reactivates the case. | Review the [case status reason transitions](/dynamics365/customer-service/administer/define-status-reason-transitions-case-management) and cloud flows. |
| A child case reopens after a case merge. | The case merge reactivated the child case. | Review the case audit history entries created around the time of the merge. |

## Solution

Use the case audit history to identify the configuration or automation that reactivated the case:

1. Open the affected case, and then select **Related** > **Audit History**.
1. Find the entry where **Status Reason** changed to a value that represents an active state.
1. Note the values of **Modified By** and **Modified On**.
1. Use the **Modified On** value to correlate the change with an automatic record creation and update rule evaluation, a Power Automate cloud flow run, an SLA action, or a case merge.
1. Disable the responsible automation or add a condition that verifies the case status before the automation updates the case. Ensure that the automation reactivates cases only when intended.

> [!NOTE]
> If you want to reopen cases when an inbound email is received, don't disable the rule. Configure the rule so that the reopen condition is evaluated before the rule that creates a new case. For more information, see [Reopen a resolved case in Dynamics 365 Customer Service](/dynamics365/customer-service/administer/reopen-resolved-case).

## Related content

[Case resolution dialog fields are missing in production environment](case-resolution-dialog-fields-missing-production.md)
