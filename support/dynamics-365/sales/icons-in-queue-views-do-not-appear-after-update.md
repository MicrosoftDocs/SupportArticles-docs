---
title: Icons in Queue Views do not appear after update
description: Icons in Queue Views do not show after Update Rollup 12 or the December 2012 Service Update for Microsoft Dynamics CRM 2011.
ms.reviewer: 
ms.topic: article
ms.date: 
---
# Icons in Queue Views do not show after Update Rollup 12 or the December 2012 Service Update for Microsoft Dynamics CRM 2011

This article introduces a known issue that icons in Queue Views don't appear after Update Rollup 12 or the December 2012 Service Update for Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2813139

## Symptoms

Icons in Queue Views do not appear after applying Update Rollup 12 in Microsoft Dynamics CRM 2011 or the December 2012 Service Update for Microsoft Dynamics CRM Online.

## Cause

After applying Update Rollup 12 or the December 2012 Service Update for Microsoft Dynamics CRM, the icons have now been removed from grid views, except for grids that contain multiple record types. For example, when a user views a grid that displays a single entity such as Lead, the Lead icon will no longer appear next to each record. Meanwhile, the Activities grid view will display the icon associated with each unique activity type, such as Phone Call or Task. This is considered by design.

However, Queue views do display different record types, but the icons do not appear as they should. This is a known issue.

## More information

The ability to see icons in queue views will be addressed in a future Update Rollup.
