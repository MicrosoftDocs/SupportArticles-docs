---
title: Search for Shapes feature on the Internet is discontinued
description: Fixes an issue in which the Search for Shapes feature on the Internet is discontinued.
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
appliesto: 
  - Microsoft Office Visio Professional 2007
  - Microsoft Office Visio Standard 2003
  - Visio
ms.date: 03/31/2022
---

# Search for Shapes feature on the Internet is discontinued

## Summary

The Search for Shapes feature in Visio 2003 and 2007 (known as "Find Shape" in Visio 2002) allowed users to query for Visio shapes both on their computer as well as online from Microsoft servers. The online search portion of Search for Shapes feature is being discontinued and the servers are being shut down. Users of Visio 2002 and later versions will only be able to search for shapes locally. Results will not be returned from the online source.

Some of the shapes that were available only online, such as the geographic map shapes, are available for download in the [Microsoft Download Center](https://www.microsoft.com/downloads/). These shapes can be found by searching for "Visio" in the Microsoft Download Center.

## More Information

In Microsoft Office Visio, you can use the **Search for Shapes** box to search for shapes. The Search for Shapes feature searches the Office Visio stencils that are installed on your computer. The Search for Shapes box works best when Windows Indexing service is enabled and running for Visio 2007 and earlier. Visio 2010 and later utilize the Windows Search service when searching for shapes. If one of these services is disabled or not functioning properly, users may receive "No result found" when searching for shapes. Possible resolutions to this problem include:

Installing the Windows Search service on Windows Server - see the [reference](search-for-shapes-use-windows-search.md) for more details

Enable Windows Search service - Right click the taskbar and select Start Task Manager. On the services tab, confirm that the "Windows Search" service is running. If not,

1. Go to Start > Control Panel > Uninstall a program > Turn Windows features on or off

1. Place a check mark next to "Windows Search" to enable the service, then click OK.
