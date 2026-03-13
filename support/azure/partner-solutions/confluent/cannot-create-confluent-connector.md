---
title: Can't create a Confluent connector
description: Resolve failures that occur when you try to create a Confluent connector in Azure.
author:  praveenrajap
ms.author: jarrettr 
ms.reviewer: v-ryanberg
ms.service: partner-services 
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Confluent on Azure
ms.date: 09/25/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to resolve a failure that's occuring when I try to create a Confluent connector. 
---

# Can't create a Confluent connector

This article helps you resolve failures that can occur when you try to create a Confluent connector in Azure.

## Prerequisites

- An Azure account with an active subscription [Create an account for free](https://azure.microsoft.com/free).
- An existing Confluent organization. If you don't have one, see [Create a Confluent organization](/azure/partner-solutions/apache-kafka-confluent-cloud/create).
- An app deployed to [Azure App Service](/azure/app-service/quickstart-dotnetcore), [Azure Container Apps](/azure/container-apps/quickstart-portal), [Azure Spring Apps](https://azure.microsoft.com/products/spring-apps/?msockid=16f3be2d0f1066e62759a8150e8867c4), or [Azure Kubernetes Service (AKS)](/azure/aks/learn/quick-kubernetes-deploy-portal).

## Symptoms

- Unable to create a Confluent connector in Azure.
- Error or failure when using the connector creation page.

## Causes

- You don't have the required permissions. 
- One or more required values on the connector creation page are incorrect.
- The Azure service you're trying to connect to isn't configured correctly.

## Solution 1: Verify permissions 

- Ensure that you have the required permissions to create Confluent connectors. You need to have an Owner or Contributor role in the Azure subscription and appropriate permissions on the Confluent Kafka cluster.  

## Solution 2: Check Azure service configuration

Verify that the Azure service you're trying to connect to is configured properly.

## Solution 3: Escalate to Confluent support

If the issue persists after you verify permissions and configuration, contact [Confluent support](https://support.confluent.io).

## Resources

- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
 
 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]