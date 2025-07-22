---
title: Collect Data to Analyze and Troubleshoot Licensing and Activation Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on licensing and activation scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot licensing and activation scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Windows volume activation

### TSS cmdlet

```powershell
.\TSS.ps1 -CollectLog DND_SETUPReport
```

### TSS cmdlet description

Use this scenario when Windows fails to activate. Run this cmdlet on the machine that is experiencing the activation failure. The `DND_SETUPReport` collects detailed logs including component-based servicing (CBS), Windows Update, and servicing logs to help identify root causes such as component corruption, servicing stack issues, or policy misconfigurations.
