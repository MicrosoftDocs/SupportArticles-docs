---
title: Collect Data to Analyze and Troubleshoot Group Policy Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on Group Policy scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot Group Policy scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Issues applying Group Policy

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario ADS_AuthEx
```

Server (domain controller):

```powershell
.\TSS.ps1 -Scenario ADS_Auth
```

### TSS cmdlet description

Depending on the specific issue or scenario, you might need to gather data from the client and the domain controller. However, if you can't retrieve logs from the domain controller, you can continue logging on the client with the TSS cmdlet and reproduce the issue.
