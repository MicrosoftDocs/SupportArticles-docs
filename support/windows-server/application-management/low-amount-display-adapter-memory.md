---
title: DXDIAG reports low display adapters memory
description: Describes an issue where Direct-X diagnostics tool (DXDIAG) reports an unexpected value for the display adapters memory.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joelch, waltere
ms.custom: sap:application-compatibility-toolkit-act, csstroubleshoot
---
# Direct-X diagnostics tool may report an unexpected value for the display adapters memory

This article describes an issue where Direct-X diagnostics tool (DXDIAG) reports an unexpected value for the display adapters memory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2026022

## Symptoms

You have a system with 1GB or greater of Video memory, and 4GB or greater of system memory (RAM). You run the Direct-X Diagnostics tool, and it reports that you have an unexpectedly low amount of Approximate Total Memory on the display tab. You may also see issues with some games or applications not allowing you to select the highest detail settings.

## Cause

The API that DXDiag uses to approximate the system memory was not designed to handle systems in this configuration

## Resolution

Microsoft is working to resolve this in future releases.

## More information

On a system with 1GB of video memory, the following values are returned with the associated system memory:

|System Memory | Reported Approximate Total Memory|
|--|--|
|4GB |3496MB|
|6GB|454MB|
|8GB|1259MB|
