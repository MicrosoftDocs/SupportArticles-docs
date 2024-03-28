---
title: Error (This update is not applicable to your computer) when installing RSAT
description: Provides a solution to an error that occurs when you install the Remote Server Administration Tools.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# Error message when installing RSAT: This update is not applicable to your computer

This article provides a solution to an error that occurs when you install the Remote Server Administration Tools (RSAT).

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2517239

## Symptoms

When installing the Remote Server Administration Tools for Windows 7 (RSAT), you may receive the following error message:

> "This update is not applicable to your computer"  

## Cause

This error will occur if you attempt to install RSAT after installing Service Pack 1 for Windows 7. The RSAT tools are designed for the RTM version of Windows 7 and are not compatible with Service Pack 1. However, Service Pack 1 includes updated components for RSAT, so if RSAT is installed before Service Pack 1, the issue will not occur and the components will be updated automatically.

## Resolution

Install RSAT tools before installing Service Pack 1 for Windows 7. If Service Pack 1 for Windows 7 is already installed, it can be uninstalled and then reinstalled after the RSAT tools are installed.

## More information

Microsoft has confirmed this to be by design, as RSAT was designed for Windows 7 RTM version. A newer version of RSAT is slated to be released in the future.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
