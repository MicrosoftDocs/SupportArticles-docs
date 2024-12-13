---
title: HTTP error 401.1 with pre-authentication headers
description: An unexpected 401.1 status is returned when you use Pre-Authentication headers with Internet Explorer and Internet Information Services (IIS).
ms.date: 12/13/2024
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: bretb, mlaing, zixie
---
# An unexpected 401.1 status is returned when you use Pre-Authentication headers with Internet Explorer and IIS

This article resolves the problem where an unexpected 401.1 status is returned with Pre-Authentication headers. It occurs when you use Internet Explorer to browser to a web application hosted on Internet Information Services (IIS).

_Original product version:_&nbsp;Internet Explorer mode in Microsoft Edge, Internet Explorer 11, Internet Information Services  
_Original KB number:_&nbsp;2749007

## Symptoms

Consider the following scenario:

- You use Internet Explorer (or Internet Explorer mode in Microsoft Edge) to browse a web application hosted on IIS.
- The client machine is configured to use Pre-Authentication in Internet Settings, and Kernel Mode Authentication is enabled in IIS.
- The web request sent by Internet Explorer (or Internet Explorer mode in Microsoft Edge) is the first request to be sent to the IIS application.

In this scenario, IIS might return a HyperText Transfer Protocol (HTTP) 401.1 response to Internet Explorer (or Internet Explorer mode in Microsoft Edge) in response to the browser's request. The web browser might prompt you to enter your username and password. Or, an HTTP 401.1 error message might be displayed in the browser window.

## Cause

This behavior is by design. The 401.1 response occurs if the web browser's first request that's sent to the IIS application contains one of the following headers:

- A Windows Challenge/Response (NTLM) header
- A Negotiate WWW-Authorization header (known as Pre-Authentication)

> [!NOTE]
> There are many reasons a user might be prompted for credentials in Internet Explorer that are outside the scope of this article. See the [More information](#more-information) section to learn how to determine if the cause of the prompt is from the issue described here.

## Workaround

To work around this behavior, disable Pre-Authentication in Internet Settings or turn off Kernel Mode Authentication for the IIS Web application.

> [!WARNING]
> If you use Registry Editor incorrectly, you might cause serious problems that might require you to reinstall your operating system. Microsoft can't guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To modify this behavior in Internet Explorer, use Registry Editor (**Regedt32.exe**) to add a value to the following registry key:

`HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Internet Settings/`

> [!NOTE]
> The registry key is a path; it has been wrapped for readability.

Add the following registry values:

- Value Name: `DisableNTLMPreAuth`  
- Data Type: `REG_DWORD`  
- Value: `1`

To modify this behavior in IIS, disable Kernel Mode Authentication for the IIS web application:

1. Open Internet Information Services (IIS) Manager by running the following command from an administrative command prompt:

    ```console
    %windir%\System32\inetsrv\inetmgr.exe
    ```

2. In the **Connections** pane, expand the server name, expand **Sites**, and then expand the site, application, or Web service for which you want to disable Kernel Mode Authentication.

3. Scroll to the **Security** section in the **Home** pane, and then double-click **Authentication**.

4. In the **Authentication** pane, select **Windows Authentication**.

5. Select **Advanced Settings** in the **Actions** pane.

6. When the **Advanced Settings** dialog box appears, clear the **Enable Kernel-mode authentication** checkbox.

7. Select **OK** to close the **Advanced Settings** dialog box.

> [!IMPORTANT]
> Disabling Kernel Mode Authentication might cause web applications that require Kerberos authentication and delegation to fail.

## More information

To determine if the prompt is caused by the issue described in this article, use the Fiddler tool. Use the tool to view the HTTP request/response traffic for the request resulting in the prompt in Internet Explorer (or Internet Explorer mode in Microsoft Edge). You'll also need the IIS logs from the IIS Server to confirm the HTTP status and sub status codes. The following example uses Internet Explorer to illustrate this behavior:

1. Start the Fiddler Tool and enable traffic capture.
2. Browse to the IIS web application such that it will result in the prompt for credentials.
3. In Fiddler, look for the request that resulted in the 401. Looking at the raw request and response views, you'll see entries similar to the following ones:

    Request Headers:  

    ```console
    GET /App1/default.aspx HTTP/1.1
    Accept-Language: en-US
    Accept-Encoding: gzip, deflate
    Connection: Keep-Alive
    Host: websitename
    Cookie: ASP.NET_SessionId=jdzbfpnmacq0jykhxnhqhe3j
    Authorization: Negotiate
    <header content omitted>
    ```

    Response Headers  

    ```console
    HTTP/1.1 401 Unauthorized
    Content-Type: text/html
    Server: Microsoft-IIS/7.5
    WWW-Authenticate: Negotiate
    WWW-Authenticate: NTLM
    X-Powered-By: ASP.NET
    Date: Wed, 22 Aug 2012 17:41:09 GMT
    Content-Length: 1293
    Proxy-Support: Session-Based-Authentication
    ```

> [!NOTE]
> The initial request to the web application already contains the `Authorization` header, which then results in the 401 response. The corresponding IIS log should show an entry similar to the following one:

```output
2012-08-22 17:41:09 2001:4898:0:fff:200:5efe:157.59.113.72 GET /App1/default.aspx - 80 - 2001:4898:0:fff:0:
5efe:172.18.100.183 Mozilla/4.0+(compatible;+MSIE+7.0;+Windows+NT+6.1;+WOW64;+Trident/5.0;+SLCC2;+.NET+CLR+
2.0.50727;+.NET+CLR+3.5.30729;+.NET+CLR+3.0.30729;+Media+Center+PC+6.0;+.NET4.0C;+.NET4.0E;+InfoPath.3;+MS-
RTC+EA+2;+BRI/1;+Zune+4.7;+MS-RTC+LM+8;+BRI/2;+Creative+AutoUpdate+v1.41.02) 401 1 2148074254 5005
```

The HTTP status and sub status are 401.1, which maps to *Access Denied due to Invalid credentials*.

For more information, see the following documentation:

- [Windows Authentication \<windowsAuthentication>](/iis/configuration/system.webServer/security/authentication/windowsAuthentication/)

- [How IIS authenticates browser clients
](https://support.microsoft.com/help/264921)

- [Internet Explorer May Prompt Your for a Password](https://support.microsoft.com/help/258063)

- [Application for a Site \<application>](/iis/configuration/system.applicationHost/sites/site/application/)
