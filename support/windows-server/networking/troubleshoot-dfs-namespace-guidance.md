---
title: Guidance of troubleshooting DFSN
description: Introduces general guidance of troubleshooting scenarios related to DFSN.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfs-namespace, csstroubleshoot
ms.technology: networking
---
# DFSN troubleshooting guidance

Distributed File System Namespace (DFSN) is a Windows technology designed to provide distributed namespace access to file shares across an enterprise.

## Troubleshooting checklist

Examine the SMB traffic to see if the issue is with getting the referral list from the namespace server or connecting to the referred file server. To do so, follow these steps:

First, filter the trace by the SMB traffic for the DFSN IP address. Example filter: `tcp.port==445`.

Then, look for the DFS referral. Follow these steps:

1. The protocol is named DFSC by packet capture parsers. Look for the DFSC traffic in the filtered results or append the filter with `DFSC` in netmon or MA: `tcp.port==445 and DFSC`.
2. The client should send a DFS referral request to the DFSN server. If no DFS referral is being sent, and there's no indication of a firewall or anti-virus block, restart the DFS client to clear any DFS referral caching. Then, start the data collection steps over again.
3. The server should send a DFS referral response to the DFS client.
4. The referral step has completed successfully if a referral list has been returned. Skip to step 4 <!-- What's step 4? --> if the referral process completed successfully.
5. Verify whether the DFS Referral Request arrived at the DFSN server. Standard TCP/IP and firewall troubleshooting applies if the referral doesn't arrive. The most likely cause is the traffic being dropped or blocked somewhere.

   If the referral request arrives but no response is sent:

   1. Make sure the Windows Firewall or another network security application isn't blocking the request.
   2. Verify Active Directory works correctly to troubleshoot the DFSN server.

Look for the DFS client to resolve DNS (assuming it isn't cached) and make a connection to a file server.

1. It's possible that Windows won't attempt to contact a referral if there are other networking issues, such as a DNS resolution failure.
2. To ensure that Windows will perform DNS resolution, you can flush the DNS cache after starting the trace and before reproducing the issue. This operation allows you to verify that DNS resolution is working correctly.
   1. In Windows 8 and later versions of Windows, use PowerShell cmdlet: `Clear-DnsClientCache`.
   2. For previous versions of Windows, run command: `ipconfig flushdns`.

[SMB troubleshooting](/windows-server/storage/file-server/troubleshoot/troubleshooting-smb) applies to fixing the file server connection.

## Common issues and solutions

- [Unsupported DFSN deployment scenario](/troubleshoot/windows-server/networking/support-policy-for-dfsr-dfsn-deployment)
- [Recovery process of a DFSN](/troubleshoot/windows-server/networking/recovery-process-of-dfs-namespace)
- [Troubleshoot DFSN access failures](/troubleshoot/windows-server/networking/dfsn-access-failures)
- [Fail to create a DFSN](/troubleshoot/windows-server/identity/namespace-not-queried-rpc-server-unavailable)
- [DFSNs service and its configuration data](/troubleshoot/windows-server/networking/dfs-namespaces-service-configuration-data)

## Reference

Frequently Asked Questions

- [Distributed File System: Namespace Availability Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341464%28v=ws.10%29)
- [Distributed File System: Namespace Client Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341469%28v=ws.10%29)
- [Distributed File System: Namespace Management Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341474%28v=ws.10%29)
- [Distributed File System: Namespace Scalability and Sizing Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341472%28v=ws.10%29)
- [Distributed File System: Namespace Server Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341468%28v=ws.10%29)
- [Distributed File System: Namespace Site Discovery and Target Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341470%28v=ws.10%29)
