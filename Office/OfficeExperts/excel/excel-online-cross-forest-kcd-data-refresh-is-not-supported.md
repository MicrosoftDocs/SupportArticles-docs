---
title: Excel Online cross forest KCD data refresh is not supported
description: Excel Online cross forest KCD data refresh fails with the error "The data connection uses Windows Authentication and user credentials could not be delegated."
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: o365-solutions
ms.topic: article
ms.author: randring
appliesto:
- Excel Online
---

# Excel Online cross forest KCD data refresh is not supported

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

## Symptoms

Consider the following scenario:

- You configure Microsoft Office Online Server with SharePoint 2013 or SharePoint 2016.
- You have configured Kerberos Constrained Delegation (KCD) to a data warehouse to pull business intelligence data for users.
- You have two Active Directory domains in separate forests in a two-way transitive trust configuration (for example, *DomainA* in forest 1 and *DomainB* in forest 2).
- The SharePoint farm, data source and Office Online Server sit in *DomainA*. However, only a specific set of users is located in *DomainB*. Users have no issues logging into the site and interacting with SharePoint.

In this scenario, users who sit in *DomainA* configure Excel workbooks and load them into SharePoint, display them in the browser and refresh without any issues. However, when users from *DomainB* come over to the SharePoint site and try to refresh the same workbooks, they receive the following error message:

**The data connection uses Windows Authentication and user credentials could not be delegated. The following connections failed to refresh: XXXXXXXX**

## Cause

The first assumption is that there is an issue communicating between domains because we have proven that the KCD is functional. You may have also found that this worked (or still works) with Excel Services in SharePoint 2013. You will find (through multiple means) that you can query users from the trusted domain without issues. All diagnosis and troubleshooting efforts show that communication seems to be correct.

If you dig deeper into this issue and pull Office Online Server logs, you will see the following chain in this scenario:

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services 6k5r Verbose CredentialsProvider.GetCredentials: **Getting credentials for external source: EXAMPLEDATASOURCE, with CredentialsMethod Integrated**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a2pb1 Verbose CredentialsProvider.TranslateSid: **Trying to translate SID: s-1-0-00-000000000-0000000000-0000000000-0000**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a2pb2 Verbose CredentialsProvider.TranslateSid: **Searching domain: DomainA.lab**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a2pb2 Verbose CredentialsProvider.TranslateSid: **Searching domain: DomainA.lab**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a2pb4 Medium CredentialsProvider.TranslateSid: **SID not found on any domain**


**The above process causes the following:**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a1tj8 Medium CredentialsProvider.**TranslateSidToUpn translation** elapsed 285 ms

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services a1tj0 Verbose CredentialsDelegation.UpnLogon: **upn is null (ok on DataCenter)**


**Therefore, the Windows Identity Translation fails:**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services c9la Medium CredentialsProvider.GetCredentials: **Failed to get WindowsIdentity**

*Timestamp* w3wp.exe (0x4D94) 0x193C Services Infrastructure Logging ai2vt Verbose An event was fired: id: NoIntegratedConnectionsAllowed, eventId: 5252, eventType: Warning, eventMessage: **Credential delegation failed because Excel Services Application was unable to obtain a Windows Identity.  [Session: TRUNCATED User: i:0#.w|domainb\user1]**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services oyyh Verbose CredentialsProvider.ProcessCancel: **Processing cancel of the credentials for external source with data connection name: EXAMPLEDATASOURCE**

*Timestamp* w3wp.exe (0x4D94) 0x193C Excel Online Excel Calculation Services ajhkx Medium SessionUser.EnsureCredentialsForExternalData: **Failed to get credentials. User=i:0#.w|domainb\user1, ConnectionIndex=0**

You will also notice that there are no calls to the other forest from Office Online Server in network traces (at least in relation to this stack).

## Workaround

To perform any data refresh action, Office Online Server requires the Windows Identity of the user that is collected by the Claims to Windows Token Service. You will notice in the logs above that Office Online Server doesn't even try to query DomainB. This is a product limitation. Currently, Office Online Server only tries to query domains located within the same forest as itself.

To work around this issue, use the following methods:

- From the domain level, you can move both domains into the same forest.
- From the Excel Online level, you can refresh data by using the Secure Store instead of the Authenticated Users account. This effectively bypasses the need for Office Online Server to retrieve user credentials from the other domain.

> [!NOTE]
> This article is specific to Office Online Server on-premises and does not reflect on or speak to the capabilities of Office Online, Office 365 or SharePoint Online.