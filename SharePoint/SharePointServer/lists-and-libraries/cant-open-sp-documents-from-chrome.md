---
title: Can't open documents in a local client from Chrome
description: Describes an issue that occurs when you open SharePoint-based files in the Chrome browser. Because Chrome has deprecated NPAPI support, SharePoint integration with Chrome has been disrupted. A workaround is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Server 2013
- Microsoft SharePoint Server 2013 Service Pack 1
- SharePoint Online
---

# Can't open SharePoint documents in a local client (rich client) from Chrome when NPAPI plug-in is missing

## Symptoms

When you try to open a file from an on-premises installation of Microsoft SharePoint or from SharePoint Online, the browser defaults to either downloading a local copy or trying to open the file in the browser. This issue occurs regardless of your library settings.

Additionally, many other SharePoint integration features don't work. These include the following:

- The ability to open documents in a rich client app when a document library link is selected   
- Lync Presence information   
- The ability to export to Excel from a document library or a SharePoint list    
- The **Edit Library** button and functionality   
- The **New Quick Step **option    
- The **Create a workflow in SharePoint Designer** option under **Workflow Settings**   
- The **Open with Access** and **Open with Project** options   
- The **Edit Lists** feature   


## Cause

This problem occurs when Netscape Plugin API (NPAPI) support is disabled.

## Workaround

The following workaround lets you temporarily enable NPAPI plug-ins:

1. Start the Chrome browser, and then enter the following path into the Address bar:

    chrome://flags/#enable-npapi   
2. Find the Enable NPAPI plug-in, and then enable it.   
3. At the bottom of the page, select **relaunch now**.   
4. Check to see whether you have your old functionality back.   

**Note** This workaround will not work after the end of September 2015, per the following Google blog post:

[The final countdown for NPAPI](https://blog.chromium.org/2014/11/the-final-countdown-for-npapi.html)

*In September 2015 we will remove the override and NPAPI support will be permanently removed from Chrome. Installed extensions that require NPAPI plugins will no longer be able to load those plugins.*

Alternatively, you can open the file in the browser by using Office Web Apps, and then click the button from the web editor to open in a rich client application. For example, click **Edit in Word** in this situation.

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

## More Information

The fix for this issue has been rolled out as of August 11, 2015, and it should be in build 15.0.4745.1000 and later.

Concerning Lync presence information on a SharePoint page, Chrome is deprecating the plug-in technology that made this feature work. We are currently working on a replacement. In the meantime, if you must access presence information in SharePoint, use Internet Explorer.  

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
