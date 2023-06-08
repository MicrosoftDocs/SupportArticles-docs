---
title: Troubleshoot SMB NetBIOS/FCN limit issues with remote content
description: Introduces how to troubleshoot SMB NetBIOS/FCN limit issues with remote content
ms.date: 04/09/2012
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande, rimarr
---
# Troubleshoot SMB NetBIOS/FCN limit issues with remote content

_Applies to:_ &nbsp; Internet Information Services

This article introduces how to troubleshoot SMB NetBIOS/FCN limit issues with remote content.

## Overview

Before SMB 2.0 we typically would troubleshoot these issues by trying reducing the File Change Notifications (FCNs) IIS/ASP.NET would enlist in and / or increasing the limits via the **MaxCmds** and the **MacMpxct** settings.

Due to an architecture change in SMB 2.0 protocol, the **MaxCmds** and the **MacMpxct** settings no longer apply, and we typically do not see these issues. If you're' running a version of Windows that supports SMB 2.0, verify if this is enabled and the content server also supports this and has it enabled.

## Tools

- [Network Monitor](../../../../windows-server/networking/network-monitor-3.md)

## SMB 2.0 scenarios

The following table shows the version of SMB that will be used in different client/server scenarios. Note that in a remote IIS content scenario the IIS server is the client.

| Client | Server | SMB Version |
| --- | --- | --- |
| Windows Server 2008 / Vista | Windows Server 2008 / Vista | SMB 2.0 |
| Windows Server 2008 / Vista | Windows 2000, XP, 2003 | SMB 1.0 |
| Windows 2000, XP, 2003 | Windows Server 2008 / Vista | SMB 1.0 |
| Windows 2000, XP, 2003 | Windows 2000, XP, 2003 | SMB 1.0 |

To tell what version is being used, use one of these methods:

- In network monitor, check the **Protocol Name** and it will list either SMB for 1.0 or SMB2 for 2.0.

    :::image type="content" source="media/troubleshoot-smb-netbios-fcn-limit-issues/netmon-protocol.png" alt-text="Screenshot of the Network Monitor pane displaying the protocol name types.":::

- If you don't want to depend on the Parsers, locate an `NTCreate` command from the trace. You might see _NT Create AndX_. In the frame details expand the SMB details. For SMB 1.0, the `NTCreate` command offset will be _0xA2_ and in SMB 2.0 if will be _0x5_. The following screenshot shows a sample of an SMB 1.0 representation.

    :::image type="content" source="media/troubleshoot-smb-netbios-fcn-limit-issues/frame-details-smb-command-highlighted.png" alt-text="Screenshot of the Frame Details pane. The S M B Command field is highlighted in the expanded list.":::

- If you are using Windows 2008 or later, and you are not using SMB 2.0, and the backend files server supports this, then it could be disabled. It can be verified by checking the registry location `HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters` for a key `Smb2`. If it's set to _0_ then SM2.0 is disabled.

## SMB 1.0 scenarios

You are typically going to see these in Pre IIS 7.0 -2008 scenarios or when either the client (IIS) or server (UNC share) does not support SMB 2.0. In this case, try to use any or both of the following methods:

- Limit the number of file change monitors that are created by the client (IIS or asp.net).
- Increase the limits supported.

### Increase the limits (MaxCmds and MaxMpxCt)

The limit is a negotiated limit between the client and the server, whenever the lower of **MaxCmds** and **MaxMpxCt** will take effect.

For example, if you have a scenario where on the IIS server you set `MaxCmds = 2000` and on the File Server `MaxMPXCt = 50`, _50_ will be the effective setting.

#### How do I know the effective settings?

Obviously asking is one way, but sometimes the file servers are 3rd party and we cannot verify the settings.

Take the following steps to get the effective setting. You need to capture a network trace during the setup of the SMB connection. It occurs when the content is accessed for the first time.

- Start Network Monitor.
- Reset IIs or Recycling the application pool.
- Access some content over HTTP that resides on the remote file server.
- Stop the network trace.
- In the network trace, look for the files servers response to the NEGOTIATE function.
- Find the MaxMpxCount response from the file Server.
- If the number is lower than the IIS server setting, it's the effective limit.

:::image type="content" source="media/troubleshoot-smb-netbios-fcn-limit-issues/frame-details-maxmpx-count-highlighted.png" alt-text="Screenshot of the Frame Details pane. The Max M P X Count field is highlighted.":::

#### What number should I set the MaxCMds and MaxMpxCt to?

See [Tuning the Servers for UNC Content (IIS 6.0)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd296694(v=ws.10)).

### Reduce the file change monitors

For ASP.NET Content, see [Set Asp.net FCN Mode to reduce ASP.Net FCN monitors](https://support.microsoft.com/kb/911272).

## More information

- [Common Internet File System (CIFS) File Access Protocol](/openspecs/windows_protocols/ms-cifs/d416ff7c-c536-406e-a951-4f04b2fd1d2b)
- [Microsoft SMB Protocol and CIFS Protocol Overview](/windows/win32/fileio/microsoft-smb-protocol-and-cifs-protocol-overview)
- [UNC-based Caching Considerations](/previous-versions/windows/it-pro/windows-server-2003/cc778350(v=ws.10))
- [IIS and File Server Configuration Scenarios for SMB Scaling (IIS 6.0)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd296655(v=ws.10))
- [Two Minute Drill: Overview of SMB 2.0](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd296655(v=ws.10))
