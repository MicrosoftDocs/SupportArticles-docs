---
title: HTTP Error 403.14 when you open IIS webpages
description: Resolves the HTTP 403.14 The web server is configured to not list the contents of this directory error message that occurs when you visit a website.
ms.date: 11/09/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.subservice: health-diagnostic-performance
---
# HTTP Error 403.14 - Forbidden when you open an IIS webpage

This article helps you resolve the "HTTP Error 403.14 - Forbidden - The web server is configured to not list the contents of this directory" error that occurs when you open an Internet Information Services (IIS) webpage.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942062

> [!NOTE]
>
> - The target audience for this article is website administrators and web developers.
> - This article only applies to traditional ASP.Net Form applications.

## Symptoms

When you visit a website hosted on IIS 7.0 or a later version, you receive an error message that resembles the following:

> Server Error in Application "**application name**"  
> HTTP Error 403.14 - Forbidden  
> HRESULT: 0x00000000  
> Description of HRESULT : The Web server is configured to not list the contents of this directory.

## Resolution for users

If you're a user, you should contact the website administrators to notify them that this error has occurred for this web address.

## Resolution for site administrators

This problem occurs because the website doesn't have the Directory Browsing feature enabled. Also, the default document isn't configured. To resolve this problem, use one of the following methods:

**Method 1: Enable the Directory Browsing feature in IIS (recommended)**

To resolve this problem, follow these steps:

1. Start IIS Manager. To do it, select **Start**, select **Run**, type **inetmgr.exe**, and then select **OK**.
2. In IIS Manager, expand **server name**, expand **Web sites**, and then select the website that you want to change.
3. In the **Features** view, double-click **Directory Browsing**.
4. In the **Actions** pane, select **Enable**.

**Method 2: Add a default document**

To resolve this problem, follow these steps:

1. Start IIS Manager. To do it, select **Start**, select **Run**, type **inetmgr.exe**, and then select **OK**.
2. In IIS Manager, expand **server name**, expand **Web sites**, and then select the website that you want to change.
3. In the **Features** view, double-click **Default Document**.
4. In the **Actions** pane, select **Enable**.
5. In the **File Name** box, type the name of the default document, and then select **OK**.

**Method 3: Enable the Directory Browsing feature in IIS Express**

> [!NOTE]
> This method is for the web developers who experience this issue when they use IIS Express.

1. Open a Command Prompt window, and navigate to the IIS Express folder on your computer. For example, type the following command at the command prompt, and then press Enter:

    ```console
    C:\Program Files\IIS Express
    ```

2. Type the following command, and then press Enter:

    ```console
    appcmd set config /section:directoryBrowse /enabled:true
    ```

For more information about Appcmd.exe command lines, see [Getting Started with AppCmd.exe](/iis/get-started/getting-started-with-iis/getting-started-with-appcmdexe).
