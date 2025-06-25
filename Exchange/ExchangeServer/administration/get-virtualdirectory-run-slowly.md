---
title: Get-VirtualDirectory run slowly
description: Work around an issue in which the Get-VirtualDirectory cmdlets take longer than expected (about 15 minutes) to complete in an Exchange Server environment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Virtual Directories configuration
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
---
# Get-VirtualDirectory cmdlets take a long time to run in Exchange Server

_Original KB number:_ &nbsp; 2896472

## Symptoms

In an Exchange Server environment, you run one of the following cmdlets to obtain the properties of a virtual directory for a server in another site that's connected over a wide area network (WAN):

- Get-WebServicesVirtualDirectory
- Get-OwaVirtualDirectory
- Get-ActiveSyncVirtualDirectory
- Get-AutodiscoverVirtualDirectory
- Get-EcpVirtualDirectory
- Get-PowerShellVirtualDirectory
- Get-OABvirtualDirectory

However, the cmdlet takes much longer than expected to run (about 15 minutes).

## Cause

This issue occurs because the cmdlet makes calls to the Internet Information Services (IIS) metabase for the properties of the virtual directory.

## Workaround

To work around this issue, use the `AdPropertiesOnly` switch with the cmdlet in the calls to the IIS metabase.

Example 1

```powershell
Get-OwaVirtualDirectory -Server Contoso -AdpropertiesOnly
```

Example 2

```powershell
Get-OwaVirtualDirectory -Identity "Contoso\owa (default Web site)" -AdpropertiesOnly
```

The `ADPropertiesOnly` switch specifies that only the virtual directory properties that are stored in Active Directory Domain Services (AD DS) are returned.

For more information about `ADPropertiesOnly` switch, see [Get-OwaVirtualDirectory](/powershell/module/exchange/get-owavirtualdirectory).
