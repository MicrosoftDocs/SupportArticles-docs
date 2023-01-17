---
title: How to troubleshoot a memory leak
description: Describes troubleshooting steps, important memory usage considerations, and known memory-related issues in BizTalk Server.
ms.date: 03/16/2020
ms.custom: sap:Performance
ms.reviewer: mandia
---
# How to troubleshoot a memory leak or an out-of-memory exception in the BizTalk Server process

This article describes how to troubleshoot a memory leak or an out-of-memory exception in the BizTalk Server process of Microsoft BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server 2010, 2009  
_Original KB number:_ &nbsp; 918643

## Summary

Memory leaks are a common issue. You may have to try several steps to find the specific cause of a memory leak or an out-of-memory (OOM) exception in Microsoft BizTalk Server. This article discusses important things to consider when you evaluate memory usage and possible memory-related issues. These considerations include the following things:

- Physical RAM
- Large message processing
- Use of the **/3GB switch**
- Use of custom components
- Which version of the Microsoft .NET Framework the system is running
- The number of processors

The BizTalk Server process may be experiencing a memory leak when memory usage in Microsoft Windows Task Manager consumes more than 50 percent of the physical RAM. A memory leak may cause an out-of-memory exception when memory usage increases until the process runs out of system memory or until the process stops functioning. For this issue, consider the following:

## Physical RAM and memory usage

Because it may be expected behavior for a process to use about half the physical RAM, use the memory usage as a guideline. For example, if the BizTalk Server has 4 gigabytes (GB) of RAM, and the BizTalk Server process uses about 500 megabytes (MB) of RAM, there may not be leak. If the BizTalk Server process uses about 1 GB of RAM, there might be a memory leak or a high memory situation. The memory consumption may be caused by a long-running stored procedure or orchestration. Make sure that you know how much memory the BizTalk host typically uses to determine whether a memory leak or high memory condition is occurring.

## Large messages

When BizTalk Server processes large messages, the system seems to have a memory leak. However, the messages may be using a large amount of memory.

Also, consider that high memory usage may be expected if BizTalk Server is processing large messages. You may want to upgrade your hardware to meet the performance requirements of BizTalk Server in your environment.

## How long it takes to reproduce the memory leak

Memory leaks can occur immediately or they may accumulate over time. Both scenarios are common.

## Use of the /3GB switch on 32-bit computers

Typically, a process can access 2 GB of virtual address space. The **/3GB switch** is an option for systems that require more addressable memory. This option may improve memory usage for processing messages. However, the **/3GB switch** allows for only 1 GB of addressable memory for kernel mode operations. Additionally, this switch may increase the risk of running out of pool memory.

When the **/3GB switch** is enabled on a 32-bit version of Windows, the process can access 3 GB of virtual address space if the process is large-address aware. A process is large-address aware when the executable has the **IMAGE_FILE_LARGE_ADDRESS_AWARE** flag set in the image header. Because the BizTalk process is large-address aware, BizTalk will benefit from the **/3GB switch**.

If a 32-bit BizTalk host instance is running on a 64-bit version of Windows (AMD64), the BizTalk process benefits from the 4-GB memory address space because BizTalk is large-address aware. Therefore, moving your high memory applications to a 64-bit server may be the best solution.

A 64-bit BizTalk process on a 64-bit version of Windows (AMD64) has 8 TB of addressable memory.

You should also consider the virtual bytes and the private bytes used by the process. A BizTalk host instance (which is a .NET Framework application) may receive an out of memory error before the Virtual Bytes value reaches 2 GB. This situation can occur even though the maximum memory addressable by a process on a 32-bit version of Windows (without the **/3GB switch**) is 2 GB. For an explanation of why this situation can occur, visit the following Microsoft Developer Network (MSDN) website:  
[ASP.NET Performance Monitoring, and When to Alert Administrators](/previous-versions/dotnet/articles/ms972959(v=msdn.10))

The **/3GB switch** also increases the maximum private bytes of the BizTalk process from 800 MB to 1800 MB. For more information about .NET Framework application performance with the **/3GB switch** enabled, visit [Chapter 17—Tuning .NET Application Performance](/previous-versions/msp-n-p/ff647813(v=pandp.10)).

The following table summarizes this information and includes the practical limits for virtual bytes and private bytes.

|Process|Windows|Addressable memory (with a large address-aware process)|Practical limit for virtual bytes|Practical limit for private bytes|
|---|---|---|---|---|
|32-bit|32-bit|2 GB|1400 MB|800 MB|
|32-bit|32-bit with /3GB|3 GB|2400 MB|1800 MB|
|32-bit|64-bit|4 GB|3400 MB|2800 MB|
|64-bit|64-bit|8 TB|Not applicable|Not applicable|

For more information about the addressable memory for 32-bit vs. 64-bit Windows, visit [Memory Limits for Windows and Windows Server Releases](/windows/win32/memory/memory-limits-for-windows-releases).

The following table lists PAE and 3 GB supportability for different versions of BizTalk Server.

|Product|PAE|3 GB|
|---|---|---|
|BizTalk Server 2004|Yes|No|
|BizTalk Server 2006|Yes|Yes|
|BizTalk Server 2006 R2|Yes|Yes|
|BizTalk Server 2009|Yes|Yes|
  
If you must enable the **/3GB switch** to meet the performance requirements of a computer that is running BizTalk Server, you may want to consider adding servers to the BizTalk group. This enables you to scale out the memory-intensive host instances.

BizTalk components that run inside an Internet Information Services (IIS) process may also benefit when the **/3GB switch** is enabled.

The **/3GB switch** is not supported on computers that are running Windows SharePoint Services 2.0 or later versions or SharePoint Portal Server 2003 SP2 or later versions. The Windows Server 2003 **/3GB switch** is not supported in Windows SharePoint Services 2.0 or in later versions or in SharePoint Portal Server 2003 Service Pack 2 or in later versions.

## Use of custom components

If you use custom components, such as pipelines or service components, you must know what these components do. You should also know the potential effect of these components on memory usage. A common memory problem occurs when a component is transforming a document. The transform operation is a memory-intensive operation. When a document is transformed, BizTalk Server passes the message stream to the Microsoft .NET Framework `XslTransform` class within the BizTalk process.

Another common issue occurs when there is intensive string manipulation. Intensive string manipulation can consume lots of memories. For more information about ways to improve performance, visit [Improving Managed Code Performance](/previous-versions/msp-n-p/ff647790(v=pandp.10)).

## Version of the .NET Framework

The Microsoft .NET Framework 2.0 and the .NET Framework 1.1 have different memory behavior. So you may see varying results between them. If you are using the .NET Framework, confirm that the latest .NET Framework Service Pack 1 is installed. This service packs address several known memory issues.

## Number of processors

The common language runtime (CLR) has the following garbage collectors (GCs):

- Workstation (_Mscorwks.dll_)
- Server (_Mscorsvr.dll_)

If the computer that is running BizTalk Server is a multiprocessor system, the .NET Framework uses the Server version of the execution engine. This is the default behavior. The Server garbage collector is designed for maximum throughput. Additionally, the Server garbage collector scales to provide high performance. This garbage collector allocates memory and then later frees memory to provide high performance on the system. Therefore, a computer that is running BizTalk Server together with some .NET Framework components seems to have a memory leak. However, in this scenario, high memory usage is the expected behavior. If the computer runs out of system memory, or if the process stops working because of insufficient addressable memory, a memory leak condition may exist.

If the computer that is running BizTalk Server is a single processor system, the .NET Framework uses the Workstation version of the execution engine. It is the default behavior. The Workstation garbage collector allocation algorithm is not designed for scaling or for maximum throughput. This garbage collector uses concurrent garbage collector methods. These methods are designed for applications that have complex user interfaces. Such applications may require more aggressive garbage collection.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. But serious problems might occur if you modify the registry incorrectly. Thus make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Sometimes, it may be appropriate to run the Workstation version of the execution engine on a multiprocessor system. You can use the following registry key to switch to the Workstation version of the execution engine.

## BizTalk 2006 and later versions

Create the following `CRL Hosting` String registry key with the corresponding values:

- Key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTSSvc$BizTalkHostName\CLR Hosting`
- Value name: Flavor
- Value data: wks

## BizTalk 2004

Create the following `CRL Host` String registry key with the corresponding values:

- Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\BTSSvc{GUID }\CLR Hosting`
- Value name: Flavor
- Value data: wks

For more information, visit [Performance Considerations for Run-Time Technologies in the .NET Framework](/previous-versions/dotnet/articles/ms973838(v=msdn.10)).

The following are common causes and resolutions:

## Process and physical memory usage throttling thresholds

The Process memory usage and Physical memory usage throttling thresholds can be changed in BizTalk Server 2006 and in later versions.

- By default, the **Process memory usage** throttling threshold is set to 25. If this value is exceeded and the BizTalk process memory usage is more than 300 MB, a throttling condition may occur. On a 32-bit server, you can increase the Process memory usage value to 50. On a 64-bit server, you can increase this value to 100. This allows for more memory consumption by the BizTalk process before throttling occurs.

- The **Physical memory usage** throttling threshold has a default value of 0. This threshold measures total system memory. Therefore, if a value other than 0 is configured, a throttling condition can occur if a non-BizTalk process is using high memory.

## Dehydration throttling thresholds

The default memory dehydration thresholds may cause too much dehydration when orchestrations are run on a 64-bit host. For more information about this issue, see [Dehydration Default Properties](/biztalk/core/dehydration-default-properties).

> [!NOTE]
> 64-bit hosts are supported in BizTalk Server 2006 and later versions.

On equivalent hardware in a 32-bit host instance, observed dehydration is nominal when the same orchestrations are run by using the default memory dehydration throttling thresholds.

Because 64-bit architecture provides expanded memory address space (16 TB instead of 4 GB), 64-bit host instances are allocated more memory than 32-bit host instances. This can cause the default memory throttling thresholds to be exceeded.

To work around this behavior, change the **VirtualMemoryThrottlingCriteria** and **PrivateMemoryThrottlingCriteria** values in the BTSNTSvc64.exe.config file. Use the \Process\Virtual Bytes and the \Process\Private Bytes Performance Monitor counters to determine the largest amount of memory that is being allocated by an orchestration instance.

- Set the **OptimalUsage** value for both properties based on the following:

  - **VirtualMemoryThrottlingCriteria**: \Process\Virtual Bytes value + 10%
  - **PrivateMemoryThrottlingCriteria**: \Process\Private Bytes value + 10%

- Set **MaximalUsage** for both properties to the **OptimalUsage** value + 30%

For example, if the \Process\Virtual Byte Performance Monitor counter value for an orchestration instance is 5,784,787,695 bytes (5,517 MB), set the **OptimalUsage** value for **VirtualMemoryThrottlingCriteria** to 6,069 MB (5,784,787,695 * 1.10 = 6,363,266,464.5 bytes).

Set the **MaximalUsage** value for **VirtualMemoryThrottlingCriteria** to 7,889 MB (6,363,266,464.5 * 1.30 = 8,272,246,403.85 bytes).

If the \Process\Private Bytes Performance Monitor counter value is 435689400 bytes (415 MB), set the **OptimalUsage** value for **PrivateMemoryThrottlingCriteria** to 457 MB (435689400 * 1.10 = 479258340 bytes).

Set the **MaximalUsage** value for **PrivateMemoryThrottlingCriteria** to 594 MB (479258340 * 1.30 = 623035842).

For this example, the following values would be specified in the BTSNTSvc64.exe.config file to reduce throttling.

|Performance Monitor counter|Memory allocated|OptimalUsage|MaximalUsage|
|---|---|---|---|
|\Process\Virtual Bytes|5,784,787,695 bytes (5517 MB)|6069|7889|
|\Process\Private Bytes|435,689,400 bytes (415 MB)|457|594|
  
  These values would then be represented in the BTSNTSvc64.exe.config file as follows:

```xml
<xlangs>
    <Configuration>
       <Dehydration>
         <VirtualMemoryThrottlingCriteria OptimalUsage="6069" MaximalUsage="7889" IsActive="true" />
         <PrivateMemoryThrottlingCriteria OptimalUsage="457" MaximalUsage="594" IsActive="true" />
       </Dehydration>
    </Configuration>
</xlangs>
```

To determine which host instance is running the orchestration, you can match the ID Process from the \BizTalk: Messaging\ID Process and \Process\ID Process Performance Monitor counters. Then, check the Average value displayed for the corresponding \Process\Virtual Bytes and \Process\Private Bytes Performance Monitor counters.

> [!NOTE]
> Information the user should notice even if skimmingThe high dehydration may cause a significant decrease in performance when the `BizTalkMsgBoxDb` database is running on SQL Server 2008.

## BizTalk Server service packs and cumulative updates

BizTalk Server service packs and cumulative updates include the latest fixes. These include those that affect known `System.OutOfMemoryException` issues.

## HeapDeCommitFreeBlockThreshold

By default, the `HeapDeCommitFreeBlockThreshold` registry key value is 0. A value of 0 means that the heap manager de-commits each 4 kilobytes (KB) page that becomes available. De-commit operations can cause virtual memory fragmentation. The size of the `HeapDeCommitFreeBlockThreshold` setting in the heap manager will depend on the kind of work that the system is doing. A size of 0x00040000 is a recommended starting value.

Consider the following information before you change the value of the `HeapDeCommitFreeBlockThreshold` registry key:

- This change only applies to memory fragmentation problems.
- This change is system-wide. Therefore, most processes will use more memory on startup.
- Only consider this change for systems that have BizTalk Server as their primary mission.

To help reduce virtual memory fragmentation, you can increase the size of the `HeapDeCommitFreeBlockThreshold` setting in the heap manager by changing the value of the following registry key under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager`:

- Value name: HeapDeCommitFreeBlockThreshold
- Value type: REG_DWORD
- Value data: 0x00040000 (It is the recommended starting value.)
- Value default: not present

## Transform operations

When BizTalk Server performs XML transform operations on fairly large messages in a receive port, in a send port, or in `XLANG`, XSL transforms load the whole message in memory.

To resolve this issue, use one of the following methods:

- Reduce the number of messages that BizTalk Server processes at the same time.
- Reduce the size of the XML message that is being transformed.

The `System.Policy.Security.Evidence` object is frequently used in transforms and can consume much memory. When a map contains a scripting `functoid` that uses inline C# (or any other inline language), the assembly is created in memory. The `System.Policy.Security.Evidence` object uses the object of the actual calling assembly. This situation creates a rooted object that is not deleted until the BizTalk service is restarted.

Most of the default BizTalk `functoids` are implemented as inline script. These items can cause `System.Byte[]` objects to collect in memory. To minimize memory consumption, we recommend that you put any map that uses these `functoids` into a small assembly. Then, reference that assembly. Use the following chart to determine which `functoids` use inline script and which `functoids` do not use inline script.

In the second column, **Yes** means that this `functoid` is implemented as inline script, and that it will cause `System.Byte[]` objects to collect in memory. **No** means that this `functoid` is not implemented as inline script, and that it will not cause `System.Byte[]` objects to collect in memory.

|Functoids|Inline script?|
|---|---|
|All String Functoids|Yes|
|All Mathematical Functoids|Yes|
|All Logical Functoids except IsNil|Yes|
|Logical IsNil Functoid|No|
|All Date/Time Functoids|Yes|
|All Conversion Functoids|Yes|
|All Scientific Functoids|Yes|
|All Cumulative Functoids|Yes|
|All Database Functoids|No|
  
|Advanced Functoids|Inline script?|
|---|---|
|Looping Functoid|No|
|Value-Mapping Flattening Functoid|No|
|Assert Functoid|No|
|Table Extractor Functoid|No|
|Table Looping Functoid|No|
|Scripting Functoid with Inline C#|Yes|
|Scripting Functoid with Inline JScript.NET|Yes|
|Scripting Functoid with Inline Visual Basic .NET|Yes|
|Scripting Functoid with Inline XSLT|No|
|Scripting Functoid with Inline XSLT Call Template|No|
|Scripting Functoid calling External Assembly|No|
|Nil Value Functoid|No|
|Value Mapping Functoid|No|
|Mass Copy Functoid|No|
|Iteration Functoid|No|
|Index Functoid|No|
|Record Count Functoid|No|
  
BizTalk Server 2006 and later versions significantly improve memory management for large documents. To do this, BizTalk Server implements a configurable message size threshold for loading documents into memory during transform operations. The default message size threshold is 1 MB. For more information about the TransformThreshold setting, visit [How BizTalk Server Processes Large Messages](/biztalk/core/how-biztalk-server-processes-large-messages).

## Large attribute values and large element values

When BizTalk Server executes a receive pipeline or a send pipeline on an XML document, the payload is processed in memory if the document contains one or more of the following entities:

- Large attribute values
- Large element values
- Large attribute or element tags

To resolve this issue, limit the size of these entities. If this method isn't possible, make sure that your BizTalk HOST instance doesn't process multiple documents such as these at the same time.

## Custom pipeline components

You are using a custom pipeline component that loads the whole stream into memory. All the components that are included with BizTalk Server, except transforms, support streaming. These components do not use as much memory during streaming. However, custom pipeline components may not support streaming.

## Streaming under heavy stress

Send hosts run out of memory when they operate under heavy stress. BizTalk Server sends pipelines and sends adapters support streaming. In streaming, each component loads a small fragment of the stream into memory. Because each message includes other data structures, together with a message context that can be significant or small, this behavior affects the behavior of BizTalk Server under heavy stress.

The behavior of BizTalk Server is affected because the engine loads a pre-configured number of messages. The number of messages that the engine loads is based on the values that appear in the **LowWaterMark** field and the **HighWaterMark** field of the `Adm_serviceClass` table. The `Adm_serviceClass` table is in the BizTalk Management Database. These values control the number of messages that BizTalk Server processes or sends at the same time.

The **HighWaterMark** value is the total number of messages that the engine processes at the same time. The default value is 200 messages per CPU. Therefore, on an 8-processor server, the send host will try to process 1,600 messages (200 * 8) at the same time.

If you assume that each message is 50 KB, the messages equal 80 MB (1,600 * 50=80,000 KB).

To resolve this issue, you can change the **HighWaterMark** value and the **LowWaterMark** value in the database. The values that you use depend on the size of the messages. For BizTalk Server 2006 and later versions, you can change the default host throttling settings.

## Try to simplify the issue

If you have identified a memory leak, try to determine the cause by removing custom components or by simplifying a map. Also, try to reproduce the issue by using a simple orchestration or a simple solution. Typically, you should create separate receive hosts for receive adapters. You should also create separate send hosts for send adapters. When you use this method, each adapter can run in a separate process. Therefore, if your BizTalk Server process experiences an out-of-memory condition, you will know which components are involved.

## Troubleshooting steps

To troubleshoot an out-of-memory condition, use the Debug Diagnostics tool to monitor memory allocations over time. The Debug Diagnostics tool can create and analyze a memory leak dump file (.dmp). When you troubleshoot memory leaks, the goal is to attach _Leaktrack.dll_ before the high memory condition reproduces to capture memory growth over time. _Leaktrack.dll_ is included with the Debug Diagnostics tool.

1. Install the Debug Diagnostics Tool.

    The following file is available for download from the Microsoft Download Center:  
    [Download the Debug Diagnostic Tool package now](https://www.microsoft.com/download/details.aspx?id=58210)

    For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

2. Use Performance Monitor to collect data about system performance. This data may provide important indicators about the efficiency of your BizTalk Server environment. The goal is to capture process performance over time. Therefore, enable Performance Monitor logging before the memory leak occurs.

## How to use Performance Monitor logging

The following sections describe how to use performance monitor logging.

### Select the data to log

To select the data to log, use the method that is appropriate for your operating system:

- For Windows Server 2008 and Windows Server 2008 R2
  1. In Administrative Tools, open **Reliability and Performance Monitor**.
  2. Right-click **Performance Monitor**, click **New** and then click **Data Collector Set**.
  3. In the **Name** box, type a descriptive name, and then click **Next**.
  4. Note the **Root** directory, and then click **Next**.
  5. Click **Start this data collector set now**, and then click **Finish**.
  6. Expand **Data Collector Sets**, expand **User Defined** and then select your file.
  7. Right-click **System Monitor Log**, and then click **Properties**.
  8. Click **Add** on the **Performance Counters** tab. Select the following objects, and then click **Add** after you select each object:

     - **.Net CLR Exceptions**
     - **.Net CLR Memory**
     - **BizTalk: Messaging**
     - **BizTalk: TDDS**
     - **Memory**
     - **Process**
     - **Processor**
     - **XLANG/s Orchestrations**

     If SQL Server is local, also add the following objects:

     - **SQLServer: Databases**
     - **SQLServer: General Statistics**
     - **SQLServer: Memory Manager**

  9. Click **OK**.
  10. Change the **Sample Interval value** box to **5 seconds**.

      > [!NOTE]
      > The Sample Interval value and the time to start to monitor are subjective. These values depend on when the memory leak is reproduced. Because the log file can be large, specify an interval in which you can obtain the information that you must have without overwhelming the server.

  11. Click **OK**.
  
To stop collecting data, click **Stop** on the **Action** menu.

- For Windows Server 2003 or for Windows XP

    1. Expand **Performance Logs and Alerts**.
    2. Right-click **Counter Logs**, and then click **New Log Settings**. The **New Log Settings** dialog box appears.
    3. In the **Name** box, type a descriptive name, and then click **OK**.
    4. Note the log file location. (You can also click the **Log Files** tab, and then click **Configure** to change the log file location.)
    5. Click **Add Counters**.
    6. Select **All counters** and **All instances**.
    7. In the **Performance object** list, select the following objects. Click **Add** after you select each object.

        - **.Net CLR Exceptions**
        - **.Net CLR Memory**
        - **BizTalk: Messaging**
        - **BizTalk: TDDS**
        - **Memory**
        - **Process**
        - **Processor**
        - **XLANG/s Orchestrations**

        If SQL Server is local, also add the following objects:

        - **SQLServer: Databases**
        - **SQLServer: General Statistics**
        - **SQLServer: Memory Manager**

    8. Click **Close**.
    9. Change the value in **Data Sampling Interval** to 5 seconds.

       > [!NOTE]
       > The **Data Sampling Interval** value and the time to start to monitor are subjective. These values depend on when the memory leak is reproduced. Because the log file can be large, specify an interval in which you can obtain the information that you must have without overwhelming the server.

    10. Click **OK**. To stop collecting data, right-click the name of the counter log and then click **Stop**.

### Obtain the dump file

To obtain the dump file, use one of the following methods:

#### Method 1: Automatic

Creating a Memory and Handle Leak rule with DebugDiag is the recommended approach to capture a memory dump. The Memory and Handle Leak rule automatically attaches _Leaktrack.dll_. This is used to track memory allocations. To create the Memory and Handle Leak rule, follow these steps:

1. Start Debug Diagnostics Tool 1.1.
2. Select **Memory and Handle Leak**, and then click **Next**.
3. Select the Btsntsvc.exe process, and then click **Next**.
4. On the **Configure Leak Rule** page, follow these steps:

   1. Click to select the **Start memory tracking immediately when rule is activated** check box. Otherwise, you can specify a warm-up time before _LeakTrack.dll_ is injected in the BTSNTSvc.exe process.

   2. Click **Configure**, and then do the following:

      - Confirm that **Autocreate a crash rule** is selected. By selecting this option, a memory dump will be created automatically if the BTSNTSvc.exe process stops.

      - Click to select the **Generate a userdump when virtual bytes reach** check box, and keep the default value of **1024**.

      - Click to select the **and each additional** check box, and keep the default of 200. By selecting the virtual bytes reach option, a memory dump will automatically be created when virtual bytes use 1024 MB. If virtual bytes increases by 200 MB, another memory dump will automatically be created.

   3. Click **Save & Close**.
   4. Click **Next**.
   5. On the **Select Dump Location And Rule Name** page, click **Next**.

      > [!NOTE]
      > You can also change the path of the dump file in the **Userdump Location** box on this page.

   6. Click **Finish** to make the rule active now.

       > [!NOTE]
       > The rule status is now **Tracking**. Every time that a memory dump is created, the value will increase in the **Userdump Count** column on the **Rules** tab. The default memory dump location is `C:\Program Files\DebugDiag\Logs`.

#### Method 2: Manual

You can also manually attach Leaktrack.dll and manually obtain the memory dump file. This enables you to control when the memory dump is created. To do this, follow these steps:

1. Start Debug Diagnostics Tool 1.1.
2. Click the **Processes** tab.
3. Right-click the Btsntsvc.exe process, and then click **Monitor For Leaks**.
4. In the **Debug Diagnostics Tool** dialog box, click **Yes**, and then click **OK**.

Create a crash rule to monitor the same Btsntsvc.exe process in case the process stops before you can create the memory dump:

1. Start Debug Diagnostics Tool 1.1.
2. Select **Crash**, and then click **Next**.
3. Select a specific process, and then click **Next**.
4. Select the same Btsntsvc.exe process, and then click **Next**.
5. On the **Advanced Configuration (Optional)** page, click **Next**.
6. In the **Select Dump Location And Rule Name (Optional)** dialog box, click **Next**.
7. Select **Activate the rule now**, and then click **Finish**.

When the process reaches 60 percent to 80 percent of RAM, right-click the Btsntsvc.exe process, and then click **Create Full Userdump**. If the BizTalk process stops before you can create the user dump, the Crash rule should take effect and create the memory dump.

### Stop Performance Monitor logging

If you are capturing a memory dump and Performance Monitor data, stop Performance Monitor logging about two minutes after the memory dump is created.

#### Analyze the dump file

To help determine the cause of a memory leak, you can use the Debug Diagnostics tool to analyze the dump file. To do this, follow these steps:

1. Click the **Advanced Analysis** tab.
2. Click **Add Data Files**, and then locate the .dmp file.
3. Select the **Memory Pressure Analysis** script, and then click **Start Analysis**.

By default, an analysis report file (the .mht file) will be created in the `C:\Program Files\DebugDiag\Reports` folder when the analysis is finished. The report file will also be displayed in your browser. The report file contains the results of the analysis. Additionally, the report file may contain recommendations for how to resolve the memory leak.

If you use custom DLLs, you can add the symbol path of the custom .pdb files for analysis. To do this, follow these steps:

1. Open the Debug Diagnostics tool.
2. On the **Tools** menu, click **Options and Settings**.
3. In the **Symbol Search Path For Debugging** box, type the symbol path.

If you want help with analyzing the dump file, contact Microsoft Customer Support Services. For a complete list of Customer Support Services telephone numbers and information about support costs, visit the [Contact Support](https://support.microsoft.com/contactus/?ws=support).

Before you contact Customer Support Services, compress the dump file, the Performance Monitor log, the analysis report file, and the updated event logs (.evt files). You may have to send these files to a BizTalk Server support engineer.
