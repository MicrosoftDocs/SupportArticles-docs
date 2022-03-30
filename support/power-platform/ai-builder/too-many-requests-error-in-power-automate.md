---
title: Too Many Requests error in Power Automate
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice:
---

# Too Many Requests error in Power Automate

This article provides a solution when receiving TooManyRequests error.

_Applies to:_ &nbsp; Power Automate


## Symptoms

error: 429 – TooManyRequests.

## Cause

You have performed too many executions in a short time frame on a given model.

## Resolution

"If this error occurs, decrease the concurrency level of your flow. 
For example, if your flow is triggered by the action ""When a file is created in a folder"" when using the SharePoint trigger, you can reduce the degree of parallelism in the action settings."


