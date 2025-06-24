---
title: Microsoft 365 One of on-premises Federation Service certificates is expiring
description: Describes a scenario in which you receive a One of your on-premises Federation Service certificates is expiring message in the Microsoft 365 portal. Provides a resolution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Azure Active Directory
  - Microsoft 365
ms.date: 03/31/2022
---

# "One of your on-premises Federation Service certificates is expiring" message in Microsoft 365 portal

## Problem

You receive the following message in the Microsoft 365 portal:

> **One of your on-premises Federation Service certificates is expiring. Failure to renew the certificate and update trust properties within 13 days will result in a loss of access to all Office 365 services for all users.**

## Cause 

The Secure Sockets Layer (SSL) certificate or the token-signing certificate is about to expire. You may receive this message even if automatic certificate rollover is enabled for the token-signing certificate. 

## Solution 

To resolve this issue, follow these steps:

1. Install the Microsoft Azure Active Directory module for Windows PowerShell on the computer (if the module isn't already installed).  
2. Follow the steps in the "Scenario 1: The AD FS token-signing certificate expired" section in ["There was a problem accessing the site" error from AD FS when a federated user signs in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2713898).   
3. Follow the steps in [How to update or repair the settings of a federated domain in Microsoft 365, Azure, or Intune ](https://support.microsoft.com/help/2647048).   

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
