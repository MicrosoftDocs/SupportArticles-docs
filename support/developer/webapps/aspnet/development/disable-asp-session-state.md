---
title: Disable ASP session state in ASP.NET
description: This article demonstrates how to disable session state in ASP.NET.
ms.date: 04/03/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Disable ASP session state in ASP.NET  

This article demonstrates how to disable session state in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306996

## Summary

When session state is enabled, ASP.NET creates a session for every user who accesses the application, which is used to identify the user across pages within the application. When session state is disabled, user data is not tracked, and you cannot store information in the `Session` object or use the `Session_OnStart` or `Session_OnEnd` events. By disabling session state, you can increase performance if the application or the page does not require session state to enable it.

In ASP.NET, if you do not use the `Session` object to store any data or if any of the `Session` events (`Session_OnStart` or `Session_OnEnd`) is handled, session state is disabled. A new `Session.SessionID` is created every time a single page is refreshed in one browser session.

## Disable session state at the application level

The following steps demonstrate how to disable session state at the application level, which affects all pages in the application:

1. Start Microsoft Visual Studio .NET, and create a new ASP.NET web application.
2. In **Solution Explorer**, double-click *Web.config* to view the contents of this file.
3. Locate the `<sessionState>` section, and set the mode value to **Off**.
4. Save the file and/or the project to disable session state throughout all pages in the application.

## Disable session state at the page level

The following steps demonstrate how to disable session state at the page level, which affects only the specific pages that enable these changes:

1. Start Visual Studio .NET, and create a new ASP.NET Web Application.
2. In **Solution Explorer**, double-click the Web Form for which you want to disable session state.
3. Select the **HTML** tab.
4. At the top of the page, add `EnableSessionState="false"` in the @ Page directive. The modified attribute should appear similar to the following:

    ```aspx-csharp
    <%@ Page language="c#" Codebehind="WebForm1.aspx.cs"
    AutoEventWireup="false" Inherits="WebApplication1.WebForm1"
    EnableSessionState="false" %>
    ```

5. Save the file and/or project to disable session state throughout all pages in the application.

## Troubleshooting

If you try to set or retrieve information when session state is disabled, you receive the following error message:

> Session state can only be used when enableSessionState is set to true, either in a configuration file or in the Page directive

## References

- [ASP.NET Session State](/previous-versions/dotnet/articles/ms972429(v=msdn.10))
- [\<sessionState> Section](/previous-versions/dotnet/netframework-1.1/h6bb9cz9(v=vs.71))
