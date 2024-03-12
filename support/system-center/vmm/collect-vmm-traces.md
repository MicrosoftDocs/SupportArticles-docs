---
title: Collect Virtual Machine Manager traces
description: Describes how to enable logging for the System Center 2012 R2 Virtual Machine Manager Storage Management Service.
ms.date: 03/12/2024
---
# How to collect Virtual Machine Manager traces

This article describes how to enable debug logging for the Microsoft System Center 2012 R2 Virtual Machine Manager Storage Management Service.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3037626

## Summary

The Storage Management Service communicates with SMI-S providers from several third-party providers.

> [!NOTE]
> For a complete list of providers, see [System Center 2012 VMM: Supported Storage Arrays](https://learn.microsoft.com/archive/technet-wiki/16100.system-center-2012-vmm-supported-storage-arrays).

Storage traces (CIMXML output) are useful when you troubleshoot storage provider failures.

Storage traces can grow very large quickly. Therefore, make sure that you try to narrow the time of collection as much as you can before you start a trace. To enable Storage Management Service tracing, use one of the following methods.

## Automated method

1. Download the VMM Support Diagnostics Platform (SDP) package from the following website:

   [https://aka.ms/vmmdiag](https://aka.ms/vmmdiag)

2. Follow the wizard to go to the **Select trace type** screen, and then click **Storage tracing (Select only if debugging storage providers)**.
3. Click **Next**.
4. When you are prompted, reproduce your issue, and then click **Next**. The wizard will stop logging after you press **Next** on this screen and will automatically collect your data.
5. When you are prompted, save a copy of the .cab file locally.

In the .cab file that you saved in step 5, locate the following files:

- \<_ServerName_>\_VMMLog_\<_number_>.car - VMM debug log
- \<_ServerName_>\_VMMLog_\<_number_>_error.car - VMM debug log errors only
- \<_ServerName_>-cimxmllog.xml - CimXML debug log
- \<_ServerName_>_StorageLog_02031445.etl - CIMXML ETL log

> [!NOTE]
> in these files, the placeholder \<_ServerName_> represents the name of the server that you are tracing, and the placeholder \<_number_> represents a date and time stamp string.

## Manual method

1. Create a VMM debug trace by following the steps in [How to enable debug logging in Virtual Machine Manager](https://support.microsoft.com/help/2913445).
2. Start the trace, and then go to step 3. You will capture both the VMM debug trace and the CIMXML trace at the same time.
3. Start Registry Editor (regedit.exe), and then locate the following registry key:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Storage Management`

4. Create a key that is named `CIMXMLLog` under this key if a key that has this name does not exist.
5. Create the following three values under the `CIMXMLLog` key:

   |Name|Type|Data|
   |---|---|---|
   |`LogFileName`|REG_SZ|The full path of your `CIMXMLLog`. For example, `C:\temp\cimxmllog.xml`.|
   |`LogLevel`|REG_DWORD|4|
   |`MaxLogFileSize`|REG_DWORD|0x4000000 (hexadecimal)|

6. Restart the Windows Standards-Based Storage Management service (MSStrgSvc).
7. Reproduce your issue.
8. Stop your VMM trace from step 2, and then convert it.
9. Set the `LogLevel` registry value that you created in step 5 to **0** (zero).
10. Restart the Windows Standards-Based Storage Management service (MSStrgSvc).
