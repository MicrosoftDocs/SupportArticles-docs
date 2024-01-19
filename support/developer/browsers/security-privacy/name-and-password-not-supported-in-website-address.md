---
title: URL syntax doesn't contain a username and password
description: Discusses the default behavior of Internet Explorer for handling user information, such as user name and password, in HTTP and in HTTPS URLs.
ms.date: 06/03/2020
ms.reviewer: josborne, ericlaw, gsilva
---
# Internet Explorer does not support user names and passwords in Web site addresses (HTTP or HTTPS URLs)

[!INCLUDE [](../../../includes/browsers-important.md)]

This article is intended to notify Web site administrators and IT professionals about the behavior of Internet Explorer when user information is included in a Web site address (HTTP or HTTPS URL).

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 834489

## Summary

By default, versions of Internet Explorer that were released starting with the release of security update 832894 do not support handling user names and passwords in HTTP and HTTP with Secure Sockets Layer (SSL) or HTTPS URLs. The following URL syntax is not supported in Internet Explorer or in Windows Explorer:

`http(s)://username:password@server/resource.ext`

This article is intended to notify you of this default behavior of Internet Explorer. If you include user information in HTTP or HTTPS URLs, we recommend that you explore the workarounds that are described in this article.

## Background information

Internet Explorer versions 3.0 to 6.0 support the following syntax for HTTP or HTTPS URLs:

`http(s)://username:password@server/resource.ext`

You can use this URL syntax to automatically send user information to a Web site that supports the basic authentication method.

A malicious user might use this URL syntax to create a hyperlink that appears to open a legitimate Web site but actually opens a deceptive (spoofed) Web site. For example, the following URL appears to open `http://www.wingtiptoys.com` but actually opens `http://example.com`:

`http://www.wingtiptoys.com@example.com`

> [!NOTE]
> In this case, Internet Explorer 6 Service Pack 1 (SP1) and Internet Explorer 6 for Microsoft Windows Server 2003 only display `http://example.com` in the Address bar. However, earlier versions of Internet Explorer display `http://www.wingtiptoys.com@example.com` in the Address bar.

Additionally, malicious users can use this URL syntax together with other methods to create a link to a deceptive (spoofed) Web site that displays the URL to a legitimate Web site in the **Status bar**, **Address bar**, and **Title bar** of all versions of Internet Explorer. For more information on this issue, click the article number [833786](https://support.microsoft.com/help/833786/steps-that-you-can-take-to-help-identify-and-to-help-protect-yourself) to help protect yourself from deceptive (spoofed) Web sites and malicious hyperlinks.

## Explanation of the change in the default behavior

To mitigate the issues that are discussed in the **Background information** section, Internet Explorer and Windows Explorer no longer support handling HTTP and HTTPS URLs of this form. Windows Explorer and Internet Explorer do not open HTTP or HTTPS sites by using a URL that includes user information. By default, if user information is included in an HTTP or an HTTPS URL, a Web page that has the following title appears:

> Invalid syntax error.

> [!NOTE]
> This change in the default behavior does not affect other protocols.

This change in the default behavior is also implemented by security updates, service packs, and versions of Internet Explorer that were released starting with the release of security update 832894.

## Workarounds for users

1. URLs that are opened by users who type the URL in the Address bar or click a link

    If users typically type HTTP or HTTPS URLs that include user information in the Address bar, or click links that include user information in HTTP or HTTPS URLs, you can work around this new functionality in Internet Explorer in two ways:

    - Do not include user information in HTTP or HTTPS URLs.
    - Instruct users not to include their user information when they type HTTP or HTTPS URLs.

    If the Web site uses the basic authentication method, Internet Explorer automatically prompts users for a user name and a password. In some cases, users can click the **Remember my password** box in the dialog box to save their credentials for later visits to that Web site.

## Workarounds for application and Web site developers

1. URLs that are opened by objects that call WinInet or Urlmon functions

    For objects that use an HTTP or an HTTPS URL that includes user information when they call a WinInet or Urlmon function such as InternetOpenURL, rewrite the object to use one of the following methods to send user information to the Web site:

    - Use the InternetSetOption function and include the following option flags:
      - `INTERNET_OPTION_USERNAME`
      - `INTERNET_OPTION_PASSWORD`

    > [!NOTE]
    > For these flags, the InternetSetOption option must have a handle returned by the InternetConnect function. Therefore, if the application uses the InternetOpenUrl function, modify the application to use the InternetConnect , HttpOpenRequest and HttpSendRequest WinInet functions.

    For more information about how to use these functions, visit the following Microsoft Web sites:

    - [InternetConnectA function](/windows/win32/api/wininet/nf-wininet-internetconnecta)
    - [HttpOpenRequestA function](/windows/win32/api/wininet/nf-wininet-httpopenrequesta)
    - [HttpSendRequestA function](/windows/win32/api/wininet/nf-wininet-httpsendrequesta)

    For more information about how to use the **IAuthenticate** Interface, visit the following Microsoft Web site:

    - [IAuthenticate interface](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms775080(v=vs.85))

    > [!NOTE]
    > With this workaround, you can open Web sites that the URL-spoofing technique redirects. The whole URL appears, including the redirected location.

    For example, the following URL appears:

    `http://www.wingtiptoys.com@www.example.com`

    The user still arrives at the redirected Web site. In this example, the user arrives at `http://www.example.com`.

2. URLs that are opened by a script that uses credentials for state management

    If you include HTTP or HTTPS URLs that contain user information in your scripting code, to manage state information, change your scripting code to use cookies instead of user information. For more information about how to use cookies to manage state information, see [HTTP State Management Mechanism](http://www.ietf.org/rfc/rfc2965.txt).

    To see an example of how to use Visual Basic to read and write HTTP cookies in an ASP.NET Web program, see [HttpCookie Class](/dotnet/api/system.web.httpcookie?view=netframework-4.8&preserve-view=true).

## How to disable the new behavior or to use it in other programs

You can set registry values to use this new behavior in other programs that host the Web browser control or to disable this new behavior for Windows Explorer and Internet Explorer.

1. How programs that host the Web browser control can use this new default behavior to handle user information in HTTP or in HTTPS URLs

    By default, this new default behavior for handling user information in HTTP or HTTPS URLs applies only to Windows Explorer and Internet Explorer. To use this new behavior in other programs that host the Web browser control, create a **DWORD** value named **SampleApp.exe**, where **SampleApp.exe** is the name of the executable file that runs the program. Set the **DWORD** value's value data to 1 in one of the following registry keys.

    - For all users of the program, set the value in the following registry key:

      `HKEY_LOCAL_MACHINE\Software\Microsoft\InternetExplorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE`

    - For the current user of the program only, set the value in the following registry key:

      `HKEY_CURRENT_USER\Software\Microsoft\InternetExplorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE`

2. How to disable the new default behavior for handling user information in HTTP or HTTPS URLs

    To disable the new default behavior in Windows Explorer and Internet Explorer, create **iexplore.exe** and **explorer.exe DWORD** values in one of the following registry keys and set their value data to 0.

    - For all users of the program, set the value in the following registry key:

        `HKEY_LOCAL_MACHINE\Software\Microsoft\InternetExplorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE`

    - For the current user of the program only, set the value in the following registry key:

        `HKEY_CURRENT_USER\Software\Microsoft\InternetExplorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE`

## References

For an explanation of the standard URL syntax for HTTP or HTTPS URLs, visit the following Internet Engineering Task Force (IETF) Web sites:

- [RFC 1738: Uniform Resource Locators (URL)](http://www.ietf.org/rfc/rfc1738.txt)
- [RFC 2396: Uniform Resource Identifiers (URI): Generic Syntax](http://www.ietf.org/rfc/rfc2396.txt)
- [RFC 2616: Hypertext Transfer Protocol--HTTP/1.1](http://www.ietf.org/rfc/rfc2616.txt)

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
