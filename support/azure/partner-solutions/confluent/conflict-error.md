---
title: Conflict error when creating Confluent Cloud organization resource
description: "Resolve the Conflict error when creating a new Confluent Cloud organization resource in Azure."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/23/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Conflict error when creating Confluent Cloud organization resource

This article helps you resolve the Conflict error that appears when you try to create a new Confluent Cloud organization resource in Azure using an email address that was previously registered for Confluent Cloud.

## Prerequisites

- Access to the Azure portal and the Confluent integration blade.
- A new, unused email address for registering a Confluent Cloud organization resource.

## Symptoms

- You see a **Conflict** error message when attempting to create a new Confluent Cloud organization resource.
- The resource creation fails and you cannot proceed with the same email address.

## Cause

- If you previously registered for Confluent Cloud, you must use a different email address to create another Confluent Cloud organization resource. Using a previously registered email address triggers a Conflict error.

## Solution 1: Register with a different email address

1. When creating a new Confluent Cloud organization resource, use an email address that has not been registered with Confluent Cloud before.
2. Complete the registration process with the new email address.
3. If you need to use the same email address, contact [Confluent support](https://support.confluent.io) for assistance.

## Verify

- After registering with a new email address, confirm that the Confluent Cloud organization resource is created successfully in the Azure portal.
- If you contact support, verify receipt of resolution or further instructions.

## Related content

- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)