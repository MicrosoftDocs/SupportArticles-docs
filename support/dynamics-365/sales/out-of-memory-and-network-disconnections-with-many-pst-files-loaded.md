---
title: Out of memory and network disconnections with many PST files loaded
description: Provides a resolution for the out of memory and network disconnections with many PST files loaded in Microsoft Dynamics CRM Outlook clients.
ms.reviewer: ehagen
ms.topic: troubleshooting
ms.date: 
---
# Out of memory and network disconnections with many PST files loaded in Microsoft Dynamics CRM Outlook clients

This article provides a resolution for the issue that out of memory and network disconnections with many PST files loaded in Microsoft Dynamics CRM Outlook clients.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2015877

## Symptoms

This problem may manifest itself with multiple symptoms or any one of the symptoms listed below.

1. Frequent disconnections from Microsoft Dynamics CRM Servers. Microsoft Dynamics CRM client system tray icon will show "There is a problem communicating with the Microsoft Dynamics CRM Server. The Server might be unavailable. Try again later. If the problem persists, contact your system administrator."

2. Frequent disconnections from Microsoft Office Communicator (if installed) to the Microsoft Exchange Server(s). This will often show up with Microsoft Office Communicator showing in a disconnected state and will show messages like "Trying to connect."

3. Disconnections inside Microsoft Outlook to the Microsoft Exchange Server(s). This may show up as "Folder last updated x day and time" in the lower right-hand corner of Microsoft Outlook where x day and time is a day and time that is not current or possibly an hour or two older than the current day and time.

4. The Microsoft Outlook process may have more than 10,000 handles open (can be seen with Windows Task Manager or the Microsoft Sysinternals utility, Process Explorer).

5. If Microsoft CRM Dynamics Client platform tracing has been enabled ([Generating tracing files for support](/previous-versions/dynamics-crm4/implementation-guide/dd979085(v=crm.6)), the additional errors may be seen in the Microsoft Dynamics CRM platform trace files. Typically the errors noted below will be seen in the files named MachineName-OUTLOOK-Client-YYYYMMDD-#.log where YYYY = the year, MM = the month, and DD = the date the log file was created. Note that some of these messages will also be logged in the Application event log from the client computer having the issues.

    1. The Microsoft CRM Outlook add-in failed to initialize the user's language setting. Restart Microsoft Outlook and try again. HR=0x8007000e. Context=. Function=CEnableState::Activate. Line=169.

    2. An error occurred retrieving data from the Microsoft CRM server for processing Microsoft CRM-related e-mail messages. Not all CRM-related e-mail messages may be marked appropriately. Verify that the current user has appropriate permissions and server connectivity and try the action again. HR=0x80131534. Context=. Function=CEmailTagger::Run. Line=414.

    3. Exception occurred during outlook interop: System.Net.WebException: The request failed with HTTP status 401: Unauthorized.

    4. Exception occurred during outlook interop: Microsoft.Crm.CrmException: Resource not found(301).

    5. Exception occurred during outlook interop: System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: An established connection was aborted by the software in your host machine 192.168.1.1:443

    6. Exception occurred during outlook interop: System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A socket operation was attempted to an unreachable host 192.168.1.1:443

    7. Exception when trying to check if the user is authenticated System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A socket operation was attempted to an unreachable host 192.168.1.1:443

    8. LoadMetadataForRichClient() got exception: System.OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.

> [!NOTE]
> The following steps for capturing a memory dump are optional as the symptoms seen should be captured with event log errors or Microsoft Dynamics CRM client platform trace error logs.

If a memory dump has been captured of the Microsoft Outlook process using these steps:

Add the registry path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework`  
Key: **GCBreakOnOOM**  
Type: DWORD  
Value: 2

Setting the above key causes a DebugBreak within the process when a System.OutOfMemoryException is encountered. Configure the Debug Diagnostic Tool:

1. Download and install DebugDiag to a drive with at least 4-5 GB of disk space.
2. Open DebugDiag. If prompted to select a rule, select **Crash**. Else select the **Add Rule** button and select **Crash**.
3. Select **Next** and select **A specific process**.
4. Select the process name, in our Case Outlook.exe. Select **Next**.
5. Under **Advanced Settings**, select **Exceptions**, then select **Add Exception**.
6. From the list of exceptions, select 80000003 Breakpoint Exception.
7. Set Action Type to Full userdump & Action limit to 1. Select **OK**.
8. Select Save & Close button.
9. Select **Next** and provide a name for the rule and location where the dump files must be saved.
10. Select **Next** and then **Finish** button.

You may see a System.OutOfMemoryException listed in the managed threads when analyzing that memory dump with Windbg and the SOS !threads command. You may also see a System.Net.WebException error listed.

## Cause

This problem occurs because Outlook 2003 and Outlook 2007 allocate more memory for caching .pst files than earlier versions of Microsoft Outlook. After you enable this registry key, Outlook 2003 or Outlook 2007 will allocate the same amount of memory as earlier versions of Outlook for caching .pst files. This is typically only seen with having larger numbers of open PST files loaded in Microsoft Outlook such as 50 or more PST files loaded.

## Resolution

The primary resolution is listed here:

> [!Warning]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

**If using Microsoft Outlook 2003:**

1. Quit Outlook 2003.
2. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
3. Locate and then select the following registry subkey:
   `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\PST`
4. On the **Edit** menu, point to **New**, and then select DWORD Value.
5. Type *UseLegacyCacheSize*, and then press ENTER.
6. Right-click **UseLegacyCacheSize**, and then select **Modify**.
7. In the **Value data** box, type **1**, and then select **OK**.
8. On the **File** menu, select **Exit** to quit Registry Editor.

**If using Microsoft Outlook 2007:**

1. Quit Outlook 2007.
2. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
3. Locate and then select the following registry subkey:
   `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\PST`
4. On the **Edit** menu, point to **New**, and then select DWORD Value.
5. Type *UseLegacyCacheSize*, and then press ENTER.
6. Right-click **UseLegacyCacheSize**, and then select **Modify**.
7. In the **Value data** box, type **1**, and then select **OK**.
8. On the **File** menu, select **Exit** to quit Registry Editor.

**If using Microsoft Outlook 2010:**

1. Quit Outlook 2010.
2. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
3. Locate and then select the following registry subkey:
   `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\PST`
4. On the **Edit** menu, point to **New**, and then select DWORD Value.
5. Type *UseLegacyCacheSize*, and then press ENTER.
6. Right-click **UseLegacyCacheSize**, and then select **Modify**.
7. In the **Value data** box, type **1**, and then select **OK**.
8. On the **File** menu, select **Exit** to quit Registry Editor.

Secondary Resolutions that should be applied and may need to be applied in addition to the primary resolution:

1. Network disconnections or an inability to connect to Microsoft CRM Servers may be due to not having enough open WinInet Connections available. This can be automatically fixed by using the FixIt functionality or by implementing the corresponding registry changes manually.

2. We can also increase networking-related performance and minimize networking problems by setting the following two registry keys on your client machine. These keys would need to be created as DWORD keys if not already set. Create these keys and set the correct values:

    `HKEY_LOCAL_MACHINE\System\CurrectControlSet\services\Tcpip\Parameters\MaxUserPort`  
    Value: 65000 decimal

    `HKEY_LOCAL_MACHINE\System\CurrectControlSet\services\Tcpip\Parameters\TCPTimedWaitDelay`  
    Value: 30 decimal

## More information

- [Generating Platform tracing files for Support](/previous-versions/dynamics-crm4/implementation-guide/dd979085(v=crm.6))
- Windbg downloads are available [here](https://www.microsoft.com/whdc/devtools/debugging/default.mspx) for both 64-bit or 32-bit Windows (typically the 32-bit Windbg is used for Microsoft Outlook client debugging since there's only a 32-bit version of Microsoft Outlook available with both Microsoft Outlook 2003 and Microsoft Outlook 2007).
