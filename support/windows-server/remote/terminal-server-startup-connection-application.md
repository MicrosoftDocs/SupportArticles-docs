---
title: Terminal Server startup, connection, and application
description: Describes the initialization process of a Terminal Server and describes what occurs when a user connects to the server and runs an application.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:administration, csstroubleshoot
ms.subservice: rds
---
# Terminal Server Walkthrough: Startup, Connection, and Application

This article describes the initialization process of a Terminal Server and describes what occurs when a user connects to the server and runs an application.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186572

## Windows Terminal Server Initialization

As the Windows Terminal Server boots and loads the core operating system, the Terminal Server service (Termsrv.exe) is started and creates listening stacks (one per protocol and transport pair) that listen for incoming connections. Each connection is given a unique session identifier or "SessionID" to represent an individual session to the Terminal Server. Each process created within a session is "tagged" with the associated SessionID to differentiate its namespace from any other connection's namespace.

The console (Terminal Server keyboard, mouse, and video) session is always the first to load, and is treated as a special-case client connection and assigned SessionID. The console session starts as a normal Windows NT system session with the configured Windows NT display, mouse, and keyboard drivers loaded.

The Terminal Server service then calls the Windows NT Session Manager (Smss.exe) to create two (default = 2) idle client sessions (after creating the console session) that await client connections. To create the idle sessions, the Session Manager executes the Windows NT-based client/server runtime subsystem process (Csrss.exe), and a new SessionID is assigned to that process. The CSRSS process will also invoke the Winlogon (Winlogon.exe) process and the Win32k.sys (Window Manager and graphics device interface - GDI) kernel module under the newly associated SessionID. The modified Windows NT image loader will recognize this Win32k.sys as a SessionSpace-loadable image by a predefined bit set in the image header. It will then relocate the code portion of the image into physical memory, with pointers from the virtual kernel address space for that session, if Win32k.sys has not already been loaded. By design, it will always attach to a previously loaded image's code (Win32k.sys) if one already exists in memory. For example, from any active application or session.

The data (or non-shared) section of this image will then be allocated to the new session from a newly created SessionSpace pageable kernel memory section. Unlike the console session, Terminal Server Client sessions are configured to load separate drivers for the display, keyboard, and mouse.

The new display driver is the Remote Desktop Protocol (RDP) display device Driver, Tsharedd.dll. The mouse and keyboard drivers communicate into the stack through the multiple instance stack manager, termdd.sys. Termdd.sys will send the messages for mouse and keyboard activity to and from the RDP driver, Wdtshare.sys. These drivers allow the RDP client session to be remotely available and interactive. Finally, Terminal Server will also invoke a connection listener thread for the RDP protocol, again managed by the multiple instance stack manager (Termdd.sys), which listens for RDP client connections on TCP port number 3389.

At this point, the CSRSS process exists under its own SessionID namespace, with its data instantiated per process as necessary. Any processes created from within this SessionID will execute within the SessionSpace of the CSRSS process automatically. This prevents processes with different SessionIDs from accessing another session's data.

## Client Connection

The RDP client can be installed and run on any Windows-based terminal (based on WinCE), Windows for Workgroups 3.11 running TCP/IP-32b, or the Microsoft Win32 API-based platform. Non-Windows-based clients are supported by the Citrix Metaframe add-on. The Windows for Workgroups RDP client's executable file is approximately 70 KB in size, uses a 300 KB working set, and uses 100 KB for display data. The Win32-based client is approximately 130 KB in size, uses a 300 KB working set and 100 KB for display data.

The client will initiate a connection to the Terminal Server through TCP port 3389. The Terminal Server RDP listener thread will detect the session request, and create a new RDP stack instance to handle the new session request. The listener thread will hand over the incoming session to the new RDP stack instance and continue listening on TCP port 3389 for further connection attempts. Each RDP stack is created as the client sessions are connected to handle negotiation of session configuration details. The first details will be to establish an encryption level for the session. The Terminal Server will initially support three encryption levels: low, medium, and high.

Low encryption will encrypt only packets being sent from the client to the Terminal Server. This "input only" encryption is to protect the input of sensitive data, such as a user's password. Medium encryption will encrypt outgoing packets from the client the same as low-level encryption, but will also encrypt all display packets being returned to the client from the Terminal Server. This method of encryption secures sensitive data, as it travels over the network to be displayed on a remote screen. Both low and medium encryption use the Microsoft-RC4 algorithm (modified RC4 algorithm with improved performance) with a 40-bit key. High encryption will encrypt packets in both directions, to and from the client, but will use the industry standard RC4 encryption algorithm, again with a 40-bit key. A non- export version of Windows NT Terminal Server will provide 128-bit high- level RC4 encryption.

A font exchange will occur between the client and server to determine which common system fonts are installed. The client will notify the Terminal Server of all installed system fonts, to enable faster rendering of text during an RDP session. When the Terminal Server knows what fonts the client has available, you can save network bandwidth by passing compressed font and Unicode character strings, rather than larger bitmaps, to the client.

By default, all clients reserve 1.5 MB of memory for a bitmap cache that is used to cache bitmaps, such as icons, toolbars, cursors, and so on, but is not used to hold Unicode strings. The cache is tunable (through a registry key) and overwritten using a Least Recently Used (LRU) algorithm. The Terminal Server also contains buffers to enable flow-controlled passing of screen refreshes to clients, rather than a constant bitstream. When user interaction at the client is high, the buffer is flushed at approximately 20 times per second. During idle time, or when there is no user interaction, the buffer is slowed to only flush 10 times per second. You can tune all these numbers through the registry.

After session details have been negotiated, the server RDP stack instance for this connection will be mapped to an existing idle Win32k user session, and the user will be prompted with the Windows NT logon screen. If autologon is configured, the encrypted username and password will be passed to the Terminal Server, and logon will proceed. If no idle Win32k sessions currently exist, the Terminal Server service will call the Session Manager (SMSS) to create a new user space for the new session. Much of the Win32k user session is utilizing shared code and will load noticeably faster after one instance has previously loaded.

After the user types a username and password, packets are sent encrypted to the Terminal Server. The Winlogon process then performs the necessary account authentication to ensure that the user has privilege to log on and passes the user's domain and username to the Terminal Server service, which maintains a domain/username SessionID list. If a SessionID is already associated with this user (for example, a disconnected session exists), the currently active session stack is attached to the old session. The temporary Win32 session used for the initial logon is then deleted. Otherwise the connection proceeds as normal and the Terminal Server service creates a new domain/username SessionID mapping. If for some reason more than one session is active for this user, the list of sessions is displayed and the user decides which one to select for reconnection.

## Running an Application

After user logon, the desktop (or application if in single-application mode) is displayed for the user. When the user selects a 32-bit application to run, the mouse commands are passed to the Terminal Server, which launches the selected application into a new virtual memory space (2-GB application, 2-GB kernel). All processes on the Terminal Server will share code in kernel and user modes wherever possible. To achieve the sharing of code between processes, the Windows NT Virtual Memory (VM) manager uses copy-on-write page protection. When multiple processes want to read and write the same memory contents, the VM manager will assign copy-on-write page protection to the memory region. The processes (Sessions) will use the same memory contents until a write operation is performed, at which time the VM manager will copy the physical page frame to another location, update the process's virtual address to point to the new page location and now mark the page as read/write. Copy-on-write is useful and efficient for applications running on a Terminal Server.

When a Win32-based application such as Microsoft Word is loaded into physical memory by one process (Session), it is marked as copy-on-write. When new processes (Sessions) also invoke Word, the image loader will just point the new processes (Sessions) to the existing copy because the application is already loaded in memory. When buffers and user-specific data is required (for example, saving to a file), the necessary pages will be copied into a new physical memory location and marked as read/write for the individual process (Session). The VM manager will protect this memory space from other processes. Most of an application, however, is shareable code and will only have a single instance of code in physical memory no matter how many times it is run.

It is preferable (although not necessary) to run 32-bit applications in a Terminal Server environment. The 32-bit applications (Win32) will allow sharing of code and run more efficiently in multi-user sessions. Windows NT allows 16-bit applications (Win16) to run in a Win32 environment by creating a virtual MS-DOS-based computer (VDM) for each Win16 application to execute. All 16-bit output is translated into Win32 calls, which perform the necessary actions. Because Win16 apps are executing within their own VDM, code cannot be shared between applications in multiple sessions. Translation between Win16 and Win32 calls also consumes system resources. Running Win16 applications in a Terminal Server environment can potentially consume twice the resources than a comparable Win32-based application will.

## Session Disconnect and User Logoff

### Session Disconnect

If a user decides to disconnect the session, the processes and all virtual memory space will remain and be paged off to the physical disk, if physical memory is required for other processes. Because the Terminal Server keeps a mapping of domain/username and its associated SessionID, when the same user reconnects, the existing session will be loaded and made available again. An additional benefit of RDP is that it is able to change session screen resolutions, depending on what the user requests for the session. For example, suppose a user had previously connected to a Terminal Server session at 800 x 600 resolution and disconnected. If the user then moves to a different computer that supports only 640 x 480 resolution, and reconnects to the existing session, the desktop will be redrawn to support the new resolution.

## User Logoff

Logoff is typically simple to implement. After a user logs off from the session, all processes associated with the SessionID are terminated, and any memory allocated to the session is released. If the user is running a 32-bit application such as Microsoft Word, and logs off from the session, the code of the application itself would remain in memory until the last user exited from the application.
