---
title: Troubleshoot private front-end IP allocation issues in Azure Application Gateway
description: Learn how private front-end IP allocation affects Application Gateway. Follow the troubleshooting steps to fix provisioning failures or traffic routing issues. 
ms.date: 04/02/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

#customer intent: As an Azure Application Gateway administrator, I want to understand private front-end IP allocation behavior so that I can prevent provisioning failures and unexpected traffic routing issues.
---

# Troubleshoot private front-end IP allocation issues in Azure Application Gateway

## Summary

This article describes scenarios in which Microsoft Azure Application Gateway behavior that's related to private front-end IP allocation causes unexpected failures or traffic routing issues. This behavior is by design, and can occur in specific deployment or operational scenarios.

## Prerequisites

- An Application Gateway deployed by having a private front-end IP
- Access to Application Gateway configuration and DNS settings

## Troubleshooting scenarios

### Scenario 1: Private front-end IP allocation conflict

#### Overview

Application Gateway activates a private front-end IP address only if you attach it to a listener that's associated with a routing rule. If you configure a private front-end IP but don't actively use it, the system doesn't reserve it for conflict detection.

When you scale out the Application Gateway, or when you deploy another application gateway in the same subnet, the private IP address might be allocated to one of the Application Gateway instances. This allocation can cause a private IP conflict if the original private front-end IP is later activated.

#### Symptoms

You observe the following behavior:

- An application gateway enters a **Failed** provisioning state after it attaches a private front-end IP to a listener.

#### Cause

Application Gateway differentiates between:

- Configured private front-end IPs
- Active private front-end IPs that are tied to a listener and routing rule

A private front-end IP that isn't attached to a listener together with a rule isn't activated. This condition means:

- The private IP isn't considered in use.
- The same IP might later be allocated internally by another Application Gateway or another instance.
- When the original Application Gateway later activates that IP by attaching it to a listener and rule, a conflict is detected, and provisioning fails.

#### Solution

To resolve this issue before you retry the update, remove the IP configuration, and then select a different private IP address.

### Scenario 2: Front-end private IP changes after stop and start operation (Application Gateway v1 only)

#### Overview

When you stop and start an Application Gateway v1, the front-end private IP address might change. This behavior is expected if the private front-end IP allocation method is dynamic.

> [!NOTE]
> This scenario applies only to Application Gateway v1 where dynamic private IP allocation is supported. This scenario doesn't apply to Application Gateway v2, where a static private IP address is required for the front-end configuration.

#### Symptoms

You might observe the following behavior after a stop and start operation:

- The Application Gateway front-end private IP address changes.
- If a scaling operation occurs after the initial deployment, an instance can reclaim and reassign a front-end IP address following a stop and start operation.
    - In that case, traffic continues to reach the application through a single Application Gateway instance.
- Traffic isn't load balanced across all Application Gateway instances as expected.  
  
If the previous front-end IP is no longer associated with a front-end configuration or any Application Gateway instance, traffic won't reach the application.

#### Cause

On Application Gateway v1:

- A stop and start operation might cause a new private front-end IP address if dynamic allocation is used.
- One of the Application Gateway instances might reuse the previously assigned front-end IP address internally.
- If DNS records still point to the old private IP address, traffic is sent directly to that instance instead of to the active front-end IP.

As a result:

- Traffic bypasses the Application Gateway front-end.
- Load balancing across all instances doesn't occur.

#### Solution

To restore appropriate traffic distribution on Application Gateway v1, follow these steps:

1. Verify the current front-end private IP address that's assigned to the Application Gateway.
1. Update DNS records to point to the new front-end private IP address.
1. Allow time for DNS propagation.
1. Verify that traffic is distributed across all Application Gateway instances.

For environments that require a stable front-end private IP, consider using Application Gateway v2, where static private IP assignment is mandatory.

## More information

### Advanced troubleshooting and data collection

If the issue persists:

- Review the Application Gateway provisioning state and recent configuration changes.
- Verify resolution from the client perspective.
- Verify that no overlapping private IP usage exists within the virtual network.

### Supportability note

Azure Application Gateway v1 is a legacy SKU. Microsoft announced the retirement of Application Gateway v1 and won't support it after *April 28, 2026*. New deployments and long‑term designs should use Application Gateway v2.

## References

[Private IP address allocation](/azure/application-gateway/configuration-front-end-ip#public-and-private-ip-address-support)
[Migrate from Application Gateway V1 to V2](/azure/application-gateway/v1-retirement)
