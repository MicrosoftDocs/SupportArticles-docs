---
title: Error 0x80004005 when you create DSN with GPP
description: Provides help to fix the error 0x80004005 that occurs when you configure a Data Source Name (DSN) using Group Policy Preferences (GPP).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sajijohn, markgray
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# Unable to create DSN using Group Policy Preferences, unspecified error 0x80004005

This article provides help to fix the error 0x80004005 that occurs when you configure a Data Source Name (DSN) using Group Policy Preferences (GPP).

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2001454

## Symptoms

Attempts to configure a DSN using GPP may result in error events similar to the following:

> Event ID: 4098  
Source: Group Policy DataSources  
Description: The computer \<Preference Name> preference item in the \<GPO Name>. Group Policy object did not apply because it failed with error code 0x80004005 unspecified error. This error was suppressed. 

If client-side debug logging is enabled, the following error messages may be recorded in the debug log:

> *\<DateTime>* [pid=0x70,tid=0x91c] Invalid keyword-value pairs [ hr = 0x80004005 "Unspecified error" ]  
*\<DateTime>* [pid=0x70,tid=0x91c] createDsn [ hr = 0x80004005 "Unspecified error" ]  
*\<DateTime>* [pid=0x70,tid=0x91c] Properties handled. [ hr = 0x80004005 "Unspecified error" ]

To enable GPP debug logging, enable the relevant policy setting below:

**Windows Server 2008**  

Computer Configuration\Policies\Administrative Templates\System\Group Policy\Logging and Tracing\Data Source Policy processing

**Windows Server 2008 R2, Windows 7**  

Computer Configuration\Policies\Administrative Templates\System\Group Policy\Logging and Tracing\Configure Data Sources preference logging and tracing

In the **Event Logging** section, select **Informational, Warnings, and Errors**. **Tracing** should be set to **On**.

The default locations for the log file are listed below. Both the location and name of the log file are configurable.

**Windows Server 2003, Windows XP**  

%SystemDrive%\Documents and Settings\All Users\Application Data\GroupPolicy\Preference\Trace\Computer.log

**Windows Server 2008 R2, Windows 7, Windows Server 2008, Windows Vista**  

%SystemDrive%\ProgramData\GroupPolicy\Preference\Trace\Computer.log 

## Cause

The error condition occurs if you attempt to configure username and password for the DSN policy using GPP. Username and password are not valid keywords when configuring a SQL Server DSN.
For more information about the valid SQL Server-specific keyword/value pairs for data source configuration attribute strings, visit this Microsoft [Web site](https://msdn.microsoft.com/library/aa177860%28SQL.80%29.aspx).

## Resolution

When configuring SQL connections, the only way to make the connection transparent for the user is to set **Trusted_Connection** to **Yes**. Otherwise, the user will be prompted for credentials when trying to connect.
You must also ensure that attributes not listed in the above MSDN link, including username and password, are left blank (not configured) within the policy when configuring SQL connections.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
