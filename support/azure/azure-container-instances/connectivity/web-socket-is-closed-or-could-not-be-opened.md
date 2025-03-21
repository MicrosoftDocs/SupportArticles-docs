---
title: Error - Web socket is closed or could not be opened
description: Learn how to resolve the (Web socket is closed or could not be opened) error. This error prevents you from connecting to your container from a virtual network.
ms.date: 02/24/2025
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: albarqaw, v-weizhu, v-leedennis
ms.service: azure-container-instances
ms.custom: sap:Connectivity
#Customer intent: As an Azure administrator, I want to learn how to resolve the "Web socket is closed or could not be opened" error so that I can successfully deploy an image onto a container instance.
---
# Error: "Web socket is closed or could not be opened"

This article discusses how to resolve the "Web socket is closed or could not be opened" error message that prevents Microsoft Azure Container Instances from connecting to a virtual network.

## Symptoms

When you try to connect to your container from the Azure portal, you receive the following error message:

> The following web socket error occurred: error: Web socket is closed or could not be opened. Please validate your network connection and retry the attempt.

## Cause

Your firewall or corporate proxy blocks access to port 19390. This port is required to connect to Container Instances from the Azure portal when container groups are deployed in virtual networks.

## Solution

To resolve this error, allow ingress to TCP port 19390 in your firewall. At a minimum, make sure that your firewall gives access to that port for all public client IP addresses that the Azure portal has to connect to.

In some scenarios where the corporate proxy blocks port 19390, allow this port for corporate proxy, and then verify the traffic by using the **Network** tab in the browser developer tools.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
