---
title: Move resources error signature triage map for Azure virtual machines
description: Find the right troubleshooting article for Azure VM migration errors by matching error code, text, and behavior in this triage map.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/08/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Move resources error signature triage map for Azure virtual machines

## Summary

Use this move resources triage map to find the fastest path to the right troubleshooting article for Azure virtual machine (VM) move and migration failures.

## Track by using a known signal

Use the following table to find the right troubleshooting article for your Azure VM move or migration failure.

| Signal you see | Problem category | Recommended article |
|---|---|---|
| `AnotherOperationInProgress`, `DeploymentActive` | Active operation conflicts and transient failures | [Move is blocked because another deployment is still active](move-resources-deployment-active-blocks-move.md) |
| `RequestConflict`, provisioning state not terminal | Active operation conflicts and transient failures | [Move fails with request conflict because resources aren't in a terminal provisioning state](move-resources-request-conflict-provisioning-state-not-terminal.md) |
| `ResourcesBeingMoved`, resource group updating | Active operation conflicts and transient failures | [Move fails because resources are already being moved or the resource group is updating](move-resources-resources-moved-resource-group-update.md) |
| Operation hits 4-hour limit | Active operation conflicts and transient failures | [Move fails because the operation exceeded the four-hour limit](move-resources-operation-timeout-4-hour-limit.md) |
| `InternalServerError` with no useful detail, empty `BadRequest` body | Active operation conflicts and transient failures | [Move fails with InternalServerError or empty BadRequest message](move-resources-internalservererror-empty-badrequest.md) |
| Destination policy deny, policy compliance failure | Validation and policy failures | [Move is blocked by destination Azure Policy](move-resources-blocked-by-destination-policy.md) |
| `ResourceMoveProviderValidationFailed` with `CrossSubscriptionMoveOfResourceWithSSECMK`, disk encrypted with Azure Disk Encryption or Azure Customer-Managed Keys | Validation and policy failures | [Move is blocked because the disk uses Azure Disk Encryption](move-resources-azure-disk-encryption-blocked.md) |
| `MissingRegistrationState` for `Microsoft.KeyVault/vaults`, disk encryption set (DES) or Azure Customer-Managed Keys (CMK) dependency missing at destination | Validation and policy failures | [Move fails because Disk Encryption Set or CMK access is denied](move-resources-cmk-disk-encryption-set-access-denied.md) |
| `BatchResponseItemError`, `CannotMoveResource`, or orchestration error across multiple resources in one move request | Validation and policy failures | [Move fails because the batch orchestration step failed](move-resources-batch-orchestration-failed.md) |
| `ReadOnlyLock` or `CanNotDelete` lock on source or destination resource group | Validation and policy failures | [Move is blocked by a resource lock](move-resources-resource-locks-blocking-move.md) |
| VM extension in failed or stuck provisioning state before move | Validation and policy failures | [Move is blocked because a VM extension is in a failed state](move-resources-extension-failed-state.md) |
| Provider validation failure from `Microsoft.Compute` or `Microsoft.Network` | Validation and policy failures | [Move fails provider validation](move-resources-provider-validation-failed.md) |
| Validation failed due to incompatible settings | Validation and policy failures | [Move fails validation because resource settings are incompatible](move-resources-validation-failed-resource-settings.md) |
| Name already exists at destination | Validation and policy failures | [Move fails because a resource name already exists at destination](move-resources-name-conflict-at-destination.md) |
| Load balancer, private endpoint, Network adapter dependency mismatch | Dependency blocks | [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md) |
| `MissingMoveDependentResources`, virtual network (VNet) or subnet must move with VM | Dependency blocks | [Move fails because VNet dependencies must move together](move-resources-vnet-dependencies-must-move-together.md) |
| Proximity placement group (`PPG`) constraint or active deployment conflict while moving VM placement-bound resources | Dependency blocks | [Move fails because a proximity placement group constraint blocks validation](move-resources-proximity-placement-group-constraint.md) |
| Private endpoint blocks move, `PrivateEndpoint` dependency validation fails | Dependency blocks | [Move is blocked by a private endpoint dependency](move-resources-private-endpoint-dependency-block.md) |
| Recovery Services Vault stuck in move state, `EntitiesPresentInVault`, backup lock prevents move | Dependency blocks | [Move is blocked by a backup lock on a Recovery Services Vault](move-resources-backup-lock-recovery-services-vault.md) |
| `ResourceMoveProviderValidationFailed` with Azure Site Recovery replication active | Dependency blocks | [Move is blocked because Azure Site Recovery replication is enabled](move-resources-site-recovery-replication-enabled.md) |
| `RestorePoint` or hidden snapshot residue prevents validation | Dependency blocks | [Move is blocked by hidden restore point or snapshot residue](move-resources-hidden-restore-point-snapshot-residue.md) |
| Managed identity access drift after move | Dependency blocks | [Move fails because managed identity role assignments drift at destination](move-resources-managed-identity-rbac-drift.md) |
| `VMSizeNotAvailable`, destination SKU constraints | Unsupported scope and platform constraints | [Move fails because VM size isn't available at destination](move-resources-resize-blocked-disk-constraints.md) |
| Reservation or capacity association conflict, `SkuNotAvailable` after move | Unsupported scope and platform constraints | [Move fails because of a reservation or capacity association conflict](move-resources-reservation-capacity-association-conflict.md) |
| Ephemeral OS disk unsupported | Unsupported scope and platform constraints | [Move isn't supported for ephemeral OS disk deployments](move-resources-ephemeral-os-disk-not-supported.md) |
| Azure Virtual Machine Scale Sets with Standard Load Balancer or Standard Public IP | Unsupported scope and platform constraints | [Move isn't supported for VM Scale Sets that use Standard Load Balancer or Standard public IP](move-resources-vmss-standard-lb-public-ip-constraint.md) |
| `ResourceNotFound` references `Microsoft.Network/publicIPAddresses` after relocation or move validation | Post-move and relocation follow-up | [Region relocation doesn't retain public IP addresses](move-resources-region-relocation-public-ip-not-retained.md) |
| Workload broken after successful move | Post-move and relocation follow-up | [Move succeeded but the VM is up and the workload is still broken](move-resources-post-move-vm-up-workload-broken.md) |
| Post-relocation Domain Name System (DNS) or routing still points to source | Post-move and relocation follow-up | [Region relocation succeeds but DNS, probes, or front-end routing still point to the source environment](move-resources-post-relocation-dns-probe-routing-still-source.md) |

## Signal is unclear

If the signal is unclear, follow these steps:

1. Refer to the [Pre-flight checklist for moving VM resources](move-resources-preflight-checklist.md).
1. Use [Troubleshoot validation-failed move errors](move-resources-troubleshoot-validation-failed-dispatcher.md) for code-to-article routing.
1. If the operation is active for a long time, see [Move operation is taking longer than expected](move-resources-operation-duration-expected.md).

## References

- [Migration and Move](../windows/welcome-virtual-machines-windows.yml)
- [Move resources troubleshooting overview](move-resources-preflight-checklist.md)
