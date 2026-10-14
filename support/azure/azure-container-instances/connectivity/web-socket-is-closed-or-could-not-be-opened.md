---
title: Troubleshoot Web socket is closed or couldnt be opened error in Azure Container Instances
description: Fix the "Web socket is closed or couldn't be opened" error in Azure Container Instances by allowing port 19390 to connect to containers in a virtual network.
ms.date: 10/05/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: albarqaw, v-weizhu, v-leedennis, kennethgp, kaushika
ms.service: azure-container-instances
ms.custom: sap:Connectivity
ai-usage: ai-assisted
#Customer intent: As an Azure administrator, I want to learn how to resolve the "Web socket is closed or couldn't be opened" error so that I can successfully deploy an image onto a container instance.
---
# Troubleshoot "Web socket is closed or couldn't be opened" error in Azure Container Instances

## Summary

This article explains how to mitigate the "Web socket is closed or couldn't be opened" error in Azure Container Instances (ACI). This error occurs when connecting to containers in a virtual network.

## Symptoms

When you try to connect to your container from the [Azure portal](https://portal.azure.com), you receive the following error message.

> The following web socket error occurred: error: Web socket is closed or couldn't be opened. Please validate your network connection and retry the attempt.

## Cause

Your firewall or corporate proxy blocks access to port 19390. This port is required to connect to ACI from the Azure portal when container groups are deployed in virtual networks.

## Solution

To resolve this error, allow ingress to TCP port 19390 in your firewall. At a minimum, ensure that your firewall gives access to that port for all public client IP addresses that the Azure portal uses to connect.

In some scenarios where the corporate proxy blocks port 19390, allow this port for the corporate proxy, and then verify the traffic by using the **Network** tab in the browser developer tools.

For more information on reserved ports, see [Does the ACI service reserve ports for service functionality?](/azure/container-instances/container-instances-faq#does-the-aci-service-reserve-ports-for-service-functionality-).
