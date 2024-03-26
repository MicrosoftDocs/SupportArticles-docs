---
title: Excel workbook shows old property values
description: An Excel workbook shows old property values instead of the current SharePoint property values when it's opened from SharePoint in the Excel desktop.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: warrenr, jhaak
ms.custom: 
  - CSSTroubleshoot
  - CI 167550
search.appverid: 
  - MET150
appliesto: 
  - SharePoint Online
  - SharePoint Server
  - Excel for Microsoft 365
ms.date: 10/26/2022
---
# Excel workbook shows old SharePoint property values

## Symptoms

You have a Microsoft Excel workbook that's stored in a SharePoint Online or SharePoint Server document library. When you open the workbook in the Excel desktop app and [view the file properties](https://support.microsoft.com/office/view-or-change-the-properties-for-an-office-file-21d604c2-481e-4379-8e54-1dd4622c6b75), the workbook shows the old property values instead of the values that are stored in SharePoint. In this case, when Excel does a **Save** or **AutoSave** operation, the old values that are stored in the local cache will overwrite the current values that are stored in SharePoint.

## Cause

This is a known issue in Excel. This issue might occur if the workbook already exists in the app local cache of the Excel desktop app.

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Delete files from local cache when closing them

1. In the Excel desktop app, select **File** > **Options** > **Save**.  
2. Under **Cache Settings**, select **Delete files from the Office Document Cache when they are closed**, and then select **OK**.  
3. Close and reopen the file.

**Note:** Setting this option might cause files to open more slowly and increase network usage. This is because Office applications always download files completely every time that they're opened.  
  
### Method 2: Disable SharePoint property sync

You can prevent a SharePoint document library from synchronizing the property values of files between Office applications and SharePoint. If properties are set on the [Office Backstage](https://support.microsoft.com/office/start-backstage-with-the-file-tab-04610088-406c-43d0-98a0-c1999ab4ef53), they won't be saved to SharePoint. If properties are set in SharePoint, they won't be pushed to the Office Backstage. This workaround is best suited for users who primarily use the SharePoint UI to view and set property values.

**Note:** You must have the SharePoint administrator permission to take the following step.

To disable the property sync, run the following PowerShell scripts:  
  
```powershell  
$list = $Context.Web.Lists.GetByTitle($listName)  
$list.ParserDisabled = $true  
$list.Update()  
```

> [!IMPORTANT]
> If the `ParserDisabled` property is later set to **$false**, a significant side effect of this action is that the old property values that are stored in the file might overwrite the property values of all documents that are stored in the document library on SharePoint.
