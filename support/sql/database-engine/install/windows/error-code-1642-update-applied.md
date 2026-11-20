---
title: Error Code 1642 After a Successful Update
description: Learn when you can safely ignore error code 1642 in the Application event log after a SQL Server cumulative update by checking the Setup result and logs.
ms.date: 11/20/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: mcimfl, troymoen, sureshka
ai-usage: ai-assisted
---
# Error code 1642 in the Application log after a successful SQL Server update

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4230836

## Summary

When you install a cumulative update (CU) for Microsoft SQL Server on Windows, the Application event log can report error code 1642 even though Setup completed successfully. This article explains how to check the update result and determine whether you can safely ignore the event. Ignore the event only if the CU installation completed successfully and *Summary.txt* contains no error messages. This guidance describes that specific logging scenario; it doesn't establish that every SQL Server version exhibits this behavior.

## Symptoms: MsiInstaller event 1024 with error code 1642

After a SQL Server CU installation completes successfully, the Windows Application event log might contain an error from **MsiInstaller**, with event ID **1024** and error code **1642**.

The following example shows what the event might look like in SQL Server 2016. Compare the event source, event ID, and error code with your event, rather than the example's product name or identifier.

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

## Cause: SQL Server Setup can't retrieve the patch file list

In this logging scenario, an MSI installer package failure is recorded in the Application event log because SQL Server Setup's call to the [MsiGetPatchFileList function](/windows/win32/api/msi/nf-msi-msigetpatchfilelistw) doesn't return a list of files from the Windows Installer patch file (.msp).

Windows Installer defines error code 1642 as `ERROR_PATCH_TARGET_NOT_FOUND`: the program to update might be missing, or the patch might target a different version of the program. For the general definition, see [Windows Installer error codes](/windows/win32/msi/error-codes). The event alone doesn't establish whether the SQL Server CU installation succeeded; check the Setup result and logs.

## Resolution: Verify the SQL Server update before ignoring the event

You can safely ignore this error code 1642 event in the Application event log when **both** of the following conditions are true:

- Setup of the SQL Server CU completed successfully.
- No error messages are recorded in the *Summary.txt* file for that update attempt.

To check the Setup logs:

1. Open *Summary.txt* in `%programfiles%\Microsoft SQL Server\<nnn>\Setup Bootstrap\Log\`. The `<nnn>` folder corresponds to the SQL Server version being updated.
1. Review the execution summary and search for `error` or `failed` to find error messages.
1. If Setup failed or the summary contains error messages, continue investigating the update failure instead of ignoring the event. For update-failure guidance, see [Troubleshoot common SQL Server cumulative update installation issues](sqlserver-patching-issues.md).

For log locations and details about *Summary.txt*, *Detail.txt*, and MSI logs, see [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).

## Related content

- [Install SQL Server servicing updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)
