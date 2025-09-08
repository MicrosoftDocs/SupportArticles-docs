---
title: Can't set up a hybrid deployment when you run Set-FederatedOrganizationIdentifier cmdlet
description: Describes an issue in which you receive an error when you run Set-FederatedOrganizationIdentifier cmdlet to set up a hybrid deployment.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - CSSTroubleshoot
appliesto: 
- Exchange Online 
- Exchange Server 2013 Enterprise 
- Exchange Server 2013 Standard Edition 
- Exchange Server 2010 Enterprise 
- Exchange Server 2010 Standard
search.appverid: MET150
ms.reviewer: scotro, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# "InternalError InternalError: Internal error" when you run Set-FederatedOrganizationIdentifier to set up a hybrid deployment

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [Microsoft.Online.CSE.Hybrid.Client](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

You want to set up a hybrid deployment between your on-premises Exchange Server organization and an external federated organization. However, when you run the Set-FederatedOrganizationIdentifier cmdlet, the operation isn't successful, and you receive an "InternalError InternalError: Internal error" error message. The full text of the message resembles the following:

> ERROR: Updating hybrid configuration failed with error 'Subtask Configure execution failed: Creating Organization Relationships.  
>
> Execution of the Set-FederatedOrganizationIdentifier cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information "An unexpected result was received from Windows Live. Detailed information: "InternalError InternalError: Internal error.".".
at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)'.

## Cause

This problem occurs if the domain name for your organization was previously in use and you try to reconfigure the domain. A domain name may be blocked in Windows Live for the Microsoft Entra authentication system if the domain name was previously used.

## Resolution

To resolve this problem, contact [Microsoft Support](https://support.microsoft.com/), and reference this Knowledge Base article.

## More information

See [Set-FederatedOrganizationIdentifier](/powershell/module/exchange/set-federatedorganizationidentifier) for more information.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
