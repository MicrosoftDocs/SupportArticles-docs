---
title: Windows Media Player cannot connect to the server
description: This article describes an issue where Windows Media Player cannot connect to the server when you click a .mov or .mp4 file, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Windows Media Player cannot connect to the server" error when you click a .mov or .mp4 file

## Problem

Consider the following scenario.

- You upload a .mov or .mp4 video to a SharePoint Online library.

- In Internet Explorer, you browse to a SharePoint Online library that contains a .mov or .mp4 video file.

- When you click the video to open it in Windows Media Player, you receive the following error message:

   **Windows Media Player cannot connect to the server. The server name might not be correct, the server might not be available, or your proxy settings might not be correct.**

## Solution

To resolve this issue, make sure that you're authenticated to Office 365 by using the **Keep me signed in** option. Also, add the affected URL or URLs to your Trusted sites zone in Internet Explorer.

### Add the URL to the Trusted sites zone

To add the affected SharePoint Online URL or URLs to your **Trusted sites** zone in Internet Explorer, follow these steps:

1. Start Internet Explorer.

1. Depending on your version of Internet Explorer, do one of the following:

    - On the **Tools** menu, click **Internet options**.
    
    - Click the gear icon, and then click **Internet options**.

1. Click the **Security** tab, click **Trusted sites**, and then click **Sites**.

    ![The Security tab in Internet Options](./media/windows-media-player-cannot-connect-to-server/internet-options.jpg)

1. In the **Add this website to the zone** box, type the URL for the SharePoint Online site that you want to add to the **Trusted sites** zone, and then click **Add**. For example, type `https://contoso.sharepoint.com`. (Here, the **contoso** placeholder represents the domain that you use for your organization.) Repeat this step for any additional sites that you want to add to this zone.

   ![Trusted sites dialog box](./media/windows-media-player-cannot-connect-to-server/trusted-sites.jpg)

1. After you have added each site to the **Websites** list, click **Close**, and then click **OK**.

### Authenticate to Office 365

Make sure that you're authenticated to Office 365. To do this, sign in to the SharePoint Online site by using your Office 365 work or school account credentials, and then select the **Keep me signed in** check box.

> [!NOTE]
> If you didn't previously check this setting and then browse to a SharePoint Online site or to the Office 365 portal, and you're already signed in, you must first sign out, and then sign in again by using the Keep me signed in check box. To do this, follow these steps:
>
> 1. On the Office 365 ribbon, click the drop-down arrow next to your user name.
>
> 1. Click **Sign out**.
>
> 1. Close all browser windows.
>
> 1. Browse to the Office 365 portal.
>
> 1. Select the **Keep me signed in** check box, enter your Office 365 work or school account credentials, and then click **Sign in** (if necessary).

> [!NOTE]
> If you're on a shared computer, make sure that you sign out when your session is complete.

## More information

This article doesn't apply to Office 365 Video or Microsoft Stream scenarios. For more information about Office 365 Video, go to [Introducing Office 365 Video](https://www.microsoft.com/en-us/microsoft-365/blog/2014/11/18/introducing-office-365-video/).

> [!NOTE]
> Office 365 Video will be replaced by Microsoft Stream. To learn more about the new enterprise video service that adds intelligence to video collaboration, go to https://stream.microsoft.com. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
