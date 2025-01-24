---
title: Disable documentation protocol for ASP.NET
description: This article describes how to disable the documentation protocol for ASP.NET web services.
ms.date: 04/08/2020
ms.custom: sap:Configuration
ms.topic: how-to
---
# Disable the documentation protocol for ASP.NET web services

This article describes how to disable the documentation protocol for ASP.NET web services.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 815149

## Summary

ASP.NET Web services facilitate the development of Web services clients by automatically generating documentation that describes how to communicate with the web service. Web services that have the documentation protocol enabled generate an HTML-formatted page when a browser request is received. This HTML-formatted page describes the following information:

- The operations that are supported
- The parameters that each operation accepts
- The type of data that should be passed in this parameters

The documentation protocol also generates an XML-formatted Web Services Description Language (WSDL) file. This file is designed to allow applications to understand how to structure requests to the Web service.

This information can be useful to developers, especially developers who create clients for public Web services. However, revealing detailed information about the functionality of private Web services increases the risk that the Web service will be misused by a malicious attacker. The documentation protocol always describes all functions and parameters of a Web service even if only a subset of those functions are intended to be publicly accessible.

## Remove the documentation protocol

To disable the documentation web services protocol for an ASP.NET application, follow these steps:

1. Open the *web.config* file from the web application's root directory in a text editor (for example, Notepad). If the *web.config* file doesn't exist, create a *web.config* file for the ASP.NET Application.
2. Add the `<webServices>` configuration element to the `system.web` element in the *web.config* file.
3. In the `<webServices>` element, add the `<protocols>` configuration element.
4. In the `<protocols>` element, add the `remove name="Documentation"` element.

    The following example shows the `<webServices>` configuration element added to a *web.config* file to disable the automatic generation of browser-friendly documentation:

    ```xml
    <webServices>
        <protocols>
            <remove name="Documentation"/>
        </protocols>
    </webServices>
    ```

5. Save the *web.config* file.

## References

- [How To Create the Web.config File for an ASP.NET Application](https://support.microsoft.com/help/815179)

- [How To Edit the Configuration of an ASP.NET Application](https://support.microsoft.com/help/815178)

- [HOW TO: Secure Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818014)
