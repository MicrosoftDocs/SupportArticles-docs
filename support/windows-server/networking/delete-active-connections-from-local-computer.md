---
title: Disconnect all shared resources from local computer
description: Describes how you can delete active or remembered connections on a local computer.
ms.date: 01/08/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-nirmsh
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Disconnect all shared resources from local computer

This article explains how you can disconnect active or remembered shared resources on a local computer.

_Applies to:_ &nbsp; Supported versions of Windows  
_Original KB number:_ &nbsp; 556001

## Command to delete active connections

You can use the `Net Use * /delete` command to disconnect active or remembered shared resources on a local computer.

> [!NOTE]
> This command can also be used on remote computers. Run `Net help use` for more options.

## Reference

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
