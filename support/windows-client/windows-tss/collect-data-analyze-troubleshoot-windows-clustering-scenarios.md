---
title: Collect Data to Analyze and Troubleshoot Clustering and High availability Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on clustering and high availability scenarios.
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
# Collect data to analyze and troubleshoot clustering and high availability scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Unable to bring a resource online

### TSS cmdlet

```powershell
.\TSS.ps1 -SDP Cluster
```

### TSS cmdlet description

Run this cmdlet on the cluster node where the resource doesn't come online.

## Scenario: Cluster service startup failure

### TSS cmdlet

```powershell
.\TSS.ps1 -SDP Cluster
```

### TSS cmdlet description

Run this cmdlet on the cluster node where the service fails to start.

## Scenario: Setup and configuration of clustered services and applications

### TSS cmdlet

```powershell
.\TSS.ps1 -SDP Cluster
```

### TSS cmdlet description

Run this cmdlet on the cluster node where you're installing or configuring the service or application.

## Scenario: Partition and volume management

### TSS cmdlet

```powershell
.\TSS.ps1 -SDP Cluster
```

### TSS cmdlet description

Run this cmdlet on the cluster's active node when you experience partition or volume management issues.
