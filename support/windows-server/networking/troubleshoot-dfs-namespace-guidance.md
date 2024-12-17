---
title: Guidance for troubleshooting DFS Namespace
description: Introduces general guidance for troubleshooting scenarios related to DFS Namespace.
ms.date: 09/27/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# DFS Namespace troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31941548" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DFS-Namespace issues.

Distributed File System (DFS) Namespace is a Windows technology designed to provide distributed namespace access to file shares across an enterprise.

## Troubleshooting checklist

Examine the SMB traffic to see if the issue is with getting the referral list from the namespace server or connecting to the referred file server. To do so, follow these steps:

First, filter the trace by the SMB traffic for the DFS Namespace IP address. Example filter: `tcp.port==445`.

Then, look for the DFS referral. Follow these steps:

1. The protocol is named DFSC by packet capture parsers. Look for the DFSC traffic in the filtered results or append the filter with `DFSC` in netmon or MA: `tcp.port==445 and DFSC`.
2. The client should send a DFS referral request to the DFS Namespace server. If no DFS referral is being sent, and there's no indication of a firewall or anti-virus block, restart the DFS client to clear any DFS referral caching. Then, start the data collection steps over again.
3. The server should send a DFS referral response to the DFS client.
4. The referral step has completed successfully if a referral list has been returned. Skip to step 4 <!-- What's step 4? --> if the referral process completed successfully.
5. Verify whether the DFS Referral Request arrived at the DFS Namespace server. Standard TCP/IP and firewall troubleshooting applies if the referral doesn't arrive. The most likely cause is the traffic being dropped or blocked somewhere.

   If the referral request arrives but no response is sent:

   1. Make sure the Windows Firewall or another network security application isn't blocking the request.
   2. Verify Active Directory works correctly to troubleshoot the DFS Namespace server.

Look for the DFS client to resolve DNS (assuming it isn't cached) and make a connection to a file server.

1. It's possible that Windows won't attempt to contact a referral if there are other networking issues, such as a DNS resolution failure.
2. To ensure that Windows will perform DNS resolution, you can flush the DNS cache after starting the trace and before reproducing the issue. This operation allows you to verify that DNS resolution is working correctly.
   1. In Windows 8 and later versions of Windows, use PowerShell cmdlet: `Clear-DnsClientCache`.
   2. For previous versions of Windows, run command: `ipconfig flushdns`.

[SMB troubleshooting](/windows-server/storage/file-server/troubleshoot/troubleshooting-smb) applies to fixing the file server connection.

## Common issues and solutions

When you access, modify, or create a DFS Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you may receive the following error variations of "The namespace cannot be queried" error message.

> [!NOTE]
> After you apply the solutions, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

- [Delegation information for the namespace cannot be queried. The request is not supported](error-request-not-supported.md)
- [The namespace cannot be queried. Access is denied](cant-create-domain-based-dfs-namespace.md)
- [The namespace cannot be queried. Element not found](error-element-not-found-dfsn.md)
- [The namespace cannot be queried. Not enough memory resources are available to process this command](error-not-enough-memory-resources-available.md)
- [The namespace cannot be queried. The data is invalid](error-data-invalid-namespace-no-targets.md)
- [The namespace cannot be queried. The device is not ready for use](error-device-not-ready-for-use.md)
- [The namespace cannot be queried. The namespace has no targets. This may be due to a corrupt or out of sync metadata](error-data-invalid-namespace-no-targets.md)
- [The namespace cannot be queried. The remote procedure call failed](error-remote-procedure-call-failed.md)
- [The namespace cannot be queried. The RPC server is unavailable](namespace-not-queried-rpc-server-unavailable.md)
- [The namespace cannot be queried. The specified domain either does not exist or cannot be contacted](error-specified-domain-not-exist-cannot-contacted.md)
- [The namespace cannot be queried. The specified server cannot perform the requested operation](error-specified-server-cannot-perform-requested-operation.md)
- [The namespace cannot be queried. The system cannot find the file specified](error-system-cannot-find-file-specified.md)

For more information, see:

- [Unsupported DFSN deployment scenario](support-policy-for-dfsr-dfsn-deployment.md)
- [Recovery process of a DFSN](recovery-process-of-dfs-namespace.md)
- [Troubleshoot DFSN access failures](dfsn-access-failures.md)
- [Fail to create a DFSN](../identity/namespace-not-queried-rpc-server-unavailable.md)
- [DFSNs service and its configuration data](dfs-namespaces-service-configuration-data.md)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:

    - Client:  

        ```powershell
        TSS.ps1 -Scenario NET_DFScli
        ```

    - Server:  

        ```powershell
        TSS.ps1 -Scenario NET_DFSsrv
        ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

Frequently Asked Questions

- [Distributed File System: Namespace Availability Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341464%28v=ws.10%29)
- [Distributed File System: Namespace Client Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341469%28v=ws.10%29)
- [Distributed File System: Namespace Management Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341474%28v=ws.10%29)
- [Distributed File System: Namespace Scalability and Sizing Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341472%28v=ws.10%29)
- [Distributed File System: Namespace Server Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341468%28v=ws.10%29)
- [Distributed File System: Namespace Site Discovery and Target Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh341470%28v=ws.10%29)
