---
title: Limits to using pst files over LAN and WAN links
description: Explains why personal folders files (which store messages locally) are typically unsupported over a LAN or WAN link. To resolve this issue, you can use Exchange Server with local Offline Folders file or Terminal Services instead. An exception in which Outlook 2010 is hosted remotely on a Windows Server 2008 R2 RDSH is included.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: aruiz, cherryc, gbratton, gregmans, sercast
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Office Outlook 2003
  - Windows Server 2008 R2
  - Windows Server 2008
  - Windows 7
  - Windows Server 2003
  - Windows Vista
  - Windows XP
ms.date: 01/30/2024
---
# Limits to using personal folders files over LAN and WAN links

_Original KB number:_ &nbsp; 297019

## Summary

The .pst files aren't meant to be a long-term, continuous-use method of storing messages in an enterprise environment.

This article also suggests three alternatives to .pst files:

- Use Microsoft 365 Exchange Online, Microsoft Exchange Server 2013, or Microsoft Exchange Server 2010 Personal Archive mailboxes.
- Configure Microsoft Outlook in Cached Exchange Mode. This caches Exchange Server mailbox data in a local Offline Folders file.
- Configure Outlook to run on Windows Terminal Services and to connect to the Exchange Server mailbox in Online mode.

Additionally, the one supported scenario for networked .pst files is described in this article. The scenario is using Microsoft Outlook 2010 or later versions remotely on a Windows Server 2008 R2 or later Remote Desktop Session Host (RDSH).

## Personal folders files

The Microsoft Exchange Server 4.0 team created .pst files to let users maintain a copy of their messages on their local computers. The .pst files also serve as a message store for users who don't have access to an Exchange Server computer (for example, POP3 or IMAP email users).

However, .pst files aren't intended as an enterprise network solution. Although it's possible to specify a network directory or a Universal Naming Convention (UNC) path as a storage location for a .pst file, network usage isn't meant to be a long-term, continuous-use method of storing messages in an enterprise environment.

A .pst file is a file-access-driven method of message storage. File-access-driven means that the computer uses special file access commands that the operating system provides to read and write data to the file.

## Behaviors of .pst files over WAN and LAN links

It's not efficient on WAN or LAN links because WAN and LAN links use network-access-driven methods. These are commands that the operating system provides to send data to, or receive from, another networked computer. If there's a remote .pst file (over a network link), Outlook tries to use the file commands to read from the file or write to the file. However, the operating system must then send those commands over the network because the file isn't located on the local computer. This creates lots of overhead and increases the time that is required to read and write to the file. Additionally, the use of a .pst file over a network connection may result in a corrupted .pst file if the connection degrades or fails.

Other behaviors of .pst files over WAN and LAN links

- All operations take longer.
- Write operations can take approximately four times longer than read operations.
- Outlook has slower performance than the Exchange Client.

Because of these behaviors, Offline Folders files and Personal Address Book (.pab) files on a network share that are accessed remotely are also unsupported configurations.

## Recommendations solutions

Microsoft recommends the following solutions. The first three should be used instead of .pst files over a LAN or WAN. The fourth describes an option for using networked .pst files, but only when Outlook 2010 or later versions are hosted remotely on a Windows Server 2008 R2 or later Remote Desktop Session Host.

### Exchange Server 2010 and Exchange Server 2013 Personal Archive mailbox

Personal Archives help you regain control of your organization's messaging data by eliminating the need for personal store files and allowing users to store messages in a Personal Archive mailbox accessible in  Microsoft Outlook 2007 or later versions, and Microsoft Office Outlook Web App.

For more information about Personal Archives, see [Understanding Personal Archives](/previous-versions/office/exchange-server-2010/dd979795(v=exchg.141)).

### Exchange Server with local Offline Folders file

When you're working over a WAN or LAN, it's better to configure Microsoft Outlook in Cached Exchange Mode. This caches the Exchange Server mailbox data in a local Offline Folders file. This configuration lets the remote client work successfully even without being connected to the server. Local Offline Folders files support local replication, and this means that *all* folders and their data can be replicated to Local Offline Folders files, not just email messages, as is the case when you use remote mail. The use of Local Offline Folders file is therefore more efficient and more useful. Local Offline Folders files also don't have a dependency on the availability of the Exchange Server computer (except to synchronize new data from the server to the client and vice versa), because the information is cached in the Local Offline Folders file. This improves performance because the information being viewed is stored on the local drive, while the master copy of the data remains on the server, where it can be accessed and backed up. Local Offline Folders files also provide data redundancy, and this ensures greater integrity and recoverability of the data.

### Microsoft Terminal Services

If an enterprise wants to use Outlook over WAN or LAN links, it's highly efficient to configure Outlook to connect to the Exchange Server mailbox in Online mode while using the Microsoft Windows Terminal Server service. With Terminal Services, only the information that is required to update a display is transferred. The potential benefits in having many remote users based on Terminal Services (instead of using either .pst or .ost files) are significant in any network bandwidth conservation analysis.

### Outlook 2010 or later versions hosted remotely by using Windows Server 2008 R2 or later RDSH or VDI configuration

Outlook 2010 or later versions functionality is supported when networked .pst or .ost files are used under the following conditions:

- A high bandwidth/low latency network connection is used.
- There's single client access per file (one Outlook client per .pst or .ost).
- Either Windows Server 2008 R2 or later Remote Desktop Session Host (RDSH), or Windows Server 2008 R2 or later Virtual Desktop Infrastructure (VDI) is used to run Outlook remotely.

If a specific Outlook feature stops working or the .pst or .ost file becomes corrupt and you can reproduce the issue in the above environment, contact Microsoft Support.

> [!NOTE]
> Customers are responsible for both defining and maintaining adequate network and disk I/O. Microsoft will not assist in troubleshooting slow performance due to *networked*.pst or .ost files. Microsoft will only assist if the performance issue is reproduced while the .pst or .ost file is located on either a hard disk that is physically attached to the computer that is running Outlook, or on a virtual hard disk (VHD) that is attached to the virtual machine that is running Outlook.

> [!IMPORTANT]
> Microsoft programs may not work as expected in a third-party application or software virtualization environment. We do not test Microsoft products that are running in third-party application or software virtualization environments. For more information about support provided by Microsoft for its software running together with non-Microsoft hardware virtualization software, see [Support policy for Microsoft software running in non-Microsoft hardware virtualization software](https://support.microsoft.com/help/897615).

Network scalability guidance that is specific to this configuration can be found in the "Cached Exchange Mode in a Remote Desktop Session Host environment: planning considerations (Outlook 2010)" white paper. Although this document specifically refers to Exchange Cached Mode, the scalability metrics should also apply to other Outlook configurations, assuming the criteria that are mentioned in the preceding list are met. To download this white paper as a Microsoft Word document (.docx), see [Cached Exchange Mode in a Remote Desktop Session Host environment: planning considerations](https://www.microsoft.com/download/details.aspx?id=15238).

### What to consider when you store .pst files

When you store .pst files, shares may stop responding. This behavior may cause several client-side problems, such as causing Outlook to stop responding or freezing desktops on client computers. Queuing in the Server service work queues is what causes this temporary condition. The Server service uses work items, such as a request to extend a .pst file, to handle I/O requests that come in over the network. These work items are queued in the Server service work queues. From there, they're handled by the Server service worker threads. The work items are allocated from a kernel resource that is called the nonpaged pool (NPP). The Server service sends these I/O requests to the disk subsystem. If for reasons that are mentioned earlier, the disk subsystem doesn't respond in time, the incoming I/O requests are queued by using work items in the server work queues. Because these work items are allocated from the NPP, this resource eventually runs out. Running out of NPP causes systems to eventually stop responding and to log event ID 2019.

If you troubleshoot this issue, you can usually find evidence of a problem in Poolmon and Perfmon captures. For example, you may see the LSwn pool tag allocation climb in a Poolmon trace. These allocations are made by the Srv.sys program. The size of the allocation is configurable by using the SizReqBuf registry value. One allocation is made for each work item that is used by the Server service. When you use Perfmon to troubleshoot this issue, you see a steady decrease in the "Available Work Items" counter. If "Available Work Items" reaches zero, clients may be unable to access files. You may also experience event ID 2019 errors if the problem is LSwn allocations (NPP depletion). Another tag that indicates .pst file issues is the MmSt tag. This tag represents the Mm section object prototype PTEs, a memory management-related structure that is used for mapped files. (This is the pool tag that is used to map the operating system memory that is used to track shared files.) MmSt issues frequently manifest as paged pool depletion (Event ID 2020).

### Exchange connectivity and Outlook performance troubleshooting where shared files exist

If the environment contains network shared .pst files, make sure that the following guidelines are followed during troubleshooting:

- These files can't be stored on the same storage media as the files that are used by the Exchange server. This includes core files, databases, and log files.
- These files should be disconnected from the Outlook profile and Outlook should be restarted.

Because of these issues, and the possibility that the shared .pst files may be the cause of client performance issues, the Microsoft Exchange Server, and Microsoft Office Outlook support teams must take these actions when troubleshooting.
