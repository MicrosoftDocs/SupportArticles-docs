---
title: Guidance for troubleshooting TCP/IP communication
description: Introduces general guidance for troubleshooting scenarios related to TCP/IP communication.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcpip-communication, csstroubleshoot
---
# TCP/IP communication troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806409" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Active Directory replication issues.

This article is designed to help you troubleshoot TCP/IP communication issues.

## Troubleshooting tools

The ping command is useful to test basic connectivity. However, you shouldn't rely upon it to prove overall connectivity. Telnet and [PsPing](/sysinternals/downloads/psping) are more useful, for the following reasons:

- These tools can test connectivity to the application layer by using TCP or UDP (PsPing only) as the transport protocol.
- You can specify which port will be used. Therefore, you can navigate open ports on a firewall.
- You can connect to any "listening" port on the destination node to verify access to a specific application's port.

## Troubleshooting checklist

### Step 1: Capture a network diagram

Capture a network diagram that details the devices that are in the path to the affected area. Specifically, note the following devices:

- Firewalls
- IPS (Intrusion Protection/Prevention Systems)
- DPI (Deep Packet Inspection)
- WAN accelerators

The diagram can help you visualize and identify where to look for the cause of the issue.

### Step 2: Networking traces

Networking traces are useful to see what's occurring at the network level when the issue occurs.

### Step 3: Ping the computer's local IP address

Try to ping the computer's local IP address.

If the node can't ping its local IP, the local stack isn't working. Note any error messages that are displayed.

If you receive a **General Failure** error, this error means that there are no valid interfaces to process the request. This issue could be caused by a hardware issue or a stack issue.

Check whether you see a red "X" character or a yellow exclamation mark on the **Network Connection** icon in the system tray. A red X indicates that Windows isn't detecting a network connection. A yellow exclamation mark indicates that the Network Connection Status Indicator (NSCI) failed a probe check.

To troubleshoot this issue, verify that the network adapter reports connectivity. Make sure that the network adapter is plugged in and that the switch port where the node is connected isn't in an error state. You can change cables, switch ports, and network adapters to narrow down where this issue occurs. However, ultimately, the issue is outside the OS. To investigate further, contact the hardware vendors.

An issue might also occur between the network driver and Windows. This issue is typically because of a corruption in the stack. Use the following troubleshooting steps:

1. Make sure that the latest bits on the node (TCP/IP, NDIS, AFD, Winsock, and so on).
2. Reset IP and Winsock by running the following commands. Back up all the network configuration.

   ```console
   netsh -c interface dump > C:\netConfig.txt
   netsh int ip reset
   netsh winsock reset
   ```

3. Restart the node.
4. Restore the network settings after the restart. This operation works only if the interface names haven't changed, or the script is updated to use the new names.

   ```console
   netsh -f C:\netConfig.txt
   ```

5. Uninstall or reinstall the network adapter driver, as appropriate.
6. Check for and remove third-party filter drivers (for example, antivirus).
7. Try to start the computer in Safe Mode with Networking. If Safe Mode with Networking works, run a "clean boot" process by disabling all third-party apps and services within *MSConfig*, then re-enabling them one by one until the issue returns. You can then contact the vendor for support.
   1. If none of these items are successful, the issue is likely a registry corruption.
   2. If you have a backup copy of the registry (such as a physical backup or a system restore point), you can try to restore the node to a previously working configuration. Catching the root cause of the corruption can be difficult and extremely time consuming. Even if the corruption is found, knowing what caused it's even more challenging. Modifying the corrupted registry key manually puts the node into an unsupported state. As such, we recommend that the customer restore or reload the node in order to correct the corruption.

If the NSCI fails its probe check (yellow exclamation mark), this doesn't necessarily indicate a connectivity problem. Make sure that typical communication is occurring as it should.

- If so, the investigation should focus specifically on why the NCSI is failing its probe checks. The details for this are covered in a separate topic.
- If not, investigate the connectivity issues first because this would likely get corrected after connectivity is restored.

### Step 4: Troubleshoot error messages that occurs during the ping or telnet test

If the node can ping or telnet to nodes on the same subnet or network segment, this would confirm that external connectivity is working. Further testing is still required to understand whether a basic connectivity issue exists.

If the node can't ping/telnet to nodes on the same subnet/network segment. Note any error messages that are displayed.

1. **Destination host unreachable** error means that the ARP requests that are sent by the node aren't getting a response.
2. Gather a two-sided trace from the nodes that you're testing between. Make sure that the ARP request that's sent by the source node reaches the destination node and that the destination node replies accordingly. This reply should be seen back in the source trace. If this process fails, the issue is likely a misconfiguration or other issues that affect the infrastructure.

   Possible causes could be:
   1. Incorrect or mismatched VLANs.
   2. An incorrect switch port configuration (trunk versus access port).
   3. Other hardware issues.

3. The **Request timed out** error means that the ARP request got a response, but the ICMP Echo Request that's sent by the node isn't getting an ICMP echo response. This, alone, doesn't indicate an issue. ICMP traffic could be blocked by the network or firewall software on the nodes. It could be beneficial to turn off the firewall profiles (Windows) or disable them through the firewall vendor's supported method for testing ICMP.
   1. Telnet and PsPing are better suited for testing. Run Telnet or PsPing from the source node to the destination node on a listening port (such as 445).
   2. If step 1 is successful, external connectivity is working. Continue testing basic connectivity.
   3. If step 1 isn't successful (and if firewall profiles are disabled), gather a two-sided `netsh netconnection` scenario trace to troubleshoot further.

### Step 5: Ping or Telnet to the default gateway

When the node can ping its default gateway, then external connectivity (such as off-box connectivity) is possible from the source node. Further testing would still be required to understand whether a basic connectivity issue exists. If the node can't ping or Telnet to its default gateway, this means that the ICMP replies are disabled on the router.

### Step 6: Check issues that affects the specific destination node

If the source node can ping, Telnet, or PsPing to other nodes on the destination subnet, then basic connectivity and routing within the infrastructure is working. This outcome points to an issue that affects the specific destination node.

1. Try to Telnet or PsPing to the specific port that the application is listening on (for example, TCP port 445 for SMB). If the connection is successful, then basic application-level connectivity can be confirmed. In this situation, you'll have to contact the application vendor to help investigate why the application doesn't connect.

   > [!Note]
   > The application vendor could be Microsoft if the issue is a failure to connect to a share, for example. In these situations, it would be useful to take two-sided netsh netconnection scenario trace to gather additional information and help you to verify that there are no issues in the networking stack.

2. If the connection to the specific port isn't successful:
   1. Make sure that the port is in a 'listening' state:  
      CMD: `netstat -nato | findstr :<port>`  
      PowerShell: `Get-NetTcpConnection -LocalPort <port>`
   2. Temporarily disable all firewall profiles. (Note: Disable only the profiles. Don't disable the service.)  
      If this succeeds, the firewall must be reconfigured to allow the application traffic on its specific port.
   3. Remove any third-party applications one at a time, and test between each removal.  
      If this succeeds, contact the vendor of the problematic software.
   4. Try Safe Mode with Networking.  
      If this succeeds, isolate the cause by running a "clean boot" of the node by using *MSConfig*, and then enabling third-party applications and services one by one until the issue reoccurs.
   5. When you reproduce the connection attempt, you should run a netsh netconnection scenario trace from the source to the affected destination node. A Networking SDP would also be beneficial.
3. If the node can't ping, Telnet, or PsPing to other nodes on the destination subnet, the issue could likely be infrastructure-related. Again, ICMP could be blocked within the environment. Therefore, verify connectivity by using Telnet or PsPing to connect to known-listening ports. At this point, a two-sided network trace is necessary to show where the packet loss is occurring on the network. Make sure that both traces are running before you try the connectivity test so that the issue is captured.

## Common issues and solutions

### TCP/IP connection to a host appears to have stopped

This issue occurs because either data is blocked in TCP and UDP queues or there are network or user-level software delay problems.

To troubleshoot this issue, use the `netstat -a` command to show the status of all activity on TCP and UDP ports on the local computer.  
The state of a good TCP connection is established while having zero (0) bytes in the send and receive queues. If data is blocked in either queue, or if the state is irregular, the connection is probably at fault. If not, you're probably experiencing a network or user-level software delay.

### Long connect times when using Lmhosts for name resolution

This issue occurs because the Lmhosts file is parsed sequentially to locate entries without the \#PRE option.

To troubleshoot this issue, put frequently used entries near the top of the file and the \#PRE entries near the bottom. If an entry is added to the end of a large Lmhosts file, mark the entry in Lmhosts as a preloaded entry by using the \#PRE option. Then, run the `nbtstat -R` command to update the local name cache immediately.

### System error 53 occurred

System error 53 is returned if name resolution fails for a particular computer name when the `net use` command is used.

If the computer is on the local subnet, verify that the name is spelled correctly and that the target computer is also running TCP/IP. If the computer isn't on the local subnet, make sure that its name and IP address mapping are available in the Lmhosts file or the WINS database. If all TCP/IP elements appear to be installed properly, use the `ping` command together with the remote computer to verify that its TCP/IP software is working.

### Can't connect to a specific server

This issue occurs because either NetBIOS name resolution isn't resolving the name or the wrong IP address is being resolved.

To troubleshoot this issue, use the `nbtstat -n` command on the server to determine which names the server registered on the network. The computer name of the computer that you're trying to connect to should be on the displayed list. If the name isn't listed, try one of the other unique computer names that are displayed by `nbtstat`.
If the name that's used by a remote computer is the same as the name that's displayed by the `nbtstat -n` command, make sure that the remote computer has an entry for the server name that's on the WINS server or in its Lmhosts file.

### Unable to add a default gateway

This issue occurs because the IP address of the default gateway isn't on the same IP network ID as your IP address.

To troubleshoot this issue, determine whether the default gateway is located on the same logical network as the network adapter of the computer by comparing the IP address of the default gateway with the network IDs of any of the network adapters of the computer.

For example, a computer has a single network adapter that's configured with an IP address of 192.168.0.33 and a subnet mask of 255.255.0.0. This requires that the default gateway to be of the form "192.168.\<y\>.\<z\>" because the network ID portion of the IP interface is 192.168.0.0.

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
3. Start the traces on the source and destination server by using the following cmdlet:

    ```PowerShell
    TSS.ps1 -Scenario NET_General
    ```

4. Accept the EULA if the traces are run for the first time on the source or the destination server.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Troubleshoot TCP/IP connectivity](/windows/client-management/troubleshoot-tcpip-connectivity)
- [Troubleshoot port exhaustion issues](/windows/client-management/troubleshoot-tcpip-port-exhaust)
- [Troubleshoot Remote Procedure Call (RPC) errors](/windows/client-management/troubleshoot-tcpip-rpc-errors)
- [Collect data using Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon)
- [Failure to open TCP/IP properties of network adapter](cannot-open-network-adapter-tcp-ip-properties.md)
- [Direct host SMB over TCP/IP](direct-hosting-of-smb-over-tcpip.md)
- [Configure TCP/IP networking while NetBIOS is turned off](configure-tcpip-networking-netbios-turn-off.md)
- [TCP traffic stops](tcp-traffic-stops.md)
- [Default dynamic port range for TCP/IP has changed](default-dynamic-port-range-tcpip-chang.md)
- [TCP/IP properties revert to the default settings](internet-protocol-properties-show-default-ip-address.md)
