---
title: Azure Cosmos DB Data Explorer fails to connect
description: Troubleshoot scenarios when the Azure Cosmos DB data explorer cannot connect to an account and perform specific data-plane or control-plane operations.
author: seesharprun
editor: v-jsitser
ms.author: sidandrews
ms.reviewer: ouryba, v-jayaramanp
ms.service: cosmos-db
ms.topic: troubleshooting-problem-resolution
ms.date: 01/18/2024
---

# Azure Cosmos DB Data Explorer fails to connect

There are occasional situations where the Azure Cosmos DB Data Explorer cannot connect to your account or perform operations against resources or items. This article reviews potential causes and solutions for this issue.

> [!IMPORTANT]
> The Azure Cosmos DB Data Explorer is not available for the API for PostgreSQL or the API for MongoDB vCore.

## Prerequisites

- An existing Azure Cosmos DB for NoSQL, MongoDB, Apache Cassandra, Apache Gremlin, or Table account.

## Symptoms

You are unable to connect to the Data Explorer even after enabling the **Allow access from Azure Portal** option.

## Cause

Even after configuring the right role-based access control and portal permissions, there are additional network access requirements that must be configured based on your selected API.

## Solution for the API for NoSQL

Review solutions for the **control** and **data plane** respectively.

### Solution for API for NoSQL control plane

Database and container operations are executed via calls to the Azure Resource Manager control plane using the Azure Cosmos DB resource provider. These operations are not impacted by the current user's network configuration.

### Solution for API for NoSQL data plane



## Solution for the API for MongoDB

Review solutions for the **control** and **data plane** respectively.

### Solution for API for MongoDB control plane

Database and collection operations are executed via calls to the Azure Resource Manager control plane using the Azure Cosmos DB resource provider. These operations are not impacted by the current user's network configuration.

### Solution for API for MongoDB data plane



## Solution for the API for Apache Cassandra

Review solutions for the **control** and **data plane** respectively.

### Solution for API for Apache Cassandra control plane

Keyspace operations are executed via calls to the Azure Resource Manager control plane using the Azure Cosmos DB resource provider. These operations are not impacted by the current user's network configuration.

Some table opprations are also executed using the same resource provider. These operations are also unaffected by the current user's network configuration. However, table creation operations are **NOT** executed using the resource provider and could potentially be impacted by the current user's network configuration. Please see the [next section](#solution-for-api-for-apache-cassandra-data-plane) for more details.

### Solution for API for Apache Cassandra data plane



## Solution for the API for Apache Gremlin

Review solutions for the **control** and **data plane** respectively.

### Solution for API for Apache Gremlin control plane

Database and graph operations are executed via calls to the Azure Resource Manager control plane using the Azure Cosmos DB resource provider. These operations are not impacted by the current user's network configuration.

### Solution for API for Apache Gremlin data plane



## Solution for the API for Table

Review solutions for the **data plane**.

### Solution for API for Table data plane


