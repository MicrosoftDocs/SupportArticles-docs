---
title: State of runspace is not valid for this operation error
description: Describes an issue in which you receive a State of runspace is not valid for this operation error when you run the Hybrid Configuration wizard.
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
# (State of runspace is not valid for this operation) error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067613

## Symptoms

You want to set up a hybrid deployment between your on-premises Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully. You receive a **State of runspace is not valid for this operation** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Creating Organization Relationships.
>
> Execution of the Get-FederatedOrganizationIdentifier cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> State of runspace is not valid for this operation.
>
> Cannot perform operation because the runspace pool is not in the 'Opened' state. The current state is 'Broken'.  
at System.Management.Automation.Runspaces.Internal.RunspacePoolInternal.AssertPoolIsOpen  
at System.Management.Automation.Runspaces.RunspacePool.AssertPoolIsOpen  
at System.Management.Automation.PowerShell.CoreInvokeAsync[TInput,TOutput](PSDataCollection\`1 input, PSDataCollection\`1 output, PSInvocationSettings settings, AsyncCallback callback, Object state, PSDataCollection\`1 asyncResultOutput)

## Resolution

Follow the steps in the Solution section of this article ["Exception has been thrown by the target" error in a hybrid deployment of Microsoft 365 and your on-premises environment](https://support.microsoft.com/help/2626696).

If the problem persists, contact [Microsoft Support](https://support.microsoft.com/contactus/) and reference this article.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
