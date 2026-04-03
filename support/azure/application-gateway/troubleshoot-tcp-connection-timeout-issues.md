---
title: Troubleshoot TCP connection timeout issues in Azure Application Gateway
description: Learn how to diagnose and resolve TCP connection timeout issues that occur before HTTP processing in Azure Application Gateway.
ms.date: 04/02/2026
ms.author: lalbadarneh, giverm
ms.editor: lalbadarneh
ms.reviewer: lalbadarneh
ms.service: azure-application-gateway
ms.custom: sap:Connection timed out

#customer intent: As a cloud administrator, I want to troubleshoot TCP connection timeout issues in Azure Application Gateway so that client traffic can successfully establish a TCP connection to the gateway frontend.
---

# Troubleshoot TCP connection timeout issues in Azure Application Gateway

This article helps you diagnose and resolve **TCP connection timeout issues** when traffic is routed through **Azure Application Gateway**.

A TCP connection timeout occurs when a client is unable to establish a TCP connection to the Application Gateway frontend. These issues occur **before HTTP processing takes place**, which means the request never reaches the backend application.

This article focuses **only on TCP connection timeouts**.  
If you’re troubleshooting HTTP 504 Gateway Timeout errors, see
[504 Gateway Time Out](/azure/application-gateway/http-response-codes#504--gateway-time-out).

## Prerequisites

- An Azure Application Gateway deployed with a public or private frontend IP
- Client access to the Application Gateway frontend IP and port
- Permission to review Application Gateway, NSG, and route table configurations

## Symptoms

You may experience one or more of the following browser or client-side errors:

- `ERR_CONNECTION_TIMED_OUT`
- `ERR_EMPTY_RESPONSE`
- `This operation returned because the timeout period expired`
- `Could not open connection to the host on port <port>: Connect failed`

In these scenarios, requests time out before any HTTP response is received, and traffic doesn’t reach the application.

## Troubleshooting checklist

### Validate client network connectivity

Before reviewing Application Gateway configuration, confirm that the client network can establish outbound TCP connections.

Client network components that commonly affect connectivity include:

- Firewalls restricting outbound ports
- Proxy servers that block, inspect, or require authentication for outbound traffic

Ensure that outbound traffic to the Application Gateway frontend IP and port is allowed and not altered before reaching Azure.

### Review NSG and UDR configuration on the Application Gateway subnet

Verify the network configuration applied to the Application Gateway subnet:

1. Confirm that Network Security Group (NSG) rules allow inbound and outbound traffic on the destination port.
2. Check whether a User Defined Route (UDR) is associated with the subnet.

The validation scope depends on whether traffic reaches Application Gateway through a **public** or **private frontend IP**.

### Validate DNS configuration

DNS issues **do not result in a TCP connection timeout**. Instead, they prevent the TCP connection from being created because the client can’t resolve the destination hostname to an IP address.

If you encounter DNS-related errors (for example, `ERR_NAME_NOT_RESOLVED` or host not found):

- Ensure the DNS record resolves to the **Application Gateway frontend IP address**
- Verify that the resolved IP belongs to the intended Application Gateway

### Verify frontend listener configuration

Ensure that Application Gateway is listening on the expected IP address and port:

1. A frontend listener must exist on the destination port.
2. The listener must be associated with a routing rule that forwards traffic to a backend pool.

If no listener exists, the TCP connection will time out.

## Causes and/or solutions

### TCP connection cannot be established to the Application Gateway frontend

A TCP connection timeout indicates that the client is unable to establish a TCP connection to the Application Gateway frontend.

Common causes include:

- Client network issues such as firewall or proxy configurations that block or inspect outbound traffic
- NSG rules applied to the Application Gateway subnet
- UDRs applied to the subnet, including forced tunneling scenarios
- No frontend listener configured on the destination port
- A listener exists but isn’t associated with a routing rule
- Client-side DNS resolution issues


## Related content

- [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure)
- [Application Gateway listener configuration](/azure/application-gateway/configuration-listeners)
