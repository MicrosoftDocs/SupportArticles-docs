---
title: BizTalk server admin console issues
description: Introduces common issues and resolutions with the BizTalk Server Administration console.
ms.date: 03/04/2020
ms.custom: sap:Management and Operations
ms.reviewer: btstech
---
# Common issues and resolutions with the BizTalk Server Administration console

This article describes resolutions for common issues with the BizTalk Server Administration console.

_Original product version:_ &nbsp; BizTalk Server 2009, 2010  
_Original KB number:_ &nbsp; 2449532

When using System Center Operations Manager (SCOM) 2007 with the BizTalk Management Pack, you may notice the following potential issues:

## Expanding BizTalk Group causes the MMC to stop responding

To resolve this issue, use one of the following resolutions:

- Confirm the BizTalk Management Pack is configured correctly. For example, you must specify a Run As Account for the _BizTalk Server Monitoring Account_ and _BizTalk Server Discovery Account_ profiles within SCOM. For the specific details, see [Microsoft BizTalk Server Management Pack for System Center Operations Manager 2007](/biztalk/technical-guides/monitoring-biztalk-server-with-system-center-operations-manager-2007).

- The BizTalk Management pack runs a script for every artifact type (send port, receive port, receive location, send port group, orchestration, and so on) per host. If there are 50 hosts, then there will be 50 scripts executed against Windows Management Instrumentation (WMI) per artifact type. In this scenario, WMI can become overloaded. This querying may keep the BizTalk WMI provider running continuously.

    To prevent this, increase the monitoring intervals within SCOM to a higher value. For example, increase the monitoring intervals by picking a random 5-7 minute difference between the scripts:

    |Script|Time (seconds)|
    |---|---|
    |Adapter Availability Monitor|420|
    |Host Availability Monitor|780|
    |Host Instance Availability Monitor|1140|
    |Orchestration Availability Monitor|1500|
    |Receive Location Availability Monitor|1860|
    |Receive Port Availability Monitor|2220|
    |Send Port Availability Monitor|2580|
    |Send Port Group Availability Monitor|2940|

## Error when clicking Refresh or expanding Handlers

You get one of these error messages:

> Unable to load adapter handlers for Adapter adapter.(Microsoft.BizTalk.Administration.SnapIn)

Additional information:

> Failed to create a CLSID_Biztalk Property Bag Factory COM component installed with a BizTalk server.  
> A dynamic link library (DLL) initialization routine failed. (WinMgmt)

### Resolution

BizTalk Server Administration relies on Windows Management Instrumentation (WMI); more specifically, the BizTalk WMI Provider (BTSWMIProvider.dll).

The BizTalk WMI Provider relies on the ClearAfter property within the WMI root namespace. The default `ClearAfter` property is 30 seconds (00000000000030.000000:000). If this value has been changed to a larger value, like 500 seconds (00000000000500.000000:000), then this error may be returned.

To set the `ClearAfter` property, use Windows Management Instrumentation Tester (wbemtest) on all BizTalk servers in the group using the steps below:

1. Go to **Start** or **Run**, and type _wbemtest_.
2. Click the **Connect** button and change the name pace to root. Click **Connect**.
3. Click the **Query** button and type `select * from __CacheControl`. Click **Apply**.
4. Double-click each item and select the `ClearAfter` property. Confirm they have the following values:

    |Item|Value|
    |---|---|
    |__EventConsumerProviderCacheControl=@|00000000000030.000000:000|
    |__EventProviderCacheControl=@|00000000000030.000000:000|
    |__EventSinkCacheControl=@|00000000000015.000000:000|
    |__ObjectProviderCacheControl=@|00000000000030.000000:000|
    |__PropertyProviderCacheControl=@|00000000000030.000000:000|

    If any value exceeds the values listed above, click the **Edit Property** button to change it. Click **Save Property**. Click **Save Object**.

5. Restart the Windows Management Instrumentation service.

## Errors when you stop an orchestration

On the SCOM server, you attempt to stop an orchestration. This may return the following error message:

> Error encountered when attempting to stop orchestration processing.  
> Could not stop orchestration 'Orchestration, Version=4.12.1.1, Culture=neutral, PublicKeyToken=1710edac7131301e'. A database failure occurred due to database connectivity problems. (HRESULT: 80131600).

On the BizTalk Server around the same time as the SCOM server error, the following error message is displayed:

> Event Type: Error  
> Event Source: COM+  
> Event Category: (98)  
> Event ID: 4791  
> Description:  
> The COM+ Services DLL (comsvcs.dll) was unable to load because allocation of thread local storage failed.  
> Process Name: wmiprvse.exe  
> Error Code = 0x80070008 : Not enough storage is available to process this command.  
> COM+ Services Internals Information:  
> File: d:\nt\com\complus\src\comsvcs\comsvcs\comsvcs.cpp, Line: 334  
> Comsvcs.dll file version: ENU 2001.12.4720.4045

To resolve this, follow the steps in the link below to modify the registry key and install the appropriate hotfix:  
[Troubleshooting Issues When Monitoring BizTalk Server Using System Center Operations Manager 2007](https://www.microsoft.com/download/details.aspx?id=56498)

You also may receive additional issues that are described in the following section.

## Common tasks require specific rights

Many common tasks like creating a BizTalk host or stopping a send port require specific rights within BizTalk and SQL Server. If you're unable to perform certain functions within BizTalk Administration, you may be missing membership to a BizTalk group. For the specific details of the group or role requirements, see [Minimum Security User Rights](/biztalk/core/minimum-security-user-rights).

## SQL Server configured to listen on a port other than 1433 may cause issues

A SQL Server configured to listen on a port other than 1433 may cause the following behaviors:

- Expanding BizTalk Group takes longer than expected and shows a red circle.
- Expanding Applications takes longer than expected.
- Adding a Resource takes longer than expected.
- Selecting Send Ports takes longer than expected for them to display.
- Expanding All Artifacts shows a red circle.

To resolve these issues, confirm the SQL Server Browser service is started on all the BizTalk servers in the group. Also on all BizTalk servers in the group, open SQL Server Configuration Manager and create an alias:

1. Expand SQL Native Client Configuration and select **Aliases**.

2. Right-click **Alias** and choose **New Alias**. Enter the following:

    |Alias Name|SQL Server name|
    |---|---|
    |Port No|TCP port used by SQL Server|
    |Protocol|TCP/IP|
    |Server|SQL Server name|

    For example, if your SQL Server computer is named _MySQL_ and listening on port 40090, then you would specify the following:

    |Alias Name|MySQL|
    |---|---|
    |Port No|40090|
    |Protocol|TCP/IP|
    |Server|MySQL|

3. Click **OK**.

    > [!NOTE]
    > In this scenario, a Network Monitor capture may show connections to port 1433 continually being reset. This typically occurs if SQL Server is not listening on port 1433. To confirm the SQL Server port, run `netstat -a noon` the SQL Server. Look for the sqlservr.exe Process ID (PID) in the `netstat` output to determine the port number.

## Network layer could be responsible for some delays

When BizTalk and SQL Server are remote, the network layer could be responsible for some delays. Consider the following:

- If there are any delays or issues with name resolution within Domain Name System (DNS), the BizTalk Administration console will be affected. As a workaround, you can add the SQL Server IP address to the hosts file on all BizTalk servers in the group. The hosts file is located in the following directory:

    32-bit server: `%systemroot% \system32\drivers\etc`

    64-bit server: `%systemroot% \SysWOW64\drivers\etc`

    For example, if the SQL Server IP address is _1.1.1.1_ and the SQL Server name is _MySQL_, you should add the hosts file _1.1.1.1 MySQL_.

    BizTalk Administration runs as a 32-bit process on a 64-bit server. As a result, the issue described below may impact the MMC:  
    32-bit applications don't use the Domain Name System (DNS) cache on a computer that is running an x64-based version of Windows Server 2003 or of Windows XP

    If a remote server is specified in a receive location or a send port that is running in a 32-bit host, the DNS query for this server could also be affected. In this scenario, you can add the remote server to the hosts file. For example, the remote server IP address is `1.1.1.1` and the remote server name is _MyServer_. You would add the following to the hosts file _1.1.1.1 MyServer_.

    To reset the hosts file back to the default, see [How to reset the Hosts file back to the default](https://support.microsoft.com/help/972034).

- The Speed & Duplex value on the Network Interface Card (NIC) and additional network layers (for example router) can impact performance. If the Speed & Duplex value on the SQL Server NIC is set to 100 MB Half and theSpeed & Duplex value on the BizTalk Server NIC is set to 1 GB Full, then a delay will probably occur.

    Confirm the Speed & Duplex value of all network layers involved (NIC, router, and so on) are the same. In the scenario above, configure the SQL Server NIC and the router to 1 GB Full.

    To test this scenario, copy/paste a file from the BizTalk Server to a folder on the SQL Server, and vice versa. If this copy process takes a while, then something in the network layer is causing an issue.

- When connecting to the SQL Server Database Engine, a network protocol must be enabled. For BizTalk, confirm the TCP/IP protocol is enabled. See [Choosing a Network Protocol](/previous-versions/sql/sql-server-2016/ms187892(v=sql.130)).

## OutOfMemory exception when working within BizTalk Administration

You may get an `OutOfMemory` exception when working within BizTalk Administration. WMI has a `__ProviderHostQuotaConfiguration` class that applies to the BizTalk WMI namespace. This class consists of the following properties:

- HandlesPerHost
- MemoryAllHosts
- MemoryPerHost
- ProcessLimitAllHosts
- ThreadsPerHost

To check the MemoryPerHost value, use **wbemtest** on all BizTalk servers in the group:

1. Go to **Start** or **Run**, and type **wbemtest**.
2. Click the **Connect** button and change the Name pace to root. Click **Connect**.
3. Click the **Enum Instances** button and enter **__ProviderHostQuotaConfiguration**. Click **OK**.
4. Double-click **__ProviderHostQuotaConfiguration=@**.
5. If the **MemoryPerHost** value is less than 512 MB (536870912), double-click **MemoryPerHost** and set the value to 536870912. Click **Save Property**, click **Save Object** and exit.
6. Restart the Windows Management Instrumentation service.

For more information, see [ProviderHostQuotaConfiguration class](/windows/win32/wmisdk/--providerhostquotaconfiguration).

## Troubleshooting

If BizTalk support assistance is needed, collect the following data while reproducing the issue:

1. Capture a BizTalk trace using the `-all` option while reproducing the issue. 、
2. Configure the Private Trace registry key to enable WMI tracing in the BizTalk Administration console using the steps below:

    1. Open the registry and go to the following key:

        32-bit server: `HKEY_LOCAL_MACHINE\Software\Microsoft\BizTalk Server\3.0\Administration`

        64-bit server: `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\BizTalk Server\3.0\Administration`

    2. Create a new DWORD value named **Private Trace** and set it to 1.

    3. Restart the Windows Management Instrumentation service.

        This creates the `c:\BizTalkAdminDbgLog.txt` log file. The log file path and file name can' be changed.

3. Capture a SQL Server Profiler trace with the following Events:

    |Errors and Warnings|All events|
    |---|---|
    |Locks|Lock: Deadlock <br/> Lock: Escalation <br/>Lock: Timeout|
    |Security Audit| Audit Login<br/>Audit Login Failed<br/>Audit Logout|
    |Sessions| ExistingConnection|
    |Stored Procedures| SP: Completed<br/>SP: Starting<br/>SP: StmtCompleted<br/>SP: StmtStarting|
    |TSQL|SQL: StmtCompleted<br/>SQL: StmtStarting|
    |Transactions| DTCTransaction<br/>SQL Transaction|

4. Capture simultaneous Network Monitor captures on the BizTalk and SQL servers while reproducing the issue.
