---
title: ADAM general Event ID 1161 is logged on an AD LDS server
description: Describes an issue in which ADAM General Event ID 1161 is logged on an AD LDS server
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory Lightweight Directory Services (AD LDS) and Active Directory Application Mode (ADAM)
ms.technology: windows-server-active-directory
---
# ADAM general Event ID 1161 is logged on an AD LDS server

This article describes an issue in which ADAM general Event ID 1161 is logged on an AD LDS server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3080830

## Symptoms

The following event is logged in the ADAM log every time an instance is restarted on an AD LDS server that's running Windows Server 2012 R2.

## Cause

The address book hierarchy table does not exist in the Active Directory Lightweight Directory Services (AD LDS) database. Therefore, the event is triggered during service startup.

This event can be safely ignored on an AD LDS instance.
