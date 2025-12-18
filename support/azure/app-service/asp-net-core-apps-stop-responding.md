---
title: ASP.NET Core applications hosted in App Service stop responding
description: This article provides guidance on addressing ASP.NET Core applications that are hosted in Azure App Service when they stop responding. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/18/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---

# ASP.NET Core applications hosted in App Service stop responding

This article provides guidance on addressing ASP.NET Core applications that are hosted in Azure App Service when they stop responding. 

## Symptom

ASP.NET Core applications that are hosted in App Service sometimes stop responding. How do I fix this issue?

## Cause

A known issue with an earlier [Kestrel version](https://github.com/aspnet/KestrelHttpServer/issues/1182) might cause an ASP.NET Core 1.0 app that's hosted in App Service to intermittently stop responding. You might also see this message: "The specified CGI Application encountered an error and the server terminated the process."

## Resolution

This issue is fixed in Kestrel version 1.0.2. This version is included in the ASP.NET Core 1.0.3 update. To resolve this issue, make sure you update your app dependencies to use Kestrel 1.0.2. Alternatively, you can use one of two workarounds that are described in the blog post [ASP.NET Core 1.0 slow perf issues in App Service web apps](/archive/blogs/waws/asp-net-core-slow-perf-issues-on-azure-websites).

