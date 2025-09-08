---
title: SharePoint installs the obsolete SQL Server product
description: Provides a workaround for an issue in which SharePoint installs the obsolete Microsoft SQL 2005 Analysis Services ADOMD.NET.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# SharePoint installs the obsolete SQL Server 2005 Analysis Services ADOMD.NET

_Original KB number:_ &nbsp; 4498705

## Symptoms

Microsoft SQL Server 2005 Analysis Services ADOMD.NET was initially installed by Microsoft SharePoint 2007 for use together with Performance Point and Key Performance Indicator web parts.

ADOMD.NET is also installed by SharePoint 2019, 2016, and 2013, although it is now considered to be an obsolete product.

## Cause

Because it was included as part of the actual SharePoint installation process instead of as a prerequisite, ADOMD.NET was overlooked when future versions of SharePoint were built. Therefore, the tool was never removed or updated.

## Workaround

You can safely remove SQL Server 2005 Analysis Services ADOMD.NET by using the **Programs and Features** item or the **Add or Remove Programs** item in Control Panel, as appropriate.

## More information

SQL Server 2005 Analysis Services ADOMD.NET is unused in later versions of SharePoint and will be removed from future versions of the product.

Beginning in SharePoint 2013, users of Performance Point continue to be instructed to install the ADOMD.Net from the SQL Server 2012 Feature Pack.

## References

[Configure PerformancePoint Services](/SharePoint/administration/configure-performancepoint-services)
