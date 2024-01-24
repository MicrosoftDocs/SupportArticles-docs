---
title: Recommended private heartbeat configuration on a cluster server
description: Describes recommended configuration for the private adapter on a cluster server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, ELDENC, dewitth
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# Recommended private heartbeat configuration on a cluster server

This article describes recommended configuration for the private adapter on a cluster server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 258750

## Summary

Communication between Server Cluster nodes is critical for smooth cluster operations. Therefore, you must configure the networks that you use for cluster communication are configured optimally and follow all hardware compatibility list requirements. For networking configuration, two or more independent networks must connect the nodes of a cluster to avoid a single point of failure. The use of two local area networks (LANs) is typical. (Microsoft Product Support Services does not support the configuration of a cluster with nodes connected by only one network.)

At least two of the cluster networks must be configured to support heartbeat communication between the cluster nodes to avoid a single point of failure. To do so, configure the roles of these networks as either "Internal Cluster Communications Only" or "All Communications" for the Cluster service. Typically, one of these networks is a private interconnect dedicated to internal cluster communication.

Additionally, each cluster network must fail independently of all other cluster networks. This means that two cluster networks must not have a component in common that can cause both to fail simultaneously. For example, the use of a multiport network adapter to attach a node to two cluster networks would not satisfy this requirement in most cases because the ports are not independent.

To eliminate possible communication issues, remove all unnecessary network traffic from the network adapter that is set to **Internal Cluster communications only** (this adapter is also known as the heartbeat or private network adapter). Clustering communicates by using Remote Procedure Call (RPC) calls on IP sockets with User Datagram Protocol (UDP) packets. The process described in this article:

- Removes NetBIOS from the interconnect.
- Sets the proper Cluster communication priority order.
- Sets the proper adapter binding order.
- Defines the proper network adapter speed and mode.
- Configures TCP/IP correctly.
- Disable the Media Sense feature (in Windows 2000 only).

> [!NOTE]
> The information in this article does not apply to Windows Server 2008 or Windows Server 2008 R2 failover clusters. The recommendations for network configuration for the newer versions of Failover Cluster in non-CSV environments are noted at [Appendix A: Failover Cluster Requirements](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197454(v=ws.10)). The scenario where the settings in this article are likely to cause adverse behavior on Windows Server 2008 or Windows Server 2008 R2, is with a CSV environment. Recommendations with CSV is located at [Requirements for Using Cluster Shared Volumes in a Failover Cluster in Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff182358(v=ws.10)).

## Recommended configuration for the private adapter in Windows 2000 and Windows 2003

1. Click **Start**, point to **Settings**, click **Control Panel**, and then double-click **Network and Dial-up Connections**.

2. On the **Advanced** menu, click **Advanced Settings**.

3. In the **Connections** box, make sure that your bindings are in the following order, and then click **OK**:

    - External public network
    - Internal private network (Heartbeat)
    - [Remote Access Connections]

4. Right-click the network connection for your heartbeat adapter, and then click **Properties**.

    > [!NOTE]
    > You may want to rename this connection for simplicity (for example, rename it to "Private").

5. Use one of the following procedures:

   - If the server is using a quorum type other than Majority Node Set (MNS), click to select **Internet Protocol (TCP/IP)**, and then click to clear all other options.

   - If the server is using a MNS quorum, click to select **Internet Protocol (TCP/IP)** and at least one other file-sharing network protocol, and then click to clear all other options.

    > [!NOTE]
    > If the server is using a MNS quorum, you must have at least one network that has file-sharing capabilities for the MNS quorum to function. We strongly recommend that you have multiple networks on the cluster that have file sharing enabled to avoid a single point of failure for the quorum resource.

6. If you have a network adapter that can transmit at multiple speeds, and the adapter can specify a speed and duplex mode, manually specify a speed and duplex mode.

    With network adapters that can manually specify a speed and duplex mode, make sure that you hard set them to the same on all nodes and according to the manufacturers' specifications. For network adapters that do not support manual settings, follow the card manufacturer's specifications.

    The information that is traveling across the heartbeat network is small, but latency is critical for communication. If you have the same the speed and duplex settings, this helps to make sure that you have reliable communication.

    If you are not sure of the supported speed of your card and connecting devices, or your manufacturer's recommended settings, Microsoft recommends that you set all the devices on that path of 10 MB/Sec and Half Duplex. This configuration will provide sufficient bandwidth and reliable communication.

    > [!NOTE]
    > Microsoft does not recommend the use of any type of fault-tolerant adapter or "Teaming" for the heartbeat. If you require redundancy for your heartbeat connection, use multiple network adapters set to Internal Communication Only and define their network priority in the Cluster configuration. Issues seen with early multi-ported network adapters, verify that your firmware and driver are at the most current revision if you use this technology.

    Contact your network adapter manufacturer for information about compatibility on a Server Cluster.

7. Click **Internet Protocol (TCP/IP)**, and then click **Properties**.

8. On the **General** tab, verify that you have selected a static IP address that is not on the same subnet or network as another one of the public network adapters. An example of good IP addresses to use for the private adapters is 10.10.10.10 on node 1 and 10.10.10.11 on node 2 with a subnet mask of 255.0.0.0. If your public network uses the 10.x.x.x network and 255.0.0.0 subnet mask, use an alternate private network IP and subnet.

9. Make sure that there is no value set in the **Default Gateway** box.

10. Verify that there are no values defined in the **Use the following DNS server addresses** box.

    > [!NOTE]
    > If the cluster nodes are also DNS servers, "127.0.0.1" is displayed in the **Use the following DNS server addresses** box (the box will not be blank); this is acceptable.

11. Click **Advanced**.

12. On the **DNS** tab, verify that there are no values defined. Make sure that the **Register this connection's addresses in DNS** and **Use this connection's DNS suffix in DNS registration** check boxes are cleared.

13. When you close the dialog box, you may receive the following prompt. If you receive this prompt, click **Yes**:

    > This connection has an empty primary WINS address. Do you want to continue?

14. If you are using a crossover cable for your private heartbeat interconnect, disable the TCP/IP stack destruction feature of Media Sense.

    > [!NOTE]
    > Do not perform this step on a Windows Server 2003 Cluster.

    To disable the TCP/IP stack destruction feature of Media Sense, add the following registry value to each node:  `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`

    - Value Name: DisableDHCPMediaSense
    - Data Type: REG_DWORD
    - Data: 1

15. Complete the previous steps on all other nodes in the cluster.

16. Start Cluster Administrator.

17. Click the cluster name at the root of Administrator. On the **File** menu, click **Properties**.

18. On the **Network Priority** tab, verify that the private network is listed at the top. If it is not, use the **Move Up** button to increase its priority.

19. Click the private network, and then click **Properties**.

20. Click to select the **Enable this network for cluster use** check box.

21. Click **Internal cluster communications only (private Network)**. For more information, see [How to use Windows Server cluster nodes as domain controllers](use-cluster-nodes-as-domain-controllers.md).

## Recommended configuration for the private adapter in Windows NT 4.0

1. Click **Start**, point to **Settings**, click **Control Panel**, and then double-click **Network**.

2. On the **Protocols** tab, click **TCP/IP Protocol**, and then click **Properties**.

3. In the **Adapter** box, click the private network adapter.

4. On the **IP Address** tab, verify that you have selected a static IP address that is not on the same subnet or network as another one of the public network adapters. An example of good IP addresses to use for the private adapters is 10.10.10.10 on node 1 and 10.10.10.11 on node 2 with a subnet mask of 255.0.0.0.

5. Make sure that there is no value set in the **Default Gateway** box.

6. On the **WINS Address** tab, click the heartbeat adapter in the **Adapter** box.

7. Verify that there are no values defined for the WINS server entries.

8. When you close the dialog box, you may receive the following prompt. If you receive this prompt, click **Yes**:

    > At least one of the adapter cards has an empty primary WINS address. Do you want to continue?

9. On the **Routing** tab, verify that the **Enable IP Forwarding** check box is cleared.

10. Click **OK**.

11. If you have a network adapter that can transmit at multiple speeds and can specify a speed and duplex mode, manually specify a speed and duplex mode.

    With network adapters that can manually specify a speed and duplex mode, make sure that you hard set them to the same on all nodes and according to the manufacturer's specifications. For network adapters that do not support manual settings, follow the card manufacturer's specifications.

    The information that is traveling across the heartbeat network is small, but latency is critical for communication. If you have the same speed and duplex settings, you can help make sure that you have reliable communication.

    If you do not know the supported speed of your card and connecting devices, Microsoft recommends you set all devices on that path to 10 MB/Sec and Half Duplex. This configuration provides sufficient bandwidth and reliable communication.

    > [!NOTE]
    > Microsoft does not recommend that you use any type of fault-tolerant adapter or "Teaming" for the heartbeat. If you require redundancy for your heartbeat connection, use multiple network adapters set to Internal Communication Only and define their network priority in the Cluster configuration. Issues seen with early multi-ported network adapters, verify that your firmware and driver are at the most current revision if you use this technology.

    Contact your network adapter manufacturer for information about compatibility on a Server Cluster.

12. On the **Bindings** tab, click **All Adapters** in the **Show Bindings For** box.

13. Click the **plus sign** (+) next to the adapter used for the private interconnect.

14. Click **WINS Client (TCP/IP)**, and then click **Disable**.

    > [!NOTE]
    > No protocols other than TCP/IP should be enabled on the heartbeat adapter. Verify that all others are disabled (including such items as Network Monitor).

15. In the **Show Bindings For** box, click **All Protocols**.

16. Click the **plus sign** (+) next to **TCP/IP Protocol**.

17. Make sure that the public network adapter is the first binding (at the top of the binding list). To do this, click the private network adapter and use the **Move Down** button. If you have multiple public network adapters, make sure the heartbeat adapter is listed last.

18. Click **OK** to finish modifying the network properties and accept the changes.

19. Reboot the node for the changes to take effect.

20. Complete the previous steps on all other nodes in the cluster.

21. Start Cluster Administrator.

22. Click the cluster name at the root of Administrator. On the **File** menu, click **Properties**.

23. On the **Network Priority** tab, verify that the private network is listed at the top. If it is not, use the **Move Up** button to increase its priority.

24. Click the private network, and then click **Properties**.

25. Click to select the **Enable this network for cluster use** check box.

26. Click **Internal cluster communications only (private Network)**. For more information, see [How to use Windows Server cluster nodes as domain controllers](use-cluster-nodes-as-domain-controllers.md).
