---
title: Delete all active connections from local computer
description: Describes how you can delete active or remembered connections on a local computer.
ms.date: 09/24/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-nirmsh
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# Delete all the active connections from local computer

This article explains how you can delete active or remembered connections on a local computer.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556001

## Command to delete active connections

You can use the `Net Use * /delete` command to delete active connections on a local computer.

The command deletes all the active connections on local computer.

> [!NOTE]
> This command can also be used on remote computers. See the **Net help use** for more options.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
