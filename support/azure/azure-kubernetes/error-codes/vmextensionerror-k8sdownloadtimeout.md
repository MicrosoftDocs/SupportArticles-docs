---
title: Troubleshoot the VMExtensionError_K8SDownloadTimeout error message
description: Fix the VMExtensionError_K8SDownloadTimeout error in AKS. Learn how to resolve Kubernetes binary download timeouts and successfully create or deploy your AKS cluster.
ms.date: 04/27/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SDownloadTimeout error so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SDownloadTimeout error in Azure Kubernetes Service

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SDownloadTimeout` error in Azure Kubernetes Service (AKS) when you try to start, create, or deploy a cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or later. If Azure CLI is already installed, run `az --version` to find the version number.

- The Client URL (`curl`) command-line tool.

- The Netcat (`nc`) command-line tool.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) DNS lookup tool or the `dig` tool.

- The OpenSSL (`openssl`) command-line tool.

## Symptoms

When you try to start, create, or deploy an AKS cluster, you receive the following error message:

> Code="VMExtensionProvisioningError"
>
> Message="CSE failed with 'VMExtensionError_K8SDownloadTimeout'. AKS node provisioning failed due to a timeout downloading Kubernetes binaries from `<hostname>`. `<diagnostic details>`. For more detailed troubleshooting, see https://aka.ms/aks/vmextensionerror_k8sdownloadtimeout.
> For the complete list of required endpoints, ports, and addresses, see https://aka.ms/aks/outbound-rules-control-egress and https://aka.ms/aks-required-ports-and-addresses."

In some logs, this error might also appear as **exit status 31** or `ExitCode: 31`.

## Causes

During node provisioning, the AKS Custom Script Extension (CSE) downloads Kubernetes binaries from a required AKS endpoint. This error occurs if the node can't finish the download before the CSE timeout is reached.

This issue is common in bring-your-own virtual network (BYO VNet) scenarios. In such scenarios, firewall rules, network security groups (NSGs), user-defined routes (UDRs), or proxy settings can block required outbound endpoints. Required endpoints include `mcr.microsoft.com`, `acs-mirror.azureedge.net`, `packages.aks.azure.com`, and `packages.microsoft.com`. For the complete list of required endpoints, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress).

The endpoint is usually `acs-mirror.azureedge.net`. However, you should use the host name that appears in the error message because the failing endpoint can vary.

Common causes include:

- DNS resolution failures for the download endpoint
- Firewall, proxy, network virtual appliance (NVA), NSG, or UDR rules that block outbound HTTPS traffic
- TLS inspection or proxy certificate trust issues
- A generic CSE timeout after repeated download retries

Use the following table to match the CSE or `curl` error in the error message to the likely cause and corresponding solution.

| Message pattern | Likely cause | Solution |
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

In the error message, locate the host name that follows `downloading Kubernetes binaries from`. Use that value as `<hostname>` in the commands in this article.

If the host name isn't shown in the AKS operation error message, review the failed node virtual machine scale set (VMSS) instance extension status for the CSE output. You can also test against `acs-mirror.azureedge.net` if that endpoint appears in the CSE output or if the error doesn't include a different host name.

### Find the node resource values for the checks

Some checks in this article run against the AKS node resources, not the AKS cluster resource itself. AKS node resources are usually in a managed resource group whose name starts as `MC_`.

To find the values to use later in this article, use Azure CLI to run the following commands:

```azurecli
# Get the AKS managed resource group that contains the node resources.
az aks show --resource-group <cluster-resource-group-name> \
   --name <cluster-name> \
   --query nodeResourceGroup \
   --output tsv

# List the VM scale sets in the managed resource group.
az vmss list --resource-group <mc-resource-group-name> \
   --query "[].name" \
   --output table

# List instances in the VM scale set.
az vmss list-instances --resource-group <mc-resource-group-name> \
   --name <vmss-name> \
   --query "[].{instanceId:instanceId,name:name,provisioningState:provisioningState}" \
   --output table
```

The first command returns the managed resource group name to use as `<mc-resource-group-name>`. The second command returns the node pool VMSS names. The third command returns instance IDs to use as `<vmss-instance-id>`. If you have multiple node pools or VM scale sets, start by using the VMSS that contains the failed instance that's shown in the AKS operation error message. If the message doesn't identify an instance, test one instance from the affected node pool.

To find the node network interface ID for Network Watcher and effective NSG or route checks, run the following command:

```azurecli
az vmss nic list --resource-group <mc-resource-group-name> \
   --vmss-name <vmss-name> \
   --instance-id <vmss-instance-id> \
   --query "[0].id" \
   --output tsv
```

The command should return a resource ID for the node network interface. Use that value as `<node-nic-id>` in later commands.

To find the node subnet, run the following command:

```azurecli
az network nic show --ids <node-nic-id> \
   --query "ipConfigurations[0].subnet.id" \
   --output tsv
```

The command should return the subnet resource ID for the node. Use this subnet when you review NSGs, route tables, firewall source ranges, proxy source ranges, or Network Watcher checks in the [Azure portal](https://portal.azure.com).

### Review the failed node VM extension status

If the diagnostic message tells you to review the failed node VM extension status, check the VMSS instance view for the failed node. The extension output often contains the exact `curl` error and the endpoint that failed.

To get the VMSS instance view, run the following command:

```azurecli
az vmss get-instance-view --resource-group <mc-resource-group-name> \
   --name <vmss-name> \
   --instance-id <vmss-instance-id> \
   --output json
```

In the output, look for extension status or substatus messages that mention `VMExtensionError_K8SDownloadTimeout`, `CSE`, `curl`, `download`, or the endpoint host name. If you find a specific `curl` error, use the table in the [Causes](#causes) section to choose the matching solution section. If the output is truncated or doesn't show a specific `curl` error, go to [Run the baseline connectivity checks](#run-the-baseline-connectivity-checks).

### Resolve DNS lookup failures

If the error includes `curl: (6) Could not resolve host`, verify that DNS can resolve the download endpoint from the node subnet or from a VM that uses the same DNS and network path.

Run one of the following commands:

```bash
nslookup <hostname>
dig <hostname>
```

The command should return one or more IP addresses for `<hostname>`. If it returns `NXDOMAIN` or `SERVFAIL`, if it times out, or if it doesn't return an address, troubleshoot DNS resolution before you continue to run connectivity checks.

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

The `az vmss list-instances` command should return the node instance IDs. The `az vmss run-command invoke` output should include the `nslookup` result in the command output. If the command can't run on the instance, verify that the VMSS instance exists and that the Azure VM agent can run commands on the node.

If DNS resolution fails, verify the following settings:

- The custom DNS server can resolve the download endpoint.
- DNS forwarding or resolver rules are configured correctly.
- The node subnet can reach the configured DNS servers.
- Firewall rules don't block DNS traffic between the node subnet and DNS servers.
- If a proxy is used, the proxy can resolve the download endpoint.

### Resolve firewall, proxy, NVA, NSG, or UDR blocks

If the error includes HTTP 403, `curl` timeout code 124, repeated `Trying <IP>:443...` lines, or connection reset messages, verify the outbound HTTPS access from the node subnet to the download endpoint.

In BYO VNet clusters, start at the network controls that you manage for the node subnet. Verify that NSGs, UDRs, firewalls, NVAs, and proxies allow the node to reach the required AKS outbound endpoints.

> [!NOTE]
> The likeliest cause of this error is that NSG outbound rules don't correctly allow access to the required AKS endpoints. Make sure that outbound HTTPS access is allowed for endpoints such as `mcr.microsoft.com`, `acs-mirror.azureedge.net`, `packages.aks.azure.com`, and `packages.microsoft.com`. The complete required endpoint list is maintained in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress).

Run the following command from a node, from a VMSS instance, or from a test VM that uses the same subnet, route table, DNS, firewall, and proxy path:

```bash
nc -vz <hostname> 443
curl -Iv --connect-timeout 10 https://<hostname>/
```

For `nc`, a successful test usually shows that the connection to port 443 succeeded or is open. A timeout, a refused connection, or no route message indicates that a network control might be blocking the TCP connection. For `curl`, look for a completed TLS handshake and an HTTP response. A `curl` timeout, connection reset, "HTTP 403" status code, or certificate error identifies the next area to investigate.

If you use a proxy, also test the proxy path:

```bash
curl --proxy http://<http-proxy-address>:<port>/ --head https://<hostname>/
curl --proxy https://<https-proxy-address>:<port>/ --head https://<hostname>/
```

The proxy test should show that the proxy can establish a connection to `<hostname>:443` and return an HTTP response. If the proxy returns `403`, `407`, a timeout, or a connection reset, check the proxy allowlist, authentication, and TLS inspection policy.

If you can't access the node through SSH, run the test by using `az vmss run-command invoke`:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "nc -vz <hostname> 443 && curl -Iv --connect-timeout 10 https://<hostname>/"
```

Review the run-command output for the same `nc` and `curl` success or failure patterns. If `nc` fails, focus on TCP port 443 routing or firewall controls. If `nc` succeeds but `curl` fails, focus on HTTP proxy behavior, TLS inspection, or certificate trust.

If the connectivity test fails, verify the settings in the following sections. These checks don't have to be completed in any specific order. Start at the network control that applies to your cluster, and then check the other controls that are in the node subnet's outbound path.

#### Verify NSG outbound rules

Verify that NSG outbound rules allow TCP port 443 from the node subnet.

Identify the node VMSS instance network interface, and then review the effective NSG rules:

```azurecli
# Get the VMSS instance network interface ID.
az vmss nic list --resource-group <mc-resource-group-name> \
   --vmss-name <vmss-name> \
   --instance-id <vmss-instance-id> \
   --query "[0].id" \
   --output tsv

# Review effective NSG rules for that network interface.
az network nic list-effective-nsg --ids <node-nic-id> --output table
```

The first command should return the network interface ID for the selected node instance. The effective NSG output shows the rules that actually apply after subnet-level and network-interface-level NSGs are combined.

Verify that no higher-priority rule denies outbound TCP traffic from the node subnet to the destination IP address on port 443. 

To check a specific flow in the Azure portal:

1. Go to **Network Watcher** > **IP flow verify**. 
1. Select the node VMSS instance network interface.
1. Set **Direction** to **Outbound**, **Protocol** to **TCP**, and **Remote port** to **443**. 
1. Use the resolved IP address for `<hostname>` as the remote IP address.

#### Verify UDRs for user-defined routing clusters

If the cluster uses user-defined routing, verify that UDRs send traffic through the expected next hop.

This check applies to only clusters that use the AKS `userDefinedRouting` outbound type or clusters whose node subnet has a route table that's associated with it. These configurations are commonly used if outbound traffic is forced through Azure Firewall, an NVA, or another controlled egress path.

To check the AKS outbound type, run the following command:

```azurecli
az aks show --resource-group <cluster-resource-group-name> \
   --name <cluster-name> \
   --query networkProfile.outboundType \
   --output tsv
```

The output shows the cluster outbound type, such as `loadBalancer`, `managedNATGateway`, or `userDefinedRouting`. If the output is `userDefinedRouting`, complete the UDR-specific checks in this section.

If the output isn't `userDefinedRouting`, and the node subnet doesn't have a route table associated with it, skip the UDR-specific checks.

#### Review the effective route table for the same node network interface

To review the effective route table for the node network interface, run the following command:

```azurecli
az network nic show-effective-route-table --ids <node-nic-id> --output table
```

The output shows the routes that apply to the node network interface after system routes, Border Gateway Protocol (BGP) routes, and UDRs are evaluated. Look for the route that matches the resolved IP address for `<hostname>`, and verify that the next hop is the one you expect.

Verify that traffic to the resolved IP address for `<hostname>` is routed to the expected next hop, such as internet, Azure Firewall, or your NVA. In the Azure portal, you can also use **Network Watcher** > **Next hop** to test the route from the node VMSS instance network interface to the resolved IP address for `<hostname>`.

#### Verify firewall or NVA rules

Verify that firewall or NVA rules allow outbound HTTPS to the required AKS endpoints.

If you use Azure Firewall, make sure that your application rules include the `AzureKubernetesService` fully qualified domain name (FQDN) tag or explicit allow rules for the required FQDNs. In the Azure portal, go to the firewall policy or firewall rules and verify that the rule collection allows HTTPS traffic from the node subnet to the required AKS endpoints. For more information, see [Azure Firewall](/azure/aks/outbound-rules-control-egress#azure-firewall).

If Azure Firewall diagnostic logs are enabled, review the application rule and network rule logs around the time of the failed AKS operation or failed `curl` test:

1. In the Azure portal, open the firewall or firewall policy.
1. Check **Monitoring** > **Logs** or the configured diagnostic destination. 
1. Search for the failing host name, the node private IP address, the destination IP address, and **port 443**. 
1. Look for **deny**, **reset**, or **rule-not-matched** entries.

If you use an NVA or a third-party firewall, check the vendor logs for **denied**, **reset**, or **TLS-inspection-failed** events from the node private IP address to `<hostname>:443`.

#### Verify proxy allowlists

Verify that proxy allowlists permit `CONNECT <hostname>:443`.

From a node, a VMSS instance, or a test VM that uses the same proxy path, run the following command:

```bash
curl --proxy http://<http-proxy-address>:<port>/ -Iv --connect-timeout 10 https://<hostname>/
```

A working proxy path usually shows `HTTP/1.1 200 Connection established` or `CONNECT tunnel established` before the TLS handshake continues. If the proxy returns `403`, `407`, or another deny response, update the proxy allowlist, authentication, or policy so that it permits `CONNECT <hostname>:443` for the node subnet.

#### Verify cluster proxy settings

Verify that `HTTPS_PROXY` and `NO_PROXY` settings are correct for the cluster.

If the cluster uses the AKS HTTP proxy feature, review the cluster proxy configuration:

```azurecli
az aks show --resource-group <cluster-resource-group-name> \
   --name <cluster-name> \
   --query httpProxyConfig
```

If the cluster uses the AKS HTTP proxy feature, the output shows values like `httpProxy`, `httpsProxy`, `noProxy`, and `trustedCa`. If the output is empty or `null`, the AKS HTTP proxy feature isn't configured for the cluster.

Verify that `httpsProxy` points to the expected proxy, and that `noProxy` includes addresses that should bypass the proxy, such as private cluster endpoints, service Classless Inter-Domain Routing (CIDR) blocks, pod CIDRs, node subnet ranges, and internal domains that are required by your environment. In the Azure portal, go to the AKS cluster, open **Networking**, and review the HTTP proxy configuration if it's configured for the cluster.

#### Review firewall, proxy, or NVA logs

Verify that firewall, proxy, or NVA logs don't show denied or reset connections.

Match the timestamp of the failed AKS operation or the failed `curl` test with logs from the network device. Search by source node private IP address, destination IP address, destination FQDN, and port 443. A **deny**, **reset**, **connection timeout**, **TLS inspection failure**, or **proxy authentication failure** entry in those logs identifies the control that must be updated.

### Resolve TLS inspection or certificate trust failures

If the error includes `curl: (60) SSL certificate problem`, `unknown CA`, or `self signed certificate in certificate chain`, a proxy or TLS inspection device might present a certificate chain that the node doesn't trust.

If the AKS diagnostic message instructs you to configure TLS inspection or proxy trust, this message means that AKS nodes must be able to make trusted HTTPS connections to the required AKS endpoints. To fix this problem, either exclude the required AKS endpoints from TLS inspection or configure the proxy or TLS inspection device and the cluster so that the nodes trust the certificate chain that the device presents. After you make the change, verify that `curl -Iv --connect-timeout 10 https://<hostname>/` completes certificate verification and returns an HTTP response.

Run the following command to inspect the TLS handshake:

```bash
curl -Iv --connect-timeout 10 https://<hostname>/
```

The output shows whether the TCP connection, proxy tunnel, TLS handshake, and certificate verification succeed. Use the following table to interpret the most common TLS-related patterns. If the TLS handshake fails, review the command output to determine where this occurs.

| Output pattern | What it means | Next step |
| --- | --- | --- |
| `SSL certificate problem`, `unable to get local issuer certificate`, `self signed certificate in certificate chain`, or `unknown CA` | The node doesn't trust the certificate chain that it received. | Make the presented certificate chain trusted by using a supported AKS cluster configuration, or bypass TLS inspection for AKS required endpoints. |
| The certificate subject or issuer shows your enterprise proxy, firewall, or TLS inspection device instead of a public Microsoft certificate chain for the endpoint. | TLS inspection is being applied to the connection. | Exclude AKS required endpoints from TLS inspection, or make sure the inspected certificate chain is trusted by the node. |
| `CONNECT tunnel established` followed by a certificate trust error | The proxy connection succeeded, but the TLS certificate that was presented through the proxy isn't trusted by the node. | Update the proxy certificate chain and cluster certificate authority (CA) trust configuration, or bypass TLS inspection for AKS required endpoints. |
| `OpenSSL SSL_connect: Connection reset by peer`, `unexpected eof while reading`, or `curl: (35)` | An intermediate proxy, firewall, NVA, or TLS inspection device might be interrupting the handshake. | Review the device logs for **deny**, **reset**, **connection timeout**, **TLS inspection failure**, or **proxy authentication failure** events for `<hostname>:443`. |
| `SSL certificate verify ok` followed by an HTTP response | The TLS handshake succeeded. | If the AKS operation still fails, continue to run the firewall, proxy, NVA, NSG, or applicable UDR checks. |

Based on your network design, use the fix from one of the following sections, as appropriate.

#### Bypass TLS inspection for AKS required endpoints

Configure your proxy, firewall, NVA, or TLS inspection device so that it doesn't decrypt or re-sign HTTPS traffic for AKS required endpoints. Instead, allow the node to create a direct TLS session to the original endpoint.

At a minimum, apply the bypass to the endpoint from the error message and to the required AKS endpoints that nodes use during provisioning, such as `mcr.microsoft.com`, `acs-mirror.azureedge.net`, `packages.aks.azure.com`, and `packages.microsoft.com`. Use the full endpoint list in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress) for your cluster configuration and Azure environment.

On the network device, use an HTTPS inspection bypass, SSL decryption exception, or no-decrypt rule for the required FQDNs. Make sure that the allow rule still permits outbound TCP 443, and that the proxy allows `CONNECT <hostname>:443` if a proxy is used.

After you configure the bypass, rerun the test:

```bash
curl -Iv --connect-timeout 10 https://<hostname>/
```

The output no longer shows your inspection device as the certificate issuer. The command completes certificate verification or reaches an HTTP response.

#### Configure the proxy or TLS inspection device to present a trusted certificate chain

If you can't bypass TLS inspection, configure the proxy or TLS inspection device to present a complete certificate chain that the AKS node trusts.

On the proxy or TLS inspection device, verify the following settings:

1. Check that the device sends the full certificate chain, including required intermediate CA certificates:

   ```bash
   openssl s_client -connect <hostname>:443 -servername <hostname> -showcerts -verify_return_error </dev/null
   ```

   In the output, review the `Certificate chain` section. The chain should include the leaf certificate and the required intermediate CA certificates. The command should end in `Verify return code: 0 (ok)`. If it ends in `unable to get local issuer certificate`, `unable to verify the first certificate`, or a similar verification error, the device might not be sending the full chain, or the node might not trust the issuing CA.

1. Check that the leaf certificate matches the requested host name by using the Subject Alternative Name (SAN) extension:

   ```bash
   openssl s_client -connect <hostname>:443 -servername <hostname> -showcerts </dev/null 2>/dev/null | \
     openssl x509 -noout -subject -issuer -ext subjectAltName
   ```

   In the `X509v3 Subject Alternative Name` section, verify that the certificate contains the requested host name. For example, the SAN should include `DNS:<hostname>` or a valid wildcard entry that covers the host name. Don't rely on the certificate common name (CN) alone.

1. Check that the signing CA certificates are usable for TLS server authentication and aren't expired:

   ```bash
   openssl s_client -connect <hostname>:443 -servername <hostname> -showcerts </dev/null 2>/dev/null | \
     openssl x509 -noout -issuer -subject -dates -ext basicConstraints -ext keyUsage -ext extendedKeyUsage
   ```

   Review the CA certificates that are configured on the proxy or TLS inspection device. The signing CA must be valid for the current date, and must be allowed to issue server certificates. If an intermediate CA includes the Extended Key Usage (EKU) extension, it should include TLS server authentication. To check revocation, use the certificate revocation list (CRL) or Online Certificate Status Protocol (OCSP) tools that your enterprise CA publishes, or check the CA status in your certificate management system.

1. Check that the certificate algorithm, key size, and TLS version are accepted by the node operating system image:

   ```bash
   curl -Iv --connect-timeout 10 https://<hostname>/
   openssl s_client -connect <hostname>:443 -servername <hostname> -tls1_2 </dev/null
   openssl s_client -connect <hostname>:443 -servername <hostname> -tls1_3 </dev/null
   ```

   In the `curl -Iv` output, review the negotiated TLS version, cipher, certificate signature algorithm, and public key details. In the `openssl s_client` output, verify that the node can complete the handshake by using the TLS versions that the node image supports. If the handshake fails for only the inspected path, update the proxy or TLS inspection device to use certificate and TLS settings that are compatible with the node image.

1. Check that the proxy or TLS inspection policy applies consistently to all required AKS endpoints that are used during node provisioning:

   ```bash
   for endpoint in mcr.microsoft.com acs-mirror.azureedge.net packages.aks.azure.com packages.microsoft.com; do
     echo "Testing ${endpoint}"
     curl -Iv --connect-timeout 10 "https://${endpoint}/"
   done
   ```

   Replace or extend the endpoint list by using the complete set of required FQDNs for your cluster from [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/outbound-rules-control-egress). The result should be consistent for all required endpoints: Either TLS inspection is bypassed for all of them, or the inspected certificate chain is trusted for all of them. Review proxy, firewall, and TLS inspection logs for any endpoint that shows a different issuer, a certificate trust error, or a reset connection.

After you update the device, rerun `curl -Iv`. The TLS failure should be gone. If `curl` still reports a trust error, compare the issuer and chain that `curl` shows with the CA certificates that are installed on the node.

#### Configure the cluster to trust the enterprise CA certificate

If TLS inspection remains enabled, the node must trust the enterprise root or intermediate CA certificate before AKS node provisioning tries to download Kubernetes binaries. If you use a DaemonSet, a post-provisioning script, or a manual change on the node to install the CA certificate after the node is ready, this method won't fix this error. The reason is that the failure occurs during provisioning.

Use an AKS-supported method to provide the enterprise CA certificate for your cluster configuration. The supported methods depend on the cluster configuration and the AKS features that are available in your Azure region.

- If the cluster uses the AKS HTTP proxy feature, configure the proxy CA certificate in the cluster HTTP proxy configuration. For more information, see [HTTP proxy support in Azure Kubernetes Service (AKS)](/azure/aks/http-proxy).
- If [custom certificate authority certificates for Azure Kubernetes Service (AKS)](/azure/aks/custom-certificate-authority) are supported for your cluster configuration, use that feature to provide the enterprise root or intermediate CA certificates.
- If you can't provide the enterprise CA certificate by using a supported AKS configuration, bypass TLS inspection for AKS required endpoints instead of relying on certificate installation after the node is provisioned.

After you configure the supported CA trust option, rerun `curl -Iv --connect-timeout 10 https://<hostname>/` from a node, a VMSS instance, or a test VM that uses the same network path. The command should complete certificate verification and return an HTTP response.

Don't use `curl -k` or `--insecure` as a fix. Those options only bypass certificate validation for the manual test command. They don't change how the AKS node bootstrap process validates certificates.

If the error includes `curl: (35)`, `unexpected eof while reading`, or `Connection reset by peer`, check both TLS inspection logs and firewall, proxy, or NVA logs. These errors can occur if an intermediate device interrupts the TLS handshake or resets the connection.

### Run the baseline connectivity checks

If the error shows only a generic CSE timeout, or if the `curl` details are unavailable, run the following checks in the given order. Stop at the first failed check, and fix that issue.

1. Verify the DNS resolution:

   ```bash
   nslookup <hostname>
   ```

   The command should return one or more IP addresses. If it doesn't return an address, fix DNS resolution before you continue.

1. Verify TCP port 443 connectivity:

   ```bash
   nc -vz <hostname> 443
   ```

   The command should show that the connection to port 443 succeeded or is open. If it times out, is refused, or reports no route, check NSGs, UDRs (if applicable), firewalls, NVAs, and routing.

1. Verify the HTTPS and TLS handshake:

   ```bash
   curl -Iv --connect-timeout 10 https://<hostname>/
   ```

   The command should complete the TLS handshake and return an HTTP response. If it returns a certificate error, connection reset, "HTTP 403" status code, or timeout, use the matching solution section in this article.

1. If a proxy is configured, verify that the proxy allows HTTPS access to the endpoint:

   ```bash
   curl --proxy http://<http-proxy-address>:<port>/ --head https://<hostname>/
   ```

   The command should show that the proxy can reach `<hostname>:443` and return an HTTP response. If it returns `403`, `407`, a timeout, or a connection reset, check the proxy allowlist, authentication, and TLS inspection policy.

1. Review NSG, firewall, NVA, proxy, and Azure Firewall FQDN tag configuration. If the cluster uses `userDefinedRouting`, or the node subnet has a route table associated with it, also review the UDR configuration.

If all checks pass but the AKS operation still fails, collect the failed node VM extension status and the CSE output from the VMSS instance, and then contact Azure Support.

## References

- [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress)
- [Required ports and addresses for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress#required-outbound-network-rules-and-fqdns-for-aks-clusters)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
