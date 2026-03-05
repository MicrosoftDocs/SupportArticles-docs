---
title: Troubleshoot performance issues on a SQL Server failover cluster
description: Helps you identify and fix severe performance issues on a Windows Server failover cluster that hosts a SQL Server instance.
ms.date: 03/04/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:system performance\system performance (slow, unresponsive, high cpu, resource leak)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot slow startup and performance issues on a failover cluster that runs SQL Server

## Summary

This article helps you identify and fix severe performance issues on a Windows Server failover cluster that hosts a SQL Server instance. You might experience these issues during server startup or after signing in. Use this article to diagnose the root cause, apply a resolution, and collect diagnostic data if you have to escalate your issue to your storage vendor or Microsoft Support.

## Symptoms

In a failover cluster environment that runs Microsoft SQL Server, you encounter the following symptoms:

- After a restart, the servers start slowly.
- The Windows desktop and applications load slowly or experience delays.
- Windows File Explorer and Windows PowerShell perform sluggishly.
- The servers fail or shut down unexpectedly.
- When you open a system tool such as Task Manager, you experience a long delay before the tool starts.
- User productivity decreases significantly.

Additionally, the event log contains a large number of disk error warnings and disk timeout events, such as the following examples:

- Event ID 153: `The IO operation at logical block address 123456 for Disk 2 was retried`
- Event ID 154: `The IO Operation failed due to a hardware error`
- Status code `0xC0000185`: `The Boot Configuration Data for your PC is missing or contains errors.`

## Cause

These performance issues typically indicate a storage subsystem issue, such as one or more of the following issues:

- Disk hardware, firmware, or controller issues:
  - A disk is corrupted, or hardware fails.
  - A storage controller isn't functioning correctly.
  - Storage firmware isn't compatible with either the hardware or the storage controllers.
- Configuration or processing issues:
  - The storage cache is saturated. This condition increases latency in storage operations.
  - The logging level is too verbose. This condition floods the event log and increases the processing load.
  - A bottleneck restricts storage operations. This condition slows the storage system response time.

## Resolution

To resolve this issue, follow these steps:

1. Update firmware and drivers to the latest versions that your hardware and operating system support.
1. Engage the storage vendor to conduct a full diagnostic review of the storage system.
1. If any diagnostics detect issues such as faulty storage hardware, replace the affected hardware.
1. Inspect the storage controllers and cache to identify failures, health issues, or degradation.
1. Review Windows Server and SQL Server storage best practices, and reconfigure storage settings to optimize performance.
1. Track disk errors and verify performance improvements by monitoring system and event logs.
1. If the issues persist, eliminate hardware-related failures by replacing storage components.

## Data collection

Before you engage your storage vendor or Microsoft Support, collect the following information:

- Event data that covers the period when the issue occurred. You can export this information from Event Viewer.
- Hardware diagnostic reports from the storage vendor's tools.
- Version information for the storage controller firmware and drivers.
- Error and cluster logs from SQL Server.
- Performance data that focuses on disk I/O and latency. To collect this information, use tools such as Performance Monitor ([PerfMon](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc749115(v=ws.11))).
- Details of recent configuration changes in the failover cluster or storage environment.
