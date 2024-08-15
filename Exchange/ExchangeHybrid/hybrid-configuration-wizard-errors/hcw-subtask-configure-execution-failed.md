---
title: Subtask Configure execution failed in HCW
description: Provides a workaround for an issue that triggers an error when you run the Hybrid Configuration Wizard in Exchange Server 2013 after you upgrade from Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Subtask Configure execution failed when you run the Hybrid Configuration Wizard in Exchange 2013

_Original KB number:_ &nbsp; 2967914

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you run the Hybrid Configuration Wizard in Microsoft Exchange Server 2013, you receive the following error message:

> Updating hybrid configuration failed with error ‎'Subtask Configure execution failed: Upgrading hybrid configuration from Exchange 2010... Object reference not set to an instance of an object. at Microsoft.Exchange.Management.Hybrid.UpgradeConfigurationFrom14Task.UpgradeFopeConnectors‎(ITaskContext taskContext)‎ at Microsoft.Exchange.Management.Hybrid.UpgradeConfigurationFrom14Task.Configure‎(ITaskContext taskContext)‎ at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteSubStep‎(String subStepName, ITaskContext taskContext, ITask task, Func\`3 substep, Func\`4 createException, Boolean throwOnFalse)‎ ‎'.

## Cause

This issue occurs if you have an Exchange hybrid deployment that was configured through the Hybrid Configuration Wizard in Microsoft Exchange Server 2010, and then you later upgrade the server to Exchange Server 2013. A change was introduced to the Hybrid Configuration Wizard in Exchange Server 2013 that triggers this issue.

## Resolution

To resolve this issue, follow these steps:

1. Install the latest cumulative update for Exchange Server 2013. To download this update, go to [Updates for Exchange 2013](/exchange/updates-for-exchange-2013-exchange-2013-help).
2. Run the latest version of the [Hybrid Configuration wizard](https://aka.ms/hybridwizard).

## More information

For more information about the benefits of the latest Hybrid Configuration wizard, see [Introducing the Microsoft 365 Hybrid Configuration Wizard](https://techcommunity.microsoft.com/t5/exchange-team-blog/introducing-the-microsoft-office-365-hybrid-configuration-wizard/ba-p/604207).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
