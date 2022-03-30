---
title: The output of an AI Builder action is empty in Power Automate or the next action returns an error "Unable to process template language expressions in action..."
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# The output of an AI Builder action is empty in Power Automate or the next action returns an error "Unable to process template language expressions in action..."

This article provides a solution to an error "Unable to process template language expressions in action..." with a statusCode:" 202.

_Applies to:_ &nbsp; Power Automate


## Symptoms

In the output of the AI bulider action, you'll see a json starting with "statusCode": 202.


## Cause

Make sure that the asynchronous pattern is not disabled for this action.


## Resolution

If it is disabled, enable it and run your flow again.


## Resources

Limits and configuration

- [Timeout](https://docs.microsoft.com/power-automate/limits-and-config#timeout)


