---
title: The pipeline has been stopped error
description: Describes that you receive a System.Management.Automation.PipelineStoppedException pipeline has been stopped error when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# The pipeline has been stopped error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067998

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully. You receive a **System.Management.Automation.PipelineStoppedException: The pipeline has been stopped** error message. The full text of the message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'System.Management.Automation.PipelineStoppedException: The pipeline has been stopped.  
at System.Management.Automation.MshCommandRuntime.WriteProgress(ProgressRecord progressRecord)  
at System.Management.Automation.Cmdlet.WriteProgress(ProgressRecord progressRecord)  
at Microsoft.Exchange.Configuration.Tasks.Task.WriteProgress(LocalizedString activity, LocalizedString statusDescription, Int32 percentCompleted)  
at Microsoft.Exchange.Management.Hybrid.Engine.Execute(ILogger logger, String onPremPowershellHost, PSCredential onPremCredentials, PSCredential tenantCredentials, HybridConfiguration hybridConfiguration)  
at Microsoft.Exchange.Management.SystemConfigurationTasks.UpdateHybridConfiguration.InternalProcessRecord()'.

## Resolution

Contact [Microsoft Support](https://support.microsoft.com/contactus/), and reference this article.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
