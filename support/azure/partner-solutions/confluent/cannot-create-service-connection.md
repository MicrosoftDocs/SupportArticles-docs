---
title: Can't Create a Service Connection by Using Service Connector
description: Troubleshoot problems with creating a service connection for Confluent Cloud by using Service Connector in Azure.
author:  praveenrajap
ms.author: jarrettr  
ms.reviewer: v-ryanberg
ms.custom: sap:Confluent on Azure
ms.service: partner-services 
ms.topic: troubleshooting-general
ms.date: 09/24/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to resolve problems with creating a service connection by using Service Connector. 
---

# Can't create a service connection by using Service Connector

## Summary

This article helps you troubleshoot issues with creating a service connection for Confluent Cloud by using Service Connector in Azure.

## Prerequisites

- Access to the Azure portal.

## Symptoms

- Unable to create a service connection for Confluent Cloud by using Service Connector.

## Causes

- The Confluent organization is inactive or not running.
- The Confluent Marketplace resource is inactive or in an unsubscribed status.
- Schema-based data types (like Avro) are used, but the schema registry isn't configured.

## Solution 1: Ensure that the Confluent organization is active

- Verify that your Confluent organization is active and running.

## Solution 2: Check the Confluent Marketplace resource status

- If you used the Confluent Marketplace resource, confirm that your Azure Native Integrations Confluent organization is active and not in an unsubscribed status.

## Solution 3: Configure schema registry for schema-based data types

- If you use schema-based data types (for example, Avro), make sure that you configured the schema registry.

## Resources

- [Service Connector documentation](/azure/service-connector/overview)
- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)


 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
