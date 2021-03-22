---
title: Installing the Microsoft Loopback Adapter in Windows
description: Fixes an issue where you can't find the Microsoft Loopback Adapter.
ms.date: 09/07/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Devices and Drivers
ms.technology: windows-server-deployment
---
# Installing the Microsoft Loopback Adapter in Windows

This article helps fix an issue where you can't find the Microsoft Loopback Adapter.

_Original product version:_ &nbsp;Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;2777200

## Symptoms

You're trying to install the Microsoft Loopback Adapter, but are unable to find it.

## Cause

The Microsoft Loopback Adapter was renamed in Windows 8 and Windows Server 2012. The new name is "Microsoft KM-TEST Loopback Adapter".

## Resolution

When using the Add Hardware Wizard to manually add a network adapter, choose Manufacturer "Microsoft" and choose network adapter "Microsoft KM-TEST Loopback Adapter".
