---
title: Exchange Online Hybrid Free/Busy Diagnostic
description: Describes the data that's collected by the Exchange Online Free/Busy Diagnostic.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: farshadt, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Online Hybrid Free/Busy Diagnostic

The Exchange Online Hybrid Free/Busy Diagnostic package collects Windows PowerShell command results that Microsoft 365 technical support can use to troubleshoot free/busy issues in an Exchange hybrid deployment. The Support Diagnostics Platform (SDP) diagnostic tool uses this diagnostic package to collect relevant information. The SDP should be run on the hybrid server.

This article lists the information that may be collected when this diagnostic package is run.

_Original KB number:_ &nbsp; 2957394

## More information

> [!NOTE]
>
> - This diagnostic package is created specifically for customers who have a hybrid deployment of on-premises Exchange Server and Exchange Online.
> - You have to provide global admin credentials for the Microsoft 365 organization with which you are setting up free/busy.
> - The SDP package asks you for the primary SMTP address of the on-premises users and the Microsoft 365 users whose free/busy data you want to pull.

### Exchange Online-related files

|Description| File name |
|---|---|
|Get-FederatedOrganizationIdentifier cmdlet output|O365_Get-FederatedOrganizationIdentifier.log|
|Get-FederationInformation cmdlet output for specified Domain.|O365_Get-FederationInformation -DomainName \<DomainName>.log|
|Get-OrganizationRelationship cmdlet output|O365_Get-OrganizationRelationship.log|
|Get-SharingPolicy cmdlet output|O365_Get-SharingPolicy.log|

### Hybrid server-related files

|Description|File name|
|---|---|
|AcceptedDomain cmdlet output|\<HYBRIDSERVERNAME>_AcceptedDomain_FL.txt|
|Get-ExchangeServer cmdlet output|\<HYBRIDSERVERNAME>_AllExchangeServers_FL.txt|
|Get-AutodiscoverVirtualDirectory cmdlet output|\<HYBRIDSERVERNAME>_AutodiscoverVirtualDirectory_FL.txt|
|Get-AvailabilityAddressSpace cmdlet output|\<HYBRIDSERVERNAME>_AvailabilityAddressSpace_FL.txt|
|Get-ClientAccessServer cmdlet output|\<HYBRIDSERVERNAME>_ClientAccessServer_FL.txt|
|Generic OS related output|\<HYBRIDSERVERNAME>_DiscoveryReport.xml|
|Application Event output in csv format|\<HYBRIDSERVERNAME>_evt_Application.csv|
|Application Event output in Evtx format|\<HYBRIDSERVERNAME>_evt_Application.evtx|
|Application Event output in txt format|\<HYBRIDSERVERNAME>_evt_Application.txt|
|System Event output in csv format|\<HYBRIDSERVERNAME>_evt_System.csv|
|System Event output in Evtx format|\<HYBRIDSERVERNAME>_evt_System.evtx|
|System Event output in txt format|\<HYBRIDSERVERNAME>_evt_System.txt|
|Get-ExchangeServer cmdlet output|\<HYBRIDSERVERNAME>_ExchangeServer_FL.txt|
|Get-FederatedOrganizationIdentifier cmdlet output|\<HYBRIDSERVERNAME>_FederatedOrganizationIdentifier_FL.txt|
|Get-FederationTrust cmdlet output|\<HYBRIDSERVERNAME>_FederationTrust_FL.txt|
|Get-FederationInformation cmdlet output|\<HYBRIDSERVERNAME>\_Get-FederationInformation_<`onmicrosoft.com` domain name>|
|Get-Mailbox cmdlet output for On-Premise Mailbox|\<HYBRIDSERVERNAME>_OnPremiseMailbox_FL|
|Get-OrganizationRelationship cmdlet output|\<HYBRIDSERVERNAME>_OrganizationRelationship_FL|
|Get-RemoteDomain cmdlet output|\<HYBRIDSERVERNAME>_RemoteDomain_FL|
|Get-RemoteDomain cmdlet output|\<HYBRIDSERVERNAME>_SharingPolicy_FL|
|Test-FederationTrust cmdlet output|\<HYBRIDSERVERNAME>\_Test-FederationTrust_\<On Premise User>|
|Test-FederationTrustCertificate cmdlet output|\<HYBRIDSERVERNAME>_Test-FederationTrustCertificate_FL|
|Test-OrganizationRelationShip cmdlet output|\<HYBRIDSERVERNAME>_Test-OrganizationRelationShip_FL|
|Get-WebServicesVirtualDirectory cmdlet output|\<HYBRIDSERVERNAME>_WebServicesVirtualDirectory_FL|
|IIS log files|W3SVC1LogFiles.cab|
|IIS log files|W3SVC2LogFiles.cab|

### On-premises legacy Exchange-related files

|Description|File name|
|---|---|
|Get-mailbox -arbitration cmdlet output|\<HYBRIDSERVERNAME>_Arbitration Mailbox_FL.TXT|
|Get-PublicFolderClientPermission cmdlet output|\<HYBRIDSERVERNAME>_NON_IPM_SUBTREE_SCHEDULE_FREE_BUSY_FIRST ORGANIZATION_EXTERNAL_FYDIBOHF25SPDLT.log_FL.TXT|
|Get-PublicFolder cmdlet output|\<HYBRIDSERVERNAME>_NON_IPM_SUBTREE_SCHEDULE_FREE BUSY.log_FL|

## References

For more information about Microsoft Automated Troubleshooting Services and about the Support Diagnostics Platform, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).
