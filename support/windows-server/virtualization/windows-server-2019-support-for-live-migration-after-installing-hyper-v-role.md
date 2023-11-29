---
title: Windows Server 2019 support for live migration after installing the Hyper-V role
description: Discusses a scenario in which a Windows Server 2019 Hyper-V server does not perform Hyper-V node live migrations correctly.
ms.date: 11/30/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:live-migration, csstroubleshoot
ms.technology: hyper-v
keywords: Windows Server 2019, SSDBHardWarePresent, live migration
---

# Windows Server 2019 support for live migration after installing the Hyper-V role

_Applies to:_ &nbsp; Windows Server 2019

## Symptoms

You have a Windows Server 2019 server that has the Hyper-V role installed. In order for Windows Server 2019 Hyper-V node live migrations to work correctly, the value of the `SSBDHardwarePresent` Windows PowerShell property must be **True**. However, the server is reporting the value of `SSBDHardwarePresent` as **False**.

## Cause

This feature isn't supported in Windows Server 2019.

## Resolution

This is a known issue in Windows Server 2019 that is resolved in Windows Server 2022.

## More information

Before you install the Hyper-V role on Windows Server 2019, the system might correctly report the value of `SSBDHardwarePresent` as **True**. After you install the Hyper-V role, Windows Server 2019 reports the value of `SSBDHardwarePresent` as **False**.
