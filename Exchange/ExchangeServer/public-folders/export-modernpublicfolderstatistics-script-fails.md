---
title: Export-ModernPublicFolderStatistics.ps1 script fails and returns a ToBytes error
description: Provides workarounds for an issue in which the Export-ModernPublicFolderStatistics.ps1 script fails with a ToBytes error after you install the November 2022 security updates for Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 171093
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Export-ModernPublicFolderStatistics.ps1 script fails and returns a "ToBytes" error

## Symptoms

After you install the November 2022 Microsoft Exchange Server security updates (SUs) or later SUs, you try to run *Export-ModernPublicFolderStatistics.ps1*, but the script fails and returns the following error message:

> Method invocation failed because [System.String] does not contain a method named 'ToBytes'.

## Workaround

To work around this issue, use one of the following methods.

### Workaround 1

1. Open *Export-ModernPublicFolderStatistics.ps1* in a text editor.

2. Search for and replace all occurrences of `ToBytes()` with `ToString().Split("(")[1].Split(" ")[0].Replace(",","")`.

3. Save the modified content to a new file, such as *Export-ModernPublicFolderStatistics-Temp.ps1*.

4. Run *Export-ModernPublicFolderStatistics-Temp.ps1*.

### Workaround 2

1. Open an elevated PowerShell session.

2. Load the Exchange Management PowerShell cmdlets by running the following command:

   ```powershell
   Add-PSSnapin *Exchange*
   ```

3. Run *Export-ModernPublicFolderStatistics.ps1*.

## Status

Microsoft is investigating this issue and will update this article when more information becomes available.
