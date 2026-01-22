---
title: Web Request Times Out In App Service
description: This article provides guidance on addressing when a web request times out after 230 seconds in Azure App Service. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/16/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# Web request times out in App Service

## Summary

This article provides guidance on addressing when a web request times out after 230 seconds in Azure App Service. 

## Symptom

A web request times out after 230 seconds (about four minutes).

## Cause

Azure Load Balancer has a default idle timeout setting of four minutes. This setting is generally a reasonable response time limit for a web request. Therefore, App Service returns a timeout to the client if your application doesn't return a response within approximately 240 seconds (230 seconds on Windows app, 240 seconds on Linux app).

## Resolution

If your web app requires background processing, we recommend using Azure WebJobs. The Azure web app can call WebJobs and be notified when background processing is finished. You can choose from multiple methods for using WebJobs, including queues and triggers.

WebJobs is designed for background processing. You can do as much background processing as you want in a WebJob. For more information about WebJobs, see [Run background tasks with WebJobs](/azure/app-service/webjobs-create).

