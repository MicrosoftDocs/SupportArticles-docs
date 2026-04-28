---
title: Troubleshoot the VMExtensionError_K8SDownloadTimeout error message
description: Fix the VMExtensionError_K8SDownloadTimeout error in AKS. Learn how to resolve Kubernetes binary download timeouts and successfully create or deploy your AKS cluster.
ms.date: 04/27/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SDownloadTimeout error code so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SDownloadTimeout error in AKS

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SDownloadTimeout` error in Azure Kubernetes Service (AKS) when you try to start, create, or deploy a cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59, or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

- The Client URL (`curl`) command-line tool.

- The Netcat (`nc`) command-line tool.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) DNS lookup tool or the `dig` tool.

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message:

> Code="VMExtensionProvisioningError"
>
> Message="CSE failed with 'VMExtensionError_K8SDownloadTimeout'. AKS node provisioning failed due to a timeout downloading Kubernetes binaries from `<hostname>`. `<diagnostic details>`. For more detailed troubleshooting, see https://aka.ms/aks/vmextensionerror_k8sdownloadtimeout.
  For the complete list of required endpoints, ports and addresses,
  see https://aka.ms/aks/outbound-rules-control-egress and https://aka.ms/aks-required-ports-and-addresses."

In some logs, this error might also appear as exit status 31 or `ExitCode: 31`.

## Cause

During node provisioning, the AKS Custom Script Extension (CSE) downloads Kubernetes binaries from a required AKS endpoint. This error occurs when the node can't complete the download before the CSE timeout is reached.

This issue is especially common in bring-your-own virtual network (BYO VNet) scenarios, where firewall rules, Network Security Groups (NSGs), user-defined routes (UDRs), or proxy settings can block required outbound endpoints. Required endpoints include `mcr.microsoft.com`, `acs-mirror.azureedge.net`, `packages.aks.azure.com`, and `packages.microsoft.com`. For the complete list of required endpoints, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress).

The endpoint is usually `acs-mirror.azureedge.net`. However, use the host name that appears in your error message because the failing endpoint can vary.

Common causes include:

- DNS resolution failures for the download endpoint.
- Firewall, proxy, network virtual appliance (NVA), Network Security Group (NSG), or user-defined route (UDR) rules that block outbound HTTPS traffic.
- TLS inspection or proxy certificate trust issues.
- A generic CSE timeout after repeated download retries.

Use the following table to match the CSE or `curl` error in the error message to the likely cause and the corresponding solution section.

| Message pattern | Likely cause | Next step |
| --- | --- | --- |
| `curl: (6) Could not resolve host: <hostname>` | DNS can't resolve the download endpoint. | [Resolve DNS lookup failures](#resolve-dns-lookup-failures). |
| `curl: (22) The requested URL returned error: 403` | A firewall, proxy, or NVA is denying HTTPS access. | [Resolve firewall, proxy, NVA, NSG, or UDR blocks](#resolve-firewall-proxy-nva-nsg-or-udr-blocks). |
| `curl: (35)`, `unexpected eof while reading`, or `Connection reset by peer` | The HTTPS connection is being reset or interrupted. Firewall, proxy, NVA, or TLS inspection behavior can cause this issue. | [Resolve firewall, proxy, NVA, NSG, or UDR blocks](#resolve-firewall-proxy-nva-nsg-or-udr-blocks), and then [Resolve TLS inspection or certificate trust failures](#resolve-tls-inspection-or-certificate-trust-failures). |
| `curl: (60) SSL certificate problem`, `unknown CA`, or `self signed certificate in certificate chain` | The node doesn't trust the TLS inspection or proxy certificate chain. | [Resolve TLS inspection or certificate trust failures](#resolve-tls-inspection-or-certificate-trust-failures). |
| `curl: (124)` or `curl timed out while connecting to ...` | TCP 443 connectivity to the download endpoint is timing out. | [Resolve firewall, proxy, NVA, NSG, or UDR blocks](#resolve-firewall-proxy-nva-nsg-or-udr-blocks). |
| `Error: CSE has been running for <seconds> seconds, exceeding the limit of <seconds> seconds` | The detailed `curl` symptom might be missing or truncated. | [Run the baseline connectivity checks](#run-the-baseline-connectivity-checks). |
| Other errors | The error details are unavailable or truncated. | [Run the baseline connectivity checks](#run-the-baseline-connectivity-checks). |

## Solution

### Identify the download endpoint

In the error message, locate the host name after `downloading Kubernetes binaries from`. Use that value as `<hostname>` in the commands in this article.

If the host name isn't shown in the AKS operation error, review the failed node virtual machine scale set (VMSS) instance extension status for the CSE output. You can also test against `acs-mirror.azureedge.net` if that endpoint appears in the CSE output or if the error doesn't include a different host name.

### Resolve DNS lookup failures

If the error includes `curl: (6) Could not resolve host`, verify that DNS can resolve the download endpoint from the node subnet or from a VM that uses the same DNS and network path.

Run one of the following commands:

```bash
nslookup <hostname>
dig <hostname>
```

If you can't access the node through Secure Shell (SSH), test from the VMSS instance by using the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command:

```azurecli
# Get the VMSS instance IDs.
az vmss list-instances --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --output table

# Use an instance ID to test DNS resolution.
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "nslookup <hostname>"
```

If DNS resolution fails, verify the following settings:

- The custom DNS server can resolve the download endpoint.
- DNS forwarding or resolver rules are configured correctly.
- The node subnet can reach the configured DNS servers.
- Firewall rules don't block DNS traffic between the node subnet and DNS servers.
- If a proxy is used, the proxy can resolve the download endpoint.

### Resolve firewall, proxy, NVA, NSG, or UDR blocks

If the error includes HTTP 403, `curl` timeout code 124, repeated `Trying <IP>:443...` lines, or connection reset messages, verify outbound HTTPS access from the node subnet to the download endpoint.

In **BYO VNet** clusters, start with the network controls that you manage for the node subnet. Confirm that NSGs, UDRs, firewalls, NVAs, and proxies allow the node to reach the required AKS outbound endpoints.

> [!NOTE]
> Not allowing required AKS endpoints correctly causes most cases of this error. Make sure that outbound HTTPS access is allowed for endpoints such as `mcr.microsoft.com`, `acs-mirror.azureedge.net`, `packages.aks.azure.com`, and `packages.microsoft.com`. The complete required endpoint list is maintained in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress).

Run the following commands from a node, from a VMSS instance, or from a test VM that uses the same subnet, route table, DNS, firewall, and proxy path:

```bash
nc -vz <hostname> 443
curl -Iv --connect-timeout 10 https://<hostname>/
```

If you use a proxy, also test the proxy path:

```bash
curl --proxy http://<http-proxy-address>:<port>/ --head https://<hostname>/
curl --proxy https://<https-proxy-address>:<port>/ --head https://<hostname>/
```

If you can't access the node through SSH, run the test by using `az vmss run-command invoke`:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "nc -vz <hostname> 443 && curl -Iv --connect-timeout 10 https://<hostname>/"
```

If the connectivity test fails, verify the following settings:

- NSG outbound rules allow TCP port 443 from the node subnet.
- UDRs send traffic through the expected next hop.
- Firewall or NVA rules allow outbound HTTPS to the required AKS endpoints.
- Proxy allowlists permit `CONNECT <hostname>:443`.
- `HTTPS_PROXY` and `NO_PROXY` settings are correct for the cluster.
- Firewall, proxy, or NVA logs don't show denied or reset connections.

If you use Azure Firewall, make sure that your application rules include the `AzureKubernetesService` FQDN tag. For more information, see [Azure Firewall](/azure/aks/outbound-rules-control-egress#azure-firewall).

### Resolve TLS inspection or certificate trust failures

If the error includes `curl: (60) SSL certificate problem`, `unknown CA`, or `self signed certificate in certificate chain`, a proxy or TLS inspection device might be presenting a certificate chain that the node doesn't trust.

Run the following command to inspect the TLS handshake:

```bash
curl -Iv --connect-timeout 10 https://<hostname>/
```

If the TLS handshake fails because of certificate trust, use one of the following fixes:

- Bypass TLS inspection for AKS required endpoints.
- Configure the proxy or TLS inspection device to present a certificate chain that the node trusts.
- Make sure the node image and bootstrap path trust the required enterprise root or intermediate certificate authority (CA) certificates.

If the error includes `curl: (35)`, `unexpected eof while reading`, or `Connection reset by peer`, check both TLS inspection logs and firewall, proxy, or NVA logs. These errors can occur when an intermediate device interrupts the TLS handshake or resets the connection.

### Run the baseline connectivity checks

If the error only shows a generic CSE timeout or if the `curl` details are unavailable, run the following checks in order. Stop at the first failed check and fix that issue.

1. Verify DNS resolution:

   ```bash
   nslookup <hostname>
   ```

1. Verify TCP port 443 connectivity:

   ```bash
   nc -vz <hostname> 443
   ```

1. Verify HTTPS and TLS handshake:

   ```bash
   curl -Iv --connect-timeout 10 https://<hostname>/
   ```

1. If a proxy is configured, verify that the proxy allows HTTPS access to the endpoint:

   ```bash
   curl --proxy http://<http-proxy-address>:<port>/ --head https://<hostname>/
   ```

1. Review NSG, UDR, firewall, NVA, proxy, and Azure Firewall FQDN tag configuration.

If all checks pass but the AKS operation still fails, collect the failed node VM extension status and the CSE output from the VMSS instance, and then contact Azure Support.

## More information

- [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress)
- [Required ports and addresses for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress#required-outbound-network-rules-and-fqdns-for-aks-clusters)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
