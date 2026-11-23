---
title: Azure container group intermittently restarts in Azure Container Instances
description: Learn how to fix an issue where an Azure container group is unexpectedly stopped and restarted due to killing event interruptions.
ms.date: 10/07/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tysonfreeman, v-weizhu, kennethgp, kaushika 
ms.service: azure-container-instances
ms.custom: sap:Management
ai-usage: ai-assisted
---

# Azure container group intermittently restarts due to killing event interruptions in Azure Container Instances

## Summary

This article provides a solution to an issue where an Azure container group unexpectedly stops and restarts due to killing event interruptions in Azure Container Instances (ACI).

## Symptoms

A container group intermittently restarts without clear causes. You also experience one or more of the following symptoms and receive exit code 7147, 7148, 1, or one of the following:

- A portal event message "Killing container with id \<ID>" is shown.
- Log Analytic events show the "Killing container with id \<ID>" message.
- The container group IP address changes.

## Cause

Container group killing events can happen due to platform maintenance (which is an expected behavior), load balancing, or user application errors.

## Solution

Exit codes 7147 and 7148 indicate that the container group stops due to platform maintenance, which is an expected behavior. For more information, see [Diagnose common code package errors by using Service Fabric - Azure Service Fabric](/azure/service-fabric/service-fabric-diagnostics-code-package-errors#how-can-i-tell-if-service-fabric-terminated-my-code-package).

Exit code 1 means that an error occurs in the user's application and the container group stops. To resolve this error, fix the application.
