---
title: Collect Data to Analyze and Troubleshoot Active Directory Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on Active Directory scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna，raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot Active Directory scenarios

This article helps you gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Active Directory replication and topology

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario ADS_AuthEx
```

Server (domain controller (DC)):

```powershell
.\TSS.ps1 -Scenario ADS_Auth
```

### TSS cmdlet description

Run this cmdlet on both the source and destination DCs to gather data at the same time. Begin logging on both DCs using the TSS cmdlet and reproduce the issue by initiating replication with the [repadmin /replicate](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc742152(v=ws.11)) cmdlet. For example, `repadmin /replicate dest-dc01 source-dc01 DC=contoso,DC=com`.

## Scenario: Active Directory Certificate Services (ADCS)

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario ADS_AuthEx
```

Server:

```powershell
.\TSS.ps1 -Start -ADS_ADCS
```

### TSS cmdlet description

Depending on the issue or scenario, you can run this cmdlet only on the ADCS server, the client, or both. Begin logging using the TSS cmdlet and reproduce the issue.

## Scenario: Authentication issues (Kerberos and New Technology LAN Manager (NTLM))

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario ADS_AuthEx
```

Server:

```powershell
.\TSS.ps1 -Scenario ADS_Auth
```

### TSS cmdlet description

Depending on the specific issue or scenario, you might need to gather data from the client, the server, and the DC, or from all three sources. For thorough troubleshooting, it's important to obtain data from all three sources. However, if you can't retrieve logs from the DC, you can continue logging on the client and server with the TSS cmdlet, and reproduce the issue.

## Scenario: Domain join

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario ADS_AuthEx
```

Server:

```powershell
.\TSS.ps1 -Scenario ADS_Auth
```

### TSS cmdlet description

Depending on the specific issue or scenario, you might need to gather data from the client and the DC. However, if you can't retrieve logs from the DC, you can continue logging on the client with the TSS cmdlet, and reproduce the issue.
