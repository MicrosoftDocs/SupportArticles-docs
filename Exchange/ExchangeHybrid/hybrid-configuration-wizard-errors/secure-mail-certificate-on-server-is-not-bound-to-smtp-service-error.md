---
title: Secure Mail Certificate on server is not bound error
description: Describes an issue that occurs if the SMTP service is not bound to the correct certificate. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
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
# Secure Mail Certificate on server is not bound to the SMTP Service error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3058190

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following error message:

> [\<Date>\<Time>] ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Configure Mail Flow
>
> The Secure Mail Certificate on server \<Server\> is not bound to the SMTP Service at Microsoft.Exchange.Management.Hybrid.MailFlowTask.CheckCertPrereqs

## Cause

The Simple Mail Transfer Protocol (SMTP) service is not bound to the correct certificate.

## Resolution

Use the `Enable-ExchangeCertificate` cmdlet to bind the certificate to the SMTP service.

For more information about this cmdlet, see [Enable-ExchangeCertificate](/powershell/module/exchange/enable-exchangecertificate?view=exchange-ps&preserve-view=true).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
