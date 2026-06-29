---
title: Troubleshoot Azure Load Balancer limitations
description: Identify Azure Load Balancer Layer-4 limitations and find the right service for your needs. Learn which platform constraints apply to your scenario.
ms.service: azure-load-balancer
ms.topic: troubleshooting
ms.custom: sap:Management
ms.date: 6/17/2026
ai.hint.symptom-tags:
  - layer-7-routing
  - path-based-routing
  - host-based-routing
  - tls-termination
  - sni
  - cookie-affinity
  - sticky-sessions
  - hairpin
  - loopback
  - lb-chaining
  - no-access-logs
  - uneven-distribution
  - wrong-service
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/loadBalancers/read
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/frontDoors/read
  - Microsoft.Network/trafficManagerProfiles/read
  - Microsoft.Insights/diagnosticSettings/read
  - Microsoft.Network/networkWatchers/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
---

# Troubleshoot Azure Load Balancer limitations

## Summary

This article helps you identify Azure Load Balancer Layer-4 limitations and determine whether this service is right for your scenario. You'll learn which platform constraints apply to your workload and discover alternative services that may better meet your needs.

Azure Load Balancer is a **Layer-4 (TCP/UDP)** service. Many support cases aren't product problems. They're requests for behavior that Load Balancer doesn't provide by design: Layer-7 (path, host, or URL) routing, Transport Layer Security (TLS) termination or Server Name Indication (SNI), cookie-based sticky sessions, hairpin (a backend reaching its own frontend VIP), arbitrary load-balancer chaining, application or access logs, or per-request round-robin operations. 

## Symptoms

You might experience one or more of the following symptoms:

- You configure a Load Balancer rule and expect it to route by URL path or hostname (for example, `/api` to one pool and `/web` to another), but all traffic goes to one backend.
- You expect the Load Balancer to terminate TLS or select a backend based on the TLS SNI hostname, and there's no setting for it.
- You enable session persistence but the application still loses session state because there's no cookie-based affinity option.
- A backend virtual machine (VM) can't connect to the Load Balancer frontend virtual IP (VIP) that the same VM serves (connection times out or is refused).
- You chain two Load Balancers and traffic doesn't flow as expected.
- You look for HTTP access logs or request logs on the Load Balancer and find only metrics and health-event logs.
- Traffic isn't evenly split across backends (like one or two backends receive most connections) even though all backends are healthy.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required:** `Reader` role on the Load Balancer and the resource group for all diagnostics; `Network Contributor` role (or equivalent) only if you apply a write-operation resolution like enabling virtual network (VNet) flow logs.
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the Load Balancer | `myResourceGroup` |
| `{RESOURCE_NAME}` | Load Balancer resource name | `myLoadBalancer` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check the Load Balancer SKU, whether it's public or internal, and the rules it carries. This baseline check tells you that the resource is a Layer-4 Load Balancer (TCP or User Datagram Protocol (UDP) only) and gives you the rule names that the later steps inspect.

Run the following commands with Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{sku:sku.name, tier:sku.tier, frontends:frontendIPConfigurations[].{name:name, privateIp:privateIPAddress, publicIp:publicIPAddress.id}, rules:loadBalancingRules[].name}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next step |
|---|---|---|
| A `sku` of `Basic`, `Standard`, or `Gateway` and one or more `rules`. | This is a Layer-4 Load Balancer. Confirm what you're trying to do | Perform [Step 2](#step-2). |
| `frontends` entries have a `publicIp` value. | This is a **public** Load Balancer. | Perform [Step 2](#step-2). |
| `frontends` entries have only a `privateIp` value. | This is an **internal** Load Balancer. | Perform [Step 2](#step-2). |
| `rules` is empty or `null` | No load-balancing rule is configured. This guide assumes at least one rule exists. Configure a rule first. | Configure a load-balancing rule, then re-run [Step 1](#step-1). |
| `ResourceNotFound` error. | Subscription, resource group, or Load Balancer name is incorrect. | Verify your variables and re-run. |

### Step 2

Check which capability you're trying to get from Load Balancer. Load Balancer operates only at Layer 4 (TCP or UDP). Match your goal in the following table to the diagnostic step that confirms whether you hit a by-design Layer-4 limitation.

> This step has no command. It routes you by intent. Each target step runs a read-only command that produces the signal confirming the limitation before recommending a different service.

### Interpret your goals

| What you're trying to do | Likely limitation | Next steps |
|---|---|---|
| Route by URL path, hostname, or do TLS termination or SNI. | No Layer-7 routing. | Perform [Step 3](#step-3). |
| Keep a client pinned to a backend with a cookie (true sticky sessions). | No cookie-based affinity. | Perform [Step 4](#step-4). |
| Have a backend VM connect to the frontend VIP it also serves. | No hairpin or loopback. | Perform [Step 5](#step-5). |
| Cascade or chain Load Balancers. | Load Balancer chaining constraints. | Perform [Step 6](#step-6). |
| Get HTTP access or request logs. | No Layer-4 application logs. | Perform [Step 7](#step-7). |
| Get even, per-request round-robin distribution. | Hash-based, not round-robin. | Perform [Step 8](#step-8). |

### Step 3

Check whether your rules are Layer-4 only (TCP or UDP). If they are, path-based routing, host-based routing, URL rewrite, TLS termination, and SNI aren't available. Also check whether an Application Gateway already exists in the resource group that you can route through instead.

Run the following commands with Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, protocol:protocol, frontendPort:frontendPort, backendPort:backendPort}" \
  --output table
```

Then check whether a Layer-7 service already exists in the resource group:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az network application-gateway list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, tier:sku.tier}" \
  --output table
```

### Interpret the results

The `protocol` column of a load-balancing rule can only be `Tcp`, `Udp`, or `All`. There's no HTTP or HTTPS protocol, no listener path, and no host condition. This protocol value is the deterministic signal that the rule can't make Layer-7 routing decisions.

| If you see... | Meaning | Next steps |
|---|---|---|
| Rule `protocol` is `Tcp`, `Udp`, or `All`, and you need path or host routing, TLS termination, or SNI. | Load Balancer can't route at Layer 7. This limitation is by design. | Perform [Resolution A](#resolution-a). |
| The Application Gateway list returns one or more gateways. | A Layer-7 entry point already exists you can route through. | Perform [Resolution A](#resolution-a). |
| The Application Gateway list is empty and you need global, Azure Content Delivery Network (CDN), or Azure Web Application Firewall (WAF)-at-edge routing. | You likely need Azure Front Door rather than a regional gateway. | Perform [Resolution A](#resolution-a). |
| Your rules are `Tcp` or `Udp` and you only need Layer-4 forwarding (no path or host logic). | Load Balancer is the correct service. | No change needed — Load Balancer fits this workload., |

### Step 4

Check the session-persistence (affinity) mode on each rule. Load Balancer offers only hash-based affinity (`Default` is 5-tuple, `SourceIP` is 2-tuple, `SourceIPProtocol` is 3-tuple). None of these options is a cookie-based application affinity.

Run the following commands with Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, loadDistribution:loadDistribution, protocol:protocol}" \
  --output table
```

### Interpret the results

The `loadDistribution` value is the deterministic signal. Every possible value is a network-tuple hash. There's no cookie option anywhere in the Load Balancer schema.

| If you see... | Meaning | Next steps |
|---|---|---|
| `loadDistribution` is `Default` (5-tuple) and you need a client pinned across address or port changes. | Only network-hash affinity is available. There's no cookie affinity by design. | Perform [Resolution B](#resolution-b). |
| `loadDistribution` is `SourceIP` (2-tuple) or `SourceIPProtocol` (3-tuple) and clients still lose session state. | Source-IP affinity breaks when clients share a network address translation (NAT) or proxy or change IP. It isn't application-layer stickiness. | Perform [Resolution B](#resolution-b). |
| `loadDistribution` is `SourceIP` or `SourceIPProtocol` and source-IP pinning is acceptable. | Source-IP affinity might be sufficient and no cookie's needed. | No change needed. Confirm clients have stable source IPs. |

### Step 5

Check whether the client that can't reach the frontend VIP is itself a member of the Load Balancer's backend pool. A backend instance connecting to a frontend VIP that it also serves (like hairpin or loopback) isn't supported by Load Balancer by design.

Run the following commands with Azure CLI.

List the frontend IPs and the backend pool members, then compare them to the source host that's failing to connect:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

# Frontend VIPs (the addresses the backend is trying to reach)
az network lb frontend-ip list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, privateIp:privateIPAddress, publicIp:publicIPAddress.id}" \
  --output table
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

# Backend pool members (the hosts the LB sends traffic to)
az network lb address-pool list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{pool:name, members:loadBalancerBackendAddresses[].{name:name, ip:ipAddress, nic:networkInterfaceIPConfiguration.id}}" \
  --output json
```

### Interpret the results

The key signal is membership. Compare the host that fails to connect (its network interface card (NIC) IP configuration ID or private IP) against the `members` list. If the failing source is in the backend pool and the destination it can't reach is one of the frontend VIPs, you encountered the hairpin limitation.

> [!NOTE]
> For an IP-based backend pool, the member appears with an `ip` value and a `null` `nic`. For a NIC-based backend pool, the member appears with a `nic` and a `null` `ip`. Match the failing host against whichever field is populated. One of the two uniquely identifies the source host. Azure exposes no server-side signal that a backend attempted to reach its own VIP, so this membership comparison is the deterministic detection.

| If you see... | Meaning | Next steps |
|---|---|---|
| The failing source host appears in the `members` list and is connecting to a frontend VIP previously listed. | Hairpin or loopback to the Load Balancer's own VIP isn't supported by design. | Perform [Resolution C](#resolution-c). |
| The failing source host isn't in the `members` list. | This isn't a hairpin scenario. The connectivity failure has another cause. | Go to [References](#references). |
| The destination IP isn't one of the frontend VIPs previously listed. | The failing connection isn't to the Load Balancer frontend. Investigate the actual destination. | Go to [References](#references). |

### Step 6

Check whether multiple Load Balancers exist in the resource group and how they're layered. Chaining is constrained: An internal Standard Load Balancer can sit behind a public Standard Load Balancer (a supported pattern), but arbitrary public-behind-public cascades aren't supported.

Run the following commands with Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az network lb list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, sku:sku.name, hasPublicFrontend:frontendIPConfigurations[?publicIPAddress!=null] | length(@), hasPrivateFrontend:frontendIPConfigurations[?privateIPAddress!=null] | length(@)}" \
  --output table
```

### Interpret the results

The signal is the SKU and frontend type of each Load Balancer in the chain. `hasPublicFrontend > 0` means the Load Balancer is public and `hasPrivateFrontend > 0` means it has an internal frontend.

> [!NOTE]
> This command establishes only that multiple Load Balancers exist as well as their SKU or frontend types. It doesn't prove one Load Balancer's backend pool targets another's frontend. To confirm a *true* chain, list the front Load Balancer's backend pool members (`az network lb address-pool list` from [Step 5](#step-5)) and check whether any member IP equals the second Load Balancer's frontend private IP. Two public Standard Load Balancers and a Basic or Standard SKU mix are both unsupported regardless of whether a backend link is configured.

| If you see... | Meaning | Next steps |
|---|---|---|
| A public Standard Load Balancer whose backend resolves to an internal Standard Load Balancer frontend. | Supports chaining pattern (public-to-internal). | Perform [Resolution D](#resolution-d). |
| Two public Load Balancers cascaded (public-to-public). | Public-behind-public chaining isn't a supported pattern. | Perform [Resolution D](#resolution-d). |
| A `Basic` SKU mixed with a `Standard` SKU in the chain. | Basic and Standard SKUs can't be mixed in a single load-balanced path. | Perform [Resolution D](#resolution-d). |
| Only one Load Balancer is listed. | There is no chain. Re-check your goal. | Perform [Step 2](#step-2). |

### Step 7

Check which diagnostic log categories the Load Balancer supports. A Layer-4 Load Balancer doesn't produce HTTP access logs or request logs, only metrics and health or alert events. This step confirms the absence of an access-log category so you know to collect flow data elsewhere.

Run the following commands with Azure CLI.

Get the Load Balancer resource ID, then list its available diagnostic categories:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

LB_ID=$(az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az monitor diagnostic-settings categories list \
  --resource "$LB_ID" \
  --query "value[].{name:name, type:categoryType}" \
  --output table
```

### Interpret the results

The signal is the set of category names returned. The Load Balancer exposes metric categories and health-event log categories, but no category for HTTP requests or application or access logs because it never inspects Layer-7 traffic.

> [!NOTE]
> A Standard Load Balancer returns exactly two categories: `LoadBalancerHealthEvent` (type `Logs`) and `AllMetrics` (type `Metrics`). There's no `LoadBalancerAlertEvent` and no HTTP or access-log category. A Basic Load Balancer exposes no diagnostic-settings categories at all (the list returns empty).

| If you see... | Meaning | Next steps |
|---|---|---|
| Categories are limited to metrics and health or alert events, with no access or request log category. | There are no Layer-4 application logs by design. | Perform [Resolution E](#resolution-e). |
| You need per-connection 5-tuple flow records (like allow, deny, and bytes). | Capture this with VNet flow logs or Azure Network Watcher, not the Load Balancer. | Perform [Resolution E](#resolution-e). |
| The category list is empty. | The SKU (often `Basic`) exposes no diagnostic categories. | Perform [Resolution E](#resolution-e). |

### Step 8

Check whether your distribution expectation matches Load Balancer's hash-based algorithm. Load Balancer distributes by hashing a connection tuple, not by a per-request round-robin operation, so flow counts can look uneven even when all backends are healthy.

Run the following commands with Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, loadDistribution:loadDistribution, protocol:protocol}" \
  --output table
```

### Interpret the results

The `loadDistribution` value is the signal that determines how concentrated traffic becomes.

| If you see... | Meaning | Next steps |
|---|---|---|
| `loadDistribution` is `Default` (5-tuple) but distribution still looks uneven. | Hash-based on flow, not round-robin. Few clients or long-lived connections concentrate on one backend. | Perform [Resolution F](#resolution-f). |
| `loadDistribution` is `SourceIP` or `SourceIPProtocol` | 2-tuple or 3-tuple affinity pins each source IP to one backend, concentrating traffic from shared NATs or proxies. | Perform [Resolution F](#resolution-f). |
| You require strict per-request round-robin across backends. | Layer-4 hashing can't do per-request balancing but a Layer-7 service can. | Perform [Resolution F](#resolution-f). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| Rule `protocol` is TCP, UDP, or All and you need path or host routing, TLS, or SNI. | Perform [Resolution A](#resolution-a). |
| You need cookie-based sticky sessions and Load Balancer only offers hash affinity. | Perform [Resolution B](#resolution-b). |
| Failing source is a backend pool member reaching its own frontend VIP. | Perform [Resolution C](#resolution-c). |
| Two public Load Balancers cascaded, or Basic or Standard SKUs mixed in a chain. | Perform [Resolution D](#resolution-d). |
| No accessor request log category exists on the Load Balancer. | Perform [Resolution E](#resolution-e). |
| Distribution is uneven> Load Balancer is hash-based, not round-robin. | Perform [Resolution F](#resolution-f). |
| Your rules are TCP or UDP-based and you only need Layer-4 forwarding. | Load Balancer is the correct service. No change needed. |
| Limitation confirmed but the recommended service doesn't fit. | File an Azure support request. |

## Resolution A

You need Layer-7 behavior, like path-based or host-based routing, URL rewrite, TLS termination, or SNI-based backend selection. Load Balancer operates only at Layer 4 (TCP and UDP), never inspects the HTTP request or TLS SNI, and can't make these decisions.

Choose the Layer-7 service that matches your scope:

- **Application Gateway**: Regional Layer-7 load balancer with path or host routing, TLS termination, SNI, and a WAF. Use it for a single region.
- **Front Door**: Global Layer-7 entry point with edge routing, caching or CDN, and WAF. Use it for multi-region or global traffic.
- **Azure Traffic Manager**: Domain Name System (DNS)-based global routing (it returns an endpoint by DNS, not proxy traffic). Use it when you need DNS-level failover or geo-routing rather than an HTTP proxy.

Run the following commands in Azure CLI.

1. Confirm whether an Application Gateway already exists you can route through.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az network application-gateway list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, tier:sku.tier, state:operationalState}" \
  --output table
```

If a gateway already exists, add the listener, rule, and backend pool there instead of deploying a new resource.

2. If no Layer-7 resource exists, create an Application Gateway as your Layer-7 entry point. The following example creates a v2 gateway. You need to supply your own VNet, subnet, and public IP.


> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This is a write operation that creates a billable Application Gateway.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$APPGW_NAME" ] && read -rp "New App Gateway Name: " APPGW_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:          " VNET_NAME
[ -z "$APPGW_SUBNET" ] && read -rp "App Gateway Subnet: " APPGW_SUBNET
[ -z "$APPGW_PUBLIC_IP" ] && read -rp "Public IP Name:     " APPGW_PUBLIC_IP

az network application-gateway create \
  --name "$APPGW_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$APPGW_SUBNET" \
  --public-ip-address "$APPGW_PUBLIC_IP" \
  --sku Standard_v2 \
  --priority 100 \
  --verbose
```

> [!NOTE]
> `--priority` is mandatory for v2 SKUs (`Standard_v2`/`WAF_v2`). Omitting it fails the create operation. The gateway also requires a dedicated, empty subnet (no other resources) and a Standard SKU public IP address. The minimal flag previously set provisions a working v2 gateway. Be sure to configure listeners, rules, and backend pools afterward.

After the gateway is provisioned, configure listeners, path-based routing rules, and backend pools as per [Application Gateway URL path-based routing](/azure/application-gateway/url-route-overview). Keep the Load Balancer only for any remaining Layer-4 (non-HTTP) traffic.

## Resolution B

You need a client pinned to the same backend across its session (true sticky sessions). Load Balancer offers only network-tuple hash affinity (`loadDistribution`: `Default`, `SourceIP`, and `SourceIPProtocol`). It has no cookie-based affinity. Source-IP affinity breaks as soon as multiple clients share a NAT or proxy (they collapse to one backend) or a client's source IP changes (it moves to a different backend).

Run the following commands in Azure CLI.

1. If source-IP affinity is acceptable for your workload (clients have stable, distinct source IPs), you can set 2-tuple or 3-tuple affinity on the existing rule instead of moving services.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name (from Step 4): " RULE_NAME

az network lb rule update \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --load-distribution SourceIP
```

2. If you require true cookie-based stickiness (independent of client source IP), move the HTTP workload to Application Gateway, which supports cookie-based session affinity. Enable it on the gateway's backend HTTP settings.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:     " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:      " RG
[ -z "$APPGW_NAME" ] && read -rp "App Gateway Name:    " APPGW_NAME
[ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name:  " HTTP_SETTINGS_NAME

az network application-gateway http-settings update \
  --gateway-name "$APPGW_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$HTTP_SETTINGS_NAME" \
  --cookie-based-affinity Enabled
```

For more information, see [Application Gateway cookie-based affinity](/azure/application-gateway/configuration-http-settings#cookie-based-affinity).

## Resolution C

A backend instance tries to connect to the frontend VIP of the same Load Balancer that the instance is a member of. Load Balancer doesn't support this hairpin or loopback flow by design. The return path can't complete when the source and the load-balanced destination are the same instance.

Pick one of these supported redesigns. None require the Load Balancer to hairpin:

- **Connect directly to the backend.** From a backend instance, reach the peer instance by its own private IP or hostname instead of the shared VIP.
- **Use an internal endpoint that isn't the Load Balancer VIP.** Put a separate internal name or IP (for example, an Azure Private DNS record or a dedicated internal service) in front of the workload for intra-pool calls.
- **Use Azure Private Link for service-to-service access.** Expose the service behind a Private Link service or private endpoint so callers reach it without hairpinning through their own Load Balancer frontend.
- **Move HTTP traffic to Application Gateway**, which supports requests originating from its own backend instances for Layer-7 workloads.

There's no Load Balancer configuration flag that enables a hairpin. The fix is architectural. For more information, see [Load Balancer limitations](/azure/load-balancer/load-balancer-multivip-overview).

## Resolution D

A Load Balancer chaining topology you built isn't a supported pattern. Load Balancer supports a limited set of cascades, most notably an internal Standard Load Balancer behind a public Standard Load Balancer, but it doesn't support arbitrary public-behind-public cascades. It also doesn't support mixing Basic and Standard SKUs in the same load-balanced path.

Use a supported pattern:

- **Public-to-internal (Standard SKU):** Front your service with a public Standard Load Balancer, then place an internal Standard Load Balancer behind it for the next tier. This is the supported chaining pattern.
- **Keep SKUs consistent:** Use a Standard SKU end-to-end. Don't mix a Basic Load Balancer with a Standard Load Balancer in the same path.
- **For Layer-7 fan-out**, terminate at Application Gateway or Front Door and use the Load Balancer only for the Layer-4 tier behind it.

Run the following commands in Azure CLI.

Confirm the SKU of each Load Balancer in the path is consistent:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az network lb list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, sku:sku.name}" \
  --output table
```

If any Load Balancer in the path is `Basic`, plan a migration to Standard so the chain uses a single SKU. For more information, see [Upgrade from Basic to Standard Load Balancer](/azure/load-balancer/load-balancer-basic-upgrade-guidance).

## Resolution E

You expect HTTP access logs or request logs from the Load Balancer. A Layer-4 Load Balancer never inspects the application payload, so it produces only metrics and health events and there's no access-log category. Capture connection-level (5-tuple) flow data with (VNet) flow logs and analyze it with Network Watcher or Traffic Analytics instead.

> [!NOTE]
> Network security group (NSG) flow logs are being retired (no new NSG flow logs can be created as of June 30, 2025 and full retirement will happen on September 30, 2027). Use VNet flow logs, which supersede NSG flow logs and capture the same per-connection 5-tuple data at the virtual network scope.

Run the following commands in Azure CLI.

1. Confirm a Network Watcher exists in the Load Balancer's region:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az network watcher list \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, location:location, state:provisioningState}" \
  --output table
```

2. Enable VNet flow logs on the VNet containing the backend subnet so you capture per-connection allow and deny records. Supply a storage account for the log data.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This enables flow logging and writes log data to the storage account you specify.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$FLOWLOG_NAME" ] && read -rp "Flow Log Name:     " FLOWLOG_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:         " VNET_NAME
[ -z "$STORAGE_ACCOUNT" ] && read -rp "Storage Account Name: " STORAGE_ACCOUNT
[ -z "$LOCATION" ] && read -rp "Region (e.g. eastus): " LOCATION

az network watcher flow-log create \
  --name "$FLOWLOG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --location "$LOCATION" \
  --vnet "$VNET_NAME" \
  --storage-account "$STORAGE_ACCOUNT" \
  --enabled true \
  --verbose
```

The `--location` value must match the region of the target virtual network (the regional Network Watcher is selected by location). Use `--subnet` or `--nic` instead of `--vnet` to scope the flow log more narrowly.

For request-level analytics, review VNet flow logs in [Traffic Analytics](/azure/network-watcher/traffic-analytics). For Layer-7 access logs, the workload must front with Application Gateway or Front Door, both of which emit access logs.

## Resolution F

Distribution looks uneven because Load Balancer is hash-based, not round-robin. When you use the `Default` (5-tuple) mode, it hashes the source IP, source port, destination IP, destination port, and protocol to pick a backend for each flow. When you use `SourceIP` or `SourceIPProtocol`, it pins each source IP to one backend. A few clients, long-lived connections, or shared NAT or proxy front ends concentrate flows on a subset of backends even when every backend is healthy.

Run the following commands in Azure CLI.

1. If you set 2-tuple or 3-tuple affinity and that's what's concentrating traffic, return the rule to the default 5-tuple hash for the widest spread.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name (from Step 8): " RULE_NAME

az network lb rule update \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --load-distribution Default
```

2. If you require strict per-request balancing across backends (not per-flow), Layer 4 hashing can't deliver it. Move the HTTP workload to Application Gateway, which balances per request by using a round-robin algorithm. For a deeper analysis of source-entropy and persistence causes specific to Load Balancer, see the uneven-distribution troubleshooter linked in [References](#references).

---

## References

- [Azure Load Balancer overview](/azure/load-balancer/load-balancer-overview)
- [Load Balancer distribution modes (hash-based distribution)](/azure/load-balancer/distribution-mode-concepts)
- [Load Balancer multiple frontends and limitations](/azure/load-balancer/load-balancer-multivip-overview)
- [What is Azure Application Gateway?](/azure/application-gateway/overview)
- [What is Azure Front Door?](/azure/frontdoor/front-door-overview)
- [What is Traffic Manager?](/azure/traffic-manager/traffic-manager-overview)
- [VNet flow logs and Traffic Analytics](/azure/network-watcher/traffic-analytics)
- [Load Balancer and Application Gateway comparison](/azure/architecture/guide/technology-choices/load-balancing-overview)
