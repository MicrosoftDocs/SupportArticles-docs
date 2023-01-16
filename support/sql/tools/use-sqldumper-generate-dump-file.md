---
title: Use Sqldumper.exe to generate dump files
description: This article introduces the Sqldumper.exe utility included with SQL Server. This utility generates different kinds of dump files.
ms.date: 09/21/2020
ms.custom: sap:Other tools
ms.reviewer: sureshka, jopilov
ms.topic: how-to
ms.prod: sql
---
# Use the Sqldumper.exe utility to generate a dump file in SQL Server

This article provides general guidelines for the Sqldumper.exe utility that is included with SQL Server. This utility is used to generate different kinds of dump files.

_Original product version:_ &nbsp; SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 917825

## Summary

The Sqldumper.exe utility is included with Microsoft SQL Server. It generates memory dumps of SQL Server and of related processes for debugging purposes. This article describes how to use the Sqldumper.exe utility to generate a dump file for Watson error reporting or for debugging tasks.

The article also describes two other methods to generate dump files:

- The attached [PowerShell script](#how-to-use-a-powershell-script-to-generate-a-dump-file-with-sqldumper) automates SQLDumper.exe command line options.
- [DBCC STACKDUMP](#how-to-use-dbcc-stackdump) Transact-SQL (T-SQL) command can be used to generate a dump file in SQL Server.

## How to run the Sqldumper.exe utility manually

Run the Sqldumper.exe utility under the context of the folder where SQL Server originally installed the utility. By default, the installation path of the Sqldumper.exe utility is as follows:

`<SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\90\Shared\SQLDumper.exe`

> [!NOTE]
> \<SQLServerInstall Drive\> is a placeholder for the drive where you installed SQL Server 2005.

To generate a dump file by using the Sqldumper.exe utility, follow these steps:

1. Open the following folder:

    `<SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\<number>\Shared`

    > [!NOTE]
    > In this folder path, \<number\> is a placeholder for one of the following:
    >
    > - 150 for SQL Server 2019
    > - 140 for SQL Server 2017
    > - 130 for SQL Server 2016
    > - 120 for SQL Server 2014
    > - 110 for SQL Server 2012
    > - 100 for SQL Server 2008
    > - 90 for SQL Server 2005

2. Make sure that the _Dbghelp.dll_ file is in this folder.
3. Select **Start** > **Run**, type _cmd_, and then select **OK**.
4. At the command prompt, type the following command, and then press **Enter**:

    ```dos
    cd <SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\<number>\Shared
    ```

    > [!NOTE]
    > In this folder path, \<number\> is the same placeholder changing with SQL Server version as described earlier.

5. To generate a specific kind of dump file, type the corresponding command at the command prompt, and then press **Enter**:
   - Full dump file

        ```dos
        Sqldumper.exe <ProcessID> 0 0x01100
        ```

   - Mini-dump file

        ```dos
        Sqldumper.exe <ProcessID> 0 0x0120
        ```

   - Mini-dump file that includes indirectly referenced memory. This is the recommended option and is also used by SQL Server by default when auto-generating memory dumps

       ```dos
       Sqldumper.exe <ProcessID> 0 0x0128
       ```

   - Filtered dump file

        ```dos
        Sqldumper.exe <ProcessID> 0 0x8100
        ```

    > [!NOTE]
    > \<ProcessID\> is a placeholder for the process identifier of the Windows application for which you want to generate a dump file.

If the Sqldumper.exe utility runs successfully, the utility generates a dump file in the folder where the utility is installed.

The dump file that the Sqldumper.exe utility generates has a file name pattern that resembles the following:  
*SQLDmpr\<xxxx\>.mdmp*
  
In this pattern, \<xxxx\> is an increasing number that is determined based on other files that have a similar file name in the same folder. If you already have files in the folder that have file names in the specified pattern, you may have to compare the date and the time that the file was created to identify the file that you want.

#### How to obtain a Microsoft Windows application process identifier

To generate a dump file by using the Sqldumper.exe utility, you must have the process identifier of the Windows application you want to generate a dump file for. Here's how to obtain the process identifier:

1. Press **Ctrl+Alt+Delete**, and select **Task Manager**.
2. In the **Windows Task Manager** dialog box, select the **Processes** tab.
3. On the **View** menu, select **Select Columns**.
4. In the **Select Columns** dialog box, select the **PID (Process Identifier)** check box, and select **OK**.
5. Take note of the process identifier of the Windows application you want to generate a dump file for. For the SQL Server application, take note of the process identifier of the _Sqlservr.exe_ process.
6. Close the **Task Manager**.

Alternatively, use the SQL Server error log file to obtain the process identifier of the SQL Server application running on your computer. A part of the SQL Server error log file resembles this:

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

The number that appears after `Server process ID` is the process identifier for the Sqlservr.exe process.

## Output path for memory dumps

SQLDumper.exe exists primarily to generate memory dumps for the SQL Server process in scenarios where a memory dump is needed to resolve specific problems (exceptions, asserts, non-yielding schedulers, etc.). In such cases, SQL Server invokes the SQLDumper.exe to generate a memory dump of its process. The memory dump is stored in the SQL instance *MSSQL\LOG\\* directory by default.

### How to change the default path

If in some cases the dump size is too large, for example, you can modify the path by doing the following:

1. Open **SQL Server Configuration Manager**.  
2. Under **SQL Server Services**, locate the SQL Server under investigation.
3. Right-click it, select **Properties** and go to the **Advanced** tab.
4. Modify that Dump Directory to the desired path and select **OK**.
5. Restart SQL Server (when possible) for the new setting to take effect.

When the Sqldumper.exe utility is used manually to generate a dump file for any Windows application, the dump file may be as large as the memory that the Windows application is currently using. Make sure that sufficient disk space is available on the drive to which the Sqldumper.exe utility is writing the dump file.

### Specify a custom output folder in command

You can specify the directory where you want the Sqldumper.exe utility to write the dump file. The directory must already exist before you run the Sqldumper.exe utility. Otherwise, the Sqldumper.exe utility will fail. Don't use a UNC path as a location for the dump file. The following is an example of how to specify the dump file location of the mini-dump file:

1. Select **Start** > **Run**, type _cmd_, and then select **OK**.
2. At the command prompt, type the following command, and then press **Enter**:

    ```dos
    cd <SQLServerInstall Drive>:\Program Files\Microsoft SQL Server\<number>\Shared
    ```

3. Type the following command at the command prompt, and then press **Enter**:

    ```dos
    Sqldumper.exe ProcessID 0 0x0128 0 <MdumpPath>
    ```

    > [!NOTE]
    > \<MdumpPath\> is a placeholder for the directory where you want the Sqldumper.exe utility to write the dump file. By default, the file is written to the current folder.

If you specify a full dump file or a filtered dump file to be generated, the Sqldumper.exe utility may take several minutes to generate the dump file. The time depends on the following variables:

- The amount of memory that the Sqldumper.exe utility is currently using.
- The speed of the drive to which the utility is writing the dump file.

During this time, the Sqldumper.exe utility won't process commands. You'll notice that the server has stopped responding. Additionally, a cluster failover may occur.

## Permission requirements

To run the Sqldumper.exe utility, you must sign in to Windows by using one of the following methods:

- Use an account that is a member of the administrator's group on the computer.
- Use the same user account under which the SQL Server service is running.

For the Sqldumper.exe utility to work successfully through Remote Desktop or through Terminal Services, you must start Remote Desktop or Terminal Services in console mode. For example, to start Remote Desktop in console mode, select **Start** > **Run**, type _mstsc /console_, and then select **OK**. If the target server runs Windows 2000, the **/console** option is silently ignored. You can connect to the server through Remote Desktop. But you won't be using the console session.

If you notice that no dump file has been generated in the current folder after you run the Sqldumper.exe utility, review the information that the utility has generated at the command line to try to determine the possible cause of the failure. This information is also logged in the _Sqldumper_errorlog.log_ file in current directory. The following are two possible error messages and their causes:

- Message 1

  > OpenProcess failed 0x57 - The parameter is incorrect

    An invalid Process ID was passed to the Sqldumper.exe utility.

- Message 2

    > Invalid value for thread id - \<invalid parameter\> Parameter error

    An invalid parameter was passed to the Sqldumper.exe utility.

If an error message that resembles one of the following is generated, you can safely ignore this message:

>Unknown callback type during minidump 6  
Unknown callback type during minidump 7

## Impact of dump generation

When a dump of a user-mode process is requested (as is discussed in this article, to be contrasted with Operating System Kernel Dumps, which are outside our scope), the target Process (here SQLServer.exe) is frozen for the duration it takes to serialize the dump content to its file target.

Frozen means that the process won't be able to execute any user request or any internal operation, including any Resource Polling mechanism like the implementation of Windows Clustering's IsAlive and Looks Alive (see the [Memory dumps on Cluster failovers section](#generate-a-memory-dump-on-cluster-failovers) for details on handling that situation). Any time-out relying on wall clock time may also be breached as a consequence of the freeze.

As can be derived from the previous statement, the duration of the freeze is therefore the critical factor here, and it's driven by the following:

- The **type of dump** selected.
- The **size of SQL Server process in memory**, which in the case of a single active instance running default parameters is often close to the **total physical RAM of the server**.
- The performance of the disk used as a target for the dump.

Furthermore, the **size of the dump file** on disk should be planned for, especially if multiple dumps are a possibility and if large, non-default dump types are selected. Make sure you review the [Dump types](#dump-types) to know what to expect. By default, some dump methods will create the dump in SQL Server Instance's _\Log_ folder, which, in default simple configuration would also be system disk and data+log disk for SQL Server. Bringing that disk to saturation will have severe impact on SQL Server and/or system availability.

## Manage the impact on clustered systems

The process is suspended temporarily during the dump generation. This might affect the SQL Server service availability and trigger resources failover in Always On contexts (both Failover cluster instance and Availability group). The dump generation of different processes impacts resources differently. Read the [Impact of dump generation](#impact-of-dump-generation) and [Dump types](#dump-types) sections carefully.

When capturing a SQL Server process dump file (especially a filtered dump file or a full dump file) on a clustered SQL Server or a SQL Server hosting an Always On availability group (AG) instance, the clustered SQL Server or AG might fail over to another node if the dump file takes too long to be completed. To prevent failover, use the following settings before capturing the dump file. The change can be reverted after a dump file is taken:

- For failover clustered instance (FCI):
  - Right-click SQL Server resource in **Cluster Administrator**, select **If resource fails, do not restart** on the **Policies** tab.
  - On the **Properties** tab, increase the **HealthCheck Timeout**. For example, set the property value to 180 seconds or higher. If this timeout is reached, the policy **If resource fails, do not restart** will be ignored and the resource will be restarted anyway.
  - Also on the **Properties** tab, change the **FailureConditionLevel** value to zero.
- For AG, apply all the following settings:
  - Increase session-timeout, for example, 120 seconds for all replicas. In SQL Server Management Studio (SSMS), right-click the replica to be configured, and then select **Properties**. Change the **Session timeout (seconds)** field to _120_ seconds. For more information, see [Change the Session-Timeout Period for an Availability Replica (SQL Server)](/sql/database-engine/availability-groups/windows/change-the-session-timeout-period-for-an-availability-replica-sql-server).
  - Change the auto failover of all replicas to manual failover. In SSMS, right-click replica, select **Properties** and change the **auto failover** of all replicas to manual failover on the **Properties** tab. For more information, see [Change the Failover Mode of an Availability Replica (SQL Server)](/sql/database-engine/availability-groups/windows/change-the-failover-mode-of-an-availability-replica-sql-server).
  - Increase the **LeaseTimeout** to _60,000_ ms (60 seconds) and change **HealthCheckTimeout** to _90,000_ ms (90 seconds). In **Cluster Administrator**, right-click AG resource, select **Properties**, and then switch to the **Properties** tab to modify both settings. For more information, see [Configure HealthCheckTimeout Property Settings](/sql/sql-server/failover-clusters/windows/configure-healthchecktimeout-property-settings).

## Product improvements to reduce the impact on SQL Server

Three major improvements have been added to recent versions of SQL Server to reduce the size of the dump file and/or time for generating the memory dump:

- Bitmap filtering mechanism.

- Elimination of repeated dumps on the same issue.

- Shortened output in the error log.

**Bitmap filtering mechanism:** SQL Server allocates a bitmap that keeps track of memory pages to be excluded from a filtered dump. Sqldumper.exe reads the bitmap and filters out pages without the need to read any other memory manager metadata. You'll see the following messages in the SQL Server error log when the bitmap is enabled or disabled respectively:

`Page exclusion bitmap is enabled.` and `Page exclusion bitmap is disabled.`

- SQL Server 2016

    Starting with SQL Server 2016 SP2 CU13 the bitmap filtering is enabled by default.

- SQL Server 2017

  - This isn't available in RTM through CU15.
  - In SQL Server 2017 CU16, you can enable the bitmap filtering via T8089 and disable it by turning off T8089.
  - Starting with SQL Server 2017 CU20 the bitmap filtering is enabled by default. Trace flag T8089 will no longer apply and will be ignored if turned on. The bitmap filtering can be disabled via T8095.

- SQL Server 2019

    This is enabled by default in SQL Server 2019 RTM. It can be disabled via T8095.

**Elimination of repeated dumps on the same issue:**  Repeated memory dumps on the same problem are eliminated. Using a stack signature, the SQL engine keeps track if an exception has already occurred and won't produce a new memory dump if there's one already. This applies to access violations, stack overflow, asserts, and index corruption exceptions. This significantly reduces the amount of disk space used by memory dumps and doesn't freeze the process temporarily to generate a dump. This was added in SQL Server 2019.

**Shortened output in the Error log:** The content generated in the SQL Server Error log from a single memory dump can't only be overwhelming, but it also slowed down the process of generating a memory dump due to the time all this information had to be serialized into a text format in the Error log. In SQL Server 2019, the content stored in the Error log upon dump generation has been greatly reduced and it may look like this:

```console
DateTimespidS pid    **Dump thread - spid = 0, EC = 0x0000015C7169BF40
DateTimespidS pid    *
DateTimespidS pid    *User initiated stack dump. This is not a server exception dump.
DateTimespidS pid    *
DateTimespidS pid    Stack Signature for the dump is 0x00000000788399E5
DateTimespidS pid    External dump process return code 0x20000001.
External dump process returned no errors.
```

Previously SQL Server would print information for each session/thread when a manual dump was triggered by the user for example.

## Factors that prevent or delay creation of memory dumps

Based on Microsoft CSS support experience, a few factors are known to cause delays or prevent the creation of memory dumps.

- The IO path where memory dumps are written performs poorly. In such cases, to investigate and resolve disk I/O performance is the next logical step.
- An anti-virus or other monitoring software is interfering with SQLDumper.exe. In some cases, third party software detour [ReadProcessMemory](/windows/win32/api/memoryapi/nf-memoryapi-readprocessmemory) function. This can dramatically increase the dump duration. To resolve most of these issues, disable the interfering software or add SQLDumper.exe to an exclusion list.

## Dump types

The methods described are able to generate three different types of dumps: [mini dumps](#mini-dumps-with-referenced-memory), [full dumps](#full-dumps), and [filtered dumps](#filtered-dumps).

#### Mini dumps with referenced memory

This type of memory dump is a snapshot of all active threads of the process ("thread stacks"), along with a limited extract of the memory referenced by the thread stacks and some other key process/thread data. They're typically a few megabytes in size, and are fast to generate (from less than a second to a couple of seconds). Even larger server systems (with hundreds of CPU indirectly driving massive number of threads in SQL Server process) will rarely exceed 20-30 MB: the size of a mini dump doesn't grow with the size of SQL Server process. This dump type is the default type used by SQL Server when generating memory dumps automatically on exceptions, scheduler issues, latch issues, etc.

> [!NOTE]
> SQL Server, as part of its built-in instrumentation, will generate automated "diagnostic mini dumps" in some specific situations. This operation is therefore considered safe enough that SQL Server can trigger it automatically when needed.

#### Full dumps

A Full memory dump is a complete copy of the active target process space. That would therefore include all thread state, all process allocated memory, and all loaded modules. Full dumps will therefore have a size, which is roughly the same of SQL Server process, which in turn may be **almost as large as total system RAM**. On large servers dedicated to a single SQL Server instance, that might mean a file, which is several hundreds of gigabytes or more. Needlessly to say, such a file will take a long time to generate and will therefore induce prolongated freeze. Disk performance for file target of dump will be a major driver to freeze time. This kind of dump is rarely used for SQL Server today**, as next type description will explain.

#### Filtered dumps

As the RAM size of typical servers running SQL Server steadily increases, full dumps become more unwieldy. Filtered dumps are therefore implemented. A filtered dump is a subset of a full dump, where large areas of SQL Server memory are excluded on the fly and not written to disk. Typically the excluded memory brings no added value to troubleshooting. Examples are data/index pages and some internal caches like Hekaton data pages and Log Pool memory. This filtered dump results in a smaller file than a full dump does, but the dump still retains almost all its usefulness. **Filtered dumps have replaced full dumps as the preferred option in a vast majority of situations where mini dumps are not sufficient**. The decrease in size can vary compared to a full dump, but it's still a rather large file, which is often 30-60 % of SQL Server process size. Therefore, it's best to plan for a possible size as large as a full dump as a worst option, which leaves a good safety margin. A filtered dump may not be necessarily faster to generate than a full dump in every case: it's a matter of whether the gains related to the number of avoided IO exceed the time required to implement the filter logic (disk speed and CPU/RAM speed will influence that).

You can use the following query to get a rough estimate of the filtered dump size. Though the expectation is that most data/index pages are excluded from the dump, the ones that are exclusively latched and being modified won't be left out.

```sql
SELECT SUM(pages_kb) 
FROM sys.dm_os_memory_clerks
WHERE type != 'MEMORYCLERK_SQLBUFFERPOOL'
```

Since you can employ the Sqldumper.exe utility to generate a dump file on demand for any Microsoft Windows application, you may consider using the filtered dump option. However, a filtered dump file is only applicable and meaningful in the context of SQL Server. You can still generate a mini-dump  a full dump file or non-SQL Server applications successfully.

The SQL Server process calls the Sqldumper.exe utility internally to generate a dump file when the process experiences any exceptions. SQL Server passes parameters to the Sqldumper.exe utility. You can use trace flags to change the parameters that SQL Server passes to the utility by default when an exception or assertion occurs. These trace flags are in the range from 2540 to 2559. You can use one of these trace flags to change the default dump type SQLDumper.exe generate (the default is a mini-dump with referenced memory). For example:

- Trace Flag 2551: Produces a filtered memory dump.
- Trace Flag 2544: Produces a full memory dump.
- Trace Flag 8026: SQL Server will clear a dump trigger after generating the dump once.

If two or more trace flags are active, the option indicating the largest memory dump will be honored. For example, if trace flags 2551 and 2544 are used, SQL Server will create a full memory dump.

## Generate a memory dump on Cluster failovers

In cluster failover scenarios, the SQL Server resource DLL can obtain a dump file before the failover occurs to assist with troubleshooting. When the SQL Server resource DLL determines that a SQL Server resource has failed, the SQL Server resource DLL uses the Sqldumper.exe utility to obtain a dump file of the SQL Server process. To make sure that the Sqldumper.exe utility successfully generates the dump file, you must set the following three properties as prerequisites:

- SqlDumperDumpTimeOut
    A user-specified time-out. The resource DLL waits for the dump file to be completed before the resource DLL stops the SQL Server service.
- SqlDumperDumpPath  
    The location where the Sqldumper.exe utility generates the dump file.
- SqlDumperDumpFlags  
    Flags that the Sqldumper.exe utility uses.

If any one of the properties isn't set, the Sqldumper.exe utility can't generate the dump file. A warning message will be logged both in the event log and in the cluster log whenever the resource is brought online.

#### Cluster configuration for SQLDumper on SQL Server 2012 and later versions

You can use the `ALTER SERVER CONFIGURATION` (T-SQL) command to modify these properties. For example:

```sql
ALTER SERVER CONFIGURATION   set FAILOVER CLUSTER PROPERTY SqlDumperDumpTimeOut =0;
ALTER SERVER CONFIGURATION   set FAILOVER CLUSTER PROPERTY SqlDumperDumpPath ='C:\temp\';
ALTER SERVER CONFIGURATION   set FAILOVER CLUSTER PROPERTY SqlDumperDumpFlags =296;
```

Alternatively, you can use PowerShell scripts. For example, for a named instance SQL2017AG:

```powershell
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpPath" -Value "C:\temp"
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpFlags" -Value 296
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Set-ClusterParameter -Name "SqlDumperDumpTimeOut" -Value 0
```

To validate the settings have been applied, you can run this PowerShell command:

```powershell
Get-ClusterResource -Name "SQL Server (SQL2017AG)" | Get-ClusterParameter
```

#### Cluster configuration for SQLDumper on SQL Server 2008/2008 R2 or Windows 2012 and earlier versions

To set the Sqldumper.exe utility properties for cluster failover, follow these steps:

1. Select **Start** > **Run**, type _cmd_, and then select **OK**.
2. For each property, type the corresponding command at the command prompt, and then press **Enter**:
   - The `SqlDumperDumpFlags` property
To set the `SqlDumperDumpFlags` property for a specific kind of dump file, type the corresponding command at the command prompt, and then press **Enter**:
     - All thread full dump file
       - Default instance

           ```dos
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x01100
           ```

       - Named instance

           ```dos
           cluster resource "SQL Server (INSTANCE1)" /priv SqlDumperDumpFlags = 0x01100
           ```

     - All thread mini-dump file
       - Default instance

           ```dos
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x0120
           ```

       - Named instance

           ```dos
           cluster resource "SQL Server (INSTANCE1)" /priv SqlDumperDumpFlags = 0x0120
           ```

     - Filtered all thread dump file
       - Default instance

           ```dos
           cluster resource "SQL Server" /priv SqlDumperDumpFlags = 0x8100
           ```

       - Named instance

           ```dos
           cluster resource "SQL Server  (INSTANCE1)" /priv SqlDumperDumpFlags = 0x8100
           ```

   - The `SqlDumperDumpPath` property

     ```dos
     cluster resource "SQL Server" /priv SqlDumperDumpPath= DirectoryPath     
     ```

     > [!NOTE]
     > `DirectoryPath` is a placeholder for the directory in which the dump file will be generated, and it should be specified in quotation marks (" ").

   - The `SqlDumperDumpTimeOut` property

     ```dos
     cluster resource "SQL Server" /priv SqlDumperDumpTimeOut = <Timeout>  
     ```

     > [!NOTE]
     > \<Timeout\> is a placeholder for the time-out in milliseconds (ms).

The time that the utility takes to generate a dump file of a SQL Server process depends on the computer configuration. For a computer that has lots of memories, the time could be significant. To obtain an estimate of the time that the process takes, use the Sqldumper.exe utility to manually generate a dump file. The valid values for the `SqlDumperDumpTimeOut` property are from **10,000 ms** to **MAXDWORD.MAXDWORD** represents the highest value in the range of the DWORD data type (4294967295).

To verify that the settings have been enabled, you can run the following command:

```dos
cluster resource "SQL Server" /priv "
```

#### Remove Sqldumper.exe properties for cluster failover

To remove the Sqldumper.exe utility properties for cluster failover, follow these steps:

1. Select **Start** > **Run**, type _cmd_, and then select **OK**.
2. For a specific property, type the corresponding command at the command prompt, and then press **Enter**:
   - The `SqlDumperDumpFlags` property
     - Default instance

        ```dos
         cluster resource "SQL Server" /priv:SqlDumperDumpFlags /usedefault
        ```

     - Named instance

        ```dos
         cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpFlags /usedefault
        ```

   - The `SqlDumperDumpPath` property
     - Default instance  

        ```dos
        cluster resource "SQL Server" /priv:SqlDumperDumpPath /usedefault
        ```

     - Named instance  

        ```dos
        cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpPath /usedefault
        ```

   - The `SqlDumperDumpTimeOut` property
     - Default instance  

        ```dos
        cluster resource "SQL Server" /priv:SqlDumperDumpTimeOut /usedefault
        ```

     - Named instance

        ```dos
        cluster resource "SQL Server (INSTANCE1)" /priv:SqlDumperDumpTimeOut /usedefault
        ```

## How to use DBCC STACKDUMP

The `DBCC STACKDUMP` command can help you create a memory dump in the LOG directory of your SQL Server instance installation. The command will by default create a minidump with all threads, which has limited size and is adequate to reflect the state of SQL Server process. Execute the following command in a SQL Server client:

```SQL
 DBCC STACKDUMP
```

For extended functionality of `DBCC STACKDUMP` in SQL Server 2019, see [Extended DBCC STACKDUMP functionality introduced in SQL Server 2019](#extended-dbcc-stackdump-functionality-introduced-in-sql-server-2019).

To enable this method to create a filtered dump, turn on trace flags 2551 with following command:

```SQL
dbcc traceon(2551, -1)
go
dbcc stackdump
```

To create a full dump, use trace flag 2544.

> [!NOTE]
> After you get the dump file, you should disable the trace flag by using the following command to avoid inadvertently upgrading all further SQL Server self-diagnostic minidumps to larger dumps:

```SQL
DBCC TRACEOFF (TraceNumber, -1);
```

Where `TraceNumber` is the trace flag you have previously enabled like 2551 or 2544.

In case you're unsure of which trace flag remains active, you can execute:

```SQL
 DBCC TRACESTATUS(-1)
```

An empty result set indicates no trace flag is active. Conversely, if 2551 is still active you would see:

|TraceFlag|Status| Global| Session|
|---|---|---|---|
|2551|      1|      1|      0|
  
> [!NOTE]
> The `traceflag` enabled by `DBCC TRACEON` are reset (removed) after a service restart.

#### Extended DBCC STACKDUMP functionality introduced in SQL Server 2019

Starting with SQL Server 2019 CU2, the `DBCC STACKDUMP` command was extended to support generating dumps of different types: mini, filtered, full dumps. This command eliminates the need for using trace flags. It also allows you to limit the text output in the other text file that gets generated with the memory dump. Doing so may provide visible performance gain in the time it takes SQLDumper.exe to generate a memory dump.

```syntaxsql
DBCC STACKDUMP WITH MINI_DUMP | FILTERED_DUMP | FULL_DUMP [, TEXT_DUMP = LIMITED | DETAILED]
```

The `TEXT_DUMP = LIMITED` is the default option. If you would like to receive detailed output in the SQLDump000X.txt file, you can use `TEXT_DUMP = DETAILED`.

To generate a filtered dump with limited output in the .txt file, you can execute the following command:

```sql
DBCC STACKDUMP WITH FILTERED_DUMP , TEXT_DUMP = LIMITED 
```

## How to use a PowerShell script to generate a dump file with SQLDumper

- Save the following code as a ps1 file, for example _SQLDumpHelper.ps1_:

    Code details

    ```powershell
    $isInt = $false
    $isIntValDcnt = $false
    $isIntValDelay = $false
    $SqlPidInt = 0
    $NumFoler =""
    $OneThruFour = "" 
    $SqlDumpTypeSelection = ""
    $SSASDumpTypeSelection = ""
    $SSISDumpTypeSelection = ""
    $SQLNumfolder=0
    $SQLDumperDir=""
    $OutputFolder=""
    $DumpType ="0x0120"
    $ValidPid
    $SharedFolderFound=$false
    $YesNo =""
    $ProductNumber=""
    $ProductStr = ""
    
    Write-Host ""
    Write-Host "`**********************************************************************"
    Write-Host "This script helps you generate one or more SQL Server memory dumps"
    Write-Host "It presents you with choices on:`
                -target SQL Server process (if more than one)
                -type of memory dump
                -count and time interval (if multiple memory dumps)
    You can interrupt this script using CTRL+C"
    Write-Host "***********************************************************************"
    
    #check for administrator rights
    #debugging tools like SQLDumper.exe require Admin privileges to generate a memory dump
    
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
         Write-Warning "Administrator rights are required to generate a memory dump!`nPlease re-run this script as an Administrator!"
         #break
    }
    
    #what product would you like to generate a memory dump
    while(($ProductNumber -ne "1") -and ($ProductNumber -ne "2") -and ($ProductNumber -ne "3") -and ($ProductNumber -ne "4") -and ($ProductNumber -ne "5"))
    {
        Write-Host "Which product would you like to generate a memory dump of?" -ForegroundColor Yellow
        Write-Host "1) SQL Server"
        Write-Host "2) SSAS (Analysis Services)"
        Write-Host "3) SSIS (Integration Services)"
        Write-Host "4) SSRS (Reporting Services)"
        Write-Host "5) SQL Server Agent"
        Write-Host ""
        $ProductNumber = Read-Host "Enter 1-5>"
    
        if (($ProductNumber -ne "1") -and ($ProductNumber -ne "2") -and ($ProductNumber -ne "3") -and ($ProductNumber -ne "4")-and ($ProductNumber -ne "5"))
        {
            Write-Host ""
            Write-Host "Please enter a valid number from list above!"
            Write-Host ""
            Start-Sleep -Milliseconds 300
        }
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
        Write-Host "There are curerntly no running instances of $ProductStr. Exiting..." -ForegroundColor Green
        break
    }
    
    #if multiple SQL Server instances, get the user to input PID for desired SQL Server
    if ($SqlTaskList.Count -gt 1) 
    {
        Write-Host "More than one $ProductStr instance found." 
    
        $SqlTaskList | Select-Object  PID, "Image name", Services |Out-Host 
    
        #check input and make sure it is a valid integer
        while(($isInt -eq $false) -or ($ValidPid -eq $false))
        {
            Write-Host "Please enter the PID for the desired SQL service from list above" -ForegroundColor Yellow
            $SqlPidStr = Read-Host ">" 
        
            try{
                    $SqlPidInt = [convert]::ToInt32($SqlPidStr)
                    $isInt = $true
                }
    
            catch [FormatException]
                {
                     Write-Host "The value entered for PID '",$SqlPidStr,"' is not an integer"
                }
        
            #validate this PID is in the list discovered 
            for($i=0;$i -lt $SqlTaskList.Count;$i++)
            {
                if($SqlPidInt -eq [int]$SqlTaskList.PID[$i])
                {
                    $ValidPid = $true
                    break;
                }
                else
                {
                    $ValidPid = $false
                }
            }
         }   
    
     
        Write-Host "Using PID=$SqlPidInt for generating a $ProductStr memory dump" -ForegroundColor Green
        Write-Host ""
        
    }
    else #if only one SQL Server/SSAS on the box, go here
    {
        $SqlTaskList | Select-Object PID, "Image name", Services |Out-Host
        $SqlPidInt = [convert]::ToInt32($SqlTaskList.PID)
     
        Write-Host "Using PID=", $SqlPidInt, " for generating a $ProductStr memory dump" -ForegroundColor Green
        Write-Host ""
    }
    
    #dump type
    
    if ($ProductNumber -eq "1")  #SQL Server memory dump
    {
        #ask what type of SQL Server memory dump 
        while(($SqlDumpTypeSelection  -ne "1") -and ($SqlDumpTypeSelection -ne "2") -And ($SqlDumpTypeSelection -ne "3") -And ($SqlDumpTypeSelection -ne "4" ))
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Mini-dump with referenced memory " -NoNewLine; Write-Host "(Recommended)" 
            Write-Host "3) Filtered dump " -NoNewline; Write-Host "(Not Recommended)" -ForegroundColor Red
            Write-Host "4) Full dump  " -NoNewline; Write-Host "(Do Not Use on Production systems!)" -ForegroundColor Red
            Write-Host ""
            $SqlDumpTypeSelection = Read-Host "Enter 1-4>"
    
            if (($SqlDumpTypeSelection -ne "1") -and ($SqlDumpTypeSelection -ne "2") -And ($SqlDumpTypeSelection -ne "3") -And ($SqlDumpTypeSelection -ne "4" ))
            {
                Write-Host ""
                Write-Host "Please enter a valid type of memory dump!"
                Write-Host ""
                Start-Sleep -Milliseconds 300
            }
        }
    
        Write-Host ""
    
        switch ($SqlDumpTypeSelection)
        {
            "1" {$DumpType="0x0120";break}
            "2" {$DumpType="0x0128";break}
            "3" {$DumpType="0x8100";break}
            "4" {$DumpType="0x01100";break}
            default {"0x0120"; break}
        }
    }
    elseif ($ProductNumber -eq "2")  #SSAS dump 
    {
    
        #ask what type of SSAS memory dump 
        while(($SSASDumpTypeSelection  -ne "1") -and ($SSASDumpTypeSelection -ne "2"))
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Full dump  " -NoNewline; Write-Host "(Do Not Use on Production systems!)" -ForegroundColor Red
            Write-Host ""
            $SSASDumpTypeSelection = Read-Host "Enter 1-2>"
    
            if (($SSASDumpTypeSelection -ne "1") -and ($SSASDumpTypeSelection -ne "2"))
            {
                Write-Host ""
                Write-Host "Please enter a valid type of memory dump!"
                Write-Host ""
                Start-Sleep -Milliseconds 300
            }
        }
    
        Write-Host ""
    
        switch ($SSASDumpTypeSelection)
        {
            "1" {$DumpType="0x0";break}
            "2" {$DumpType="0x34";break}
            default {"0x0120"; break}
        }
    }
    
    elseif ($ProductNumber -eq "3" -or $ProductNumber -eq "4" -or $ProductNumber -eq "5")  #SSIS/SSRS/SQL Agent dump
    {
        #ask what type of SSIS memory dump 
        while(($SSISDumpTypeSelection   -ne "1") -and ($SSISDumpTypeSelection  -ne "2"))
        {
            Write-Host "Which type of memory dump would you like to generate?" -ForegroundColor Yellow
            Write-Host "1) Mini-dump"
            Write-Host "2) Full dump" 
            Write-Host ""
            $SSISDumpTypeSelection = Read-Host "Enter 1-2>"
    
            if (($SSISDumpTypeSelection  -ne "1") -and ($SSISDumpTypeSelection  -ne "2"))
            {
                Write-Host ""
                Write-Host "Please enter a valid type of memory dump!"
                Write-Host ""
                Start-Sleep -Milliseconds 300
            }
        }
    
        Write-Host ""
    
        switch ($SSISDumpTypeSelection)
        {
            "1" {$DumpType="0x0";break}
            "2" {$DumpType="0x34";break}
            default {"0x0120"; break}
        }
    }
    
    # Sqldumper.exe PID 0 0x0128 0 c:\temp
    #output folder
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
    
    #strip the last character of the Output folder if it is a backslash "\". Else Sqldumper.exe will fail
    if ($OutputFolder.Substring($OutputFolder.Length-1) -eq "\")
    {
        $OutputFolder = $OutputFolder.Substring(0, $OutputFolder.Length-1)
        Write-Host "Stripped the last '\' from output folder name. Now folder name is  $OutputFolder"
    }
    
    #find the highest version of SQLDumper.exe on the machine
    $NumFolder = dir "c:\Program Files\microsoft sql server\1*" | Select-Object @{name = "DirNameInt"; expression={[int]($_.Name)}}, Name, Mode | Where-Object Mode -Match "da*" | Sort-Object DirNameInt -Descending
    
    for($j=0;($j -lt $NumFolder.Count); $j++)
    {
        $SQLNumfolder = $NumFolder.DirNameInt[$j]   #start with the highest value from sorted folder names - latest version of dumper
        $SQLDumperDir = "c:\Program Files\microsoft sql server\"+$SQLNumfolder.ToString()+"\Shared\"
        $TestPathDumperDir = $SQLDumperDir+"sqldumper.exe" 
        
        $TestPathResult = Test-Path -Path $SQLDumperDir 
        
        if ($TestPathResult -eq $true)
        {
            break;
        }
     }
    
    #build the SQLDumper.exe command e.g. (Sqldumper.exe 1096 0 0x0128 0 c:\temp\)
    
    $cmd = "$([char]34)"+$SQLDumperDir + "sqldumper.exe$([char]34)"
    $arglist = $SqlPidInt.ToString() + " 0 " +$DumpType +" 0 $([char]34)" + $OutputFolder + "$([char]34)"
    Write-Host "Command for dump generation: ", $cmd, $arglist -ForegroundColor Green
    
    #do-we-want-multiple-dumps section
    Write-Host ""
    Write-Host "This utility can generate multiple memory dumps, at a certain interval"
    Write-Host "Would you like to collect multiple memory dumps (2 or more)?" -ForegroundColor Yellow
    
    #validate Y/N input
    while (($YesNo -ne "y") -and ($YesNo -ne "n"))
    {
        $YesNo = Read-Host "Enter Y or N>"
    
        if (($YesNo -eq "y") -or ($YesNo -eq "n") )
        {
            break
        }
        else
        {
            Write-Host "Not a valid 'Y' or 'N' response"
        }
    }
    
    #get input on how many dumps and at what interval
    if ($YesNo -eq "y")
    {
        [int]$DumpCountInt=0
        while(1 -ge $DumpCountInt)
            {
                Write-Host "How many dumps would you like to generate for this $ProductStr ?" -ForegroundColor Yellow
                $DumpCountStr = Read-Host ">"
        
                try{
                        $DumpCountInt = [convert]::ToInt32($DumpCountStr)
    
                        if(1 -ge $DumpCountInt)
                        {
                            Write-Host "Please enter a number greater than one." -ForegroundColor Red
                        }
                    }
    
                catch [FormatException]
                    {
                         Write-Host "The value entered for dump count '",$DumpCountStr,"' is not an integer" -ForegroundColor Red
                    }
            }
    
        [int]$DelayIntervalInt=0
        while(0 -ge $DelayIntervalInt)
            {
                Write-Host "How frequently (in seconds) would you like to generate the memory dumps?" -ForegroundColor Yellow
                $DelayIntervalStr = Read-Host ">"
        
                try{
                        $DelayIntervalInt = [convert]::ToInt32($DelayIntervalStr)
                        
                        if(0 -ge $DelayIntervalInt)
                        {
                            Write-Host "Please enter a number greater than zero." -ForegroundColor Red
                        }
                    }
    
                catch [FormatException]
                    {
                         Write-Host "The value entered for frequency (in seconds) '",$DelayIntervalStr,"' is not an integer" -ForegroundColor Red
                    }
            }
    
        Write-Host "Generating $DumpCountInt memory dumps at a $DelayIntervalStr-second interval" -ForegroundColor Green
    
        #loop to generate multiple dumps    
        $cntr = 0
        while($true)
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
    
        #print what files exist in the output folder
        Write-Host ""
        Write-Host "Here are all the memory dumps in the output folder '$OutputFolder'" -ForegroundColor Green
        $MemoryDumps = $OutputFolder + "\SQLDmpr*"
        Get-ChildItem -Path $MemoryDumps
    
        Write-Host ""
        Write-Host "Process complete"
    }
    
    else #produce just a single dump
    {
        Start-Process -FilePath $cmd -Wait -Verb runAs -ArgumentList $arglist 
    
        #print what files exist in the output folder
        Write-Host ""
        Write-Host "Here are all the memory dumps in the output folder '$OutputFolder'" -ForegroundColor Green
        $MemoryDumps = $OutputFolder + "\SQLDmpr*"
        Get-ChildItem -Path $MemoryDumps
    
        Write-Host ""
        Write-Host "Process complete"
    }
    
    Write-Host "For errors and completion status, review SQLDUMPER_ERRORLOG.log created by SQLDumper.exe in the output folder '$OutputFolder'. `Or if SQLDumper.exe failed look in the folder from which you are running this script"

    ```

- Run it from Command Prompt as administrator by using the following command:

    ```powershell
    Powershell.exe -File SQLDumpHelper.ps1
    ```

- Or run it from Windows PowerShell console and run as administrator by using the following command:

    ```powershell
    .\SQLDumpHelper.ps1
    ```

> [!NOTE]
> If you have never executed PowerShell scripts on your system, you may receive the error message:
>
> "File ...SQLDumpHelper.ps1 cannot be loaded because running scripts is disabled on this system."

You have to enable the ability to run them by the following steps:

1. Start Windows PowerShell console with the **Run as Administrator** option. Only members of the administrators group on the computer can change the execution policy.
2. Enable running unsigned scripts by the following command:

    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```

    > [!NOTE]
    > This will allow you to run unsigned scripts that you create on your local computer and signed scripts from Internet.
