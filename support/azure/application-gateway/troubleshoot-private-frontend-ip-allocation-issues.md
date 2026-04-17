---
title: Troubleshoot private frontend IP allocation issues in Azure Application Gateway
description: Learn how private frontend IP allocation works in Azure Application Gateway and how to troubleshoot failures or traffic routing issues related to IP allocation behavior.
ms.date: 04/02/2026
ms.author: lalbadarneh
ms.editor: lalbadarneh
ms.reviewer: lalbadarneh
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

#customer intent: As an Azure Application Gateway administrator, I want to understand private frontend IP allocation behavior so that I can prevent provisioning failures and unexpected traffic routing issues.
---

# Troubleshoot private frontend IP allocation issues in Azure Application Gateway

This article describes scenarios where Azure Application Gateway behavior related to **private frontend IP allocation** may lead to unexpected failures or traffic routing issues. These behaviors are **by design** and can occur in specific deployment or operational scenarios.

## Prerequisites

- An Azure Application Gateway deployed with a private frontend IP
- Access to Application Gateway configuration and DNS settings

## Troubleshooting checklist

### Scenario 1: Private frontend IP allocation conflict

#### Summary

Azure Application Gateway activates a private frontend IP address **only when it’s attached to a listener that’s associated with a routing rule**. If a private frontend IP is configured but not actively used, it isn’t reserved for conflict detection.

When a scale‑out operation occurs on the Application Gateway, or when another Application Gateway is deployed in the same subnet, the private IP address may be allocated to one of the Application Gateway instances. This can result in a private IP conflict when the original private frontend IP is later activated.

#### Symptoms

You may observe the following behavior:

- An Application Gateway enters a **Failed** provisioning state after attaching a private frontend IP to a listener.

#### Cause

Application Gateway differentiates between:

- **Configured private frontend IPs**
- **Active private frontend IPs** that are tied to a listener and routing rule

A private frontend IP that isn’t attached to a listener with a rule isn’t activated. Because of this:

- The private IP isn’t considered in use.
- The same IP may later be allocated internally by another Application Gateway or by another instance.
- When the original Application Gateway later activates that IP by attaching it to a listener and rule, a conflict is detected and provisioning fails.

#### Resolution

To avoid this scenario:

- If a conflict occurs, remove the IP configuration and select a different private IP address before retrying the update.

---

### Scenario 2: Frontend private IP change after stop/start operation (Application Gateway v1 only)

#### Summary

This scenario applies **only to Application Gateway v1**, where **dynamic private IP allocation** is supported.

When an Application Gateway v1 is stopped and started, the frontend private IP address may change. This behavior is expected when the private frontend IP allocation method is dynamic.

This scenario doesn’t apply to **Application Gateway v2**, where a **static private IP address is required** for the frontend configuration.

#### Symptoms

You may observe the following behavior after a stop/start operation:

- The Application Gateway frontend private IP address changes.
- In some cases, if a scaling operation occurs after the initial deployment, a frontend IP address may be reclaimed by an instance and reassigned to it following a stop/start operation.
- In that case, traffic continues to reach the application through a **single Application Gateway instance**.
- Traffic isn’t load balanced across all Application Gateway instances as expected.  
  If the previous frontend IP is no longer associated with a frontend configuration or any Application Gateway instance, traffic won’t reach the application.

#### Cause

On **Application Gateway v1**:

- A stop/start operation can result in a new private frontend IP address being assigned when dynamic allocation is used.
- The previously assigned frontend IP address may be reused internally by one of the Application Gateway instances in some cases.
- If DNS records still point to the old private IP address, traffic is sent directly to that instance instead of the active frontend IP.

As a result:

- Traffic bypasses the Application Gateway frontend.
- Load balancing across all instances doesn’t occur.

On **Application Gateway v2**, this behavior doesn’t occur because:

- Private frontend IP addresses must be statically assigned.
- The frontend IP doesn’t change across stop/start operations.

#### Resolution

To restore proper traffic distribution on **Application Gateway v1**:

1. Verify the current frontend private IP address assigned to the Application Gateway.
2. Update DNS records to point to the **new frontend private IP address**.
3. Allow time for DNS propagation.
4. Confirm that traffic is distributed across all Application Gateway instances.

For environments that require a stable frontend private IP, consider using **Application Gateway v2**, where static private IP assignment is mandatory.

## Advanced troubleshooting and data collection

If the issue persists:

- Review Application Gateway provisioning state and recent configuration changes.
- Validate DNS resolution from the client perspective.
- Confirm no overlapping private IP usage exists within the virtual network.

## Supportability note

Azure Application Gateway v1 is a legacy SKU. Microsoft announced the retirement of Application Gateway v1, and it will no longer be supported after **April 28, 2026**. New deployments and long‑term designs should use **Application Gateway v2**.

## Related content

- [Private IP address allocation](/azure/application-gateway/configuration-frontend-ip#public-and-private-ip-address-support)
- [Migrate from Application Gateway V1 to V2](/azure/application-gateway/v1-retirement)
