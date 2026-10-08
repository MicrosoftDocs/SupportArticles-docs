---
title: Azure Container Instance continues to run after the stop or delete commands are run
description: Learn how to fix an Azure Container Instance that continues to run and incur charges after you run the stop or delete command. Follow these steps to resolve it.
ms.date: 10/06/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tysonfreeman, v-weizhu, kennethgp, kaushika
ms.service: azure-container-instances
ms.custom: sap:Management
ai-usage: ai-assisted
---
# Azure Container Instance continues to run after you run the stop or delete commands

## Summary

This article provides a solution to an issue where an Azure Container Instance (ACI) continues to run even after you run the `stop` or `delete` commands.

## Symptoms

Despite executing the `stop` or `delete` command, an ACI continues to run and is still billed.

## Cause

This issue might occur due to stuck deactivations or errors in the underlying platform during stop or delete operations.

## Solution

Follow these possible mitigation steps:

1. Verify that you ran the `stop` or `delete` command.
1. Verify that the container instance is still billed.
1. Create a new container instance with the same resource ID in the same region. When you successfully create the new container instance, the old container instance should be removed immediately.
