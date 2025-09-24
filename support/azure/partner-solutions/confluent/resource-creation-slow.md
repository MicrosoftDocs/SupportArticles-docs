---
title: Troubleshoot Slow or Failed Confluent Cloud Resource Creation in Azure
description: Troubleshoot slow or failed resource creation for Confluent Cloud in Azure.
author:  
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/24/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to troubleshoot problems with slow or failed Confluent Cloud resource creation.

---

# Resource creation is slow or fails 

This article helps you troubleshoot problems in which Confluent Cloud resource creation in Azure takes a long time or fails.

## Prerequisites

- Access to the Azure portal and the subscription in which you're deploying the resource.
- Permissions to view resource status and, as needed, to delete resources. 

## Problems and solutions

### Problem: Deployment is slow or stuck

- If deployment doesn't complete after three hours, contact [Confluent support](https://support.confluent.io).

### Problem: Deployment fails

1. If deployment fails and the Confluent Cloud resource has a status of **Failed**, delete the resource. 
1. Try again to create the resource. 

 