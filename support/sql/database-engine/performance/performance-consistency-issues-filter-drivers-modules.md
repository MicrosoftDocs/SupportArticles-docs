---
title: Performance and consistency issues when modules or driver are loaded
description: Provides a workaround for the performance issue when certain modules are loaded into SQL Server address space or certain filter drivers are loaded into a system.
ms.date: 10/22/2021
ms.custom: sap:Performance
ms.reviewer: bobward, SureshKa, jopilov
---

# Performance and consistency issues when certain modules or filter drivers are loaded

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2033238, 2454053

## Symptoms

Consider one of the following scenarios:

- Certain modules are loaded into the SQL Server process address space (Sqlservr.exe).
- Certain filter drivers are loaded into a system that is running SQL Server components.

In the scenarios, you may experience performance degradation and consistency issues of SQL Server Database Engine.

- Reports of various unresponsive-related error messages and conditions (SQL Server scheduler message such as [17883](/sql/relational-databases/errors-events/mssqlserver-17883-database-engine-error), application time-out messages, severe blocking within SQL Server).
- Slow response from SQL Server even if the concurrent amount of load or activity isn't unusually heavy.
- Exceptions (such as access violations), critical error messages about database consistency, assertion messages or unexpected process termination.
- 100% CPU utilization and long database recovery times when you use In-Memory OLTP tables in SQL Server.
- High CPU usage for the SQL Server process, especially privileged processor time.
- Unexpected or unexplained failures when SQL Server processes make Windows API calls.
- Memory dumps triggered for SQLDumper.exe may fail to complete hindering any troubleshooting activity.

Because of the nature of these issues, root cause identification often requires significant troubleshooting time and low level tracing. 

## Causes

These issues occur because of the following causes for modules and filter drivers.

### Modules (DLLs or EXEs)

These issues occur because applications or other software that are installed on a server that is running SQL Server can load certain modules into the SQL Server process (Sqlservr.exe). This may be done to achieve a specific business logic requirement, an enhanced functionality, or intrusion monitoring. These modules might perform unsupported activities that include detouring important Win32 APIs and SQL Server routines, and calling risky APIs. Additionally, some intrinsic problems within these modules may cause corruption of various memory structures that are necessary for the SQL Server process to function correctly.

The list of modules (DLLs) loaded in a given process can be obtained through various tools, such as [ListDlls](/sysinternals/downloads/listdlls) or [Process Explorer](/sysinternals/downloads/process-explorer).

### Filter drivers

[Filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) can be installed on a system as part of the Setup program of an application to provide a certain kind of functionality. Examples include antivirus protection, online backups, encryption services, and data compression or defragmentation facilities. These filter drivers insert themselves into the Windows file I/O stack to enhance or alter the behavior of filesystems requests.

Under some conditions, these requests may either take a long time to complete or consume excessive resources. Also, there might be some form of incompatibility between the different filter drivers that are present in the same driver stack.

SQL Server typically emits a lot of filesystem I/Os (some of which are larger than the average). Therefore, compared with other running applications with less I/O intensity, the problem with filter drivers will have a more serious impact on SQL Server.

> [!NOTE]
> Unlike injected DLLs, filter drivers (typically with .sys extension) are not visible in user processes details because they are kernel entities. You can use tools like Windows built-in [fltmc.exe](/windows-hardware/drivers/ifs/development-and-testing-tools#fltmcexe-command) to discover installed minifilters.

## Workaround

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We don't recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

To work around these issues, identify the filter driver or the module that is causing the issues. Then, try all or one of the following methods appropriately. To help you identify the filter driver or the module, check the [list of some possible filter drivers and modules](#list-of-filter-drivers-and-modules-that-can-cause-the-issues) for more information.

- Contact the vendor of the module, filter driver, or application to check for updates. Apply any updates that are available.
- Configure the filter driver or the associated application in such a way that it doesn't interfere with the SQL Server workload or operations.
- Disable the filter driver from loading into the system.
- Configure the application not to load the specific module into the SQL Server process.
- In some rare situations, you may have to remove the module or the filter driver, and its associated application to restore stability to the SQL Server process and the system.

## List of filter drivers and modules that can cause the issues

The following list helps you to identify the filter drivers and modules that can cause the performance issues. You can collect an iterative set of diagnostic and tracing data for the issues.

- *ENTAPI.DLL*

  *ENTAPI.DLL* is loaded into the SQL Server process if you install McAfee VirusScan Enterprise on a server that is running Microsoft SQL Server, and then you configure this software to monitor SQL Server. When this module is loaded, important Win 32 APIs are also detoured inside the SQL Server process. If you notice that this module is loaded into SQL Server process, configure McAfee VirusScan Enterprise to exclude Sqlservr.exe from various advanced monitorings, such as buffer overflow protection.

- *HIPI.DLL*, *HcSQL.DLL*, *HcApi.DLL*, and *HcThe.DLL*

    These DLL files are loaded into the SQL Server process if you install McAfee Host Intrusion Prevention software on the same system as SQL Server. If you notice that this module is loaded into SQL Server process, configure McAfee Host Intrusion Prevention to exclude Sqlservr.exe from its monitoring list.

- *SOPHOS_DETOURED.DLL*, *SWI_IFSLSP_64.DLL*, and *SOPHOS_DETOURED_x64.DLL*

    These DLL files are loaded into the SQL Server process if you install Sophos Antivirus program on a server that is running SQL Server. If you notice that this module is loaded into the SQL Server process, you can [configure the AppInit_Dlls](https://support.sophos.com/support/s/article/KB-000033536) registry subkey to avoid loading this module into SQL Server process.

- *PIOLEDB.DLL* and *PISDK.DLL*

    These DLL files are loaded into the SQL Server process if you use the PI OLEDB provider to access data from a PI server or if you use extended stored procedures that use the PI SDK. If you notice that these modules are loaded into the SQL Server process, contact the vendor of these modules to configure the OLEDB provider as an out-of-process provider. This configuration helps to avoid the need to load these modules into the SQL Server process.

- *UMPPC\*.DLL* and *SCRIPTCONTROL\*.DLL*

    These DLL files are loaded in to the address space of SQL Server related processes if you enable the **Additional User Mode Data** prevention setting for CrowdStrike Anti-Virus/Endpoint protection programs. You might notice failures while SQL Server Agent attempts to create new processes when executing jobs. You might encounter failures while attempting to launch SQL Server Management Studio. You might also see that SQL Server fails to launch SQLDumper.exe to generate memory dumps. We recommend you contact Crowdstrike support with information related to your issue and ask if a fix is available. 

- *perfiCrcPerfMonMgr.DLL*

    This DLL file is loaded into the SQL Server process if you install Trend Micro OfficeScan client. Refer to the software publisher exclusion list setting at [Recommended scan exclusion list for Trend Micro Endpoint products](https://success.trendmicro.com/solution/1059770-recommended-scan-exclusion-list-for-trend-micro-endpoint-products).

- *MFEBOPK.SYS*

    This filter driver is used for the `Buffer Overflow Protection` feature in McAfee VirusScan Enterprise. If you have this feature enabled, you will notice that sqlservr.exe is among the list of processes protected by `Buffer Overflow Protection`. If you have this filter driver on a system that is running SQL Server, you must perform the actions that are specified in the [Workaround](#workaround) section. For more information, see [High Impact Issue: Servers may become unresponsive due to multiple issues](https://techcommunity.microsoft.com/t5/ask-the-performance-team/high-impact-issue-servers-may-become-unresponsive-due-to/ba-p/374567).

- *NLEMSQL64.SYS* and *NLEMSQL.SYS*

    This filter driver is installed by the NetLib Encryptionizer-Software. When this filter driver is installed on a computer that is running SQL Server, and you perform backup to a network share, you might encounter failures that return **Operating system error 1 : Incorrect function**. To resolve this problem, contact the software vendor to obtain updates to the filter driver.

- *MFETDIK.SYS*

    This filter driver is used for the `McAfee Anti-Virus Mini-Firewall` feature in the products McAfee VirusScan Enterprise and McAfee McShield. If you have this feature enabled, you will notice that sqlservr.exe is among the list of processes monitored by the `Anti-Virus` feature. If you have this filter driver on a system that is running SQL Server, you must perform the actions that are specified in the [Workaround](#workaround) section. You could also consider adding SQL Server processes to the low risk process list in the Anti-Virus configuration.

## Reference

- [Types of WDM Drivers](/windows-hardware/drivers/kernel/types-of-wdm-drivers)
- [How to temporarily deactivate the kernel mode filter driver in Windows](../../../windows-server/performance/deactivate-kernel-mode-filter-driver.md)
- [Detours or similar techniques may cause unexpected behaviors with SQL Server](../../general/issue-detours-similar-techniques.md)
- [How to run a DLL-based COM object outside the SQL Server process](../development/run-dll-based-com-object.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Third-party information and solution disclaimer](../../../includes/third-party-information-solution-disclaimer.md)]
