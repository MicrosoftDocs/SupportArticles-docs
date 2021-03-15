---
title: Chromium sandbox optimizations incorrectly identified as threats by EAF policy in the Enhanced Mitigation Experience Toolkit (EMET)
ms.author: luche
author: helenclu
ms.date: 4/8/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 113425
- CSSTroubleshoot 
ms.reviewer: scapero
description: Describes a workaround for an issue where the EAF policy in EMET identifies Chromium optimizations as threats.
---

# EAF policy in the EMET identifies Chromium sandbox optimizations as threats

## Symptoms

An issue has been identified with Chromium sandbox in which the Export Address Table Access Filtering (EAF) policy in the Enhanced Mitigation Experience Toolkit (EMET) and in Windows Defender Advanced Threat Protection (ATP) incorrectly identifies Chromium sandbox optimizations as threats. This issue causes Teams to work incorrectly.

## Workaround

To work around this issue, turn off EAF for Teams. More about this issue can be found in the [EMET mitigations guidelines](https://support.microsoft.com/help/2909257/emet-mitigations-guidelines). 

## More information
For more information about Windows Defender ATP and EAF policy, see [Enable exploit protection](https://docs.microsoft.com/windows/security/threat-protection/microsoft-defender-atp/enable-exploit-protection).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
