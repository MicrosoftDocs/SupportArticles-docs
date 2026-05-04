---
title: Troubleshoot Load Balancer in a failed state
description: Learn how to identify and resolve issues when an Azure Load Balancer enters a failed state, including steps to recover the resource and restore traffic flow.
services: load-balancer
ms.service: azure-load-balancer
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/29/2026
ms.custom: engagement-fy23
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Troubleshoot Azure Load Balancer in a failed state

## Summary

An Azure Load Balancer can enter a failed state due to provisioning or configuration problems. When this state occurs, the load balancer might not distribute traffic correctly to backend virtual machines (VMs). This article explains how to identify a failed load balancer, recover the resource, and restore normal traffic flow.

### Solution

To resolve a failed Azure Load Balancer, follow these steps:

1. Go to [Azure Resource Explorer](https://resources.azure.com/) and identify the resource that's in a failed state.
1. Update the toggle to **Read/Write**.
1. Select **Edit** for the resource in failed state.
1. Select **PUT** > **GET** to ensure that the provisioning state is changed to **Succeeded**.