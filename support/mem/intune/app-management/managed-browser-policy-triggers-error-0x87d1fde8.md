---
title: Managed Browser policy triggers 0x87D1FDE8 error in Intune
description: Describes an issue in which you receive error 0x87D1FDE8 after you deploy a Managed Browser policy in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Android\Device profiles
ms.reviewer: kaushika, jchornbe
---
# Managed Browser policy triggers 0x87D1FDE8 error in Intune console

This article describes a known issue where you receive error 0x87D1FDE8 after you deploy a Managed Browser policy. For the most recent guidance, see [Manage web access by using Microsoft Edge for iOS and Android](/mem/intune/apps/manage-microsoft-edge).

## Symptoms

Consider the following scenario:

- You deploy the **Configure URLs that will be allowed or blocked in the Managed Browser** policy.
- The allowlist contains [https://www.microsoft.com](https://www.microsoft.com/), or the policy was implemented during app installation.

In this scenario, devices that receive the policy display the following status in the Microsoft Intune admin console:

> An error occurred:  
> 0x87D1FDE8

## Cause

This is a known issue in Microsoft Intune.

## Solution

The error in the admin console goes away after the device checks in again. This error doesn't affect the performance or behavior of Intune Managed Browser, and it can be safely ignored.
