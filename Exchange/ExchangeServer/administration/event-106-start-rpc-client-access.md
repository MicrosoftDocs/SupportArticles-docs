---
title: Event ID 106 when starting the RPC Client Access service on Exchange Server 2010
description: Describes a problem in which event ID 106 is logged when you start the RPC Client Access service on an Exchange Server 2010 server that only has the Mailbox role installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-michse, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 106 is logged when you start the RPC Client Access service on Exchange Server 2010

_Original KB number:_ &nbsp;982679

## Symptoms

You start the Microsoft Exchange RPC Client Access service on a Microsoft Exchange Server 2010 server that has only the Mailbox role installed. In this situation, the following event is logged in the Application log:

```console
Log Name: Application

Source: MSExchange Common

Date: Date_Time_AM_PM
Event ID: 106

Task Category: General

Level: Error

Keywords: Classic

User: N/A

Computer: myExchange2010.example.com
Description:

Performance counter updating error. Counter name is Client: Foreground RPCs Failed, category name is MSExchange RpcClientAccess. Optional code: 3. Exception: The exception thrown is : System.InvalidOperationException: The requested Performance Counter is not a custom counter, it has to be initialized as ReadOnly.

at System.Diagnostics.PerformanceCounter.Initialize()

at System.Diagnostics.PerformanceCounter.set_RawValue(Int64 value)

at Microsoft.Exchange.Diagnostics.ExPerformanceCounter.set_RawValue(Int64 value)

Last worker process info : System.UnauthorizedAccessException: Access to the registry key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ExchangeServer\v14\Transport' is denied.

at Microsoft.Win32.RegistryKey.Win32Error(Int32 errorCode, String str)

at Microsoft.Win32.RegistryKey.CreateSubKey(String subkey, RegistryKeyPermissionCheck permissionCheck, RegistrySecurity registrySecurity) at Microsoft.Exchange.Diagnostics.ExPerformanceCounter.GetLastWorkerProcessInfo()

Performance Counters Layout infomration: FileMappingNotFoundException for category MSExchange RpcClientAccess : Microsoft.Exchange.Diagnostics.FileMappingNotFoundException: Cound not open File mapping for name : Global\netfxcustomperfcounters.1.0msexchange rpcclientaccess

at Microsoft.Exchange.Diagnostics.FileMapping.OpenFileMapping(String name, Boolean writable)

at Microsoft.Exchange.Diagnostics.FileMapping..ctor(String name, Boolean writable)

at Microsoft.Exchange.Diagnostics.PerformanceCounterMemoryMappedFile.Initialize(String fileMappingName, Boolean writable)

at Microsoft.Exchange.Diagnostics.ExPerformanceCounter.GetAllInstancesLayout(String categoryName)
```

## Cause

This problem occurs because the performance counters of the RPC Client Access service aren't installed when you install only the Mailbox role on an Exchange Server 2010 server. However, this doesn't affect the functionality of the Exchange Server 2010 server.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
