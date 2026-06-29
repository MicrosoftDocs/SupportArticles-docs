---
title: Troubleshoot uneven traffic distribution in Azure Load Balancer
description: Diagnose and resolve scenarios in which Azure Load Balancer sends all or most traffic to a single backend or pins clients to the same instance.
ms.service: azure-load-balancer
ms.topic: troubleshooting
ms.custom: sap:Management
ms.date: 06/17/2026
author: ryanberg-aquent
ms.author: v-ryanberg
ai.hint.symptom-tags:
  - uneven-distribution
  - session-persistence
  - hash-based
  - source-ip-affinity
  - snat-entropy
  - dhcp-relay
  - syslog
  - one-backend-hot
  - round-robin-expected
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/loadBalancers/read
  - Microsoft.Network/loadBalancers/write
  - Microsoft.Insights/metrics/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
---

# Troubleshoot uneven traffic distribution in Azure Load Balancer

## Summary

This article helps you diagnose and resolve scenarios in which Azure Load Balancer sends all or most traffic to a single backend or pins clients to the same instance. 

Azure Load Balancer distributes flows by using a hash instead of round robin. Therefore, a single client or a single fronting Network Address Translation (NAT) or proxy can pin all traffic to one backend. Uneven distribution traces back to the following root causes: 

- Customer expectation of per-request round robin against the 5-tuple hash default is unrealistic. 
- Low source-IP entropy from an upstream NAT or proxy collapses many clients to one source IP. 
- Source-IP session persistence (2-tuple or 3-tuple) is configured if session stickiness isn't required. 
- The rule serves a protocol whose packets use the same tuple (Dynamic Host Configuration Protocol (DHCP) relay, syslog, Simple Network Management Protocol (SNMP) traps) and is, therefore, unsuitable for a flow-hash load balancer.

## Symptoms

You might encounter one or more of the following symptoms:

- One backend instance shows nearly 100 percent of received bytes or flows in Microsoft Viva Insights, while its peers are at near zero.
- A specific client IP, subnet, or office always arrives at the same backend even after the backend is restarted.
- Adding more backend instances doesn't reduce load on the busy instance.
- Traffic distribution looks even during testing, then collapses in production after a firewall, network virtual appliance (NVA), or proxy is put in front of the load balancer.
- DHCP, syslog, or SNMP trap traffic accumulates on one backend. Standby relay servers don't receive packets.
- Health probes report all backends as `Up`, although only one backend is doing work.

## Prerequisites

To troubleshoot uneven traffic distribution on Load Balancer, you need the following items:

- **Permissions required:** `Network Contributor` role on the load balancer's resource group (or equivalent role that grants `Microsoft.Network/loadBalancers/read`, `Microsoft.Network/loadBalancers/write`, and `Microsoft.Insights/metrics/read` permissions)
- **Tools:** Azure CLI 2._x_, or an AI agent that has Azure CLI access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID hosting the load balancer | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the load balancer | `myResourceGroup` |
| `{RESOURCE_NAME}` | Load balancer resource name | `myLoadBalancer` |
| `{RULE_NAME}` | Load balancing rule under investigation (from [Step 1](#step-1)) | `httpRule` |

> [!TIP]
> Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check every load balancing rule on the resource, including its current `loadDistribution` mode, transport protocol, front-end and back-end ports, idle timeout, and floating IP setting. This information is the single most important source for understanding how the load balancer hashes flows today.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, protocol:protocol, frontendPort:frontendPort, backendPort:backendPort, loadDistribution:loadDistribution, floatingIP:enableFloatingIP, idleTimeoutInMinutes:idleTimeoutInMinutes}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `loadDistribution` is `SourceIP` or `SourceIPProtocol` on the affected rule. | Session persistence is on. All flows from a client (or client and protocol) hash to the same backend by design. | Perform [Step 2](#step-2) to verify whether session stickiness is actually required. |
| `loadDistribution` is `Default` and `protocol` is `Udp` with `frontendPort` in `67`, `68`, `514`, `162`, or `161` | The rule serves a protocol whose packets use the same tuple. Therefore, the 5-tuple hash degenerates to one bucket. | Perform [Step 4](#step-4). |
| `loadDistribution` is `Default` and `protocol` is `Tcp` or `Udp` on a normal application port. | Hash-based 5-tuple distribution is in effect. Whether distribution is actually skewed must be measured. | Perform [Step 2](#step-2). |
| The rule is missing or `ResourceNotFound`. | Subscription, resource group, or load balancer name is incorrect. | Re-enter your variables, and rerun [Step 1](#step-1). |

Record the rule name as `$RULE_NAME` for later steps.

### Step 2

Check the back-end pool composition and the actual byte distribution per backend over the last hour. This step is what distinguishes *perceived* unevenness from *measured* unevenness. It produces the per-backend signal that later routing decisions depend on.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

LB_ID=$(az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

echo "Backend pool members:"
az network lb address-pool list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{pool:name, backends:loadBalancerBackendAddresses[].{ip:ipAddress, network adapter:networkInterfaceIPConfiguration.id}}" \
  --output json

echo ""
echo "Per-backend network adapter byte rate (last 60 minutes):"
network adapter_IDS=$(az network lb address-pool list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].loadBalancerBackendAddresses[].networkInterfaceIPConfiguration.id" -o tsv \
  | sed -E 's|/ipConfigurations/.*||' | sort -u)

for network adapter in $network adapter_IDS; do
  echo "--- $(basename $network adapter) ---"
  az monitor metrics list \
    --resource "$network adapter" \
    --metrics "BytesReceivedRate" "BytesSentRate" \
    --aggregation Total \
    --interval PT1M \
    --output table
done
```

> [!NOTE]
> Azure Standard Load Balancer's `ByteCount` metric is fed dimensions by `FrontendIPAddress`, `FrontendPort`, `Direction`, and `Protocol` only. It doesn't expose a `BackendIPAddress` dimension. You must read per-backend byte distribution from the `BytesReceivedRate` and `BytesSentRate` values for each backend network adapter (also known as a network interface card, or network adapter).

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `loadBalancerBackendAddresses` has only one entry. | Only one backend exists. Distribution can't be uneven. | Add backend instances, not a load balancing fault. |
| One backend network adapter's `BytesReceivedRate` total accounts for greater than or equal to 80 percent of the sum across all backend network adapters and the others sit near zero. | Distribution is measurably skewed. The cause is either persistence [Step 1](#step-1) or low upstream entropy [Step 3](#step-3). | If [Step 1](#step-1) shows `SourceIP`/`SourceIPProtocol`, perform [Resolution C](#resolution-c). Otherwise, perform [Step 3](#step-3). |
| Backend network adapter `BytesReceivedRate` totals are within roughly the same order of magnitude (no single backend greater than 60 percent of total bytes). | Distribution is within the normal envelope of a 5-tuple hash. The uneven perception is the round-robin expectation. | Perform [Resolution A](#resolution-a). |
| All network adapter metrics return zero or no rows. | The backends have no measured traffic in the interval. Drive traffic and retest, or verify that the network adapters are attached and the rule's probe is reporting `Up`. | Rerun [Step 2](#step-2) during a known traffic window. |

Record the dominant backend network adapter, its percentage share, and whether one or many client source IPs drove the bytes. You need to know the count of distinct source IPs to be able to proceed to [Step 3](#step-3).

### Step 3

Check whether a NAT, firewall, NVA, or reverse proxy fronts the load balancer and collapses many client IPs into a single source IP. A 5-tuple hash on a single source IP plus a single destination IP or port gives, at most, one backend per source port. A stable client often reuses one source port. This situation means that the hash effectively pins to one backend.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

LB_ID=$(az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

echo "Frontend configuration (public vs internal, attached IP):"
az network lb frontend-ip list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, privateIP:privateIPAddress, publicIPId:publicIPAddress.id, subnetId:subnet.id}" \
  --output table

echo ""
echo "Packet count and SYN count on the load balancer (last 60 minutes):"
az monitor metrics list \
  --resource "$LB_ID" \
  --metrics PacketCount SYNCount \
  --aggregation Total \
  --interval PT1M \
  --output table
```

Then, from the network path itself, answer the following questions without changing anything:

- Is the load balancer **internal** (private IP in `privateIPAddress`)? Is it reached through a hub firewall, Azure Firewall, NVA, or third-party proxy? If yes, every client that traverses that hop arrives at the load balancer by using the hop's source IP, not the original client IP.
- Is the load balancer **public** but published through Azure Front Door, a content delivery network (CDN), Application Gateway, or Azure Web Application Firewall (WAF)? If yes, the fronting service is the source IP that the load balancer sees.
- If a fronting Azure Firewall exists, query its `SNATPortUtilization` or source-IP behavior to verify that it's performing source NAT toward this backend.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| A fronting NAT, firewall, NVA, Front Door, or reverse proxy is in the path and [Step 2](#step-2) shows one backend network adapter taking greater than or equal to 80 percent of bytes. | Low source-IP entropy. The hash input is effectively constant, so the 5-tuple hash degenerates. | Perform [Resolution B](#resolution-b). |
| Frontend is reached directly from many distinct client IPs (no fronting NAT or proxy) and [Step 2](#step-2) shows greater than or equal to 80 percent on one backend | Distribution is skewed despite high entropy. Re-check Step 1 for `SourceIP`/`SourceIPProtocol` persistence. If `Default`, this is a measurement. Window or workload-shape problem, not a hashing problem. | Perform [Resolution A](#resolution-a). |
| Frontend is direct AND [Step 2](#step-2) shows roughly even distribution. | No action. The 5-tuple hash is performing as designed. | Perform [Resolution A](#resolution-a) for documentation only. |
| [Step 1](#step-1) already flagged `SourceIP` or `SourceIPProtocol`. | Persistence overrides entropy analysis. | Perform [Resolution C](#resolution-c). |

### Step 4

Check whether the rule serves a protocol whose packets can't be meaningfully spread by a flow hash. DHCP relay (User Datagram Protocol (UDP) 67 or 68), syslog (UDP 514), and SNMP traps (UDP 162) typically have one source per relay agent that sends one destination port. Therefore, the 5-tuple collapses to one bucket no matter what's done at the load balancer level.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?protocol=='Udp'].{name:name, frontendPort:frontendPort, backendPort:backendPort, loadDistribution:loadDistribution, floatingIP:enableFloatingIP}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| A rule with `protocol: Udp` and `frontendPort` of `67`, `68`, `514`, `162`, or `161`. | The protocol is unsuitable for flow-hash load balancing. The load balancer can't meaningfully distribute these packets, regardless of distribution mode. | Perform [Resolution D](#resolution-d). |
| No UDP rule matches those ports, but the rule serves another protocol where all packets use the same 5-tuple (for example, a single Generic Routing Encapsulation (GRE) tunnel). | Protocol unsuitable for hash distribution. | Perform [Resolution D](#resolution-d). |
| All UDP rules serve application ports with many concurrent client tuples. | This step doesn't apply. | Go to the [Decision map](#decision-map). |

---

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| [Step 1](#step-1) shows `loadDistribution` equal to `SourceIP` or `SourceIPProtocol` and session stickiness isn't required. | Perform [Resolution C](#resolution-c). |
| [Step 2](#step-2) shows greater than or equal to 80 percent bytes on one backend and [Step 3](#step-3) confirms a fronting NAT, firewall, NVA, Front Door, or reverse proxy in the path. | Perform [Resolution B](#resolution-b). |
| [Step 2](#step-2) shows roughly even distribution (no backend greater than roughly 60 percent of bytes), but you expected per-request round robin behavior. | Perform [Resolution A](#resolution-a). |
| [Step 4](#step-4) shows a UDP rule on port 67, 68, 514, 162, or 161 (or another single-tuple protocol) | Perform [Resolution D](#resolution-d). |
| All diagnostics pass and distribution still appears uneven. | File an Azure support request, and attach the [Step 2](#step-2) metric output and the [Step 3](#step-3) entropy assessment. |

## Resolution A

You're comparing Load Balancer to a round-robin appliance. Load Balancer is a stateless, flow-based load balancer. It hashes a 5-tuple (source IP, source port, destination IP, destination port, and protocol) per flow to pick a backend, then pins that flow for its lifetime. 

Run the following commands in Azure CLI.

1. Verify that the rule is on `Default` (5-tuple) distribution (the most distribution-friendly mode):

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name:       " RULE_NAME

az network lb rule show \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --query "{name:name, loadDistribution:loadDistribution, protocol:protocol}" \
  --output json
```

If `loadDistribution` is already `Default`, no change is necessary. Go to the next step.

2. If the rule is set to `SourceIP` or `SourceIPProtocol`, but no application-level session stickiness is required, set it to `Default`.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step is a write operation that changes how new flows hash to backends. Existing in-flight flows aren't interrupted.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name:       " RULE_NAME

az network lb rule update \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --load-distribution Default
```

3. Rerun [Step 2](#step-2) after at least 10 minutes of traffic. 

A healthy output is indicated if no single backend network adapter's `BytesReceivedRate` accounts for more than roughly 60 percent of the sum across all backend network adapters over the interval. If a skew remains, and a fronting NAT or proxy is in the path, go to [Resolution B](#resolution-b). If a single client drives most of the load even by having many source ports, the workload itself is concentrated, and additional client-side parallelism (or a Layer-7 load balancer such as Application Gateway) is required for per-request distribution.

## Resolution B

Source IP entropy at the load balancer level is too low for the 5-tuple hash to spread flows. An upstream NAT device (such as Azure Firewall, hub NVA, a third-party firewall, Front Door, or a reverse proxy) collapses many original clients to a single source IP toward the load balancer. With one source IP and one destination IP or port, the hash space is reduced to source-port variation, and stable clients that reuse the same source port pin to one backend.

1. Verify the fronting hop by tracing where requests enter the load balancer:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb frontend-ip list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, privateIP:privateIPAddress, publicIPId:publicIPAddress.id, subnetId:subnet.id}" \
  --output json
```

If the frontend is a private IP, identify the upstream device whose interface targets this virtual network (VNet) or subnet. If the frontend is a public IP, identify any CDN, Front Door, WAF, or NVA in front. Record the device and tenant boundary.

2. Remove the fronting NAT from the hash path. The supported options, in order of preference, are:

- **Bypass source NAT at the fronting device**. Configure the upstream firewall or NVA to forward client traffic to the load balancer by having the original client source IP preserved (without Source Network Address Translation (SNAT)). This action restores per-client hash entropy without changing the application.
- **Move the fronting device behind the load balancer** instead of in front of it, so that client IPs reach the load balancer directly.
- **Switch to Application Gateway** (Layer 7) for the workload. Application Gateway distributes per HTTP request, not per flow. Therefore, a single client connection still spreads requests across backends and isn't subject to 5-tuple collapse.

This last option is the appropriate fix if the upstream NAT must remain in place and the workload is HTTP/S.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. The exact command set to disable SNAT depends on the fronting device. The following commands provisions an Application Gateway as the recommended Layer-7 alternative. This action creates new billable resources and changes your data plane.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$AGW_NAME" ] && read -rp "New App Gateway Name: " AGW_NAME
[ -z "$AGW_VNET" ] && read -rp "VNet for App Gateway: " AGW_VNET
[ -z "$AGW_SUBNET" ] && read -rp "Dedicated subnet for App Gateway: " AGW_SUBNET
[ -z "$AGW_PUBIP" ] && read -rp "Public IP name (Standard SKU): " AGW_PUBIP

az network application-gateway create \
  --name "$AGW_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$AGW_VNET" \
  --subnet "$AGW_SUBNET" \
  --public-ip-address "$AGW_PUBIP" \
  --sku Standard_v2 \
  --priority 100
```

3. Rerun [Step 2](#step-2). 

A healthy output is indicated if the backend network adapter `BytesReceivedRate` is spread across multiple backends, and no single backend network adapter accounts for more than roughly 60 percent of total bytes. If you adopted Application Gateway, traffic toward the original load balancer drops, and the new Application Gateway becomes the metric of interest.

## Resolution C

The rule is configured by having `loadDistribution` set to `SourceIP` (2-tuple is source IP and destination IP) or `SourceIPProtocol` (3-tuple is source IP, destination IP, and protocol). Both modes intentionally pin every flow from a given client (or client and protocol) to one backend. This behavior is correct for stateful workloads that genuinely require client affinity, but it's the primary cause for "one backend hot" complaints when you set the rule by using this value without having that specific requirement.

Run the following commands in Azure CLI:

1. Verify that session persistence is on, and capture the current value before you change it:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name:       " RULE_NAME

az network lb rule show \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --query "{name:name, loadDistribution:loadDistribution, protocol:protocol}" \
  --output json
```

If `loadDistribution` is `SourceIP` or `SourceIPProtocol`, the rule uses source-IP affinity. Before you proceed to the next step, verify that the workload doesn't require backend affinity (for example, no in-memory session state that isn't replicated across backends), and that session stickiness isn't a functional requirement.

2. Switch the rule to `Default` (5-tuple) distribution. 

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This change removes client affinity. Any application that relies on a sticky backend (such as in-memory session or local cache) can break.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name:       " RULE_NAME

az network lb rule update \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --load-distribution Default
```

Existing flows continue to arrive at their current backend until they end. New flows are distributed as hash across all healthy backends.

3. Rerun [Step 2](#step-2) after at least 10 minutes of new traffic. 

A healthy output is indicated if the backend network adapter `BytesReceivedRate` spread across multiple backends. If the workload genuinely needs session stickiness, leave persistence on, and, instead, use Application Gateway by having cookie-based affinity. This configuration gives per-request distribution combined with per-session pinning.

## Resolution D

The rule serves a protocol whose packets use the same 5-tuple. Common examples are DHCP relay (UDP 67 or 68), syslog (UDP 514), and SNMP traps (UDP 162 or 161). The relay agent or device sends one stream from one source IP to one destination IP and port. A flow hash has nothing to vary on. Therefore, all packets fall into one bucket every time, no matter the distribution mode. Load Balancer isn't the right app for this traffic.

Run the following commands in Azure CLI.

1. Identify protocol-specific high availability (HA) options for the affected service, and remove the load balancer from distributing these packets. The following options are common examples:

- **DHCP relay:** Use Windows DHCP Failover or DHCP scope split between two servers. Add each server's network adapter as directly addressable from the DHCP relay agent. Don't front them by using a load balancer for the DHCP traffic itself.
- **Syslog:** Configure the syslog client (rsyslog, syslog-ng, Windows Event Forwarder) to have multiple destinations and either round-robin or with active or standby at the client level. Tools such as `rsyslog` and `omfwd` support multiple targets natively.
- **SNMP traps:** Configure the trap source to send to all collectors in parallel, or use a trap-forwarding daemon (such as `snmptrapd`) for distribution on the receiver side.

2. Remove the unsuitable rule from the load balancer to eliminate the misleading uneven signal and free the front-end port.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This operation removes the load balancing rule. Verify that the protocol-specific HA that was determined previously is in place before you delete the rule. Otherwise, a brief outage occurs for that traffic.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule Name:       " RULE_NAME

az network lb rule delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME"
```

3. Verify that the rule is gone:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb rule list \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, protocol:protocol, frontendPort:frontendPort}" \
  --output table
```

Verify that the protocol traffic now reaches the intended HA targets directly.

## References

- [Azure Load Balancer distribution modes](/azure/load-balancer/distribution-mode-concepts)
- [Configure the distribution mode for Azure Load Balancer](/azure/load-balancer/load-balancer-distribution-mode)
- [Azure Load Balancer metrics and diagnostic logs](/azure/load-balancer/load-balancer-standard-diagnostics)
- [What is Azure Application Gateway?](/azure/application-gateway/overview)
- [Application Gateway cookie-based affinity](/azure/application-gateway/configuration-http-settings#cookie-based-affinity)
- [Azure Load Balancer SKUs](/azure/load-balancer/skus)
