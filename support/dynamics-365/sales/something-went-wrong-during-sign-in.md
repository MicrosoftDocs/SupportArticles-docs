---
title: Something went wrong during sign-in
description: Fixes an issue in which you get the Something went wrong during sign-in error when using Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# "Something went wrong during sign-in" error using Microsoft Dynamics 365 App for Outlook

This article helps you fix an issue in which you get the "Something went wrong during sign-in" error when using Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4035750

## Symptoms

When using the Dynamics 365 App for Outlook within Outlook desktop, you encounter the following error:

> Having trouble signing in?  
> Something went wrong during sign-in. Please try adding the following URLs to your Trusted Sites:  
> `https://*.dynamics.com`  
> `https://login.microsoftonline.com`  
> If the problem persists, contact your system administrator."

## Cause

Some of the URLs required to use the Dynamics 365 App for Outlook are in different Internet Explorer security zones (ex. **Internet**, **Trusted Sites**, or **Local Intranet**).

When using Dynamics 365 App for Outlook within Outlook desktop, Internet Explorer is used to display the content and also redirect you to authenticate as needed. The different security zones may be using different integrity levels depending on whether Protected Mode is enabled for the zone. If the different URLs load with different integrity levels, it will prevent authentication from being passed successfully from your authentication URLs to Dynamics 365.

## Resolution

Make sure the URLs used by Dynamics 365 and also your authentication URLs are using the same integrity level. Use one of the following resolutions:

### Option 1 - Add each of the Dynamics 365 URLs and your authentication URLs to the same security zone in Internet Explorer

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. Click the **Security** tab, click the **Trusted Sites** zone, and then click **Sites.**  
3. In **Add this website to the zone**, type the following URLs one at a time:

    `*.dynamics.com`  
    `*.microsoftonline.com`  
    `https://login.windows.net`  

    > [!IMPORTANT]
    > If you use federated authentication to access Dynamics 365 using your corporate credentials, you also need to add the authentication URLs used by your company. For example: If your company uses Active Directory Federation Services (ADFS) with an authentication URL of `https://adfs.contoso.com/...`, add this URL to the same zone or make sure both zones have the same Protected Mode setting.  

4. Click **Add**, click **Close**, and then click **OK**.
5. Click **OK** to close the Internet Options dialog box.

### Option 2 - Enable Protected Mode on each Internet Explorer security zone

By enabling Protected Mode on each Internet Explorer security zone, each URL will load in the same integrity level.

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. Click the **Security** tab.
3. Select each of the zones (**Internet**, **Local Intranet**, and **Trusted sites**).
4. While selecting each zone, verify the **Enable Protected Mode** checkbox is selected.
5. Click **OK** to close the Internet Options dialog box.

## More information

When Protected Mode is enabled for a security zone, the URLs will load in the low integrity level (most secure). When Protected Mode is disabled for a security zone, the URLs will load in the medium integrity level. If a URL isn't added to the **Trusted Sites** or **Local Intranet** zones, it will default to loading in the Internet zone, which has Protected Mode enabled by default.
