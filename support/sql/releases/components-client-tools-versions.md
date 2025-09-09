---
title: Determine version information of SQL Server components and client tools
description: This article describe the procedures to determine the version information of SQL Server components and client tools.
ms.date: 02/12/2025
ms.topic: how-to
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: v-six, jopilov
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "aartigoyle" for triage before making the further changes to the screenshots.
--->

# Determine version information of SQL Server components and client tools

This article describes the procedures to determine the version information of SQL Server components and client tools.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

## Determine the version of SQL Server Client tools

- **SQL Server Management Studio (SSMS)**

  To determine which versions of the client tools are installed on your system, start Management Studio, and then click **About** on the **Help** menu. (See the following screenshot.)

  :::image type="content" source="media/components-client-tools-versions/ssms-about.svg" alt-text="Screenshot of the About Microsoft SQL Server Management Studio window, which shows the versions of the client tools." border="false":::

  Starting with SQL Server 2016, SQL Server management studio is offered as a separate download. For additional information about various versions of the tool, review [Release notes for SQL Server Management Studio (SSMS)](/sql/ssms/release-notes-ssms).

  SQL Server Data Tools

  For additional information about SQL Server Data Tools, review [Download SQL Server Data Tools (SSDT) for Visual Studio](/sql/ssdt/download-sql-server-data-tools-ssdt).

## SQL Server Reporting Services

The version of SQL Server Reporting Services (SSRS) is displayed on the Reporting Services Web Service URL, for example: `http://servername/reportserver`. The version is also displayed in the Reporting Services Configuration tool.

## SQL Server Integration Services

The version of SQL Server Integration Services aligns with the version of SQL Server that you had installed.

## SQL Server Analysis Services

To determine the version of SQL Server Analysis Services, use one of the following methods:

- **Method 1:** Connect to the server by using Object Explorer in SQL Server Management Studio. After Object Explorer is connected, it will show the version information in parentheses, together with the user name that is used to connect to the specific instance of Analysis Services.

- **Method 2:** Check the version of the Msmdsrv.exe file in the Analysis Services bin folder. The default locations are shown in the following table.

  |Analysis Services version|Location|
  |---|---|
  |2019 |`%ProgramFiles%\Microsoft SQL Server\MSAS15.InstanceName\OLAP\Bin\MSMDSrv.exe`|
  |2017 |`%ProgramFiles%\Microsoft SQL Server\MSAS14.InstanceName\OLAP\Bin\MSMDSrv.exe`|
  |2016| `%ProgramFiles%\Microsoft SQL Server\MSAS13.InstanceName\OLAP\Bin\MSMDSrv.exe`|
  |2014| `%ProgramFiles%\Microsoft SQL Server\MSAS12.InstanceName\OLAP\Bin\MSMDSrv.exe`|
  |2012|`%ProgramFiles%\Microsoft SQL Server\MSAS11.InstanceName\OLAP\Bin\MSMDSrv.exe` |

- **Method 3:** Use the registry subkeys that are listed in the following table.

  |Analysis Services version|Location|
  |---|---|
  |2019|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS15.InstanceName\MSSQLServer\CurrentVersion Key: CurrentVersion`</br></br>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS15.InstanceName \Setup Keys: PatchLevel , Version, Key Edition`|
  |2017|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS14.InstanceName\MSSQLServer\CurrentVersion Key: CurrentVersion`</br></br>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS14.InstanceName \Setup Keys: PatchLevel , Version, Key Edition`|
  |2016|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS13.InstanceName\MSSQLServer\CurrentVersion Key: CurrentVersion`</br></br>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS13.InstanceName \Setup Keys: PatchLevel , Version, Key Edition`|
  |2014|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS12.InstanceName\MSSQLServer\CurrentVersion Key: CurrentVersion`</br></br>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS12.InstanceName \MSSQLServer\CurrentVersion Key: CurrentVersion`|
  |2012|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS11.InstanceName\MSSQLServer\CurrentVersion Key: CurrentVersion`</br></br>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSAS11.InstanceName \Setup Keys: PatchLevel , Version, Key Edition` |

  For more information about verifying Analysis Services build versions review [Verify Analysis Services cumulative update build version](/analysis-services/instances/analysis-services-component-version).

## SQL Server replication

Because replication agents may be installed on several different computers, it is important to check the installed versions on all affected computers.

For example, the Distribution Agent in Transactional or Peer-to-Peer replication may exist on computers that differ from the publisher instance of SQL Server and may exist on the various subscriber instances of SQL Server in a pull subscription.

If you use Web Synchronization for Merge Replication, the IIS web server may not be the same computer as the computer that is running SQL Server. Therefore, you have replication agent files that are installed on the IIS web server. And you may have to check the version of those .dll files in the IIS virtual directory and update them explicitly to obtain the latest service packs, cumulative updates, and hotfixes for your web agents.

For more information, see [Upgrade or patch replicated databases](/sql/database-engine/install-windows/upgrade-replicated-databases).  

## Full-text search

Full-text search components include the following:

- Sqlserver.exe
- Sql_fulltext_keyfile.dll
- Iftsph.dll
- Fd.dll
- Fdhost.exe
- Fdlauncher.exe

Except for Sqlservr.exe, these components may not be updated with each cumulative update or service pack for the respective SQL Server product. The versions of these files will change only when there is a fix to the respective component. Generally, you can check the file version of each of these .dll files. The highest version in the list is the version of the full-text search component that is installed on the system.

You can use one of the following methods to determine the version of the full-text search component that is installed on your system.

> [!NOTE]
> Each of these methods may indicate that the version of the full-text search component is either RTM or a version that is earlier than the current version of the database component. We acknowledge that this is a problem and are working on fixing it in a future update.

- **Method 1:** Check the version of SQL Server Full-Text Key (Sql_fulltext_keyfile.dll) in the SQL Server 2008 R2 or SQL Server 2008 installation folder. Typically, for SQL Server 2008 R2, this file is located in the following folder:

  `%ProgramFiles%\Microsoft SQL Server\MSQL10_50.\<Instance Name>\MSSQL`

  For SQL Server 2008, this file typically is located in the following folder:

  `%ProgramFiles%\Microsoft SQL Server\MSQL10.\<Instance Name>\MSSQL`

- **Method 2:** Check the following registry subkey:

  `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft sql server\Mssql10_50.instname\Setup\SQL_FULLTEXT_ADV`

  An example entry at this registry subkey is the following:

  ```console
  featurelist: SQL_FullText_Adv=3 SQL_FullText_CNI=3
  ProductCode: {9DFA5914-C275-42E0-810E-C88E46A7F9EA}
  Patchlevel: 10.50.1765.0
  Version: 10.50.1600.1
  ```

  In this example entry, the third line (Patchlevel) indicates the current build of full-text search component that is installed, and the fourth line (Version) usually shows the original version of full-text search that is installed. In this case, it is SQL Server 2008 R2.

- **Method 3:** Use the _Summary.txt_ file that is created during setup. For SQL Server 2008 R2 and later versions, this file is located in the following folder:

  `%ProgramFiles%\Microsoft SQL Server\<nnn>\Setup Bootstrap\LOG\Summary.txt`

  For values of \<nnn> that correlate to your version review [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

  For SQL Server 2008, this file is located in the following folder:

  `%ProgramFiles%\Microsoft SQL Server\100\Setup Bootstrap\LOG\Summary.txt`

## SQL Server Master Data Services (MDS)

The MDS Configuration Manager does not show the currently installed version number directly.

Be aware that MDS has a unique versioning scenario in which the SQL Server database engine installation does not necessarily match the MDS version. The version may vary when you compare the SQL Server installation to the binaries deployed in the MDS website and the MDS catalog schema version. Manual steps that use the MDS Configuration Manager tool are required to update and to upgrade the MDS websites and database schemas. You can refer to the following blog post on hotfix and service pack update methodology for MDS: [Downloading and Installing SQL Server 2008 R2 Master Data Services (MDS) Cumulative Updates](https://techcommunity.microsoft.com/t5/sql-server-integration-services/downloading-and-installing-sql-server-2008-r2-master-data/ba-p/387712)

The following registry subkey shows the binary versions that are installed on the SQL Server. However, this version does not necessarily match the website and database schema version until the MDS upgrade process is complete.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\Master Data Services 10.5\CurrentVersion`

You can check the installed product version and schema version by using the following query in the MDS catalog:

```sql
select * from mds.mdm.tblSystem
```

## SQL Server Native Client

> [!NOTE]
> The major SQL Server version of latest SQL Server Native Client is SQL Server 2012. It's compatible with SQL Server 2014 and SQL Server 2016. For additional information review [Installing SQL Server Native Client](/sql/relational-databases/native-client/applications/installing-sql-server-native-client).

To determine the version of SQL Server Native Client, use one of the following methods:

- **Method 1:** On the system where you want to find the version of Native Client, start the ODBC Administrator (odbcad32.exe), and then check the **Version** column under the **Drivers** tab.

- **Method 2:** Check the following PatchLevel or Version keys at the following registry locations.

  |SQL version /</br>SQL Server Native Client version|Registry subkeys|
  |---|---|
  |SQL Server 2012, SQL Server 2014 and SQL Server 2016/ SQL Server Native Client 11.0 |HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\SQLNCLI11\CurrentVersion|
  |SQL Server 2008 & SQL Server 2008 R2/</br> SQL Server Native Client 10 |HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\SQLNCLI10\CurrentVersion|
  |SQL Server 2005/</br>SQL Server Native Client 9|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Native Client\CurrentVersion|

## SQL Server Browser

The browser version should match the highest version of the SQL Server Database Engine and of the instances of Analysis Services that are installed on the computer.

## SQL Server Writer

To determine the version of SQL Server Writer, check the following registry subkey value:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\SqlWriter\CurrentVersion Keys: PatchLevel or Version`

## Microsoft .NET Framework

To determine the version of .NET Framework on your system, see [Determine which versions and service pack levels of .NET Framework are installed](../../developer/dotnet/framework/general/determine-dotnet-versions-service-pack-levels.md).

For more information, see [Understanding the .NET Framework requirements for various versions of SQL Server](https://support.microsoft.com/help/2027770).

## SQL Azure

To find the version of your instance of SQL Azure and related information, see the following topic in Books Online: [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).

## SQL Server CE

To find the version of your instance of SQL Server CE and related information, see [SQL Server CE previous versions documentation](/previous-versions/sql/compact/).

## PolyBase

### PolyBase for SQL Server on Windows

To find the version of PolyBase and its related features in Windows, try the following methods:

- If the PolyBase service is running, run the following PowerShell script:

```powershell
Get-Process mpdwsvc -FileVersionInfo | Format-Table -AutoSize
```

- If the PolyBase service is not running or can't be started, run the following PowerShell script:

```powershell
cd 'C:\Program Files\Microsoft SQL Server'
ls mpdwsvc.exe -r -ea silentlycontinue | % versioninfo | Format-Table -AutoSize
```

### PolyBase for SQL Server on Linux

To find the version of PolyBase installed and its related features in Ubuntu, try the following methods:

```bash
apt list mssql-server-polybase
apt list mssql-server-polybase-hadoop
```

To find the version of PolyBase installed and its related features in RHEL, try the following methods:

```bash
yum info mssql-server-polybase
yum info mssql-server-polybase-hadoop
```

```bash
yum list installed *polybase*
```

### Windows or Linux

Alternatively, try the SQL Server Setup steps in this next section. To find the version of PolyBase and its related features, refer to a fresh discovery report that runs within the SQL Server Setup tools.

In Windows or Linux, find the installation folder \Setup Bootstrap\Log\. The Summary.txt file shows a discovery report of all features and versions. However, if the most recent setup action was to add PolyBase to an existing SQL Server instance, the Summary.txt file will not contain the PolyBase feature. This is because the discovery report will have run before the PolyBase feature was added.

We recommend that you refresh the Summary.txt report by running the features discovery report from SQL Server Setup. For more information, see [Validate a SQL Server Installation](/sql/database-engine/install-windows/validate-a-sql-server-installation).

## Machine Learning services

 For Windows servers, refer to the CAB file versions which change with SQL Server cumulative updates. Refer to the Rlauncher.config or PythonLauncher.config files in the `Program Files\Microsoft SQL Server\MSSQL.nn\MSSQL\Binn` directory to find the RHOME or PYTHONHOME folder locations of the CAB files. For the CAB versions that are included with SQL Server CU versions, see [CAB downloads for offline installation of cumulative updates for SQL Server Machine Learning Services](/sql/machine-learning/install/sql-ml-cab-downloads).

 For Linux servers, the following command returns a list of all mssql-specific installed packages, together with their version numbers:

```console
apt-get list --installed | --grep mssql
```

 The version number of the mssql-server-extensibility package version is the SQL Server version of the Machine Learning Services feature.

 The version number of the mssql-mlservices-packages-r or mssql-mlservices-packages-py refers to each language package file. For more information, see [Install SQL Server Machine Learning Services on Linux (Offline installation)](/sql/linux/sql-server-linux-setup-machine-learning#offline-installation).

## See also

- [Latest updates and version history for SQL Server](download-and-install-latest-updates.md)
- [Determine which version and edition of SQL Server Database Engine is running](find-my-sql-version.md)
