---
title: "Troubleshooting SMB NetBIOS/FCN limit issues with Remote Content"
author: rick-anderson
description: "Tools Used in this Troubleshooter: Network Monitor This material is provided for informational purposes only. Microsoft makes no warranties, express or impli..."
ms.date: 04/09/2012
ms.assetid: db45d74e-0265-4936-aec6-c71966f7d987
msc.legacyurl: /learn/troubleshoot/performance-issues/troubleshooting-smb-netbios-fcn-limit-issues-with-remote-content
msc.type: authoredcontent
---
# Troubleshooting SMB NetBIOS/FCN limit issues with Remote Content

by Richard Marr

## Tools Used in this Troubleshooter

- Network Monitor

This material is provided for informational purposes only. Microsoft makes no warranties, express or implied.

## Overview

Before SMB 2.0 we typically would troubleshoot these issues by trying a combination of reducing the FCNs (File Change Notifications) IIS/ASP.NET would enlist in and OR/ increase the limits via the **MaxCmds** and the **MacMpxct** settings.

Due to an architecture change in SMB 2.0 protocol, the MaxCmds and the MacMpxct settings no longer apply, and we typically do not see these issues. If your customer is running a version of Windows that supports 2.0 you will want to verify if this is enabled and the content server also supports this and has it enabled.

## SMB 2.0 Scenarios

The table below shows the version of SMB that will be used in different client / server scenarios. Note in a remote IIS content scenario the IIS server is the client.

| Client | Server | SMB Version |
| --- | --- | --- |
| Windows Server 2008 / Vista | Windows Server 2008 / Vista | SMB 2.0 |
| Windows Server 2008 / Vista | Windows 2000, XP, 2003 | SMB 1.0 |
| Windows 2000, XP, 2003 | Windows Server 2008 / Vista | SMB 1.0 |
| Windows 2000, XP, 2003 | Windows 2000, XP, 2003 | SMB 1.0 |

How Can I tell what version is being used?

In network monitor you can look at the "Protocol Name" and it will list either SMB for 1.0 or SMB2 for 2.0.

![Screenshot of the Network Monitor pane displaying the protocol name types.](troubleshooting-smb-netbios-fcn-limit-issues-with-remote-content/_static/image1.png)

Or if you don't want to depend on the Parsers you can use this trick the networking team shared with me. From the trace locate an NTCreate command. You might this NT Create AndX. In the frame details expand the SMB details. For SMB 1.0 the NTCreate command offset will be 0xA2 and in SMB 2.0 if will be 0x5. . Below is sample of an SMB 1.0 representation.

![Screenshot of the Frame Details pane. The S M B Command field is highlighted in the expanded list. ](troubleshooting-smb-netbios-fcn-limit-issues-with-remote-content/_static/image3.png)

If you are using Windows 2008 or later and you are not using SMB 2.0 and the backend files server supports this then it could be disabled.

This can be verified by checking the following registry location. `HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters` for a key `Smb2`

If its set = 0 then SM2.0 is disabled.

## SMB 1.0 Scenarios

You are typically going to see these in Pre IIS 7.0 -2008 scenarios or when either the client (IIS) or server (UNC share) does not support 2.0. In this case you need to go through the exercise of trying to limit the # of file change monitors that are created by the client (IIS or asp.net) and /or increasing the limits supported.

**Increasing the Limits (MaxCmds and MaxMpxCt)**

The limit is a negotiated limit between the client and the server, whenever the lower of **MaxCmds** and **MaxMpxCt** will take effect.

For example if you have a scenario where on the IIS server you set MaxCmds = 2000 and on the File Server MaxMPXCt = 50, 50 will be the effective setting.

How Do I know the effective settings?

Obviously asking is one way, but sometimes the file servers are 3rd party and we cannot verify the settings.

To verify this you will need to capture a network trace during the setup of the SMB connection, this occurs when the content is accessed for the first time

- Start Network Monitor
- Reset IIs or Recycling the application pool
- Access some content over http that resides on the remote file server
- Stop the network trace

In the network trace you are looking for the files servers response to the NEGOTIATE function. In this you will find the MaxMpxCount response from the file Server. If this is lower than the IIS server setting this will be the effective limit, so in the example above it will be 50

![Screenshot of the Frame Details pane. The Max M P X Count field is highlighted.](troubleshooting-smb-netbios-fcn-limit-issues-with-remote-content/_static/image5.png)

What # should I set the MaxCMds and MaxMpxCt to? See the following reference.

[Tuning the Servers for UNC Content (IIS 6.0)](https://technet.microsoft.com/library/dd296694(WS.10).aspx)

**Reducing the File Change Monitors**

IIS Content

2494628 How to configure IIS 7 to limit File Access for Change notifications on UNC Shares (`https://vkbexternal.partners.extranet.microsoft.com/VKBWebService/ViewContent.aspx?scid=B;2494628`)

ASP.NET Content

[Set Asp.net FCN Mode to reduce ASP.Net FCN monitors](https://support.microsoft.com/kb/911272)

### Other Resources

- [Common Internet File System (CIFS) File Access Protocol](/openspecs/windows_protocols/ms-cifs/d416ff7c-c536-406e-a951-4f04b2fd1d2b)
- [Microsoft SMB Protocol and CIFS Protocol Overview](https://msdn.microsoft.com/library/aa365233(v=VS.85).aspx)
- [UNC-based Caching Considerations](https://technet.microsoft.com/library/cc778350(WS.10).aspx)
- [IIS and File Server Configuration Scenarios for SMB Scaling (IIS 6.0)](https://technet.microsoft.com/library/dd296655(WS.10).aspx)
- [Two Minute Drill: Overview of SMB 2.0](https://techcommunity.microsoft.com/t5/ask-the-performance-team/two-minute-drill-overview-of-smb-2-0/ba-p/373098)
