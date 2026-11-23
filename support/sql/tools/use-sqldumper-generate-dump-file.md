---
title: Use Sqldumper.exe to Generate Dump Files in SQL Server
description: Learn how to use Sqldumper.exe in SQL Server to generate mini, filtered, and full memory dump files, with steps, permissions, and cluster guidance.
ms.reviewer: sureshka, jopilov
ms.date: 11/17/2026
ms.topic: how-to
ms.custom: sap:SQL Server Management, Query and Data Tools
ai-usage: ai-assisted
---

# Use Sqldumper.exe to generate a dump file in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 917825

## Summary

The Sqldumper.exe tool in Microsoft SQL Server enables you to generate memory dump files of the SQL Server process and other Windows processes. SQL Server supports mini, filtered, and full dumps. Use them for Watson error reporting or debugging. This article explains how to run Sqldumper.exe manually, where the dump files are stored, which permissions you need, and how dump generation affects SQL Server availability. Use this article to collect dump files to help you troubleshoot problems such as exceptions, asserts, or non-yielding schedulers.

The article also describes two other methods to generate dump files: a [PowerShell script](#how-to-use-a-powershell-script-to-generate-a-dump-file-with-sqldumper) that automates SQLDumper.exe command line options, and the [DBCC STACKDUMP](#how-to-use-dbcc-stackdump) Transact-SQL (T-SQL) command that generates a dump file in SQL Server.

## How to run Sqldumper.exe manually

Before you run Sqldumper.exe:

- Check the [required permissions](#permissions-required-to-run-sqldumperexe).
- Obtain the target application's [process identifier](#how-to-obtain-a-microsoft-windows-application-process-identifier).
- [Choose a dump type](#dump-types) and confirm that the output drive has [sufficient space](#plan-disk-space-for-dump-files).
- Review the [availability impact](#impact-of-dump-generation). Dump generation temporarily freezes the target process and might trigger failover on clustered systems.

Run the Sqldumper.exe tool from the folder where SQL Server originally installed the tool.

By default, SQL Server installs Sqldumper.exe in the _\<SQLServerInstall Drive\>:\Program Files\Microsoft SQL Server\\\<number\>\Shared_ folder. In this path, \<SQLServerInstall Drive\> is a placeholder for the drive where you installed SQL Server, and \<number\> depends on the SQL Server version, as shown in step 1. For more information about default installation paths, see [File locations for default and named instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

To generate a dump file by using the Sqldumper.exe tool, follow these steps:

1. Open _\<SQLServerInstall Drive\>:\Program Files\Microsoft SQL Server\\\<number\>\Shared_ folder.

    In this folder path, \<number\> is a placeholder for one of the following versions:

      - 170 for SQL Server 2025
      - 160 for SQL Server 2022
      - 150 for SQL Server 2019
      - 140 for SQL Server 2017
      - 130 for SQL Server 2016
      - 120 for SQL Server 2014
      - 110 for SQL Server 2012
      - 100 for SQL Server 2008
      - 90 for SQL Server 2005

1. Make sure that the _Dbghelp.dll_ file is in this folder.
1. Select **Start** > **Run**, type `cmd`, and then select **OK**.
1. At the command prompt, type the following command, and then press **Enter**:

    ```cmd
    cd <SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\<number>\Shared
    ```

    > [!NOTE]
    > In this folder path, \<number\> is the same placeholder that changes with the SQL Server version, as described earlier.

1. To generate a specific kind of dump file, type the corresponding command at the command prompt, and then press **Enter**:
   - Full dump file:

        ```cmd
        Sqldumper.exe <ProcessID> 0 0x01100
        ```

   - Mini-dump file:

        ```cmd
        Sqldumper.exe <ProcessID> 0 0x0120
        ```

   - Mini-dump file that includes indirectly referenced memory (this is the recommended option and is also used by SQL Server by default when it auto-generates memory dump files):

       ```cmd
       Sqldumper.exe <ProcessID> 0 0x0128
       ```

   - Filtered dump file:

        ```cmd
        Sqldumper.exe <ProcessID> 0 0x8100
        ```

    > [!NOTE]
    > \<ProcessID\> is a placeholder for the process identifier of the Windows application for which you want to generate a dump file.

If Sqldumper.exe runs successfully, the tool generates a dump file in the folder where the tool is installed.

The dump file that Sqldumper.exe generates has a file name pattern that resembles _SQLDmpr\<xxxx\>.mdmp_.

In this pattern, \<xxxx\> is an increasing number that's based on other files that have a similar file name in the same folder. If the folder contains files that match the specified pattern, consider comparing their creation dates and times to find the file you want.

### How to obtain a Microsoft Windows application process identifier

To create a dump file by using the Sqldumper.exe tool, you need the process identifier (PID) of the Windows application. Here's how to get the process identifier by using Task Manager:

1. Press **Ctrl+Alt+Delete**, and select **Task Manager**.
1. In **Task Manager**, select the **Details** tab. In older versions of Windows, select the **Processes** tab instead.
1. If the **PID** column isn't displayed, right-click a column header, and then select **Select columns**. Select the **PID (Process Identifier)** checkbox, and then select **OK**. In older versions of Windows, select **Select Columns** on the **View** menu, select the **PID (Process Identifier)** checkbox, and then select **OK**.
1. Note the process identifier of the Windows application. For the SQL Server application, note the process identifier of the _Sqlservr.exe_ process.
1. Close **Task Manager**.

Alternatively, use the SQL Server error log file to get the process identifier of the SQL Server application that's running on your computer. Part of the SQL Server error log file resembles the following example:

```output
2021-09-15 11:50:32.690 Server       Microsoft SQL Server 2019 (RTM-CU12) (KB5004524) - 15.0.4153.1 (X64)
    Jul 19 2021 15:37:34
    Copyright (C) 2019 Microsoft Corporation
    Enterprise Edition (64-bit) on Windows 10 Pro 10.0 <X64> (Build 19043: ) (Hypervisor)
2021-09-15 11:50:32.690 Server       UTC adjustment: -5:00
2021-09-15 11:50:32.690 Server       (c) Microsoft Corporation.
2021-09-15 11:50:32.690 Server       All rights reserved.
2021-09-15 11:50:32.690 Server       Server process ID is 7028.
```

The number that appears after `Server process ID` is the process identifier for the _Sqlservr.exe_ process.

## Output path for memory dump files

SQLDumper.exe primarily generates memory dump files for the SQL Server process when a memory dump is needed to resolve specific issues, such as exceptions, asserts, or non-yielding schedulers. In such cases, SQL Server invokes the SQLDumper.exe to generate a memory dump file of its process. By default, the memory dump file is stored in the SQL instance _MSSQL\LOG\\_ directory.

### How to change the default dump file directory

If the dump file size is too large, you can change the directory by following these steps:

1. Open **SQL Server Configuration Manager**.
1. Under **SQL Server Services**, locate the SQL Server instance that you want to investigate.
1. Right-click the entry, select **Properties**, and then select the **Advanced** tab.
1. Change the **Dump Directory** to the desired path, and then select **OK**.
1. Restart SQL Server (when possible) for the new setting to take effect.

When you use the Sqldumper.exe tool manually to generate a dump file for any Windows application, the dump file can be as large as the memory that the Windows application is currently using. Ensure that there's sufficient disk space on the drive where Sqldumper.exe writes the dump file.

### Specify a custom output folder when you run Sqldumper.exe

You can specify the directory where you want the Sqldumper.exe tool to write the dump file. The directory must already exist before you run Sqldumper.exe. Otherwise, Sqldumper.exe fails. Don't use a UNC (Universal Naming Convention) path as a location for the dump file. The following steps provide an example of how to specify the location of the mini-dump file:

1. Select **Start** > **Run**, enter `cmd`, and then select **OK**.
1. At the command prompt, type the following command, and then press **Enter**:

    ```cmd
    cd <SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\<number>\Shared
    ```

1. At the command prompt, type the following command, and then press **Enter**:

    ```cmd
    Sqldumper.exe ProcessID 0 0x0128 0 <MdumpPath>
    ```

    > [!NOTE]
    > \<MdumpPath\> is a placeholder for the directory where you want the Sqldumper.exe tool to write the dump file. By default, the file is written to the current folder.

If you specify a full dump file or a filtered dump file to be generated, Sqldumper.exe might take several minutes to generate the dump file. The time it takes depends on the following variables:

- The amount of memory that _Sqlservr.exe_ is currently using.
- The write speed of the drive used by the tool to store the dump file.

During this time, the Sqldumper.exe tool doesn't process commands. You notice that the server stops responding. Also, a cluster failover might occur.

## Permissions required to run Sqldumper.exe

To run Sqldumper.exe, sign in to Windows by using one of the following methods:

- Use an account that's a member of the administrator's group on the computer.
- Use the same user account under which the SQL Server service is running.

For the Sqldumper.exe tool to work successfully through Remote Desktop (formerly Terminal Services), start Remote Desktop in the console mode. For example, to start Remote Desktop in the console mode, select **Start** > **Run**, type _mstsc /admin_ (which connects to the administrative session), and then select **OK**. In Remote Desktop Connection 6.0 and earlier versions, use _mstsc /console_ instead. If the target server runs Windows 2000, the **/console** option is silently ignored. You can connect to the server through Remote Desktop, but you don't use the console session. For more information about the options, see [mstsc](/windows-server/administration/windows-commands/mstsc).

## Troubleshoot Sqldumper.exe errors

If no dump file is generated in the current folder after running Sqldumper.exe, check the command line output generated by the tool to identify the potential cause of the failure. This information is also logged in the _Sqldumper_errorlog.log_ file in the current directory. The following table lists two possible error messages and their causes:

| Message | Cause |
|--|--|
| "OpenProcess failed 0x57 - The parameter is incorrect" | An invalid Process ID was passed to the Sqldumper.exe utility. |
| "Invalid value for thread id - \<invalid parameter\> Parameter error" | An invalid parameter was passed to the Sqldumper.exe utility. |

If an error message that resembles one of the following messages is generated, you can safely ignore it:

- "Unknown callback type during minidump 6"
- "Unknown callback type during minidump 7"

## Impact of dump generation

When you request a dump file of a user-mode process (as discussed in this article, as opposed to Operating System Kernel Dumps, which are outside our scope), the target process (here SQLServer.exe) is frozen for the duration it takes to serialize the dump content to its file target.

Frozen means that the process can't run any user request or any internal operation, including any Resource Polling mechanism such as the implementation of Windows Clustering's IsAlive and Looks Alive (see the [Memory dumps on cluster failovers section](#generate-a-memory-dump-on-cluster-failovers) for details about how to handle that situation). The freeze might also breach any timeout that relies on wall clock time.

The duration of the freeze is the critical factor, driven by the following factors:

- The **type of dump** selected.
- The **size of SQL Server process in memory**, which in the case of a single active instance running default parameters is often close to the **total physical RAM of the server**.
- The performance of the disk used as a target for the dump.

## Manage the impact on clustered systems

The process is temporarily suspended during dump generation. This suspension might affect SQL Server service availability and trigger resource failover in Always On contexts (both [Failover cluster instance](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server) and [Availability group](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server)). The dump generation of different processes impacts resources differently. Read the [Impact of dump generation](#impact-of-dump-generation) and [Dump types](#dump-types) sections carefully.

When you capture a SQL Server dump on a failover clustered instance or an availability group (AG) instance of SQL Server, the clustered SQL Server or AG might fail over to another node if the dump takes too long to complete. This behavior might be especially problematic on systems that use large amounts of RAM or if you're generating a filtered or a full memory dump. To prevent failover, use the following settings before capturing the dump file. You can revert the change after taking the dump file:

- For failover clustered instance (FCI):
  - Right-click SQL Server resource in **Cluster Administrator**, select **If resource fails, do not restart** on the **Policies** tab.
  - On the **Properties** tab, increase the **HealthCheck Timeout**. For example, set the property value to _180_ seconds or higher. If this timeout is reached, the policy **If resource fails, do not restart** is ignored, and the resource is restarted.
  - On the **Properties** tab, change the **FailureConditionLevel** value to zero.
- For AG, apply all the following settings:
  - Increase session-timeout, for example, 120 seconds for all replicas. In SQL Server Management Studio (SSMS), right-click the replica to be configured, and then select **Properties**. Change the **Session timeout (seconds)** field to _120_ seconds. For more information, see [Change the Session-Timeout Period for an Availability Replica (SQL Server)](/sql/database-engine/availability-groups/windows/change-the-session-timeout-period-for-an-availability-replica-sql-server).
  - Change the auto failover of all replicas to manual failover. In SSMS, right-click replica, select **Properties**, and change the **auto failover** of all replicas to manual failover on the **Properties** tab. For more information, see [Change the Failover Mode of an Availability Replica (SQL Server)](/sql/database-engine/availability-groups/windows/change-the-failover-mode-of-an-availability-replica-sql-server).
  - Increase the **LeaseTimeout** to _60,000_ ms (60 seconds) and change **HealthCheckTimeout** to _90,000_ ms (90 seconds). In **Cluster Administrator**, right-click AG resource, select **Properties**, and then switch to the **Properties** tab to modify both settings. For more information, see [Configure HealthCheckTimeout Property Settings](/sql/sql-server/failover-clusters/windows/configure-healthchecktimeout-property-settings).

## Product improvements to reduce the impact on SQL Server

Recent versions of SQL Server include four major improvements that reduce the size of the dump file and the time it takes to generate the memory dump:

- [Bitmap filtering mechanism](#bitmap-filtering-mechanism)
- [Elimination of repeated dumps on the same issue](#elimination-of-repeated-dumps-on-the-same-issue)
- [Shortened output in the error log](#shortened-output-in-the-error-log)
- [Parallel compression of memory dumps](#parallel-compression-of-memory-dumps)

### Bitmap filtering mechanism

SQL Server allocates a bitmap that keeps track of memory pages to exclude from a filtered dump. Sqldumper.exe reads the bitmap and filters out pages without needing to read any other memory manager metadata. You see the following messages in the SQL Server error log when the bitmap is enabled or disabled respectively:

`Page exclusion bitmap is enabled.` and `Page exclusion bitmap is disabled.`

- SQL Server 2016

    Starting with SQL Server 2016 SP2 CU13, the bitmap filtering is enabled by default.

- SQL Server 2017

  - This feature isn't available in RTM through CU15.
  - In SQL Server 2017 CU16, you can enable the bitmap filtering via T8089 and disable it by turning off T8089.
  - Starting with SQL Server 2017 CU20, the bitmap filtering is enabled by default. Trace flag T8089 no longer applies and is ignored if turned on. You can disable the bitmap filtering via T8095.

- SQL Server 2019

    This feature is enabled by default in SQL Server 2019 RTM. You can disable it via T8095.

### Elimination of repeated dumps on the same issue

SQL Server eliminates repeated memory dumps on the same problem. By using a stack signature, the SQL engine keeps track if an exception already occurred and won't produce a new memory dump if there's one already. This behavior applies to access violations, stack overflow, asserts, and index corruption exceptions. This feature significantly reduces the amount of disk space used by memory dumps and doesn't freeze the process temporarily to generate a dump. SQL Server 2019 introduced this feature.

In SQL Server 2022 CU12 and later versions, you can turn on trace flag 2616 so that Sqldumper.exe generates a single dump per unique stack signature per hour. This feature helps prevent dump flooding when the same issue repeats frequently. When you enable trace flag 2616, the dump file name format changes. For more information, see [DBCC TRACEON trace flags](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#trace-flags).

### Shortened output in the error log

The content generated in the SQL Server error log from a single memory dump can be overwhelming. It can also slow down the process of generating a memory dump because of the time required to serialize all this information into a text format in the error log. In SQL Server 2019, the content stored in the error log upon dump generation is greatly reduced and might look like this:

```output
DateTimespidS pid    **Dump thread - spid = 0, EC = 0x0000015C7169BF40
DateTimespidS pid    *
DateTimespidS pid    *User initiated stack dump. This is not a server exception dump.
DateTimespidS pid    *
DateTimespidS pid    Stack Signature for the dump is 0x00000000788399E5
DateTimespidS pid    External dump process return code 0x20000001.
External dump process returned no errors.
```

Previously, SQL Server printed information for each session or thread when a user triggered a manual dump.

### Parallel compression of memory dumps

To generate dumps faster and make them smaller, [SQL Server 2022 CU8](https://support.microsoft.com/help/5029666#2591508) and [SQL Server 2019 CU23](https://support.microsoft.com/help/5030333#2639915) introduced a compressed memory dump feature. When activated, Sqldumper.exe creates multiple threads to read a process's memory simultaneously, compresses it, and then saves it to the dump file. This multithreaded, parallel compression reduces file size and speeds up the dumping process when used with full and filtered dumps.

Turn on trace flag 2610 to enable compressed memory dump:

```sql
DBCC TRACEON (2610,-1)
GO
DBCC STACKDUMP with FILTERED_DUMP
GO
DBCC TRACEOFF (2610,-1)
```

Alternatively, add `-T2610` as a startup parameter to your SQL Server instance so it always creates compressed memory dumps.

If you manually run Sqldumper.exe, you can use the `-zdmp` parameter to capture a compressed memory dump. For example:

```cmd
Sqldumper.exe <ProcessID> 0 0x8100 0 d:\temp -zdmp
```

You can also limit how many cores Sqldumper.exe can use to create the compressed dump by using the `-cpu:X` parameter, where _X_ is the number of CPUs. This parameter is only available when you manually run Sqldumper.exe from the command line:

```cmd
Sqldumper.exe <ProcessID> 0 0x8100 0 d:\temp -zdmp -cpu:8
```

## Factors that prevent or delay creation of memory dumps

The following factors can cause delays or prevent the creation of memory dumps.

- The IO path where memory dumps are written performs poorly. In such cases, investigate and resolve disk I/O performance.
- An antivirus or other monitoring software is interfering with SQLDumper.exe. In some cases, third-party software detours the [ReadProcessMemory](/windows/win32/api/memoryapi/nf-memoryapi-readprocessmemory) function. This behavior can dramatically increase the dump duration. To resolve most of these issues, disable the interfering software or add SQLDumper.exe to an exclusion list.

## Dump types

You can use the following methods to generate three different types of dumps: [mini dumps](#mini-dumps-with-referenced-memory), [full dumps](#full-dumps), and [filtered dumps](#filtered-dumps). Choose the dump type based on the size of the SQL Server process and how long the process can be frozen.

### Mini dumps with referenced memory

This type of memory dump is a snapshot of all active threads of the process ("thread stacks"), along with a limited extract of the memory referenced by the thread stacks and some other key process or thread data. They're typically a few megabytes in size, and are fast to generate (from less than a second to a couple of seconds). Even larger server systems (with hundreds of CPU indirectly driving massive number of threads in SQL Server process) rarely exceed 20-30 MB: the size of a mini dump doesn't grow with the size of SQL Server process. This dump type is the default type used by SQL Server when generating memory dumps automatically on exceptions, scheduler issues, latch issues, database corruption, and asserts.

> [!NOTE]
> SQL Server, as part of its built-in instrumentation, generates automated "diagnostic mini dumps" in some specific situations. This operation is therefore considered safe enough that SQL Server can trigger it automatically when needed.

### Full dumps

A full memory dump is a complete copy of the active target process space. It includes all thread state, all process allocated memory, and all loaded modules. Full dumps have a size that's roughly the same as the SQL Server process, which in turn might be **almost as large as total system RAM**. On large servers dedicated to a single SQL Server instance, this size might mean a file that's several hundred gigabytes or more. Such a file takes a long time to generate and induces prolonged freeze. Disk performance for the file target of the dump significantly influences the freezing time. This type of dump is rarely used for SQL Server nowadays, as described in the following explanation.

### Filtered dumps

As the RAM size of typical servers running SQL Server steadily increases, full dumps become more unwieldy. Filtered dumps exclude large areas of SQL Server memory on the fly and don't write them to disk. Typically, the excluded memory brings no added value to troubleshooting. Examples are data and index pages, and some internal caches like Hekaton data pages and Log Pool memory.

This filtered dump results in a smaller file than a full dump, but the dump still retains almost all its usefulness. **Filtered dumps have replaced full dumps as the preferred option in a vast majority of situations where mini dumps aren't sufficient**. The decrease in size can vary compared to a full dump, but it's still a rather large file, which is often 30-60 percent of SQL Server process size. Plan for a possible size as large as a full dump as a worst option, which leaves a good safety margin. A filtered dump might not be necessarily faster to generate than a full dump in every case. It's a matter of whether the gains related to the number of avoided IO exceed the time required to implement the filter logic. Disk speed and CPU/RAM speed influence that.

You can use the following query to get a rough estimate of the filtered dump size. Although most data or index pages are excluded from the dump, the ones that are exclusively latched and being modified aren't omitted.

```sql
SELECT SUM(pages_kb)
FROM sys.dm_os_memory_clerks
WHERE type != 'MEMORYCLERK_SQLBUFFERPOOL'
```

Since you can use Sqldumper.exe to generate a dump file on demand for any Microsoft Windows application, consider using the filtered dump option. However, a filtered dump file is only applicable and meaningful in the context of SQL Server. You can still generate a mini dump, a full dump file, or non-SQL Server applications successfully.

### Change the default dump type by using trace flags

The SQL Server process calls the Sqldumper.exe tool internally to generate a dump file when the process experiences any exceptions. SQL Server passes parameters to Sqldumper.exe. You can use trace flags to change the parameters that SQL Server passes to the tool by default when an exception or assertion occurs. These trace flags are in the range from 2540 to 2559. You can use one of these trace flags to change the default dump type SQLDumper.exe generates (the default is a mini-dump with referenced memory). For more information, see [DBCC TRACEON trace flags](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#trace-flags). For example:

- Trace Flag 2551: Produces a filtered memory dump.
- Trace Flag 2544: Produces a full memory dump.
- Trace Flag 8026: SQL Server clears a dump trigger after generating the dump once.

If two or more trace flags are active, the option indicating the largest memory dump takes effect. For example, if trace flags 2551 and 2544 are used, SQL Server creates a full memory dump.

### Plan disk space for dump files

Plan for the **size of the dump file** on disk, especially if multiple dumps are possible and if you select large, non-default dump types. Review the [Dump types](#dump-types) to know what to expect. By default, some dump methods create the dump in SQL Server Instance's _\Log_ folder, which in default simple configuration is also the system disk and data+log disk for SQL Server. Bringing that disk to saturation has severe impact on SQL Server and system availability.

## Generate a memory dump on cluster failovers

In cluster failover scenarios, the SQL Server resource DLL can obtain a dump file before the failover occurs to assist with troubleshooting. When the SQL Server resource DLL determines that a SQL Server resource has failed, the SQL Server resource DLL uses the Sqldumper.exe utility to obtain a dump file of the SQL Server process. To ensure that the Sqldumper.exe tool successfully generates the dump file, you must set the following three properties as prerequisites:

- `SqlDumperDumpTimeOut`

    A user-specified timeout. The resource DLL waits for the dump file to be completed before the resource DLL stops the SQL Server service.

- `SqlDumperDumpPath`

    The location where the Sqldumper.exe tool generates the dump file.

- `SqlDumperDumpFlags`

    Flags that Sqldumper.exe uses.

If you don't set any one of these properties, Sqldumper.exe can't generate the dump file. A warning message is logged in both the event log and the cluster log whenever the resource is brought online.

### Cluster configuration for SQLDumper on SQL Server 2012 and later versions

Use the `ALTER SERVER CONFIGURATION` (T-SQL) command to change these properties. For example:

```sql
ALTER SERVER CONFIGURATION SET FAILOVER CLUSTER PROPERTY SqlDumperDumpTimeOut = 0;
ALTER SERVER CONFIGURATION SET FAILOVER CLUSTER PROPERTY SqlDumperDumpPath = 'C:\temp\';
ALTER SERVER CONFIGURATION SET FAILOVER CLUSTER PROPERTY SqlDumperDumpFlags = 296;
```

You can also use PowerShell scripts. For example, for a named instance SQL2017AG:

```powershell
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpPath" -Value "C:\temp"
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpFlags" -Value 296
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpTimeOut" -Value 0
```

To verify the settings, run the following PowerShell command:

```powershell
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Get-ClusterParameter
```

### Cluster configuration for SQLDumper on SQL Server 2008/2008 R2 or Windows 2012 and earlier versions

To set the Sqldumper.exe utility properties for cluster failover by using the [cluster resource](/previous-versions/windows/it-pro/windows-server-2003/cc785087(v=ws.10)) command, follow these steps:

1. Select **Start** > **Run**, type _cmd_, and then select **OK**.
1. For each property, type the corresponding command at the command prompt, and then press **Enter**:
   - The `SqlDumperDumpFlags` property

     To set the `SqlDumperDumpFlags` property for a specific dump file, type the corresponding command at the command prompt, and then press **Enter**:

     - All thread full dump file
       - Default instance

           ```cmd
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x01100
           ```

       - Named instance

           ```cmd
           cluster resource "SQL Server (INSTANCE1)" /priv SqlDumperDumpFlags = 0x01100
           ```

     - All thread mini-dump file
       - Default instance

           ```cmd
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x0120
           ```

       - Named instance

           ```cmd
           cluster resource "SQL Server (INSTANCE1)" /priv SqlDumperDumpFlags = 0x0120
           ```

     - Filtered all thread dump file
       - Default instance

           ```cmd
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x8100
           ```

       - Named instance

           ```cmd
           cluster resource "SQL Server  (INSTANCE1)" /priv SqlDumperDumpFlags = 0x8100
           ```

   - The `SqlDumperDumpPath` property

     ```cmd
     cluster resource "SQL Server" /priv SqlDumperDumpPath = <DirectoryPath>
     ```

     > [!NOTE]
     > `<DirectoryPath>` is a placeholder for the directory where the dump file will be generated. Specify it within quotation marks (" ").

   - The `SqlDumperDumpTimeOut` property

     ```cmd
     cluster resource "SQL Server" /priv SqlDumperDumpTimeOut = <Timeout>
     ```

     > [!NOTE]
     > `<Timeout>` is a placeholder for the timeout in milliseconds (ms).

The time that the tool takes to generate a dump file of a SQL Server process depends on the computer configuration. For a computer with a large amount of memory, the time could be significant. To estimate the time required for the process, use the Sqldumper.exe tool to manually generate a dump file. The valid values for the `SqlDumperDumpTimeOut` property are from **10,000 ms** to **MAXDWORD**. `MAXDWORD` represents the highest value in the range of the DWORD data type (4294967295).

To verify that the settings are enabled, run the following command:

```cmd
cluster resource "SQL Server" /priv
```

### Remove Sqldumper.exe properties for cluster failover

To remove the Sqldumper.exe tool properties for cluster failover, follow these steps:

1. Select **Start** > **Run**, type _cmd_, and then select **OK**.
1. For a specific property, enter the corresponding command at the command prompt, and then press **Enter**:

   - The `SqlDumperDumpFlags` property

     - Default instance

        ```cmd
         cluster resource "SQL Server" /priv:SqlDumperDumpFlags /usedefault
        ```

     - Named instance

        ```cmd
         cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpFlags /usedefault
        ```

   - The `SqlDumperDumpPath` property

     - Default instance

        ```cmd
        cluster resource "SQL Server" /priv:SqlDumperDumpPath /usedefault
        ```

     - Named instance

        ```cmd
        cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpPath /usedefault
        ```

   - The `SqlDumperDumpTimeOut` property

     - Default instance

        ```cmd
        cluster resource "SQL Server" /priv:SqlDumperDumpTimeOut /usedefault
        ```

     - Named instance

        ```cmd
        cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpTimeOut /usedefault
        ```

## How to use DBCC STACKDUMP

The `DBCC STACKDUMP` command helps you create a memory dump in the LOG directory of your SQL Server instance installation. By default, the command creates a minidump with all threads. This minidump has a limited size and adequately reflects the state of the SQL Server process. Run the following command in a SQL Server client:

```sql
DBCC STACKDUMP
```

For extended functionality of `DBCC STACKDUMP` in SQL Server 2019, see [Extended DBCC STACKDUMP functionality introduced in SQL Server 2019](#extended-dbcc-stackdump-functionality-introduced-in-sql-server-2019).

To enable this method to create a filtered dump, turn on trace flag 2551 by using the following command:

```sql
DBCC TRACEON(2551, -1)
GO
DBCC STACKDUMP
```

To create a full dump, use the trace flag 2544.

After you get the dump file, disable the trace flag by using the command `DBCC TRACEOFF (<TraceNumber>, -1);` to avoid inadvertently upgrading all further SQL Server self-diagnostic minidumps to larger dumps. In the command, \<TraceNumber\> is the trace flag you previously enabled, such as 2551 or 2544. For example:

```sql
DBCC TRACEOFF(2551, -1)
```

If you're unsure which trace flag remains active, run the following command:

```sql
DBCC TRACESTATUS(-1)
```

An empty result set indicates that no trace flag is active. If 2551 is still active, you see:

| TraceFlag | Status | Global | Session |
| --- | --- | --- | --- |
| 2551 | 1 | 1 | 0 |

> [!NOTE]
> The `traceflag` enabled by `DBCC TRACEON` are reset (removed) after a service restart.

### Extended DBCC STACKDUMP functionality introduced in SQL Server 2019

Starting with SQL Server 2019 CU2, the `DBCC STACKDUMP` command supports generating mini, filtered, and full dumps. This command removes the need for trace flags. You can also use it to limit the text output in the text file that accompanies the memory dump. Limiting the text output might improve the performance of SQLDumper.exe when it generates a memory dump.

```syntaxsql
DBCC STACKDUMP WITH MINI_DUMP | FILTERED_DUMP | FULL_DUMP [, TEXT_DUMP = LIMITED | DETAILED]
```

The default option is `TEXT_DUMP = LIMITED`. To get detailed output in the *SQLDump000X.txt* file, use `TEXT_DUMP = DETAILED`.

To generate a filtered dump with limited output in the *.txt* file, run the following command:

```sql
DBCC STACKDUMP WITH FILTERED_DUMP , TEXT_DUMP = LIMITED
```

## How to use a PowerShell script to generate a dump file with SQLDumper

- Save the following code as a PS1 file, for example _SQLDumpHelper.ps1_:

    Code details

    ```powershell
    $isInt = $false
    $isIntValDcnt = $false
    $isIntValDelay = $false
    $SqlPidInt = 0
    $NumFoler = ""
    $OneThruFour = ""
    $SqlDumpTypeSelection = ""
    $SSASDumpTypeSelection = ""
    $SSISDumpTypeSelection = ""
    $SQLNumfolder = 0
    $SQLDumperDir = ""
    $OutputFolder = ""
    $DumpType = "0x0120"
    $ValidPid
    $SharedFolderFound = $false
    $YesNo = ""
    $ProductNumber = ""
    $ProductStr = ""

    Write-Host ""
    Write-Host "`******************************************************************"
    Write-Host "This script helps you generate one or more SQL Server memory dumps"
    Write-Host "It presents you with choices on:`
                -target SQL Server process (if more than one)
                -type of memory dump
                -count and time interval (if multiple memory dumps)
    You can interrupt this script using CTRL+C"
    Write-Host "***********************************************************************"

    # check for administrator rights
    # debugging tools like SQLDumper.exe require Admin privileges to generate a memory dump

    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        Write-Warning "Administrator rights are required to generate a memory dump!`nPlease re-run this script as an Administrator!"
        return
    }

    # what product would you like to generate a memory dump
    while ($true)
    {
        Write-Host "Which product would you like to generate a memory dump of?" -ForegroundColor Yellow
        Write-Host "1) SQL Server"
        Write-Host "2) SSAS (Analysis Services)"
        Write-Host "3) SSIS (Integration Services)"
        Write-Host "4) SSRS (Reporting Services)"
        Write-Host "5) SQL Server Agent"
        Write-Host ""
        $ProductNumber = Read-Host "Enter 1-5>"

        if ($ProductNumber -in 1,2,3,4,5)
        {
            break
        }
        Write-Host "`nPlease enter a valid number from list above!`n"
        Start-Sleep -Milliseconds 300
    }

    if ($ProductNumber -eq "1")
    {
        $SqlTaskList = Tasklist /SVC /FI "imagename eq sqlservr*" /FO CSV | ConvertFrom-Csv
        $ProductStr = "SQL Server"
    }
    elseif ($ProductNumber -eq "2")
    {
        $SqlTaskList = Tasklist /SVC /FI "imagename eq msmdsrv*" /FO CSV | ConvertFrom-Csv
        $ProductStr = "SSAS (Analysis Services)"
    }
    elseif ($ProductNumber -eq "3")
    {
        $SqlTaskList = Tasklist /SVC /FI "imagename eq msdtssrvr*" /FO CSV | ConvertFrom-Csv
        $ProductStr = "SSIS (Integration Services)"
    }
    elseif ($ProductNumber -eq "4")
    {
        $SqlTaskList = Tasklist /SVC /FI "imagename eq reportingservicesservice*" /FO CSV | ConvertFrom-Csv
        $ProductStr = "SSRS (Reporting Services)"
    }
    elseif ($ProductNumber -eq "5")
    {
        $SqlTaskList = Tasklist /SVC /FI "imagename eq sqlagent*" /FO CSV | ConvertFrom-Csv
        $ProductStr = "SQL Server Agent"
    }

    if ($SqlTaskList.Count -eq 0)
    {
        Write-Host "There are currently no running instances of $ProductStr. Exiting..." -ForegroundColor Green
        break
    }

    # if multiple SQL Server instances, get the user to input PID for desired SQL Server
    if ($SqlTaskList.Count -gt 1)
    {
        Write-Host "More than one $ProductStr instance found."

        $SqlTaskList | Select-Object PID, "Image name", Services | Out-Host

        # check input and make sure it is a valid integer
        while ($true)
        {
            Write-Host "Please enter the PID for the desired SQL service from list above" -ForegroundColor Yellow
            $SqlPidStr = Read-Host ">"

            if( $SqlPidStr -in $SqlTaskList.PID)
            {
                $SqlPidInt = [int]$SqlPidStr
                break
            }
        }

        Write-Host "Using PID=$SqlPidInt for generating a $ProductStr memory dump" -ForegroundColor Green
        Write-Host ""

    }
    else # if only one SQL Server/SSAS on the box, go here
    {
        $SqlTaskList | Select-Object PID, "Image name", Services | Out-Host
        $SqlPidInt = [convert]::ToInt32($SqlTaskList.PID)

        Write-Host "Using PID=", $SqlPidInt, " for generating a $ProductStr memory dump" -ForegroundColor Green
        Write-Host ""
    }

    # dump type

    if ($ProductNumber -eq "1")  # SQL Server memory dump
    {
        # ask what type of SQL Server memory dump
        while($true)
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Mini-dump with referenced memory " -NoNewLine; Write-Host "(Recommended)"
            Write-Host "3) Filtered dump " -NoNewline; Write-Host "(Not Recommended)" -ForegroundColor Red
            Write-Host "4) Full dump  " -NoNewline; Write-Host "(Do Not Use on Production systems!)" -ForegroundColor Red
            Write-Host ""
            $SqlDumpTypeSelection = Read-Host "Enter 1-4>"

            if ($SqlDumpTypeSelection -in 1,2,3,4)
            {
                break
            }
            Write-Host "`nPlease enter a valid type of memory dump!`n"
            Start-Sleep -Milliseconds 300
        }

        Write-Host ""

        switch ($SqlDumpTypeSelection)
        {
            "1" { $DumpType="0x0120"; break }
            "2" { $DumpType="0x0128"; break }
            "3" { $DumpType="0x8100"; break }
            "4" { $DumpType="0x01100"; break }
            default { "0x0120"; break }
        }
    }
    elseif ($ProductNumber -eq "2")  # SSAS dump
    {
        # ask what type of SSAS memory dump
        while($true)
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Full dump  " -NoNewline; Write-Host "(Do Not Use on Production systems!)" -ForegroundColor Red
            Write-Host ""
            $SSASDumpTypeSelection = Read-Host "Enter 1-2>"

            if ($SSASDumpTypeSelection -in 1,2)
            {
                break
            }
            Write-Host "`nPlease enter a valid type of memory dump!`n"
            Start-Sleep -Milliseconds 300
        }

        Write-Host ""

        switch ($SSASDumpTypeSelection)
        {
            "1" {$DumpType="0x0";break}
            "2" {$DumpType="0x34";break}
            default {"0x0120"; break}
        }
    }
    elseif ($ProductNumber -in 3,4,5)  # SSIS/SSRS/SQL Agent dump
    {
        # ask what type of SSIS memory dump
        while($true)
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Full dump"
            Write-Host ""
            $SSISDumpTypeSelection = Read-Host "Enter 1-2>"

            if ($SSISDumpTypeSelection -in 1,2)
            {
                break
            }
            Write-Host "`nPlease enter a valid type of memory dump!`n"
            Start-Sleep -Milliseconds 300
        }

        Write-Host ""

        switch ($SSISDumpTypeSelection)
        {
            "1" { $DumpType="0x0"; break }
            "2" { $DumpType="0x34"; break }
            default { "0x0120"; break }
        }
    }

    # Sqldumper.exe PID 0 0x0128 0 c:\temp
    # output folder
    while($OutputFolder -eq "" -or !(Test-Path -Path $OutputFolder))
    {
        Write-Host ""
        Write-Host "Where would your like the memory dump stored (output folder)?" -ForegroundColor Yellow
        $OutputFolder = Read-Host "Enter an output folder with no quotes (e.g. C:\MyTempFolder or C:\My Folder)"
        if ($OutputFolder -eq "" -or !(Test-Path -Path $OutputFolder))
        {
            Write-Host "'" $OutputFolder "' is not a valid folder. Please, enter a valid folder location" -ForegroundColor Yellow
        }
    }

    # strip the last character of the Output folder if it is a backslash "\". Else Sqldumper.exe will fail
    if ($OutputFolder.Substring($OutputFolder.Length-1) -eq "\")
    {
        $OutputFolder = $OutputFolder.Substring(0, $OutputFolder.Length-1)
        Write-Host "Stripped the last '\' from output folder name. Now folder name is  $OutputFolder"
    }

    # find the highest version of SQLDumper.exe on the machine
    $NumFolder = dir "C:\Program Files\Microsoft SQL Server\1*" | Select-Object @{name = "DirNameInt"; expression={[int]($_.Name)}}, Name, Mode | Where-Object Mode -Match "da*" | Sort-Object DirNameInt -Descending

    for( $j=0; $j -lt $NumFolder.Count; $j++)
    {
        $SQLNumfolder = $NumFolder.DirNameInt[$j]   # start with the highest value from sorted folder names - latest version of dumper
        $SQLDumperDir = "C:\Program Files\Microsoft SQL Server\" + $SQLNumfolder.ToString() + "\Shared\"
        $TestPathDumperDir = $SQLDumperDir + "sqldumper.exe"

        if (Test-Path -Path $SQLDumperDir)
        {
            break
        }
    }

    # build the SQLDumper.exe command e.g. (Sqldumper.exe 1096 0 0x0128 0 c:\temp\)

    $cmd = "$([char]34)"+$SQLDumperDir + "sqldumper.exe$([char]34)"
    $arglist = $SqlPidInt.ToString() + " 0 " +$DumpType +" 0 $([char]34)" + $OutputFolder + "$([char]34)"
    Write-Host "Command for dump generation: ", $cmd, $arglist -ForegroundColor Green

    # do-we-want-multiple-dumps section
    Write-Host ""
    Write-Host "This utility can generate multiple memory dumps, at a certain interval"
    Write-Host "Would you like to collect multiple memory dumps (2 or more)?" -ForegroundColor Yellow

    # validate Y/N input
    while ($true)
    {
        $YesNo = Read-Host "Enter Y or N>"

        if ($YesNo -in "y","n")
        {
            break
        }
        Write-Host "Not a valid 'Y' or 'N' response"
    }

    # get input on how many dumps and at what interval
    if ($YesNo -eq "y")
    {
        [int]$DumpCountInt=0
        while (1 -ge $DumpCountInt)
        {
            Write-Host "How many dumps would you like to generate for this $ProductStr ?" -ForegroundColor Yellow
            $DumpCountStr = Read-Host ">"

            if ([int]::TryParse($DumpCountStr, [ref]$DumpCountInt) -and $DumpCountInt -gt 1)
            {
                break
            }
            Write-Host "Please enter a number greater than one." -ForegroundColor Red
        }

        [int]$DelayIntervalInt=0
        while ($true)
        {
            Write-Host "How frequently (in seconds) would you like to generate the memory dumps?" -ForegroundColor Yellow
            $DelayIntervalStr = Read-Host ">"

            if ([int]::TryParse($DelayIntervalStr, [ref]$DelayIntervalInt) -and $DelayIntervalInt -gt 0)
            {
                break
            }
            Write-Host "Please enter a number greater than zero." -ForegroundColor Red
        }

        Write-Host "Generating $DumpCountInt memory dumps at a $DelayIntervalStr-second interval" -ForegroundColor Green

        # loop to generate multiple dumps
        $cntr = 0
        while ($true)
        {
            Start-Process -FilePath $cmd -Wait -Verb runAs -ArgumentList $arglist
            $cntr++

            Write-Host "Generated $cntr memory dump(s)." -ForegroundColor Green

            if ($cntr -ge $DumpCountInt)
            {
                break
            }
            Start-Sleep -S $DelayIntervalInt
        }

        # print what files exist in the output folder
        Write-Host ""
        Write-Host "Here are all the memory dumps in the output folder '$OutputFolder'" -ForegroundColor Green
        $MemoryDumps = $OutputFolder + "\SQLDmpr*"
        Get-ChildItem -Path $MemoryDumps

        Write-Host ""
        Write-Host "Process complete"
    }
    else # produce just a single dump
    {
        Start-Process -FilePath $cmd -Wait -Verb runAs -ArgumentList $arglist

        # print what files exist in the output folder
        Write-Host ""
        Write-Host "Here are all the memory dumps in the output folder '$OutputFolder'" -ForegroundColor Green
        $MemoryDumps = $OutputFolder + "\SQLDmpr*"
        Get-ChildItem -Path $MemoryDumps

        Write-Host ""
        Write-Host "Process complete"
    }

    Write-Host "For errors and completion status, review SQLDUMPER_ERRORLOG.log created by SQLDumper.exe in the output folder '$OutputFolder'.`nOr if SQLDumper.exe failed, look in the folder from which you are running this script."
    ```

- Run it from Command Prompt as administrator by using the following command:

    ```cmd
    Powershell.exe -File SQLDumpHelper.ps1
    ```

- Or run it from Windows PowerShell console and run as administrator by using the following command:

    ```powershell
    .\SQLDumpHelper.ps1
    ```

> [!NOTE]
> If you never ran PowerShell scripts on your system, you might receive the following error message:
>
> "File ...SQLDumpHelper.ps1 cannot be loaded because running scripts is disabled on this system."

To enable running the commands, follow these steps:

1. Start Windows PowerShell console by using the **Run as Administrator** option. Only members of the administrators group on the computer can change the execution policy.
1. Enable running unsigned scripts by running the following command:

    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```

    > [!NOTE]
    > This command enables running unsigned scripts that you create on your local computer and signed scripts from the internet.

## Related content

- [Windows Server Failover Clustering with SQL Server](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server)
- [Troubleshoot entire SQL Server or database application that appears to be slow](/troubleshoot/sql/database-engine/performance/troubleshoot-entire-sqlserver-slow)
- [Non-yielding scheduler error in large memory server if the lock pages in memory option is disabled](/troubleshoot/sql/database-engine/performance/non-yielding-error-lock-pages-disable)
