---
title: Customize appearance and behavior of SharePoint site collections
description: Describes two methods to customize the appearance and behavior of your site collections in Microsoft Office SharePoint Server and in Microsoft Windows SharePoint Services 3.0.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: sridhara
appliesto: 
  - SharePoint Server 2010
search.appverid: MET150
ms.date: 12/17/2023
---
# How to customize application pages in the Layouts folder in SharePoint

_Original KB number:_ &nbsp; 944105

## Introduction

This article describes two methods to customize the appearance and the behavior of your site collections in SharePoint.

Modifying the files that are installed by SharePoint is not supported. However, there are some scenarios in which you may have to modify these files to achieve consistent branding or other customizations. When you modify these files, you must consider that they may be replaced by future updates and service packs. Additionally, there may be complications when you upgrade to later versions of the product. Keep backup copies of all customized files in case they are overwritten by an update. Product support will provide commercially reasonable support for help with modifications but will be unable to provide product changes or hotfixes that result from modifying the files that are installed by SharePoint.

## Method 1: Customize the files in the Layouts folder (recommended)

1. Create a Layouts_Backup folder to contain a backup of the originally installed files and folders. For example, create a Layouts_Backup folder in the following location:

    `C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\Template\Layouts\Layouts_Backup`

2. Copy the originally installed files and folders from the Layouts folder to the Layouts_Backup folder that you created in step 1. For example, copy the originally installed files and folders from the following folder to the Layouts_Backup folder:

    `C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\Template\Layouts`

3. In the Layouts folder, customize the .aspx files and the Application.Master file as needed.

## Method 2: Create a custom Layouts folder

> [!NOTE]
> This method will change the layouts directory for any site collection within the Web application that is being modified. To apply custom layouts changes to an individual site collection, the site collection should reside in its own Web application.

1. Create a custom Layouts*SiteCollection* folder to contain a copy of the originally installed files and folders. For example, create a Layouts*SiteCollection* folder in the following location:

    C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\Template\Layouts\Layouts*SiteCollection*  

    > [!NOTE]
    > The *SiteCollection* placeholder is the name of a site collection.

2. Copy the originally installed files and folders from the Layouts folder to the Layouts*SiteCollection* folder that you created in step 1. For example, copy the originally installed files and folders from the following folder to the Layouts*SiteCollection* folder:

    `C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\Template\Layouts`

3. Start Internet Information Services (IIS) Manager. To do this, click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Internet Information Services (IIS) Manager**.

4. In IIS Manager, follow these steps:
   1. Expand the Web site that is hosting the site collection.
   2. Right-click **_layouts**, and then click **Properties**.
   3. Click the **Virtual Directory** tab.
   4. Click **Browse**, change the path from the Layouts folder to the Layouts*SiteCollection* folder, and then click **OK** two times.

5. In the Layouts*SiteCollection* folder, customize the .aspx files and the Application.Master file as needed.
6. Repeat these steps for each site collection that you have to customize.

### Advantage of Method 2

- This method enables the customization of application pages for individual site collections.

### Limitations of Method 2

- If a public update, a hotfix package, or a service pack is installed that contains updates to the files in the Layouts folder, the update isn't applied to your custom Layouts folder.
- This method may cause excessive manageability and maintenance issues.
- Any hard-coded functionality in SharePoint that references the Layouts folder instead of the _layouts virtual directory may not function as expected.
