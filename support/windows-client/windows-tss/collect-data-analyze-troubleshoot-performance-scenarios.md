---
title: Collect Data to Analyze and Troubleshoot Performance Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on performance scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot performance scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: System reliability (crashes, errors, bug checks, or blue screens, and unexpected restarts)

### TSS cmdlet

```powershell
TSS.ps1 -SDP Perf
```

### TSS cmdlet description

Use this cmdlet when your server or client has a performance issue, slow startup, or a bug check (also known as bluescreen).

## Scenario: System performance (slow, unresponsive, high CPU, and resource leak)

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_General
```

### TSS cmdlet description

The `PRF_General` scenario can be useful if you experience unexplained performance degradation across multiple components, or intermittent issues that are hard to reproduce or isolate. You might experience multi-symptom scenarios involving CPU, memory, disk, or user interface (UI) responsiveness. This scenario is also useful if you're unsure which specific performance scenario applies.

Switch to the high CPU cmdlet if you know that the high CPU is the problem.

## Scenario: Black screen after logon

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_UWP
```

```powershell
.\TSS.ps1 -set crashmode
```

```powershell
.\TSS.ps1 -Scenario PRF_UWP -crash
```

```powershell
.\TSS.ps1 -StartAutoLogger -Scenario PRF_UWP -crash
```

### TSS cmdlet description

If the black screen after logon lasts less than five minutes, run the scenario and optionally collect a dump file if the delay is long enough to ensure the issue is captured. If the duration exceeds five minutes, stop the reproduction at five minutes and allow the data collection and dump capture to occur.

Before the dump capture, make sure to enable a complete dump collection using the `-crashmode` option, and then run the scenario with the `-crash` flag.

Use the `-StartAutoLogger` parameter to schedule the data capture after the next restart.

## Scenario: App, process, and service reliability (crashes and errors)

### TSS cmdlet

```powershell
.\TSS.ps1 -set wer
```

```powershell
.\TSS.ps1 -Scenario PRF_General
```

### TSS cmdlet description

If an application crashes, ensure the system is configured to capture complete user dumps (`-set wer`) and then capture and upload them for analysis.

Use the `PRF_General` scenario to gather more information on the system.

## Scenario: App, process, and service performance (slow and unresponsive)

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_General
```

### TSS cmdlet description

The `PRF_General` scenario is ideal for multi-symptom scenarios involving CPU, memory, disk, or UI responsiveness or where you're unsure which specific performance scenario applies.

## Scenario: Boot problems

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_Boot
.\TSS.ps1 -StartAutoLogger -Scenario PRF_Boot
```

### TSS cmdlet description

The `PRF_Boot` scenario is used to collect diagnostic data related to boot-time performance issues on Windows systems. Examples include slow boot times, black screens during or after boot and missing or delayed services at startup.

Use the `-StartAutologger` switch to schedule data collection after the next restart.

## Scenario: Performance library (Perflib) counters

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_Perflib
```

### TSS cmdlet description

The `PRF_Perflib` scenario is useful for troubleshooting problems like missing or corrupted performance counters or where Performance Monitor (PerfMon) shows blank or incomplete data.

Your applications might fail to retrieve performance data, or you see high CPU usage or memory leaks linked to **perflib.dll**, or event log errors like:

- Event ID 1008: "The Open Procedure for service failed…"
- Event ID 1023: "Windows cannot load the extensible counter DLL…"
