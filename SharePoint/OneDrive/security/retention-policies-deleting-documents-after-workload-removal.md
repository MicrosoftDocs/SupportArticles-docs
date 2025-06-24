---
title: Documents deleted by retention policy after workload is removed
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 119743
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
description: A retention policy continues to delete documents even after workloads are removed from the policy
appliesto: 
  - OneDrive for Business
---

# A retention policy deletes documents after workload is removed from the policy

> [!NOTE]
> This issue was resolved on June 19, 2020 and should no longer affect retention policies.

If a retention policy is set up for specific workloads such as SharePoint Online, OneDrive for Business, or Exchange Online, but the OneDrive for Business workload is removed from it at a later time, the actions that are generated to comply with the policy continue to run until they are finished. 

For example, a retention policy is enabled to move all OneDrive for Business documents that are created before a specific date to the Recycle Bin. If this policy is later disabled for OneDrive for Business, it will not stop the documents from continuing to be moved to the Recycle Bin. 


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
