---
title: Federation certificate with the thumbprint cannot be found
description: Provides a workaround to resolve the error (Federation certificate with the thumbprint cannot be found) that occurs when you make changes to federation trust.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: brenle, jmartin, v-six, v-kccross
ms.custom: 
  - sap:Plan and Deploy\Need help to deploy Oauth, HMA, ADFS
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11513
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 04/26/2026
---
# Error when you make changes to federation trust: Federation certificate with the thumbprint cannot be found

_Original KB number:_ &nbsp; 3215261

## Summary

This issue can occur after an Exchange server is recovered by using the Setup /m:RecoverServer option. In this state, Exchange still references a federation trust certificate that is no longer available, which causes federation management tasks to fail. This article describes how to remove the stale federation trust configuration and recreate the trust.

## Symptoms

Assume that you try to perform the following operations in an Exchange organization:

- Make changes to your federation trust.
- Create a new certificate for your federation trust.
- Use federation services.
- Remove your federated domains or federation trust.

In this situation, you receive an error message that resembles the following:

> Federation certificate with the thumbprint [**certificate thumbprint**] cannot be found.  
> \+ CategoryInfo: InvalidArgument: (:) [Set-FederationTrust], FederationCertificateInvalidException  
> \+ FullyQualifiedErrorId: [Server= **Server Name**,RequestId= **RequestId**,TimeStamp= **Date** **Time**] [FailureCategory=Cmdlet-FederationCertificateInvalidException] D02898C6,Microsoft.Exchange.Management.SystemConfigurationTasks.SetFederationTrust  
> \+ PSComputerName: **ComputerName**

This issue occurs after you recover the only Exchange server in your environment by using the `Setup /m:RecoverServer` option.

## Cause

This issue occurs because the Exchange federation trust certificate (`OrgPrivCertificate`) that's referenced by the Microsoft Exchange federation trust object is missing. However, the federation configuration mistakenly recognizes the certificate as still there. Therefore, any PowerShell cmdlets that edit, manipulate, or use the federation trust to look for this certificate fail.

## Workaround

To work around this issue, use the [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)) to delete the current federation trust and create a new one.

Follow these steps:

1. Open ADSI Edit. Select **Start**, select **Run**, enter *ADSIEdit.msc*, and then select **OK**.

1. Locate `CN=Federation,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Domain,DC=com`, and do the following:
    1. Clear the value of the `msExchFedAccountNamespace` attribute.
    1. Clear the value of the `msExchFedDelegationTrust` attribute.
    1. Set the value of the `msExchFedIsEnabled` attribute to **False**.

1. Locate `CN=Microsoft Federation Gateway,CN=Federation Trusts,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Domain,DC=com`, and remove the federation trust. For example, remove Microsoft Federation Gateway.

1. Locate `CN=Accepted Domains,CN=Transport Settings,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Domain,DC=com`, and clear the value of the `msExchFedAcceptedDomainLink` attribute for each accepted domain name.

1. Recreate the federation trust. For more information, see [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).

## More information

If you have multiple Exchange servers in your environment, export and import the federation certificate from another server.
