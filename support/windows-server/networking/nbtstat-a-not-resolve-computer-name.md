---
title: NBTSTAT -A doesn't resolve computer name with DNS
description: Works around an issue where the NBTSTAT -A command doesn't resolve computer name with Domain Name System (DNS).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# NBTSTAT -A command does not resolve computer name with DNS

This article provides a workaround for an issue where the `NBTSTAT -A` command doesn't resolve computer name with Domain Name System (DNS).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 249874

## Symptoms

When you use the `nbtstat -a` command with a remote computer and the name of the computer is resolved by DNS, you receive a **Host not found** error message.

## Workaround

To work around this problem, ping the name of the computer, and then use the IP address that is returned with the `nbtstat -a` command.
