---
title: Use authenticated proxy servers
description: Describes problems that you may encounter when you use apps that connect to the Internet if you use an Internet proxy server that requires authentication.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tode, tonyga
ms.custom: sap:web-application-proxy-wap-role-service, csstroubleshoot
---
# Using authenticated proxy servers together with Windows 8

This article provides help to solve an issue that occurs when you use apps that connect to the Internet if you use an Internet proxy server that requires authentication.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2778122

## Symptoms

If you use an Internet proxy server that requires authentication, you may encounter problems when you use apps that connect to the Internet.

Proxy servers that require authentication either require a username and password to access the Internet or authenticate users by using their current domain credentials.

Depending on your proxy configuration, you may encounter one of the following problems when you use Microsoft Store apps:

- You cannot install updates that are available in the Microsoft Store, and you may receive one of the following error messages:

  - > This app wasn't installed - view details.

  - > Something happened and this app couldn't be installed. Try again. Error code: 0x8024401c

- You cannot install new apps and may receive one of the following error messages:

  - > Your purchase couldnt be completed. Something happened and your purchase cant be completed.

  - > Something happened and this app couldn't be installed. Try again. Error code: 0x8024401c

- When you start the Microsoft Store app, you may receive the following error message:

  - > Your network proxy doesn't work with the Microsoft Store. Contact your system administrator for more information.

- Apps that are included with Windows 8 may indicate that you are not connected to the Internet. If you installed other apps from the Microsoft Store while you were connected to a different network, those apps may also indicate that you are not connected to the Internet. The apps may display one of the following error messages:

  - > There was a problem signing you in.

  - > You are not connected to the Internet.

- Live Tiles for some apps may not update their content or may never show live content.
- Windows Update may not check for updates or download updates, and you receive error code 8024401C or the following error message:
  - > There was a problem checking for updates.

## Resolution

The issues that are discussed in this article are resolved in Windows 8.1 and Windows Server 2012 R2.

## More information

If you are using Windows 8 or Windows Server 2012, you can reduce the effect of these issues by enabling unauthenticated access through the proxy server. We recommend that you enable unauthenticated access only for connections to URL addresses that are used by each app that has a problem. Some proxy servers may suggest that you create an allow list of URL addresses.

To resolve these issues as they relate to using Microsoft Store apps or to using Microsoft apps that are included with Windows 8 or Windows Update, you can include the following addresses in an allow list on the proxy server and enable HTTP and HTTPS access to them:

- login.live.com
- account.live.com
- clientconfig.passport.net
- wustat.windows.com
- *.windowsupdate.com
- *.wns.windows.com
- *.hotmail.com
- *.outlook.com
- *.microsoft.com
- *.msftncsi.com/ncsi.txt

To resolve these issues for other apps, you may have to contact the application vendor for information about the URL addresses that you should include in your allow list.
