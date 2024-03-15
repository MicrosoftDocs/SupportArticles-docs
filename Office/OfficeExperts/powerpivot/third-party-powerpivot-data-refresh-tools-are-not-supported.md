---
title: Third-party PowerPivot data refresh tools are not supported
description: Describes third-party PowerPivot data refresh tools are not supported.
author: helenclu
ms.author: luche
ms.reviewer: randring
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# Third-party PowerPivot data refresh tools are not supported

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

Microsoft has seen multiple third-party tools or scripts are being used to refresh a PowerPivot workbook more frequently than the standard default PowerPivot limit of one time per day. However, these tools bring a high risk and can cause multiple issues for SharePoint Web Front End and Database servers. Microsoft doesn't support these tools and highly recommends not using them. If you need to refresh your PowerPivot workbooks multiple times a day, you need to use a different BI solution to display your data. Excel Services and PowerPivot for SharePoint are not meant to be a "live feed" of data.

## Adverse effect if you use third-party data refresh tools

The third-party tools or scripts update the workbooks from another server or computer outside the farm and reupload them to SharePoint. As in most cases where PowerPivot is used, the library where the documents are stored is a PowerPivot Gallery as it provides the best user experience visually and functionally. Because the documents are stored in a gallery, frontend load is caused by the PowerPivot gallery snapshots that are triggered on the workbooks. Every time that a workbook is updated or uploaded to a gallery, this snapshot process is triggered. The process engages the workbook after upload, actually creating images for every supported sheet in the workbook, and then uploads them to the metadata of the file.

For example, if you have a PowerPivot gallery with fifty 30 megabyte (MB) workbooks in it and you use the script to refresh all workbooks, and then reupload them to the site, not only do you just slam a single WFE with 1.5 gigabytes (GB) of uploads, but you have potentially caused 50 "get snapshot" processes to start at the same time and start to process. Each of those processes reaches out to the site at the same time to create an image file and then upload it to the document. This can affect more than one WFE at the same time.

The other problem about a solution like this is that it can be implemented by any user who has access to the farm. Administrators may not even know it exists until it is too late. Most of these update solutions can be run and triggered from a client computer. They don't require servers or code level access to function. They generally access the site through the same interface that other software (like Office for example) would use.

Finally, if the PowerPivot gallery is configured with versioning, this can cause some bad issues with version limits. You may find these documents becoming quickly unusable or causing corruption in your content database if too many versions are created. They also cause large storage issues on the database side when they become unmanageable.

## What can you do?

1. Do not use custom solutions to update your PowerPivot workbooks multiple times per day. It is not supported. If you find that users are doing this, stop them.
1. If you use custom solutions, do not store the workbooks in a PowerPivot Gallery.
1. Do not configure versioning on the library where the workbooks are stored or limits the versioning severely.
1. If you need to refresh BI data more frequently, think your BI data strategy again.

## How to refresh data more frequently?

1. You could upsize your data models. Effectively this involves moving data models created in PowerPivot to Analysis Services. Then you can use SQL jobs to update the data as frequently as you want. After that is configured, you could create Excel workbooks to hit the new model and "Refresh on Open". This would effectively give you "fresh" data every time that you open the workbook. Again, it would not be a live stream, but it would give you a supported method to retrieve data on a more frequent basis.

   > [!NOTE]
   > This workaround may not make sense if you have very small workbooks.
1. If the data source is SQL Analysis Services, you could use Excel instead of PowerPivot and configure the workbook to "Refresh on Open".
   > [!NOTE]
   > This solution may cause a bit more load on the application servers and the Analysis Services data sources, but it is fully supported and a much more reliable method to retrieve data.
1. Consider other products to display the data such as PowerBI, PowerBI Report Server, SQL Reporting Services or PerformancePoint.

## What is the meaning of "It is not supported"?

Microsoft won't provide support to fix custom solutions or scenarios that are considered "out of bounds" by our product teams. This does not mean that these solutions will not work, but if you encounter a problem because of one of those solutions, we will be unable to help to get the farm back into a working state after the customizations are removed or disabled.

If you want to know whether your solution is supported, please contact Microsoft support and we can have a look and let you know.
