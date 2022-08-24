---
title: 64-bit operating systems supported together with Microsoft Dynamics GP
description: Describes the operating systems, the installation path, and the ODBC DSN to use so that the server list isn't empty when you try to sign in Microsoft Dynamics GP.
ms.reviewer: kyouells, v-lans
ms.date: 03/31/2021
---
# Description of the 64-bit operating systems that are supported together with Microsoft Dynamics GP

This article describes the operating systems, the installation path, and the ODBC DSN to use so that the server list isn't empty when you try to sign in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918983

## Introduction

The following 64-bit operating systems are supported together with Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 9.0:

- The 64-bit versions of Windows Vista Business, of Windows Vista Ultimate, and of Windows Vista Enterprise
- The 64-bit versions of Windows XP
- The 64-bit versions of Windows Server 2003 including Terminal Server
- The 64-bit versions of Windows Server 2008 and Windows Server 2008 R2 (Microsoft Dynamics GP 10.0 only)
- The 64-bit versions of Windows 7 (Microsoft Dynamics GP 10.0 only)

> [!NOTE]
> When a new installation of Microsoft Dynamics GP is located on 64-bit computer, a specific type of ODBC must be created. This article includes the following additional information:
>
> - Blank, empty, or missing ODBC menu
> - Missing server name after creating a new instance of Microsoft Dynamics GP
>
> You can find this information in the "Prerequisites" section of this article.

## Prerequisites

To run Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0 on a 64-bit computer or on a 64-bit server, you must satisfy the following prerequisites:

> [!NOTE]
> Microsoft Dynamics GP only work with a 32-bit ODBC. When Microsoft Dynamics GP is installed on a 64-bit computer, the ODBC is automatically defaulted for 64-bit and the server list will be empty. In this case, a new 32-bit ODBC have to be created.

- You must use a 32-bit Open Database Connectivity (ODBC) Data Source Name (DSN) when you try to sign in Microsoft Dynamics GP. If you use a 64-bit ODBC DSN, the server list will be empty.

    > [!NOTE]
    > To configure a 32-bit ODBC DSN, follow these steps:
    >
    > 1. Right-click **Start**, and then click **Explore**.
    > 1. Locate the following folder: *C:\Windows\SysWOW64*.
    > 1. Right-click the *Odbcad32.exe* file, and then click **Create Shortcut**.
    > 1. Right-click the shortcut file, and then click **Rename**.
    > 1. To rename the shortcut file, type *Data Sources (ODBC) 32-bit*.
    > 1. Right-click the shortcut file, and then click **Copy**.
    > 1. Expand **My Computer** > **Control Panel**, and then click **Administrative Tools**.
    > 1. Paste the shortcut file in the **Administrative Tools** folder.
    > 1. Close Windows Explorer.
    > 1. Click **Start** > **Control Panel**, double-click **Administrative Tools**, and then double-click **Data Sources (ODBC) 32-bit**.
    > 1. In the **ODBC Data Source Administrator** dialog box, create an ODBC data source.
    >
    >    **Note:** Rename the ODBC data source by using a name that clearly identifies this ODBC data source as the 32-bit version. For example, use the name "Dynamics32bit."
    > 1. Start Microsoft Dynamics GP.
    > 1. Select the ODBC data source that you created in step 11.
    > 1. Double-click the new shortcut to open it.
    > 1. Reference Microsoft Knowledge Base article 870416 to create an ODBC connection for Microsoft Dynamics GP. For more information about this article, click the following article number to view the article in the Microsoft Knowledge Base:
    >
    >     [870416](https://support.microsoft.com/help/870416) How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP  
    >   **Note:** To clearly identify the names of the shortcut files of the ODBC data sources, rename the shortcut file of the 64-bit version as "Data Sources (ODBC) 64-bit."

- During installation, remove any information that's in parentheses from the default installation path. For example, the 64-bit ODBC DSN uses the following default path:

    *C:\Program Files (x86)\Microsoft Dynamics\GP\\*

    In this case, you must change the installation path of the following path:

    *C:\Program Files\Microsoft Dynamics\GP\\*
    > [!NOTE]
    > The Field Service notification is incompatible with any x64-based server.

## Web Services Runtime workaround

To run Web Services on an x64-based operating system, you must use the following workarounds.

### Windows Server 2003 x64 and Microsoft Dynamics GP 10.0 only

1. In Windows Explorer, locate the system drive, and then open the following folder:
    *%SystemRoot%\Windows\Microsoft.NET\AuthMon\1.2 folder*
1. Drag the Microsoft.Interop.Security.AzRoles.dll file into the *%SystemRoot%\Windows\assembly* folder.
1. In Windows Explorer, verify that you can see the Microsoft.Interop.Security.AzRoles.dll file in the *%SystemRoot%\Windows\assembly* folder.
1. Install the x64 Dexterity Common Components on the IIS server.
1. Install Microsoft Dynamics GP 10.0 Service Pack 3 (SP3) or a later version.
1. Download Web Services SP3 or a later version.
1. Browse the Web Services installation folder, and then double-click the DynamicsGPWebServices.msi file.
1. After Web Services is installed successfully, see the "Web Services Management Tools workaround" section.

### Windows Server 2008 x64 or x86 and Microsoft Dynamics GP 10.0 only

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows.

1. See page 24 in the *WebServicesInstallation.pdf* file for the Windows Server 2008 roles and role services that must be enabled.
2. Click **Start** > **Run**, and then type *REGEDIT*.
3. Locate the following registry subkey, and then follow these steps:
    `HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion`

    1. Right-click the registry subkey, point to **New**, click **Key**, and then name the new key ADAM_Shared.
    1. Open the ADAM_Shared folder.
    1. Right-click the **ADAM_Shared** folder, point to **New**, and then click **String Value**.
    1. Name the new string value InstalledVersion, and then type *1.1.3790.2075* as the value data.
4. Install the x64 Dexterity Common Components on the IIS server.
5. Install Microsoft Dynamics GP 10.0 SP# or a later version.
6. Download Web Services SP3 or a later version.
7. Browse the Web Services installation folder, and then double-click the DynamicsGPWebServices.msi file.
8. After Web Services is installed successfully, see the "Web Services Management Tools workaround" section.

## Web Services Management Tools workaround

This workaround is necessary for Microsoft Management Console (MMC) to work for Web Services:

1. The Microsoft Visual C++ 2005 SP1 redistributable package (x86) must be installed on the x64-based computer for the Management Tools to work correctly.
2. The Web Services Management Tool installation must be started from the "Web Services" folder on CD2 or the Feature Pack DVD. Locate the Microsoft Dynamics GP 10.0 CD2 or the Feature Pack DVD, and then open the AdProd\WebServices folder. Double-click the DynamicsGPWebServicesManagementTools.msi file.

## References

For more information about how to set up the ODBC Data Source for Microsoft Business Solutions - Great Plains, click the following article number to view the article in the Microsoft Knowledge Base:

[870416](https://support.microsoft.com/help/870416) ODBC setup on SQL Server 2005, SQL Server 2000, SQL Server 7.0, and SQL Server Desktop Engine 2000 (MSDE)
