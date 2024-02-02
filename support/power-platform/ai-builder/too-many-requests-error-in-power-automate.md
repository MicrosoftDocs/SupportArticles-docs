---
title: Too many requests error in Power Automate
description: Provides a resolution for the 429-TooManyRequests error.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice:
ms.author: angieandrews
author: v-aangie
---

# Too many requests error in Power Automate

This article provides a solution when you receive a *too many requests* error.

*Applies to:* &nbsp; Power Automate

## Symptoms

You get the error "429 – TooManyRequests".

## Cause

You've performed too many executions in a short time frame on a model.

## Resolution

If this error occurs, decrease the concurrency level of your flow. For example, if your flow is triggered by the action, **When a file is created in a folder** when using the SharePoint trigger, you can reduce the degree of parallelism in the action settings.

1. Select "..." on the **When a file is created in a folder** window and select **Settings**.

    :::image type="content" source="media/too-many-requests-error-in-power-automate/reduce-degree-of-parallelism-step-1.png" alt-text="Step 1 of reducing the degree of parallelism in the action settings." border="false":::

2. Reduce the degree of parallelism under **Concurrency Control**.

    :::image type="content" source="media/too-many-requests-error-in-power-automate/reduce-degree-of-parallelism-step-2.png" alt-text="Step 2 of reducing the degree of parallelism in the action settings." border="false":::

3. Select **Done**.

## Resources

For more information, see [Concurrency, looping, and debatching limits](/power-automate/limits-and-config#concurrency-looping-and-debatching-limits).
