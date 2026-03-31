---
title: Shared folder for virtual desktop profiles experiences intermittent communication failures in Windows Server 2019
description: Helps you diagnose and resolve intermittent communication failures on a shared folder that stores virtual desktop profiles on a Windows Server 2019-based computer.
ms.date: 04/01/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:remote desktop services and terminal services\virtual desktop infrastructure (vdi)
- pcy:WinComm User Experience
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Shared folder for virtual desktop profiles experiences intermittent communication failures in Windows Server 2019

## Summary

This article helps you diagnose and resolve intermittent communication failures on a shared folder that stores virtual desktop profile on a Windows Server 2019-based computer. These failures are typically caused by issues in the storage subsystem, such as a faulty disk, storage controller, or related hardware. Follow the steps in this article to identify the faulty component and restore reliable storage connectivity.

## Symptoms

You use a Windows Server 2019-based computer to host a shared folder for virtual desktop profile storage. You experience the following symptoms:

- The Windows event logs contain repeated warning messages that document device resets and input/output (IO) operation retries on a specific disk.
- On multiple occasions, the shared folder experiences temporary communication disruptions that last several minutes at a time.
- Disconnection events occur even when no specific tasks or workloads are actively running on the computer.

## Cause

These symptoms indicate a failure in the storage subsystem. For example, a storage device, storage controller, or other related hardware could be responsible for the intermittent connectivity issues.

## Resolution

### Prerequisites

- Before you perform any repairs or modify any disks, back up all critical data.
- Make sure that you have administrative permissions on the affected devices.
- Familiarize yourself with storage subsystem architecture and event log monitoring.

To resolve this issue, follow these steps.

### Step 1: Check drivers and firmware

Make sure that the storage-related drivers and firmware are up to date. Consult your hardware vendor for the latest drivers. This step includes drivers for components such as:

- iSCSI initiator
- RAID controller
- Host Bus Adapter (HBA)
- Device-specific module (DSM)
- Multipath I/O (MPIO)

### Step 2: Review the system and application logs for relevant events

For example, the following event IDs indicate an issue in the storage subsystem:

- Event ID 129, `Reset to device, <DeviceIdentifier>, was issued.`
- Event ID 153, `The IO operation at logical block address <LogicalBlockAddress> for Disk <DiskNumber> was retried.`
- Event ID 157, `Disk <DiskNumber> has been surprise removed.`

### Step 3: Run diagnostics and collect additional diagnostic information

- Review the storage controller logs.
- If it's available, review Self-Monitoring, Analysis, and Reporting Technology (SMART) data from the affected disks.
- Run vendor-provided diagnostic tools to assess the health of the storage devices and controllers.
- Check cabling, power supply stability, and physical connections for the affected storage hardware.
- If you're using clustered storage, isolate the issue to specific hardware by removing individual disks from the cluster, and then testing the system.

### Step 4: Replace or repair faulty components

- Replace any faulty disk, storage controller, or power supply.

### Step 5: Monitor to make sure that the issue is resolved

- Set up real-time monitoring for storage performance metrics and network connectivity.
- Track any recurrence of device resets or I/O errors.

> [!TIP]  
> Consider using redundant storage (such as storage clusters), if you don't use them already. Redundant storage solutions minimize the effects of future failures.

## Data collection

If you have to contact Microsoft Support, gather the following information to expedite troubleshooting:

- Exported data from the system log, application log, and storage-related event logs
- Disk health reports from monitoring or troubleshooting tools
- Screenshots or logs that show error messages and error codes
- Storage controller logs and firmware versions.
- SMART data for all disks in the affected storage array.
- Details of the shared folder configuration and network topology.
- Any recent changes to hardware, drivers, or firmware.
