---
title: Troubleshoot TCP connection timeout problems in Azure Application Gateway
description: Diagnose and fix TCP connection timeout problems before HTTP processing in Azure Application Gateway. Follow this checklist to restore client connectivity.
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

This article helps you diagnose and resolve TCP connection timeout problems when traffic is routed through Azure Application Gateway.

A TCP connection timeout occurs when a client can't establish a TCP connection to the Application Gateway front end. These problems occur before HTTP processing. Therefore, the request never reaches the back-end application.

> [!NOTE]
> This article focuses on only TCP connection timeouts.  
> If you're troubleshooting HTTP 504 Gateway Timeout errors, see [504 Gateway Time Out](/azure/application-gateway/http-response-codes#504--gateway-time-out).

## Prerequisites

- An Azure Application Gateway deployed by having a public or private front-end IP
- Client access to the Application Gateway front-end IP and port
- Permission to review Application Gateway, network security group (NSG), and route table configurations

## Symptoms

You receive one or more of the following browser or client-side errors messages:

- `ERR_CONNECTION_TIMED_OUT`
- `ERR_EMPTY_RESPONSE`
- `This operation returned because the timeout period expired`
- `Could not open connection to the host on port <port>: Connect failed`

In this scenario, requests time out before any HTTP response is received, and traffic doesn't reach the application.

## Causes

### TCP connection can't be established to the Application Gateway front end

A TCP connection timeout indicates that the client can't establish a TCP connection to the Application Gateway front end.

Common causes include:

- Client network problems occur. These include firewall or proxy configurations that block or inspect outbound traffic.
- NSG rules are applied to the Application Gateway subnet.
- UDRs are applied to the subnet, including forced tunneling scenarios.
- No front-end listener is configured on the destination port.
- A listener exists but isn't associated with a routing rule.
- Client-side DNS resolution problems occur.

## Troubleshooting checklist

### Verify client network connectivity

Before you review the Application Gateway configuration, verify that the client network can establish outbound TCP connections.

Client network components that commonly affect connectivity include:

- Firewalls that restrict outbound ports
- Proxy servers that block, inspect, or require authentication for outbound traffic

Make sure that outbound traffic to the Application Gateway front-end IP and port is allowed and isn't changed before it reaches Azure.

### Review NSG and user-defined route (UDR) configuration on the Application Gateway subnet

Verify the network configuration applied to the Application Gateway subnet.

- Verify that NSG rules allow inbound and outbound traffic on the destination port.
- Check whether a UDR is associated with the subnet.

The validation scope depends on whether traffic reaches Application Gateway through a public or private front-end IP.

### Veriify DNS configuration

DNS problems don't cause a TCP connection timeout. Instead, they prevent the TCP connection from being created because the client can't resolve the destination hostname to an IP address.

If you encounter DNS-related errors (for example, `ERR_NAME_NOT_RESOLVED` or host not found), take the following actions:

- Make sure that the DNS record resolves to the Application Gateway front-end IP address.
- Verify that the resolved IP belongs to the intended Application Gateway.

### Verify front-end listener configuration

To make sure that Application Gateway is listening on the expected IP address and port, follow these guidelines:

- A frontend listener must exist on the destination port.
- The listener must be associated with a routing rule that forwards traffic to a back-end pool.

If no listener exists, the TCP connection times out.

## Related content

- [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure)
- [Application Gateway listener configuration](/azure/application-gateway/configuration-listeners)
