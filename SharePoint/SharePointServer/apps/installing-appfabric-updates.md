---
title: Installing Windows Server AppFabric updates SharePoint 2013 Servers
description: Updates to AppFabric on SharePoint 2013 are applied via AppFabric updates. SharePoint 2013 updates do not update AppFabric.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Foundation 2013
ms.date: 12/17/2023
---

# Installing Windows Server AppFabric updates SharePoint 2013 Servers  

## Summary  

SharePoint Foundation 2013 and SharePoint Server 2013 requires [Windows Server AppFabric and the AppFabric 1.1 Cumulative Update Package 1 (KB 2671763)](https://support.microsoft.com/help/2671763/).   

After AppFabric and SharePoint are installed on the server, AppFabric will continue to be updated independently from SharePoint. SharePoint Updates do not update the AppFabric software running on the SharePoint 2013 server.  

## More Information  

Updating AppFabric may be needed to improve the performance or address issues in the product on your SharePoint servers.   

For example, the .Net Framework 4.5 update introduces background GC (Garbage Collection) for Servers. To allow AppFabric to take advantage of background GC, it requires [Cumulative update package 3 for Microsoft AppFabric 1.1 for Windows Server](https://support.microsoft.com/help/2787717) be applied and the steps given in the update article to be completed (enables background GC in the DistributedCacheService.exe.config configuration file).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
