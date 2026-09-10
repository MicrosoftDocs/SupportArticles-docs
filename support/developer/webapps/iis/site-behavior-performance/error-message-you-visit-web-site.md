---
title: Fix IIS HTTP Error 404.17 for ASP.NET Applications
description: Fix HTTP error 404.17 in IIS when dynamic ASP.NET content reaches the static file handler. Match application pool settings to handler preconditions.
ms.date: 09/09/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: nagosang
ai-usage: ai-assisted
---
# HTTP error 404.17 - Not Found in IIS

_Original product version:_ &nbsp; Internet Information Services 10.0 and later versions  
_Original KB number:_ &nbsp; 2019689

## Summary

This article helps you resolve HTTP error 404.17 - Not Found when Internet Information Services (IIS) 10.0 and later versions route dynamic ASP.NET content to the static file handler. Match the application pool's .NET CLR version, pipeline mode, and 32-bit setting to the ASP.NET handler's preconditions.

## Symptoms

You have a Web site that is hosted on IIS 10.0 and later versions. When you browse to dynamic content in the Web site by using a Web browser, you might receive an error message that resembles the following:

> Error Summary  
HTTP Error 404.17 - Not Found  
The requested content appears to be script and won't be served by the static file handler.  
Detailed Error Information:  
>
> Module StaticFileModule  
Notification ExecuteRequestHandler  
Handler StaticFile  
Error Code 0x80070032  
>
> Requested URL `http://<ServerName>:80/page.aspx`  
Physical Path C:\inetpub\wwwroot\page.aspx  
Logon Method Anonymous  
Logon User Anonymous  

## Cause

This error occurs when the HTTP handler configured to handle the request has certain preconditions, but the application pool doesn't meet those preconditions. When this mismatch happens, IIS uses the static file handler to process the request. The request fails because it's for a dynamic resource, not a static one, and IIS returns a **404.17** status.

For example, consider the following handler mapping:

```xml
<add name="PageHandlerFactory-ISAPI-4.0_32bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness32" responseBufferLimit="0" />
```

If you request a `*.aspx` resource and the application pool doesn't run in `Classic` mode, isn't 32-bit, or doesn't use the .NET Framework 4.x CLR, IIS returns a **404.17** error. To serve the resource correctly, the application pool must meet all three preconditions: run in `Classic` mode, use the v4.0 .NET CLR version, and be set for 32-bit applications.

> [!NOTE]
> The same issue can occur with .NET Framework 2.0 handler mappings (using `runtimeVersionv2.0` and the `v2.0.50727` ISAPI path). The resolution is the same: ensure the application pool settings match all of the handler's preconditions.

## Solution

To resolve this issue, configure the application pool hosting the application to meet all of the preconditions set for the handler.

1. Open IIS Manager.
1. Expand the computer name and select **Application Pools** in the left pane.
1. Select the application pool hosting the resource in the middle pane.
1. In the far right pane, select **Advanced Settings...**.
1. In the **Advanced Settings** dialog under the **(General)** category, configure the following settings to match the handler's preconditions:

   - **.NET CLR Version** — Set to `v4.0` (for .NET Framework 4.x apps) or `v2.0` (for .NET Framework 2.0/3.5 apps).
   - **Enable 32-Bit Applications** — Set to `True` if the handler specifies `bitness32`.
   - **Managed Pipeline Mode** — Set to `Classic` or `Integrated` to match the handler's precondition.

## Inspect handler and application pool preconditions

The information in this section helps you identify which handlers are configured for the web site and application mentioned in the error. It also helps you identify the preconditions that are configured for that handler.

Use the following commands to identify the handlers configured for the web site listed in the output of the error.

### List application pools

Use the following commands to determine what application pool the application is running in. Then, list the preconditions configured for that application pool.

```console
C:\Windows\System32\inetsrv>appcmd.exe list apps /site.name:"Default Web Site"
APP "Default Web Site/" (applicationPool:DefaultAppPool)

C:\Windows\System32\inetsrv>appcmd.exe list apppools
APPPOOL "DefaultAppPool" (MgdVersion:v4.0,MgdMode:Integrated,state:Started)
```

### List handler mappings

Use this command to output the handlers configured for the specific application in the default web site.

```console
C:\Windows\System32\inetsrv>appcmd.exe list config "Default Web Site/<ApplicationName>" -section:handlers
```

```xml
<system.webServer>
  <handlers accessPolicy="Read, Script">
    <add name="PageHandlerFactory-ISAPI-4.0_32bit" path="*.aspx" verb="GET,HEAD,POST,DEBUG" modules="IsapiModule" scriptProcessor="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll" preCondition="classicMode,runtimeVersionv4.0,bitness32" responseBufferLimit="0" />
    <add name="StaticFile" path="*" verb="*" modules="StaticFileModule,DefaultDocumentModule,DirectoryListingModule" resourceType="Either" requireAccess="Read" />
  </handlers>
</system.webServer>
```

For ASP.NET, you might see many handlers configured for a `*.aspx` resource. In some cases, you just need to change the handler to match the application pool the application is running in. The following list shows common ASP.NET handler mappings with their various precondition settings.

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

## Reproduce HTTP error 404.17

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

    - *Web.config* with the following content:
  
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

1. Create an application in IIS that points to the directory with these two files.

1. Configure the new application to run in an application pool that is configured for **Integrated** mode (which doesn't match the `classicMode` precondition in the handler).

1. Browse to *test.aspx*.
