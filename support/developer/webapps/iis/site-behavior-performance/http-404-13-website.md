---
title: HTTP Error 404.13 when you visit website
description: This article describes a problem that occurs because a client request contains a Content-Length header that is larger than the value that is specified for this header in the ApplicationHost.config file.
ms.date: 04/17/2020
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: mlaing
---
# HTTP Error 404.13 - CONTENT_LENGTH_TOO_LARGE when you visit a web site that is hosted on a server that is running IIS 10.0 and later versions

This article helps you resolve the error (HTTP Error 404.13 - CONTENT_LENGTH_TOO_LARGE) that occurs when you visit a website in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 10.0 and later versions  
_Original KB number:_ &nbsp; 942074

## Symptoms

Consider the following scenario. You have a web site that is hosted on a server that is running IIS 10.0 and later versions. When a user visits this web site, the user receives an error message that resembles the following error message:

> Server Error in Application "**application name**"  
> HTTP Error 404.13 - CONTENT_LENGTH_TOO_LARGE  
> HRESULT: 0  
> Description of HRESULT # The operation completed successfully.

## Cause

This problem occurs because the client request contains a `Content-Length` header that is larger than the value (in bytes) that is specified for the `maxAllowedContentLength` attribute in the *ApplicationHost.config* file or the site-level *web.config* file.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Update the site-level web.config file (recommended)

Add or update the `maxAllowedContentLength` attribute in your site's *web.config* file. Set the value (in bytes) to match or exceed the size of the `Content-Length` header that the client sends. By default, the value of `maxAllowedContentLength` is 30000000 bytes (approximately 28.6 MB).

For example, to allow up to 50 MB, add the following inside the `<system.webServer>` section of your *web.config* file:

```xml
<system.webServer>
  <security>
    <requestFiltering>
      <requestLimits maxAllowedContentLength="52428800" />
    </requestFiltering>
  </security>
</system.webServer>
```

### Method 2: Edit the ApplicationHost.config file (server-wide)

1. Select **Start**. In the **Start Search** box, type *Notepad*. Right-click **Notepad**, and then select **Run as administrator**.

    > [!NOTE]
    > If you are prompted for an administrator password or for a confirmation, type the password, or select **Continue**.

2. On the **File** menu, select **Open**. In the **File name** box, type `%windir%\system32\inetsrv\config\applicationhost.config`, and then select **Open**.

3. In the *ApplicationHost.config* file, locate the `<requestLimits>` node.
4. Set the `maxAllowedContentLength` attribute to a value (in bytes) that matches or exceeds the size of the `Content-Length` header that the client sends as part of the request. By default, the value of `maxAllowedContentLength` is 30000000 bytes (approximately 28.6 MB). Alternatively, remove the attribute to revert to the default value.

    For example, modify the following configuration data inside the `<requestFiltering>` section:

    ```xml
    <requestLimits maxAllowedContentLength ="<length>" />
    ```

5. Save the *ApplicationHost.config* file.
