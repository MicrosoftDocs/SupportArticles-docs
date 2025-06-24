---
title: The term Get-OrganizationConfig isn't recognized
description: Describes that you receive a Get-OrganizationConfig isn't recognized error when you run the Hybrid Configuration wizard to set up a hybrid deployment between your on-premises Exchange Server environment and Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
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
# (The term Get-OrganizationConfig is not recognized) error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067676

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive a **Get-OrganizationConfig is not recognized** error message. The full text of this message resembles the following example:

> ERROR : Subtask CheckPrereqs execution failed: Check Tenant Prerequisites  
Execution of the Get-OrganizationConfig cmdlet has thrown an exception. This may indicate invalid parameters in your hybrid configuration settings.  
The term 'Get-OrganizationConfig' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.  
at System.Management.Automation.PowerShell.CoreInvokeRemoteHelper[TInput,TOutput](PSDataCollection\`1 input, PSDataCollection\`1 output, PSInvocationSettings settings)  
at System.Management.Automation.PowerShell.CoreInvoke[TInput,TOutput](PSDataCollection\`1 input, PSDataCollection\`1 output, PSInvocationSettings settings)  
at System.Management.Automation.PowerShell.CoreInvoke[TOutput](IEnumerable input, PSDataCollection\`1 output, PSInvocationSettings settings)  
at System.Management.Automation.PowerShell.Invoke(IEnumerable input, PSInvocationSettings settings)  
at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, SessionParameters parameters, Boolean ignoreNotFoundErrors)

## Cause

The Hybrid Configuration wizard depends on the availability of a Microsoft 365 plan that can access the `Get-HybridMailflowDatacenterIPs` cmdlet. The error message indicates that the subscriptions that you currently have can't access this cmdlet.

## Workaround

Add a trial subscription of Office 365 E3 to your account. After you add the Office 365 E3 plan, the Hybrid Configuration wizard will complete successfully. To add a trial subscription, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://www.office.com/?auth=2).
2. Select **Admin** to open the Microsoft 365 admin center.
3. In the navigation pane, expand **Billing**, select **Subscriptions**, and then select **New Subscription**.
4. Under **Office 365 Enterprise E3**, select **Trial**, and then follow the steps that are displayed on the screen.For more help to work around this issue, contact [Microsoft Support](https://support.microsoft.com/contactus/).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
