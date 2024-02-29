---
title: Event ID 56 is logged in Windows Server
description: Provides help to fix Event ID 56 that's logged in Windows Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Event ID 56 is logged in Windows Server

This article provides help to fix Event ID 56 that's logged in Windows Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2685788

## Symptoms

### Scenario 1

Two or more non-volatile memory expresses (NVMe) devices of the same make / model are attached to a Windows Server 2016 or Windows Server 2019-based computer.

### Scenario 2

Multiple paths are available to a disk in Windows Server. In these scenarios, you receive event ID 56 in the System log.
> Log Name: System  
Source: Application Popup  
Event ID: 56  
Level: Error  
Description: Driver SCSI returned invalid ID for a child device (000000).  

## Cause

The issue occurs because the Plug and Play (PnP) manager auto-generates unique instance IDs when duplicates are found.

## Resolution

This event ID can safely be ignored, and no user action is required.

> [!Note]
> In Windows Server 2012 R2, and Windows Server 2016, you might see the event displayed but without the correct Description field, as shown below. However, the driver name and the child device name are correct and can be used to identify the driver involved and the name of the child device.  

The description for Event ID 56 from source Application Popup cannot be found. Either the component that raises this event is not installed on your local computer or the installation is corrupted. You can install or repair the component on the local computer. If the event originated on another computer, the display information had to be saved with the event. The following information was included with the event:  
> SCSI  
000000  

The message resource is present but the message is not found in the string/message table.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
