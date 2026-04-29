---
title: Troubleshoot TCP connection timeout problems in Azure Application Gateway
description: Diagnose and fix TCP connection timeouts in Azure Application Gateway. Use this checklist to restore client connectivity and resolve front-end issues.
ms.date: 04/02/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.custom: sap:Connection timed out

#customer intent: As a cloud administrator, I want to troubleshoot TCP connection timeout problems in Azure Application Gateway so that client traffic can successfully establish a TCP connection to the gateway front end.
---

# Troubleshoot TCP connection timeout problems in Azure Application Gateway

## Summary

This article helps you diagnose and resolve TCP connection timeout problems when traffic routes through Microsoft Azure Application Gateway.

A TCP connection timeout occurs when a client can't establish a TCP connection to the Application Gateway front end. These problems occur before HTTP processing. Therefore, the request never reaches the back-end application.

> [!NOTE]
> This article focuses on only TCP connection timeouts.  
> If you're troubleshooting HTTP 504 Gateway Timeout errors, see [504 Gateway Time Out](/azure/application-gateway/http-response-codes#504--gateway-time-out).

## Prerequisites

- An Application Gateway deployed by having a public or private front-end IP
- Client access to the Application Gateway front-end IP and port
- Permission to review Application Gateway, network security group (NSG), and route table configurations
 
## Symptoms

You receive one or more of the following browser or client-side error messages:

- `ERR_CONNECTION_TIMED_OUT`
- `ERR_EMPTY_RESPONSE`
- `This operation returned because the timeout period expired`
- `Could not open connection to the host on port <port>: Connect failed`

In this scenario, requests time out before any HTTP response is received, and traffic doesn't reach the application.

## Causes

### TCP connection can't be established to the Application Gateway front end

A TCP connection timeout indicates that the client can't establish a TCP connection to the Application Gateway front end.

Common causes include:

- Client network problems. These problems include firewall or proxy configurations that block or inspect outbound traffic.
- NSG rules are applied to the Application Gateway subnet.
- User-defined routes (UDRs) are applied to the subnet, including forced tunneling scenarios.
- No front-end listener is configured on the destination port.
- A listener exists but isn't associated with a routing rule.
- Client-side DNS resolution problems occur.

## Troubleshooting checklist

### Verify client network connectivity for TCP connections

Before you review the Application Gateway configuration, verify that the client network can establish outbound TCP connections.

Client network components that commonly affect connectivity include:

- Firewalls that restrict outbound ports.    
- Proxy servers that block, inspect, or require authentication for outbound traffic.

Make sure that outbound traffic to the Application Gateway front-end IP and port is allowed and isn't changed before it reaches Azure.

### Review NSG and UDR configuration on the Application Gateway subnet

The validation scope depends on whether traffic reaches Application Gateway through a public or private front-end IP.

Verify that the network configuration is applied to the Application Gateway subnet. Follow these steps:

1. Verify that NSG rules allow inbound traffic on the destination port.
1. Determine whether a UDR is associated with the Application Gateway subnet, and evaluate the configured route propagation behavior.

#### UDR validation

If a route table is associated with the Application Gateway subnet, review all user‑defined routes that could affect return traffic from the Application Gateway.

Pay particular attention to routes that match the client or source IP address range that forward traffic to a Network Virtual Appliance (NVA) or Azure Firewall.

If such a route exists, determine whether it could redirect return traffic away from the expected path and, therefore, cause asymmetric routing. If no matching user-defined route exists for the client or source IP address, verify whether gateway route propagation is disabled on the route table.

If gateway route propagation is disabled, the issue is unlikely to be caused by routing.

> [!NOTE]
> If no route table is associated with the Application Gateway subnet, gateway route propagation is effectively enabled by default. However, this condition alone doesn't rule out routing-related issues.

If no route table is associated, or if a route table is associated and gateway route propagation is enabled, check the following items.

#### Check gateway route propagation (same virtual network)

Check whether a `GatewaySubnet` exists in the same virtual network.

If a `GatewaySubnet` exists, evaluate whether routes that are propagated from a VPN gateway or Azure ExpressRoute gateway (for example, default routes that are introduced by forced tunneling) might affect return traffic for the request client IP address.

Verify the effective return path by using **Connection Troubleshoot** in the **Monitoring** section of the application gateway.

#### Check peered virtual network 

Check whether the Application Gateway virtual network is peered with another virtual network. If peering exists, verify whether **Use remote gateways** is enabled on the peering configuration.

If it's enabled, follow these steps:

- Evaluate whether routes propagated from a VPN gateway or ExpressRoute gateway (for example, default routes introduced by forced tunneling) could affect return traffic for the request client IP address.
- Verify the effective return path by using **Connection Troubleshoot** in the **Monitoring** section of the Application Gateway.

> [!NOTE]
> Any scenario in which `0.0.0.0/0` has to be redirected through a virtual appliance, a hub/spoke virtual network, or on-premises (forced tunneling), isn't supported for public front-end Application Gateway v2.

### Verify DNS configuration

DNS problems don't cause a TCP connection time out. Instead, they prevent the TCP connection from being created because the client can't resolve the destination hostname to an IP address.

If you encounter DNS-related errors, such as `ERR_NAME_NOT_RESOLVED` or host not found, take the following actions:

- Make sure that the DNS record resolves to the Application Gateway front-end IP address.
- Verify that the resolved IP belongs to the intended application gateway.

### Verify front-end listener configuration

To make sure that Application Gateway is listening on the expected IP address and port, follow these guidelines:

- A front-end listener must exist on the destination port.
- The listener must be associated with a routing rule that forwards traffic to a back-end pool.

If no listener exists, the TCP connection times out.

## References

- [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure)
- [Application Gateway listener configuration](/azure/application-gateway/configuration-listeners)
