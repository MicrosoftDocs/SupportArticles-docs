---
title: Collect Data to Analyze and Troubleshoot System Management Components Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on system management components scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot system management components scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Windows Management Instrumentation (WMI)

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario UEX_WMI -netsh
```

### TSS cmdlet description

Use this cmdlet when facing WMI connection failures such as 0x800706ba or an "access denied" error, or when querying WMI classes returns an error.

## Scenario: Task Scheduler

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario UEX_Tsched
```

### TSS cmdlet description

Use this cmdlet when running a scheduled task that fails with an error, or when the task status becomes abnormal, such as queued, or when the task's last run status is incorrect.

## Scenario: Printing

### TSS cmdlet

```powershell
.\TSS.ps1 -start -UEX_Print -Procmon -netsh
```

### TSS cmdlet description

Use this cmdlet when having network printing errors occur, when the client fails to print, or when the printing is slow.

> [!NOTE]
> If the printing is slow, add the parameter `-procmon` to the end of the cmdlet.
