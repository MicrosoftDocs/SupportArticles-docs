---
title: RS Diagnostics Collector collects information 
description: This article describes the information that may be collected from a computer when the SQL RS Diagnostics Collector tool is running.
ms.date: 08/19/2020
ms.reviewer: ramakoni
ms.topic: article
---
# Information that is collected by SQL RS Diagnostics Collector

This article describes the information that may be collected from a computer when the SQL RS Diagnostics Collector tool is running.

_Original product version:_ &nbsp; Microsoft SQL Server 2012, SQL Server 2008, SQL Server 2008 R2, SQL Server 2005  
_Original KB number:_ &nbsp; 2773194

## Summary

The SQL RS Diagnostics Collector for Windows Server 2003 R2, Windows Vista, Windows Server 2008, Windows Server 2008 R2, Windows 7, Windows 8, Windows 8.1, Windows Server 2012, and Windows Server 2012 R2 collects diagnostic information that is useful in troubleshooting a broad class of issues that involve SQL Server Reporting Services (SSRS). This collector is used to collect information for both the Native mode and the SharePoint mode of SSRS.

The SQL RS Diagnostics Collector supports the following versions of SQL Server:

- SQL Server 2005
- SQL Server 2008
- SQL Server 2008 R2
- SQL Server 2012

## Prerequisite software

There are different prerequisites to run diagnostic packages, depending on the operating system of the destination computer. The diagnostic package will automatically check your computer for these prerequisites, and then start if the prerequisites are already installed. If the prerequisites are not already available on the computer, you are prompted to install them. The Automated Troubleshooting Service (MATS) can also install the required software for you. For example, if Windows PowerShell is not present on the destination computer, MATS will install it automatically. For more information, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).

## Required Windows rights

You must have administrative rights on the computer from which you execute the SQL RS Diagnostics Collector.

## Steps that are involved

The SQL RS Diagnostics Collector must be manually run on all computers that are involved in the SSRS configuration. For example if the SSRS is a scale-out deployment, then the SQL RS Diagnostics Collector should be manually run on all computers that are involved in the scale-out configuration. Similarly, on a SharePoint-integrated mode, the SQL RS Diagnostics Collector should be run on SharePoint.

## SQL Server security requirements

The SQL RS Diagnostics Collector discovers all instances of reporting services that are installed on the computer where the diagnostics tool is run. As part of the data collection process, the SQL RS Diagnostics Collector tries to connect to each SSRS catalog database server to which the SSRS instances connect, and then collects information from the ReportServer catalog database. Database connections are made by using Windows authentication. In order to start the SQL RS Diagnostics Collector, you must have a Windows logon that is a member in the sysadmin fixed server role.

## SharePoint security requirements

The SQL RS Diagnostics Collector discovers all instances of reporting services that are installed on the computer. If the computer hosts just the SharePoint software that SSRS integrates to, then the SQL RS Diagnostics Collector collects information about the SharePoint configuration, installed websites, and so on. In order to execute the SQL RS Diagnostics Collector, you must have a Windows logon that is a member of the administrator group on the computer.

## Information that is collected by the SQL RS Diagnostics Collector

- **System event log**

    > [!NOTE]
    > The SQL RS Diagnostics Collector collects events from the previous 30 days.

    |Description|File name|
    |---|---|
    |System event log in TXT, CSV, and EVT or EVTX formats| _<COMPUTER_NAME> _ evt_System.csv_<br> _<COMPUTER_NAME> _ evt_System.txt_<br/> _<COMPUTER_NAME> _ evt_System.(evt or evtx)_|

- **Application event log**

    > [!NOTE]
    > The SQL RS Diagnostics Collector collects events from the previous 30 days.

    |Description|File name|
    |---|---|
    |Application event log in TXT, CSV, and EVT or EVTX formats| _<COMPUTER_NAME> _evt_Application.csv_<br/> _<COMPUTER_NAME> _ evt_Application.txt_<br/> _<COMPUTER_NAME> _evt_Application.(evt or evtx)_|

- **Registry information that is related to reporting services configuration**

    |Description|File name|
    |---|---|
    |Collect registry key and child keys under `HKLM:\System\CurrentControlSet\Services\TCPIP\Parameters`.| _<COMPUTER_NAME> _RS_Registry.XML_|
    |Collect registry key and child keys under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`.| _<COMPUTER_NAME> _RS_Registry.XML_|

- **Information from all services that are installed on the destination computer**

    |Description|File name|
    |---|---|
    |Collect information about services that are installed on the destination computer.| _<COMPUTER_NAME> _MiscProperties.XML_|

- **Information from the ULS logs from the SharePoint instance on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the ULS logs from the SharePoint that is installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> _Date.log_|

- **Information from the SSRS Logs from all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the SSRS logs from the SSRS instances that are installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> _ReportServerService_GUID.log_|

- **Information from the SSRS ReportServer.Config file from all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the _RSReportServer.Config_ file from the SSRS instances that are installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> _RSReportserver.config_|

- **Information from the Web.config file from all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the _Web.config_ file from the ReportServer and ReportManager directories from all SSRS instances that are installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> _web.config_|

- **Information from the SSRS configuration for all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the configuration information that is stored in the SSRS Catalog database for all SSRS instances that are installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> ConfigInfo.XML_|

- **Information from the execution information for all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the execution information that is stored in the SSRS Catalog database for all SSRS instances that are installed on the destination computer.| _<COMPUTER_NAME>.<INSTANCE_NAME> ExecutionInfo.XML_|

- **Information from the SPN configuration for all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the SPN configuration information for the SSRS service account that is running the SSRS instance. (if the server is running SharePoint)| _<COMPUTER_NAME> _RS_SPN.XML_|

- **Information from the HTTP error logs on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the HTTP error logs on the destination computer.| _<COMPUTER_NAME>.httperrX.log_|

- **Information from the HTTP logs for all SSRS instances on the destination computer**

    |Description|File name|
    |---|---|
    |Collect the HTTP logs that are generated if the attribute is turned on the SSRS _Reportserver.config_ files.| _<COMPUTER_NAME>.<INSTANCE_NAME> _Http.log_|

## Applies to

- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Enterprise Core
- SQL Server 2012 Express
- SQL Server 2012 Web
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Parallel Data Warehouse
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Evaluation Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Workgroup Edition
