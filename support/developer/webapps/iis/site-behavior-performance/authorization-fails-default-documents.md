---
title: Authorization fails for requests to the default document
description: This article provides resolutions for the problem where authorization fails for requests to the default document even though the default document is allowed in the authorization tag.
ms.date: 04/17/2020
ms.custom: sap:Site Behavior and Performance
---
# Authorization fails for requests to the default document in IIS

This article helps you resolve the problem where authorization doesn't work for the requests to a default document in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2620604

## Symptoms

Consider the following scenario. You have a web server running IIS. The web server hosts an ASP.NET web application that is configured to use forms authentication and a default document. HTTP requests sent to the root of the web application will fail and users will be forced to re-authenticate, even though the default document is set to allow users via the `<authorization>` section of the IIS configuration file.

## Cause

In this scenario, the pertinent sections of the IIS configuration will look similar to the following:

```xml
<system.web>
    <authentication mode="Forms">
        <forms name="FormsCookie" defaultUrl="Home.aspx" loginUrl="Login.aspx" path="/" />
    </authentication>
    <authorization>
        <deny users="?" />
        <allow users="*" />
    </authorization>
</system.web>
<location path="Default.aspx">
    <system.web>
        <authorization>
            <allow users="*" />
        </authorization>
    </system.web>
</location>
```

If the extensionless URL handlers are not enabled, when a request is sent to the root of the site the IIS static file handler will act first and redirect the request to the configured default document. For example, if the default document is set to *default.aspx* and the site name is `http://www.contoso.com`, sending a request to `http://www.contoso.com` will automatically send the user to `http://www.contoso.com/default.aspx`. Next, ASP.NET will come in to play due to the .aspx extension of the request URL and will serve *default.aspx* to the user in accordance with the authorization setting in the `<location>` tag section of the configuration file.

If the extensionless URL handlers are enabled, the ASP.NET extensionless URL handler will act first for the request to `http://www.contoso.com`. ASP.NET determines that the URL requires authentication, so the user is redirected to the forms authentication login page before the IIS static file handler gets a chance to request the default document.

## Workaround

If your web application does not require the extensionless URL feature, then the wildcard handlers can safely be removed from the application configuration. In the IIS Manager, under the **Handler Mappings** section for the application, remove the following handlers:

- `ExtensionlessUrl-Integrated-4.0`
- `ExtensionlessUrl-ISAPI-4.0_32bit`
- `ExtensionlessUrl-ISAPI-4.0_64bit`

## More information

For more information, see [An update is available that enables IIS handlers to handle requests whose URLs do not end with a period](https://support.microsoft.com/help/980368).
