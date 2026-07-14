---
title: Troubleshoot private endpoint connectivity failures
description: Diagnose failures in private endpoint connectivity to an approved private endpoint. Learn how to resolve timeouts, blocked traffic, and routing overrides.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints
ms.date: 07/14/2026
ai.hint.symptom-tags:
  - private-endpoint-timeout
  - private-endpoint-connectivity
  - pe-route-override
  - nsg-blocking-pe
  - vnet-peering-disconnected
  - webapp-vnet-integration
  - snat-exhaustion
  - tcp-timeout
  - longest-prefix-match
  - hub-spoke-bypass
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/networkInterfaces/read
  - Microsoft.Network/networkInterfaces/effectiveRouteTable/action
  - Microsoft.Network/networkSecurityGroups/read
  - Microsoft.Network/virtualNetworks/read
  - Microsoft.Network/networkWatchers/nextHop/action
  - Microsoft.Web/sites/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - SOURCE_VM_NAME
  - SOURCE_VM_RG
---

# Troubleshoot private endpoint connectivity failures

## Summary

This article provides step-by-step diagnostics for failures in private endpoint connectivity to an approved private endpoint in Microsoft Azure Private Link. The article helps identify timeouts, blocked traffic, and routing overrides.

Failures in traffic-flow to an approved private endpoint can be traced most commonly to four root causes: 

- The private endpoint `/32` system route as it overrides a user-defined route through a longest-prefix-match (such as bypassing firewall or Azure Network Virtual Appliance (NVA) inspection in the hub-spoke)
- Network security group (NSG) or firewall rules that block the path between source and the private endpoint subnet
- Missing or disconnected virtual network (VNet) peering if the source and private endpoint reside in different VNets
- The calling service (for example, Web App) if it routs outbound traffic through the public path instead of the private endpoint

## Symptoms

You might experience one or more of the following problems:

- TCP connection timeouts occur when you connect from a virtual machine (VM) or service to a resource's private endpoint IP on port 443 (or the target service port).
- `curl` or application logs show `Connection timed out` or `No route to host` values when they target the private endpoint private IP.
- The Domain Name System (DNS) resolves correctly to the private IP (for example, `10._x_._._`), but traffic never arrives at the destination.
- Intermittent "HTTP 499" or TCP reset packets (RSTs) occur when you use Azure Accelerated Networking that has high connection volume to the private endpoint.
- Hub-spoke architecture unexpectedly causes traffic to the private endpoint to bypass the central firewall or NVA.
- Azure Web App outbound calls to a private endpoint-enabled service fail and generate timeouts, even though VNet integration is configured.
- `az network watcher show-next-hop` reports `InterfaceEndpoint` instead of the expected NVA or firewall next hop for the private endpoint IP.

## Prerequisites

To troubleshoot effectively, you must have the following prerequisite items:

- **Permissions required**: 
    - `Network Contributor` role on the source VM resource group and the private endpoint resource group
    - `Network Watcher Contributor` role for next-hop or effective-routes operations
- **Tools**: Azure CLI 2.x or an AI agent with Azure MCP or Azure CLI access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `RG` | Resource group containing the private endpoint | `myPEResourceGroup` |
| `PE_NAME` | Private endpoint resource name | `myPrivateEndpoint` |
| `SOURCE_VM` | Name of the source VM that's experiencing connectivity failure | `mySourceVM` |
| `SOURCE_VM_RG` | Resource group of the source VM | `myVMResourceGroup` |
| `TARGET_FQDN` | Fully qualified domain name (FQDN) of the target service (for example, `mystorageaccount.blob.core.windows.net`) | `myapp.azurewebsites.net` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment. 

### Step 1

Check whether DNS resolves the target FQDN to the private endpoint's private IP address (not a public IP). If DNS returns a public IP, the problem is DNS configuration, not connectivity. For more information, see [Troubleshoot private endpoint DNS resolution](troubleshoot-private-endpoint-dns-resolution.md).

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_FQDN" ] && read -rp "Target service FQDN (e.g., myaccount.blob.core.windows.net): " TARGET_FQDN

nslookup "$TARGET_FQDN"
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Response contains a private IP (for example, `10._x_._x_._x_`, `172.16._x_._x_`, `192.168._x_._x_`). | DNS correctly resolves to the private endpoint private IP. | Perform [Step 2](#step-2). |
| Response contains a public IP address. | DNS isn't resolving through a private DNS zone. Traffic goes over the public path. | Fix private DNS zone configuration. For more information, see [Troubleshoot private endpoint DNS resolution](troubleshoot-private-endpoint-dns-resolution.md). |
| `** server can't find` or `NXDOMAIN`. | DNS can't resolve the FQDN. | Verify that the private DNS zone exists, is linked to the source VNet, and has an A record for the private endpoint. |
| Response contains `privatelink` CNAME but resolves to a public IP. | The Azure Private DNS zone link to the source VNet is missing. | Link the private link DNS zone to the source VNet. |

### Step 2

Check whether the private endpoint connection state is `Approved` and provisioning is `Succeeded`. A `Pending` or `Rejected` status connection blocks all traffic regardless of routing.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, connectionState:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status, connectionDescription:privateLinkServiceConnections[0].privateLinkServiceConnectionState.description, peIP:customDnsConfigs[0].ipAddresses[0], nicId:networkInterfaces[0].id}" \
  --output json

# If peIP is null (common when a DNS zone group manages DNS), get it from the PE NIC:
PE_NIC_ID=$(az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkInterfaces[0].id" \
  --output tsv)

PE_IP=$(az network nic show \
  --ids "$PE_NIC_ID" \
  --query "ipConfigurations[0].privateIPAddress" \
  --output tsv)

echo "Private Endpoint IP: $PE_IP"
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `provisioningState: Succeeded` and `connectionState: Approved`. | The private endpoint is properly provisioned and approved. | Perform [Step 3](#step-3). |
| `connectionState: Pending`. | The resource owner hasn't approved the private endpoint connection. | Approve the private endpoint connection on the target resource before proceeding. |
| `connectionState: Rejected`. | The connection is explicitly rejected. | Re-create the private endpoint or request approval from the resource owner. |
| `provisioningState: Failed`. | Private endpoint deployment failed. | Delete and re-create the private endpoint. For more information, see [Troubleshoot private endpoint creation failures](troubleshoot-private-endpoint-connectivity-failure.md). |
| `peIP` is null or empty. | Private endpoint network adapter has no IP assigned. | Delete and re-create the private endpoint. |

> Record the `peIP` value (the private endpoint private IP). You'll need it in subsequent steps.

### Step 3

Check the effective routes on the source VM's network adapter (NIC) to determine whether the private endpoint `/32` system route is present and whether it overrides a user-defined route (UDR) that forces traffic through a firewall or NVA.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

# Get the primary network adapter name
SOURCE_NIC=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv | rev | cut -d'/' -f1 | rev)

echo "Source NIC: $SOURCE_NIC"

az network nic show-effective-route-table \
  --name "$SOURCE_NIC" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

### Interpret the results

Look for a route that matches the private endpoint private IP from [Step 2](#step-2). The private endpoint `/32` route has a `nextHopType: InterfaceEndpoint` value.

| Observation | Meaning | Next steps |
|---|---|---|
| A `/32` route to the private endpoint IP with a `nextHopType: InterfaceEndpoint` value and no UDR to a firewall or NVA for a broader prefix that should inspect this traffic. | A private endpoint route is present and there's no firewall bypass problem. | Perform [Step 4](#step-4). |
| A `/32` route to the private endpoint IP with a `nextHopType: InterfaceEndpoint` value AND a UDR for a broader prefix (for example, `10.0.0.0/8 → VirtualAppliance`) that should have forced this traffic through a firewall. | The private endpoint `/32` takes priority by the longest-prefix-match, bypassing the firewall or NVA. | Perform [Resolution A](#resolution-a). |
| No `/32` route for the private endpoint IP appears in effective routes. | The source and private endpoint are in different VNets and the route isn't propagated. | Perform [Step 5](#step-5). |
| `nextHopType: None` value for the private endpoint IP prefix. | Traffic is prevented by a UDR. | Perform [Resolution A](#resolution-a) to remove the conflicting UDR. |

### Step 4

Check whether NSG rules on the source subnet block outbound traffic to the private endpoint IP on the required port. NSGs on the private endpoint subnet aren't evaluated by default (`privateEndpointNetworkPolicies` is `Disabled`), so only the source subnet NSG matters.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

# Get the source VM subnet
SOURCE_SUBNET_ID=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv | xargs -I {} az network nic show --ids {} --subscription "$SUBSCRIPTION" --query "ipConfigurations[0].subnet.id" --output tsv)

# Get NSG associated with the source subnet
SOURCE_NSG=$(az network vnet subnet show \
  --ids "$SOURCE_SUBNET_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "networkSecurityGroup.id" \
  --output tsv | rev | cut -d'/' -f1 | rev)

echo "Source Subnet NSG: $SOURCE_NSG"

if [ -n "$SOURCE_NSG" ] && [ "$SOURCE_NSG" != "None" ]; then
  SOURCE_NSG_RG=$(az network vnet subnet show \
    --ids "$SOURCE_SUBNET_ID" \
    --subscription "$SUBSCRIPTION" \
    --query "networkSecurityGroup.id" \
    --output tsv | grep -oP '(?<=resourceGroups/)[^/]+')

  az network nsg rule list \
    --nsg-name "$SOURCE_NSG" \
    --resource-group "$SOURCE_NSG_RG" \
    --subscription "$SUBSCRIPTION" \
    --include-default \
    --output table
else
  echo "No NSG is associated with the source subnet."
fi
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| No NSG on the source subnet. | NSG isn't blocking traffic. | Perform [Step 5](#step-5). |
| The outbound allow rule exists for port 443 (or the target port) with a destination covering the private endpoint IP. | NSG allows traffic to the private endpoint. | Perform [Step 5](#step-5). |
| The outbound deny rule with higher priority blocks port 443 (or the target port) to the private endpoint IP range. | The NSG is blocking outbound traffic to the private endpoint. | Perform [Resolution B](#resolution-b). |
| Only the default `AllowVnetOutBound` rule exists (priority 65000) and a custom deny-all rule at lower priority overrides it. | The custom deny rule blocks private endpoint traffic. | Perform [Resolution B](#resolution-b). |

### Step 5

Check whether the source VNet and the private endpoint VNet are peered with the peering in a `Connected` state. If the source and private endpoint are in the same VNet, go to [Step 6](#step-6).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

# Get source VNet name and RG
SOURCE_NIC_ID=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

SOURCE_SUBNET_ID=$(az network nic show \
  --ids "$SOURCE_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

SOURCE_VNET_NAME=$(echo "$SOURCE_SUBNET_ID" | grep -oP '(?<=virtualNetworks/)[^/]+')
SOURCE_VNET_RG=$(echo "$SOURCE_SUBNET_ID" | grep -oP '(?<=resourceGroups/)[^/]+')

echo "Source VNet: $SOURCE_VNET_NAME (RG: $SOURCE_VNET_RG)"

az network vnet peering list \
  --vnet-name "$SOURCE_VNET_NAME" \
  --resource-group "$SOURCE_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{Name:name, PeeringState:peeringState, RemoteVNet:remoteVirtualNetwork.id, AllowForwardedTraffic:allowForwardedTraffic, UseRemoteGateways:useRemoteGateways}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Peering to the private endpoint VNet shows a `PeeringState: Connected` state. | Peering is healthy. | Perform [Step 6](#step-6). |
| Peering to the private endpoint VNet shows `PeeringState: Disconnected` or `Initiated` states. | Peering is broken and traffic can't flow. | Perform [Resolution B](#resolution-b). |
| No peering exists to the VNet containing the private endpoint. | VNets aren't connected. | Perform [Resolution B](#resolution-b). |
| The source and private endpoint are in the same VNet (no peering needed). | Peering isn't the problem. | Perform [Step 6](#step-6). |
| There's a `AllowForwardedTraffic: false` state on the peering and traffic arrives through a hub NVA. | Forwarded traffic is blocked by the peering configuration. | Perform [Resolution B](#resolution-b). |

### Step 6

Check whether the calling service uses a web app with VNet integration. If it is, check whether outbound traffic is routed through the integrated subnet (required for private endpoint connectivity). Skip this step if the source is a VM.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$WEBAPP_RG" ] && read -rp "Web App Resource Group (or 'skip' if source is a VM): " WEBAPP_RG

if [ "$WEBAPP_RG" = "skip" ]; then
  echo "Source is not a Web App — skipping this step."
else
  [ -z "$WEBAPP_NAME" ] && read -rp "Web App Name: " WEBAPP_NAME

  echo "=== VNet Integration ==="
  az webapp vnet-integration list \
    --name "$WEBAPP_NAME" \
    --resource-group "$WEBAPP_RG" \
    --subscription "$SUBSCRIPTION" \
    --output table

  echo ""
  echo "=== App Settings (route-all / WEBSITE_VNET_ROUTE_ALL) ==="
  az webapp config appsettings list \
    --name "$WEBAPP_NAME" \
    --resource-group "$WEBAPP_RG" \
    --subscription "$SUBSCRIPTION" \
    --query "[?name=='WEBSITE_VNET_ROUTE_ALL' || name=='WEBSITE_DNS_SERVER'].{Name:name, Value:value}" \
    --output table

  echo ""
  echo "=== VNet Route All property ==="
  az webapp show \
    --name "$WEBAPP_NAME" \
    --resource-group "$WEBAPP_RG" \
    --subscription "$SUBSCRIPTION" \
    --query "vnetRouteAllEnabled" \
    --output tsv
fi
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The source is a VM (skipped). | This step doesn't apply. | Go to the [Decision map](#decision-map). If all steps pass, consider performing [Resolution D](#resolution-d). |
| VNet integration shows a subnet and a `vnetRouteAllEnabled: true` value (or `WEBSITE_VNET_ROUTE_ALL=1`) | The web app routes all outbound traffic through VNet. | Go to the [Decision map](#decision-map). If all steps pass, consider performing [Resolution D](#resolution-d). |
| VNet integration shows a subnet but has a `vnetRouteAllEnabled: false` state (or the setting's absent). | The web app only routes RFC1918 traffic through VNet. Private endpoint traffic for the public FQDN uses public paths. | Perform [Resolution C](#resolution-c). |
| No VNet integration is configured. | The web app has no path to the private endpoint subnet at all. | Perform [Resolution C](#resolution-c). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| DNS resolves to a public IP. | Fix the private DNS zone link. For more information, see [Troubleshoot private endpoint DNS resolution](troubleshoot-private-endpoint-dns-resolution.md). |
| The private endpoint connection state is `Pending` or `Rejected`. | Approve or re-create the private endpoint connection. |
| The private endpoint `/32` route overrides UDR and, therefore, bypasses the firewall or NVA. | Perform [Resolution A](#resolution-a). |
| An NSG deny rule blocks outbound to private endpoint IP traffic on the source subnet. | Perform [Resolution B](#resolution-b). |
| VNet peering is disconnected or missing between the source and private endpoint VNets. | Perform [Resolution B](#resolution-b). |
| The web app is missing VNet integration, or route-all is disabled. | Perform [Resolution C](#resolution-c). |
| All diagnostics pass but generate intermittent timeouts with Accelerated Networking. | Perform [Resolution D](#resolution-d). |
| All diagnostics pass but problems persist. | File an Azure support request. |

## Resolution A

The private endpoint `/32` system route (with a next hop value of `InterfaceEndpoint`) overrides a less-specific user-defined route (for example, `10.0.0.0/8 → VirtualAppliance`) through longest-prefix-match. In hub-spoke architectures, this behavior causes private endpoint traffic to bypass the central firewall or NVA.

1. Verify the private endpoint private IP and the conflicting UDR.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

PE_IP=$(az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "customDnsConfigs[0].ipAddresses[0]" \
  --output tsv)

echo "Private Endpoint IP: $PE_IP"
echo "You need a /32 UDR for $PE_IP/32 pointing to your firewall/NVA."
```

2. Add a `/32` UDR for the private endpoint IP pointing to the firewall or NVA so traffic still traverses the inspection path.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM
[ -z "$FIREWALL_IP" ] && read -rp "Firewall/NVA private IP: " FIREWALL_IP

# Get the route table associated with the source subnet
SOURCE_NIC_ID=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

SOURCE_SUBNET_ID=$(az network nic show \
  --ids "$SOURCE_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

RT_ID=$(az network vnet subnet show \
  --ids "$SOURCE_SUBNET_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "routeTable.id" \
  --output tsv)

RT_NAME=$(echo "$RT_ID" | rev | cut -d'/' -f1 | rev)
RT_RG=$(echo "$RT_ID" | grep -oP '(?<=resourceGroups/)[^/]+')

# Get PE IP from earlier step
[ -z "$PE_IP" ] && read -rp "Private Endpoint IP (from A.1): " PE_IP

az network route-table route create \
  --route-table-name "$RT_NAME" \
  --resource-group "$RT_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "route-to-pe-via-firewall" \
  --address-prefix "$PE_IP/32" \
  --next-hop-type VirtualAppliance \
  --next-hop-ip-address "$FIREWALL_IP" \
  --output json
```

3. Verify the fix by rechecking effective routes on the source NIC.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM
[ -z "$PE_IP" ] && read -rp "Private Endpoint IP: " PE_IP

SOURCE_NIC=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv | rev | cut -d'/' -f1 | rev)

az network watcher show-next-hop \
  --vm "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --source-ip "$(az network nic show --name "$SOURCE_NIC" --resource-group "$SOURCE_VM_RG" --subscription "$SUBSCRIPTION" --query "ipConfigurations[0].privateIPAddress" --output tsv)" \
  --dest-ip "$PE_IP" \
  --output json
```

The `nextHopType` should now show a `VirtualAppliance` value with `nextHopIpAddress` to match your firewall or NVA IP. If it still shows `InterfaceEndpoint`, the UDR might not have propagated yet. Wait 1–2 minutes, and then rerun.

> [!NOTE]
> If the NVA or firewall is unreachable (no network adapter at that IP with IP forwarding enabled), `nextHopType` might display `None` even though the route table is correctly configured. Verify that the `nextHopIpAddress` value matches your firewall IP and that the `routeTableId` points to your UDR. This verification confirms that the `/32` route is in effect.

4. After you verify routing, test connectivity from the source VM.

Run the following commands in Azure CLI:

```bash
[ -z "$PE_IP" ] && read -rp "Private Endpoint IP: " PE_IP
[ -z "$TARGET_PORT" ] && read -rp "Target port (default 443): " TARGET_PORT
TARGET_PORT=${TARGET_PORT:-443}

curl -v --connect-timeout 10 "https://$TARGET_FQDN" 2>&1 | head -20
```

If the problem persists after this fix, go to [Resolution B](#resolution-b) to check NSG rules.

## Resolution B

An NSG deny rule on the source subnet blocks outbound traffic to the private endpoint IP, or VNet peering between the source and private endpoint VNets is missing or disconnected and, therefore, prevents traffic flow.

1. Create or repair the peering. First, identify the private endpoint VNet.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

PE_NIC_ID=$(az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkInterfaces[0].id" \
  --output tsv)

PE_SUBNET_ID=$(az network nic show \
  --ids "$PE_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

PE_VNET_NAME=$(echo "$PE_SUBNET_ID" | grep -oP '(?<=virtualNetworks/)[^/]+')
PE_VNET_RG=$(echo "$PE_SUBNET_ID" | grep -oP '(?<=resourceGroups/)[^/]+')

echo "PE VNet: $PE_VNET_NAME (RG: $PE_VNET_RG)"
```

2. For missing VNet peering, create the VNet peering (both directions are required).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

Run the following commands in Azure CLI: 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

# Derive source VNet
SOURCE_NIC_ID=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

SOURCE_SUBNET_ID=$(az network nic show \
  --ids "$SOURCE_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

SOURCE_VNET_NAME=$(echo "$SOURCE_SUBNET_ID" | grep -oP '(?<=virtualNetworks/)[^/]+')
SOURCE_VNET_RG=$(echo "$SOURCE_SUBNET_ID" | grep -oP '(?<=resourceGroups/)[^/]+')

# Get PE VNet ID
[ -z "$PE_VNET_NAME" ] && read -rp "PE VNet Name (from B.1): " PE_VNET_NAME
[ -z "$PE_VNET_RG" ] && read -rp "PE VNet Resource Group (from B.1): " PE_VNET_RG

PE_VNET_ID=$(az network vnet show \
  --name "$PE_VNET_NAME" \
  --resource-group "$PE_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv)

SOURCE_VNET_ID=$(az network vnet show \
  --name "$SOURCE_VNET_NAME" \
  --resource-group "$SOURCE_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv)

# Create peering: source → PE VNet
az network vnet peering create \
  --name "peer-to-pe-vnet" \
  --vnet-name "$SOURCE_VNET_NAME" \
  --resource-group "$SOURCE_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --remote-vnet "$PE_VNET_ID" \
  --allow-vnet-access \
  --allow-forwarded-traffic \
  --output json

# Create peering: PE VNet → source
az network vnet peering create \
  --name "peer-to-source-vnet" \
  --vnet-name "$PE_VNET_NAME" \
  --resource-group "$PE_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --remote-vnet "$SOURCE_VNET_ID" \
  --allow-vnet-access \
  --allow-forwarded-traffic \
  --output json
```

3. For NSG deny rules, remove the deny rule or add an allow rule at a lower priority number (higher evaluation priority) than the deny rule.

> [!NOTE]
> NSG rules are evaluated only by priority number. This condition means that the lower number is evaluated first. The valid range is 100–4096.

> [!IMPORTANT]
> If the deny rule is already at priority 100 (the minimum), you can't create a higher-priority allow rule. In this case, delete or modify the deny rule instead.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_NSG" ] && read -rp "Source Subnet NSG Name (from Step 4): " SOURCE_NSG
[ -z "$SOURCE_NSG_RG" ] && read -rp "Source NSG Resource Group: " SOURCE_NSG_RG
[ -z "$PE_IP" ] && read -rp "Private Endpoint IP: " PE_IP
[ -z "$TARGET_PORT" ] && read -rp "Target port (default 443): " TARGET_PORT
[ -z "$DENY_RULE_PRIORITY" ] && read -rp "Priority of the blocking deny rule (from Step 4): " DENY_RULE_PRIORITY
TARGET_PORT=${TARGET_PORT:-443}

# Choose a priority lower (numerically) than the deny rule
ALLOW_PRIORITY=$((DENY_RULE_PRIORITY - 10))
if [ "$ALLOW_PRIORITY" -lt 100 ]; then
  echo "ERROR: Deny rule is at minimum priority ($DENY_RULE_PRIORITY). Cannot create a higher-priority allow rule."
  echo "Delete or modify the deny rule instead:"
  echo "  az network nsg rule delete --nsg-name $SOURCE_NSG --resource-group $SOURCE_NSG_RG --subscription $SUBSCRIPTION --name <deny-rule-name>"
  exit 1
fi

az network nsg rule create \
  --nsg-name "$SOURCE_NSG" \
  --resource-group "$SOURCE_NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "Allow-Outbound-To-PE" \
  --priority "$ALLOW_PRIORITY" \
  --direction Outbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "$PE_IP/32" \
  --destination-port-ranges "$TARGET_PORT" \
  --output json
```

4. Verify connectivity after the peering or NSG fix.

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_FQDN" ] && read -rp "Target service FQDN: " TARGET_FQDN
[ -z "$TARGET_PORT" ] && read -rp "Target port (default 443): " TARGET_PORT
TARGET_PORT=${TARGET_PORT:-443}

curl -v --connect-timeout 10 "https://$TARGET_FQDN:$TARGET_PORT" 2>&1 | head -20
```

A successful TLS handshake or HTTP response confirms that the path is now open. If the problem persists, go to [Resolution C](#resolution-c).

## Resolution C

The calling service (for example, Azure Web App) routes outbound traffic through the public internet instead of through the VNet-integrated subnet. Therefore, it never reaches the private endpoint. This problem occurs when VNet integration is missing or when `route-all` is disabled (only RFC1918 destinations are routed through the VNet by default).

1. Verify the web app's current VNet integration status.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$WEBAPP_RG" ] && read -rp "Web App Resource Group: " WEBAPP_RG
[ -z "$WEBAPP_NAME" ] && read -rp "Web App Name: " WEBAPP_NAME

az webapp vnet-integration list \
  --name "$WEBAPP_NAME" \
  --resource-group "$WEBAPP_RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

2. If VNet integration exists but `route-all` isn't enabled, enable it.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$WEBAPP_RG" ] && read -rp "Web App Resource Group: " WEBAPP_RG
[ -z "$WEBAPP_NAME" ] && read -rp "Web App Name: " WEBAPP_NAME

az webapp config appsettings set \
  --name "$WEBAPP_NAME" \
  --resource-group "$WEBAPP_RG" \
  --subscription "$SUBSCRIPTION" \
  --settings WEBSITE_VNET_ROUTE_ALL=1 \
  --output json
```

> [!NOTE]
> On newer Azure App Service plans, use `vnetRouteAllEnabled` routing through `az webapp update` or the portal instead of the app setting. Both achieve the same result.

3. If VNet integration isn't configured, add and configure it.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$WEBAPP_RG" ] && read -rp "Web App Resource Group: " WEBAPP_RG
[ -z "$WEBAPP_NAME" ] && read -rp "Web App Name: " WEBAPP_NAME
[ -z "$INTEGRATION_VNET" ] && read -rp "VNet name for integration: " INTEGRATION_VNET
[ -z "$INTEGRATION_SUBNET" ] && read -rp "Subnet name (must be delegated to Microsoft.Web/serverFarms): " INTEGRATION_SUBNET
[ -z "$INTEGRATION_VNET_RG" ] && read -rp "VNet Resource Group: " INTEGRATION_VNET_RG

SUBNET_ID=$(az network vnet subnet show \
  --vnet-name "$INTEGRATION_VNET" \
  --name "$INTEGRATION_SUBNET" \
  --resource-group "$INTEGRATION_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv)

az webapp vnet-integration add \
  --name "$WEBAPP_NAME" \
  --resource-group "$WEBAPP_RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet "$INTEGRATION_VNET" \
  --subnet "$INTEGRATION_SUBNET" \
  --output json
```

4. Verify that the web app can now reach the private endpoint by testing from the app's Kudu console or by checking application logs for successful connections. Verify DNS resolution from the web app's perspective.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$WEBAPP_RG" ] && read -rp "Web App Resource Group: " WEBAPP_RG
[ -z "$WEBAPP_NAME" ] && read -rp "Web App Name: " WEBAPP_NAME
[ -z "$TARGET_FQDN" ] && read -rp "Target FQDN: " TARGET_FQDN

az webapp config appsettings list \
  --name "$WEBAPP_NAME" \
  --resource-group "$WEBAPP_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?name=='WEBSITE_VNET_ROUTE_ALL'].{Name:name, Value:value}" \
  --output table

echo ""
echo "Verify from Kudu (Advanced Tools > Console): nslookup $TARGET_FQDN"
echo "Expected: private IP (10.x.x.x). If public IP, link the private DNS zone to the integration subnet VNet."
```

If DNS from the web app still resolves to a public IP, you must link the private DNS zone to the VNet that contains the integration subnet.

## Resolution D

Ephemeral port (source network address translation (SNAT)) exhaustion that's combined with Accelerated Networking on the source network adapter causes intermittent TCP timeouts or "HTTP 499" errors when connecting to the private endpoint under high connection volume.

1. Check whether the source network adapter has Accelerated Networking enabled and a review connection volume.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

SOURCE_NIC_ID=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

az network nic show \
  --ids "$SOURCE_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, acceleratedNetworking:enableAcceleratedNetworking, ipConfigs:ipConfigurations[].name}" \
  --output json
```

2. Perform one of the two following options depending on your scenario.

**Option 1: Disable Accelerated Networking (requires VM stop)**

> [!NOTE]
>  Disabling Accelerated Networking requires the VM to be deallocated. This action causes downtime. An alternative is to add more frontend IPs or expand SNAT capacity if you're using a load balancer for outbound traffic.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SOURCE_VM_RG" ] && read -rp "Source VM Resource Group: " SOURCE_VM_RG
[ -z "$SOURCE_VM" ] && read -rp "Source VM Name: " SOURCE_VM

SOURCE_NIC=$(az vm show \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv | rev | cut -d'/' -f1 | rev)

# Stop the VM first
az vm deallocate \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --output json

# Disable accelerated networking
az network nic update \
  --name "$SOURCE_NIC" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --accelerated-networking false \
  --output json

# Restart the VM
az vm start \
  --name "$SOURCE_VM" \
  --resource-group "$SOURCE_VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

**Option 2: Increase allocated ports if using a NAT gateway or load balancer for outbound SNAT**

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NAT_GW_RG" ] && read -rp "NAT Gateway Resource Group: " NAT_GW_RG
[ -z "$NAT_GW_NAME" ] && read -rp "NAT Gateway Name: " NAT_GW_NAME

# Add a second public IP to the NAT Gateway to double SNAT capacity
[ -z "$NEW_PIP_NAME" ] && read -rp "New Public IP name to create: " NEW_PIP_NAME

az network public-ip create \
  --name "$NEW_PIP_NAME" \
  --resource-group "$NAT_GW_RG" \
  --subscription "$SUBSCRIPTION" \
  --sku Standard \
  --zone 1 2 3 \
  --output json

az network nat gateway update \
  --name "$NAT_GW_NAME" \
  --resource-group "$NAT_GW_RG" \
  --subscription "$SUBSCRIPTION" \
  --public-ip-addresses "$(az network nat gateway show --name "$NAT_GW_NAME" --resource-group "$NAT_GW_RG" --subscription "$SUBSCRIPTION" --query "publicIpAddresses[].id" --output tsv) $(az network public-ip show --name "$NEW_PIP_NAME" --resource-group "$NAT_GW_RG" --subscription "$SUBSCRIPTION" --query "id" --output tsv)" \
  --output json
```

3. Verify the fix by testing connectivity under load.

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_FQDN" ] && read -rp "Target FQDN: " TARGET_FQDN
[ -z "$TARGET_PORT" ] && read -rp "Target port (default 443): " TARGET_PORT
TARGET_PORT=${TARGET_PORT:-443}

# Quick connectivity test
for i in $(seq 1 10); do
  curl -s -o /dev/null -w "Attempt $i: HTTP %{http_code} in %{time_total}s\n" --connect-timeout 5 "https://$TARGET_FQDN:$TARGET_PORT"
done
```

All 10 attempts should finish without timeouts. If intermittent failures persist after you expand SNAT capacity, capture a network trace at the source network adapter, and file an Azure support request by including the trace and correlation IDs.

## References

- [Troubleshoot Azure Private Endpoint connectivity problems](troubleshoot-private-endpoint-connectivity-problems.md)
- [Private endpoint DNS integration](troubleshoot-private-endpoint-dns-resolution.md)
- [Manage network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy)
- [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview)
- [Integrate your app with an Azure virtual network](/azure/app-service/overview-vnet-integration)
