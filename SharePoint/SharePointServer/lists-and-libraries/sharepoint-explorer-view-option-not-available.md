---
title: Explorer View option isn't available on the Current View list box
description: Describes an issue in which the SharePoint Explorer View option is not available on the Current View list box.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Lists and libraries
  - CSSTroubleshoot
appliesto:
- Microsoft Office SharePoint Server 2010
- Microsoft Office SharePoint Server 2007
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 12/17/2023
---
# Explorer View option isn't available on the Current View list box in SharePoint Server

## Symptoms

After a recent upgrade from Microsoft Office SharePoint Server 2007 to Microsoft Office SharePoint Server 2010, users find that **Explorer View** is no longer available on the **View** list box on the ribbon.

In SharePoint Server 2007, the view was available in the **View** list box:

1. Access a document library on SharePoint Server 2007.
2. On the top right hand side of the document library, select the **View** list box.
3. Note that **Explorer View** is available.

In SharePoint Server 2010, the customer is trying to find **Explorer View** in the same list box:

1. Access a document library on SharePoint Server 2010.
2. On the ribbon, select the **Library** tab.
3. In the **Manage Views** section, select on the **Current View** list box.
4. The customer expects **Explorer View** to appear in this list.

## Cause

This behavior is by design.

The Explorer View was a feature of SharePoint Server 2007. It has been replaced with an **Open with Explorer** button in the **Connect & Export** section of the ribbon.
However, for document libraries that existed during the upgrade from SharePoint Server 2007 to SharePoint Server 2010, that **Explorer View** will still be available in the **View** list box, as well as the **Open with Explorer** button. Newly created document libraries will only have the **Open with Explorer** button and not **Explorer View** in the **View** list box.
