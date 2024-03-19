---
title: Visio Graphics Service application pool isn't recycled
description: Fixes an issue that blocks Visio files from being displayed in SharePoint Server 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CSSTroubleshoot
ms.reviewer: vrunge
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Unable to retrieve data from the server when you display Visio files in SharePoint Server 2013

_Original KB number:_ &nbsp; 4012706

## Symptoms

When the Visio Graphics Service application pool is not recycled for a few days in SharePoint Server 2013, you may receive the following error message when you try to display Visio files:

> Unable to retrieve data from the server. The web request failed.

Meanwhile, you may find the following entries in the ULS log:

> w3wp.exe Visio Graphics Service Web Access 9004 Warning  
> Failed to access the cache.  
> w3wp.exe Visio Graphics Service Graphics Service 8079 Critical
Failed to generate raster diagram for file `https://SERVER/sites/SITENAME/Documents/VISIODOCUMENTNAME.vsdx` page ShapeInfo Error : System.IO.FileNotFoundException: Drive:\Program Files\Microsoft Office Servers\15.0\Data\VisioServer\VisioCachexxx\VisioBundlexxx.cache  
> at Microsoft.Office.Visio.Server.GraphicsServer.DiskCache.ReadBundlePart(Bundle bundle, Int32 index)  
> at Microsoft.Office.Visio.Server.GraphicsServer.ServiceCore.GetRasterPageItem(RasterPageItemRequest request)  
> at Microsoft.Office.Visio.Server.GraphicsServer.VisioGraphicsService.GetRasterPageItem(RasterPageItemRequest request)

## Resolution

To resolve this issue, you can recycle an application pool for the Visio Graphics Service daily during non-business hours.

> [!NOTE]
>
> - Before recycling, make sure that access to the Visio cache isn't blocked (by permissions or antivirus software, for example).
> - When you recycle an application pool in a farm, you may receive errors for a short period.

For more information, see the following articles:  

- [Certain folders may have to be excluded from antivirus scanning when you use file-level antivirus software in SharePoint](https://support.microsoft.com/office/certain-folders-may-have-to-be-excluded-from-antivirus-scanning-when-you-use-file-level-antivirus-software-in-sharepoint-01cbc532-a24e-4bba-8d67-0b1ed733a3d9)

- [Account permissions and security settings in SharePoint Servers](/SharePoint/install/account-permissions-and-security-settings-in-sharepoint-server-2016)

- [Configure an Application Pool to Recycle at a Scheduled Time (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754494(v=ws.10))
