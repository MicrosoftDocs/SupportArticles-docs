---
title: Administrator on RDSH gets error in Licensing Diagnosis-Licenses are not available for this Remote Desktop Session Host server
description: Describes an issue where you get an error when you click Licensing Diagnosis.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: klausu, kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# Windows Server 2008 R2: Administrator on RDSH gets an error in Licensing Diagnosis: Licenses are not available for this Remote Desktop Session Host server

This article describes a by-design behavior where Windows Server 2008 R2 Administrator on RDSH gets an error in Licensing Diagnosis.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2546583

## Symptoms

Consider the following Scenario:

1. You install the "Remote Desktop Licensing" role service on a computer that is running Windows Server 2008 R2.
2. You install the "Remote Desktop Session Host" role service on another computer that is running Windows Server 2008 R2.
3. You open the "Remote Desktop Session Host Configuration" MMC windows (tsconfig.msc) on the computer with the RDSH role.
4. You click the **Licensing Diagnosis** item in the left panel.

In this scenario, you may get the following error message displayed:

> Licenses are not available for this Remote Desktop Session Host server, and Licensing Diagnosis has identified licensing problems for the RD Session Host server.  
Number of licenses available for clients: 0  
...
>
> Licensing Diagnosis Information - 1 error(s)...  
Problem: To identify possible licensing issues, administrator credentials for license server %servername% are required.  
Suggested Resolution: Provide administrator credentials for the Remote Desktop Services license server.

## Cause

The issue occurs since the current querying user account doesn't have the administrator privilege on the Remote Desktop Licensing server.

The Licensing Diagnosis uses a WMI method to query the licensing information. This method requires Administrator privileges on the Remote Desktop Licensing Server. This is by design.

## Resolution

Add the querying User Account to the local Administrators group on the Remote Desktop Licensing Server.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).
