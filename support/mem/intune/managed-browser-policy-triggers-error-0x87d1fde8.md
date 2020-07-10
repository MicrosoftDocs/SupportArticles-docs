---
title: Managed Browser policy triggers 0x87D1FDE8 error
description: Describes an issue in which you receive error 0x87D1FDE8 after you deploy a Managed Browser policy.
ms.date: 05/11/2020
ms.prod-support-area-path: App management
ms.reviewer: jchornbe
---
# Managed Browser policy triggers 0x87D1FDE8 error in Intune console

This article describes a known issue in which you receive error 0x87D1FDE8 after you deploy a Managed Browser policy.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 3144435

## Symptoms

Consider the following scenario:

- You deploy the **Configure URLs that will be allowed or blocked in the Managed Browser** policy.
- The whitelist contains [https://www.microsoft.com](https://www.microsoft.com/), or the policy was implemented during app installation.

In this scenario, devices that receive the policy display the following status in the Microsoft Intune admin console:

> An error occurred:  
> 0x87D1FDE8

## Cause

This is a known issue in Microsoft Intune.

## Resolution

The error in the admin console goes away after the device checks in again. This error does not affect the performance or behavior of Intune Managed Browser, and it can be safely ignored.
