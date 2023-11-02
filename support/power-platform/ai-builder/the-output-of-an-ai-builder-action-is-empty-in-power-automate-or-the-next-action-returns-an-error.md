---
title: Output of an AI Builder action is empty in Power Automate or the next action returns an error
description: Provides a resolution for the issue that the output of an AI Builder action is empty in Power Automate or the next action returns an error.
ms.reviewer: angiendrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Output of an AI Builder action is empty in Power Automate or the next action returns an error

This article provides a solution to an error "Unable to process template language expressions in action..." with "statusCode: 202".

_Applies to:_ &nbsp; Power Automate

## Symptoms

In the output of the AI Builder action, you'll see a json starting with **statusCode: 202**.

## Cause

The asynchronous pattern might be disabled.

## Resolution

Make sure that the asynchronous pattern isn't disabled for this action. If it's disabled, enable it and run your flow again.

## Resources

For more information, see [Timeout](/power-automate/limits-and-config#timeout).
