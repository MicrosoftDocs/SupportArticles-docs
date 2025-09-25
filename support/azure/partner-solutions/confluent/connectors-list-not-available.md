---
title: List of connectors that use Confluent connectors isn't available
description: "Troubleshoot missing connector list for Confluent connectors in Azure."
author: v-albemi
ms.author: jarrettr 
ms.service: partner-services 
ms.topic: troubleshooting-general
ms.date: 09/25/2025

---
# Confluent connector isn't in the list of connectors

This article helps you troubleshoot issues when the list of connectors that use Confluent connectors isn't available in Azure.

## Prerequisites

- Access to the Azure portal.
- Permissions to view and manage resources in your Azure subscription.

## Symptoms

- The list of Confluent connectors isn't visible in the Azure portal.
- You can't see available connectors for integration.

## Causes

- You aren't assigned the Owner or Contributor role for the Azure subscription.
- Insufficient permissions to view connector resources.

## Solutions

### 1. Check your Azure subscription role

- Ensure you're assigned the Owner or Contributor role for the Azure subscription.
- If you aren't, contact your Azure subscription administrator to update your role assignments.

## Verify

- After updating your role, refresh the Azure portal and check if the list of Confluent connectors is available.

## Related content

- [Azure role-based access control (RBAC)](https://learn.microsoft.com/azure/role-based-access-control/overview)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
