---
title: TooManyRequests error in Power Automate
description: Cause and resolution for a TooManyRequests error. 
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice:
---

# TooManyRequests error in Power Automate

This article provides a solution when you receive a **TooManyRequests** error.

_Applies to:_ &nbsp; Microsoft Power Automate

## Symptoms

You get the error, **429 – TooManyRequests**.

## Cause

You've performed too many executions in a short timeframe on a model.

## Resolution

If this error occurs, decrease the concurrency level of your flow. For example, if your flow is triggered by the action **When a file is created in a folder** when using the SharePoint trigger, you can reduce the degree of parallelism in the action settings.

