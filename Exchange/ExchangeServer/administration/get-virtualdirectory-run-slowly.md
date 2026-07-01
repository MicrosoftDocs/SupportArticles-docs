---
title: Get-VirtualDirectory cmdlets run slowly
description: Work around an issue in which the Get-VirtualDirectory cmdlets take longer than expected (about 15 minutes) to complete in an Exchange Server environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Virtual Directories configuration
  - Exchange Server
  - CI 9823
  - CI 12055
  - CSSTroubleshoot
ms.reviewer: v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/12/2026
---

# Get-VirtualDirectory cmdlets take a long time to run in Microsoft Exchange Server

_Original KB number:_ &nbsp; 2896472

## Summary

The Get-VirtualDirectory cmdlets can take an extended time to complete when they query virtual directories on Exchange servers in remote Active Directory sites across a WAN connection. This delay occurs because the cmdlets retrieve information from both Active Directory and the IIS metabase. Using the `AdPropertiesOnly` switch limits the query to Active Directory data and avoids IIS metabase lookups, reducing the time required to return results.

## Symptoms

In an Exchange Server environment, you run one of the following cmdlets to obtain the properties of a virtual directory for a server in another site that's connected over a wide area network (WAN):

- Get-WebServicesVirtualDirectory
- Get-OwaVirtualDirectory
- Get-ActiveSyncVirtualDirectory
- Get-AutodiscoverVirtualDirectory
- Get-EcpVirtualDirectory
- Get-PowerShellVirtualDirectory
- Get-OABvirtualDirectory

However, the cmdlet takes longer than expected to run (about 15 minutes).

## Cause

This issue occurs because the cmdlet makes calls to the Internet Information Services (IIS) metabase for the properties of the virtual directory.

## Workaround

To work around this issue, run the [Get-OwaVirtualDirectory](/powershell/module/exchangepowershell/get-owavirtualdirectory) PowerShell cmdlet with the `AdPropertiesOnly` switch in the calls to the IIS metabase.

Example 1

```powershell
Get-OwaVirtualDirectory -Server Contoso -AdpropertiesOnly
```

Example 2

```powershell
Get-OwaVirtualDirectory -Identity "Contoso\owa (default Web site)" -AdpropertiesOnly
```

The `ADPropertiesOnly` switch specifies that only the virtual directory properties that are stored in Active Directory Domain Services are returned.

For more information about `ADPropertiesOnly` switch, see [Get-OwaVirtualDirectory](/powershell/module/exchangepowershell/get-owavirtualdirectory).
