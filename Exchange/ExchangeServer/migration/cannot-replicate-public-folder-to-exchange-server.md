---
title: Cannot replicate public folder
description: Resolves an issue in which you receive an Unable to get Replica list for the folder error when trying to replicate public folder to Exchange Server 2013. Provides a resolution.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: anthonge, v-six
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# Cannot replicate public folder to Exchange Server 2013

_Original KB number:_ &nbsp; 2866631

## Symptoms

Consider the following scenario:

- You migrate public folders from Exchange Server 2003 to Exchange Server 2010.
- You remove Exchange Server 2003 from the organization.
- You install Exchange Server 2013 in the organization.

In this scenario, when you try to replicate public folders from Exchange Server 2010 to Exchange Server 2013, you receive the following error message:

> MapiExceptionNoReplicaAvailable: Unable to get Replica list for the folder. (hr=0x80004005, ec=1129)

## Cause

This issue occurs because there are some legacy system folders in the public folder database.

## Resolution

To resolve this issue, follow these steps:

1. Open the Public Folder Management Console.
2. Expand and then select **System Public Folders** so that it is highlighted and populates the **Result** pane.
3. Right-click **schema-root** and then select **Remove**.
4. Right-click all `OWAscratchpad` entries and then select **Remove**.
5. Migrate public folders to Exchange Server 2013. For more information about how to do this, see [Use serial migration to migrate public folders to Exchange 2013 from previous versions](/previous-versions/exchange-server/exchange-150/jj150486(v=exchg.150)).
