---
title: Force SSL for specific pages
description: This article provides the steps to use Active Server Pages to force SSL for specific pages without making changes in the MMC.
ms.date: 08/10/2020
ms.prod-support-area-path: Active Server Pages
ms.reviewer: robmcm
ms.topic: how-to
---
# Use ASP to force SSL for specific pages  

This article describes how to use Active Server Pages (ASP) to force Secure Sockets Layer (SSL) for specific pages without making changes in the MMC.

_Original product version:_ &nbsp; Microsoft Active Server Pages
_Original KB number:_ &nbsp; 239875

## Summary

It is frequently good security practice to require SSL for certain pages on a Web site. Although this can be configured through the Internet Services Manager (ISM) in the Microsoft Management Console (MMC), you can also use ASP to force SSL for specific pages without making changes in the MMC.

> [!NOTE]
> It's recommended that all users upgrade to Internet Information Services (IIS) version 7.0 running on Windows Server 2008. IIS 7.0 significantly increases Web infrastructure security.

## Prerequisites

This article assumes the following conditions:

- IIS is running on standard ports:
  
  - HTTP = Port 80
  - HTTPS = Port 443

- IIS has a valid SSL certificate installed.
- The Web site or virtual server that is used does not use HTTP/1.1 host headers for name resolution.

## Force SSL by using ASP

To force SSL by using ASP, follow these steps:

1. Click **Start**, click **Run**, type *Notepad*, and then click **OK**.
2. Paste the following code into a blank Notepad document. On the **File** menu, click **Save As**, and then save the following code in the root of your Web server as an include file named *ForceSSL.inc*:

    ```asp
    <%
    If Request.ServerVariables("SERVER_PORT")=80 Then
        Dim strSecureURL
        strSecureURL = "https://"
        strSecureURL = strSecureURL & Request.ServerVariables("SERVER_NAME")
        strSecureURL = strSecureURL & Request.ServerVariables("URL")
        Response.Redirect strSecureURL
    End If
    %>
    ```

3. For each page that requires SSL, paste the following code at the top of the page to reference the include file from the previous step:

    ```asp
    <%@Language="VBSCRIPT"%>
    <!--#include virtual="/ForceSSL.inc"-->
    ```

When each page is browsed, the ASP code that is contained in the include file detects the port to determine if HTTP is used. If HTTP is used, the browser will be redirected to the same page by using HTTPS.

## References

- [How to create and install an SSL certificate in Internet Information Server 4.0](https://support.microsoft.com/help/228991)
