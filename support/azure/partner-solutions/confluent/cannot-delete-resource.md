---
title: Can't Delete a Confluent Cloud Resource in Azure
description: Resolve problems with deleting a Confluent Cloud resource in Azure, including permission and retention policy problems.
author:  
ms.author: jarrettr
ms.service: partner-services 
ms.topic: troubleshooting-problem-resolution
ms.date: 09/24/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to resolve a problem with deleting a Confluent Cloud resource. 

---

# Can't delete a resource

This article helps you resolve problems with deleting a Confluent Cloud resource in Azure, including permission problems and retention policy restrictions.

## Prerequisites

- Access to the Azure portal and the subscription containing the Confluent Cloud resource.
- Permissions to view role assignments.

## Symptoms

- You can't delete a Confluent Cloud resource in the Azure portal.
- The delete action is unavailable or fails with a permissions error.

## Cause

- You must have permission to take `Microsoft.Confluent/*/Delete` actions on the resource. 
- If you have the correct permissions but still can't delete the resource, the problem might be related to the Confluent retention policy.

## Solution 1: Verify or obtain delete permissions

1. In the Azure portal, go to the resource and select **Access control (IAM)**.
1. View your role assignments. Confirm that you have a role that allows `Microsoft.Confluent/*/Delete` actions. For information about viewing permissions, see [List Azure role assignments by using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal).
1. If you don't have the correct permissions, contact your Azure subscription administrator to assign the necessary role.

## Solution 2: Escalate to Confluent support for retention policy problems

If you have the correct permissions but still can't delete the resource, contact [Confluent support](https://support.confluent.io). This problem might be related to the Confluent retention policy. Confluent support can delete the organization and email address for you.

