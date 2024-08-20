---
title: Can't run the Hybrid Configuration wizard
description: Fixes an error message that you receive when you try to run the Hybrid Configuration wizard to set up a hybrid deployment between your on-premises Exchange Server environment and Exchange Online in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Subtask CheckPrereqs execution failed error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 2772596

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you run the Hybrid Configuration wizard to set up a hybrid deployment between your on-premises Microsoft Exchange Server environment and Microsoft Exchange Online in Microsoft 365, you receive the following error message:

> Update-HybridConfiguration  
> Failed  
> Error:  
> Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites  
> "" isn't a valid SMTP domain.  
> at Microsoft.Exchange.Data.SmtpDomainWithSubdomains..ctor(String s, Boolean includeSubdomains)  
> at Microsoft.Exchange.Management.Hybrid.GlobalPrereqTask.IsValidCert(String exchangeServerName)  
> at Microsoft.Exchange.Management.Hybrid.GlobalPrereqTask.CheckPrereqs(ITaskContext taskContext)  
> at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(TaskBase taskBase, TaskContext taskContext)

Additionally, when you view the Hybrid Configuration wizard log file, you receive the following error message:

> [*Date Time*] INFO:Running command: Get-ExchangeCertificate -Server 'EARTH-MPLS-EXC1'[*Date Time*] INFO:Cmdlet: Get-ExchangeCertificate --Start Time: 5/24/2012 1:55:50 PM.  
> [*Date Time*] INFO:Cmdlet: Get-ExchangeCertificate --End Time: 5/24/2012 1:55:50 PM.  
> [*Date Time*] INFO:Cmdlet: Get-ExchangeCertificate --Processing Time: 405.6052.  
> [*Date Time*] INFO:Disconnected from On-Premises session  
> [*Date Time*] INFO:Disconnected from Tenant session  
> [*Date Time*] ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites  
> "" isn't a valid SMTP domain.  
> at Microsoft.Exchange.Data.SmtpDomainWithSubdomains..ctor(String s, Boolean includeSubdomains)  
> at Microsoft.Exchange.Management.Hybrid.GlobalPrereqTask.IsValidCert(String exchangeServerName)  
> at Microsoft.Exchange.Management.Hybrid.GlobalPrereqTask.CheckPrereqs(ITaskContext taskContext)  
> at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(TaskBase taskBase, TaskContext taskContext)

This issue occurs if a certificate that's installed on the hybrid server that's running Microsoft Exchange Server 2010 is missing a subject name. The certificate is validated by the hybrid server even if it's not used for hybrid mail flow.

## Solution

Remove the invalid certificate from the hybrid server. After the invalid certificate is removed, the wizard should successfully complete the process.

## More information

For more information about how to manage certificates in Exchange Server 2010, go to the following Microsoft websites:

- [Remove-ExchangeCertificate](/powershell/module/exchange/remove-exchangecertificate)
- [Managing SSL for a Client Access Server](/previous-versions/office/exchange-server-2010/bb310795(v=exchg.141))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
