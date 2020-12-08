---
title: Updates may not install with Fast Startup in Windows 10
description: Describes that the Fast Startup feature may impede the installation of certain Windows 10 updates.
ms.date: 12/07/2020
ms.prod-support-area-path: 

Windows\Windows 10\Shutdown and Sleep
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Updates may not be installed with Fast Startup in Windows 10

_Original product version:_ &nbsp; Windows 10, version 1903, all editions, Windows 10, version 1809, all editions, Windows 10  
_Original KB number:_ &nbsp; 4011287

## Summary

Windows updates might not be installed on your system after you shut down your computer. This behavior occurs when the Fast Startup feature is enabled. This behavior doesn't occur when you restart your computer. 

## More information

The Fast Startup feature in Windows 10 is enabled by default if applicable. Fast Startup is designed to help your computer start up faster after you shut down your computer. When you shut down your computer, your computer actually enters a hibernation state instead of a full shutdown. 

When comes to Windows updates, s ome patch installation could require pending operations being processed during the next Windows startup that follows a full shutdown. Without a full shutdown, those pending operations won't be processed. As a result, these update installations will not complete. Full shutdown only occurs when you restart a computer or when other event causes the computer to process a full shutdown. 

In order to make sure Windows updates that require pending operations being installed properly, you have to restart your computer to complete the installation. 

In environments managed by using Microsoft Endpoint Manager Configuration Manager (MEMCM), the installation of updates will also be affected by this behavior. There are plans to address this in a future Windows version.
