---
title: Metrics checkbox disabled when enabling metrics collection for Dynatrace
description: "Resolve the issue where the metrics collection checkbox is disabled because the user lacks Owner permissions on the subscription."
author: v-albemi
ms.author: v-albemi
ms.service: Dynatrace integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/22/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Metrics checkbox disabled when enabling metrics collection

This article helps you resolve the specific problem where the metrics collection checkbox is disabled (greyed out) in the Dynatrace integration because the signed-in account doesn't have Owner permissions on the Azure subscription.

Use this article when you cannot enable metrics collection in the Dynatrace integration and the UI control is disabled.

## Prerequisites

- Access to the Azure portal and the subscription that contains the resources.
- The account name or principal ID of the user attempting the operation.
- Permissions to request role changes from a subscription Owner or to assign roles if you have the appropriate rights.

## Symptoms

- The metrics collection checkbox is disabled (greyed out) in the Dynatrace integration UI.
- Attempting to enable metrics collection results in an error or no action.

## Cause

Enabling metrics collection requires Owner permissions at the subscription scope. Users with Contributor or Reader roles cannot enable metrics collection from the integration UI; the checkbox remains disabled.

## Solution 1: Verify your role and request Owner permission

1. In the Azure portal, open the subscription that contains the resources.
2. Select Access control (IAM) from the left pane.
3. Select View my access to see your effective role at the subscription scope.
4. If you are not Owner, contact the subscription Owner or administrator and request Owner permissions, or ask them to enable metrics collection for you.
5. After the Owner assigns the role, wait 5–15 minutes for RBAC propagation and then retry enabling metrics collection in the Dynatrace integration.

## Solution 2: Verify role using CLI or PowerShell

- Azure CLI example (shows role assignments for the signed-in principal at subscription scope):

  az role assignment list --assignee {principal-id} --scope "/subscriptions/{subscription-id}" --output table

- PowerShell example (Az module):

  Get-AzRoleAssignment -ObjectId {principal-id} -Scope "/subscriptions/{subscription-id}"

If the assignment is missing or you have a Contributor role, request the Owner role or have an existing Owner perform the action.

## Determine the cause if you have Owner permissions

If you already have Owner permissions and the checkbox is still disabled, check the following:

- Sign-in context: confirm you're signed in with the correct account; sign out and sign in again.
- Portal caching: try an incognito/private browser session or clear the browser cache.
- Extension or integration scope: verify the integration is targeting the correct subscription and that any required resource provider registrations exist.

## Verify

- After Owner role is assigned and RBAC propagates, the metrics collection checkbox should become enabled.
- Enable the checkbox and confirm metrics appear in Dynatrace for the selected resources within expected ingestion time.

## Related content

- [Azure role-based access control (RBAC)](https://learn.microsoft.com/azure/role-based-access-control/)
- [Assign Azure roles using the Azure CLI](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-cli)
- [Configure metrics and logs](https://learn.microsoft.com/azure/monitoring/monitoring-configure-metrics-logs)