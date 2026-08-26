---
title: Worker Process requested recycle due to Percent Memory limit message
description: Learn how to resolve the Worker Process requested recycle due to 'Percent Memory' limit message in Azure App Service by switching to a 64-bit process. 
author: kaushika-msft
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 12/16/2025
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# Worker Process requested recycle due to 'Percent Memory' limit message

## Summary

This article explains why Azure App Service displays the **Worker Process requested recycle due to 'Percent Memory' limit** message. 

## Symptom

You see the message **Worker Process requested recycle due to 'Percent Memory' limit**.

## Cause

The maximum available amount of memory for a 32-bit process (even on a 64-bit operating system) is 2 GB. By default, the worker process is set to 32-bit in App Service (for compatibility with legacy web apps).

## Resolution

Consider switching to 64-bit processes so you can take advantage of the extra memory available in your Web Worker role. This action triggers a web app restart, so schedule it accordingly.

Also, note that a 64-bit environment requires a Basic or Standard service plan. Free and Shared plans always run in a 32-bit environment.

For more information, see [Configure web apps in App Service](/azure/app-service/configure-common).