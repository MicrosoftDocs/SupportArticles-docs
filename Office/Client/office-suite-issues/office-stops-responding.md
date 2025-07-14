---
title: Office stops responding when you open a file
description: Using Save, Save As or Open causes Office to hang or freeze for a long period of time. Office can hang or freeze when trying to open or save files on a mapped network device or drive.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Errors & Crashing
  - Reliability
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: V-DARMAC
appliesto: 
  - Office 2010
ms.date: 06/06/2024
---

# Microsoft Office stops responding when you try to open or save a file

## Symptoms

If you perform one of the following procedures in one of the Microsoft Office programs that are listed at the end of this article, the program may stop responding (hang) for a long time:

- You click the **Save in** list in the **Save As** dialog box.   
- You click the **Look in** list in the **Open** dialog box.   

If you click Cancel or try to close the dialog box, the program still does not respond.

## Cause

This problem may occur if any one of the following conditions is true: 

- When the computer is connected to one or more mapped network shares that are nonexistent or that are currently offline.    
- When one or more mapped drives are persistent, and the drive is in a domain that is not trusted.   
- When the mapped drive is located on a slow or a down-level computer. A down-level computer is when the operating system of the computer has an earlier version of Microsoft Windows than the computer that you are using).   
- When a mapped drive is connected across a Wide Area Network (WAN).    
- When a drive is an inaccessible removable drive.

## Resolution

To resolve this issue, you must disconnect all network drives that are have any one of the conditions that are stated in the "Cause" section. To do this, follow these steps.

**Note** Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see the product documentation to complete these steps.

1. Right-click My Computer, and then click **Disconnect Network Drive**.   
2. In the **Disconnect Network Drive** dialog box, click the letter of the drive that you want to disconnect, and then click OK.   
3. Repeat steps 1 and 2 until all offline network drives are disconnected. If you are not sure about a particular drive, follow these steps:
   1. Click Start, and then click Run.   
   2. In the Open box, type the following, and then press ENTER\\computer name\share name

      Where **computer name** is the name of the server that is sharing the resource, and **share name** is the name of the shared resource that you want to use.

      If the resource is not available, you receive an error message that is similar to the following: 

       The network name cannot be found.

Alternatively, you can try to view the contents of the drive in the Windows Explorer.

## Workaround

To work around this behavior, use one of the following methods.

### Method 1: Do not use persistent connections

When you connect a mapped drive, click to clear the **Reconnect at logon** check box. By clearing this check box, the mapped drive will not be connected the next time that you log on to the computer. See the "More Information" section for more information about how to map a network drive.

### Method 2: Use a user logon script 

If you can, use a logon script to connect a user to the appropriate servers every time that the user logs on. Make sure that the script maps the drive in a non persistent state. If the drive is not available as the logon script runs, the drive is not mapped. This behavior prevents the issue.

### Method 3: Use server mirroring

If the connection is over a Wide Area Network (WAN), consider implementing server mirroring. Server mirroring duplicates a distant server locally. Then, map your drive to the local, duplicate server. Doing this can reduce the wait time by connecting to a local server. 

### Method 4: Use a shortcut to the network location

Use a shortcut on the Microsoft Windows desktop or in My Network Places to connect to the network location that you want. 

## More Information

Each location in a list is checked to make sure that it is available and that you have access permissions when you perform both the following procedures in Microsoft Office programs:

- You try to open or to save a file.   
- You access the **Look in** or the **Save In** list.   
 
If any mapped drive is in a state that is documented in the "Cause" section, it takes some time for the condition to be detected and resolved by the Office program. To avoid this behavior, you should disconnect that mapped drive. You can look for the availability of the drive at any time in Windows Explorer. If the drive is available, map the network drive again later. 

To map a drive to a resource that is online again, follow these steps:

1. Right-click My Computer, and then click **Map Network Drive**.   
2. In the Drive box, click the drive letter that you want to use for the network drive.   
3. In the Folder box, type the following \\computer name\share name

   Where **computer name** is the name of the server that is sharing the resource, and **share name** is the name of the shared resource that you want to use.   
4. To make the mapped drive non persistent, click to clear the **Reconnect at logon** check box.   
5. Click Finish.   

If you are trying to connect to resources on other networks, contact the network administrator. Network drives that no longer exist, that are no longer shared, or inaccessible removable drives should be permanently disconnected to avoid affecting the performance of Office products.
