---
title: Web page pop-up username and password box
description: This article describes that when you use different windows authentication, the Internet Explorer prompts you to enter valid credentials.
ms.date: 06/03/2020
ms.reviewer: clinth
---
# Internet Explorer may prompt you for a password

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information on the situation where several types of Windows authentication cause Internet Explorer to prompt for a username and password.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 258063

## Summary

The Web browser passes your user name and password to an Internet Information Services (IIS) Web server. The following scenarios describe the relationship between Internet Explorer and IIS about authentication.

## More information

> [!NOTE]
> Windows Integrated authentication, Windows NT Challenge/Response (NTCR), and Windows NT LAN Manager (NTLM) are the same and are used synonymously throughout this article.

- Internet Explorer prompts for a password when you're using Windows-Integrated authentication (Microsoft Windows NT Challenge/Response).

    The following conditions must be met for Internet Explorer to automatically authenticate a user's logon and password and maintain security:

  - Windows-Integrated authentication, also known as Windows NT Challenge/Response, must be enabled in the Web site properties in IIS. Anonymous authentication is attempted first, followed by Windows-Integrated authentication, Digest authentication (if applicable), and finally Basic (clear text) authentication.

  - Both the client and the Web server must be in the same Microsoft Windows NT-based or Microsoft Windows 2000-based domain. Or they must be in the trusted Windows NT-based or Windows 2000-based domains, in which the user's account can be granted permissions to resources on the IIS-based computer.

  - The user's browser must be Internet Explorer. Internet Explorer is the only browser that supports Windows-Integrated authentication (NTCR).

  - Internet Explorer must consider the requested URL to be on the intranet (local). If the computer name portion of the requested URL contains periods (such as `http://www.microsoft.com` and `http://10.0.0.1`), Internet Explorer assumes that the requested address exists on the Internet. And it doesn't pass any credentials automatically. Addresses without periods (such as `http://webserver`) are considered to be on the intranet (local); Internet Explorer passes credentials automatically. The only exception is addresses included in the Intranet zone in Internet Explorer.

  - Internet Explorer's Intranet zone security setting must be set to **Automatic logon only in Intranet zone**. It's the default setting for Internet Explorer. For more information about Internet Explorer security zones, see [Internet Explorer Security Zones](/archive/blogs/ie/ie-security-zones).

  - The user requesting the Web page must have appropriate file system (NTFS) permissions to the Web page, and all of the objects referenced in the Web page. For example, a user may have Full Control rights to a Web page, but is prompted for a password if the Web page refers to graphics that are in a secure folder.

- Internet Explorer prompts for a password when you're using Basic (clear text) authentication or Digest authentication.

    Internet Explorer doesn't pass your user name and password automatically when you're using Basic (clear text) authentication or Digest authentication. So, you're always prompted for credentials when you're using these authentication methods.

- Internet Explorer prompts for a password when you're using anonymous authentication.

    Anonymous authentication never prompts you for a password, because IIS already knows the user name and password of the anonymous account. You're prompted for a password because Internet Explorer has been forced to use an authentication method other than anonymous. It occurs because the anonymous user account (IUSR_computername by default) didn't gain access to one or more of the following items:

  - The requested file or Web page
  - Any of the requested objects embedded in the file or Web page (for example, images).
  - The ISAPI extensions associated with the requested file or web page (for example, and .shtml file).
