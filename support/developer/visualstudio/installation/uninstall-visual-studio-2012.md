---
title: Uninstall Visual Studio 2012
description: This article describes how to uninstall Visual Studio 2012 and its related packages, and how to perform a force uninstall.
ms.date: 04/13/2020
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.reviewer: heaths, davguy, kelber
ms.topic: how-to
---
# Uninstall Visual Studio 2012

This article introduces how to uninstall Microsoft Visual Studio 2012 and its related packages, and how to perform a force uninstall.

_Original product version:_ &nbsp; Visual Studio 2012  
_Original KB number:_ &nbsp; 2771441

## Summary

This article applies to Visual Studio 2012 releases. To remove previous pre-release product versions, see [How to uninstall Visual Studio 2012 Release Candidate](https://support.microsoft.com/help/2744926/how-to-uninstall-visual-studio-2012-release-candidate).

If you want to install the latest Visual Studio 2012 release over the Release Candidate, you do not need to uninstall Visual Studio 2012 Release Candidate because Visual Studio 2012 will be upgraded to the newer version.

For more information and known upgrade issues, review [Installing Visual Studio](/previous-versions/e2h7fzkw(v=vs.110)).

## Manual removal

To manually remove a Visual Studio 2012 product, we recommend that you first uninstall the main product or products, such as Visual Studio 2012 Ultimate. Then, uninstall the other supporting products that may be installed.

To forcibly remove most packages listed below, see [Forcibly removing Visual Studio 2012](#forcibly-removing-visual-studio-2012).

User-generated assets such as project files and custom settings are not removed or affected by uninstalling Visual Studio. To uninstall Visual Studio, follow these steps:

1. Open **Programs and Features** in the Control Panel (formerly known as **Add or Remove Programs**, or ARP). Alternatively, you can open it as follows.
    1. Click **Run** on the **Start** menu (Start + R).
    2. Type *control appwiz.cpl* and press Enter.
2. Uninstall all the main product(s) from the following list that is installed. Hint In Control Panel, you can search for *Microsoft Visual Studio 2012* to filter the list of products accordingly.
    - Microsoft Visual Studio 2012 Ultimate
    - Microsoft Visual Studio 2012 Premium
    - Microsoft Visual Studio 2012 Professional
    - Microsoft Visual Studio 2012 Express for Windows 8
    - Microsoft Visual Studio 2012 Express for Web
3. Click **View installed updates**. Uninstall any update that is listed under the category Visual Studio 2012.

## Optional shared packages

Optionally uninstall the following shared packages that may also be installed with Visual Studio 2012. Sometimes a package may still appear even after uninstalling it. If this happens, uninstall it again since more than one package with the same name has been installed.

You may be prompted that uninstalling a product may affect other products.

- Click **Yes** only if you are sure you no longer need the features associated with the package.
- Click **No** to leave the package installed.

The order in which you uninstall packages is important; the list below indicates the order in which you should uninstall the packages. The version numbers may be newer than what is shown below if they were subsequently updated. These packages may also be used by other products on the computer. These products include Visual Studio 2010 and Visual Studio 2008.

1. Microsoft Web Deploy dbSqlPackage Provider - enu
2. Microsoft SQL Server Data Tools - enu (11.1.20627.00)
3. Microsoft SQL Server 2012 Management Objects (x64)
4. Microsoft SQL Server 2012 Management Objects
5. Microsoft SQL Server System CLR Types (x64)
6. Microsoft SQL Server System CLR Types
7. Microsoft SQL Server Compact 4.0 SP1 x64 ENU
8. Microsoft SQL Server Compact 4.0 SP1 ENU
9. Microsoft SQL Server 2012 Express LocalDB
10. Microsoft SQL Server Data Tools Build Utilities - enu (11.1.20627.00)
11. Microsoft SQL Server 2012 T-SQL Language Service
12. Microsoft SQL Server 2012 Command Line Utilities
13. Microsoft SQL Server 2012 Native Client
14. Microsoft SQL Server 2012 Data-Tier App Framework
15. Microsoft SQL Server 2012 Transact-SQL Compiler Service
16. Microsoft SQL Server 2012 Transact-SQL ScriptDom
17. Prerequisites for SSDT
18. Microsoft Visual Studio 2010 Tools for Office Runtime (x64)
19. Microsoft Visual Studio 2010 Tools for Office Runtime (x86)
20. Microsoft ASP.NET MVC 3
21. Microsoft ASP.NET Web Pages
22. WCF RIA Services V1.0 SP2
23. Microsoft Web Platform Installer 4.0
24. IIS 8.0 Express
25. Microsoft Web Deploy 3.0

## Important system updates that we do not recommend for removal

Visual Studio 2012 may also install the following important system updates. We recommend that you leave them installed on your system. Some of these may appear in **Installed Updates** that are a link within **Programs and Features**.

> [!WARNING]
> These updates may also be used by other products on the machine including Visual Studio 2010, Visual Studio 2008, or any applications built with either of these products by you or another developer.

1. Microsoft Silverlight
2. Microsoft .NET Framework 4.5
3. Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.4148
4. Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161
5. Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148
6. Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161

> [!NOTE]
> If you find that one or more products stop functioning after uninstalling Visual Studio 2012, repair those products.

## Forcibly removing Visual Studio 2012  

You can also remove Visual Studio 2012 and its [Optional shared packages](#optional-shared-packages) by using a new command line switch. If you have multiple Visual Studio 2012 products installed, any common packages will still remain until all VS2012 products are removed.

Even if you have already uninstalled the main product, you can still downloads and use it to run the following command to remove the rest of the packages except for .NET Framework 4.5 and Visual C++ Runtime.

> [!WARNING]
> Running this command may remove some packages even if they are still in use like those listed in [Optional shared packages](#optional-shared-packages).

1. Download the setup application you used to originally install Visual Studio 2012. If you installed from media, please insert that media.
2. Open a command prompt.
    1. Click **Run** on the **Start** menu (Start + R).
    2. Type *cmd* and press Enter.
3. Type in the full path to the setup application and pass the following command line switches:

    ```console
    D:\vs_ultimate.exe /uninstall /force
    ```

4. Click the **Uninstall** button and follow the prompts.

If you have any questions or encounter any issues, please visit [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup).
