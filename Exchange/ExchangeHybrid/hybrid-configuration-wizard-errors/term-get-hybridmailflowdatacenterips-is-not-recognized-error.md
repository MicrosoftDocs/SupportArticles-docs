---
title: Get-HybridMailflowDatacenterIPs isn't recognized error
description: Describes that you receive a Get-HybridMailflowDatacenterIPs is not recognized error message when you run the Hybrid Configuration wizard to set up a hybrid deployment between your on-premises Exchange Server environment and Exchange Online.
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
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# "Get-HybridMailflowDatacenterIPs is not recognized" error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3063646

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

You want to set up a hybrid deployment between your on-premises Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive a **Get-HybridMailflowDatacenterIPs is not recognized** error message. The full text of this message resembles the following example:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Configure Mail Flow
>
> Execution of the Get-HybridMailflowDatacenterIPs cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> The term 'Get-HybridMailflowDatacenterIPs' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
at System.Management.Automation.PowerShell.CoreInvoke[TOutput](IEnumerable input, PSDataCollection\`1 output, PSInvocationSettings settings) at System.Management.Automation.PowerShell.Invoke(IEnumerable input, PSInvocationSettings settings) at System.Management.Automation.PowerShell.Invoke() at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary\`2 parameters, Boolean ignoreNotFoundErrors)'.

## Cause

The Hybrid Configuration wizard depends on the availability of a Microsoft 365 plan in which it can access the Get-HybridMailflowDatacenterIPs cmdlet. The error message indicates that the subscriptions that you currently have can't access this cmdlet.

## Workaround

Add a trial subscription of Office 365 Enterprise E3 to your account. After you add the Office 365 Enterprise E3 plan, the Hybrid Configuration Wizard will complete successfully. To add a trial subscription, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://www.office.com/?auth=2).
2. To open the Microsoft 365 admin center, select **Admin**.
3. In the navigation pane, expand **Billing**, select **Subscriptions**, and then select **New Subscription**.
4. Under **Office 365 Enterprise E3**, select **Trial**, and then follow the steps that are displayed on the screen.

For more help to work around this issue, contact [Microsoft Support](https://support.microsoft.com/contactus/).

## Status

It's a known issue. We're working to address this issue and will post more information in this article when it becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
