---
title: Office cannot check in files 
description: Fixes an issue in which Office cannot check in files when LAN does not have Internet access
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
appliesto:
- Office 2013
---

# Office 2013 cannot check in files when LAN does not have Internet access or over some VPNs

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

In cases where the VPN causes this issue, we have found an issue in Windows code (113100710844135), the fix is out [Third-party VPN client stops Internet connectivity in Windows 7 SP1 or Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2964643). We have verified that Palo Alto Networks Global Protect Client, and Juniper VPN work with this fix.

Customers are using third-party VPN solutions on Windows 7. If customers migrate to Office 2013 from an older version of Office, they may experience functionality loss in Office when connected via VPN. Office 2013 took a dependency on NLA (Network Location Awareness), and some VPN solutions do not work properly with NLA. Specifically, if the VPN software does not define a default gateway. In this case, NLA will always report that the client is not connected to the Internet. This impacts Office2013 since it depends on Internet connectivity for some functions. For example, there is no help file on the machine, and all help is on the Internet. If a customer presses F1 in an Office 2013 application, they will always get an error that says they are not connected to the Internet while connected via VPN.

## Symptoms

Users without full Internet access may not be able to check in files from the Office 2013 client, even though there is good connection between the Office client and the SharePoint server.

## Cause

There was a design change between Office 2010 and 2013, where 2013 now requires an Internet connection for some activities. Some customers have already complained about this issue and the product group has been informed of the design limitations. (but no hotfix is currently in the works, a hotfix may not be possible this looks to be a significant change)

The root of the issue seems to be that Office 2013 has a dependency on NLA (Network Location Awareness). NLA uses probes to determine if the network connection has "Internet Access". The way that is does this be two ways.

1. It does a DNS probe for `dns.msftncsi.com`. It expects a specific response. The response must be `131.107.255.255`. If it is, then that is the correct DNS probe.
1. It attempts to connect to `https://www.msftncsi.com` and attempts to retrieve the file ncsi.txt. Inside the file, the text must be "Microsoft NCSI".

If both of the above conditions are met, then the connection is marked as having Internet connectivity, if not the connection is marked has having no Internet connectivity and some Office features will not work.

## Workaround

It is possible to set up a local NCIS server (Network Connection Status Indicator) on your LAN that will respond to the Office Clients requests and allow the Office feature to work.

See posts below for related information and directions:

- [What do Microsoft and NCSI have in common?](https://www.techrepublic.com/blog/data-center/what-do-microsoft-and-ncsi-have-in-common/)
- [The Network Connection Status Icon](https://web.archive.org/web/20150316185207/http://blogs.technet.com/b/networking/archive/2012/12/20/the-network-connection-status-icon.aspx)
