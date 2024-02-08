---
title: Error when you load custom extensions in Data Tools
description: This article provides a resolution for the problem where you receive an error message when you try to load custom extensions in report server projects in SQL Server 2012 Data Tools.
ms.date: 01/14/2021
ms.custom: sap:Reporting Services
ms.reviewer: ramakoni, muddin
ms.topic: troubleshooting 
---
# Error (The selected data extension \<Custom Extension Name> is not installed or cannot be loaded) when you load custom extensions in SQL Server 2012 Data Tools

This article helps you resolve the problem where you receive an error message when you try to load custom extensions in report server projects in SQL Server 2012 Data Tools.

_Applies to:_ &nbsp; SQL Server 2012 Enterprise, SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Standard, SQL Server 2012 Web  
_Original KB number:_ &nbsp; 2750044

## Symptoms

Consider the following scenario:

- You develop a custom Reporting Services data processing extension.
- The custom data processing extension assembly references a Microsoft.ReportingServices.Interfaces.dll file. The file is included with Microsoft SQL Server 2005 Reporting Services, SQL Server 2008 Reporting Services, or SQL Server 2008 R2 Reporting Services.
- You install SQL Server Data Tools (SSDT) in Microsoft SQL Server 2012.
- You deploy the data processing extension assembly by using SSDT.
- You create a new report server project that is based on the **Business Intelligence** template, and you try to select the custom data processing extension in order to add a new data source.

In this scenario, you receive an error message that resembles the following:

> Unable to connect to data source '\<Data Source Name>'. The selected data extension '\<Custom Extension Name>' is not installed or cannot be loaded. Verify that the selected data extension is installed on the client for local reports and on the report server for published reports.

> [!NOTE]
>
> - **Data Source Name** is a placeholder for the data source name, and **Custom Extension Name** is a placeholder for the custom extension name.
>
> - If you load the custom extension in any SQL Server Reporting Services (SSRS) report and then run the report through an SSRS web service or a web interface, the custom extension runs successfully.
>
> - This issue is not limited to data processing extensions. You may encounter similar errors when any custom extension references the Microsoft.ReportingServices.Interfaces.dll file that is included with SQL Server 2005 Reporting Services, SQL Server 2008 Reporting Services, or SQL Server 2008 R2 Reporting Services.

## Cause

The issue occurs because of a bug in the SSDT setup process.

When SSDT is installed, the following incorrect entries are added to the *devenv.exe.config* file and to the *PreviewProcessingService.exe.config* file:

```console
<dependentAssembly>
    <assemblyIdentity name="Microsoft.ReportingServices.Interfaces" publicKeyToken="89845dcd8080cc91" culture="neutral"/>
    <bindingRedirect oldVersion="9.0.242.0" newVersion="10.0.0.0"/>
</dependentAssembly>
```

If a custom extension references the Microsoft.ReportingServices.Interfaces.dll file whose assembly version is 9.0.242.0, SSDT will look for the Microsoft.ReportingServices.Interfaces.dll file whose assembly version is 10.0.0.0. However, this newer assembly may not exist on the computer where SSDT is installed.

## Resolution

To resolve this issue, use the correct entries in the *devenv.exe.config* file and in the *PreviewProcessingService.exe.config* file.

To correct the entry in the *devenv.exe.config* file, follow these steps:

- Open the *devenv.exe.config* file that is in the location:
`%Program Files%\Microsoft Visual Studio 10.0\Common7\IDE`.

  > [!NOTE]
  > The *PreviewProcessingService.exe.config* file is located in `%Program Files%\Microsoft Visual Studio 10.0\Common7\IDE\PrivateAssemblies`.

- In the *devenv.exe.config* file, locate the following entry:

    ```console
    <dependentAssembly>
        <assemblyIdentity name="Microsoft.ReportingServices.Interfaces" publicKeyToken="89845dcd8080cc91" culture="neutral"/>
        <bindingRedirect oldVersion="9.0.242.0" newVersion="10.0.0.0"/>
    </dependentAssembly>
    ```

- Replace the entry with the following:

    ```console
    <dependentAssembly>
        <assemblyIdentity name="Microsoft.ReportingServices.Interfaces" publicKeyToken="89845dcd8080cc91" culture="neutral" />
        <assemblyIdentity name="Microsoft.ReportingServices.Interfaces" publicKeyToken="89845dcd8080cc91" culture="neutral" />
        <bindingRedirect oldVersion="8.0.242.0" newVersion="11.0.0.0" />
        <bindingRedirect oldVersion="9.0.242.0" newVersion="11.0.0.0" />
        <bindingRedirect oldVersion="10.0.0.0" newVersion="11.0.0.0" />
    </dependentAssembly>
    ```

- Save the *devenv.exe.config* file.
- Close and then reopen Visual Studio or SSDT.

> [!NOTE]
> The steps to correct the entry in the *PreviewProcessingService.exe.config* file are the same.
