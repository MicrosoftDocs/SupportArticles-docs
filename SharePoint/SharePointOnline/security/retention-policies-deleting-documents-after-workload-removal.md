---
title: Documents deleted by retention policy after workloads are removed
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
localization_priority: Normal
ms.date: 06/10/2020
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 119743
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: A retention policy continues to delete documents even after workloads are removed from the policy
appliesto:
- SharePoint Online
---

# A retention policy deletes documents after workload is removed from the policy

## Summary

If a retention policy is set up for specific workloads such as SharePoint, OneDrive, and or Exchange Online, but SharePoint and OneDrive workloads are removed from it at a later time, the actions that are generated to comply with the policy continue to run until they are finished. 

For example, a deletion policy is enabled to move all SharePoint documents that are created before a specific date to the Recycle Bin. If this policy is later disabled for SharePoint, it will not stop the documents from continuing to be moved to the Recycle Bin. 


## More Information

Microsoft is researching ways to improve this experience and will post more information in this article when the information becomes available. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).