---
title: HTTP error 404.17 when you visit a Web site
description: This article provides resolutions for the HTTP Error 404.17 - Not Found error when you visit a Web site that is hosted on IIS 10.0 and later versions.
ms.date: 12/11/2020
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
---
# Error message when you visit a Web site that is hosted on IIS 10.0 and later versions: HTTP Error 404.17 - Not Found

This article helps you resolve the **HTTP Error 404.17 - Not Found** problem when you visit a Web site that is hosted on Internet Information Services (IIS) 10.0 and later versions.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2019689

## Symptoms

You have a Web site that is hosted on IIS 10.0 and later versions. When you browse to dynamic content in the Web site by using a Web browser, you may receive an error message that resembles the following:

> Error Summary  
HTTP Error 404.17 - Not Found  
The requested content appears to be script and will not be served by the static file handler.  
Detailed Error Information:  
>
> Module StaticFileModule  
Notification ExecuteRequestHandler  
Handler StaticFile  
Error Code 0x80070032  
>
> Requested URL http://iisserver:80/page.aspx  
Physical Path C:\inetpub\wwwroot\page.aspx  
Logon Method Anonymous  
Logon User Anonymous  

## Cause

This error occurs because the HTTP Handler configured to handle the request has certain preconditions set, but its Application pool does not meet some or all of these preconditions. This causes the static file handler to be used to process the request instead. The processing of the request then fails and the **404.17** status returned because the request is for a dynamic resource and not a static one.

For example, consider the following handler mapping:

```xml
<add name="PageHandlerFactory-ISAPI-4.0_32bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness32" responseBufferLimit="0" />
```

In this case, a **404.17** error is returned if the *.aspx* resource being requested from the site is handled in an Application pool that is not running in `Classic` Mode, is not 32-bit, or is not running the .NET Framework 4.x CLR. In order for the resource to be served correctly in this example, all three preconditions must be met. Specifically, the application pool hosting this resource would have to be configured for `Classic` Mode, it would need to be configured to use the v4.0 .NET CLR version, and it would need to be set for 32-bit applications.

> [!NOTE]
> The same issue can occur with .NET Framework 2.0 handler mappings (using `runtimeVersionv2.0` and the `v2.0.50727` ISAPI path). The resolution is the same: ensure the application pool settings match all of the handler's preconditions.

## Resolution

To resolve this issue, configure the Application Pool hosting the application to meet all of the pre-conditions set for the Handler.

1. Open the IIS Manager.
2. Expand the computer name and select **Application Pools** in the left pane.
3. Select the Application Pool hosting the resource in the middle pane.
4. In the far right pane, select **Advanced Settings...**
5. In the **Advanced Settings** dialog under the **(General)** category, configure the following settings to match the handler's preconditions:

   - **.NET CLR Version** — Set to `v4.0` (for .NET Framework 4.x apps) or `v2.0` (for .NET Framework 2.0/3.5 apps).
   - **Enable 32-Bit Applications** — Set to `True` if the handler specifies `bitness32`.
   - **Managed Pipeline Mode** — Set to `Classic` or `Integrated` to match the handler's precondition.

## More information

The information in this section is meant to help identifying which handlers are configured for the web site and application mentioned in the error, as well as help identify the pre-conditions that are configured for that handler.

### Appcmd.exe commands

The following commands can be used to identify the handlers configured for the Web Site listed in the output of the error.

### List application pool

The following commands show how to determine what application pool the application is running in, and then list the preconditions configured for that application pool.

```console
C:\Windows\System32\inetsrv>appcmd.exe list apps /site.name:"Default Web Site"
APP "Default Web Site/" (applicationPool:DefaultAppPool)

C:\Windows\System32\inetsrv>appcmd.exe list apppools
APPPOOL "DefaultAppPool" (MgdVersion:v4.0,MgdMode:Integrated,state:Started)
```

### List handlers

This command will output the handlers configured for the specific application in the default web site.

```console
C:\Windows\System32\inetsrv>appcmd.exe list config "Default Web Site/application" -section:handlers
```

```xml
<system.webServer>
  <handlers accessPolicy="Read, Script">
    <add name="PageHandlerFactory-ISAPI-4.0_32bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness32" responseBufferLimit="0" />
    <add name="StaticFile" path="*" verb="*" modules="StaticFileModule,DefaultDocumentModule,DirectoryListingModule" resourceType="Either" requireAccess="Read" />
  </handlers>
</system.webServer>
```

In the case of ASP.NET, there may be many handlers configured for a *.aspx* resource. In some cases, the handler may just need to be changed to match the application pool the application is running in. Below is a list of common ASP.NET handler mappings with their various precondition settings.

### ASP.NET 4.x handlers

- ASP.NET 4.x Integrated Mode 32/64-bit Handler

    ```xml
    <add name="PageHandlerFactory-Integrated-4.0" path="*.aspx" verb="GET,HEAD,POST,DEBUG" 
         type="System.Web.UI.PageHandlerFactory" preCondition="integratedMode,runtimeVersionv4.0" />
    ```

- ASP.NET 4.x Classic Mode 32-bit Handler

    ```xml
    <add name="PageHandlerFactory-ISAPI-4.0_32bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" 
        scriptProcessor="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness32" 
        responseBufferLimit="0" />
    ```

- ASP.NET 4.x Classic Mode 64-bit Handler

    ```xml
    <add name="PageHandlerFactory-ISAPI-4.0_64bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" 
         modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_isapi.dll" 
         preCondition="classicMode,runtimeVersionv4.0,bitness64" responseBufferLimit="0" />
    ```

### ASP.NET 2.0 handlers

- ASP.NET 2.0 Integrated Mode 32/64-bit Handler

    ```xml
    <add name="PageHandlerFactory-Integrated" path="*.aspx" verb="GET,HEAD,POST,DEBUG" 
         type="System.Web.UI.PageHandlerFactory" preCondition="integratedMode" />
    ```

- ASP.NET 2.0 Classic Mode 32-bit Handler

    ```xml
    <add name="PageHandlerFactory-ISAPI-2.0" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" 
        scriptProcessor="%windir%\Microsoft.NET\Framework\v2.0.50727\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv2.0,bitness32" 
        responseBufferLimit="0" />
    ```

- ASP.NET 2.0 Classic Mode 64-bit Handler

    ```xml
    <add name="PageHandlerFactory-ISAPI-2.0-64" path="*.aspx" verb="GET,HEAD,POST,DEBUG" 
         modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework64\v2.0.50727\aspnet_isapi.dll" 
         preCondition="classicMode,runtimeVersionv2.0,bitness64" responseBufferLimit="0" />
    ```

## Steps to reproduce

1. Create a directory that contains two files.  

    - *Test.aspx* with the following content:

        ```aspx-csharp
        <%@ Page Language="C#" %>
        <html>
        <body>
            <%= "Hello World" %>
        </body>
        </html>
        ```

    - *Web.config* with the content:
  
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <configuration>
            <system.webServer>
                <handlers>
                    <clear/>
                    <add name="PageHandlerFactory-ISAPI-4.0_64bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness64" responseBufferLimit="0" />
                    <add name="StaticFile" path="*" verb="*" modules="StaticFileModule,DefaultDocumentModule,DirectoryListingModule" resourceType="Either" requireAccess="Read" />
                </handlers>
            </system.webServer>
        </configuration>
        ```

2. Create an application in IIS that points to the directory with these two files.

3. Configure the new application to run in an application pool that is configured for **Integrated** mode (which doesn't match the `classicMode` precondition in the handler).

4. Browse to *test.aspx*.
