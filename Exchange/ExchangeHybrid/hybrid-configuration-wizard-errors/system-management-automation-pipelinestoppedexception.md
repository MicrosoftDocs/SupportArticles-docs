---
title: The pipeline has been stopped error
description: Describes that you receive a System.Management.Automation.PipelineStoppedException pipeline has been stopped error when you run the Hybrid Configuration wizard.
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
# The pipeline has been stopped error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067998

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Office 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully. You receive a **System.Management.Automation.PipelineStoppedException: The pipeline has been stopped** error message. The full text of the message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'System.Management.Automation.PipelineStoppedException: The pipeline has been stopped.  
at System.Management.Automation.MshCommandRuntime.WriteProgress(ProgressRecord progressRecord)  
at System.Management.Automation.Cmdlet.WriteProgress(ProgressRecord progressRecord)  
at Microsoft.Exchange.Configuration.Tasks.Task.WriteProgress(LocalizedString activity, LocalizedString statusDescription, Int32 percentCompleted)  
at Microsoft.Exchange.Management.Hybrid.Engine.Execute(ILogger logger, String onPremPowershellHost, PSCredential onPremCredentials, PSCredential tenantCredentials, HybridConfiguration hybridConfiguration)  
at Microsoft.Exchange.Management.SystemConfigurationTasks.UpdateHybridConfiguration.InternalProcessRecord()'.

## Resolution

Contact [Microsoft Support](https://support.microsoft.com/contactus/), and reference this article.

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
