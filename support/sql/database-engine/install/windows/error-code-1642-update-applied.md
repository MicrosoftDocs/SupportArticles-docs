---
title: Error code 1642 though update is applied
description: This article provides more information about the 1642 error message that is reported in the application event log though the SQL Server update is applied successfully.
ms.date: 10/23/2020
ms.custom: sap:Database Engine
ms.reviewer: mcimfl, troymoen, sureshka, ramakoni, Daleche 
---
# Application event log error code 1642 even though the SQL Server update was applied successfully

This article provides more information about the 1642 error message that's reported in the application event log though the SQL Server update is applied successfully.

_Original product version:_ &nbsp; SQL Server 2016, SQL Server 2014, SQL Server 2012 Developer, SQL Server 2012  
_Original KB number:_ &nbsp; 4230836

## Symptoms

When you install a cumulative update to Microsoft SQL Server, setup may complete successfully. However, you may find the following error logged in the system's Application event log:

```console
Log Name:      Application  
Source:        MsiInstaller  
Date:         date time  
Event ID:      1024  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          SYSTEM  
Computer:     host_name  
Description:  
Product: SQL Server 2016 Database Engine Services - Update '  {DDCDC225-F14E-411F-925A-7CF68238240F}' could not be installed. Error code 1642. Windows Installer can create logs to help troubleshoot issues with installing software packages. Use the following link for instructions on turning on logging support: http://go.microsoft.com/fwlink/?LinkId=23127  
Event Xml:  
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
    <System>
        <Provider Name="MsiInstaller" />
        <EventID Qualifiers="0">1024</EventID>
        <Level>2</Level>
        <Task>0</Task>
        <Keywords>0x80000000000000</Keywords>
        <TimeCreated SystemTime="date time" />
        < EventRecordID>463708</EventRecordID>
        < Channel>Application</Channel>
        <Computer>host_name</Computer>
        <Security UserID="user_id" />
    </System>
    <EventData>
        <Data>SQL Server 2016 Database Engine Services</Data>
        < Data>{DDCDC225-F14E-411F-925A-7CF68238240F}</Data>
        <Data>1642</Data>
        <Data>(NULL)</Data>
        <Data>(NULL)</Data>
        <Data>(NULL)</Data>
        <Data>
        </Data>
        <Binary>7B42463645333843342D443830312D343530382D394536312D3236463545303544363045437D207B44444344433232352D463134452D343131462D393235412D3743463638323338323430467D2031363432</Binary>
    </EventData>
</Event>
```

## Cause

This issue occurs in several scenarios in which an MSI installer package failure is logged in the Application event log because the setup call to the `MsiGetPatchFileList` API doesn't get a list of files from the MSP (Windows Installer patch file).

## Resolution

You can safely ignore this message in the Application event log when the following conditions are true:

- Setup of the SQL Server cumulative update completed successfully.

- No error messages are recorded in the *Summary.txt* file.

For more information, see [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).
