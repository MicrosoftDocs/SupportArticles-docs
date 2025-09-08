---
title: Collect Data to Analyze and Troubleshoot Shell Experience Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support for Shell experience scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot Shell experience scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Desktop (Shell, **Explorer.exe** initialization, themes, colors, icons, and Recycle Bin)

### TSS cmdlet
  
```powershell
.\TSS.ps1 -Scenario PRF_UWP
.\TSS.ps1 -StartAutoLogger -Scenario PRF_UWP
```

### TSS cmdlet description

The `PRF_UWP` scenario is useful for troubleshooting problems with Inbox applications (Appx or Modern apps), the Start menu, and the Shell.

For example, Universal Windows Platform (UWP) apps (such as Settings, Calculator, and Microsoft Store) don't launch or crash, AppX package registration fails, UWP apps are slow or unresponsive.

Schedule the data capture to occur after the next restart using the `-StartAutoLogger` option.  

## Scenario: Start menu

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario PRF_StartMenu
```

```powershell
.\TSS.ps1 -StartAutoLogger -Scenario PRF_StartMenu
```

### TSS cmdlet description

The `PRF_StartMenu` scenario is useful for troubleshooting Start menu issues, such as the Start menu not opening or responding, or pinned tiles appearing blank, missing, or broken. It also applies to cases where the Start menu crashes or closes unexpectedly, or the Search feature within the Start menu doesn't work.

Schedule the data capture to occur after the next restart using the `-StartAutoLogger` option.

## Scenario: Search

### TSS cmdlets

```powershell
.\TSS.ps1 -Scenario PRF_Search
```

```powershell
.\TSS.ps1 -StartAutoLogger -Scenario PRF_Search
```

### TSS cmdlet description

The `PRF_Search` scenario is useful for troubleshooting problems like the Search bar not responding, opening, or returning no results when searching for apps, files, or settings.

You might see the Search UI crashing, freezing, or Search indexing issues, such as missing or outdated results. The Search feature might also not work in the Start menu, File Explorer, or Settings.

Schedule the data capture to occur after the next restart using the `-StartAutoLogger` option.
