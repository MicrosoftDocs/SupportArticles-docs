---
title: Can't set up an organization relationship
description: Fixes an issue in which you receive a Creating Organization Relationships error message when you run the Get-FederatedInformation cmdlet to set up an organization relationship.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: zoltanh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Creating Organization Relationships error when you run the Get-FederatedInformation cmdlet

_Original KB number:_ &nbsp; 3070271

## Problem

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and an external federated organization. However, when you run the `Get-FederatedInformation` cmdlet, the operation isn't successful, and you receive a "Creating Organization Relationships" error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Creating Organization Relationships.  
> Execution of the Get-FederationInformation cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> Operation is not valid due to the current state of the object.  
> at System.Management.Automation.PowerShell.CoreInvoke[TOutput](IEnumerable input, PSDataCollection\`1 output, PSInvocationSettings settings)  
> at System.Management.Automation.PowerShell.Invoke(IEnumerable input, PSInvocationSettings settings)  
> at System.Management.Automation.PowerShell.Invoke()  
> at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary\`2 parameters, Boolean ignoreNotFoundErrors)'.

## Cause

This issue can occur if one or more of the following conditions are true:

- Autodiscover, Exchange Web Services (EWS), or both are published in Microsoft Forefront Unified Access Gateway (UAG), and single sign-on (SSO) is enabled.
- The `FullAuthPassthru` registry value on the Forefront UAG server isn't set to **1**.
- The `KeepClientAuthHeader` registry value on the Forefront UAG server isn't set to **1**.

## Solution

To resolve the issue, follow these steps:

1. In the Forefront UAG Management console, open the properties of the Exchange Web Services application, select the **Authentication** tab, and then clear the **Use SSO** check box.
2. On the Forefront UAG servers, create the following DWORD values in the registry (if they don't already exist), and then set each value to **1**.
   - `HKEY_LOCAL_MACHINE\SOFTWARE\WhaleCom\e-Gap\von\UrlFilter\FullAuthPassthru`
   - `HKEY_LOCAL_MACHINE\SOFTWARE\WhaleCom\e-Gap\von\UrlFilter\KeepClientAuthHeader`
3. In the Forefront UAG Management console, click **Activate** to enable the Forefront UAG configuration.

## More information

For more information about how to publish Outlook Anywhere on a Forefront UAG portal, see [Publishing Outlook Anywhere on a Forefront UAG portal](/previous-versions/tn-archive/ee921429(v=technet.10)).

For more information about Forefront UAG registry keys, see [Forefront UAG registry keys](/previous-versions/tn-archive/ee809087(v=technet.10)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
