---
title: DPM protection jobs fail with errors
description: Fixes error messages about failed job details for various protected servers occur in Data Protection Manager. 
ms.date: 04/08/2024
ms.reviewer: Mjacquet, dewitth, jeffpatt
---
# Protection jobs for various protected servers fail with errors

This article helps you fix errors messages about failed job details for various protected servers in Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 971411

## Symptoms

You receive one or more of the following error messages about failed jobs for various protected servers in System Center Data Protection Manager. These errors may occur for various kinds of jobs, including synchronization, recovery points, and consistency check.

> Type: Recovery point Status: Failed Description: An unexpected error occurred during job execution. (ID 104 Details: Internal error code: 0x80990A51)

> Type: Tape backup Status: Failed Description: DPM failed to communicate with the protection agent on Server_name.com because access is denied. (ID 42 Details: Access is denied (0x80070005))

> DPM could not communicate with the Protection Agent service on ProtectedServer.Contoso.local. (ID 308 Details: The RPC server is unavailable (0x800706BA))

> The protection agent operation failed because DPM could not communicate with the Protection Agent service on protected.server.contoso.com. (ID 308 Details: The RPC server is unavailable (0x800706BA))

> Type: Recovery point Status: Failed Description: The protection agent on Server_name.com was temporarily unable to respond because it was in an unexpected state. (ID 60 Details: Internal error code: 0x809909B0)

> The DPM service was unable to communicate with the protection agent on ProtectedServer.Contoso.local. (ID 52 Details: An existing connection was forcibly closed by the remote host (0x80072746))

> The DPM service was unable to communicate with the protection agent on ProtectedServer.Contoso.local. (ID 52 Details: The semaphore timeout period has expired (0x80070079))

> DPM failed to communicate with the protection agent on ProtectedServer.Contoso.local because the agent is not responding. (ID 43 Details: Internal error code: 0x8099090E)

> DPM failed to communicate with ProtectedServer.Contoso.local because the computer is unreachable. (ID 41 Details: No connection could be made because the target machine actively refused it (0x8007274D))

## Cause

This problem occurs if the network is experiencing high latency, or if the network is saturated with data transfers. When these conditions are true, DCOM traffic is delayed. This causes the agents to time out intermittently.

## Workaround

To work around this problem, follow these steps to add some registry entries on the DPM server and the protected server.

1. In Notepad, paste the following entries into the file, and then save the file as *DPMAgentTimeout.reg*.

    ```console
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Data Protection Manager\Agent]
    "ConnectionNoActivityTimeoutForNonCCJobs"=dword:00001c20
    "ConnectionNoActivityTimeout"=dword:00001c20
    "AbortAgentOnLockTimeout"=dword:00000001
    "CommandTimeout"=dword:1b7740

    [HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters]
    "TcpMaxDataRetransmissions"=dword:00000010
    ```

1. Right-click the *DPMAgentTimeout.reg* file, and then select **Merge**.
1. Restart the DPMRA service or the server for the changes to take effect.

If the problem persists, enable DPM throttling of 85 through 90 percent to make sure that bandwidth is available for DCOM calls. You can enable bandwidth throttling for each protected server on the **Agents** tab under the **Management** tab.

For more information about the `TcpMaxDataRetransmissions` value, see [How to modify the TCP/IP maximum retransmission time-out](https://support.microsoft.com/topic/7ae0982a-4963-fa7e-ee79-ff6d0da73db8). Additionally, [run antivirus software on the DPM server](/system-center/dpm/run-antivirus-server).

## More information

There are different channels for the control and data information that passes between the DPM server and a protected server. The control path uses the DCOM (RPC) channel, and the data path uses TCP/IP. If the data path completely saturates the network (even for a short duration), DCOM calls may fail. If the calls fail, this causes the job to fail. To avoid this problem, enable throttling for the protected servers to limit the network usage of the data path to 85 percent.

By default, throttling isn't enabled in DPM because throttling requires Quality of Service (QoS) to be installed on both the DPM server and the protected server.

If the 85 percent setting doesn't resolve the issue completely, increase the throttling level of the protected server that has the problem.

If this solution doesn't resolve the problem, the DPM server maybe overloaded. Try to reorganize the protection groups so that backups are staggered, or so that synchronizations occur at staggered times.
