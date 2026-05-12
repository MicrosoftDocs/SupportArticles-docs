---
title: Troubleshoot virtual machines not responding to traffic on the configured data port
description: "Troubleshoot why Azure Load Balancer backend VMs show as healthy but don't respond to traffic. Identify causes like misconfigured ports and NSG rules. Learn to fix connectivity issues now."
services: load-balancer
ms.service: azure-load-balancer
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/30/2026
ms.custom: 
  - Connectivity-Outbound
  - Configuration and Setup
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Troubleshoot virtual machines not responding to traffic on the configured data port

## Summary

This article explains how to troubleshoot scenarios where virtual machines (VMs) in the backend pool of an Azure Load Balancer are healthy according to the load balancer's health probes but aren't responding to traffic on the configured data port. It provides guidance on identifying common causes like misconfigured ports, network security group rules, or other connectivity issues that prevent backend VMs from receiving or responding to load-balanced traffic.

If a backend pool VM is listed as healthy and responds to the health probes, but is still not participating in the load balancing, or isn't responding to the data traffic, it might be due to any of the following reasons:

- [Cause 1: A load balancer backend pool VM isn't listening on the data port](#cause-1-a-load-balancer-backend-pool-vm-isnt-listening-on-the-data-port).

- [Cause 2: An NSG is blocking the port on the load balancer backend pool VM](#cause-2-an-nsg-is-blocking-the-port-on-the-load-balancer-backend-pool-vm)..

- [Cause 3: The data port is accessing the load balancer from the same VM and network interface (NIC)](#cause-3-the-data-port-is-accessing-the-load-balancer-from-the-same-vm-and-network-interface-nic).

- [Cause 4: The data port is accessing the internet load balancer frontend from the participating load balancer backend pool VM](#cause-4-the-data-port-is-accessing-the-internet-load-balancer-frontend-from-the-participating-load-balancer-backend-pool-vm).

## Cause 1: A load balancer backend pool VM isn't listening on the data port

If a VM doesn't respond to the data traffic, it might be because either the target port isn't open on the participating VM, or, the VM isn't listening on that port. 

### Solution

To resolve this problem, perform the following steps:

1. Sign in to the backend VM. 

1. Open a command prompt and run the following command to validate there's an application listening on the data port:  
            
    ```cmd
    netstat -an 
    ```

1. If the port isn't listed with the state as **LISTENING**, configure the proper listener port on the application running on the VM so that it listens on the port that the load balancer is sending traffic to.

1. If the port is marked as **LISTENING**, check the target application on that port for any possible issues.

## Cause 2: An NSG is blocking the port on the load balancer backend pool VM  

If one or more NSGs configured on the subnet or on the VM block the source IP or port, the VM can't respond.

### Solution

For the public load balancer, the IP address of the internet clients is used for communication between the clients and the load balancer backend VMs. Make sure the IP address of the clients are allowed in the backend VM's network security group.

Perform the following steps:

1. List the network security groups configured on the backend VM. For more information, see [Manage network security groups](/azure/virtual-network/manage-network-security-group)

2. From the list of network security groups, check if:
    
    - The incoming or outgoing traffic on the data port has interference. 
    
    - A **Deny All** NSG rule on the NIC of the VM or the subnet that has a higher priority that the default rule that allows the load balancer probes and traffic. NSGs must allow a load balancer IP of 168.63.129.16 as that's a probe port.

3. If any of the rules are blocking the traffic, remove and reconfigure those rules to allow the data traffic.  

4. Test if the VM is now able to respond to the health probes.

## Cause 3: The data port is accessing the load balancer from the same VM and network interface (NIC) 

If your application hosted in the backend VM of an internal load balancer is trying to access another application hosted in the same backend VM over the same network interface, it's an unsupported scenario and will fail. 

### Solution

You can resolve this issue via one of the following methods:

- Configure separate backend pool VMs per application. This ensures that each application has its own VM and network interface, avoiding the unsupported scenario of a VM trying to access another application on the same NIC through the load balancer.

- Configure the application in dual NIC VMs so each application was using its own NIC and IP address. 

## Cause 4: The data port is accessing the internet load balancer frontend from the participating load balancer backend pool VM

If an internal load balancer is configured inside a virtual network and one of the participant backend VMs is trying to access the internal load balancer frontend, failures can occur when the flow is mapped to the originating VM. This scenario isn't supported.

Internal load balancers don't translate outbound originated connections to the front end of an internal load balancer because both are in private IP address space. Public load balancers provide [outbound connections](/azure/load-balancer/load-balancer-outbound-connections) from private IP addresses inside the virtual network to public IP addresses. For internal load balancers, this approach avoids potential SNAT port exhaustion inside a unique internal IP address space, where translation isn't required.

This means that if an outbound flow from a VM in the backend pool attempts a flow to front end of the internal load balancer in its pool and it is mapped back to itself, the two legs of the flow don't match. Because they don't match, the flow fails. The flow succeeds if the flow didn't map back to the same VM in the backend pool that created the flow to the front end.

When the flow maps back to itself, the outbound flow appears to originate from the VM to the front end, and the corresponding inbound flow appears to originate from the VM to itself. From the guest operating system's point of view, the inbound and outbound parts of the same flow don't match inside the virtual machine. The TCP stack won't recognize these halves of the same flow as being part of the same flow. The source and destination don't match. When the flow maps to any other VM in the backend pool, the halves of the flow do match and the VM can respond to the flow.

The symptom for this scenario is intermittent connection timeouts when the flow returns to the same backend that originated the flow. While you could use a public load balancer to mitigate this issue, the resulting scenario is prone to [SNAT exhaustion](/azure/load-balancer/load-balancer-outbound-connections). Avoid this second approach unless carefully managed.

### Solution

There are several ways to unblock this scenario, including using a proxy. Evaluate Application Gateway or other third party proxies (for example, nginx or haproxy). For more information about Application Gateway, see [Overview of Application Gateway](/azure/application-gateway/overview).

> [!NOTE]
> It is by design that existing TCP connections will continue to a virtual machine even after a backend is removed from a load balancer. Once a connection is routed to a backend instance by the load balancer, traffic is established directly between the client and the backend instance. Connections will continue untl the virtual machine is stopped or deallocated.