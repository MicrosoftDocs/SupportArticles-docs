---
title: Software Defined Data Center and Software Defined Networking
description: Software Defined Data Center and Software Defined Networking
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, johnmar
ms.custom: sap:internal-dns-server-for-sdn, csstroubleshoot
---
# Software Defined Data Center and Software Defined Networking in Windows Server

This article provides some information about Software Defined Data Center and Software Defined Networking.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4464776

## Summary

When you try to enable Storage Spaces Direct or you try to add a Windows Server, version 1903, Windows Server, version 1909 or a Windows Server 2019 server to an existing Storage Spaces Direct cluster, the following event is logged in the event log: 
> Event Log: System  
  Event ID: 1809  
  Source: FailoverClustering  
  Description: This node has been joined to a cluster that has Storage Spaces Direct enabled, which is not validated on the current build. The node will be quarantined.  
  Microsoft recommends deploying SDDC on WSSD [https://www.microsoft.com/en-us/cloud-platform/software-defined-datacenter] certified hardware offerings for production environments. The WSSD offerings will be pre-validated on Windows Server 2019 in the coming months. In the meantime, we are making the SDDC bits available early to Windows Server 2019 Insiders to allow for testing and evaluation in preparation for WSSD certified hardware becoming available.  
  Customers interested in upgrading existing WSSD environments to Windows Server 2019 should contact Microsoft for recommendations on how to proceed. Please call Microsoft support [https://support.microsoft.com/en-us/help/4051701/global-customer-service-phone-numbers]. 

When you try to install a Network Controller Cluster by using the **Install-NetworkController** cmdlet, you receive the following error message:  
> NetworkController operation failed  
> - CategoryInfo : InvalidOperation: (:) [Install-NetworkController], CimException  
>- FullyQualifiedErrorId : GenericError,Microsoft.Windows.Networking.NetworkController.PowerShell.InstallNetworkControllerCommand 
>- PSComputerName :server_name 

## More information

We recommend that you deploy Software Defined Data Center (SDDC) features such as Software Defined Networking (SDN) or Storage Spaces Direct on hardware that is validated by the Windows Server Software-Defined (WSSD) program. Validated hardware will display a Windows Server 2019 Logo and have SDDC Additional Qualifications (AQs). 
 
 The first wave of hardware that is validated for Windows Server 2019 is expected to be available starting in mid-January 2019. Until then, you can use features such as the Network Controller or Storage Spaces Direct displays an advisory message and requires an additional step. This is typical and expected.  

 As WSSD-validated hardware is now available,  you can remove the advisory message by installing the latest cumulative update for Windows. Obtain the update from [https://aka.ms/update2019](https://aka.ms/update2019).  

**Required:** Windows Server Logo + SDDC AQs  

As is true for Windows Server 2016, systems and components that are listed in the Windows Server catalog and that have the SDDC AQs are required. If you run SDN or Storage Spaces Direct on such hardware, you are eligible for product support from Microsoft. There are more than 1,700 components that have the SDDC AQs for Windows Server 2016.  

**Why the two-phase launch?**  

Windows Server 2019 is the first version to skip the classic Release To Manufacturing (RTM) milestone and go directly to General Availability (GA). This change was motivated by the growing popularity of virtual machines and containers, and the growing trend to deploy in the cloud. But it also means that our hardware ecosystem did not have the opportunity to validate and certify systems or components before the release. Currently, OEMs are doing this.
