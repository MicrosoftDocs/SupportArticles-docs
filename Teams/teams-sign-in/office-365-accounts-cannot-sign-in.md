---
title: Office 365 Student and service accounts can't sign in to Microsoft Teams
description: TeamsDisabledForTenantForbidden when trying to sign in to Microsoft Teams by using an Office 365 Education Student or Office 365 F1 license.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: msteams
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Teams
---

# Office 365 Student and service accounts can't sign in to Microsoft Teams

## Symptoms

A Microsoft Teams user who is assigned an Office 365 Education Student or Office 365 F1 license can't sign in to Teams on any platform. Additionally, they receive the following error message from the site:

**https://teams.microsoft.com/_#/licenseError?errorCode=TeamsDisabledForTenantForbidden**

## Cause

This issue occurs if the license type is not enabled. 

## Resolution

To resolve this issue, follow these steps:  
 
1. In the Microsoft 365 admin center, locate **Settings** -> **Services & add-ins** -> **Microsoft Teams**.     
2. Select **Settings by user/license type**, and then configure the relevant license type to enable the user.    
