---
title: Startup fails when Firmware protection is turned on
description: Provides a solution to an issue where startup fails when Firmware protection is turned on.
ms.date: 06/06/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rosasa, v-anfiro, v-lianna, asbaliga
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# Startup failure when Firmware protection is turned on

Assume Windows Server 2019 (or an earlier version) is running with hardware that supports [Secured-core servers](/windows-server/security/secured-core-server).

The [System Guard Secure Launch](/windows/security/threat-protection/windows-defender-system-guard/system-guard-secure-launch-and-smm-protection#windows-security-center) functionality isn't supported in Windows Server 2019 and earlier versions. If this feature is enabled either through the **Firmware protection** switch in the Windows Security app UI or through a manual edit of the corresponding registry key, the startup can fail.

To recover from the startup failure, go to the Unified Extensible Firmware Interface (UEFI) settings and disable Dynamic Root of Trust for Measurement (DRTM).

Contact your hardware manufacturer for instructions on how to disable DRTM. The relevant settings are labeled differently for different silicon platforms.
