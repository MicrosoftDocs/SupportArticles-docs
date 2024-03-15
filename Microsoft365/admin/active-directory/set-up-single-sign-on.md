---
title: Supported scenarios to set up single sign-on in Microsoft 365, Azure, or Intune
description: Provides an overview of various AD FS implementation scenarios for single sign-on (SSO) in Microsoft 365, Azure, or Microsoft Intune.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Supported scenarios for using AD FS to set up single sign-on in Microsoft 365, Azure, or Intune

## Introduction 

This article provides an overview of various Active Directory Federation Services (AD FS) scenarios and their implications for single sign-on (SSO) in Microsoft 365, Microsoft Azure, or Microsoft Intune.

## More information

As with most enterprise-level services, the AD FS Federation Service (leveraged for SSO) can be implemented in many ways, depending on business needs. The following AD FS scenarios focus on how the on-premises AD FS Federation Service is published to the Internet. This is a very specific aspect of AD FS implementation. 

### Scenario 1: Fully implemented AD FS

#### Description 

An AD FS Federation server farm services Active Directory client requests through SSO authentication. An AD FS (load balanced) Federation server proxy exposes those core authentication services to the Internet by relaying requests and responses back and forth between Internet clients and the internal AD FS environment. 

#### Recommendations

This is the recommended implementation of AD FS. 

#### Support assumptions 

There are no support assumptions for this scenario. This scenario is supported by Microsoft Support. 

### Scenario 2: Firewall-published AD FS

#### Description 

An AD FS Federation server farm services Active Directory client requests through SSO authentication. A Microsoft Internet Security and Acceleration (ISA) / Microsoft Forefront Threat Management Gateway (TMG) server (or server farm) exposes those core authentication services to the Internet by reverse proxy. 

#### Limitations 

Extended Authentication Protection must be disabled on the AD FS Federation server farm for this to work. This weakens the security profile of the system. For security considerations, we recommend that you do not do this. 

#### Support assumptions 

It's assumed that the ISA/TMG firewall and reverse proxy rule are implemented correctly and are functional. For Microsoft Support to support this scenario, the following conditions must be true:  

- The reverse proxy of HTTPS (port 443) traffic between the Internet client and the AD FS server must be transparent.    
- The AD FS server must receive a faithful copy of SAML requests from the Internet client.    
- Internet clients must receive faithful copies of SAML responses as if the clients were directly attached to the on-premises AD FS server.    

For information about common problems that can cause this configuration to fail, see the following resource:

- The following Microsoft TechNet article:

   [Using a Third-Party Proxy as a Replacement to an AD FS 2.0 Federation Server Proxy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh852618(v=ws.10))   

### Scenario 3: Non-published AD FS

#### Description 

An AD FS Federation server farm services Active Directory client requests through SSO authentication, and the server farm isn't exposed to the Internet by any method. 

#### Limitations 

Internet clients (including mobile devices) can't use Microsoft cloud service resources. For service-level reasons, we recommend that you do not do this. 

Outlook rich clients cannot connect to Exchange Online resources. For more information, see the following Microsoft Knowledge Base article: 

[2466333](https://support.microsoft.com/help/2466333) Federated users can't connect to an Exchange Online mailbox

#### Support assumptions 

It's assumed that the customer acknowledges by implementation that this setup doesn't provide the fully advertised suite of services that are supported by Microsoft Entra ID. Under these circumstances, this scenario is supported by Microsoft Support. 

### Scenario 4: VPN-published AD FS

#### Description

An AD FS Federation server (or Federation server farm) services Active Directory client requests through SSO authentication, and the server or server farm isn't exposed to the Internet by any method. Internet clients connect to and use AD FS services only through a virtual private network (VPN) connection to the on-premises network environment. 

#### Limitations

Unless Internet clients (including mobile devices) are VPN-capable, they can't use Microsoft cloud services. For service-level reasons, we recommend that you do not do this. 

Outlook rich clients (including ActiveSync clients) can't connect to Exchange Online resources. For more information, see the following Microsoft Knowledge Base article:

[2466333](https://support.microsoft.com/help/2466333) Federated users can't connect to an Exchange Online mailboxSupport assumptions

It's assumed that the customer acknowledges by implementation that this setup doesn't provide the fully advertised suite of services that are supported by identity federation in Microsoft Entra ID. 

It's assumed the VPN is implemented correctly and is functional. For this scenario to be supported by Microsoft Support, the following conditions must be true: 

- The client can connect to the AD FS system by DNS name through HTTPS (port 443).    
- The client can connect to the Microsoft Entra federation endpoint by DNS name by using appropriate ports/protocols.    

<a name='high-availability-ad-fs-and-azure-ad-identity-federation'></a>

### High-availability AD FS and Microsoft Entra identity federation

Each scenario can be varied by using a stand-alone AD FS Federation server instead of a server farm. However, it's always a Microsoft best-practice recommendation that all critical infrastructure services be implemented by using high-availability technology to avoid loss of access. 

On-premises AD FS availability directly affects Microsoft cloud service availability for federated users, and its service level is the responsibility of the  customer. The Microsoft TechNet library contains extensive guidance on how to plan and deploy AD FS in the on-premises environment. This guidance can help customers reach their target service level for this critical subsystem. For more information, go to the following TechNet website: 

[Active Directory Federation Services (AD FS) 2.0](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd727958(v=ws.10))

## References 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
