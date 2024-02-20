---
title: Error when DDA-capable app is run against GPU
description: Describes an issue in which an error is generated when a Desktop Duplication API-capable application is run against a discrete GPU on a computer that is running Windows 8.1.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# Error generated when Desktop Duplication API-capable application is run against discrete GPU

This article provides a solution to an error that occurs when a Desktop Duplication API-capable application is run against a discrete GPU.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 3019314

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows 8.1.
- You have a Desktop Duplication API (DDA)-capable application, and it calls the DDA to duplicate the desktop image.
- The display adapter on the computer is running under the Microsoft Hybrid system.

In this scenario, when the application tries to duplicate the desktop image against the discrete GPU on a Microsoft Hybrid system, the application may not run correctly, or it may generate one of the following errors:

> Failed to create windows swapchain with 0x80070005
>
> CDesktopCaptureDWM: IDXGIOutput1::DuplicateOutput failed: 0x887a0004

## Cause

This issue occurs because the DDA does not support being run against the discrete GPU on a Microsoft Hybrid system. By design, the call fails together with error code DXGI_ERROR_UNSUPPORTED in such a scenario.

## Resolution

To work around this issue, run the application on the integrated GPU instead of on the discrete GPU on a Microsoft Hybrid system.

## More information

When this issue occurs, the IDXGIOutput1::DuplicateOutput method fails and returns an error code DXGI_ERROR_UNSUPPORTED.

For example, [this DXGI desktop duplication sample](/samples/browse/?-samples) is affected by this issue.
