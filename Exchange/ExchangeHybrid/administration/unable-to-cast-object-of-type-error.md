---
title: Unable to cast object of type error if connecting to domain
description: Describe an error that occurs when you try to connect to a Microsoft 365 domain. Occurs when you use the Exchange Management Console on an on-premises hybrid server that's running Exchange 2010 SP1 or Exchange 2010 SP2 in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Unable to cast object of type error when connecting to Microsoft 365 domain from on-premises hybrid server

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 2875125

## Symptoms

You have a hybrid deployment of an on-premises Microsoft Exchange server and Exchange Online in Microsoft 365. You try to connect to the Microsoft 365 cloud-based domain by using the Exchange Management Console on the on-premises hybrid server. However, the connection fails, and you receive the following error message:

> Unable to cast object of type 'system.Runtime.Serialization.TypeLoadExceptionHolder' to type 'Microsoft.Exchange.Data.RoleEntry'

## Cause

This issue occurs if you're trying to connect to Microsoft 365 from an on-premises hybrid server that's running Exchange Server 2010 Service Pack 1 (SP1) or Exchange Server 2010 Service Pack 2 (SP2).

## Resolution

Upgrade your Exchange Server 2010 servers to Exchange Server 2010 Service Pack 3 (SP3). To download Exchange Server 2010 SP3, go to [Microsoft Exchange Server 2010 Service Pack 3 (SP3)](https://www.microsoft.com/download/details.aspx?id=36768).

## More information

This issue is generally seen when Exchange 2010 servers are in a hybrid configuration with an earlier release of Microsoft 365, and then Microsoft 365 is upgraded to the current release. For an Exchange 2010-based hybrid deployment with the current release of Microsoft 365, all on-premises Exchange 2010 servers must be running Exchange 2010 SP3 or a later version.

For more information about how to set up a hybrid deployment with on-premises Exchange 2010 servers and the latest release of Microsoft 365, see [Hybrid deployment prerequisites](/exchange/hybrid-deployment-prerequisites).

For more information about Exchange 2010 SP3, see [Description of Exchange Server 2010 SP3](https://support.microsoft.com/help/2808208).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
