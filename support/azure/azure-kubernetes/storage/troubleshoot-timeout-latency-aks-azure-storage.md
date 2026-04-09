---
title: Troubleshoot timeout and latency issues in AKS with Azure Storage
description: "Troubleshoot AKS timeout and latency issues with Azure Storage. Learn diagnostic steps and solutions to improve performance and reliability."
ms.date: 04/09/2026
ms.reviewer: chiragpa, meghadubey
ms.service: azure-kubernetes-service
ms.custom: sap:Storage
---
# Troubleshoot timeout and latency issues in AKS with Azure Storage

## Summary

This article helps you troubleshoot timeout and latency issues in Azure Kubernetes Service (AKS) when using Azure Storage. You'll learn common causes, diagnostic steps, and recommended solutions to improve performance and reliability.

## Symptoms

Applications in AKS experience intermittent timeouts or slow access to Azure Storage accounts. Pod logs show errors like:

- `Connection timeout`.
- `Connection reset by peer`.
- `503 Service Unavailable`.

The `kubectl describe` pod shows no Persistent Volume Claim (PVC) errors, which indicates the problem is network-related.
 
## Causes

- **SNAT port exhaustion**: AKS nodes that use outbound connectivity with Azure Load Balancer can run out of Source Network Address Translation (SNAT) ports under heavy traffic.
- **Public endpoint dependency**: Traffic routed over the public internet is susceptible to transient network problems and DDoS protection throttling.
 
## Solutions

Use the following methods to mitigate connectivity timeouts and improve reliability.

### Enable private endpoints for storage

- Create a private endpoint for the storage account in the same virtual network (VNet) as the AKS cluster.
- Ensure DNS resolves the storage account to the private IP.

This configuration keeps traffic within Azure's backbone network and avoids public network disruptions.

### Use Azure NAT Gateway for outbound connectivity

Assign a NAT Gateway to the AKS subnet to provide:

- Increased SNAT port capacity.
- Stable, dedicated outbound IP.

This setup prevents SNAT exhaustion scenarios that cause intermittent failures.

### Implement application-level connection pooling

- Avoid creating excessive short‑lived outbound connections to Azure Storage.
- Enable persistent or pooled connections in application code or SDK configuration.

### Enable network flow logs and DDoS diagnostic logging

Enable logging to capture connection patterns, drops, and anomalies, including:

- Network security group (NSG) flow logs (or VNet flow logs), which help identify:

    - Dropped packets.
    - Outbound connection failures.
    - Saturated connection patterns.

- DDoS diagnostic logs, which provide visibility into:
    
    - Mitigated attacks.
    - Threshold-triggered throttling events.
    - High-volume spikes potentially impacting outbound calls.

## References

- [Collect and analyze resource logs from an Azure resource in Azure Monitor](/azure/azure-monitor/platform/tutorial-resource-logs?tabs=DDoSProtectionNotifications)