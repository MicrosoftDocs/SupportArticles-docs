---
title: Export-ModernPublicFolderStatistics.ps1 script fails and returns a ToBytes error
description: Fixes an issue in which the Export-ModernPublicFolderStatistics.ps1 script fails with a ToBytes error after you install the November 2022 or later security updates for Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - CI 171093
  - CI 9823
  - CI 12298
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, meerak, v-trisshores, v-kccross
appliesto:
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/29/2026
---

# Export-ModernPublicFolderStatistics.ps1 script fails and returns a "ToBytes" error

## Summary

The Export-ModernPublicFolderStatistics.ps1 script can fail after the November 2022 or later Exchange Server security updates (SUs), returning a "ToBytes" method error. This issue occurs because changes introduced by the security updates affect how the script processes public folder size information. To work around the issue, download the latest version of the script.

## Symptoms

After you install the November 2022 Microsoft Exchange Server security updates (SUs) or later SUs, you run *Export-ModernPublicFolderStatistics.ps1*, but the script fails and returns the following error message:

> Method invocation failed because [System.String] does not contain a method named 'ToBytes'.

## Workaround

To work around this issue, download the latest version of [Export-ModernPublicFolderStatistics.ps1](https://aka.ms/PublicFolderscripts).
