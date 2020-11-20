---
title: Active Directory operation failed on DomainController error
description: Describes an issue in which you receive an Active Directory operation failed on <DomainController>.<Domain>.com. The object <DistinguishedName> does not exist error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Active Directory operation failed on DomainController error when you run Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067609

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft Office 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive an **Active Directory operation failed on \<DomainController>.\<Domain>.com. The object \<DistinguishedName> does not exist** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Configure Mail FlowExecution of the Set-ReceiveConnector cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings. Active Directory operation failed on <**DomainController**>.contoso.com. The object 'CN=Inbound from Office 365,CN=SMTP Receive Connectors,CN=Protocols,CN' does not exist.
 at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)

## Resolution

Wait 20 minutes, and then rerun the Hybrid Configuration wizard. If the issue persists, contact [Microsoft Support](https://support.microsoft.com/contactus/), and reference this article.

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
