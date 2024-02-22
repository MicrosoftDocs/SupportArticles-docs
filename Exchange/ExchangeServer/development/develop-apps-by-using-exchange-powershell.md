---
title: Develop apps via Exchange PowerShell and .NET Framework
description: Describes the recommended and supported methods for developing applications that automate Exchange 2010 cmdlets by using any of the Microsoft .NET Framework languages.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dvespa, v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# Developing apps by using Exchange 2010 PowerShell and the .NET Framework

_Original KB number:_ &nbsp; 2827611

Assume that you want to use any Microsoft .NET language to develop applications that automate Microsoft Exchange Server 2010 cmdlets. Remote PowerShell is the supported and recommended method for doing this.

## More information

Microsoft does not support manually loading the Exchange PowerShell snap-in by using the `RunspaceConfiguration.AddPSSnapIn()` API. The Exchange PowerShell snap-in is the supported method for building applications in Exchange Server 2007. However, this method is not supported or recommended for use with Exchange Server 2010 cmdlets.

For more information, see:

- [Exchange Management Shell concepts](/previous-versions/office/developer/exchange-server-2010/ff326156(v=exchg.140))
- [Calling Exchange Management Shell cmdlets from managed code](/previous-versions/office/developer/exchange-server-2010/ff326159(v=exchg.140))
