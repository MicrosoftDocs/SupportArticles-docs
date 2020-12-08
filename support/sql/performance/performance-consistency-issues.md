---
title: Performance and consistency issues
description: This article provides a workaround for the problem that occurs when certain modules are loaded into SQL Server address space.
ms.date: 09/25/2020
ms.prod-support-area-path: Performance
ms.reviewer: bobward, SureshKa
ms.prod: sql
---
# Performance and consistency issues when certain modules are loaded into SQL Server address space

This article helps you resolve the problem that occurs when certain modules are loaded into SQL Server address space.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2033238

## Symptoms

When certain modules are loaded into the Microsoft SQL Server process address space (Sqlservr.exe), you may encounter the following symptoms:

- Reports of various hang-related error messages and conditions (for example, SQL Server scheduler message such as 17883, application time-out messages, severe blocking within SQL Server)
- Slow response from SQL Server even if the concurrent amount of load is not unusually heavy
- Exceptions (such as access violations), critical error messages about database consistency, assertion messages or unexpected process termination
- 100% CPU utilization and long database recovery times when you use in-memory OLTP tables in SQL Server
- Unexpected or unexplained failures when SQL Server processes make Windows API calls

## Cause

These issues occur because applications or other software that are installed on a server that is running SQL Server can load certain modules into the SQL Server process (Sqlservr.exe). This may be done to achieve a specific business logic requirement, an enhanced functionality, or intrusion monitoring. These modules might perform unsupported activities that include detouring important Win32 APIs and SQL Server routines, and calling risky APIs. Additionally, some intrinsic problems within these modules may cause corruption of various memory structures that are necessary for the SQL Server process to function correctly.

## Workaround

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

To work around this problem, follow these steps:

1. Identify the module that is loaded into the SQL Server process and that is causing the problem.
2. Perform the following actions for the module in question:

   1. Configure the application not to load the specific module into the SQL Server process.
   2. Contact the vendor of the module or application to check for updates. Apply any updates that are available.
   3. In some rare situations, you may have to remove the module and its associated software to restore stability to the SQL Server process and the system.

   > [!NOTE]
   > In some instances, you may have to perform all of these actions.

## More information

Microsoft Customer Support and Services (CSS) team has identified the following modules that can cause the symptoms that are mentioned in the "Symptoms" section. This list will be updated as new issues are found. This list is provided to help you identify the process that is mentioned in the "Resolution" section. This process typically involves the collection of an iterative set of diagnostic and tracing data for the duration of the problem.

The following modules can cause performance and stability issues when they are loaded into the SQL Server process:

- ENTAPI.DLL

  ENTAPI.DLL is loaded into the SQL Server process if you install McAfee VirusScan Enterprise on a server that is running Microsoft SQL Server, and then you configure this software to monitor SQL Server. When this module is loaded, important Win 32 APIs are also detoured inside the SQL Server process. If you notice that this module is loaded into SQL Server process, configure McAfee VirusScan Enterprise to exclude SQL Server (Sqlservr.exe) from various advanced monitorings, such as Buffer Overflow Protection.

- HIPI.DLL, HcSQL.dll, HcApi.dll, HcThe.dll  

  These DLL files are loaded into the SQL Server process if you install McAfee Host Intrusion Prevention software on the same system as SQL Server. If you notice that this module is loaded into SQL Server process, configure McAfee Host Intrusion Prevention to exclude SQL Server (Sqlservr.exe) from its monitoring list.

- SOPHOS_DETOURED.DLL and SOPHOS_DETOURED_x64.DLL, SWI_IFSLSP_64.dll

  These DLL files are loaded into the SQL Server process if you install Sophos Antivirus program on a server that is running SQL Server. If you notice that this module is loaded into the SQL Server process, you can [configure the AppInit_Dlls](http://www.sophos.com/support/knowledgebase/article/36501.html) registry subkey to avoid loading this module into SQL Server process.

- PIOLEDB.DLL and PISDK.DLL

  These DLL files are loaded into the SQL Server process if you use the PI OLEDB provider to access data from a PI server or if you use extended stored procedures that use the PI SDK. If you notice that these modules are loaded into the SQL Server process, contact the vendor of these modules to configure the OLEDB provider as an out-of-process provider. This configuration helps to avoid the need to load these modules into the SQL Server process.

- UMPPC*.DLL, SCRIPTCONTROL*.DLL

  These DLL files are loaded into the SQL Server or SQL Server Agent address space if you enable the “Additional User Mode Data” prevention setting for CrowdStrike Anti-Virus/Endpoint protection programs. You might notice failures while SQL Server Agent attempts to create new processes when executing jobs. You might also encounter failures while attempting to launch SQL Server Management Studio.

- Carbon Black -Need dll names

- Trend Micro – Need dll names

  Refer to the software vendor exclusion list setting at [Recommended scan exclusion list for Trend Micro Endpoint products](https://success.trendmicro.com/solution/1059770-recommended-scan-exclusion-list-for-trend-micro-endpoint-products).

For more information about how to set exclusion policies for Sqlservr.exe in the application software that is discussed in this article, see the product manual or contact the software vendor.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.

## References

- [Detours or similar techniques may cause unexpected behaviors with SQL Server](https://support.microsoft.com/help/920925)
- [How to run a DLL-based COM object outside the SQL Server process](https://support.microsoft.com//help/198891)

## Applies to

- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Express Edition with Advanced Services
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Workgroup Edition
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2012 Analysis Services
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Web
- SQL Server 2014 Standard
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Web
- SQL Server 2016 Standard
- SQL Server 2017 Developer on Windows
- SQL Server 2017 Enterprise on Windows
- SQL Server 2017 Enterprise Core on Windows
- SQL Server 2017 Standard on Windows
- SQL Server 2017 on Windows (all editions)
