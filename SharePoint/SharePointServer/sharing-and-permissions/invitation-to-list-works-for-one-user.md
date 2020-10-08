---
title: "Title goes here"
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: xx/xx/xxxx
audience: Admin|ITPro|Developer
ms.topic: article
ms.service OR ms.prod: see https://docsmetadatatool.azurewebsites.net/allowlists
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- ADD PRODUCT
ms.custom: 
- CI ID
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# SharePoint invitation sent to a distribution list works for only one user

## Symptoms

When you send an external user invitation to a shared Microsoft SharePoint resource, and a user accepts and accesses the resource, the others in the group are unable to access the resource. Instead, they receive one of the following messages:

- Access Denied
- You need permission to access this site.
- Let us know why you need access to this site.
- User is not found in the directory

## Cause

This issue occurs because distribution lists aren't supported methods for assigning SharePoint permissions. When you share with a distribution list, the first user who accepts the invitation receives access to the resource as an external user. 

## Resolution

To resolve this issue, use one of the following methods, depending on your specific scenario:

- If you're using directory synchronization, share the resource with security groups and not with a distribution list.
- Use SharePoint groups. For more information, go to [Customize SharePoint site permissions](https://c3web.trafficmanager.net/topic/b1e3cd23-1a78-4264-9284-87fed7282048).
- Use Microsoft 365 groups. For more information, go to [Learn about Office 365 Groups](https://c3web.trafficmanager.net/topic/b565caa1-5c40-40ef-9915-60fdb2d97fa2).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).