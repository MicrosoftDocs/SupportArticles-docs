---
title: Network Load Balancing concept and notes
description: describes the Network Load Balancing.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Network Load Balancing (NLB), csstroubleshoot
---
# Network Load Balancing - Concept and notes

This article provides the information about the Network Load Balancing.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556067

## Summary

This article has information about Network Load Balancing - a Microsoft Clustering Technology.  

## More information

- Q. How do you test an NLB Cluster?
- For example, you have found nodes in the cluster and want to check whether Load Balancing is working or not. Create different four shares on four nodes and try to access them from one machine. You must get each time different share when browsing using UNC patch.

- You can adjust the Convergence parameters by adjusting the following registry values:  

  - AliveMsgPeriod
  - AliveMsgTolerance  

- Configuring more than one VIP (Virtual IP) is available only in Windows 2003 editions and later.
- There's a different between STOP and DRAINSTOP commands. The STOP command will stop the NLB service on host and all existing connections will be lost, whereas DRAINSTOP will allow NLB to serve current connections and disable the new connections at the same time.
- IGMP can be configured only when Cluster is configured to use Multicast support.
- Server shouldn't have any network property opened while configuring using NLB Manager.
- NLB should have correct local time on all servers.
- NLB doesn't detect application failure. For example, a Web Server service may stop but NLB will still send TCP/IP requests to that server.
- NLB is used for the TCP/IP based application for which the data changes happen rarely.
- DoN't any other protocol except TCP/IP to cluster adapter.
- NLB Cluster can operate either in Unicast or Multicast mode but not both.
- Microsoft doesn't support mix of Server and NLB Cluster.
- Mix-NLB is allowed. Windows NT WLBS can run in Windows 2000 NLB.
- NLB doesn't support Token Ring and ATM networks. It has only been tested on 10 MB and 100-MB Ethernet network.
- Single Network Card Limitations: when running in Unicast Mode:
    1. Ordinary network communications between cluster host not possible.
    Network traffic intended for any individual computer within the cluster generates additional networking overhead for all computers in the cluster.
    2. Further to this, we can't use Network Load Balancing Manager on this computer to configure and manage NLB nodes.
- Automatically detects and recovers from a failed or offline computer. Automatically balances the network load when hosts are added or removed. Recovers and redistributes the workload within 10 seconds.
- The load is automatically redistributed to other nodes when a host goes offline. All the active connections to that host are lost. If you're internationally taking a node offline, then you can use the drainsstop command to service all the active connections before you take the node offline.
- You can have a mix of applications running in the NLB cluster. For example, you can run an IIS Web Server on all nodes and SQL server on one node only. This way you can designate the traffic for database to SQL server node only.
- NLB and Clustering both can't be active on same computer but you can form two clusters - Four Node NLB cluster and two node server cluster

    Is it necessary to have separate subnet for both the technology?

- NLB Supports upto 32 computers in a single cluster but you can use RRDNS to increate the number.
- NLB can load balance multiple requests from client on the same node or different node. This is done randomly.
- NLB automatically detects and removes the failure of NLB Node but it can't judge whether an application is running or stopped working. This should be done manually by running a script.
- Automatically load balances when new hosts are added or removed and this is done within 10 seconds.
- Different Virtual Cluster IP can be created to load balance different applications.
- Port rules must be same across the cluster but Port Rules can be different for multiple Virtual IP.
- NLB doesn't overlap the original computer name and IP address.
- NLB can be enabled on multiple network adapters. This allows you to configure different NLB Cluster.
- NLB can operate in two modes - Unicast or Multicast but both the modes can't be enabled at the same time. Unicast is the default mode.
- NLB enables each host to detect and receive incoming TCP/IP traffic. This traffic is received by all the hosts in cluster and NLB driver filter the traffic as per the Port Rules defined. NLB nodes don't communicate with each other for incoming traffic coming from client because NLB is enabled on all the nodes. A statistically mapping rule is created on each host to distribute incoming traffic. This mapping remains the same unless there's a change in the cluster (for example, node removed or added).
- Convergence is a process to rebuild the cluster state. This process invokes when there's a change in cluster (for example, node fails, leaves, or rejoin the cluster). In this process, the following actions are taken by cluster:  

    1. Rebuild the cluster state.
    2. Designate the host with the highest host priority as the Default Host.
    3. Load-balanced traffic is repartioned or redistributed among the remaining hosts.  

- During this process, remaining host continues to handle incoming client traffic. If a host is added to the cluster, convergence allows this host to receive its share of the load-balanced traffic. Expansion of the cluster doesn't affect ongoing cluster operations and is achieved transparently to both Internet clients and to server applications. However, it might affect client sessions that span multiple TCP connections when client affinity is selected, because clients might be remapped to different cluster hosts between connections. For more information on affinity
- All the nodes in cluster emit the heartbeat messages to tell their availability in the cluster. The default period for sending heartbeat message is one second and five missed heartbeat messages from a host cause NLB to invoke Convergence process.
- We can configure multiple NLB clusters on the same network adapter and then apply the specific port rules to each of those IP addresses. These are referred to as "Virtual Clusters".
- Windows 2003 comes with a GUI tool called: Network Load Balancing Manager and NLB.exe - a command-line tool. In Windows 2000, it's WLBS.exe and there's no GUI tool also. This GUI tool can be installed on XP also to manage only Windows 2003 NLB. NLB Manager uses DCOM and WMI.
- You should be the member of Administrators group on node for which you're configuring NLB. You don't need to be an administrator to run the NLB Manager.
- Single NIC > NLB Enabled in Unicast mode - You can't use NLB Manager on this computer to configure and manage other hosts because a single network adapter in unicast mode can't have intrahost communication.
- Intra-host communication is possible only in multicast node. To allow communication between servers in the same NLB cluster, each server requires the following registry entry: a DWORD key named "UnicastInterHostCommSupport" and set to 1, for each network interface card's GUID (HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\WLBS\Parameters\Interface\\{GUID})
- There's no restriction on number of adapters. Different hosts can have different network adapters.
- Single Network Adapter In Unicast Mode  

  - Adapter's own MAC address is disabled: The cluster MAC address that is generated automatically replaces this address.  
  - Both the dedicated IP address and Cluster IP Address resolve to the Cluster MAC address.  
  - Ordinary Network communication between cluster hosts isn't possible.  

## Cluster Parameters

- Cluster MAC Address is generated automatically by using the Cluster IP Address and it's unique across the subnet.
- Remote Control won't work if IPSEC is enabled. Remote control uses 1717 and 2504 on port over UDP.
- Priority Unique Host ID: Lowest number is the highest - The host with this priority handles all the incoming traffic that's not covered by Port Rules.  
    If a cluster node is joined with the same priority, it's not accepted as the part of the cluster but other nodes will continue to operate. This is called the Default Host. If Default Host fails, the other node with higher priority can act as a Default Host.
- Dedicated IP Address must be entered first in TCP/IP Property. It can't be DHCP enabled. This same applies to VIP also.
- You can't add more than 32 Port Rules to one cluster and it must be same across the cluster.  

## Network Load Balancing Manager  

- You can't open any network property for the host if NLB Manager currently uses this.
- NLB can be configured for any machine as long as you have administrative rights on the remote computer.
- To configure NLB successfully on Windows 2003, use the NLB Manager - Make sure you've unchecked the NLB from all hosts.
- When you add a host using NLB Manager the Port Rules and associated options will be inherited from the initial host.
- You can't open other hosts from the NLB Manager if NLB is operating in Single Adapter with Unicast Mode because a single network adapter with unicast mode can't have intrahost communication. To make this happen, use this registry: UnicastHostInterCommSupport and set it to 1.
- You can use the Credentials Option in NLB Manager to specify the credentials for remote hosts. NLB Manager will try to connect to remote hosts using this credential.
- You should use either TCP/IP Property settings or NLB Manager but shouldn't use both to configure NLB.
- NLB Manager doesn't connect or show the mis-configured Hosts in a cluster.
- Hosts for which you don't have administrative membership won't be displayed in NLB Manager.
- The list of all port ranges is sorted by Port Range.
- NLB can have mixed of Domain Controllers, Member Servers, Workgroup servers, and so on. This isn't the limitation of NLB actually. NLB should be able to access the computer using the built-in administrator account.
- When you enable NLB on a server, the default registry entries are created under: `HKLM\System\CurrentControlSet\Services\WLBS`
- The DIP and VIP must be entered correctly. The cluster nodes will converge with each other if you omit this step but they won't be able to accept and traffic.
- IP Address conflict message is displayed for VIP only. Make sure VIP from all adapters is removed if you uncheck NLB on that host.
- The following tools can be used with NLB for monitoring:  

  - ClusterSenitel  
  - Data Warehouse Center  
  - HTTPMon - for monitoring IIS Services.  
  - MOM  

- When load balancing PPTP requests, the two network adapters are required on each NLB host.
- You should supply gateway address in TCP/IP property when configuring two network adapters. The gateway should be entered to FE NIC.
- NLB must be enabled on the Public or Internet facing network adapter.
- Loading Balancing a telnet connection requires the associated ports to be opened. A telnet connection spans only one connection per IP so affinity isn't required in this case.
- The original implementation of NLB is WLBS. All the events are recorded in the source of WLBS. The command-line interface for NLB is WLBS and in Windows 2003, it's NLB.
- NLB Manager WMI provider can't connect to a cluster host for which the computer name starts with a numeric character. This is bug.
- NLB doesn't replicate the application data. You might need to use the Microsoft content Replication System (CRS) or third-party software.
- NLB doesn't monitor the services stop or start also. You can use HTTPMon that comes with Resource kit. You can use the following tools described below:  

  - Exception Monitor
  - HTTPMon
  - Third-party monitoring tools  

    - SiteScope by Mercury Interactive Corporation
    - AppManager by NetIQ  
    - WhatsUp Gold by Ipswitch  

## Unicast Mode with Single NIC  

In Unicast Mode, NLB modifies the Network Adapter's MAC address to Cluster MAC. Now, there's only one MAC Address available in cluster - that is Cluster MAC and this MAC address has to be same on all cluster hosts. Network Redirector can't forward the request to same MAC Address if it's originating from the same source, and also host can't communicate with each other - This is the disadvantage of Unicast Mode with Single NIC. To enable hosts to talk to each other, enable either MULTICAST mode or install a second NIC.

- You may get "No interface is available to configure load balancing" when using network load balancing manager. You get this error if you've imaged a server or copied to virtual machine. All network GUIDs will be same. You need to reinstall the network adapter from device manager to overcome this problem.
- While configuring NLB through NLB Manager and you've deleted the host from the cluster. If that status of that still shows pending for a long time, then manually disable the NLB in host. It would disappear from the Manager.
- It's always best practice to add local host (on where you're running NLB Manager) after adding all host when you're running NLB Cluster in Single NIC with Unicast Mode.
- It's recommended to run NLB Manager on a separate computer that's not part of cluster when you're running Cluster in Single NIC with Unicast or Multicast Mode.
- If you've added the local host to NLB Manager in single nic unicast mode and when you refresh, all other hosts will be unreachable.
- When you access VIP using UNC, you might get the login box if your request is being forwarded to a host who isn't in domain and your member of domain. You might need to supply user credentials.
- Crossover cable between NLB nodes doesn't work correctly for heartbeat messages and others. It works great in server clustering.
- Heartbeat messages are transmitted over NLB Enabled NIC always whether you're operating cluster in Unicast or Multicast mode.
- When an application running on a host dies or stop, the NLB will keep forwarding the requests to that server because NLB doesn't monitor the state of the application.
- Only Windows 2003 and later versions can be configured by the NLB Manager. However, you can manage previous versions of Windows but can't configure them using NLB Manager.
- Remote control for NLB uses UDP port 2504.  

## Windows 2008 Network Load Balancing Enhancements  

- There's a support fo IPV6 in Windows server 2008 for NLB. An IPV6 host can join NLB node.
- Multiple Dedicated IP Addresses are support in Windows Server 2008 for NLB.
- Supports rolling upgrade from Windows 2003 to Windows 2008.
- Supports for Unattended NLB Installation
- Supports for NLB in server Core also.

## Community Solutions Content Disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
