---
title: Enable the Windows Search service if you use Search for Shapes
description: Explains how to enable the Windows Search service in Windows Server 2008 R2 and in Windows Server 2012. This service is used by Visio 2010 and by Visio 2013 to search for shapes.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Diagrams
  - CSSTroubleshoot
ms.reviewer: nathanad, jennc
search.appverid: 
  - MET150
appliesto: 
  - Visio Standard 2010
  - Visio Professional 2010
  - Visio Standard 2013
  - Visio Professional 2013
ms.date: 06/06/2024
---

# Enable the Windows Search service if you want to use the Search for Shapes feature in Visio 2010 or in Visio 2013

## Introduction 

The Search for Shapes feature in Microsoft Visio 2010 and in Microsoft Visio 2013 uses the Windows Search service to search for the Visio stencils that are installed on your computer. The Windows Search service must be running to enable quick searching. Otherwise, searches take a long time to finish, and the search results may be incorrect. Additionally, you receive the following warning message:

```adoc
Visio cannot provide fast search results because Windows Search is not running or is not configured properly for Visio. Please contact your system administrator. 
```

## More Information

By default, the Windows Search service is enabled in Windows 7 and in Windows 8. However, you must manually enable the Windows Search service in Windows Server 2008 R2 and in Windows Server 2012.

### How to enable the Windows Search service in Windows Server 2012

To enable the Windows Search service in Windows Server 2012, follow these steps:

1. Start Server Manager. 
2. Click **Manage**, and then click **Add Roles and Features**.
3. On the Before You Begin page, click **Next**.
4. On the Installation Type page, select **Role-based or Feature-based Installation**, and then click **Next**.   
5. On the Server Selection page, select the server or virtual hard disk on which to install Windows Search Service.   
6. On the Features page, select **Windows Search Service**, and then click **Next**   
7. On the Confirmation page, verify that Windows Search Service is listed, and then click **Install**.

### How to enable the Windows Search service in Windows Server 2008 R2

To enable the Windows Search service in Windows Server 2008 R2, follow these steps:

1. Start Server Manager. 
2. Click **Roles** in the left navigation pane.   
3. Click **Add Roles** in the Roles Summary pane.   
4. On the Server Roles page, select the **File Services** role, and then click **Next**.   
5. On the Role Services page, select the **Windows Search Service** role service, and then click **Next**.

6. On the Confirmation page, verify that **Windows Search Service** is listed, and then click **Install**.
