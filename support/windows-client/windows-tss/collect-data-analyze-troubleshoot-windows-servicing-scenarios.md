---
title: Collect Data to Analyze and Troubleshoot Windows Servicing, Updates, and Features on Demand Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support for Windows servicing, Updates, and Features on Demand scenarios.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios

This article helps gather information about your issue by using the Trouble Shooting Script (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Failures to install Windows Updates or Features on Demand

### TSS cmdlet

```powershell
.\TSS.ps1 -CollectLog DND_SETUPReport
```

### TSS cmdlet description

Use this scenario when Windows Updates fail to install due to unknown errors. The `DND_SETUPReport` collects detailed logs, including component-based servicing (CBS), Windows Update, and servicing logs, to help identify root causes such as component corruption, servicing stack issues, or policy misconfigurations.

## Scenario: Installing or upgrading Windows

### TSS cmdlet

```powershell
.\TSS.ps1 -CollectLog DND_SETUPReport
```

### TSS cmdlet description

Use this cmdlet when the installation or upgrade of Windows fails or behaves unexpectedly. This scenario captures setup logs, compatibility checks, and rollback diagnostics to help troubleshoot setup failures or upgrade blocks.

## Scenario: Windows Update configuration, settings, and management

### TSS cmdlet

```powershell
.\TSS.ps1 -CollectLog DND_SETUPReport
```

### TSS cmdlet description

Use this cmdlet to gather logs related to Windows Update configuration, including registry settings, policy enforcement, and update agent behavior. It helps diagnose issues such as update deferrals, group policy conflicts, or misapplied settings.

## Scenario: Clients missing updates, updates not offered, or failing to download updates

### TSS cmdlet

```powershell
.\TSS.ps1 -CollectLog DND_SETUPReport
```

### TSS cmdlet description

Ideal for scenarios where clients aren't receiving updates, updates aren't being offered, or update downloads fail. The collected logs include Delivery Optimization (DO), Windows Update agent, and network traces to pinpoint issues like misconfigured DO policies or firewall blocks.
