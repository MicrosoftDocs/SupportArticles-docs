---
title: Fail to open TCP/IP properties of network adapter
description: Resolve an error that occurs when you open the TCP/IP properties of your network adapter.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Error message: In order to configure TCP/IP, you must install and enable a network adapter card

This article provides help to resolve an error that occurs when you open the TCP/IP properties of your network adapter.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 308939

## Symptoms

When you try to open the TCP/IP properties of your network adapter, you may receive the following error message:

> Microsoft TCP/IP  
In order to configure TCP/IP, you must install and enable a network adapter card.

You may receive this message after a system restoration when your network adapter has been changed before the backup.

## Cause

This behavior can occur if your network adapter has been changed to another model of network adapter without first being properly uninstalled by using the Add/Remove Hardware tool in Control Panel. If you then use Ntbackup.exe to restore a full backup of the system with your new network adapter installed, the symptom that is listed in the "Symptoms" section of this article occurs.

## Resolution

To resolve this behavior after the restoration process, uninstall the network adapter in Device Manager, and then run the Add/Remove Hardware tool in Control Panel to reinstall the network adapter.

To avoid this behavior before the restoration process, use the Add/Remove Hardware tool in Control Panel to uninstall the first network adapter, physically remove the first network adapter, install your new network adapter, and then create the backup.
