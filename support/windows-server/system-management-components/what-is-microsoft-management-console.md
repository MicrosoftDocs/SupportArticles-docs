---
title: What is MMC
description: Describe the functions of the Microsoft Management Console.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
ms.technology: windows-server-system-management-components
---
# What is Microsoft Management Console?

This article provides information about the Microsoft Management Console (MMC).

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 962457

## More information

You use Microsoft Management Console (MMC) to create, save and open administrative tools, called consoles, which manage the hardware, software, and network components of your Microsoft Windows operating system. MMC runs on all client operating systems that are currently supported.

You can use MMC to create custom tools and distribute these tools to users. With both Windows XP Professional and Windows Server 2003, you can save these tools so that they're available in the Administrative Tools folder. To create a custom MMC, you'll use the `runas` command.

A snap-in is a tool that is hosted in MMC. MMC offers a common framework in which various snap-ins can run so that you can manage several services by using a single interface. MMC also enables you to customize the console. By picking and choosing specific snap-ins, you can create management consoles that include only the administrative tools that you need. For example, you can add tools to manage your local computer and remote computers.

For more information about MMC, see the Step by Step guide to the Microsoft Management Console on the Microsoft Web site.
