---
title: Collect Data to Analyze and Troubleshoot Remote Desktop Services Scenarios
description: Helps gather information about your issue by using the TroubleShootingScript (TSS) toolset and learn what data to collect based on Remote Desktop Services scenarios.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, traceytu, takarasz, v-lianna, raviks, warrenw
ms.custom: sap:Support Tools\TSS, csstroubleshoot
---
# Collect data to analyze and troubleshoot Remote Desktop Services (RDS) scenarios

This article helps gather information about your issue by using the TroubleShootingScript (TSS) toolset before contacting Microsoft support.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Session connectivity

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario UEX_RDScli
```

Server:

```powershell
.\TSS.ps1 -Scenario UEX_RDSsrv
```

### TSS cmdlet description

Use these cmdlets to troubleshoot Remote Desktop Protocol (RDP) connection failures. Common RDP failure scenarios include:

- Remote access to the server isn't enabled.
- The remote computer is turned off.
- The remote computer isn't available on the network.

For slow logon issues, include the following parameters:

`-UEX_Auth -UEX_Logon -UEX_RDSProfiles -Mode Basic`

For authentication-related errors, such as "Logon attempt failed" or "An internal error has occurred," use: `-UEX_Auth -UEX_Logon -UEX_RDSProfiles -UEX_RDSScard -Mode Basic`  

> [!NOTE]
> When reproducing the issue, collect logs from both the client and the server to ensure complete diagnostic coverage.

## Scenario: Deployment, configuration, and management of Remote Desktop Services infrastructure

### TSS cmdlet

```powershell
.\TSS.ps1 -Scenario UEX_RDSsrv -UEX_ServerManager -UEX_WMI -UEX_WinRM
```

### TSS cmdlet description

Use this cmdlet to troubleshoot issues related to RDS role installation or when the RDS overview page fails to display.

## Scenario: Remote Desktop Connection (RDC) client (includes UWP apps)

### TSS cmdlet

Client:

```powershell
.\TSS.ps1 -Scenario UEX_RDScli
```

Server:

```powershell
.\TSS.ps1 -Scenario UEX_RDSsrv
```

### TSS cmdlet description

Use these cmdlets to troubleshoot issues specific to the Remote Desktop (RD) client.

> [!NOTE]
> These cmdlets are intended to diagnose problems with the RD client application itself, rather than session connectivity.

Typical scenarios include:

- Missing UI elements or functionality
- Application crashes or hangs
- RD client features not responding as expected

When reproducing the issue, make sure to collect logs from both the client and server sides.
