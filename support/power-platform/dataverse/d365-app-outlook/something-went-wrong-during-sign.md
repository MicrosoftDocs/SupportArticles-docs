---
title: Something went wrong during sign-in when accessing Dynamics 365 App for Outlook
description: Provides a solution to an error that occurs when you access the Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/04/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "Something went wrong during sign-in" error when you access Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you access the Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 3064194, 4035750

## Symptoms

When you open the Dynamics 365 app in Outlook, you receive one of the following error messages:

Error 1:

- > Something went wrong during sign-in. Please try again. If the problem persists, contact your system administrator.

Error 2:

- > Having trouble signing in?  
  > Something went wrong during sign-in. Please try adding the following URLs to your Trusted Sites:  
  > `https://*.dynamics.com`  
  > `https://login.microsoftonline.com`  
  > If the problem persists, contact your system administrator.

## Cause and resolution for error 1

### Cause 1

Microsoft Dynamics 365 App for Outlook was unable to connect to the authorization service to ensure that you're authorized to use this app.

#### Resolution

Close the app, and open it again. If the problem still exists, try closing your internet browser and reopening it again. If the problem continues, make sure the URLs used by Dynamics 365 and also your authentication URLs are using the same integrity level. Use one of the following options:

##### Option 1 - Add each of the Dynamics 365 URLs and your authentication URLs to the same security zone in Internet Explorer

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

##### Option 2 - Enable Protected Mode on each Internet Explorer security zone

By enabling Protected Mode on each Internet Explorer security zone, each URL will load in the same integrity level.

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. Click the **Security** tab.
3. Select each of the zones (**Internet**, **Local Intranet**, and **Trusted sites**).
4. While selecting each zone, verify the **Enable Protected Mode** checkbox is selected.
5. Click **OK** to close the Internet Options dialog box.

> [!NOTE]
> When Protected Mode is enabled for a security zone, the URLs will load in the low integrity level (most secure). When Protected Mode is disabled for a security zone, the URLs will load in the medium integrity level. If a URL isn't added to the **Trusted Sites** or **Local Intranet** zones, it will default to loading in the Internet zone, which has Protected Mode enabled by default.

### Cause 2

This issue can occur if your Dynamics 365 (online) URL was changed after the Dynamics 365 App for Outlook was installed. For example: If your Dynamics 365 URL was <`https://contosocorp.crm.dynamics.com`> when you deployed the app but you changed the URL to <`https://contoso.crm.dynamics.com`> later.

#### Resolution

If you changed your Dynamics 365 (online) URL after Microsoft Dynamics 365 App for Outlook was installed, you need to redeploy the app:

1. A user with the System Administrator role can redeploy the app to users by opening the Dynamics 365 web application, and then navigating to the Dynamics 365 App for Outlook area within Settings.
1. Select the users who should have the app redeployed and use one of the **Add App** buttons to redeploy the app.
1. After the Status changes to **Added to Outlook**, you can verify if the issue has been resolved. If you already had the app open, close and reopen it.

#### More information

You can verify if this issue is the result of Cause 2 by right-clicking on the **Help me resolve this issue** link in the error message and copying the URL. If you view the URL parameters, it contains the old Dynamics 365 URL. In the example provided earlier, it would show the old URL (`contosocorp.crm.dynamics.com`) instead of your current Dynamics 365 URL (`contoso.crm.dynamics.com`).

## Cause and resolution for error 2

Some of the URLs required to use the Dynamics 365 App for Outlook are in different Internet Explorer security zones (ex. **Internet**, **Trusted Sites**, or **Local Intranet**).

When using Dynamics 365 App for Outlook within Outlook desktop, Internet Explorer is used to display the content and also redirect you to authenticate as needed. The different security zones may be using different integrity levels depending on whether Protected Mode is enabled for the zone. If the different URLs load with different integrity levels, it will prevent authentication from being passed successfully from your authentication URLs to Dynamics 365.

### Resolution

To solve this issue, make sure the URLs used by Dynamics 365 and also your authentication URLs are using the same integrity level. Use one of the opotions:

- [Option 1 - Add each of the Dynamics 365 URLs and your authentication URLs to the same security zone in Internet Explorer](#option-1---add-each-of-the-dynamics-365-urls-and-your-authentication-urls-to-the-same-security-zone-in-internet-explorer)
- [Option 2 - Enable Protected Mode on each Internet Explorer security zone](#option-2---enable-protected-mode-on-each-internet-explorer-security-zone)
