---
title: Guidance of troubleshooting SDN
description: Introduces general guidance of troubleshooting scenarios related to SDN.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:sdn, csstroubleshoot
ms.technology: windows-server-sdn
---
# SDN troubleshooting guidance

This topic will help you troubleshoot scenarios for the Software Defined Networking (SDN) technologies that are included in Windows Server 2019, Windows Server 2016, and Azure Stack HCI. Most users are able to resolve their issues by using these solutions.

## Check IP Configuration and Virtual Subnets that are referencing the ACL

1. Run the `Get-ProviderAddress` command on both Hyper-V hosts that host the two affected tenant virtual machines (VM). Then, run `Test-LogicalNetworkConnection` or `ping -c <compartment>` from the Hyper-V host to verify connectivity on the HNV Provider logical network.
2. Make sure that the MTU settings are correct on the Hyper-V hosts and on any Layer-2 switching devices that are between the Hyper-V Hosts. Run `Test-EncapOverheadValue` on all affected Hyper-V hosts. Also check whether all Layer-2 switches between the hosts have MTU set to least 1,674 bytes to account for a maximum overhead of 160 bytes.
3. If provider addresses (PA) are not present or customer address (CA) connectivity is broken, check to make sure that network policy has been received. Run `Get-PACAMapping` to see whether the encapsulation rules and CA-PA mappings that are required to create overlay virtual networks are correctly established.
4. Verify that the Network Controller Host Agent is connected to the Network Controller. To do this, run `netstat -anp tcp |findstr 6640`.
5. Verify that the Host ID in the `HKLM` registry key matches the Instance ID of the server resources that host the tenant VMs.
6. Verify that the Port Profile ID matches the Instance ID of the VM network nterfaces of the tenant VMs.

## Check network connectivity between the network controller and Hyper-V host

Run the `netstat` command to verify that there are three established connections between the Network Coding (NC) Host Agent and the Network Controller nodes. Also, verify that there is one listening socket on the Hyper-V host. See the following list for details.

- Port TCP:6640 listening on on Hyper-V Host (NC Host Agent Service)
- Two established connections from Hyper-V host IP on port 6640 to NC node IP on ephemeral ports (The port number is higher than 32000)
- One established connection from Hyper-V host IP on ephemeral port to Network Controller REST IP on port 6640

## Check Host Agent services

The network controller communicates with two host agent services on the Hyper-V hosts: SLB Host Agent and NC Host Agent. It's possible that one or both of these services are not running. Check their state, and restart them if they're not running:

```powershell
Get-Service SlbHostAgent
Get-Service NcHostAgent

# (Re)start requires -Force flag
Start-Service NcHostAgent -Force
Start-Service SlbHostAgent -Force
```

## Check health of network controller

If there are not three **ESTABLISHED** connections, or if the network controller appears unresponsive, check whether all nodes and service modules are up and running:

```powershell
# Prints a DIFF state (status is automatically updated if state is changed) of a particular service module replica
Debug-ServiceFabricNodeStatus [-ServiceTypeName] <Service Module>
```

The following are network controller service modules:

- ControllerService
- ApiService
- SlbManagerService
- ServiceInsertion
- FirewallService
- VSwitchService
- GatewayManager
- FnmService
- HelperService
- UpdateService

Verify that **ReplicaStatus** is **Ready** and **HealthState** is **OK**. In a production deployment that uses a multi-node network controller, you can also see which node each service is primary on, and check the individual replica status of the service:

```powershell
Get-NetworkControllerReplica
```

Verify that the **Replica Status** is **Ready** for each service.

### Check MTU and Jumbo Frame support on HNV Provider logical network

Another common problem in the HNV Provider logical network is that the physical network ports or Ethernet card do not have a large enough MTU configured to handle the overhead from VXLAN (or NVGRE) encapsulation.

### Check tenant VM network adapter connectivity

Each VM network adapter that's assigned to a guest VM has a CA-PA mapping between the private Customer Address (CA) and the HNV Provider Address (PA) space. These mappings are kept in the OVSDB server tables on each Hyper-V host. You can find them by running the following cmdlet:

```powershell
# Get all known PA-CA Mappings from this particular Hyper-V Host
Get-PACAMapping
```

## Common errors and solutions based on the configuration state

### Error 1

Error code:  
> HostUnreachable

Error message:  
> MUX is Unhealthy (Common case is BGPRouter disconnected)

Troubleshooting: Credible Border Gateway Protocol (CBGP) peer on the Routing and Remote Access Service (RRAS) (BGP VM) or Top-of-Rack (ToR) switch is unreachable or not peering successfully. Check BGP settings on both Software Load Balancer Multiplexer resource and BGP peer (ToR or RRAS VM).

### Error 2

Error code:

- > CertificateNotTrusted
- > CertificateNotAuthorized

Error message:

> Failed to connect to Mux due to network or cert errors

Troubleshooting: Check the numeric code that's provided in the error message code. This corresponds to the winsock error code. Certificate errors are granular (for example, the certificate cannot be verified, or the certificate is not authorized).

### Error 3

Error code:  
> HostNotConnectedToController

Error message:  
> SLB host agent is not connected

Troubleshooting:

  1. Verify that the software load balancers (SLB) Host Agent service is running.
  2. Refer to the SLB host agent logs (auto running) for the causes. If the Software Load Balancer Manager (SLBM) (NC) rejected the certificate that was presented by the host agent, the running state can show nuanced information.

### Error 4

Error code:  
> DistributedRouterConfigurationFailure

Error message:  
> Failed to configure the Distributed router settings on the host vNic

Troubleshooting:  
TCPIP stack error. This might require cleaning up the Peer Authentication (PA) and Destination Rule (DR) Host Virtual Network Interface Cards (VNICs) on the server on which this error was reported.

### Error 5

Error code:  
> PolicyConfigurationFailure

Error message:

- > Failed to push vSwitch policies for a virtual machine network interface card (VmNic) due to certificate errors or connectivity error
- > Failed to push Firewall policies for a VmNic due to certificate errors or connectivity errors
- > Failed to push virtual network (VNet) policies for a VmNic due to certificate errors or connectivity errors

Troubleshooting:  
Check whether the appropriate certificates were deployed (the certificate subject name must match the FQDN of the host). Also, verify the host connectivity with the network controller.

## Reference

- [Troubleshoot the Windows Server Software Defined Networking Stack](/windows-server/networking/sdn/troubleshoot/troubleshoot-windows-server-software-defined-networking-stack)
  - [No network connectivity between two tenant VMs](/windows-server/networking/sdn/troubleshoot/troubleshoot-windows-server-software-defined-networking-stack#no-network-connectivity-between-two-tenant-virtual-machines)<br>
  - [Logging, Tracing and advanced diagnostics](/windows-server/networking/sdn/troubleshoot/troubleshoot-windows-server-software-defined-networking-stack#logging-tracing-and-advanced-diagnostics)<br>
  - [Software Load Balancer Manager](/windows-server/networking/sdn/troubleshoot/troubleshoot-windows-server-software-defined-networking-stack#slb-diagnostics)<br>
- [UDP Communication failures and changing the Network Controller Certificate](https://techcommunity.microsoft.com/t5/Networking-Blog/SDN-Troubleshooting-UDP-Communication-failures-and-changing-the/ba-p/339694)
- [Troubleshooting certificate issues in Software Defined Networking (SDN)](https://techcommunity.microsoft.com/t5/Networking-Blog/Troubleshooting-certificate-issues-in-Software-Defined/ba-p/339671)
- [How to find the SDN gateway local address for BGP peering in Windows Server 2016](https://techcommunity.microsoft.com/t5/Networking-Blog/How-to-find-the-SDN-gateway-local-address-for-BGP-peering-in/ba-p/339663)
- [Troubleshoot Configuring SDN RAS Gateway VPN Bandwidth Settings in Virtual Machine Manager](https://techcommunity.microsoft.com/t5/Networking-Blog/Troubleshoot-Configuring-SDN-RAS-Gateway-VPN-Bandwidth-Settings/ba-p/339661)
- [Sample scripts and workflows](https://github.com/microsoft/sdn) (requires GitHub access)
