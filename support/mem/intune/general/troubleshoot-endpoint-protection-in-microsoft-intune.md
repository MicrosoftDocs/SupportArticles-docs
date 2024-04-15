---
title: Common endpoint protection messages in Microsoft Intune
description: See common messages and possible solution when using and troubleshooting endpoint protection and Microsoft Defender for Endpoint in Microsoft Intune.
ms.date: 12/05/2023
ms.reviewer: kaushika, tscott
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\Endpoint Protection
---
# Endpoint protection issues and possible solutions in Intune

This article describes potential errors and solutions when using Microsoft Intune endpoint protection.

For troubleshooting guidance specific to Microsoft Defender for Endpoint, see [Review event logs and error codes to troubleshoot issues with Microsoft Defender Antivirus](/microsoft-365/security/defender-endpoint/troubleshoot-microsoft-defender-antivirus).

## Endpoint Protection engine unavailable

**Potential cause**: The Intune endpoint protection engine was corrupted or deleted.

**Possible solutions**:

- If endpoint protection is corrupt or won't update, then update or reinstall the program.
- Force an immediate update. In the endpoint protection client program (possibly in the taskbar), choose **Update**.
- In Control Panel > Programs, select **Microsoft Intune Endpoint Protection Agent**. Uninstall the application.
- During the next update synchronization, the Microsoft Online Management Update Manager detects the missing program and reinstalls it at the scheduled installation time.

## Features are disabled

You may get a message that some features are disabled. These messages can happen if Intune endpoint protection or Microsoft Defender for Endpoint is disabled by an administrator using a configuration profile. Or, it's disabled by an end user on the device. Possible messages:

`Endpoint Protection disabled`  
`Real-time protection disabled`  
`Download scanning disabled`  
`File and program activity monitoring disabled`  
`Behavior monitoring disabled`  
`Script scanning disabled`  
`Network Inspection System disabled`  

**Possible solutions**: Enable these features. For guidance, see:

- [Add endpoint protection settings](/mem/intune/protect/endpoint-protection-configure)
- [Microsoft Defender Antivirus](/mem/intune/configuration/device-restrictions-windows-10#microsoft-defender-antivirus)
- [Turn on Windows Defender to access company resources](/mem/intune/user-help/turn-on-defender-windows)

## Malware definitions out of date

This status shows when the malware definitions on the device are out of date by 14 days or more. For example, the message may show if the device is disconnected from the Internet, or the malware definitions are outdated.

**Possible solutions**: If malware definitions are out of date, update the definitions using [Microsoft Defender Antivirus](/mem/intune/configuration/device-restrictions-windows-10#microsoft-defender-antivirus).

## Full scan overdue or quick scan overdue

A full scan or quick scan hasn't completed for 14 days. This scenario can happen if the device restarts during a full scan.

**Possible solutions**: If a scan is overdue, you can run a one-time scan or schedule recurring scans. See [Microsoft Defender Antivirus](/mem/intune/configuration/device-restrictions-windows-10#microsoft-defender-antivirus).

## Another endpoint protection application running

Another endpoint protection application is running, and the device is healthy.

**Possible solutions**: If another endpoint protection application is installed and Intune detects that application, the device may become unstable.
