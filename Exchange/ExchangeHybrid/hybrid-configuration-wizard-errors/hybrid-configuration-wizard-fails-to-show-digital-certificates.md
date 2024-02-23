---
title: Hybrid Configuration Wizard cannot show digital certificate
description: Describes an issue in which digital certificates are missing from the Hybrid Configuration Wizard. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: shahmul, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Hybrid Configuration Wizard fails to display digital certificates during hybrid deployment setup

_Original KB number:_ &nbsp; 2964920

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

You run the Hybrid Configuration Wizard to set up a hybrid deployment between your on-premises Microsoft Exchange Server environment and Exchange Online in Microsoft 365. However, you cannot select a digital certificate because the drop-down list in the wizard is empty.

Additionally, when you try to continue, you receive the following error message:

> No valid certificate exists for the Hub Transport server(s).

## Cause

This issue occurs if the Microsoft Exchange Service Host service on the hybrid server has stopped running.

## Resolution

Start the Microsoft Exchange Service Host service on the hybrid server. To do this, follow these steps:

1. Select **Start**, select **Run**, type *services.msc*, and then select **OK**.
2. In the list of services, right-click **Microsoft Exchange Service Host**, and then select **Start**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
