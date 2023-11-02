---
title: Troubleshoot Node Not Ready state when certificates have expired
description: Troubleshoot scenarios in which Node Not Ready failures occur in an Azure Kubernetes Service (AKS) cluster node if there are expired certificates.
ms.date: 04/15/2022
ms.reviewer: rissing, chiragpa, momajed, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-node-not-ready
#Customer intent: As an Azure Kubernetes user, I want to fix expired certificates so that they don't cause Node Not Ready failures within an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot Node Not Ready failures if there are expired certificates

This article helps you troubleshoot Node Not Ready scenarios within a Microsoft Azure Kubernetes Service (AKS) cluster if there are expired certificates.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)
- The [OpenSSL](https://www.openssl.org/source/) command-line tool for certificate display and signing

## Symptoms

You discover that an AKS cluster node is in the Node Not Ready state.

## Cause

There are one or more expired certificates.

## Prevention: Run OpenSSL to sign the certificates

Check the expiration dates of certificates by invoking the [openssl-x509](https://www.openssl.org/docs/man3.0/man1/openssl-x509.html) command, as follows:

- For virtual machine (VM) scale set nodes, use the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command:

  ```azurecli
  az vmss run-command invoke \
      --resource-group <resource-group-name> \
      --name <vm-scale-set-name> \
      --command-id RunShellScript \
      --instance-id 0 \
      --output tsv \
      --query "value[0].message" \
      --scripts "openssl x509 -in /etc/kubernetes/certs/apiserver.crt -noout -enddate"
  ```

- For VM availability set nodes, use the [az vm run-command invoke](/cli/azure/vm/run-command#az-vm-run-command-invoke) command:

  ```azurecli
  az vm run-command invoke \
      --resource-group <resource-group-name> \
      --name <vm-availability-set-name> \
      --command-id RunShellScript \
      --output tsv \
      --query "value[0].message" \
      --scripts "openssl x509 -in /etc/kubernetes/certs/apiserver.crt -noout -enddate"
  ```

You might receive certain error codes after you invoke these commands. For information about error codes 50, 51, and 52, see the following links, as necessary:

- [Troubleshoot the OutboundConnFailVMExtensionError error code (50)](error-code-outboundconnfailvmextensionerror.md)
- [Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)](error-code-k8sapiserverconnfailvmextensionerror.md)
- [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md)

If you receive error code 99, this indicates that the [apt-get update](https://linux.die.net/man/8/apt-get) command is being blocked from accessing one or more of the following domains:

- security.ubuntu.com
- azure.archive.ubuntu.com
- nvidia.github.io

To allow access to these domains, update the configuration of any blocking firewalls, network security groups (NSGs), or network virtual appliances (NVAs).

## Solution: Rotate the certificates

You can apply [certificate auto rotation](/azure/aks/certificate-rotation#certificate-auto-rotation) to rotate certificates in the nodes before they expire. This option requires no downtime for the AKS cluster.

If you can accommodate cluster downtime, you can [manually rotate the certificates](/azure/aks/certificate-rotation#rotate-your-cluster-certificates) instead.

> [!NOTE]
> Starting in the [July 15, 2021, release of AKS](https://github.com/Azure/AKS/releases/tag/2021-07-15), an AKS cluster upgrade automatically helps to rotate the cluster certificates. However, this behavioral change doesn't take effect for an expired cluster certificate. If an upgrade takes only the following actions, the expired certificates won't be renewed:
>
> - Upgrade a node image.
> - Upgrade a node pool to the same version.
> - Upgrade a node pool to a more recent version.
>
> Only a full upgrade (that is, an upgrade for both the control plane and the node pool) helps renew the expired certificates.

## More information

- For general troubleshooting steps, see [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).
