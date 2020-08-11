---
title: Everyone except external users group is re-added to Visitors or Members group on Office 365 public group website 
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
ms.date: 11/7/2019
audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
- SharePoint Online MSIT
ms.custom: 
- CI 109312
- CSSTroubleshoot 
ms.reviewer: salarson, clake  
description: Describes why the security group "Everyone except external users" is automatically added back to the Visitors or Members groups after being removed. 
---

# "Everyone except external users" group is re-added to Visitors or Members group on Office 365 public group website 

## Symptoms

After a user removes the "Everyone except external users" security group from either the Visitors or Members permissions group, the security group is added back in.

## Cause 

This behavior is by design. 

By default, the "Everyone except external users" claim is added to the Members and Visitors groups on public group sites. If this claim is removed from either the Members or Visitors group on a public group site, it may be automatically re-added at any time by a managed service account. 

## Workaround 
 
To work around this behavior, we recommend using a [Private Group](https://support.office.com/en-us/article/learn-about-office-365-groups-b565caa1-5c40-40ef-9915-60fdb2d97fa2) instead. 
 
## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
