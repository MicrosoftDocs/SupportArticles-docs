---
title: You can't connect to the Azure Information Protection service in Microsoft 365
description: Describes an issue that you cannot connect to the Azure Information Protection service in Microsoft 365. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
  - Azure Information Protection
  - Azure Active Directory
ms.date: 03/31/2022
---

# You can't connect to the Azure Information Protection service in Microsoft 365

Note Microsoft Azure Information Protection was previously known as Microsoft Azure Rights Management. 

## Problem

You can't connect to the Microsoft Azure Information Protection service in Microsoft 365.

## Cause 

This issue occurs if one of the following conditions is true:

- Azure Information Protection isn't enabled for your company.   
- The network is preventing you from connecting to the Azure Information Protection.   


## Solution

To fix this issue, follow these steps:

1. Make sure that your company is enabled for Azure Information Protection. For more info about how to do this, go to the following Microsoft TechNet website:

   [Azure Information Protection deployment roadmap](/azure/information-protection/deployment-roadmap)   
2. Work with the network admin to make sure that the network meets the requirements for connecting to the Azure Information Protection. The requirements are as follows: 
  - Incoming and outgoing connections to *.aadrm.com are enabled   
  - Incoming and outgoing connections to *.cloudapp.net (rmsoprod*-b-rms*.cloudapp.net) are enabled    
  - Port 443 is open   
   


## More Information

For more info about Azure Information Protection, go to the following Microsoft TechNet website:

[Azure Information Protection Documentation](/information-protection/)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).