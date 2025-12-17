---
title: Worker Process requested recycle due to Percent Memory limit message
description: This article provides guidance on addressing the "Worker Process requested recycle due to 'Percent Memory' limit" message in Azure App Service. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/16/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# "Worker Process requested recycle due to 'Percent Memory' limit" message

This article provides guidance on addressing the "Worker Process requested recycle due to 'Percent Memory' limit" message in Azure App Service. 

## Symptom

You see the message "Worker Process requested recycle due to 'Percent Memory' limit."

## Cause

The maximum available amount of memory for a 32-bit process (even on a 64-bit operating system) is 2 GB. By default, the worker process is set to 32-bit in App Service (for compatibility with legacy web applications).

## Resolution

Consider switching to 64-bit processes so you can take advantage of the additional memory available in your Web Worker role. This action triggers a web app restart, so schedule accordingly.

Also note that a 64-bit environment requires a Basic or Standard service plan. Free and Shared plans always run in a 32-bit environment.

For more information, see [Configure web apps in App Service](/azure/app-service/configure-common).