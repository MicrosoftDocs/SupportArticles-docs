---
title: Can't create a service connection by using Service Connector
description: "Troubleshoot issues creating a service connection for Confluent Cloud using Service Connector in Azure."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-general
ms.date: 09/24/2025

---

This article helps you troubleshoot issues when you can't create a service connection for Confluent Cloud using Service Connector in Azure.

## Prerequisites

- Access to the Azure portal and Confluent Cloud.
- Permissions to manage Confluent organizations and Service Connector resources.

## Symptoms

- Unable to create a service connection using Service Connector for Confluent Cloud.
- Error or failure when attempting to connect services.

## Causes

- The Confluent organization is inactive or not running.
- The Confluent Marketplace resource is unsubscribed or inactive.
- Schema-based data types (such as Avro) are used without configuring the schema registry.

## Solutions

### 1. Ensure Confluent organization is active

- Verify your Confluent organization is active and running in Confluent Cloud.

### 2. Check Marketplace resource status

- If you used the Confluent Marketplace resource, confirm that your Azure Native Integrations Confluent organization is active and not unsubscribed.

### 3. Configure schema registry for schema-based data types

- If you use schema-based data types (for example, Avro), ensure the schema registry is properly configured in Confluent Cloud.

## Verify

- After performing the steps above, attempt to create the service connection again using Service Connector.
- Confirm that the connection is established and services are linked as expected.

## Related content

- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)
- [Service Connector documentation](https://learn.microsoft.com/azure/service-connector/overview)