---
title: Configure and troubleshoot the SubscriptionStreams parameter
description: This article describes how to configure and troubleshoot the SubscriptionStreams parameter of the Distribution Agent in SQL Server.
ms.date: 08/19/2020
ms.reviewer: ramakoni
ms.author: v-sidong
author: sevend2
ms.topic: article
ms.prod: sql
---

# How to configure and troubleshoot the SubscriptionStreams parameter of the Distribution Agent in SQL Server

_Original product version:_ &nbsp; SQL Server (all supported versions)  
_Original KB number:_ &nbsp; 953199

This article provides more information about this parameter, best practices when using this parameter, and associated troubleshooting.

## Introduction

The parameter `SubscriptionStreams` can be used to control the number of connections. In a transactional replication in Microsoft SQL Server, you can use the parameter to enable multiple connections that the Distribution Agent uses to apply batches of changes in parallel to a subscriber. This operation greatly enhances replication throughput. At the same time, the Distribution Agent can still maintain many of the same transactional characteristics as when the Distribution Agent uses a single connection to apply the changes. If one of the connections fails to execute or commit, all connections will abort the current batch, and the agent will use a single stream to retry the failed batches. Before this retry phase completes, there can be temporary transactional inconsistencies at the Subscriber. After the failed batches are successfully committed, the Subscriber is brought back to a state of transactional consistency.

When you specify a value of 2 or greater for the parameter `SubscriptionStreams`, the order in which transactions are received at the subscriber may differ from the order in which they were made at the publisher. If this behavior causes constraint violations during synchronization, you should use the `NOT FOR REPLICATION` option to disable the enforcement of constraints during synchronization. For more information, see [Control Behavior of Triggers and Constraints in Synchronization](/sql/relational-databases/replication/control-behavior-of-triggers-and-constraints-in-synchronization).

