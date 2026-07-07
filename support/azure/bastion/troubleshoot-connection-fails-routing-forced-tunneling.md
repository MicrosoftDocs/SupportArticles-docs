---
title: Troubleshoot Azure Bastion routing and forced tunneling
description: Learn to diagnose and fix Azure Bastion connection failures caused by routing issues, forced tunneling, or DNS conflicts. Follow step-by-step guidance to restore connectivity.
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 6/17/2026
ms.custom: Connectivity
ai.hint.symptom-tags:
  - bastion-connection-failure
  - forced-tunneling
  - udr-bastion-subnet
  - default-route-injection
  - route-server-default-route
  - private-dns-conflict
  - asymmetric-routing
  - nva-return-path
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/bastionHosts/read
  - Microsoft.Network/virtualNetworks/subnets/read
  - Microsoft.Network/routeTables/read
  - Microsoft.Network/networkInterfaces/effectiveRouteTable/action
  - Microsoft.Network/routeServer/read
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/virtualNetworks/subnets/write
  - Microsoft.Network/routeTables/write
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - BASTION_NAME
---

# Troubleshoot Azure Bastion connection failures caused by routing and forced tunneling

## Summary

This article provides step-by-step diagnostics to identify and resolve Azure Bastion connection failures caused by user-defined routes (UDRs), forced tunneling, Azure Route Server default-route injection, or conflicting private Domain Name System (DNS) zones. 

Azure Bastion connections fail when the platform control-plane path is disrupted by UDRs, Border Gateway Protocol (BGP)-propagated default routes (0.0.0.0/0) from Route Server or on-premises VPN, conflicting private DNS zones that shadow Azure Bastion's required management endpoints, or asymmetric routing caused by network virtual appliance (NVA) insertion on the virtual machine (VM) subnet. 

## Symptoms

You might encounter one or more of the following symptoms:

- An Azure Bastion connection to a VM stops responding at `Connecting` and eventually times out.
- The Azure Bastion portal shows `Failed to connect to the virtual machine` or a generic connection error.
- Azure Bastion was working previously and broke after a network change (like a route table, Route Server peering, private DNS zone link, or NVA deployment).
- Newly-deployed Azure Bastion never establishes a session despite the VM being reachable from other paths.
- The [Azure portal](https://portal.azure.com) shows the Azure Bastion resource in a `Succeeded` provisioning state but sessions still fail.

> [!NOTE]
> These symptoms are identical to those caused by NSG or firewall port blocks. If this article's diagnostics all pass without finding a cause, see `[Troubleshoot Azure Bastion connection failures caused by blocked ports](../connection-fails-nsg-blocked-ports/troubleshoot-bastion-connection-blocked-ports.md)`.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required:** `Network Contributor` permissions on the resource group containing the Azure Bastion host and its virtual network (VNet), or equivalent read permissions.
- **Tools:** Azure CLI 2.x or an AI agent with Azure CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `RG` | Resource group containing the Azure Bastion host | `myResourceGroup` |
| `BASTION_NAME` | Azure Bastion resource name | `myBastionHost` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the Azure Bastion resource exists, is in a healthy provisioning state, and which VNet and subnet it's deployed into.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$BASTION_NAME" ] && read -rp "Bastion Name:     " BASTION_NAME

az network bastion show \
  --name "$BASTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, sku:sku.name, subnetId:ipConfigurations[0].subnet.id}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `"provisioningState": "Succeeded"`. | Azure Bastion is provisioned. | Perform [Step 2a](#step-2a). |
| `"provisioningState": "Failed"`. | Azure Bastion deployment failed. Routing or subnet issues might have caused the failure. | Fix the provisioning error first using `[Troubleshoot Azure Bastion host deployment failures](../deployment-fails-subnet-capacity-prereqs/troubleshoot-bastion-deployment-fails-prerequisites.md)`, then re-run [Step 1](#step-1). |
| `"provisioningState": "Updating"`. | Azure Bastion is mid-update. | Wait for the operation to complete, then re-run [Step 1](#step-1). |
| `ResourceNotFound` error. | Subscription, resource group, or Azure Bastion name is incorrect. | Verify your variables and re-run [Step 1](#step-1). |

Record the `subnetId` value. It contains the VNet name and confirms the subnet is `AzureBastionSubnet`. Extract the VNet name and resource group from the subnet ID for use in subsequent steps.

### Step 2a

Check whether a route table (UDR) is associated with `AzureBastionSubnet` and, if so, what routes it contains. Any route that diverts 0.0.0.0/0 away from `Internet` breaks Azure Bastion.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$BASTION_NAME" ] && read -rp "Bastion Name:     " BASTION_NAME

# Derive the VNet name and subnet from the Bastion resource
BASTION_SUBNET_ID=$(az network bastion show \
  --name "$BASTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

VNET_NAME=$(echo "$BASTION_SUBNET_ID" | sed -n 's|.*/virtualNetworks/\([^/]*\)/.*|\1|p')
VNET_RG=$(echo "$BASTION_SUBNET_ID" | sed -n 's|.*/resourceGroups/\([^/]*\)/.*|\1|p')

echo "VNet: $VNET_NAME (RG: $VNET_RG)"

# Check the AzureBastionSubnet for a route table association
az network vnet subnet show \
  --name "AzureBastionSubnet" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{routeTable:routeTable.id, addressPrefix:addressPrefix}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `"routeTable": null`. | No UDR on `AzureBastionSubnet`. | Perform [Step 3](#step-3). |
| `"routeTable"` contains a route table resource ID. | A UDR is associated with `AzureBastionSubnet`. | Perform [Step 2b](#step-2b). |

### Step 2b

Check the routes inside the route table associated with `AzureBastionSubnet` and whether BGP route propagation is disabled.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION

# Extract route table name and RG from the route table ID found in Step 2
# If you already know the route table name, enter it at the prompt instead
[ -z "$RT_NAME" ] && read -rp "Route Table Name (from Step 2): " RT_NAME
[ -z "$RT_RG" ] && read -rp "Route Table Resource Group:      " RT_RG

az network route-table show \
  --name "$RT_NAME" \
  --resource-group "$RT_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, disableBgpRoutePropagation:disableBgpRoutePropagation, routes:routes[].{name:name, addressPrefix:addressPrefix, nextHopType:nextHopType, nextHopIpAddress:nextHopIpAddress}}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| A route with `"addressPrefix": "0.0.0.0/0"` and `"nextHopType"` is `VirtualAppliance`, `VirtualNetworkGateway`, or `None`. | Default route is forcing all Azure Bastion traffic through an NVA, gateway, or black hole. This condition breaks Azure Bastion. | Perform [Resolution A](#resolution-a). |
| Routes exist but none override 0.0.0.0/0 and `"disableBgpRoutePropagation": true`. | UDR has specific routes only and BGP propagation is off. UDR isn't the cause. | Perform [Step 3](#step-3). |
| Routes exist but none override 0.0.0.0/0 and `"disableBgpRoutePropagation": false`. | UDR allows BGP propagation. A BGP-learned 0.0.0.0/0 can still reach Azure Bastion. | Perform [Step 3](#step-3). |
| Route table exists but contains no routes. | Empty route table. Check if BGP propagation is disabled. | If `disableBgpRoutePropagation` is `true`, perform [Step 3](#step-3). If `false`, perform [Step 3](#step-3) to check for BGP default routes. |

### Step 3

Check whether a Route Server, VPN, or Azure ExpressRoute gateway is injecting a 0.0.0.0/0 default route into the Azure Bastion VNet through BGP. This condition is the most common forced-tunneling scenario.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group: " VNET_RG

# Check for Route Server in the same resource group as the VNet
az network routeserver list \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, provisioningState:provisioningState, allowBranchToBranchTraffic:allowBranchToBranchTraffic}" \
  --output json
```

If a Route Server is found, check what routes its BGP peers are advertising:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group: " VNET_RG
[ -z "$RS_NAME" ] && read -rp "Route Server Name:           " RS_NAME

# List peerings
az network routeserver peering list \
  --routeserver "$RS_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, peerAsn:peerAsn, peerIp:peerIp}" \
  --output table

# For each peering, check learned routes for 0.0.0.0/0
[ -z "$PEERING_NAME" ] && read -rp "Peering Name (from above): " PEERING_NAME

az network routeserver peering list-learned-routes \
  --name "$PEERING_NAME" \
  --routeserver "$RS_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| No Route Server found (`[]` result.) | No Route Server in this resource group. BGP default-route injection from Route Server isn't the cause. | Perform [Step 4](#step-4). |
| Route Server exists but learned routes don't contain `0.0.0.0/0`. | Route Server is present but no default route is being advertised. | Perform [Step 4](#step-4). |
| Route Server learned routes contain `0.0.0.0/0` from a BGP peer. | A BGP peer is injecting a default route into the VNet. This route reaches `AzureBastionSubnet` and breaks Azure Bastion. | Perform [Resolution B](#resolution-b). |
| No Route Server, but a VPN Gateway or ExpressRoute Gateway exists in the VNet | On-premises might be advertising `0.0.0.0/0` through the gateway. | Check the gateway's learned routes or the effective routes on a VM network interface card (NIC) in the same VNet for a `0.0.0.0/0` route with source `VirtualNetworkGateway`. If present, perform [Resolution B](#resolution-b). |

> [!TIP]
> If no Route Server is present, check for an Azure VPN Gateway or ExpressRoute gateway in the VNet that might be propagating an on-premises default route. Run `az network vnet-gateway list --resource-group "$VNET_RG" --subscription "$SUBSCRIPTION" --output table` to check.

### Step 4

Check whether private DNS zones with names that conflict with Azure Bastion's required management endpoints are linked to the Azure Bastion VNet. Azure Bastion must resolve several Azure service endpoints through public DNS. A private DNS zone with the same name shadows the public record and breaks the service.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group: " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "Bastion VNet Name:          " VNET_NAME

# List all private DNS zones in the subscription and check for conflicting names
# Known conflicting zone names for Azure Bastion:
BLOCKED_ZONES="management.azure.com blob.core.windows.net core.windows.net vault.azure.net"

echo "Checking for private DNS zones linked to VNet: $VNET_NAME"
echo "---"

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv)

# List all private DNS zones in the subscription
az network private-dns zone list \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, resourceGroup:resourceGroup}" \
  --output json | \
  jq -r '.[] | "\(.resourceGroup) \(.name)"' | \
  while read ZONE_RG ZONE_NAME; do
    # Check if this zone is linked to the Bastion VNet
    LINKS=$(az network private-dns link vnet list \
      --zone-name "$ZONE_NAME" \
      --resource-group "$ZONE_RG" \
      --subscription "$SUBSCRIPTION" \
      --query "[?virtualNetwork.id=='$VNET_ID'].{linkName:name, registrationEnabled:registrationEnabled}" \
      --output json 2>/dev/null)
    if [ "$LINKS" != "[]" ] && [ -n "$LINKS" ]; then
      for BLOCKED in $BLOCKED_ZONES; do
        if [ "$ZONE_NAME" = "$BLOCKED" ]; then
          echo "⚠ CONFLICT: Private DNS zone '$ZONE_NAME' (RG: $ZONE_RG) is linked to the Bastion VNet"
          echo "  Link details: $LINKS"
        fi
      done
    fi
  done

echo "---"
echo "Check complete."
```

> [!NOTE]
> The exhaustive list of private DNS zone names that break Azure Bastion can include additional zones beyond the ones listed here. See the latest [Azure Bastion FAQ](/azure/bastion/bastion-faq) for the most up-to-date information.

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `Check complete.` with no `⚠ CONFLICT` lines. | No conflicting private DNS zones are linked to the Azure Bastion VNet. | Perform [Step 5](#step-5). |
| One or more `⚠ CONFLICT` lines listing a private DNS zone. | A private DNS zone is shadowing an endpoint Azure Bastion needs to resolve. This condition breaks the control-plane path. | Perform [Resolution C](#resolution-c). |

### Step 5
Check whether routing on the target VM's subnet introduces asymmetric paths or NVA middleboxes that break the Azure Bastion-to-VM connection. This condition applies when [Step 1](#step-1) through [Step 4](#step-4) are clean but sessions still fail.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VM_NAME" ] && read -rp "Target VM Name:   " VM_NAME
[ -z "$VM_RG" ] && read -rp "Target VM Resource Group: " VM_RG

# Get the VM's primary NIC
VM_NIC_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

echo "VM NIC: $VM_NIC_ID"

# Show effective routes on the VM's NIC
az network nic show-effective-route-table \
  --ids "$VM_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

### Interpret the results

Look at routes with a destination matching the `AzureBastionSubnet` address prefix (from [Step 2a](#step-2a)) or a broader prefix that covers it.

| If you see... | Meaning | Next steps |
|---|---|---|
| Traffic from the VM to `AzureBastionSubnet` routes through `VirtualNetwork` (next hop `VNetLocal`). | Direct path. No NVA in the way. | All routing diagnostics pass. Check `[blocked ports](../connection-fails-nsg-blocked-ports/troubleshoot-bastion-connection-blocked-ports.md)` next, then file an Azure support request if it's still unresolved. |
| Traffic from the VM to `AzureBastionSubnet` routes through `VirtualAppliance` (next hop is an NVA IP). | An NVA is in the return path between the VM and Azure Bastion. This condition causes asymmetric routing and breaks the session. | Perform [Resolution D](#resolution-d). |
| A 0.0.0.0/0 route through `VirtualAppliance` on the VM subnet and not a more specific route for the Azure Bastion subnet. | All VM traffic including Azure Bastion return traffic is forced through the NVA. | Perform [Resolution D](#resolution-d). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| UDR on `AzureBastionSubnet` contains a 0.0.0.0/0 route pointing to NVA, gateway, or `None`. | Perform [Resolution A](#resolution-a). |
| UDR on `AzureBastionSubnet` contains any route overriding Internet-bound traffic | Perform [Resolution A](#resolution-a). |
| Route Server, VPN, or ExpressRoute Gateway is advertising 0.0.0.0/0 into the Azure Bastion VNet. | Perform [Resolution B](#resolution-b). |
| Private DNS zone with a blocked name is linked to the Azure Bastion VNet. | Perform [Resolution C](#resolution-c). |
| NVA or UDR on the VM subnet breaks the return path to Azure Bastion. | Perform [Resolution D](#resolution-d). |
| All diagnostics pass but problems persist. | See `[Troubleshoot Azure Bastion connection failures caused by blocked ports](../connection-fails-nsg-blocked-ports/troubleshoot-bastion-connection-blocked-ports.md)` for more information and guidance. Then file an Azure support request if it's still unresolved. |

## Resolution A

A user-defined route (UDR) on `AzureBastionSubnet` diverts traffic away from the internet next hop. Azure Bastion requires direct internet access for its control-plane communication. Any route that overrides the system default 0.0.0.0/0-to-internet connection breaks this path.

> [!NOTE]
> In Azure, the platform guard `RouteTableCannotBeAttachedForAzureBastionSubnet` blocks attaching a route table to `AzureBastionSubnet` when the table contains a 0.0.0.0/0 route with a non-internet next hop. This scenario still applies to deployments where the route table was associated before the guard was introduced, or where the problematic route was added after association.

Run the following commands in Azure CLI.

1. Confirm the problematic route table and its routes.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RT_NAME" ] && read -rp "Route Table Name:             " RT_NAME
[ -z "$RT_RG" ] && read -rp "Route Table Resource Group:    " RT_RG

az network route-table show \
  --name "$RT_NAME" \
  --resource-group "$RT_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, routes:routes[].{name:name, addressPrefix:addressPrefix, nextHopType:nextHopType, nextHopIpAddress:nextHopIpAddress}}" \
  --output json
```

Record the route names that have `addressPrefix` of `0.0.0.0/0` or any prefix that might intercept Azure Bastion's control-plane traffic.

2. Use one of the two following options to remove the problematic routes from the Azure Bastion subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

**Option 1: Disassociate the route table from `AzureBastionSubnet` entirely** (preferred if the route table is only used for forced tunneling)

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "Bastion VNet Name:            " VNET_NAME
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group:   " VNET_RG

az network vnet subnet update \
  --name "AzureBastionSubnet" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --route-table "" \
  --output json
```

**Option 2: Delete only the offending 0.0.0.0/0 route** (if the route table contains other routes that are needed)

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RT_NAME" ] && read -rp "Route Table Name:             " RT_NAME
[ -z "$RT_RG" ] && read -rp "Route Table Resource Group:    " RT_RG
[ -z "$ROUTE_NAME" ] && read -rp "Route Name to Delete (from A.1): " ROUTE_NAME

az network route-table route delete \
  --route-table-name "$RT_NAME" \
  --resource-group "$RT_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$ROUTE_NAME"
```

3. Re-run [Step 2a](#step-2a). Confirm `"routeTable": null` (**Option 1**) or that no 0.0.0.0/0 route remains (**Option 2**). Then test the Azure Bastion connection.

If the issue persists, go to [Step 3](#step-3) to check for BGP-propagated default routes.

## Resolution B

A 0.0.0.0/0 default route is propagating into the Azure Bastion VNet through BGP, either from Route Server (with an NVA peer advertising a default route) or from an on-premises network through VPN Gateway or an ExpressRoute gateway. This route forces Azure Bastion's control-plane traffic into a path that drops it.

Run the following commands in Azure CLI.

1. Determine the source of the 0.0.0.0/0 route.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group: " VNET_RG

# Check for Route Server
az network routeserver list \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name}" \
  --output table

# Check for VPN/ExpressRoute gateways
az network vnet-gateway list \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, gatewayType:gatewayType}" \
  --output table
```

2. Use one of the two following options as appropriate for your scenario.

**Option 1: Route Server is the source** Configure the NVA BGP peer to stop advertising 0.0.0.0/0, or disable BGP route propagation on the `AzureBastionSubnet` route table so BGP-learned routes don't reach Azure Bastion.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

To disable BGP propagation on the `AzureBastionSubnet`, first ensure a route table is associated (create one if needed), then disable propagation. Azure requires any route table attached to `AzureBastionSubnet` to contain a `0.0.0.0/0`-to-`Internet` route. The following script adds that route before associating the table.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "Bastion VNet Name:            " VNET_NAME
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group:   " VNET_RG

# Check if a route table is already associated
EXISTING_RT=$(az network vnet subnet show \
  --name "AzureBastionSubnet" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "routeTable.id" \
  --output tsv)

if [ -z "$EXISTING_RT" ] || [ "$EXISTING_RT" = "None" ]; then
  echo "No route table on AzureBastionSubnet. Creating one..."
  az network route-table create \
    --name "rt-AzureBastionSubnet" \
    --resource-group "$VNET_RG" \
    --subscription "$SUBSCRIPTION" \
    --disable-bgp-route-propagation true \
    --output json

  az network route-table route create \
    --route-table-name "rt-AzureBastionSubnet" \
    --resource-group "$VNET_RG" \
    --subscription "$SUBSCRIPTION" \
    --name "allow-internet" \
    --address-prefix "0.0.0.0/0" \
    --next-hop-type "Internet"

  az network vnet subnet update \
    --name "AzureBastionSubnet" \
    --vnet-name "$VNET_NAME" \
    --resource-group "$VNET_RG" \
    --subscription "$SUBSCRIPTION" \
    --route-table "rt-AzureBastionSubnet" \
    --output json
else
  echo "Route table already associated: $EXISTING_RT"
  RT_NAME_EXTRACTED=$(echo "$EXISTING_RT" | sed -n 's|.*/routeTables/\(.*\)|\1|p')
  RT_RG_EXTRACTED=$(echo "$EXISTING_RT" | sed -n 's|.*/resourceGroups/\([^/]*\)/.*|\1|p')
  az network route-table update \
    --name "$RT_NAME_EXTRACTED" \
    --resource-group "$RT_RG_EXTRACTED" \
    --subscription "$SUBSCRIPTION" \
    --disable-bgp-route-propagation true \
    --output json

  # Ensure a 0.0.0.0/0 → Internet route exists (required by Azure for AzureBastionSubnet)
  HAS_INTERNET_ROUTE=$(az network route-table route list \
    --route-table-name "$RT_NAME_EXTRACTED" \
    --resource-group "$RT_RG_EXTRACTED" \
    --subscription "$SUBSCRIPTION" \
    --query "[?addressPrefix=='0.0.0.0/0' && nextHopType=='Internet'].name | [0]" \
    --output tsv)

  if [ -z "$HAS_INTERNET_ROUTE" ] || [ "$HAS_INTERNET_ROUTE" = "None" ]; then
    echo "Adding required 0.0.0.0/0 → Internet route..."
    az network route-table route create \
      --route-table-name "$RT_NAME_EXTRACTED" \
      --resource-group "$RT_RG_EXTRACTED" \
      --subscription "$SUBSCRIPTION" \
      --name "allow-internet" \
      --address-prefix "0.0.0.0/0" \
      --next-hop-type "Internet"
  fi
fi
```

**Option 2: VPN or ExpressRoute Gateway is the source** 

The fix depends on the network design. Do one of the following steps:

- Disable BGP route propagation on `AzureBastionSubnet` (same commands in **Option 1**).
- Move Azure Bastion to a separate VNet that isn't connected to the forced-tunneling path and peer it to the workload VNet.

3. Verify that BGP propagation is disabled on `AzureBastionSubnet`.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "Bastion VNet Name:            " VNET_NAME
[ -z "$VNET_RG" ] && read -rp "Bastion VNet Resource Group:   " VNET_RG

RT_ID=$(az network vnet subnet show \
  --name "AzureBastionSubnet" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "routeTable.id" \
  --output tsv)

az network route-table show \
  --ids "$RT_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, disableBgpRoutePropagation:disableBgpRoutePropagation}" \
  --output json
```

Confirm `"disableBgpRoutePropagation": true`. Then test the Azure Bastion connection.

If the issue persists, go to [Step 4](#step-4) to check for private DNS conflicts.

## Resolution C

A private DNS zone with a name that matches one of Azure Bastion's required management endpoints is linked to the Azure Bastion VNet. This configuration causes Azure Bastion's internal DNS resolution to return private IP addresses (or NXDOMAIN) instead of the public Azure service endpoints it needs.

Known conflicting private DNS zone names include:

- `management.azure.com`
- `blob.core.windows.net`
- `core.windows.net`
- `vault.azure.net`

> [!NOTE]
> The exhaustive list of private DNS zone names that break Azure Bastion can include additional zones beyond the ones listed here. See the latest [Azure Bastion FAQ](/azure/bastion/bastion-faq) for the most up-to-date information.

Run the following commands in Azure CLI.

1. Identify the conflicting zone link.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$ZONE_NAME" ] && read -rp "Conflicting DNS Zone Name (from Step 4): " ZONE_NAME
[ -z "$ZONE_RG" ] && read -rp "DNS Zone Resource Group:                  " ZONE_RG

az network private-dns link vnet list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

Record the link name that points to the Azure Bastion VNet.

2. Unlink the conflicting private DNS zone. This action doesn't delete the zone or affect other VNets linked to it.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$ZONE_NAME" ] && read -rp "Conflicting DNS Zone Name:    " ZONE_NAME
[ -z "$ZONE_RG" ] && read -rp "DNS Zone Resource Group:       " ZONE_RG
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (from C.1):    " LINK_NAME

az network private-dns link vnet delete \
  --name "$LINK_NAME" \
  --zone-name "$ZONE_NAME" \
  --resource-group "$ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --yes
```

> [!TIP]
> If other services in the Azure Bastion VNet depend on this private DNS zone, consider moving Azure Bastion to a separate VNet (with VNet peering to the workload VNet) where the conflicting zone isn't linked.

3. Re-run [Step 4](#step-4). Confirm no `⚠ CONFLICT` lines appear. Then test the Azure Bastion connection.

If the issue persists after removing all conflicting DNS zones, go to [Step 5](#step-5) to check for asymmetric routing on the VM side.

## Resolution D

A UDR or NVA on the target VM's subnet forces return traffic (from the VM back to Azure Bastion) through a middlebox or alternate path. This setup creates an asymmetric route. Azure Bastion sends traffic directly to the VM through the Azure backbone, but the VM's reply goes through the NVA. This configuration either drops the traffic, applies network address translation (NAT), or resets the connection.

Run the following commands in Azure CLI.

1. Confirm the NVA route on the VM subnet.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VM_NAME" ] && read -rp "Target VM Name:   " VM_NAME
[ -z "$VM_RG" ] && read -rp "Target VM Resource Group: " VM_RG

# Get the VM's subnet
VM_SUBNET_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv | xargs -I{} az network nic show --ids {} --subscription "$SUBSCRIPTION" --query "ipConfigurations[0].subnet.id" --output tsv)

echo "VM Subnet: $VM_SUBNET_ID"

# Check route table on VM subnet
az network vnet subnet show \
  --ids "$VM_SUBNET_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "{routeTable:routeTable.id}" \
  --output json
```

2. Add a specific route on the VM's subnet route table that sends traffic destined for `AzureBastionSubnet` directly through the VNet (bypassing the NVA) while keeping other traffic routed through the NVA.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VM_RT_NAME" ] && read -rp "VM Subnet Route Table Name:     " VM_RT_NAME
[ -z "$VM_RT_RG" ] && read -rp "VM Subnet Route Table RG:        " VM_RT_RG
[ -z "$BASTION_SUBNET_PREFIX" ] && read -rp "AzureBastionSubnet CIDR (from Step 2, e.g. 10.0.1.0/26): " BASTION_SUBNET_PREFIX

az network route-table route create \
  --route-table-name "$VM_RT_NAME" \
  --resource-group "$VM_RT_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "direct-to-bastion-subnet" \
  --address-prefix "$BASTION_SUBNET_PREFIX" \
  --next-hop-type "VnetLocal"
```

3. Verify the new route is active on the VM NIC.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$VM_NAME" ] && read -rp "Target VM Name:   " VM_NAME
[ -z "$VM_RG" ] && read -rp "Target VM Resource Group: " VM_RG

VM_NIC_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

az network nic show-effective-route-table \
  --ids "$VM_NIC_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "value[?contains(addressPrefix[0], '$(echo $BASTION_SUBNET_PREFIX | cut -d/ -f1)')]" \
  --output table
```

Confirm the route to the `AzureBastionSubnet` prefix shows `VnetLocal` as the next hop. Then test the Azure Bastion connection.

If the issue persists after you check all four resolutions, routing isn't the problem. Continue with `[Troubleshoot Azure Bastion connection failures caused by blocked ports](../connection-fails-nsg-blocked-ports/troubleshoot-bastion-connection-blocked-ports.md)`. If that article also passes without resolution, file an Azure support request.

## References

- `[Troubleshoot Azure Bastion connection failures caused by blocked ports](../connection-fails-nsg-blocked-ports/troubleshoot-bastion-connection-blocked-ports.md)`
- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
- [Azure Bastion and VNet peering](/azure/bastion/vnet-peering)
- [Configure forced tunneling for Azure services](/azure/firewall/forced-tunneling)
- [What is Azure Route Server?](/azure/route-server/overview)
