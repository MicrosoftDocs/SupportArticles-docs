---
title: Nullable object must have a value
description: Provides a workaround for an issue in which you receive a "Nullable object must have a value" error message when you run the Hybrid Configuration wizard.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer:
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Service Pack 3
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# Nullable object must have a value when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3034991

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Office 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you run the Hybrid Configuration wizard, you receive the following error message when mail flow is being set up between your on-premises environment and Exchange Online:

> Update-HybridConfiguration  
> Failed
>
> Error:  
>
> Updating hybrid configuration failed with error 'Subtask NeedsConfiguration execution failed: Configure Mail Flow  
> Nullable object must have a value.  
> at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)  
> at Microsoft.Exchange.Management.Hybrid.MailFlowTask.ValidateRemoteDomain(DomainContentConfig remoteDomain, Boolean inbound, Boolean OnPrem, Boolean enableSecureMail)  
> at Microsoft.Exchange.Management.Hybrid.MailFlowTask.RemoteDomainsNeedConfiguration(Boolean OnPrem, ITaskContext taskContext, Boolean enableSecureMail, List\`1 changedDomains, List\`1 addedDomains, List`1 removedDomains)  
> at Microsoft.Exchange.Management.Hybrid.MailFlowTask.CheckOrVeifyConfiguration(ITaskContext taskContext, Boolean fVerifyOnly)  
> at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(ITask taskBase, ITaskContext taskContext)

## Cause

A remote domain that's configured in the on-premises environment has an unexpected value that causes the Hybrid Configuration wizard to fail.

## Workaround

To work around this issue, follow these steps:

1. Identify the domains that are causing the problem. To do this, run the following command in the Exchange Management Shell:

    ```powershell
    Get-RemoteDomain | where{$_.TNEFEnabled -eq $null}
    ```

    The domains that contain the unexpected value are listed in the output.
2. Set the value of the `TNEFEnabled` parameter to **true** for each domain that you identified in step 1.

    For example, to set this value for all the domains from step 1, run the following command:

    ```powershell
    Get-RemoteDomain | where{$_.TNEFEnabled -eq $null} | Set-RemoteDomain -TNEFEnabled $true
    ```

3. Rerun the Hybrid Configuration wizard.
4. After the wizard has completed successfully, revert the value of the `TNEFEnabled` parameter on the domains that you changed in step 2. To do this, run the following command:

    ```powershell
    Set-RemoteDomain "name" -TNEFEnabled $null
    ```

## More information

The Hybrid Configuration wizard is expecting the value of the `TNEFEnabled` parameter to be either **true** or **false**. However, in some cases, the value can be null. For more information, see [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
