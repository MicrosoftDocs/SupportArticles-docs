---
title: Troubleshoot cluster connection issues with the API server
description: Troubleshoot AKS API server connection issues by checking network, authentication, and authorization paths. Follow these steps to restore access fast.
author: kaushika-msft
ms.author: kaushika
ms.date: 08/20/2026
ms.topic: troubleshooting
ms.reviewer: zhixinsun, shiyao, pihe
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting measures so that I can avoid cluster connectivity issues with the API server.
ms.custom: sap:Connectivity,innovation-engine
ai-usage: ai-assisted
---

# Troubleshoot AKS cluster connection issues with the API server

## Summary

This article helps you troubleshoot Azure Kubernetes Service (AKS) cluster connection issues with the API server when [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) or REST clients can't connect. The troubleshooting flow checks Domain Name System (DNS) resolution, network connectivity, and authentication and authorization in order.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).
- [kubectl](https://kubernetes.io/docs/tasks/tools/).
- [curl](https://curl.se/docs/manpage.html).
- [nslookup](/windows-server/administration/windows-commands/nslookup).
- For a private cluster, a client that has network connectivity to the cluster virtual network.

## Root cause and solutions

Troubleshoot the connection in the following stages. Complete each stage before you continue to the next stage:

- **Stage 1: DNS resolution**
- **Stage 2: Network connectivity**
- **Stage 3: Authentication and authorization**

### Before you begin

1. Use [az aks show](/cli/azure/aks#az-aks-show) to identify the API server access model and the FQDN that the client should use.

    ```azurecli
    az aks show \
      --resource-group <resource-group> \
      --name <cluster-name> \
      --query "{
        provisioningState:provisioningState,
        powerState:powerState.code,
        fqdn:fqdn,
        privateFqdn:privateFqdn,
        privateCluster:apiServerAccessProfile.enablePrivateCluster,
        apiServerVnetIntegration:apiServerAccessProfile.enableVnetIntegration,
        authorizedIpRanges:apiServerAccessProfile.authorizedIpRanges
      }" \
      --output yaml
    ```

    If this command fails, verify the Azure tenant, subscription, resource group, and permissions.

    Confirm that `provisioningState` is `Succeeded` and `powerState` is `Running`.

    Use `fqdn` for a public API server. If `privateCluster` is `true`, use `privateFqdn` from a network that has connectivity to the cluster virtual network.
You can take these common troubleshooting steps to check the connectivity to the AKS cluster's API server:

### Stage 1: DNS resolution

2. Resolve the FQDN from step 1.

    ```bash
    nslookup <cluster-fqdn>
    ```

    - For a public API server, verify that the public FQDN resolves to a public IP address.
    - For a private API server, verify that the private FQDN resolves to a private IP address from the connected network.
    - If private name resolution fails, verify the private DNS zone link, custom DNS conditional forwarders, or Azure DNS Private Resolver configuration before you continue.

    > [!NOTE]
    > When you stop and start an AKS cluster, the API server's IP address can change while the FQDN stays the same. If connection issues begin after a stop/start operation, flush the relevant DNS caches and resolve the FQDN again. For more information, see [Stop and start an Azure Kubernetes Service (AKS) cluster](/azure/aks/start-stop-cluster#about-the-cluster-stopstart-feature).

    Continue to Stage 2 only after the FQDN resolves to the expected address.

### Stage 2: Network connectivity

1. Use a timed `curl` request to test HTTPS connectivity to the API server.

    # [Bash](#tab/bash)

    ```bash
    curl -kv --connect-timeout 5 --max-time 15 https://<cluster-fqdn>/version
    ```

    # [PowerShell](#tab/powershell)

    ```powershell
    curl.exe -kv --connect-timeout 5 --max-time 15 https://<cluster-fqdn>/version
    ```

    ---

    > [!NOTE]
    > The `-k` option skips certificate validation. Use it only for this connectivity test.

    - `curl: (28) Connection timed out` after DNS succeeds means that the TCP connection to port 443 wasn't established. Continue to step 4 for a private endpoint or step 5 for a public endpoint.
    - `HTTP 401 Unauthorized` from `/version` confirms that network connectivity works and that the unauthenticated request reached the API server. Continue to Stage 3.

4. If the client targets a private endpoint, including a private cluster or an [API Server VNet Integration](/azure/aks/api-server-vnet-integration) cluster in private mode, and the request times out, verify the private network path.

    **Understand the access path:**

    - A private API server requires private network connectivity. A public FQDN on a private cluster doesn't make the API server publicly reachable.
    - With API Server VNet Integration, node-to-API-server connectivity is separate from the path used by an external client.

    **Verify the client path:**

    1. Confirm that the client network connects to the cluster virtual network through virtual network peering, VPN, ExpressRoute, or another supported private path.
    1. Verify that routes, network security groups, firewalls, and other network virtual appliances allow TCP port 443 from the client to the private API server IP.
    1. Repeat the timed `curl` request after you correct the private network path.

    **Optional isolation test:**

    If direct private connectivity isn't available, use [Run Command options for connecting to the private cluster](/azure/aks/access-private-cluster). If Run Command succeeds, focus the investigation on the client's private network path. Run Command requires separate Azure permissions and can also be affected by policy or pod scheduling.

1. If the client targets a public API server and the request times out, check the client's outbound path and the API server's authorized IP ranges.

    ```azurecli
    az aks show \
      --resource-group <resource-group> \
      --name <cluster-name> \
      --query apiServerAccessProfile.authorizedIpRanges
    ```

    - If the result is `null` or empty, authorized IP ranges aren't enabled. Check the client's routing, VPN, proxy, and firewall rules for outbound TCP port 443.
    - If ranges are configured, follow [Client IP address can't access the API server](client-ip-address-cannot-access-api-server.md) to verify and update the client's actual source public IP. Consider management networks, VPN or firewall source network address translation (SNAT), automation agents, cluster egress addresses, and node public IP prefixes.

    Allow time for an update to propagate, and repeat the timed `curl` request. During propagation, individual connections can produce different results, so don't declare recovery or failure from a single request.

### Stage 3: Authentication and authorization

1. After the `curl` request returns `HTTP 401 Unauthorized`, use `kubectl` to validate the credentials in kubeconfig and the user's access to cluster resources.

    ```bash
    kubectl get --raw=/version --request-timeout=10s
    kubectl get nodes --request-timeout=10s
    ```

    - If both commands succeed, authentication works and the user can list cluster nodes.
    - `Unauthorized` or `You must be logged in to the server` indicates an authentication or credential problem. Continue to step 7.
    - If the version request succeeds but `kubectl get nodes` returns `Forbidden`, authentication succeeded but the user isn't authorized to list nodes. Continue to step 8.

1. If authentication fails, check the client configuration and authentication toolchain.

    - Follow [Config file isn't available when connecting](config-file-is-not-available-when-connecting.md) if kubeconfig is missing, invalid, or points to the wrong endpoint.
    - For Microsoft Entra-integrated clusters, verify that `kubelogin` is installed when the kubeconfig uses an exec credential plugin, and confirm that the selected authentication method is compatible with the applicable Conditional Access policy.
    - Keep `kubectl` within one minor version of the API server, in either direction, according to the [Kubernetes version skew policy](https://kubernetes.io/releases/version-skew-policy/). Use [az aks install-cli](/cli/azure/aks#az-aks-install-cli) or the platform-specific [kubectl installation instructions](https://kubernetes.io/docs/tasks/tools/) when an update is required.

    Repeat the `kubectl` commands in step 6 after you correct the authentication problem.

1. If `kubectl` returns `Forbidden`, follow [User can't get cluster resources](user-cannot-get-cluster-resources.md). Determine whether the cluster uses Kubernetes RBAC or Azure RBAC for Kubernetes Authorization, and verify the role assignment or role binding for the exact operation that failed.

    Repeat `kubectl get nodes --request-timeout=10s` after you correct the authorization problem.

### Additional check for node-specific operations

1. If the commands in step 6 succeed but `kubectl logs`, `exec`, `attach`, or `port-forward` fails, check the API-server-to-node path.

    - Follow [Troubleshoot tunnel connectivity issues](tunnel-connectivity-issues.md) and verify that network security controls associated with AKS nodes allow the required control-plane-to-kubelet communication on TCP port 10250.
    - If nodes or extensions can't reach required AKS endpoints, verify the [minimum required egress rules for AKS](/azure/aks/limit-egress-traffic), including proxy, firewall, TLS inspection, and ALPN behavior.
    - TCP port 10250 failures can affect only some node-dependent operations. Compare the failing operation with the successful commands from step 6 instead of treating it as a general client-to-API-server failure.

For additional timeout scenarios, see [TCP time-outs when kubectl or other third-party tools connect to the API server](tcp-timeouts-kubetctl-third-party-tools-connect-api-server.md).

 
