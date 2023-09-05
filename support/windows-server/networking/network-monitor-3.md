---
title: Information about Network Monitor 3
description: Discusses Network Monitor 3. Contains download and support information, installation notes, and general usage information.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Information about Network Monitor 3

This article contains download and support information, installation notes, and general usage information about Network Monitor 3.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 933741

## Summary

This article contains information about Microsoft Network Monitor 3. Network Monitor 3 is a protocol analyzer. It enables you to capture, to view, and to analyze network data. You can use it to help troubleshoot problems with applications on the network.

This article contains download and support information, installation notes, and general usage information about Network Monitor 3. Network Monitor 3.4 is the latest version.

## Key features of Network Monitor 3

Network Monitor 3 is a complete overhaul of the earlier Network Monitor 2. **x** version. Some key features of Network Monitor 3 include the following:

- Script-based parser model with frequent updates
- Concurrent live capture sessions
- Support for Windows 7
- Support for 32-bit platforms and for 64-bit platforms
- Support for network conversations and process tracking
- API to access capture and parsing engine
- Wireless Monitor Mode Capturing

## Download and support information

Download the latest version of Network Monitor, [Network Monitor 3.4](https://www.microsoft.com/download/details.aspx?id=4865).

Support information for Network Monitor 3.4 is located at [this forum] (https://social.technet.microsoft.com/Forums/home?forum=netmon).

## Installation notes

Network Monitor 3.4 can co-exist with Network Monitor 2.x. By default, Network Monitor 3.4 is installed in the `%Program Files%\Microsoft Network Monitor 3` folder. Therefore, conflicts do not occur if an earlier version is installed in a different folder on the computer. When you install Network Monitor 3.4, any previous version of Network Monitor 3 is uninstalled.

Network Monitor 3.4 includes a new driver for Windows Vista, Windows Server 2008, and Windows 7. This new driver supports new features of the Network Driver Interface Specification (NDIS) 6.0 driver. If you are using tools that rely on Network Monitor 2. **x** NPPTools, the tools will no longer work. To capture network data in Windows Vista, you must use Network Monitor 3.4. Network Monitor 2. **x** does not capture network data correctly in Windows Vista.

Suggested hardware to run Network Monitor 3.4 is listed as follows:

- 1 GHz or faster processor
- 1 GB or more memory
- 60 MB available space on the hard disk, and additional hard disk space to store capture files

Network Monitor 3.4 is supported on the following operating systems:

- Windows 7
- Windows 2008 Server
- Windows Vista
- Windows XP
- Windows Server 2003

### Warnings and cautions

Currently, we do not recommend that you run Network Monitor 3 on production systems where the extra load could affect the performance. In scenarios where load is something to consider, use the command-line version of Network Monitor 3 to capture network data. The command-line version is Nmcap.exe. For more information about Nmcap.exe, see the Nmcap.exe command-line tool in the [General usage](#general-usage) section.

Network Monitor 3 may consume lots of system resources. Some things to consider are listed as follows.

- Disk space

    When you start a capture session, Network Monitor 3 stores frames in a sequence of capture files that are located in the \Temp folder. By default, the size of each capture file is 20 MB. By default, if you do not stop the capture session, Network Monitor 3 continues to store capture files in the \Temp folder until the available hard disk space on the computer is less than 2 percent. Then, Network Monitor 3 stops the capture session.

    You can configure the capture file size, the location where the capture files are stored, the available hard disk space limit, and other capture options. To do this, on the **Tools** menu, point to **Options**, and then click the **Capture** tab.

- Memory use

    In addition to capturing data, Network Monitor 3 assigns properties to frames, and then uses the properties to group the frames into conversations. Network Monitor 3 displays the conversations and the associated frames in a tree structure in the **Network Conversations** pane.

    The Conversations feature of Network Monitor 3 significantly increases memory use. This may cause the computer to become unresponsive. By default, the Conversations feature is turned on. Some higher-level protocol filters require conversation properties. To turn off the Conversations feature, point to **Options** on the **Tools** menu, click the **Capture** tab, and then click to clear the **Enable Conversations** check box.

- Processor utilization

    The Conversations feature of Network Monitor 3 may significantly increase processor utilization when lots of frames are processed. By default, the Conversations feature is turned off, as mentioned in the "Memory use" section.

## General usage

General usage information for Network Monitor 3 is listed as follows.

- Capture network data

    As mentioned earlier, Network Monitor 3 may consume lots of system resources. Therefore, if you want to minimize the effect on system resources that may occur when you use Network Monitor 3 to capture data, use the Nmcap.exe command-line tool to capture data.

    Network Monitor 3 enables you to collect network data and to view the network data in real time as the data is captured. To start a capture session in Network Monitor 3, click the **Start Page** tab, click **Create a new capture tab**, and then either click the **Start Capture** button, or press F10.

- Filters

    Network Monitor 3 uses a simple syntax that is expression-based to filter frames. All frames that match the expression are displayed to the user. For more information about filters, do any of the following:
      - View the topics in the **Use Filters** section of the Network Monitor 3 User's Guide. To do this, on the **Help** menu, click **Contents and SDK**, and then double-click **Using Filters**.
      - On the **Help** menu, point to **How Do I**, and then click **Use Filters**.
      - Use the **Capture Filter** tab or the **Display Filter** tab to view standard filters.

- Conversations

    By default, the Conversations feature is now turned on. The Conversations feature can consume lots of memory, especially in scenarios when you capture data for long periods of time. To turn off the Conversations feature, click **Options** on the **Tools** menu, and then click to clear the **Enable Conversations** check box on the **Capture** tab.

    When the Conversations feature is turned on, frames are grouped and displayed in the **Network Conversations** pane in a tree structure according to the conversations to which they belong, together with the process information. For example, TCP data that uses the same source port and the same destination port is organized into a group. When you click a node in the **Network Conversations** pane, the corresponding conversation filter is automatically applied to the frames in the **Frame Summary** pane. Only frames that belong to that particular conversation are displayed.

- Nmcap.exe command-line tool

    The Nmcap.exe command-line tool enables you to configure when you want to start a capture session or to stop a capture session. You can also use the Nmcap.exe command-line tool to create chained captures. Chained captures enable you to create multiple capture files. However, the size of the capture files remains small. Currently, NMCap cannot save process information.

- Network Parsing Language (NPL)

    Network Monitor 3 parsers are written in a language specifically to make parser development more straightforward. This also provides a level of protection against potential exploitation from malicious code that may occur if parsers were created as DLL files. NPL provides access to parsers. You can view or change the parsers that are included in Network Monitor 3.

## Common issues

Common issues include the following:

- Protocols may not parse correctly. This issue may occur if either of the following conditions is true:
  - The Conversations feature is turned off.

    Certain protocols depend on conversation properties to store state values that may be needed in later frames. For example, TCP needs conversations to store information about retransmitted frames. The filter for TCP Retransmits will not work unless the Conversations feature is enabled.

    Similarly, the Server Message Block (SMB) protocol cannot translate the response to a Transact command, because the response does not contain the original command. The information is saved in conversation properties.

- Full parsers may not be enabled. By default, we enable a subset of the full parsers for performance reasons. To enable the full set, follow these steps:
    1. On the **Tools** menu, click **Options**.
    2. Click the **Parser** tab.
    3. Select the **Windows** row, and then click the **Stubs** button until the **Set** column displays **Full**.

- You receive one of the following error messages when you run Network Monitor 3 on a Windows Vista-based computer:

  - Error message 1:

    > None of the network adapters are bound to the Netmon driver

  - Error message 2:
  
    > This network adapter is not configured to capture with Network Monitor

    This issue occurs if either of the following conditions is true:
    - You are not running Network Monitor 3 as administrator.
    - You are not a member of the Netmon Users group.

    When you first install Network Monitor 3 on Windows Vista or later versions, we add the installers account to the Netmon Users group. But this does not take effect until you log off and then log back in. If you need to take a capture immediately, you can run Network Monitor 3 as administrator.

    For more information, see the Network Monitor 3 releases notes or see the **Operating on Windows Vista** topic in Network Monitor 3 Help.

## References

- [Network Monitor Forum](https://social.technet.microsoft.com/Forums/home?forum=netmon)
- [Network Monitor Open Source Parsers](https://archive.codeplex.com/?p=NMParsers)
