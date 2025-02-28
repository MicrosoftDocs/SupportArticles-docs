---
title: HTTP Error 403.14 when You Open IIS Webpages
description: Helps resolve the HTTP 403.14 The web server is configured to not list the contents of this directory error when you visit an Internet Information Services webpage.
ms.date: 10/22/2024
ms.reviewer: damatei
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
---
# HTTP Error 403.14 - Forbidden when you open an IIS webpage

This article helps you resolve the "HTTP Error 403.14 - Forbidden - The web server is configured to not list the contents of this directory" error that occurs when you open an Internet Information Services (IIS) webpage.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 942062

> [!NOTE]
>
> The target audience for this article is website administrators and web developers.

## Symptoms

When you visit a website hosted on IIS, you receive an error message that resembles the following one:

> Server Error in Application "\<application name\>"  
> HTTP Error 403.14 - Forbidden  
> HRESULT: 0x00000000  
> Description of HRESULT : The Web server is configured to not list the contents of this directory.

## Resolution for users

If you're a user, you should contact the website administrators to notify them that this error has occurred for this web address.

## Resolution for site administrators

This problem occurs because the website doesn't have the Directory Browsing feature enabled or the default document isn't enabled or configured properly. To resolve this problem, use one of the following methods:

### Method 1: Enable the Directory Browsing feature in IIS

To resolve this problem, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK** to start IIS Manager.
1. In IIS Manager, expand **\<server name>** > **Web sites**, and select the website that you want to change.
1. In the **Features** view, double-click **Directory Browsing**.
1. In the **Actions** pane, select **Enable**.

### Method 2: Add a default document

To resolve this problem, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK** to start IIS Manager.
1. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the website that you want to change.
1. In the **Features** view, double-click **Default Document**.
1. In the **Actions** pane, select **Enable**.
1. In the **Features** view, the **Default Document** must be listed (preferably first). If not, in the **Actions** pane, select **Add**, type the name of the default document in the **Add Default Document** box, and then select **OK**. The file must exist in the site's root folder.

### Method 3: Enable the Directory Browsing feature in IIS Express

> [!NOTE]
> This method is for the web developers who experience this issue when they use IIS Express.

1. Open a **Command Prompt** window, and navigate to the *IIS Express* folder on your computer. For example, type the following command at the command prompt, and then select <kbd>Enter</kbd>:

    ```console
    cd C:\Program Files\IIS Express
    ```

1. Type the following command, and then select <kbd>Enter</kbd>:

    ```console
    appcmd set config /section:directoryBrowse /enabled:true
    ```

    For more information about `Appcmd.exe` command lines, see [Getting Started with AppCmd.exe](/iis/get-started/getting-started-with-iis/getting-started-with-appcmdexe).
