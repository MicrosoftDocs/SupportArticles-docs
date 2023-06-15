---
title: Set current culture programmatically in ASP.NET
description: This article describes that how to change the current culture and CurrentUICulture in an ASP.NET application.
ms.date: 04/07/2020
ms.custom: sap:Development
ms.reviewer: cissyh
ms.topic: how-to
---
# Set current culture programmatically in an ASP.NET application

This article describes how to change the current culture and current UI culture in an ASP.NET application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306162

## Summary

In the .NET Framework, the `CultureInfo` class from the `System.Globalization` namespace provides culture-specific information such as the associated language, country/region, calendar, and cultural conventions. The `CurrentCulture` property represents the culture that the current thread uses. The `CurrentUICulture` property represents the current culture that Resource Manager uses to look up culture-specific resources at run time. There are three ways to set the Culture information in an ASP.NET application: application level, page level, and thread level.

## Application level

Specify application level culture information in the *web.config* file:

1. Start Notepad (or any other text editor).
2. Paste the following code in Notepad:

    ```xml
    <configuration>
        <system.web>
            <globalization
                culture="ja-JP"
                uiCulture="zh-HK"
            />
        </system.web>
    </configuration>
    ```

3. Save the text file as *web.config* in the root folder of your Web server. For example, `C:\Inetpub\wwwroot\Web.config`.
4. Start another instance of Notepad. Paste the following code in Notepad:

    ```aspx-csharp
    <%@Page Language="C#" %>
    <% @Import Namespace="System.Globalization" %>
    <html>
        <head>
        </head>
        <script runat=server>
            public void Page_Load()
            {
                Response.Write ("Current Culture is " + CultureInfo.CurrentCulture.EnglishName);
            }
        </script>
        <body>
        </body>
    </html>
    ```

5. Save this text file as *Application.aspx* in the root folder of your Web server.
6. Start Internet Explorer, and then open *Application.aspx*.

## Page level

The page level culture-specific information settings override the application level culture-specific information settings. Specify page level culture information by using the `<@Page>` directive:

1. Follow steps 1, 2, and 3 of the [Application level](#application-level) section to create the *web.config* file.
2. Start another instance of Notepad. Paste the following code in Notepad:

    ```aspx-csharp
    <%@Page Culture="fr-FR" Language="C#" %>
    <% @Import Namespace="System.Globalization" %>
    <html>
        <head>
        </head>
            <script runat=server>
            public void Page_Load()
            {
                Response.Write ("Current Culture is " + CultureInfo.CurrentCulture.EnglishName);
            }
            </script>
        <body>
        </body>
    </html>
    ```

3. Save this text file as *Page.aspx* in the root folder of your Web server.
4. Start Internet Explorer, and then open *Page.aspx*.
    > [!NOTE]
    > The Current Culture setting is French, although Japanese is specified as the current culture in the *web.config* file.

## Thread level

The thread level culture-specific information settings override the page level culture-specific information settings. Specify the thread level culture-specific information by setting the `CurrentCulture` property or the `CurrentUICulture` property of the current thread:

1. Follow the steps 1, 2, and 3 of the [Application level](#application-level) section to create the *web.config* file.
2. Start another instance of Notepad. Paste the following code in Notepad:

    ```csharp
    <% @Page Culture="fr-FR" Language="C#" %>
    <% @Import Namespace="System.Globalization" %>
    <% @Import Namespace="System.Threading" %>
    <html>
        <head>
        </head>
            <script runat=server>
            public void Page_Load()
            {    // Display the Current Culture
                Response.Write("Current Culture is " + Thread.CurrentThread.CurrentCulture.EnglishName + "<br>");

                // Modify the Current Culture
                Thread.CurrentThread.CurrentCulture = new CultureInfo("de-DE");
                Response.Write("Changing Culture to " + Thread.CurrentThread.CurrentCulture.EnglishName + "<br>");
            }
            </script>
        <body>
        </body>
    </html>
    ```

3. Save this text file as *Thread.aspx* in the root folder of your Web server.
4. Start Internet Explorer, and then open *Thread.aspx*.

    > [!NOTE]
    > The current culture setting is German, although French is specified at the page level and Japanese is specified in the *web.config* file.

## References

For more information, see [CultureInfo Class](/dotnet/api/system.globalization.cultureinfo).
