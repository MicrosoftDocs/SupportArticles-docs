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

_Applies to:_ &nbsp; Power Automate

## Symptoms

You get the error, **429 – TooManyRequests**.

## Cause

You've performed too many executions in a short time frame on a model.

## Resolution

If this error occurs, decrease the concurrency level of your flow. For example, if your flow is triggered by the action, **When a file is created in a folder** when using the SharePoint trigger, you can reduce the degree of parallelism in the action settings.


![when_a_file_paramete](https://user-images.githubusercontent.com/79529948/163181352-30c29703-da2c-4e07-896c-9c6755697ddc.jpg)


![when_a_file_paramete2](https://user-images.githubusercontent.com/79529948/163181902-f49754f6-f457-4f00-95e8-46212fdf3b1f.jpg)

Click on Done.

## Resources
[Concurrency, looping, and debatching limits](https://docs.microsoft.com/power-automate/limits-and-config#concurrency-looping-and-debatching-limits)
