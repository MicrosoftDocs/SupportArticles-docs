---
title: TCP traffic stops
description: Describes a problem that occurs when you enable both receive-side scaling and Internet Connection Sharing. To resolve this problem, disable either receive-side scaling or Internet Connection Sharing.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bburgin
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# TCP traffic stops after you enable both receive-side scaling and Internet Connection Sharing in Windows Vista or in Windows Server 2003 with Service Pack 1 or Service Pack 2

This article provides a solution to an issue that TCP traffic stops after you enable both receive-side scaling and Internet Connection Sharing.

_Applies to:_ &nbsp; Windows Vista, Windows Server 2003  
_Original KB number:_ &nbsp; 927168

## Problem description

After you enable both receive-side scaling and Internet Connection Sharing, TCP traffic stops. For example, the ping command does not work.

This problem occurs if the computer is running one of the following operating systems:

- Windows Server 2003 with Service Pack 1 (SP1) and the Windows Server 2003 Scalable Networking Pack installed
- Windows Server 2003 with Service Pack 2 (SP2)
- Windows Vista

## Cause

This problem occurs because receive-side scaling and Internet Connection Sharing are mutually exclusive.

## Resolution

To resolve this problem, disable either receive-side scaling or Internet Connection Sharing. Do not enable both receive-side scaling and Internet Connection Sharing at the same time.

### How to disable receive-side scaling in Windows Server 2003

To disable receive-side scaling in the network adapter driver in Windows Server 2003, follow these steps:

1. Click **Start**, click **Run**, type ncpa.cpl, and then click **OK**.
2. Right-click a network adapter object, and then click **Properties**.
3. Click **Configure**, and then click the **Advanced** tab.
4. In the **Property** list, click **Receive Side Scaling**, click **Disable** in the **Value** list, and then click **OK**.
5. Repeat steps 2 through 4 for each network adapter object.

### How to determine whether receive-side scaling is enabled in Windows Vista

To determine whether receive-side scaling is enabled in Windows Vista, type the following command at a command prompt:  
    netsh interface tcp show global

Output will be displayed that resembles the following:

```console
    Querying active state...

    TCP Global Parameters
    ----------------------------------------------
    Receive-Side Scaling State          : enabled
    [...]
```

### How to disable receive-side scaling in Windows Vista

To disable receive-side scaling, you have to type the following command at a command prompt:  
    netsh interface tcp set global rss=disabled

### Fix it for me

If you want us to do this for you automatically, click the **Fix this problem** link. Then click **Run** in the **File Download** dialog box, and follow the steps in this wizard.

> [!NOTE]
> This wizard may be in English only; however, the automatic fix also works for other language versions of Windows.

> [!NOTE]
> If you are not on the computer that has the problem, you can save the automatic fix to a flash drive or to a CD, and then you can run it on the computer that has the problem.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
