---
title: Error when you add link to work item
description: This article provides resolutions for the error that occurs when you try to add a new link to a work item in Team Foundation Server 2017 with Update 2 installed.
ms.date: 08/18/2020
ms.custom: sap:Boards
ms.reviewer: chcoope
ms.service: azure-devops
ms.subservice: ts-boards
---
# Error TF237201 when you try to add a new link to a work item in Team Foundation Server

This article helps you resolve the error that occurs when you try to add a new link to a work item in Team Foundation Server 2017 with Update 2 installed.

_Original product version:_ &nbsp; Microsoft Team Foundation Server 2017  
_Original KB number:_ &nbsp; 4046799

## Symptom

When you try to add a new link to a work item in Team Foundation Server 2017 with Update 2 installed, you receive the following error message:

> TF237201: Cannot add a new link because one of the work items being linked will exceed the 1000 link limit.  
Remove links from that item and try saving again

## Cause

This issue occurs because there's a limit to the number of links that a single work item can have in Team Foundation Server 2017 Update 2. Therefore, if you upgrade to Team Foundation Server 2017 Update 2 or a later version, you will experience this issue when you try to add a link that causes the total number of links to exceed the limit.

## Resolution

To fix this, run the following SQL Script on your collection database:

```sql
exec prc_SetRegistryValue 1, '#\Service\WorkItemTracking\Settings\WorkItemLinksLimit\', <new link limit (eg. 2000)>
exec prc_QueryRegistry 1, '#\Service\WorkItemTracking\Settings\WorkItemLinksLimit\'
```

The script updates a setting that increases the maximum number of 'allowed' links.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
