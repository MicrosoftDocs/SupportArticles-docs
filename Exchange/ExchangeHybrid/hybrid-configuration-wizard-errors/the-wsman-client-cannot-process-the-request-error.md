---
title: The WSMan client cannot process the request error
description: Describes that you receive a The WSMan client cannot process the request. Proxy is not supported under HTTP transport error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# (The WSMan client cannot process the request) error when you run Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067680

## Symptoms

When you run the Hybrid Configuration wizard, you receive a **The WSMan client cannot process the request. Proxy is not supported under HTTP transport** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error  
'System.Management.Automation.Remoting.PSRemotingTransportException: Connecting to remote server failed with the following error message: The WSMan client cannot process the request. Proxy is not supported under HTTP transport. Change the transport to HTTPS and specify valid proxy information and try again. For more information, see the about_Remote_Troubleshooting Help topic.  
at System.Management.Automation.Runspaces.AsyncResult.EndInvoke()  
at System.Management.Automation.Runspaces.Internal.RunspacePoolInternal.EndOpen(IAsyncResult asyncResult)  
at System.Management.Automation.Runspaces.RunspacePool.Open()  
at System.Management.Automation.RemoteRunspace.Open()  
at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.Connect(PSCredential credentials, CultureInfo sessionUiCulture)  
at Microsoft.Exchange.Management.Hybrid.Engine.Execute(ILogger logger, String onPremPowershellHost, PSCredential onPremCredentials, PSCredential tenantCredentials, HybridConfiguration hybridConfiguration)  
at Microsoft.Exchange.Management.SystemConfigurationTasks.UpdateHybridConfiguration.InternalProcessRecord()'.

## Resolution

Contact [Microsoft Support](https://support.microsoft.com/contactus/) and reference this article.

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
