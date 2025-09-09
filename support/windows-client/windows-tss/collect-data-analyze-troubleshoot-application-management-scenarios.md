---
title: Collect Data to Analyze and Troubleshoot Application Management Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on application management scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot application management scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Modern, Inbox, and Microsoft Store apps

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_UWP
```

### TSS cmdlet description

The `PRF_UWP` scenario is useful for troubleshooting problems with Inbox applications (Appx or Modern apps), the Start menu, and the Shell. For example, Universal Windows Platform (UWP) apps (such as Settings, Calculator, and Microsoft Store) don't launch or crash. This scenario also applies to issues where AppX package registration fails, or UWP apps are slow or unresponsive.

## Scenario: Microsoft Store

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_Store
```

### TSS cmdlet description

The `PRF_Store` scenario is useful for troubleshooting installation problems with Inbox applications (Appx or Modern apps). For example, Microsoft Store doesn't open, crashes, hangs, or fails to install or update apps. This scenario also applies to issues where app deployments that rely on the Microsoft Store infrastructure fail, or where Microsoft Store apps don't appear in the Start menu or Company Portal.

## Scenario: WinGet

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_WinGet
```

### TSS cmdlet description

The `PRF_WinGet` scenario is useful for troubleshooting issues with WinGet cmdlets failing or hanging. This scenario also applies to issues where the installating or upgrading apps via WinGet isn't working, or issues with the Microsoft Store integration in WinGet.

## Scenario: Photos app

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_Photo
```

### TSS cmdlet description

The `PRF_Photo` scenario is useful for troubleshooting problems such as the Photos app not opening, crashing, or freezing. It also applies to issues where images fail to render or load slowly, or issues with editing, saving, or sharing photos.

## Scenario: Clipboard and copy/paste

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_Clipboard
```

### TSS cmdlet description

The `PRF_Clipboard` scenario can help diagnose issues where the clipboard functionality is degraded or broken. Examples include copy/paste failing intermittently or stopping working entirely. This scenario also applies to issues where clipboard operations are slow or hang (for example, Snipping Tool delays).

## Scenario: Camera problems

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_MediaCamera
```

### TSS cmdlet description

The `PRF_MediaCamera` scenario is useful for troubleshooting problems such as the camera not being detected or not working in apps like Teams, Zoom, or Camera. You might see a message like "No camera found" or an error code when launching the Camera app, or encounter a black screen or frozen video feed during video calls.
