---
title: Can't delete Confluent Cloud resource in Azure
description: "Resolve issues deleting a Confluent Cloud resource in Azure, including permission and retention policy problems."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/24/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Can't delete Confluent Cloud resource in Azure

This article helps you resolve issues deleting a Confluent Cloud resource in Azure, including permission problems and retention policy restrictions.

## Prerequisites

- Access to the Azure portal and the subscription containing the Confluent Cloud resource.
- Permissions to view and manage role assignments.

## Symptoms

- You can't delete a Confluent Cloud resource in the Azure portal.
- The delete action is unavailable or fails with a permissions error.

## Cause

- You must have permission to take `Microsoft.Confluent/*/Delete` actions on the resource. Insufficient permissions prevent deletion.
- If you have the correct permissions but still can't delete the resource, the issue may be related to the Confluent retention policy.

## Solution 1: Verify and assign delete permissions

1. In the Azure portal, go to the resource and select **Access control (IAM)**.
2. View your role assignments and confirm you have a role that allows `Microsoft.Confluent/*/Delete` actions.
3. For information about viewing permissions, see [List Azure role assignments by using the Azure portal](../../role-based-control/role-assignments-list-portal.yml).
4. If you lack permissions, contact your Azure subscription administrator to assign the necessary role.

## Solution 2: Escalate to Confluent support for retention policy issues

1. If you have the correct permissions but still can't delete the resource, contact [Confluent support](https://support.confluent.io).
2. Provide details about the resource, your permissions, and the error message.
3. Confluent support can delete the organization and email address for you if the issue is related to retention policy.

## Verify

- After permissions are assigned, confirm you can delete the resource in the Azure portal.
- If support intervenes, verify the resource and associated organization/email are deleted as requested.

## Related content

- [List Azure role assignments by using the Azure portal](../../role-based-access-control/role-assignments-list-portal.yml)
- [Confluent support](https://support.confluent.io)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)