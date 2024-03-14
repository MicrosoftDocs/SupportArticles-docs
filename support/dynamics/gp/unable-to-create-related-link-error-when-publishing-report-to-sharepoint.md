---
title: Unable to create the related report link error when publishing report to SharePoint
description: Describes an error you may receive when you publish a report to SharePoint from Management Reporter 2012.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# "Unable to create the related report link" error in Management Reporter 2012 when publishing a report to SharePoint

This article provides a resolution for the **Unable to create the related report link** that may occur when you try to publish a report to SharePoint from Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011, Microsoft Dynamics SL 2011 Service Pack 1  
_Original KB number:_ &nbsp; 2841452

## Symptoms

You may receive the following error in the Report Queue when you generate a report to SharePoint:

> Unable to create the related report link in: '\<report library path>'

## Cause

This error can be caused by using invalid characters in the report Output name (ex: period at the end) in the Report Definition in Report Designer. SharePoint has specific file name requirements that need to be adhered to. You can view these requirements [here](https://support.microsoft.com/office/invalid-file-names-and-file-types-in-onedrive-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa?ui=en-us&rs=en-us&ad=us).

## Resolution

Remove the invalid characters from the report's Output name per the SharePoint requirements.
