---
title: Troubleshoot the VMExtensionError_K8SAPIServerConnFail error message
description: Fix the VMExtensionError_K8SAPIServerConnFail error in Azure Kubernetes Service. Learn how to resolve API server connectivity failures and successfully create, upgrade, or scale your AKS cluster.
ms.date: 05/01/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerConnFail error code (or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerConnFail error in Azure Kubernetes Service

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerConnFail` error when you try to start, create, upgrade, or scale an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59, or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

- The Client URL (`curl`) command-line tool.

- The Netcat (`nc`) command-line tool.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) DNS lookup tool or the `dig` tool.

- The OpenSSL (`openssl`) command-line tool.

## Symptoms

When you try to start, create, upgrade, or scale an AKS cluster, you receive the following error message:

> Code="VMExtensionProvisioningError"
>
> Message="CSE failed with 'VMExtensionError_K8SAPIServerConnFail'. Agents are unable to establish connection to Kubernetes API server. `<diagnostic details>`. For more detailed troubleshooting, see https://aka.ms/aks/vmextensionerror_k8sapiserverconnfail and https://aka.ms/aks-required-ports-and-addresses for more information."

This error might also appear as **exit status 51** or `ExitCode: 51`.

## Causes

During node provisioning, the AKS Custom Script Extension (CSE) verifies that the node can reach the Kubernetes API server on port 443. This error occurs when the connectivity check fails before the CSE timeout is reached.

This issue is especially common in bring-your-own virtual network (BYO VNet) scenarios, where firewall rules, network security groups (NSGs), user-defined routes (UDRs), or proxy settings can block the API server endpoint. For private clusters, the node must reach the API server through a private endpoint and resolve the `privatelink.*.azmk8s.io` DNS name correctly.

Common causes include:

- Firewall, proxy, NSG, or UDR rules that block outbound TCP port 443 to the API server.
- API server authorized IP ranges that don't include the node subnet.
- Private endpoint provisioning failures or missing DNS configuration.
- TLS inspection or proxy certificate trust issues that break the HTTPS handshake to the API server.
- Transient API server unavailability during cluster create or start operations.

Use the following table to match the diagnostic message in the error to the likely cause and the corresponding solution section.

| Message pattern | Likely cause | Next step |
| --- | --- | --- |
| `Connection timed out` | A firewall, NSG, UDR, or authorized IP range is silently dropping packets to the API server on port 443. | [Resolve connection timeout](#resolve-connection-timeout). |
| `Connection refused` | The API server port isn't accepting connections. This issue is usually transient during cluster create or start. | [Resolve connection refused](#resolve-connection-refused). |
| `No route to host` | The node has no network path to the API server. Routing, peering, or private endpoint configuration is broken. | [Resolve no route to host](#resolve-no-route-to-host). |
| `TLS handshake failed` | An HTTPS-inspecting proxy or firewall is intercepting the TLS connection to the API server. | [Resolve TLS handshake failure](#resolve-tls-handshake-failure). |
| `Certificate name mismatch` or `Certificate verification failed` | A proxy or TLS inspection device is rewriting the API server certificate. | [Resolve certificate problem](#resolve-certificate-problem). |
| Other errors or no diagnostic details | The error details are unavailable or truncated. | [Run the baseline connectivity checks](#run-the-baseline-connectivity-checks). |

## Solution

### Identify the API server endpoint

The error message might contain a diagnostic message that shows the API server FQDN or IP address.

**Example diagnostic messages**

```text
# Connection timeout with IP context:
Node 10.0.2.10 could not reach API server at 98.67.228.23:443. Connection timed out. Check firewall/NSG rules on port 443...

# TLS handshake failure with FQDN:
TLS handshake failed. Check for HTTPS-inspecting proxies or firewalls, and ensure secureaksdns-oxwzkm0h.hcp.uksouth.azmk8s.io is in the allow list.

# Connection refused with API server IP:
API server IP: 98.67.228.23. Connection refused. The API server port is not accepting connections...
```

From these diagnostic messages, take note of the following values:

- **Node IP**: The source IP address (for example, `10.0.2.10`).
- **API Server IP**: The destination IP address (for example, `98.67.228.23`).
- **API Server FQDN**: The hostname in format `*.hcp.<region>.azmk8s.io` (for example, `secureaksdns-oxwzkm0h.hcp.uksouth.azmk8s.io` or `myaks-cluster-dns-a1b2c3d4.hcp.eastus.azmk8s.io`).

Use the returned fully qualified domain name (FQDN) as `<api-server-fqdn>` in the commands in this article.

If the API server endpoint isn't shown in the error message, use Azure CLI to run the following command to get it:

```azurecli
az aks show --resource-group <resource-group> \
  --name <cluster-name> \
  --query "fqdn" \
  --output tsv
```

> [!NOTE]
> For private clusters, use `--query "privateFqdn"` instead of `--query "fqdn"`.

### Find the node resource values for the checks

Some troubleshooting steps require node-level information like the managed resource group name, Virtual Machine Scale Set (VMSS) name, and instance ID. You can find these values by running the following commands:

```azurecli
# Get the managed resource group (MC_*) for your cluster
az aks show --resource-group <resource-group> --name <cluster-name> --query nodeResourceGroup --output tsv

# List VMSS in the managed resource group
az vmss list --resource-group <mc-resource-group> --query "[].name" --output tsv

# List instances in a VMSS
az vmss list-instances --resource-group <mc-resource-group> --name <vmss-name> --query "[].instanceId" --output tsv
```

Use the returned values as placeholders in the commands throughout this article.

> [!TIP]
> If the error message identifies a specific failed VMSS instance, use that instance ID. For clusters with multiple node pools, use the VMSS from the affected node pool shown in the error message.

---

### Resolve connection timeout

If the error includes `Connection timed out`, the node tried to reach the API server on port 443 but received no response.

#### Causes

- **NSG rules** block outbound TCP port 443 from the node subnet.
- **Firewall or UDR** drop packets to the API server IP.
- **API server authorized IP ranges** don't include the node subnet Classless Inter-Domain Routing (CIDR) block.
- **Private clusters** and private endpoints aren't provisioned correctly, or DNS isn't resolving to the private IP.

#### Troubleshooting steps

#### Step 1: Check API server authorized IP ranges (skip if authorized IP ranges not enabled)

If the cluster has authorized IP ranges enabled, the node subnet must be included. Otherwise, the API server silently drops connections from the node.

Run the following command to check if authorized IP ranges are configured:

```azurecli
az aks show --resource-group <resource-group> \
  --name <cluster-name> \
  --query "apiServerAccessProfile.authorizedIpRanges" \
  --output tsv
```

If authorized IP ranges are set, verify that the node subnet CIDR is included. To find the node subnet CIDR, run the following command to get the subnet ID:

```azurecli
az aks show --resource-group <resource-group> \
  --name <cluster-name> \
  --query "agentPoolProfiles[0].vnetSubnetId" \
  --output tsv
```

If no output is returned, the cluster uses an AKS-managed VNet. Run the following command to get the subnet from the managed resource group instead:

```azurecli
az network vnet list --resource-group <mc-resource-group> \
  --query "[0].subnets[0].id" \
  --output tsv
```

Then get the address prefix for that subnet:

```azurecli
az network vnet subnet show --ids <subnet-id> --query "addressPrefix" --output tsv
```

If the node subnet CIDR isn't included in the authorized IP ranges, add it:

```azurecli
az aks update --resource-group <resource-group> \
  --name <cluster-name> \
  --api-server-authorized-ip-ranges "<existing-ranges>,<node-subnet-CIDR>"
```

> [!NOTE]
> If authorized IP ranges are configured and the firewall or NAT gateway outbound IP isn't included, all node traffic to the API server is silently dropped. This is the most common cause of timeout errors for clusters that have authorized IP ranges enabled. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

#### Step 2: Verify NSG outbound rules

Verify that NSG outbound rules allow TCP port 443 from the node subnet to the API server IP.

First, get the NSG associated with the node subnet. Use the subnet ID from Step 1:

```azurecli
az network vnet subnet show --ids <subnet-id> \
  --query "networkSecurityGroup.id" \
  --output tsv
```

If this returns an NSG ID (for example, `/subscriptions/.../resourceGroups/myRG/providers/Microsoft.Network/networkSecurityGroups/myNSG`), extract the resource group and NSG name from the path, then list its rules:

```azurecli
az network nsg rule list --resource-group <nsg-resource-group> \
  --nsg-name <nsg-name> \
  --query "[].{Name:name, Priority:priority, Direction:direction, Access:access, Protocol:protocol, DestPort:destinationPortRange, DestAddr:destinationAddressPrefix}" \
  --output table
```

Review the rules to confirm that no higher-priority rule denies outbound TCP traffic on port 443 to the API server IP address. Look for:
- **Direction**: `Outbound`
- **Access**: `Deny`
- **DestPort**: `443` or `*`
- **DestAddr**: Matches the API server IP or includes it in a range

Alternatively, use Network Watcher in the Azure portal for a specific flow test:
1. Go to **Network Watcher** > **IP flow verify**
2. Select the VMSS instance
3. Set **Direction** to **Outbound**, **Protocol** to **TCP**, **Local IP** to the node IP, **Remote IP** to the API server IP, **Remote port** to **443**

#### Step 3: Verify UDR configuration

If the cluster uses user-defined routing or the node subnet has a route table associated with it, verify that UDRs send traffic through the expected next hop.

```azurecli
az aks show --resource-group <resource-group> \
  --name <cluster-name> \
  --query networkProfile.outboundType \
  --output tsv
```

If the output is `userDefinedRouting`, review the route table. First, get the route table ID from the subnet (use the subnet ID from Step 1):

```azurecli
az network vnet subnet show --ids <subnet-id> \
  --query "routeTable.id" \
  --output tsv
```

Then list the routes:

```azurecli
az network route-table show --ids <route-table-id> \
  --query "routes[].{Name:name, AddressPrefix:addressPrefix, NextHopType:nextHopType, NextHopIP:nextHopIpAddress}" \
  --output table
```

Confirm that traffic to the API server IP is routed to the expected next hop (Internet, Azure Firewall, or your NVA). You can also use **Network Watcher** > **Next hop** in the Azure portal to test routing from the node to the API server IP.

If the next hop is a firewall appliance or NVA, verify that the appliance is running and allows TCP port 443 to the API server FQDN.

#### Step 4: Verify firewall or NVA rules

If you use a firewall or network virtual appliance (NVA), verify that it allows outbound traffic on TCP port 443 to the API server by checking these rules:

- Network rules: Allow outbound TCP port 443 from the node subnet to the API server IP
- Application rules: Include the API server FQDN patterns if FQDN filtering is supported:
  - `*.hcp.<region>.azmk8s.io` (public clusters)
  - `*.privatelink.<region>.azmk8s.io` (private clusters)

Check firewall logs for denied or reset events from the node private IP address to the API server endpoint on port 443.

#### Step 5: Check private endpoint (private clusters)

For private clusters, the node reaches the API server through a private endpoint. Verify that the private endpoint is provisioned correctly and that DNS resolves to the private IP.

```azurecli
az network private-endpoint list --resource-group <mc-resource-group> \
  --query "[?contains(name,'kube-apiserver')].{name:name,state:provisioningState,connectionStatus:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status}" \
  --output table
```

Both `provisioningState` and `connectionStatus` should show `Succeeded` and `Approved`. If not, the private endpoint needs reprovisioning. Try running `az aks update` to reconcile the cluster.

Verify that DNS resolves to the private endpoint IP, not a public IP:

```bash
nslookup <api-server-fqdn>
```

If using a private cluster and testing from outside the VNet, use `az vmss run-command invoke` to run the `nslookup` from a cluster node:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --command-id RunShellScript \
  --instance-id <instance-id> \
  --output json \
  --scripts "nslookup <api-server-fqdn>"
```

The result should include a `privatelink.<region>.azmk8s.io` CNAME that resolves to a private IP address. If it resolves to a public IP, the private DNS zone isn't linked to the node VNet. For more information, see [Create a private AKS cluster](/azure/aks/private-clusters).

#### Step 6: Test connectivity from the node

> [!NOTE]
> This step requires cluster nodes to exist. If cluster creation failed before nodes were provisioned, skip this step and focus on verifying network configuration (NSG, UDR, firewall rules) using the Azure portal or the earlier steps in this section.

If you can't identify the issue from network configuration alone, test connectivity directly from a VMSS instance:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --command-id RunShellScript \
  --instance-id <instance-id> \
  --output json \
  --scripts "nc -vz <api-server-fqdn> 443 && curl -k -v --connect-timeout 10 https://<api-server-fqdn>:443/healthz"
```

Review the output for connection success or failure patterns. If `nc` fails, focus on TCP port 443 routing or firewall controls. If `nc` succeeds but `curl` fails, focus on TLS inspection or proxy behavior.

---

### Resolve connection refused

If the error includes `Connection refused`, the node reached the API server IP but the port isn't accepting connections.

#### Common causes

- **Transient during create or start**: The API server pods aren't ready yet.
- **Persistent**: Network misconfiguration or API server failure.

#### Troubleshooting steps

#### Step 1: Check cluster power state and provisioning state

```azurecli
az aks show --resource-group <resource-group> \
  --name <cluster-name> \
  --query "{powerState:powerState.code, provisioningState:provisioningState}" \
  --output table
```

**Result interpretation:**

- **powerState is `Stopped`**: The cluster is stopped. Start it with `az aks start --resource-group <resource-group> --name <cluster-name>`.
- **provisioningState is `Succeeded`**: The cluster is healthy. The connection-refused error was transient. No action needed.
- **provisioningState is `Creating`, `Updating`, or `Upgrading`**: Operation still in progress. Wait for completion.
- **provisioningState is `Failed`**: Proceed to Step 2.

#### Step 2: Retry the operation

If the cluster is in a `Failed` provisioning state, try reconciling:

```azurecli
az aks update --resource-group <resource-group> \
  --name <cluster-name>
```

**If the error persists after reconciliation**, the issue is likely network misconfiguration. Check:

- For private clusters: Verify the private endpoint provisioned successfully and private DNS zone is linked to the VNet
- For BYO VNet: Verify NSG, UDR, and firewall rules allow outbound traffic to the API server (see [Resolve connection timeout](#resolve-connection-timeout) for detailed network checks)

If the problem persists after verifying network configuration, collect the error details and contact Azure Support.

---

### Resolve no route to host

If the error includes `No route to host`, the node can't reach the API server IP address. No TCP connection was established.

#### Common causes

- **Private clusters**: The private endpoint or Private Link Service (PLS) connection to the API server is unhealthy or not fully provisioned.
- **UDR next-hop down**: UDR routes traffic to a next-hop appliance (firewall/NVA) that is down or unreachable.
- **UDR blackhole**: UDR has a route that drops traffic to the API server IP range.

#### Troubleshooting steps

#### Step 1: Check private endpoint health (private clusters)

For private clusters, `No route to host` often means the private endpoint's backend (the API server PLS) is unreachable, not a routing table issue.

```azurecli
az network private-endpoint list --resource-group <mc-resource-group> \
  --query "[?contains(name,'kube-apiserver')].{name:name,state:provisioningState,connectionStatus:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status}" \
  --output table
```

Both `provisioningState` and `connectionStatus` should show `Succeeded` and `Approved`. If not, try reconciling the cluster with `az aks update`. If the private endpoint shows `Failed` or `Disconnected` after reconciliation, contact Azure Support.

#### Step 2: Check UDR next-hop health

For public clusters, or if the private endpoint is healthy, check if a UDR is routing traffic through a firewall or NVA. Get the route table ID from the subnet (use the subnet ID from [Find the node resource values](#find-the-node-resource-values-for-the-checks) and Step 1 of [Resolve connection timeout](#resolve-connection-timeout)):

```azurecli
az network vnet subnet show --ids <subnet-id> \
  --query "routeTable.id" \
  --output tsv
```

Then list the routes:

```azurecli
az network route-table show --ids <route-table-id> \
  --query "routes[].{Name:name, AddressPrefix:addressPrefix, NextHopType:nextHopType, NextHopIP:nextHopIpAddress}" \
  --output table
```

If `NextHopType` is `VirtualAppliance`, verify the appliance at `NextHopIP` is running and healthy. If `NextHopType` is `None`, traffic to that prefix is dropped. Remove or modify the route.

---

### Resolve TLS handshake failure

If the error includes `TLS handshake failed`, the TCP connection to the API server succeeded but the TLS negotiation failed.

#### Common causes

- **HTTPS-inspecting proxy or firewall**: A proxy or firewall (such as Zscaler, Palo Alto, or Fortinet) is intercepting the TLS connection to the API server.
- **SSL bypass not configured**: The API server FQDN isn't in the proxy's SSL bypass or allow list.
- **SSL decryption enabled**: A firewall is performing SSL decryption on port 443.

#### Troubleshooting steps

#### Step 1: Determine if TLS inspection is in the network path

Test from the node or a VMSS instance:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --command-id RunShellScript \
  --instance-id <instance-id> \
  --output json \
  --scripts "openssl s_client -connect <api-server-fqdn>:443 -servername <api-server-fqdn> </dev/null 2>&1 | grep -E 'issuer|subject|verify'"
```

If the certificate issuer shows a corporate CA or proxy vendor (such as Zscaler, Palo Alto, or Fortinet), TLS inspection is intercepting the connection.

#### Step 2: Add AKS API server FQDNs to the SSL inspection bypass list

Add the following patterns to your proxy or firewall's SSL inspection bypass list:

- `*.hcp.<region>.azmk8s.io` (public clusters)
- `*.privatelink.<region>.azmk8s.io` (private clusters)

Replace `<region>` with the Azure region of your AKS cluster.

For the complete list of required endpoints, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

After updating the bypass list, retest from the node:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --command-id RunShellScript \
  --instance-id <instance-id> \
  --output json \
  --scripts "curl -Iv --cacert /etc/kubernetes/certs/ca.crt --connect-timeout 10 https://<api-server-fqdn>:443/healthz"
```

The output should show a successful TLS handshake with `SSL certificate verify ok`. If the issuer still shows your corporate proxy CA, the bypass rule hasn't taken effect. If the TLS failure persists, check proxy and firewall logs for deny or inspection-failed events for the API server FQDN on port 443.

#### Step 3: If TLS inspection can't be bypassed

If TLS inspection can't be bypassed, the node must trust the certificate chain that the inspection device presents. Use one of the following AKS-supported methods to provide the enterprise CA certificate:

- If the cluster uses the AKS HTTP proxy feature, configure the proxy CA certificate in the cluster HTTP proxy configuration. For more information, see [HTTP proxy support in Azure Kubernetes Service (AKS)](/azure/aks/http-proxy).
- If [custom certificate authority certificates for Azure Kubernetes Service (AKS)](/azure/aks/custom-certificate-authority) are supported for your cluster configuration, use that feature to provide the enterprise root or intermediate CA certificates.

> [!IMPORTANT]
> The CA certificate must be installed before node provisioning. Installing the CA certificate after the node is ready (such as by using a DaemonSet or a post-provisioning script) can't fix this error because the connectivity check runs during provisioning.

---

### Resolve certificate problem

If the error includes `Certificate name mismatch` or `Certificate verification failed`, the TLS connection succeeded but the certificate doesn't match the expected hostname.

#### Common causes

- **HTTPS-intercepting proxy**: A proxy is replacing the API server certificate with its own certificate that doesn't match the API server hostname.
- **Stale certificates**: Certificates are stale after cluster migration or FQDN change.

#### Troubleshooting steps

#### Step 1: Check for proxy certificate injection

Test from the node or a VMSS instance:

```azurecli
az vmss run-command invoke --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --command-id RunShellScript \
  --instance-id <instance-id> \
  --output json \
  --scripts "openssl s_client -connect <api-server-fqdn>:443 -servername <api-server-fqdn> </dev/null 2>&1 | grep 'issuer'"
```

If the issuer is your corporate CA, a proxy is injecting certificates. Add the API server FQDN to the SSL inspection bypass list. See [Resolve TLS handshake failure](#resolve-tls-handshake-failure) for details.

#### Step 2: Rotate cluster certificates

If no proxy is involved, the certificates might be stale. Rotate the cluster certificates:

```azurecli
az aks rotate-certs --resource-group <resource-group> \
  --name <cluster-name>
```

> [!IMPORTANT]
> Certificate rotation causes an API server restart. Schedule this operation during a maintenance window and confirm that your workloads can tolerate a short control plane disruption.

---

### Run the baseline connectivity checks

If the error doesn't include a specific diagnostic subcategory, or if you're on an older AKS version that doesn't include subcategorization, run the following checks in order. Stop at the first failed check and fix that issue.

> [!NOTE]
> For private clusters, the commands in checks 1-4 must be run from inside the VNet (or from a network with access to the private DNS zone and private endpoint). Use `az vmss run-command invoke` to run them from a cluster node:
>
> ```azurecli
> az vmss run-command invoke --resource-group <mc-resource-group> --name <vmss-name> --instance-id <instance-id> \
>   --command-id RunShellScript --scripts "<command>"
> ```

1. **Verify DNS resolution:**

   ```bash
   nslookup <api-server-fqdn>
   ```

   The command should return one or more IP addresses. If it returns `NXDOMAIN`, `SERVFAIL`, times out, or doesn't return an address, fix DNS resolution before you continue. For DNS resolution failures, see [Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error](vmextensionerror-k8sapiserverdnslookupfail.md).

2. **Verify TCP port 443 connectivity:**

   ```bash
   nc -vz <api-server-fqdn> 443
   ```

   The command should show that the connection to port 443 succeeded or is open. If it times out, check NSGs, UDRs, firewalls, NVAs, and API server authorized IP ranges. If the connection is refused, the API server might not be ready yet. See [Resolve connection refused](#resolve-connection-refused).

3. **Verify HTTPS and TLS handshake:**

   ```bash
   curl -kIv --connect-timeout 10 https://<api-server-fqdn>:443/healthz
   ```

   The `-k` flag skips certificate verification (AKS uses a self-signed CA). The command should complete the TLS handshake and return an HTTP response. If it returns a connection reset or TLS error, check for TLS inspection. See [Resolve TLS handshake failure](#resolve-tls-handshake-failure).

4. **If a proxy is configured, verify that the proxy allows HTTPS access to the API server:**

   ```bash
   curl -k --proxy http://<http-proxy-address>:<port>/ --head https://<api-server-fqdn>:443/healthz
   ```

   If the proxy returns `403`, `407`, a timeout, or a connection reset, update the proxy allowlist and verify that `CONNECT <api-server-fqdn>:443` is permitted.

5. **Check API server authorized IP ranges:**

   ```azurecli
   az aks show --resource-group <resource-group> \
     --name <cluster-name> \
     --query "apiServerAccessProfile.authorizedIpRanges" \
     --output tsv
   ```

   If authorized IP ranges are set, verify that the node subnet CIDR and firewall outbound IP are included.

6. **Check private endpoint and DNS (private clusters):**

   ```azurecli
   az network private-endpoint list --resource-group <mc-resource-group> \
     --query "[?contains(name,'kube-apiserver')].{name:name,state:provisioningState,connectionStatus:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status}" \
     --output table
   ```

   Verify provisioning state is `Succeeded` and connection status is `Approved`. Verify that `nslookup <api-server-fqdn>` returns a private IP.

If all checks pass but the AKS operation still fails, collect the failed node VM extension status by running the following command, and then contact Azure Support:

```azurecli
az vmss get-instance-view --resource-group <mc-resource-group> \
  --name <vmss-name> \
  --instance-id <instance-id> \
  --output json
```

In the output, look for extension status or substatus messages that mention `VMExtensionError_K8SAPIServerConnFail`, `CSE`, `curl`, or `nc`. Include this output when you open a support ticket.

## More information

- [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress)
- [Required ports and addresses for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress#required-outbound-network-rules-and-fqdns-for-aks-clusters)
- [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges)
- [Create a private AKS cluster](/azure/aks/private-clusters)
- [HTTP proxy support in Azure Kubernetes Service (AKS)](/azure/aks/http-proxy)
- [Custom certificate authority certificates for Azure Kubernetes Service (AKS)](/azure/aks/custom-certificate-authority)
- [Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error](vmextensionerror-k8sapiserverdnslookupfail.md)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
