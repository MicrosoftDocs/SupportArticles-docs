---
title: Subtask Configure execution failed
description: Describes a problem that triggers an error when you run the Hybrid Configuration wizard in Exchange Server. [HCW8006] [HCW8012].
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Execution of the Set-FederatedOrganizationIdentifier cmdlet has thrown an exception when running Hybrid Configuration

_Original KB number:_ &nbsp; 2995731

## Symptoms

When you run the Hybrid Configuration Wizard in Exchange Server to set up a hybrid deployment between your on-premises Exchange organization and Exchange Online, you receive an error message that resembles the following:

> ERROR : Subtask Configure execution failed: Configure Organization Relationship  
Execution of the Set-FederatedOrganizationIdentifier cmdlet has thrown an exception. This may indicate invalid parameters in your hybrid configuration settings. Federation trust "contoso.com/Configuration/Deleted Objects/Microsoft Federation Gateway  
DEL: \<xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx>" wasn't found. Make sure you have typed it correctly.

> [!NOTE]
> The object that's specified in this error message differs from the object in the actual error message that you receive.

## Cause

This problem may occur if stale or obsolete registry entries are present in Active Directory Domain Services (AD DS), and these registry entries point to deleted instances.

For example, this problem may occur if you run the Hybrid Configuration Wizard in Exchange 2013 after an earlier Exchange 2010-based federation trust is removed incompletely or incorrectly.

## Workaround

> [!WARNING]
> This procedure requires Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Remove the federated domain and the federation trust. For more information about how to do this, see the following resources:

   - [Remove-FederatedDomain](/powershell/module/exchange/remove-federateddomain)
   - [Remove a federation trust](/exchange/remove-a-federation-trust-exchange-2013-help)

2. Open ASDI Edit, and then use it to do the following:

   1. Locate **CN=Federation,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Contoso,DC=com**, and then do the following:
      1. Clear the value of the `msExchFedAccountNamespace` attribute.
      2. Clear the value of the `msExchFedDelegationTrust` attribute.
      3. Set the value of the `msExchFedIsEnabled` attribute to **False**.
   2. Locate **CN=Microsoft Federation Gateway,CN=Federation Trusts,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Contoso,DC=com**, and then remove the federation trust, such as **Microsoft Federation Gateway**.
   3. Locate **CN=Accepted Domains,CN=Transport Settings,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Contoso,DC=com**, and then clear the value of the `msExchFedAcceptedDomainLink` attribute for each accepted domain name.

3. Re-create the federation trust. For more information about how do to this, see [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).
4. Run the Hybrid Configuration wizard again.

## More information

For more info about Exchange Server 2013 hybrid deployments, see [Exchange Server hybrid deployments](/exchange/exchange-hybrid).

To troubleshoot hybrid migration issues, see the [Troubleshooting migration issues in Exchange hybrid environment](https://support.microsoft.com/help/10094/troubleshooting-migration-issues-in-exchange-hybrid-environment).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
