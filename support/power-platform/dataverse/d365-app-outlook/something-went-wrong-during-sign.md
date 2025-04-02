---
title: Something went wrong during sign-in when accessing Dynamics 365 App for Outlook
description: Solves the error that occurs when you sign in to Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/14/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "Something went wrong during sign-in" error when you access Dynamics 365 App for Outlook

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 3064194, 4035750

This article provides solutions to the following sign-in errors that might occur when you access [Microsoft Dynamics 365 App for Outlook](/dynamics365/outlook-app/overview).

- [Something went wrong during sign-in. Please try again. If the problem persists, contact your system administrator.](#error-1)  
- [Something went wrong during sign-in. Please try adding the following URLs to your Trusted Sites:](#error-2)

## Error 1

When you try to open the Dynamics 365 App for Outlook while using Outlook on the desktop, web, or mobile, you might receive the following error message:

> Something went wrong during sign-in. Please try again. If the problem persists, contact your system administrator.

### Cause 1

The Dynamics 365 App for Outlook can't connect to the authorization service to ensure that you're authorized to use this app.

#### Resolution

To solve this issue, first you can try to close and reopen the app. If the issue persists, try closing and reopening your internet browser. If the problem continues, try the following options to ensure the URLs used by Dynamics 365 and your authentication URLs use the same integrity level.

##### Option 1 - Add each of the Dynamics 365 URLs and your authentication URLs to the same security zone in Internet Explorer

1. In Internet Explorer, select **Tools** > **Internet Options**.
2. Select the **Security** tab, select the **Trusted Sites** zone, and then select **Sites**.
3. In **Add this website to the zone**, type the following URLs one at a time:

    `*.dynamics.com`  
    `*.microsoftonline.com`  
    `https://login.windows.net`  

    > [!IMPORTANT]
    > If you use federated authentication to access Dynamics 365 using your corporate credentials, you also need to add the authentication URLs used by your company. For example, If your company uses [Active Directory Federation Services (AD FS)](/windows-server/identity/ad-fs/ad-fs-overview) with an authentication URL of `https://adfs.contoso.com/...`, add this URL to the same zone or make sure both zones have the same Protected Mode setting.  

4. Select **Add**, and then select **OK** to save the sites.

##### Option 2 - Enable Protected Mode on each Internet Explorer security zone

By enabling Protected Mode on each Internet Explorer security zone, each URL loads in the same integrity level.

1. In Internet Explorer, select **Tools** > **Internet Options**.
2. Select the **Security** tab.
3. Select each of the zones (**Internet**, **Local Intranet**, and **Trusted sites**).
4. While selecting each zone, verify the **Enable Protected Mode** checkbox is selected.
5. Select **OK** to close the **Internet Options** dialog box.

> [!NOTE]
> When Protected Mode is enabled for a security zone, the URLs load in the low integrity level (most secure). When Protected Mode is disabled for a security zone, the URLs load in the medium integrity level. If a URL isn't added to the **Trusted Sites** or **Local Intranet** zones, it defaults to loading in the Internet zone, which has Protected Mode enabled by default.

### Cause 2

This issue can occur if your Dynamics 365 (online) URL is changed after the Dynamics 365 App for Outlook is installed. For example, if your Dynamics 365 URL is `https://contosocorp.crm.dynamics.com` when you deploy the app, but you change the URL to `https://contoso.crm.dynamics.com` later.

You can verify if this is the cause of the issue by right-clicking the **Help me resolve this issue** link in the error message and checking the URL. If the URL is the old URL instead of your current Dynamics 365 URL, that could be the reason for the error.

#### Resolution

If you change your Dynamics 365 (online) URL after the Dynamics 365 App for Outlook is installed, you need to redeploy the app:

1. A user with the System Administrator role can redeploy the app to users by opening the Dynamics 365 web application and navigating to the **Dynamics 365 App for Outlook** area within **Settings**.

1. Select the users who should have the app redeployed and use one of the **Add App** buttons to redeploy the app.

1. After the **Status** changes to **Added to Outlook**, you can verify if the issue is resolved. If you already have the app open, close and reopen it.

## Error 2

When you try to open the Dynamics 365 App for Outlook while using Outlook on the desktop, you might receive the following error message:

> Having trouble signing in?  
> Something went wrong during sign-in. Please try adding the following URLs to your Trusted Sites:  
> `https://*.dynamics.com`  
> `https://login.microsoftonline.com`  
> If the problem persists, contact your system administrator.

### Cause

Some of the URLs required to use the Dynamics 365 App for Outlook are in different [Internet Explorer security zones](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537183(v=vs.85)) (for example, Local Intranet Zone, Trusted Sites Zone, or Internet Zone).

When using Dynamics 365 App for Outlook within Outlook on the desktop, Internet Explorer is used to display the content and also redirect you to authenticate as needed. The different security zones might use different integrity levels, depending on whether Protected Mode is enabled for the zone. If the different URLs load with different integrity levels, it prevents authentication from being passed successfully from your authentication URLs to Dynamics 365.

### Resolution

To solve this issue, use one of the following options to ensure the URLs used by Dynamics 365 and your authentication URLs use the same integrity level:

- [Option 1 - Add each of the Dynamics 365 URLs and your authentication URLs to the same security zone in Internet Explorer](#option-1---add-each-of-the-dynamics-365-urls-and-your-authentication-urls-to-the-same-security-zone-in-internet-explorer)
- [Option 2 - Enable Protected Mode on each Internet Explorer security zone](#option-2---enable-protected-mode-on-each-internet-explorer-security-zone)
