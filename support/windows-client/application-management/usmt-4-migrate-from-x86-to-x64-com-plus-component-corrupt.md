---
title: USMT 4.0 migration from x86 to x64 results in corrupted COM+ components
description: Solves an issue where COM+ component settings will be corrupt when you migrate from an x86 platform to an x64 platform.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: sgoad, nedpyle, tjung, kaushika
ms.custom: sap:com-and-com+-performance-and-stability, csstroubleshoot
---
# USMT 4.0 migration from x86 to x64 results in corrupted COM+ components

This article helps solve an issue where COM+ component settings will be corrupt when you migrate from an x86 platform to an x64 platform.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 2481190

## Symptoms

Using the User State Migration Tool (USMT) 4.0 to migrate from an x86 platform to an x64 platform, COM+ component settings will be corrupt.

> [!NOTE]
> The issue doesn't happen when migrating from x86 to x86 or x64 to x64 platforms.

Opening COMEXP.MSC or DCOMCNFG.EXE and navigating to Component Services\Computers\My Computer will result in the following on-screen error:

> You do not have permission to perform the requested action.

Additionally, you may see Event ID 4434 logged in the Application log:

> Log Name: Application  
Source: Complus  
Event ID: 4434  
Level: Warning  
User: N/A  
Task Category: Security  
Keywords: Classic  
Computer: `win7-1.contoso.com`  

A method call to an object in a COM+ application was rejected because the caller isn't properly authorized to make this call. The COM+ application is configured to use Application and Component level access checks, and enforcement of these checks is currently enabled. The remainder of this message provides information about the component method that the caller attempted to invoke and the identity of the caller.SVC/Lvl/Imp = 10/6/3, Identity=<\<DOMAIN\Username>>

## Cause

This is a known issue with USMT when migrating from x86 to x64.

## Resolution

Workaround  

To work around the issue in USMT 4.0, you must specify a config.xml file and set the "Microsoft-Windows-COM-ComPlus-Setup" to not migrate.

If you're not already using a config.xml file for USMT, you can generate one automatically by specifying the /genconfig switch to scanstate.exe syntax. For example:

scanstate.exe /genconfig:config.xml /i:migdocs.xml /i:migapp.xml

For more information about USMT and config.xml files, see the following Microsoft TechNet Article:

 [USMT .xml Files](https://technet.microsoft.com/library/cc766203%28ws.10%29.aspx#config)  

Once you've generated the config.xml file, you must edit the following section, depending on source operating system (OS):  

Windows XP - \<component displayname=" Microsoft-Windows-COM-ComPlus-Setup-DL " migrate=" no "  

Windows Vista or Windows 7 - \<component displayname=" Microsoft-Windows-COM-ComPlus-Setup " migrate=" no "

Save your changes to config.xml. Include the updated config.xml when using scanstate.exe to work around the issue. For example:

scanstate.exe c:\mystore /i:migdocs.xml /i:migapp.xml /config:config.xml /v:5

This will execute scanstate.exe, using c:\mystore as the migration store, and include MigDocs.XML, MigApp.xml, and Config.XML for the migration with verbose logging enabled.

## More information

If you're in a scenario in which you have already migrated and COM+ is corrupted, you can use the following procedure to restore the original COM+ repository:

From an administrative command prompt, run these three commands:

```console
CD %windir%\winsxs\
CD *amd64*com-complus*runtime*  
Dir  
```

Verify that R000000000001.clb is present. Then, copy it from the current directory to the root of the C drive by running this command:

```console
copy R000000000001.clb C:\R000000000001.clb  
```

Next, copy, and paste the following VB script (between the dashed lines) to a.txt file and rename it COM_Restore.vbs (make sure to change the .txt file extension to .vbs).  

```vbscript
 =============================================================================
Dim objComCatalog  

Set objComCatalog = CreateObject("COMAdmin.COMAdminCatalog")  
objComCatalog.RestoreREGDB "C:\R000000000001.clb"  

 MsgBox "Backup Restored!"  
Set objComCatalog = Nothing  

=============================================================================
```

Save the script to the root of C:\\.  

From the command prompt, run this command:  

```console
 C:\cscript COM_Restore.vbs  
```

Once you see the pop-up message stating that the backup is restored, restart the computer (this is required).

Finally, open Component Servers (dcomcnfg.exe) and see if you're still getting errors.

> [!NOTE]
> If you're logging in as a non-admin user and trying to start Component Services, the Event ID 4434 is expected. Non-admin users aren't part of the administrator role of the COM+ System Application and, therefore, the security warning will get logged in the event log. This doesn't mean that the COM+ catalog is corrupted.
