---
title: InternetSetCookie failed error
description: Fixes an issue that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# InternetSetCookie failed error when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 3092666

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator."

When you select details, the following additional detail is shown:

> InternetSetCookie failed with error code: 87 at Microsoft.Crm.CookieManager.SetCookies(Uri webApplicationUri, CookieCollection cookies, CookieDataFlags cookieFlags, String p3pHeader)  
 at Microsoft.Crm.CookieManager.SetCookies(Uri webApplicationUri, CookieCollection cookies)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProviderBase`1.SetWebAppCookies()

## Cause

The server name in the URL contains an underscore character ("_"). Example: `https://crm_server`.

Microsoft Dynamics CRM for Microsoft Office Outlook uses the [InternetSetCookieExA function (wininet.h)](/windows/win32/api/wininet/nf-wininet-internetsetcookieexa) which doesn't work if the URL contains an underscore character.

## Resolution

To fix this issue, follow these steps:

1. Create a DNS alias for the server that doesn't use an underscore character ("_"). Example: `https://crmserver`.
2. Within Deployment Manager on the Microsoft Dynamics CRM server, select Microsoft Dynamics CRM in the upper-left corner and then select **Properties**.
3. Select the **Web Address** tab and update all URLs to use the DNS alias.
4. Select **OK**.
5. Attempt to configure Microsoft Dynamics CRM for Microsoft Office Outlook using the new URL that doesn't contain an underscore character.

## More information

[Session variables do not persist between requests after you install Internet Explorer security Patch](/troubleshoot/browsers/variables-not-persist-between-requests)
