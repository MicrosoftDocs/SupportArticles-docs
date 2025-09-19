---
title: Datadog metrics not emitted from Azure resources
description: "Resolve the issue when Datadog does not receive metrics from Azure resources due to missing or incorrect role assignment."
author: v-albemi
ms.author: v-albemi
ms.service: Datadog integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/19/2025

#customer intent: As a <role>, I want <what> so that <why>.

---

This article helps you resolve the specific problem where Datadog is not receiving metrics from Azure resources because the Datadog resource identity does not have the required Monitoring Reader role assignment.

Use this article when Datadog metrics for one or more Azure resources are missing and you see no Azure role assignment for the Datadog resource.

## Prerequisites

- Access to the Azure portal with permissions to view Access control (IAM) for the target subscription (Reader) and to assign roles (Contributor/Owner) if you will remediate.
- The Datadog resource identity (managed identity or service principal) name or principal ID.

## Symptoms

- Metrics from Azure resources do not appear in the Datadog UI.
- The Datadog resource does not appear with a Monitoring Reader role assignment in the subscription's Access control (IAM) list.

## Cause

Datadog requires the Monitoring Reader role on the appropriate Azure subscription (or scope) to collect platform metrics. If the Datadog resource identity is not assigned this role at the correct scope (subscription or resource group), Datadog cannot read metrics and they won't be emitted to Datadog.

## Solution 1: Verify role assignment and assign Monitoring Reader

1. In the Azure portal, open the subscription that contains the resources.

2. Select Access control (IAM) from the left pane.

3. In the Role assignments tab, search for the Datadog resource name or principal ID.

4. If you do not find a Monitoring Reader assignment for the Datadog identity at the subscription scope, follow these steps to add one:

   1. Select + Add > Add role assignment.

   2. In Role, choose Monitoring Reader.

   3. In Assign access to, choose Managed identity or Service principal as appropriate.

   4. Select the Datadog resource identity and complete the assignment.

5. Wait a few minutes for RBAC propagation, then verify metrics are received in Datadog.

## Solution 2: Verify role scope and identity type (CLI/PowerShell)

If you prefer or cannot use the portal, verify the assignment using CLI or PowerShell.

- Azure CLI example (checks role assignments for a principal at subscription scope):

  az role assignment list --assignee {principal-id} --role "Monitoring Reader" --scope "/subscriptions/{subscription-id}" --output table

- PowerShell example (Az module):

  Get-AzRoleAssignment -ObjectId {principal-id} -RoleDefinitionName "Monitoring Reader" -Scope "/subscriptions/{subscription-id}"

If the assignment is missing at the subscription level, create it with Azure CLI:

  az role assignment create --assignee {principal-id} --role "Monitoring Reader" --scope "/subscriptions/{subscription-id}"

Or with PowerShell:

  New-AzRoleAssignment -ObjectId {principal-id} -RoleDefinitionName "Monitoring Reader" -Scope "/subscriptions/{subscription-id}"

Notes:

- Ensure you assign the role at the proper scope: Datadog typically needs subscription-level access for metrics collection across resources. Assigning at a resource group or resource scope limits access to that scope only.

- Confirm the Datadog identity is the one used by the Datadog integration (managed identity vs service principal). If you assign the role to the wrong principal, Datadog will still not receive metrics.

## Determine the cause if role assignment is present

If the Monitoring Reader role is already assigned and metrics are still not emitted, check the following:

- RBAC propagation delay: allow 5–15 minutes after assignment and re-check.

- Disabled or deleted principal: verify the managed identity or service principal is enabled.

- Datadog integration configuration: confirm the integration is configured to use the correct Azure subscription and principal.

- Azure Monitor metric availability: confirm the resource emits metrics to Azure Monitor (some resource types or SKU levels may not emit all metrics).

- Network or service issues in Datadog: check Datadog status and logs for ingestion errors.

## Verify

- In Datadog, open Metrics Explorer or the relevant dashboard and confirm recently emitted metrics appear for the affected resources.

- In the Azure portal, confirm the Datadog identity appears with the Monitoring Reader role assignment at the expected scope.

- Use CLI to list role assignments again and confirm the Monitoring Reader role is present for the Datadog principal.

## Related content

- [Azure role-based access control (RBAC)](https://learn.microsoft.com/azure/role-based-access-control/)
- [Assign Azure roles using the Azure CLI](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-cli)
- [Datadog Azure integration documentation](https://docs.datadoghq.com/integrations/azure/)