---
title: Visio Services does not render diagrams
description: Provides a workaround for a problem in which Visio Services does not render diagrams. This problem occurs when the diagrams are hosted on servers that have IDNs.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: parida, Arykhus, kevinmil, barbway, emilcico
appliesto: 
  - Visio Standard 2010
  - Visio Premium 2010
  - Visio Professional 2013
  - Visio Standard 2013
ms.date: 03/31/2022
---

# Visio Services does not render diagrams that are hosted on servers that have IDNs

## Symptoms

When you have Microsoft Silverlight installed on a computer, Microsoft Visio Services cannot render diagrams that are hosted on servers that have International Domain Names (IDNs). Specifically, Visio Services cannot render these diagrams by using Silverlight on a Microsoft SharePoint Server site. Additionally, a JavaScript error occurs.

**Note** This is a known problem in Silverlight.

## Cause

When Visio Services loads a diagram, Visio Services transforms the diagram by using Extensible Application Markup Language (XAML). Then, the Visio Web part reads the XAML. This problem occurs because Silverlight cannot fetch the new XAML-based diagram from the server that has an IDN.

## Resolution

To resolve this problem, configure Visio Services to render diagrams as raster images. For example, configure Visio Services to render diagrams as Portable Network Graphics (PNG) images. Or, do not use a server that has an IDN.

To do render diagrams as raster images, follow these steps:

1. Click the **Visio Web Access Web Part** menu, and then click **Edit Web Part**.   
2. Select the **Force raster rendering** check box.   
3. Click **Apply**, and then click **OK**.   


##  More Information

The Visio Web Access Web part must be added to a page. To add the Web part to an existing page or to create a Web part page, use the following procedures in SharePoint Server.

To add the Web part to an existing page, follow these steps:

1. Click the **Site Actions** menu, and then click **Edit Page**.   
2. Click **Add a Web Part**.   
3. In the **Categories** menu, select **Business Data**.   
4. Click **Visio Web Access**, and then click **Add**.   
5. Click the **Click here to open the tool pane** link.   
6. Click the **browse** button that is next to the **Web Drawing URL** field.   
7. Select a Web drawing (.vdw), and then click **OK**.   
8. Click **Apply**, and then click **OK**.   

To create a new Web part page, follow these steps:

1. Click the **Site Actions** menu, and then click **More Options…**.   
2. Select **Web Part Page**, and then click **Create**.   
3. Type a name for the page, select a layout template, select a Document Library, and then click  **Create**.   
4. In one of the Web part sections, click **Add a Web Part**.   
5. In the **Categories** menu, select **Business Data**.   
6. Click **Visio Web Access**, and then click **Add**.   
7. Click the **Click here to open the tool pane** link.   
8. Click the **browse** button that is next to the **Web Drawing URL** field.   
9. Select a Web drawing (.vdw), and then click **OK**.   
10. Click **Apply**, and then click **OK**.   
