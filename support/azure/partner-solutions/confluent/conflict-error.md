---
title: Conflict Error When Creating a Confluent Cloud Organization Resource
description: Resolve the Conflict error that can appear when you create a Confluent Cloud organization resource in Azure.
author:  praveenrajap
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/23/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to resolve the conflict error that I'm getting so that I can create a Confluent resource.

---

# Conflict error 

This article helps you resolve the Conflict error that appears when you try to create a new Confluent Cloud organization resource in Azure that uses an email address that was previously registered for Confluent Cloud.

## Prerequisites

- Access to the Azure portal and the Confluent integration page.
- An email address that hasn't been used to register a Confluent Cloud organization resource.

## Symptoms

You see a conflict error message when you try to create a new Confluent Cloud organization resource.

## Cause

If you previously registered for Confluent Cloud, you must use a different email address to create another Confluent Cloud organization resource. Using a previously registered email address triggers a conflict error.

## Solution: Register with a different email address

When you create the new Confluent Cloud organization resource, use an email address that hasn't been registered with Confluent Cloud.

## Related content

- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
 