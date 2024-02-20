---
title: DISM command fails with error code 87
description: Resolves an issue in which you can't apply a Windows 10 image.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# DISM command fails with error code 87 when you try to apply a Windows 10 image

This article provides a solution to the error 87 that occurs when you try to apply a Windows 10 image.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3082581

## Symptoms

Consider the following scenario:  

- You have a Windows 10 image.
- Windows has Compact OS compression enabled on some files.
- You have an earlier version of DISM (that is, a version from Windows 8.1 or from an earlier version of Windows).
- You try to apply the Windows 10 image by using the DISM /Apply-Image command.

In this scenario, the command fails with error code 87. Additionally, the DISM log file shows the following error message:

>Error DISM DISM WIM Provider: PID=1804 [RestoreReparsePoint:(1332) -> ioctl: setting reparse point tag failed]
>
>C:\Windows\assembly\NativeImages_v4.0.30319_64\System.Runt0d283adf#\9766308db336f6018797df6128270717\System.Runtime.WindowsRuntime.ni.dll (HRESULT=0x80070057) - CWimManager::WimProviderMsgLogCallback

## Cause

To apply a Windows 10 image, you must use the Windows 10 version of DISM. This version requires the Wofadk.sys filter driver.

> [!NOTE]
> The Wofadk.sys filter driver is included in the Windows 10 Assessment and Deployment Kit (ADK). The driver must be installed and configured to be used with Window 10 DISM when the command runs on an earlier version of Windows host or Windows Preinstallation Environment (Windows PE).

## Resolution

Use the Windows 10 version of DISM with Wofadk.sys filter driver. For more information, see [DISM Supported Platforms](/windows-hardware/manufacture/desktop/dism-supported-platforms) and [Copy DISM to Another Computer](https://msdn.microsoft.com/library/windows/hardware/dn898515%28v=vs.85%29.aspx).

## More information

For more information about Compact OS compression, see [Compact OS, single-instancing, and image optimization](https://msdn.microsoft.com/library/windows/hardware/dn940129%28v=vs.85%29.aspx). In that article, see the "To deploy Windows using a WIM file section for more information about how to deploy Windows by using a WIM file.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
