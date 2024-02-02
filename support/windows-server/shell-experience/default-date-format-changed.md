---
title: The default date format is changed
description: Discusses that the default date format is changed in Windows 8 and Windows Server 2012.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, cenki, v-jesits
ms.custom: sap:dst-and-timezones, csstroubleshoot
ms.subservice: shell-experience
---
# The default date format is changed in Windows 8 and Windows Server 2012

This article describes that the default date format is changed and provides a workaround for issues caused by this change. For example, some tools or programs that depend on the earlier date formats fail.

_Applies to:_ &nbsp; Windows 8, Windows Server 2012  
_Original KB number:_ &nbsp; 2905782

## Summary

Versions of Windows and Windows Server that are earlier than Windows 8 and Windows Server 2012 use the following date formats:

Short Date: dd.MM.yyyy  
Long Date: dd MMMM yyyy dddd

Starting in Windows 8 and Windows Server 2012, the date formats are changed to the following:

Short Date: d.M.yyyy  
Long Date: d MMMM yyyy dddd

This change may cause some tools or programs that depend on the earlier date formats to fail.

> [!NOTE]
> These date formats are for the Turkish language locale. However, similar changes may apply to other regions.

## Workaround

To work around this change, revert the date formats to the original formats that are mentioned in the "Summary" section. To do this, use the **Change date, time, or number formats** item in **Control Panel**.
