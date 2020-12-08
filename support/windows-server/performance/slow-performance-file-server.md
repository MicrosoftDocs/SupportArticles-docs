---
title: Your system stops responding, you experience slow file server performance, or delays occur when you work with files that are located on a file server
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: waltere
---
# Your system stops responding, you experience slow file server performance, or delays occur when you work with files that are located on a file server

_Original product version:_ &nbsp; Microsoft Windows XP Professional, Microsoft Windows XP Tablet PC Edition, Microsoft Windows Server 2003 Web Edition, Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)  
_Original KB number:_ &nbsp; 822219

## Symptoms

You may experience one or more of the following symptoms when you work with files over the network:

- A Windows-based file server that is configured as a file and print server stops responding and file and print server functionality temporarily stops.
- You experience an unexpectedly long delay when you open, save, close, delete, or print files that are located on a shared resource.
- You experience a temporary decrease in performance when you use a program over the network. Performance typically slows down for approximately 40 to 45 seconds. However, some delays may last up to 5 minutes.

- You experience a delay when you perform file copy or backup operations.
- Windows Explorer stops responding when you connect to a shared resource or you see a red X on the connected network drive in Windows Explorer.
- When you log on to the file server, after you type your name and password in the **Log On to Windows** dialog box, a blank screen appears. The desktop does not appear.
- A program that uses remote procedure call (RPC) or uses named pipes to connect to a file server stops responding.
- The server temporarily stops responding and one or more event ID messages similar to the following messages appear in the System log on the file server: Additionally, the following event appears in the System log on the client computer:
- You receive an error message similar to one of the following messages when you try to connect to a shared resource: Error message 1 System error 53. The network path was not found.
 Error message 2 System error 64. The specified network name is no longer available.

- You are intermittently disconnected from network resources, and you cannot reconnect to the network resources on the file server. However, you can ping the server, and you can use a Terminal Services session to connect to the server.
- If multiple users try to access Microsoft Office documents on the server, the **File is locked for editing** dialog box does not always appear when the second user opens the file.
- A network trace indicates a 30 to 40 second delay between an SMB Service client command and a response from the file server.
- When you try to open an Access 2.0 database file (.mdb file) in Microsoft Access 97, in Microsoft Access 2000, or in Microsoft Access 2002, you may receive an error message that is similar to the following:Disk or network error.

- When you try to open a Microsoft Word file, you may receive the following error message:Word failed reading from this file **file_name**. Please restore the network connection or replace the floppy disk and retry.
Additionally, the following event may be logged in the System log on the client computer:

## Cause

This issue may occur if a non-Microsoft program that is installed on your computer uses an outdated kernel-mode filter driver. The kernel-mode filter driver may be outdated if the following conditions are true:

- One of the following programs is installed on the computer:

- ARCserve Backup Agent for Open Files or ARCserve Open File Agent from Computer Associates International, Inc. is installed on your computer, and the Ofant.sys driver for the program is outdated.
  - Open Transaction Manager is installed on your computer, and the Otman.sys driver for the program is outdated.

> [!NOTE]
> Open Transaction Manager is included with certain programs from VERITAS Software Corporation, but it can also be installed separately from the VERITAS program. For example, Open Transaction Manager may be included with Open File Option. This program may be included with VERITAS Backup Exec.
  - A VERITAS program that uses the Otman4.sys or Otman5.sys driver (such as Open File Option) is installed on your computer, and the Otman4.sys or Otman5.sys driver for the program is outdated.
- The driver for the program is incompatible with the filter driver that is installed on the computer by a non-Microsoft antivirus program. As a result, the filter driver on the server may return an incorrect status code to the Server service. For example, the filter driver may return a STATUS_SUCCESS code instead of a STATUS_OPLOCK_BREAK_IN_PROGRESS code.


## Resolution

To resolve this issue, contact the manufacturer of the program to inquire about the availability of a filter driver update. For more information about how to contact Computer Associates to obtain the latest update for the Ofant.sys driver, visit the following Computer Associates Web site: [http://www.ca.com/support/](http://www.ca.com/support/) 
If you installed Open Transaction Manager separately, contact Columbia Data Products, Inc. to inquire about the availability of an update that may resolve this issue. To contact Columbia Data Products, visit the following Columbia Data Products Web site: [http://www.cdp.com/](http://www.cdp.com/) 
For more information about how to contact VERITAS, visit the following VERITAS Web site: [http://support.veritas.com/](http://support.veritas.com/) 
 Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

## More Information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To temporarily work around this issue, restart the Server services on the server. To restart the Server services, follow these steps:

1. Click **Start**, and then click
 **Run**.
2. In the **Open** box, type
 cmd , and then click **OK**.
3. At the command prompt, type the following lines, and press Enter after each line: net stop server
net start server 
To troubleshoot this issue, use any of the following methods:

- Use Performance Logs and Alerts to monitor the **Avg. Disk Queue Length** counter of the **PhysicalDisk** performance object. Under ordinary conditions, the number of waiting input/output (I/O) requests is typically no more than 1.5 to 2 times the number of spindles that the physical disk has. Most disks have one spindle, although redundant array of independent disks (RAID) devices typically have more than one spindle. When a program runs small successive I/O operations, you see a spike in the **Current Disk Queue Length** counter when I/O-bound operations are queued. You may also see an increase in the **Context Switches/sec** counter of the **System** performance object.
- Disable opportunistic locking on either the client or on the server. To disable opportunistic locking on the client, set the following registry value to 1: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MRXSmb\Parameters\OplocksDisabled` 
To disable opportunistic locking on the server, set the following registry value to 0: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\EnableOplocks` 
 For more information about how to disable opportunistic locking, click the following article number to view the article in the Microsoft Knowledge Base:

[296264](https://support.microsoft.com/help/296264) Configuring opportunistic locking in Windows  

- Edit the registry to temporarily deactivate the filter driver.

For more information about how to temporarily deactivate the kernel-mode filter driver, click the following article number to view the article in the Microsoft Knowledge Base:

[816071](https://support.microsoft.com/help/816071) How to temporarily deactivate the kernel mode filter driver in Windows  

The registry key that stores information for the Ofant.sys driver is the following: **Ofadriver**  


## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[814112](https://support.microsoft.com/help/814112) Files on network shares open slowly, opens as read-only, or you receive an error message  

[821246](https://support.microsoft.com/help/821246) Office files are slow to open, close, save, or print from a network server  

[816071](https://support.microsoft.com/help/816071) How to temporarily deactivate the kernel mode filter driver in Windows  

[252332](https://support.microsoft.com/help/252332) Event ID 3013 when you copy files to a server that is under disk stress  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
