---
title: Update or slipstream an installation
description: This article describes how to update or slipstream an installation of SQL Server 2008.
ms.date: 09/25/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: bobward
ms.topic: how-to
---
# Update or slipstream an installation of SQL Server 2008

This article describes how to update or slipstream an installation of SQL Server 2008.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955392

## Introduction

This article describes how to update or slipstream a failed installation of Microsoft SQL Server 2008 by using the latest Cumulative Update (CU) or latest Service Pack (SP). Use these instructions when you cannot install SQL Server 2008 because of a known issue in the Setup program. The [SQL Server 2008 Setup hotfixes](#sql-server-2008-setup-hotfixes) section lists the Microsoft Knowledge Base articles that describe known setup issues and explains how to obtain the latest update.

There are two situations to consider:

- You attempt to install SQL Server 2008. You encounter a setup failure, and the setup files are installed on the computer.
- You want to proactively avoid known setup issues by using an update setup.

It is recommended that you update or slipstream the original SQL Server 2008 by using Service Pack 1 because Service Pack enables to update the entire product. A CU that is based on the original SQL Server 2008 release can only update the SQL Support component.

For answers to frequently asked questions about slipstreaming, see the **SQL Server 2008 Slipstream Frequently Asked Questions** topic on [SQL Server Setup](/archive/blogs/petersad/).

> [!IMPORTANT]
> For SQL Server 2012 and later versions, you need to use `/UpdateSource` parameter to update your SQL Server installation files. For an example on how to do this, see [How to patch SQL Server 2012 Setup with an updated setup package (using UpdateSource to get a smart setup)](/archive/blogs/jason_howell/how-to-patch-sql-server-2012-setup-with-an-updated-setup-package-using-updatesource-to-get-a-smart-setup).

## More information

When you run the original release version of SQL Server 2008 Setup, the Setup program copies itself on the local computer, and then reruns from the local copy. Therefore, if there is a later version of the support files on the computer, the Setup program will run these updated files. Therefore, you can update the SQL Server 2008 Setup support files before you run the *Setup.exe* file.

Starting from SQL Server 2008 Service Pack 1, you can update SQL Server 2008 by using the slipstream infrastructure. When you install Service Pack 1 by using the slipstream procedure or install to an existing SQL Server 2008 installation, an entry is created for the Service Pack in **Add or Remove Programs**. You can uninstall the service pack by using this entry.

To verify whether a service pack is installed correctly, run the SQL Discovery report that is available in the SQL Server 2008 Installation Center. You should see the features are version 10. **n**. **xxxx**, where **n** represents the service pack version. For example, 10.1. **xxxx** represents Service Pack 1.

## Update an installation of SQL Server 2008

When you try to install SQL Server 2008 from a DVD or from a network share, the installation fails because of an issue with the release version of the Setup program.

The following steps describe how to update SQL Server 2008 Setup when a Setup issue occurs:

1. If the SQL Server 2008 Setup support files are installed on the computer, you apply a CU or a hotfix to update the SQL Server 2008 Setup support files, and then rerun the Setup program from the DVD or the network share.

1. If the SQL Server 2008 Setup support files aren't installed, see the [Proactively running setup](#proactively-running-setup) section.

To determine whether the SQL Server 2008 Setup support files are installed on the computer, view the entry by using **Add or Remove Programs** in Control Panel in operating systems that are earlier than Windows Vista. In Windows Vista or later versions of Windows, view the entry by using **Programs and Features** in Control Panel. To apply a CU or a hotfix and run the Setup program, follow these steps:

1. If a fix is available through a hotfix, download the CU or the hotfix, and then install it on the computer by running the .exe file or by using the command line. The package detects the SQL Server 2008 Setup support files on the computer and then applies a new version of the SQLSupport.msi file.

1. Run the Setup program again from the DVD or from the network share. The Setup program detects that a later version of the *SQLSupport.msi* file is available on the computer, and the Setup program runs from the local version on the computer instead of from the DVD or network share.

## Limitations

The following limitations apply when you update the Setup program or use the slipstream procedure.

- > [!IMPORTANT]
  > You must uninstall a failed installation if the *Summary.txt* log file indicates that you must uninstall.

- If you use the slipstream procedure to upgrade an installation to a Wow64 installation, you must perform one of the following additional steps:

  - Specify the `/Action` parameter on the command line in addition to the `/x86` parameter.

  - On the **Options** page of the Installation Center, select **x86**.

- If you add features to an instance that already has the database service installed through slipstreaming, the installation may fail. To work around this issue, you need to add feature by using the original SQL Server 2008 source media or upgrade the instance to SP1 and then use the slipstream infrastructure.

- When you copy slipstream packages, use paths that do not contain spaces. If you specify a location that contains spaces for either `/PCUSOURCE` or `/CUSOURCE` parameters, a failure occurs with slipstream setup.

## Proactively running setup

There are two methods that you can use to update an installation of SQL Server 2008. We recommend that you use the first method because of the following benefits of the slipstream infrastructure:

- You can quickly update to SQL Server 2008 SP1 in a single installation.

- Reduce the restart times.

- Improve the overall setup experience.

- Avoid known setup issues.

To use these methods, the administrator must obtain the updated SQL Server 2008 Setup support files by downloading the latest CU or hotfix, or service pack. For information about the Setup fixes that are included in the latest hotfix and for information about how to download the hotfix, see the [SQL Server 2008 Setup hotfixes](#sql-server-2008-setup-hotfixes) section. After you obtain the updated SQL Server 2008 Setup support files, use one of the following methods.

## Use the slipstream procedure to update SQL Server 2008

This method allows you to update the entire product when you run the SQL Server 2008 Setup program after following one of the following procedures.

## Procedure 1: Basic slipstream steps

To create a slipstream drop that you can use for installing the original media and a service pack at the same time, follow these steps:

1. Install the following prerequisites for SQL Server 2008.
   - .NET Framework 2.0 SP2 for SQL Server 2008 Express Edition

   - .NET Framework 3.5 SP1 for other editions

     To download and install the .NET Framework 3.5 SP1, see [Microsoft .NET Framework 3.5 Service Pack 1](https://www.microsoft.com/download/details.aspx?id=25150).

   - Windows Installer 4.5

1. Download the service pack package that matches your system architecture. For example, download the x64 package of SQL Server 2008 Service Pack 1 if your system is an x64-based system.

1. Extract the service pack by running the command `SQLServer2008SP1-KB968369-x64-ENU.exe /x:C:\SP1`.  

1. Run the service pack to install Setup files on the computer. You will receive a **Setup Support Files** dialog box if the setup support files have not been installed. You can also run the following file to install the setup support files *C:\SP1\x64\setup\1033\sqlsupport.msi*.

1. Run the *Setup.exe* file from the SQL Server 2008 source media by specifying the \<PCUSource\> parameter. For example, `Setup.exe /PCUSource=C:\SP1`.

## Procedure 2: Create a merged drop

This procedure describes how to create a new source media that will slipstream the original source media and SQL Server 2008 Service Pack 1. When you create this merged drop, you can install SQL Server 2008 SP1 in a single step.

> [!NOTE]
>
> - It's recommended that you first complete a slipstream installation from the new drop on a test computer before you deploy it into the production environment.
>
> - These steps are for the English version of SQL Server 2008. However, it works for any language of SQL Server 2008 if you obtain the correct language of service pack package.

1. Copy the original SQL Server 2008 source media to *c:\SQLServer2008_FullSP1*.
1. Download the Service Pack 1 package. The package names are as follows:

   - *SQLServer2008SP1-KB968369-IA64-ENU.exe*

   - *SQLServer2008SP1-KB968369-x64-ENU.exe*

   - *SQLServer2008SP1-KB968369-x86-ENU.exe*

1. Extract the packages as follows:

    - `SQLServer2008SP1-KB968369-IA64-ENU.exe/x:c:\SQLServer2008_FullSP1\PCU`

    - `SQLServer2008SP1-KB968369-x64-ENU.exe/x:c:\SQLServer2008_FullSP1\PCU`

    - `SQLServer2008SP1-KB968369-x86-ENU.exe/x:c:\SQLServer2008_FullSP1\PCU`

    > [!NOTE]
    > Make sure that you complete this step for all architectures to ensure the original media is updated correctly.

1. Run the following commands to copy the *setup.exe* file and the *setup.rll* file from the extracted location to the original source media location.

    ```console
    robocopy C:\SQLServer2008_FullSP1\PCU c:\SQLServer2008_FullSP1 Setup.exe
    robocopy C:\SQLServer2008_FullSP1\PCU c:\SQLServer2008_FullSP1 Setup.rll
    ```

1. Run the following commands to copy all files (not the folders), except the *Microsoft.SQL.Chainer.PackageData.dll* file, in *C:\SQLServer2008_FullSP1\PCU\Architecture* to *C:\SQLServer2008_FullSP1\Architecture* to update the original files.

   ```console
   robocopy C:\SQLServer2008_FullSP1\pcu\x86 C:\SQLServer2008_FullSP1\x86 /XF Microsoft.SQL.Chainer.PackageData.dll  

   robocopy C:\SQLServer2008_FullSP1\pcu\x64 C:\SQLServer2008_FullSP1\x64 /XF Microsoft.SQL.Chainer.PackageData.dll

   robocopy C:\SQLServer2008_FullSP1\pcu\ia64 C:\SQLServer2008_FullSP1\ia64 /XF Microsoft.SQL.Chainer.PackageData.dll  
   ```

    > [!NOTE]
    > If you accidentally copy the *Microsoft.SQL.Chainer.PackageData.dll* file, you may receive the following error message when you run the *setup.exe* file.

    > SQL Server Setup has encountered the following error:
    >
    > The specified action LandingPage is not supported for the SQL Server patching operation.
    >
    > Error code 0x84BF0007

   If this issue occurs, restore the *Microsoft.SQL.Chainer.PackageData.dll* file back to the original version.

1. Determine if you have the *Defaultsetup.ini* file in the following folders:

   - *C:\SQLServer2008_FullSP1\x86*

   - *C:\SQLServer2008_FullSP1\x64*

   - *C:\SQLServer2008_FullSP1\ia64*

    If you have the *Defaultsetup.ini* file in the folders, open the *Defaultsetup.ini* file, and then add `PCUSOURCE=".\PCU"` to the file as follows:

   ```console
   ;SQLSERVER2008 Configuration File

   [SQLSERVER2008]

   ...

   PCUSOURCE=".\PCU"
   ```

   If you don't have the *Defaultsetup.ini* file in the folders, create the *Defaultsetup.ini* file in the folders, and add the following content to the file:

   ```console
   ;SQLSERVER2008 Configuration File

   [SQLSERVER2008]

   PCUSOURCE=".\PCU"
   ```

      > [!NOTE]
      > This file tells the Setup program where to locate the SP1 source media that you extracted in step 3.

1. Start the Setup program.

    > [!NOTE]
    > You shouldn't perform the slipstream procedure to apply SQL Server 2008 Service Pack 1 for the SQL Server 2008 Express edition. SQL Server 2008 Express Edition SP1 is already a merged drop. However, you can use the slipstream procedure to apply a cumulative update for the SQL Server 2008 Express edition.

## Verify if you have completed a slipstream update

1. In the **Installation Rules** page, an **Update Setup Media Language Rule** item is shown in the rules list.

1. In the **Ready to Install** page, the **Action** node indicates that it is a slipstream install. Additionally, a **Slipstream** node is shown in the list.

1. In the Summary log file, you can find the PCUSource setting.

1. After the installation, if you run the SQL Server features discovery report from the Installation Center, you should see the features are version 10.1. **xxxx**.

## Update the SQL Server 2008 Setup support files

There are two options that you can use to install the SQL Server 2008 Setup support files. We recommend that you use this method to install SQL Server 2008 Setup support files before SQL Server SP1.

> [!NOTE]
> For the two options, only the SQL Server 2008 Setup support files are update. To update the entire product, you must run the hotfix package after the product has been successfully installed.

## Option 1: Install the SQLSupport.msi file directly

This option is best for running a patched setup on a small number of computers.

1. Install any prerequisite components for SQL Server 2008 if they aren't already installed. Microsoft Windows Installer 4.5 must be installed. You must install the .NET Framework 2.0 SP2 for SQL Server 2008 Express Edition and the .NET Framework 3.5 SP1 for other editions. You must download the .NET Framework 3.5 SP1 from the Internet and apply the SP1 manually.

   > [!NOTE]
   >
   > - On the IA-64 platform, the .NET Framework 3.5 isn't supported, and the .NET Framework 2.0 SP2 is required. You can install the .NET Framework 2.0 SP2 from the source media. The .NET Framework 2.0 SP2 is located in the following folder on the source media: *\<Drive_Letter\>:\ia64\redist\2.0\NetFx20SP2_ia64.exe*.
   >
   > - On x86 and x64 platforms, you must install the .NET Framework 3.5 SP1.

1. Double-click the hotfix package to install the SQL Server 2008 Setup support files. After you extract the contents of the package, the updated SQL Server 2008 Setup support files will be installed. The hotfix package will complete the installation without notifying you when it is completed. To confirm that the files are installed, view the entry by using the **Add or Remove Programs** item in Control Panel in operating systems that are earlier than Windows Vista. In Windows Vista or later versions of Windows, view the entry by using the Programs and Features item in Control Panel.

1. Start the Setup program from the DVD or from the network share.

## Option 2: Update the original media files

This option is best for running a patched setup on many computers, large deployments, or when an administrator wants to make available this patched setup to users. It is important to follow these steps carefully and fully test before making this option available to others.

1. Download the hotfix that includes the updated SQL Server 2008 Setup support files that you want to use to update the original media files. You must download the hotfixes for x86, x64, and IA-64 platforms because the original media contains the files for each platform.

1. At a command prompt, type the following command, and then press <kbd>ENTER</kbd> to extract the contents of the package: `<hotfix_package_name> /x:c:\<kb_number_of_hotfix package>\<architecture>`.  

   The \<architecture\> placeholder represents the different hardware platforms. For example, it can represent one of the following folders:

   - *x86*
   - *x64*
   - *IA64*

   The following examples represent how you can use this command:

   - `SQLServer2008-KB956717-IA64.exe /x:c:\kb956717\ia64`
   - `SQLServer2008-KB956717-x64.exe /x:c:\kb956717\x64`
   - `SQLServer2008-KB956717-x86.exe /x:c:\kb956717\x86`

1. Copy the contents of the SQL Server 2008 DVD to the local hard disk.

1. Copy the following files:

    - Copy the *Setup.exe* and *Setup.rll* files from the *C:\kb_number_of_hotfix package\folder* to the folder that contains the local copy of `media\`.
  
    - Copy all files (not the subfolders) in the **architecture** folder, except the *Microsoft.SQL.Chainer.PackageData.dll* file, from the *C:\\\<kb_number_of_hotfix package\>\architecture\architecture\* folder to the folder that contains the local copy of *media\architecture\\*.

1. Start the Setup program from the local folder.

    > [!NOTE]
    > Due to schema changes that have been introduced in RTM based-cumulative update packages for SQL Server 2008 that start with Cumulative Update Package 8, you may receive the following error message when you run the Setup program. You may receive the following error message after you update the Setup support files by using the procedure that is described in option 2:
    
    > 2010-01-14 15:34:36 Slp: Exception type:
    > Microsoft.SqlServer.Chainer.Infrastructure.ChainerInfrastructureException
    >
    > 2010-01-14 15:34:36 Slp: Message:
    >
    > 2010-01-14 15:34:36 Slp: The 'Path' attribute is not declared.

To avoid this validation issue, we recommend that you copy the *Microsoft.SQL.Chainer.PackageData.dll* file from the RTM media and keep the original *Microsoft.SQL.Chainer.Package.dll* file in the same location as the *Microsoft.SQL.Chainer.Package.Package.xsd* file. Do this to make sure that the two .dll files are in sync. This combination of .dll files will install the RTM version of *SqlSupport.msi (10.00.1600.22)*. To benefit from the bug fixes that are present in the cumulative update, use one of the following methods:

- Method 1

  Manually install the SQL Support .msi file for the particular architecture from the following cumulative update package extraction location: *CU8\<CPU\>\setup\sqlsupport.msi*.

- Method 2

  In addition to the files that are listed in step 4 in option 2, the files that are described in the following steps should be copied before you start setup from a local folder. To copy the files, follow these steps:

  1. Copy the *Microsoft.SQL.Chainer.Package.dll* file from the RTM folder to the local copy of the *\<media\>\<architecture folder\>* folder.

  1. Copy the *Sqlsupport.msi* file. Of the following locations, copy the file from the first location to the local copy of the second location:
     - *C:\<kb_number_of_hotfix package\>\<architecture\>\setup\Sqlsupport.msi*
     - *\<media\>\<architecture folder\>\setup\\\*

## SQL Server 2008 setup hotfixes

For more information about known setup issues and the fixes to resolve these issues, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [KB957453 - FIX: When you install SQL Server 2008, the installation fails, and the "Attributes do not match" error message is logged in the Summary.txt file](https://support.microsoft.com/help/957453)

- [KB957459 - FIX: Error message when you try to add a second node to a SQL Server 2008 failover cluster: "The current SKU is invalid"](https://support.microsoft.com/help/957459)

> [!NOTE]
> If other setup issues are identified, additional Microsoft Knowledge Base articles will be released and included in this list.

## Obtain setup hotfixes for SQL Server 2008

A supported cumulative update package is now available from Microsoft. However, it is intended to correct only the problems that are described in this article. Apply it only to systems that are experiencing these specific problems. This cumulative update package may receive additional testing. Therefore, if you are not severely affected by any of these problems, we recommend that you wait for the next SQL Server 2008 service pack that contains the hotfixes in this cumulative update package. For more information about the cumulative update package, click the following article number to view the article in the Microsoft Knowledge Base:

[KB956717 - Cumulative update package 1 for SQL Server 2008](https://support.microsoft.com/help/956717)

## Applies to

- SQL Server 2008 Enterprise
- SQL Server 2008 Developer
- SQL Server 2008 Express
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
