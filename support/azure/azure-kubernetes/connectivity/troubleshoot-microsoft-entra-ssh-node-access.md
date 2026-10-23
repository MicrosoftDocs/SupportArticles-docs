---
title: Troubleshoot Microsoft Entra SSH access to AKS nodes
description: Resolve Microsoft Entra SSH failures on AKS nodes, including node pool settings, VM login roles, and network routing. Follow these steps to restore access.
ms.date: 10/22/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaarthis
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
#Customer intent: As an AKS administrator, I want to diagnose Microsoft Entra SSH connection failures so that I can securely access nodes for troubleshooting.
---

# Troubleshoot Microsoft Entra SSH access to Azure Kubernetes Service nodes

## Summary

This article helps you troubleshoot Microsoft Entra SSH access failures on Azure Kubernetes Service (AKS) Linux nodes so that you can restore secure node access. It covers node pool configuration, network connectivity, Azure role-based access control (RBAC), Conditional Access, and Privileged Identity Management (PIM). It also includes network checks for clusters that use kubenet.

SSH access to a node is separate from access to the Kubernetes API. Being able to run `kubectl` commands doesn't prove that you can reach a node on TCP port 22 or that you have permission to sign in to its operating system.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) version 2.92.0 or later and an OpenSSH client. Run `az version` to check your CLI version.
- The Azure CLI `ssh` extension. Run `az extension add --name ssh` to install it, or `az extension update --name ssh` to update an existing installation.
- Permission to read the AKS cluster, node pools, and underlying compute resources. Updating a node pool or assigning a login role requires additional permissions for those operations.
- A client with a network route to the node's private IP address, such as a device in the cluster virtual network, a peered network, or a connected on-premises network. Azure Cloud Shell doesn't provide this connectivity by default.

Microsoft Entra ID based SSH supports Virtual Machine Scale Sets and Virtual Machines node pools. It isn't supported for Windows node pools, AKS Automatic, or Azure Container Linux (ACL) node pools. ACL's immutable file system isn't compatible with the `AADSSHLoginForLinux` extension. For current requirements and limitations, see [Manage SSH access on AKS cluster nodes](/azure/aks/manage-ssh-node-access).

The Azure CLI examples in this article use Bash syntax. Set these variables to the names of your existing resources:

```bash
RESOURCE_GROUP="<cluster-resource-group>"
CLUSTER_NAME="<cluster-name>"
NODE_POOL_NAME="<affected-node-pool>"
```

## Symptoms

Use the following table to choose a starting point. Error text alone might not identify the cause.

| Symptom | Start with |
|---|---|
| `--ssh-access` or `az aks machine` isn't recognized. | Verify the CLI version in [Prerequisites](#prerequisites). |
| SSH works in one node pool but fails in another, or fails after a configuration change. | [Check the node pool SSH mode](#step-1-check-the-node-pool-ssh-mode). |
| The connection times out or reports `No route to host`. | [Check private network connectivity](#cause-2-the-client-cant-reach-the-node-on-tcp-port-22). |
| The connection reports `Connection refused`. | Verify the target IP and SSH mode, then [collect node-side diagnostics](#advanced-troubleshooting-and-data-collection). |
| The connection reports `Permission denied (publickey)`, `Azure role not assigned`, or closes during sign-in. | [Check the login method and VM login role](#cause-3-the-user-doesnt-have-an-effective-vm-login-role). |
| Sign-in is blocked by a policy, or access fails outside an activation window. | [Check Conditional Access and PIM](#cause-4-conditional-access-or-pim-blocks-sign-in). |
| The node is reachable, but Microsoft Entra authentication still fails on a restricted-egress cluster. | [Cause 5: Node outbound dependencies or the authentication extension fail](#cause-5-node-outbound-dependencies-or-the-authentication-extension-fail). |

## Troubleshooting checklist

### Step 1: Check the node pool SSH mode

List every node pool, not just the initial system node pool:

```bash
az aks nodepool list \
    --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" \
    --query "[].{Name:name,OS:osType,SKU:osSKU,Type:type,SSH:securityProfile.sshAccess,State:provisioningState}" \
    --output table
```

For an affected pool that should use Microsoft Entra authentication, expect `SSH` to be `EntraID`. A value of `LocalUser` indicates SSH key-based authentication, and `Disabled` indicates that SSH is disabled. If the property is empty, inspect the full node pool output and confirm its configuration rather than assuming Microsoft Entra SSH is enabled.

The `--ssh-access` value on `az aks create` configures only the initial system node pool. Additional node pools don't inherit that setting. Also, an updated `securityProfile.sshAccess` value doesn't prove that the change has been applied to existing nodes: a reimage is required.

### Step 2: Identify the node's current private IP address

List the machines in the affected node pool:

```bash
az aks machine list \
    --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" \
    --nodepool-name "$NODE_POOL_NAME" \
    --output table
```

Record the affected machine's private IP address and resource ID. Don't substitute a pod IP address, service IP address, Kubernetes API server address, or Kubernetes node name for the node's private IP address.

If you already have Kubernetes API access, you can also check node addresses:

```bash
kubectl get nodes -l "agentpool=$NODE_POOL_NAME" -o wide
```

Use the `INTERNAL-IP` value. After node replacement, reimage, or scaling, obtain the address again instead of reusing an old IP address.

### Step 3: Test with the Microsoft Entra SSH client

From a client that can reach the node's private IP address, sign in with the intended user's account and select the cluster subscription:

```bash
az login --tenant "<tenant-id>"
az account set --subscription "<subscription-id>"
az account show --query "{Subscription:id,Tenant:tenantId,User:user.name}" --output table
az ssh vm --ip "<node-private-ip-address>"
```

Use `az ssh vm` to obtain and use Microsoft Entra SSH credentials. A command such as `ssh azureuser@<node-ip>` with a local private key tests a different authentication method.

Verify the host fingerprint through a trusted channel before accepting it. If SSH reports a changed host key after node replacement, verify the replacement and its fingerprint before updating the saved host entry. Don't disable host key checking.

## Cause 1: The node pool isn't configured, or the change hasn't been applied

The affected pool uses local user SSH or disabled SSH, or its configuration was updated without reimaging the nodes.

### Solution: Configure and reimage the affected node pool

For a supported node pool, enable Microsoft Entra SSH:

```bash
az aks nodepool update \
    --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" \
    --name "$NODE_POOL_NAME" \
    --ssh-access entraid
```

Apply the change by performing a node image upgrade:

```bash
az aks nodepool upgrade \
    --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" \
    --name "$NODE_POOL_NAME" \
    --node-image-only
```

This operation reimages nodes and can disrupt workloads. Plan it using your maintenance process, check pod disruption budgets and available capacity, and review [AKS node image upgrades](/azure/aks/node-image-upgrade) before you run it.

Repeat the configuration and reimage for each affected pool. When adding future pools, explicitly set `--ssh-access entraid`. Don't manually install authentication packages or change SSH configuration on AKS-managed nodes to work around a pool configuration issue.

## Cause 2: The client can't reach the node on TCP port 22

Microsoft Entra authentication doesn't create a network path to a node. A client outside the connected network, a blocking network security group (NSG), or a routing problem can prevent the SSH handshake.

### Solution: Verify the client-to-node path

1. Test TCP port 22 from the same device that runs `az ssh vm`.

   On a Linux client with netcat installed, use:

   ```bash
   nc -vz -w 5 "<node-private-ip-address>" 22
   ```

   On a Windows client, use PowerShell:

   ```powershell
   Test-NetConnection -ComputerName "<node-private-ip-address>" -Port 22
   ```

   A successful TCP connection confirms transport connectivity only, not Microsoft Entra authorization. A timeout suggests a dropped connection or routing issue. A refusal can indicate that no SSH service is listening, although a firewall can also actively reject a connection.

1. Verify the client route, virtual network peering or VPN connectivity, and the return path. If using Cloud Shell, use a [virtual network-isolated Cloud Shell](/azure/cloud-shell/vnet/overview) with appropriate connectivity, or use a connected client.
1. Inspect effective NSG rules on the node's network interface and subnet. Any required inbound rule should allow TCP port 22 only from the approved client or management network. Don't expose nodes to SSH from the public internet or remove NSGs as a troubleshooting step.
1. If a firewall or network virtual appliance is in the path, check its rules and routing in both directions. Use [Azure Network Watcher connection troubleshoot](/azure/network-watcher/connection-troubleshoot-overview) from a supported source VM when applicable.

### Additional checks for kubenet clusters

Determine the cluster's network plugin and address ranges:

```bash
az aks show \
    --resource-group "$RESOURCE_GROUP" \
    --name "$CLUSTER_NAME" \
    --query "{NetworkPlugin:networkProfile.networkPlugin,PodCIDR:networkProfile.podCidr,ServiceCIDR:networkProfile.serviceCidr}" \
    --output yaml
```

If `NetworkPlugin` is `kubenet`, apply these checks:

- **Target the node subnet address, not a pod address.** With kubenet, nodes receive virtual network subnet IP addresses, while pods use a separate address range. Direct SSH to a node's private IP doesn't require a route to the pod CIDR.
- **Check effective routes for the actual node destination.** Kubenet uses a subnet route table for pod connectivity. Don't assume that a pod route proves client-to-node reachability. Inspect client-side routes and the node's effective return routes for user-defined routes that send traffic through a firewall or virtual appliance.
- **Check for overlapping address spaces.** Overlap between the client network and the node virtual network can send SSH traffic to the wrong destination. Also record pod and service CIDRs when investigating broader connectivity issues.
- **Compare the same test from a connected management VM.** If TCP port 22 works from that VM but not the original client, investigate the original client's VPN, peering, firewall, and routing path before changing the node pool.
- **Preserve AKS-managed pod routes.** Don't delete the route table, remove AKS-managed routes, or add pod-CIDR routes merely to enable direct node SSH. If application traffic also fails, investigate it separately using [basic network troubleshooting](basic-troubleshooting-outbound-connections.md).

Kubenet doesn't change the Microsoft Entra SSH mode, VM login role requirements, or Conditional Access policies. For the network model and route table requirements, see [Use kubenet networking in AKS](/azure/aks/configure-kubenet).

## Cause 3: The user doesn't have an effective VM login role

The **Owner**, **Contributor**, and Kubernetes access roles don't grant operating system sign-in permission. A login role might also have been assigned to the cluster resource group instead of the node resource group, or to a VM that AKS has since replaced.

### Solution: Check and assign the correct authentication role

1. Get the node resource group and its resource ID:

   ```bash
   NODE_RESOURCE_GROUP=$(az aks show \
       --resource-group "$RESOURCE_GROUP" \
       --name "$CLUSTER_NAME" \
       --query nodeResourceGroup --output tsv)

   NODE_RESOURCE_GROUP_ID=$(az group show \
       --name "$NODE_RESOURCE_GROUP" \
       --query id --output tsv)
   ```

1. In the Azure portal, open the target compute resource's **Access control (IAM)** page and use **Check access** to inspect the affected user's effective assignments, including inherited and group assignments. The user needs one of these roles:

   - **Virtual Machine User Login** for nonadministrator access.
   - **Virtual Machine Administrator Login** if administrator access is required.

1. If the assignment is missing, have an authorized role administrator assign the appropriate role at an approved scope. For example, the following command grants nonadministrator authentication to nodes throughout the node resource group:

   ```bash
   az role assignment create \
       --assignee-object-id "<user-or-group-object-id>" \
       --assignee-principal-type "<User-or-Group>" \
       --role "Virtual Machine User Login" \
       --scope "$NODE_RESOURCE_GROUP_ID"
   ```

   Replace `<User-or-Group>` with `User` or `Group` to match the principal. Node resource group scope covers all nodes in that group. Use the narrowest scope that meets your access requirements:

   - For a Virtual Machine Scale Sets pool, you can scope the assignment to the affected scale set.
   - For a Virtual Machines pool, node resource group scope provides durable access when AKS replaces individual VMs. A role assignment on an individual VM must be recreated if that VM is replaced.

1. Allow several minutes for role propagation, then retry `az ssh vm` with the affected user's account.

If authentication succeeds but `sudo` is denied, check whether the user has **Virtual Machine User Login** rather than **Virtual Machine Administrator Login**. Nonadministrator access doesn't grant `sudo`; request administrator access only if the troubleshooting task requires it.

## Cause 4: Conditional Access or PIM blocks sign-in

A Conditional Access policy might require multifactor authentication or a compliant device. A PIM-eligible assignment or group membership doesn't grant access until it's activated, and access can fail again after activation expires.

### Solution: Satisfy the policy and activate the required access

1. Review the affected user's Microsoft Entra sign-in logs at the time of the failed attempt. Inspect the failure reason and Conditional Access results for **Azure Linux VM Sign-In**.
1. Complete the required authentication and use a client device that meets the applicable policy. Don't disable Conditional Access or multifactor authentication to make the test pass.
1. If access uses PIM, activate the VM authentication role or the group membership that grants it. Verify approval, activation scope, and expiration.
1. After activation and propagation, run `az login --tenant "<tenant-id>"` again and retry `az ssh vm --ip "<node-private-ip-address>"`.

For configuration details, see [Conditional Access for SSH to AKS nodes](/azure/aks/access-control-managed-azure-ad#configure-conditional-access-for-ssh-access-to-cluster-nodes) and [just-in-time SSH access with PIM](/azure/aks/privileged-identity-management#request-just-in-time-ssh-access-to-cluster-nodes).

## Cause 5: Node outbound dependencies or the authentication extension fail

Even when inbound TCP port 22 works, Microsoft Entra authentication can fail if the node can't reach authentication or authorization endpoints, or if the authentication extension didn't provision successfully.

### Solution: Verify outbound access and collect extension diagnostics

Check DNS resolution, firewall rules, and proxy configuration for the endpoints required in your Azure cloud. In Azure public cloud, dependencies include:

| Endpoint | Purpose |
|---|---|
| `https://packages.microsoft.com` | Authentication package installation and updates. |
| `https://login.microsoftonline.com` | Microsoft Entra authentication. |
| `https://pas.windows.net` | Azure RBAC authorization. |
| `http://169.254.169.254` | Azure Instance Metadata Service, reached directly from the node. |

The HTTPS endpoints use TCP port 443. The link-local metadata endpoint uses HTTP and shouldn't be routed through a proxy. Sovereign clouds use different authentication and authorization endpoints. See the [Microsoft Entra Linux VM network requirements](/entra/identity/devices/howto-vm-sign-in-azure-ad-linux#network), in addition to [AKS required outbound access](/azure/aks/outbound-rules-control-egress).

Inspect the affected node's extension provisioning status and logs for `AADSSHLoginForLinux`. A running SSH service alone doesn't prove that Microsoft Entra authentication is working. On AKS-managed nodes, use supported node pool configuration and reimage operations rather than manually modifying VM identities, reinstalling the extension, or editing authentication files. If provisioning continues to fail after resolving network dependencies, collect the following evidence for support.

## Advanced troubleshooting and data collection

If SSH is unavailable but you have the necessary Kubernetes permissions, use the supported [AKS node access and debugging workflow](/azure/aks/node-access) to collect node-side evidence. A privileged debug session grants host-level access; follow your organization's access controls and remove the debug pod afterward.

Collect:

- The failure timestamp in UTC, exact error, and whether the failure affects one node, one pool, or all pools.
- Azure CLI and `ssh` extension versions, the selected subscription and tenant, and the connection command without credentials.
- Node pool SSH mode, operating system SKU, pool type, provisioning state, and the time and result of the most recent reimage.
- The current node private IP, compute resource ID, client network location, TCP port 22 test result, and relevant effective NSG rules and routes.
- For kubenet, the node subnet, pod and service CIDRs, subnet route table association, and any firewall or virtual appliance in the client-to-node path.
- Effective VM login role assignments and scope, PIM activation details, and relevant Microsoft Entra sign-in failure codes and correlation IDs.
- SSH service status and logs, and `AADSSHLoginForLinux` extension status and logs. On Ubuntu nodes, check `systemctl status ssh` and `journalctl -u ssh`; on systems that use the `sshd` unit, use that unit name instead. Extension logs are under `/var/log/azure/`.

Don't include access tokens, private keys, or SSH certificates in shared diagnostics. Review logs for sensitive information before sharing them with support. For additional authentication error explanations, see [Troubleshoot Microsoft Entra Linux VM sign-in](/entra/identity/devices/howto-vm-sign-in-azure-ad-linux#troubleshoot-sign-in-issues).

## Verify the resolution

1. Obtain the node's current private IP address again and connect with `az ssh vm --ip "<node-private-ip-address>"` as the intended user.
1. Run `id` in the remote shell to confirm the signed-in identity. Verify administrator access only if it was requested and authorized.
1. Test a node in each affected pool. If access failed after node replacement, confirm that the role assignment scope also covers replacement nodes.
1. Exit test sessions, remove temporary debug pods, and remove temporary access or network rules that are no longer required.

A successful Microsoft Entra-authenticated shell verifies the end-to-end path. A successful TCP probe, an `EntraID` configuration value, or a running SSH service alone doesn't.
