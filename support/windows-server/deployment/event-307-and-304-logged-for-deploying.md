---
title: Event ID 307 and 304 logged for deploying Windows
description: Address an issue in which you receive event ID 307 and event ID 304 after you deploy Windows 10 on a device.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
---
# Event ID 307 and Event ID 304 are logged after you deploy Windows on a device

This article provides a resolution for the event ID 307 and 304 that are logged when you deploy Windows on a device.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019  
_Original KB number:_ &nbsp; 4480781

## Symptom

When you deploy Windows on a device, these events are logged:

```output
Log Name: Microsoft-Windows-User Device Registration/Admin  
Source: User Device Registration  
Event ID: 307  
Level: Error  
Description:  
Automatic registration failed. Failed to lookup the registration service information from Active Directory. Exit code: Unknown HResult Error code: 0x801c001d. See https://go.microsoft.com/fwlink/?LinkId=623042
```

```output
Log Name: Microsoft-Windows-User Device Registration/Admin  
Source: Microsoft-Windows-User Device Registration  
Event ID: 304  
Level: Error  
Description:  
Automatic registration failed at join phase.  Exit code: Unknown HResult Error code: 0x801c001d. Server error:. Debug Output:\r\n undefined.
```

Here is an example of the event IDs:

:::image type="content" source="media/event-307-and-304-logged-for-deploying/event-307.png" alt-text="Details of the event 307 Automatic registration failed." border="false":::

## Cause

These event IDs occur when the infrastructure isn't prepared for [Hybrid join](/azure/active-directory/devices/hybrid-azuread-join-federated-domains). When the device tries to do Hybrid join, the registration fails, and the events are logged.

## Resolution

If the infrastructure is in a non-Hybrid join environment, these event IDs are expected during Windows 10 deployment. They can be ignored.

If you have a Hybrid scenario, see [Troubleshooting Microsoft Entra hybrid joined Windows 10 and Windows Server 2016 devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current) for troubleshooting steps.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
