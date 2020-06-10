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

## Scenario

The Security and Compliance Administrator sets up a deletion policy to particular locations (workloads), such as SharePoint, OneDrive, and EXO. The admin later removes the SharePoint and OneDrive locations from the policy. However, we continue to run the generated list of actions.

## How it works

We first generate a full list of all tasks at a particular location when the policy is enabled, and then we run the tasks. This process can take anywhere from several days to a week, depending on the data.

If the policy is disabled or deleted before it's fully run, we still process the tasks as requested.

If items were set to move into the Recycle Bin, they will still move as expected in this scenario.

## More Information

We are aware of this problem, and currently plan to create additional checks to validate whether the workload is removed from the policy and, if it is removed, top the policy from running.