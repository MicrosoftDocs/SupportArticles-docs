---
title: No Connected icon when connecting to remote application
description: Works around an issue where the Connected icon doesn't appear in the notification area when you connect to a remote application by using Remote Desktop Web Access.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:rdweb, csstroubleshoot
---
# The "Connected" icon doesn't appear in the notification area when you connect to a remote application by using Remote Desktop Web Access

This article provides a workaround for an issue where the Connected icon doesn't appear in the notification area when you connect to a remote application by using Remote Desktop Web Access.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 977507

## Symptoms

When you connect to a remote application by using Remote Desktop Web Access (RD Web Access) on a computer that is running Windows Server 2008 R2, the **Connected** icon does not appear in the notification area.

> [!NOTE]
> When you first run a remote application, the **Connected** icon appears in the notification area.

WebSSO (Web Single Sign On) does not work as expected, causing a "double prompt" for credentials in applications launched via RemoteApps published via Remote Desktop Web Access in Windows Server 2008 R2.

## Cause

This issue occurs when there are multiple unexpired cookies on the client computer.

## Workaround

To work around this issue, delete the cookies.

To delete the cookies in Windows Internet Explorer 8, follow these steps:

1. Click **Start**, click **Control Panel**, click **Network and Internet Connections**, and then click **Internet Options**.
2. On the **General** tab, click **Delete**.
3. To delete just the cookies, click to select the **Cookies** check box, and then click to clear all the other check boxes.
4. Click **Delete**.
Another option than deleting the cookies is to change the script file C:\windows\Web\RDWeb\Pages\renderscripts.js on the RD Web Access server.

To change the script file C:\windows\Web\RDWeb\Pages\renderscripts.js, follow these steps:

1. Log in to the Remote Desktop Web Access server as a member in the local Administrators group.
2. Browse to the following jscript file, right-click, and select Edit.

    C:\windows\Web\RDWeb\Pages\renderscripts.js

3. Find the implement of the following function in that jscript file.
    function getCookieContents(strNameOfCookie)

4. Modify the codes in the jscript file to match the following:

    Existing code in Renderscripts.js file:

    ```js
    function getCookieContents(strNameOfCookie)
    {
        var objCookie;
        var objCookieName;
        var objCookieContents = null;
        
        if ( strNameOfCookie != null &&
        strNameOfCookie != "" &&
        document.cookie.length > 0 )
        {
            var objCookies = document.cookie.split(";");
            for (var iIndex = 0; iIndex < objCookies.length; iIndex++)
            {
                objCookie = objCookies[iIndex];
                objCookieName = objCookie.substring(0, strNameOfCookie.length);
            }
        }
    }
    ```
    
    Change the above section in the Renderscripts.js file to match the following:
    
    ```js
    // Add a function called trim as a method of the prototype
    // object of the String constructor.
    String.prototype.trim = function()
    {
        // Use a regular expression to replace leading and trailing
        // spaces with the empty string
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    // End of the new-added function
    
    function getCookieContents(strNameOfCookie)
    {
        var objCookie;
        var objCookieName;
        var objCookieContents = null;
    
        if ( strNameOfCookie != null &&
        strNameOfCookie != "" &&
        document.cookie.length > 0 )
        {
            var objCookies = document.cookie.split(";");
            for (var iIndex = 0; iIndex < objCookies.length; iIndex++)
            {
                objCookie = objCookies[iIndex];
                objCookie = objCookie.trim(); //Calling the new-added function
                objCookieName = objCookie.substring(0, strNameOfCookie.length);
            }
        }
    }
    ```

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus).

## More information

This issue may occur when the following conditions are true:

- Remote Desktop Web Access is in a subdomain that has a parent domain.
- The parent domain, or any other subdomain, writes a cookie that has the domain set to the parent domain level. This behavior shares the cookie between all subdomains.

If Remote Desktop Web Access is put at the parent domain level, the connection icon appears in the notification area. Additionally, the single sign on (SSO) feature, the remote application, and the Desktop Connection work as expected when you connect to the remote application.

Additionally this can be seen to occur when there's additional cookie information contained in the cookie presented back to the client by the Web server.
