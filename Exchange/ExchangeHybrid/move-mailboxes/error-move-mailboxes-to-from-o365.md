---
title: Error when you move mailboxes to/from Office 365
description: Discusses an issue in which you receive an error message when you try to move mailboxes to or from Office 365 in a hybrid deployment after you upgrade the on-premises environment to Exchange Server 2010 SP2. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
ms.custom: CSSTroubleshoot
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
appliesto:
- Office Products
- Exchange Online
- Exchange Server 2010 Standard
- Exchange Server 2010 Enterprise
---

# Error message when you try to move mailboxes to or from Office 365 in a hybrid deployment: "Exception has been thrown by the target"

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Problem

You have a hybrid deployment of Microsoft Exchange Online in Microsoft Office 365 and your on-premises Microsoft Exchange Server environment. When you try to move mailboxes to or from Office 365, you receive the following error message:

"Exception has been thrown by the target of an invocation."

You were previously able to successfully move mailboxes to or from Office 365 and your on-premises Exchange Server environment. You experience this symptom only after you upgrade the on-premises environment from Exchange Server 2010 Service Pack 1 (SP1) to Exchange Server 2010 Service Pack 2 (SP2) or later. 

## Cause

This issue occurs if the Web.config file was overwritten during the upgrade from Exchange Server 2010 Service SP1 to Exchange Server 2010 SP2 or later. Remote mailbox moves require the Mailbox Replication Proxy (MRSProxy) service endpoint to be enabled on the Client Access server. In Exchange Server 2010 SP1 and Exchange Server 2010, the MRSProxy setting is configured in the Web.config file.

In Exchange Server 2010 SP2 or later, the MRSProxy settings are stored in Active Directory and are configured by using the Set-WebServicesVirtualDirectoryWindows PowerShell cmdlet.

**Note** There are several possible causes of this error message. This article discusses one scenario that may cause this error message. 

## Solution

Use the Set-WebServicesVirtualDirectory cmdlet to re-enable MRSProxy on every Client Access server in the on-premises environment through which you want to let remote move requests pass. To do this, follow these steps:

1. Open the Exchange Management Shell.   
2. Make sure that the MRSProxyEnabled parameter on the server is set to false. 

   To do this, run the following cmdlet:

   Get-WebServicesVirtualDirectory-Identity "Server\EWS(default Web site)"   
3. Enable the MRSProxy service. To do this, run the following cmdlet:

   Set-WebServicesVirtualDirectory-Identity "Server\EWS(default Web site)" –MRSProxyEnabled $true    

## More information

After you enable MRSProxy on the servers, you may have to correctly publish the endpoint through your firewall. For more information about how to do this, see the following article: 

[Configure Forefront TMG for a hybrid environment](https://docs.microsoft.com/SharePoint/hybrid/configure-forefront-tmg-for-a-hybrid-environment#config) 

For more information about how to troubleshoot the error message that is mentioned in the "Symptoms" section, see the following Microsoft Knowledge Base article: 

[2626696 ](https://support.microsoft.com/help/2626696) "Exception has been thrown by the target" error in a hybrid deployment of Office 365 and your on-premises environment 

If you experience issues when you move mailboxes to Exchange Online in Office 365, you can run the Troubleshoot Office 365 Mailbox Migration tool. This diagnostic is an automated troubleshooting tool. If you're experiencing a known issue, you receive a message that states what went wrong. The message includes a link to an article that contains the solution. Currently, the tool is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).