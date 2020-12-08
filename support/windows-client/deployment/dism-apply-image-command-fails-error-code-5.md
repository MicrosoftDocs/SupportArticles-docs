---
title: DISM /Apply-Image command fails with error code 5 (ERROR_ACCESS_DENIED)
description: Works around an issue that causes the DISM apply image command to fail with error code 5 (ERROR_ACCESS_DENIED). Occurs when you try to apply a Windows 10 1607 image by using the Windows Subsystem for Linux (WSL) feature.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# DISM /Apply-Image command fails with error code 5 (ERROR_ACCESS_DENIED)

_Original product version:_ &nbsp; Windows 10, version 1809, all editions, Windows 10, version 1709, all editions, Windows 10, version 1703, all editions, Windows 10, version 1607, all editions, Windows 10, version 1511, all editions, Windows 10  
_Original KB number:_ &nbsp; 3179598

## Symptoms

Consider the following scenario:
- You have a Windows 10 image.
- You enable the Windows Subsystem for Linux (WSL) feature.
- You download and install Ubuntu package by using the command that's documented [here](https://msdn.microsoft.com/commandline/wsl/reference <!--ERROR-->).
- You capture the Windows 10 image by using the DISM /Capture-Image command.
- You try to apply the captured Windows 10 image by using the DISM /Apply-Image command.In this scenario, the DISM /Apply-Image command fails with error code 5 (ERROR_ACCESS_DENIED).

## Cause

The files that are installed by the Ubuntu package may cause DISM /Apply-Image to fail.

## Workaround

Do not download and install the Ubuntu package before you capture the Windows 10 image by using the DISM /Capture-Image  command. The Ubuntu package can be downloaded and installed after the Windows 10 image is applied to a device. You can install the Ubuntu package by following the steps in this [installation guide](https://msdn.microsoft.com/commandline/wsl/install_guide <!--ERROR-->).

## More Information

For more information about Windows Subsystem for Linux, see [Frequently Asked Questions](https://msdn.microsoft.com/commandline/wsl/faq <!--ERROR-->). For more information about DISM imaging commands, see [DISM Image Management command-line options](https://msdn.microsoft.com/windows/hardware/commercialize/manufacture/desktop/dism-image-management-command-line-options-s14 <!--ERROR-->).
