---
title: We were unable to return you to your webpage error
description: Provides a resolution for the issue that you may receive a We were unable to return you to your webpage error when trying to visit a website.
ms.date: 10/13/2020
ms.reviewer: ramakoni
---
# We were unable to return you to your webpage error occurs in Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a resolution for the issue that you receive the **We were unable to return you to \<your webpage>** error when you try to visit a website by using Internet Explorer 9.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2506617

## Symptoms

Internet Explorer 9 may stop working when you visit a website. When this problem occurs, you may receive an error message that resembles the following in the notification bar at the bottom of the Internet Explorer page:

> A problem with this webpage caused Internet Explorer to close and reopen the tab.

Additionally, you are not returned to the webpage, and Internet Explorer displays the following message on the page:

> We were unable to return you to *your webpage*.  
Internet Explorer has stopped trying to restore this website. It appears that the website continues to have a problem.

## Cause

This problem occurs because of an issue with Java Version 6 Update 22 and Java Version 6 Update 23 that was exposed by recent changes in the Internet Explorer 9 rendering engine.

## Resolution

To work around this issue, view these webpages in Internet Explorer 9 Compatibility View. Compatibility View forces Internet Explorer to render the webpage in the Internet Explorer 8 document mode, which does not contain the Internet Explorer 9 changes to the rendering engine.

To add a website to Compatibility View when you are unable to visit that website, follow these steps:

1. Start Internet Explorer.
2. Press the Alt key on the keyboard to access the menu.
3. Select **Tools**, and then select **Compatibility View Settings**.
4. Type the address of the website in the **Add this website** text box.
5. Select **Add** to add the site to the **Compatibility View** list, and then close the **Compatibility View Settings** window.
6. Visit the website again to see whether the issue is resolved.

    For more information, see the following video about how to add a website to Compatibility View when you are unable to visit that website.

    > [!VIDEO https://www.microsoft.com/videoplayer/embed/304d70d1-b64e-4e64-8607-dc700486204d?csid=ux-cms-en-us-msoffice&iframe=true&uuid=304d70d1-b64e-4e64-8607-dc700486204d&PlaybackMode=inline&Quality=HQ&AutoPlayVideo=false&width=640&height=360]

To remove a website from Compatibility view, follow these steps:

1. Start Internet Explorer.
2. Press the Alt key on the keyboard to access the menu.
3. Select **Tools** and then select **Compatibility View Settings**.
4. Select the website from the list of websites that you have added to Compatibility View.
5. Select **Remove** to remove the site from the **Compatibility View** list, and then close the **Compatibility View Settings** window.
