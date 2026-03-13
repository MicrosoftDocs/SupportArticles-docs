---
title: Troubleshoot Slow or Failed Confluent Cloud Resource Creation in Azure
description: Troubleshoot slow or failed resource creation for Confluent Cloud in Azure.
author:  praveenrajap
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.custom: sap:Confluent on Azure
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/24/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to troubleshoot problems with slow or failed Confluent Cloud resource creation.

---

# Resource creation is slow or fails 

This article helps you troubleshoot problems where Confluent Cloud resource creation in Azure takes a long time or fails.

## Prerequisites

- Access to the [Azure portal](https://portal.azure.com) and the subscription where you're deploying the resource.
- Permissions to view resource status and, as needed, to delete resources. 

## Problems and solutions

### Problem: Deployment is slow or stuck

- If deployment doesn't complete after three hours, contact [Confluent support](https://support.confluent.io).

### Problem: Deployment fails

1. If deployment fails and the Confluent Cloud resource has a status of **Failed**, delete the resource. 
1. Try again to create the resource. 

## Resources

- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
 
 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)] 
 