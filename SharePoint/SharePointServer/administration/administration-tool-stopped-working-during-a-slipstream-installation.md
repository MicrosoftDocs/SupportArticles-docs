---
title: SharePoint Foundation administration tool has stopped working error during a slipstream installation of SharePoint Server 2016
description: Provides a workaround for an issue in which SharePoint Foundation administration tool stops working when you run a slipstream installation of SharePoint Server 2016.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Setup, Upgrade, Migration and Patching
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# "SharePoint Foundation administration tool has stopped working" error during a slipstream installation  

## Symptoms  

When you run a slipstream installation of SharePoint Server 2016, you receive the following error message:

> SharePoint Foundation administration tool has stopped working  

## Cause  

This error occurs because the Microsoft SharePoint Foundation administration tool (Stsadm.exe) tries to access the SharePoint farm during a slipstream installation before the farm is created.  

## Status  

You can safely ignore this message because the error doesn't affect the integrity of the SharePoint slipstream installation.

## Workaround  

To avoid this error, run a non-slipstream installation of SharePoint Server 2016. After the SharePoint Server 2016 installation is complete, install the SharePoint updates.

## More information  

A slipstream installation installs the product and additional product updates at the same time. To run a slipstream installation, put the .msp files from the SharePoint updates into the updates folder of the SharePoint installation media. Then, run the Setup.exe file from the SharePoint installation media.

When this error occurs, the Windows event log may include the following logged events:

```output
Log Name: Application  
Source: .NET Runtime  
Date: DateTime  
Event ID: 1026  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: ServerName  
Description:  
Application: stsadm.exe  
Framework Version: v4.0.30319  
Description: The process was terminated due to an unhandled exception.  
Exception Info: System.IO.FileNotFoundException  
at Microsoft.SharePoint.StsAdmin.SPStsAdmin..cctor()  
Exception Info: System.TypeInitializationException  
at Microsoft.SharePoint.StsAdmin.SPStsAdmin.Main(System.String[])
```

```output
Log Name: Application  
Source: Application Error  
Date: DateTime   
Event ID: 1000  
Task Category: (100)  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: ServerName  
Description:  
Faulting application name: stsadm.exe, version: 16.0.4300.1000, time stamp: 0x561d26d9  
Faulting module name: KERNELBASE.dll, version: 6.3.9600.18340, time stamp: 0x57366075  
Exception code: 0xe0434352  
Fault offset: 0x000000000000xxxx  
Faulting process id: 0x000  
Faulting application start time: 0x0000000000000000  
Faulting application path: C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\BIN\stsadm.exe  
Faulting module path: C:\Windows\system32\KERNELBASE.dll  
Report Id: 00000000-0000-0000-0000-000000000000  
Faulting package full name:  
Faulting package-relative application ID:
```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
