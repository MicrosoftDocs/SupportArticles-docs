---
title: Troubleshoot private frontend IP allocation issues in Azure Application Gateway
description: Learn how private frontend IP allocation affects Application Gateway and fix provisioning failures or traffic routing issues. Follow the troubleshooting steps.
ms.date: 04/02/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

#customer intent: As an Azure Application Gateway administrator, I want to understand private frontend IP allocation behavior so that I can prevent provisioning failures and unexpected traffic routing issues.
---

# Troubleshoot private frontend IP allocation issues in Azure Application Gateway

## Summary

This article describes scenarios where Azure Application Gateway behavior related to private frontend IP allocation leads to unexpected failures or traffic routing issues. These behaviors happen by design and can occur in specific deployment or operational scenarios.

## Prerequisites

- An Application Gateway deployed with a private frontend IP.
- Access to Application Gateway configuration and DNS settings.

## Troubleshooting checklist

### Scenario 1: Private frontend IP allocation conflict

#### Overview

Application Gateway activates a private frontend IP address only when you attach it to a listener that's associated with a routing rule. If you configure a private frontend IP but don't actively use it, the system doesn't reserve it for conflict detection.

When you scale out the Application Gateway, or when you deploy another Application Gateway in the same subnet, the private IP address might be allocated to one of the Application Gateway instances. This allocation can result in a private IP conflict when the original private frontend IP is later activated.

#### Symptoms

You observe the following behavior:

- An Application Gateway enters a **Failed** provisioning state after attaching a private frontend IP to a listener.

#### Cause

Application Gateway differentiates between:

- Configured private frontend IPs.
- Active private frontend IPs that are tied to a listener and routing rule.

A private frontend IP that isn't attached to a listener with a rule isn't activated. This condition means:

- The private IP isn't considered in use.
- The same IP might later be allocated internally by another Application Gateway or by another instance.
- When the original Application Gateway later activates that IP by attaching it to a listener and rule, a conflict is detected and provisioning fails.

#### Solution

To resolve this scenario, remove the IP configuration and select a different private IP address before retrying the update.

### Scenario 2: Frontend private IP changes after stop and start operation (Application Gateway v1 only)

#### Overview

When you stop and start an Application Gateway v1, the frontend private IP address can change. This behavior is expected when the private frontend IP allocation method is dynamic.

> [!NOTE]
> This scenario applies only to Application Gateway v1 where dynamic private IP allocation is supported. This scenario doesn't apply to Application Gateway v2, where a static private IP address is required for the frontend configuration.

#### Symptoms

You might observe the following behavior after a stop and start operation:

- The Application Gateway frontend private IP address changes.
- If a scaling operation occurs after the initial deployment, an instance can reclaim and reassign a frontend IP address following a stop and start operation.
    - In that case, traffic continues to reach the application through a single Application Gateway instance.
- Traffic isn't load balanced across all Application Gateway instances as expected.  
  
If the previous frontend IP is no longer associated with a frontend configuration or any Application Gateway instance, traffic won't reach the application.

#### Cause

On Application Gateway v1:

- A stop and start operation can result in a new private frontend IP address when dynamic allocation is used.
- One of the Application Gateway instances might reuse the previously assigned frontend IP address internally.
- If DNS records still point to the old private IP address, traffic is sent directly to that instance instead of the active frontend IP.

As a result:

- Traffic bypasses the Application Gateway frontend.
- Load balancing across all instances doesn't occur.

#### Solution

To restore proper traffic distribution on Application Gateway v1, perform the following steps:

1. Verify the current frontend private IP address assigned to the Application Gateway.
1. Update DNS records to point to the new frontend private IP address.
1. Allow time for DNS propagation.
1. Confirm that traffic is distributed across all Application Gateway instances.

For environments that require a stable frontend private IP, consider using Application Gateway v2, where static private IP assignment is mandatory.

## Advanced troubleshooting and data collection

If the issue persists:

- Review the Application Gateway provisioning state and recent configuration changes.
- Validate DNS resolution from the client perspective.
- Confirm no overlapping private IP usage exists within the virtual network.

## Supportability note

Azure Application Gateway v1 is a legacy SKU. Microsoft announced the retirement of Application Gateway v1 and won't support it after *April 28, 2026*. New deployments and long‑term designs should use Application Gateway v2.

## Resources

- [Private IP address allocation](/azure/application-gateway/configuration-frontend-ip#public-and-private-ip-address-support)
- [Migrate from Application Gateway V1 to V2](/azure/application-gateway/v1-retirement)
