---
title: HCW8091 error when running Hybrid Configuration Wizard
description: Describes an issue in which you receive an HCW8091 error message when you run the Hybrid Configuration Wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# HCW8091 error when you run the Hybrid Configuration Wizard

> [!NOTE]
> The Hybrid Configuration Wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration Wizard. Instead, use the Office 365 Hybrid Configuration Wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 3185379

## Symptoms

When you run the Hybrid Configuration Wizard, you receive the following error message:

> HCW8091 = WinRM service is not enabled

## Cause

This problem occurs if a required service isn't running on the server that's running Exchange Server to complete the underlying PowerShell session.

## Resolution

To resolve this issue, follow these steps:

1. On the server that's running Exchange Server, select **Start**, select **Run**, type *Services.msc*, and then press Enter.
2. In the list of services, look for the Windows Remote Management service, and then make sure that it's running.
3. Run the Hybrid Configuration Wizard again from [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
