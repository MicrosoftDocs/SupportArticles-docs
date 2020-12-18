---
title: The user name or password is incorrect error
description: Discusses an issue in which you receive a Connecting to the remote server failed error message when you run the Hybrid Configuration wizard. Provides a solution.
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
search.appverid: MET150
---
# (The user name or password is incorrect) error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067290

## Symptoms

When you run the Hybrid Configuration wizard, you receive a **Connecting to remote server failed with the following error message : The user name or password is incorrect** error message. The full text of this message resembles the following:

> INFO:Opening runspace to `http://<Exchange Server Name>/powershell?serializationLevel=Full`  
INFO:Disconnected from On-Premises session  
ERROR:Updating hybrid configuration failed with error  
'System.Management.Automation.Remoting.PSRemotingTransportException: Connecting to remote server failed with the following error message : The user name or password is incorrect. For more information, see the about_Remote_Troubleshooting Help topic.  
 at System.Management.Automation.Runspaces.AsyncResult.EndInvoke()  
 at System.Management.Automation.Runspaces.Internal.RunspacePoolInternal.EndOpen(IAsyncResult asyncResult)  
 at System.Management.Automation.Runspaces.RunspacePool.Open()  
 at System.Management.Automation.RemoteRunspace.Open()  
 at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.Connect(PSCredential credentials, CultureInfo sessionUiCulture)  
 at Microsoft.Exchange.Management.Hybrid.Engine.Execute(ILogger logger, String onPremPowershellHost, PSCredential onPremCredentials, PSCredential tenantCredentials, HybridConfiguration hybridConfiguration)  
 at Microsoft.Exchange.Management.SystemConfigurationTasks.UpdateHybridConfiguration.InternalProcessRecord()'.

## Cause

This problem occurs if the credentials that were entered to connect to the on-premises organization are incorrect.

## Resolution

Rerun the Hybrid Configuration wizard, and make sure that you enter the correct credentials for the Microsoft Office 365 admin account and for the on-premises admin account. The wizard checks that the accounts have the appropriate credentials and can connect to the Microsoft Exchange Online and on-premises organizations.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
