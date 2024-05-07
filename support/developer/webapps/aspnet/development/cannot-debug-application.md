---
title: Cannot debug ASP.NET web applications
description: This article provides resolutions for the problem that you can't debug an ASP.NET application in Microsoft Visual Studio .NET.
ms.date: 04/07/2020
ms.custom: sap:General Development
---
# Cannot debug ASP.NET web applications

This article helps you resolve the problem where you can't debug an ASP.NET application in Microsoft Visual Studio .NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 318465

## Symptoms

When you debug an ASP.NET application in Visual Studio .NET, you may receive the following Development Environment error message:

> Error while trying to run project: Unable to start debugging on the web server. The server does not support debugging of ASP.NET or ATL Server applications. Run setup to install the Visual Studio .NET server components. If setup has been run, verify that a valid URL has been specified.  
> You may also want to refer to the ASP.NET and ATL Server debugging topic in the online documentation. Would you like to disable future attempts to debug ASP.NET pages for this project?

## Cause

This error may occur if the .NET Framework setup or installation was not completed correctly. When this occurs, the application mappings for ASP.NET file name extensions (such as .aspx) are not configured correctly in Internet Information Services (IIS).

To check whether the application mappings are correct, follow these steps:

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Internet Services Manager**.
2. Expand the node that corresponds to the local host (computer name), and then expand the Default Web Site node.
3. Right-click your Web application directory, and then select **Properties**.
4. On the **Directory** tab, under **Application Settings**, select **Configuration**.
5. Select the **App Mappings** tab.
6. On the **App Mappings** tab, under **Application Mappings**, check whether the .aspx extension is mapped to the following dynamic-link library (DLL):  
   `C:\Windows Directory\Microsoft.Net\Framework\<Version>\aspnet_isapi.dll`

    > [!NOTE]
    > You must replace *Windows Directory* in this path with the correct directory for your system and replace *Version* with the version of the .NET Frame work installed on your system.

7. If the application mapping entry is not found, follow the steps in the **Resolution** section.

## Resolution

To resolve this problem, use the `Aspnet_regiis.exe` administration utility that manages the installation and uninstallation of multiple versions of ASP.NET on a single computer.

To use the `Aspnet_regiis.exe` utility, follow these steps:

1. Select **Start**, and then select **Run**.
2. Type *cmd* in the **Open** box, and then select **OK** to open a command prompt.
3. At the command prompt, use the `cd` command to change to the following directory:  
   `C:\Windows Directory\Microsoft.Net\Framework\Version`

    > [!NOTE]
    > You must replace *Windows Directory* in this path with the correct directory for your system and replace *Version* with the version of the .NET Framework installed on your system.

4. Type `aspnet_regiis -i` to configure the required application mappings correctly.
