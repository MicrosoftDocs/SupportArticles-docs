---
title: Fail to perform transaction remote receive 
description: This article helps to fix the Access Denied error that occurs when a transactional remote receive is performed on a Message Queuing 4.0 queue in Windows Vista or in Windows Server 2008.
ms.date: 07/24/2020
ms.prod-support-area-path: 
ms.reviewer: gautamm, xinchen, sugoel
---
# Access Denied when you perform transaction remote receive on Message Queuing 4.0 queue

This article helps to fix the **Access Denied** error that occurs when a transactional remote receive is performed on a Microsoft Message Queuing (MSMQ) 4.0 queue in Windows Vista or in Windows Server 2008.

_Original product version:_ &nbsp; Windows Vista, Windows Server 2008  
_Original KB number:_ &nbsp; 2654668

## Symptoms

Consider the following scenario:

- You install MSMQ 4.0 on a computer that is running Windows Vista or Windows Server 2008.
- You create a transactional Message Queuing queue on the computer.
- You run a client application that performs a transactional remote receive on the queue by using the exclusive access mode.

In this scenario, the client application intermittently receives an error message that resembles below:
> Access denied

> [!NOTE]
> This issue occurs even after you restart the application.

## Cause

This issue occurs because MSMQ does not remove the queue handles from the memory correctly when the client application performs the transactional remote receive.

## Hotfix information

A supported hotfix is available from Microsoft. To obtain the hotfix, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support).

However, this hotfix is intended to correct only the problem that is described in this article. Apply this hotfix only to systems that are experiencing the problem described in this article. This hotfix might receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next software update that contains this hotfix.

> [!NOTE]
>
> - If additional issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and issues that do not qualify for this specific hotfix. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, see [Contact Us – Microsoft Support](https://support.microsoft.com/contactus/?ws=support).
> - The **Hotfix download available** form displays the languages for which the hotfix is available. If you do not see your language, it is because a hotfix is not available for that language.

### Prerequisites

To apply this hotfix, you must be running Windows Vista Service Pack 2 (SP2) or Windows Server 2008 Service Pack 2 (SP2). Additionally, you must have Message Queuing 4.0 installed. For more information about how to obtain a Windows Vista service pack, see [Install Windows Vista Service Pack 2 (SP2)](https://support.microsoft.com/help/935791).  

For more information about how to obtain a Windows Server 2008 service pack, see [How to obtain the latest service pack for Windows Server 2008](https://support.microsoft.com/help/968849).

### Registry information

To apply this hotfix, you do not have to make any changes to the registry.

### Restart requirement

You do not have to restart the computer after you apply this hotfix.

### Hotfix replacement information

This hotfix does not replace a previously released hotfix.

### File information

The global version of this hotfix installs files that have the attributes that are listed in the following tables. The dates and the times for these files are listed in Coordinated Universal Time (UTC). The dates and the times for these files on your local computer are displayed in your local time together with your current daylight saving time (DST) bias. Additionally, the dates and the times may change when you perform certain operations on the files.

- Windows Vista and Windows Server 2008 file information notes

  > [!IMPORTANT]
  > Windows Vista hotfixes and Windows Server 2008 hotfixes are included in the same packages. However, only **Windows Vista** is listed on the **Hotfix Request** page. To request the hotfix package that applies to one or both operating systems, select the hotfix that is listed under **Windows Vista** on the page. Always refer to the **Applies To** section in articles to determine the actual operating system that each hotfix applies to.

  - The files that apply to a specific product, SR_Level (RTM, SP*n*), and service branch (LDR, GDR) can be identified by examining the file version numbers as shown in the following table.

    | Version                        | Product                               | SR_Level | Service branch |
    |--------------------------------|---------------------------------------|----------|----------------|
    | 6.0.600<br/> 2 .<br/> 22 *xxx* | Windows Vista and Windows Server 2008 | SP2      | LDR            |
    |                                |                                       |          |                |

  - The MANIFEST files (.manifest) and the MUM files (.mum) that are installed for each environment are listed separately in the [Additional file information](#additional-file-information) section. MUM files and MANIFEST files, and the associated security catalog (.cat) files, are important to maintaining the state of the updated component. The security catalog files, for which the attributes are not listed, are signed with a Microsoft digital signature.

- For all supported x86-based versions of Windows Server 2008 and of Windows Vista

  | File name | File version   | File size | Date        | Time  | Platform |
  |-----------|----------------|-----------|-------------|-------|----------|
  | Mqqm.dll  | 6.0.6002.22774 | 931,328   | 09-Jan-2012 | 15:32 | x86      |
  |           |                |           |             |       |          |

- For all supported x64-based versions of Windows Server 2008 and of Windows Vista

  | File name | File version   | File size | Date        | Time  | Platform |
  |-----------|----------------|-----------|-------------|-------|----------|
  | Mqqm.dll  | 6.0.6002.22774 | 1,520,128 | 09-Jan-2012 | 18:26 | x64      |
  |           |                |           |             |       |          |

- For all supported IA-64-based versions of Windows Server 2008

  | File name | File version   | File size | Date        | Time  | Platform |
  |-----------|----------------|-----------|-------------|-------|----------|
  | Mqqm.dll  | 6.0.6002.22774 | 3,009,536 | 09-Jan-2012 | 15:04 | IA-64    |
  |           |                |           |             |       |          |

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the [Applies to](#applies-to) section.

## More information

For more information about a similar issue that occurs in Windows 7 or in Windows Server 2008 R2, see [High memory usage by the Message Queuing service when you perform a remote transactional read on a Message Queuing 5.0 queue in Windows 7 or in Windows Server 2008 R2](https://support.microsoft.com/help/2566230).

For more information about transactional remote receive, see [Transactional Remote Receive](/previous-versions/windows/desktop/legacy/ms700128(v=vs.85)).

For more information about software update terminology, see [Description of the standard terminology that is used to describe Microsoft software updates](https://support.microsoft.com/help/824684).

### Additional file information

- Additional files for all supported x86-based versions of Windows Vista and of Windows Server 2008

  |File name|File version|File size|Date (UTC)|Time (UTC)|
  |---|---|---|---|---|
  |Update.mum|Not applicable|2,795|09-Jan-2012 |20:11|
  |X86_c1405dd11ac0d934ee6b23f26ededc0b_31bf3856ad364e35_<br/>6.0.6002.22774_none_01fc21a3e690a8d8.manifest|Not applicable|710|09-Jan-2012|20:11|
  |X86_microsoft-windows-msmq-queuemanager-core_31bf3856ad364e35_<br/>6.0.6002.22774_none_81e055217612a96b.manifest|Not applicable|9,378|09-Jan-2012|16:02|

- Additional files for all supported x64-based versions of Windows Vista and of Windows Server 2008

  |File name|File version|File size|Date (UTC)|Time (UTC)|
  |---|---|---|---|---|
  |Amd64_c13315506438db7dd12b9e290856df97_31bf3856ad364e35_<br/>6.0.6002.22774_none_d5f948d71828e1ef.manifest|Not applicable|714|09-Jan-2012|20:11|
  |Amd64_microsoft-windows-msmq-queuemanager-core_31bf3856ad364e35_<br/>6.0.6002.22774_none_ddfef0a52e701aa1.manifest|Not applicable|9,706|09-Jan-2012|18:44|
  |Update.mum |Not applicable|2,817|09-Jan-2012|20:11|

- Additional files for all supported IA-64-based versions of Windows Server 2008

  |File name|File version|File size|Date (UTC)|Time (UTC)|
  |---|---|---|---|---|
  |Ia64_5c4af70a31d9670a1da220c06be3a2d8_31bf3856ad364e35_<br/>6.0.6002.22774_none_2f54071bed908687.manifest|Not applicable|712|09-Jan-2012|20:11|
  |Ia64_microsoft-windows-msmq-queuemanager-core_31bf3856ad364e35_<br/>6.0.6002.22774_none_81e1f9177610b267.manifest|Not applicable|9,684|09-Jan-2012|15:20|
  |Update.mum|Not applicable|1,578|09-Jan-2012|20:11|

## Applies to

- Windows Vista Business
- Windows Vista Business 64-bit Edition
- Windows Vista Enterprise
- Windows Vista Enterprise 64-bit Edition
- Windows Vista Home Basic
- Windows Vista Home Basic 64-bit Edition
- Windows Vista Home Premium
- Windows Vista Home Premium 64-bit Edition
- Windows Vista Starter
- Windows Vista Ultimate
- Windows Vista Ultimate 64-bit Edition
- Windows Server 2008 Datacenter
- Windows Server 2008 Datacenter without Hyper-V
- Windows Server 2008 Enterprise
- Windows Server 2008 Enterprise without Hyper-V
- Windows Server 2008 for Itanium-Based Systems
- Windows Server 2008 Foundation
- Windows Server 2008 Standard
- Windows Server 2008 Standard without Hyper-V
- Windows Server 2008 Web Edition
