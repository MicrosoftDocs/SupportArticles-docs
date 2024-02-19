---
title: Active Directory replication Event ID 1925 attempt to establish a replication link failed due to DNS lookup problem
description: Helps to resolve the issue where you get Event ID 1925 with the error message that DNS lookup failed, inbound replication of a directory partition has failed on the destination domain controller.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication Event ID 1925: attempt to establish a replication link failed due to DNS lookup problem

This article helps to resolve the issue where you get Event ID 1925 with the error message that DNS lookup failed, inbound replication of a directory partition has failed on the destination domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4469659

This problem typically occurs when an attempt to establish a replication link fails as a result of a Domain Name System (DNS) lookup problem. If you receive Event ID 1925 with the error message that DNS lookup failed, inbound replication of a directory partition has failed on the destination domain controller, and you must fix the DNS problem.

The following is an example of the event text:
> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: 3/12/2008 8:14:13 AM  
Event ID: 1925  
Task Category: Knowledge Consistency Checker  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `DC3.contoso.com`  
Description:  
The attempt to establish a replication link for the following writable directory partition failed.  
>
> Directory partition:  
CN=Configuration,DC=contoso,DC=com  
Source directory service: CN=NTDS Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name, CN=Sites,CN=Configuration,DC=contoso,DC=com  
Source domain controller address:  
f8786828-ecf5-4b7d-ad12-8ab60178f7cd._msdcs.contoso.com  
Intersite transport (if any): CN=IP,CN=Inter-Site Transports, CN=Sites,CN=Configuration,DC=constoso,DC=com  
>
> This domain controller will be unable to replicate with the source domain controller until this problem is corrected.  
>
> User Action  
Verify if the source domain controller is accessible or network connectivity is available.  
>
> Additional Data  
Error value:  
8524 The DSA operation is unable to proceed because of a DNS lookup failure.

## Resolution

Proceed with DNS testing as described in "[Active Directory Replication Event ID 2087: DNS lookup failure caused replication to fail](https://support.microsoft.com/help/4469661/active-directory-replication-event-id-2087-dns-lookup-failure-caused-r)."

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
