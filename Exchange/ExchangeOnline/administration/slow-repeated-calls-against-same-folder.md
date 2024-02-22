---
title: Repeated calls against the same folder are slow
description: Provides a workaround for an issue in which repeated calls are made in Exchange Server 2013 or Exchange Online to IMAPITable::Restrict() in MAPI or Folder.FindItems() in Exchange Web Services, later calls to the same folder by using the same criteria are as slow as the first call.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: bilong, dpaul, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Repeated calls against the same folder are slow in Exchange Server 2013 or Exchange Online

_Original KB number:_ &nbsp; 3077710

## Symptoms

In Exchange Server 2013 or Exchange Online, when you repeatedly call the `IMAPITable::Restrict()` method in MAPI or the `Folder.FindItems()` method in Exchange Web Services by using the same filter criteria, subsequent calls against the same folder take as long to complete as the first call took.

This situation differs from that in earlier versions of Exchange. In those versions, later calls against the same folder are faster than the original call.

## Cause

This issue occurs because Exchange Server 2013 doesn't cache every restriction. Earlier versions of Exchange cache every restriction. Therefore, repeated requests that use the same criteria are returned more quickly in those versions because the whole result set does not have to be recalculated.

## Workaround

To work around this issue, create a search folder, and configure the folder criteria to match items that have the desired attributes. Then, query the search folder for the matching items. Because the search folder results are cached and kept up-to-date, the search folder results don't have to be recalculated every time that they are requested.

> [!NOTE]
> This workaround is applicable only if the same criteria is used every time. If the search criteria constantly changes, you may have to try an alternative method, such as a sort-and-seek process. For example, a search that's based on a particular datetime value would not use consistent criteria.

## More information

For more information about how to create search folders, see [Creating search folders by using the EWS Managed API 2.0](/previous-versions/office/developer/exchange-server-2010/dd633687(v=exchg.80)).
