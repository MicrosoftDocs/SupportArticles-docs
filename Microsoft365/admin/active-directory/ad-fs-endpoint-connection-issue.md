---
title: AD FS endpoint connection issues during sign-in.
description: Describes how to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# How to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure

## Problem

When users sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Intune, or Microsoft Azure by using a federated user account, the connection to the Active Directory Federation Services (AD FS) service fails only when users try to do the following:

- Connect from a remote Internet location
- Use email connections to sign in

This situation also causes SSO testing that the Remote Connectivity Analyzer conducts to fail. 

For more information about how to run the Remote Connectivity Analyzer to test SSO authentication in Microsoft 365, see the following articles in the Microsoft Knowledge Base:

- [2650717](https://support.microsoft.com/help/2650717) How to use Remote Connectivity Analyzer to troubleshoot single sign-on issues for Microsoft 365, Azure, or Intune
- [2466333](https://support.microsoft.com/help/2466333) Federated users can't connect to an Exchange Online mailbox

## Cause

These failures can occur if the AD FS service isn't exposed correctly to the Internet. Typically, the AD FS proxy server is used for this purpose, and problems with the AD FS proxy server will cause these symptoms. Common problems include the following:

- Expired SSL certificate that's assigned to the AD FS proxy server

    Frequently, the same SSL certificate is used to help secure communication (HTTPS) for both the AD FS Federation Service and the AD FS proxy server. When this certificate becomes expired and the certificate is renewed or updated on the AD FS Federation Service farm, the SSL certificate must also be updated on all AD FS proxy servers. If the AD FS proxy server SSL certificate isn't updated in this case, Internet connections to the AD FS service may fail, even though the AD FS Federation Service is healthy.
- Incorrect configuration of IIS authentication endpoints

    The role of the AD FS proxy server is to receive Internet communication that's directed at AD FS and to relay that communication to the AD FS Federation Service. Therefore, it's important for the IIS authentication setting of the AD FS Federation Service and proxy server to be complementary. When the AD FS proxy server IIS authentication settings aren't set to complement the AD FS Federation Service IIS authentication settings, sign-in may fail or may generate multiple, unexpected prompts.
- Broken trust between the AD FS proxy server and the AD FS Federation Service

    The AD FS proxy service is designed to be installed on a non-domain joined computer. Therefore, the communication between the AD FS proxy server and the AD FS Federation Service can't be based on an Active Directory trust or credentials. Instead, the communication between these two server roles is established by using a token that is issued to the AD FS proxy server by the AD FS Federation Service and signed by the AD FS token-signing certificate. When this trust is expired or invalid, the AD FS Proxy Service can't relay AD FS requests, and the trust must be rebuilt to restore functionality. 

## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation, on all malfunctioning AD FS proxy servers.

### Method 1: Fix AD FS SSL certificate issues on the AD FS server

To do this, follow these steps:

1. Troubleshoot SSL certificate problems on the AD FS Federation Service (not the Proxy Service) by using the following Microsoft Knowledge Base article:

    [2523494](https://support.microsoft.com/help/2523494) You receive a certificate warning from AD FS when you try to sign in to Microsoft 365, Azure, or Intune 
1. If the AD FS Federation Service SSL certificate is functioning correctly, update the SSL certificate on the AD FS proxy server by using the certificate export and import functions. For more info, see the following Microsoft Knowledge Base article:  
    [179380](https://support.microsoft.com/help/2523494) How to remove, import, and export digital certificates

### Method 2: Reset the AD FS proxy server IIS authentication settings to default

To do this, follow the steps that are described in Resolution 1 of the following Microsoft Knowledge Base article for the AD FS proxy server:

[2461628](https://support.microsoft.com/help/2461628) A federated user is repeatedly prompted for credentials during sign-in to Microsoft 365, Azure, or Intune

### Method 3: Rerun the AD FS Proxy Configuration wizard

To do this, rerun the AD FS Federation Server Proxy Configuration Wizard from the Administrative Tools interface of all affected AD FS proxy servers.

> [!NOTE]
> It's usual to receive a warning from the "Deploy browser sign-in Web site" step when you rerun the configuration wizard. This isn't an indication that the wizard did not rebuild the trust between the AD FS proxy server and the AD FS Federation Service.

## More information

For more info about how to expose the AD FS service to the Internet by using an AD FS proxy server, go to the following Microsoft website:

[Plan for and deploy AD FS 2.0 for use with single sign-on](/previous-versions//ff652539(v=technet.10)#bk_deployfsp)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).