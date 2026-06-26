---
title: Troubleshoot HTTP 502 errors in Azure Application Gateway
description: Use this step-by-step guide to troubleshoot HTTP 502 Bad Gateway errors in Azure Application Gateway, and restore back-end health quickly. Start now.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 6/10/2026
ms.custom: sap:Facing 5xx errors
ai.hint.symptom-tags:
  - 502-error
  - bad-gateway
  - backend-unhealthy
  - backend-pool-empty
  - connection-refused
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/applicationGateways/backendhealth/action
  - Microsoft.Network/applicationGateways/write
  - Microsoft.Network/networkSecurityGroups/read
  - Microsoft.Insights/diagnosticSettings/read
  - Microsoft.Insights/metrics/read
  - Microsoft.Web/sites/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
---

# Troubleshoot HTTP 502 errors in Azure Application Gateway

## Summary

This article provides a structured approach to diagnose and resolve "HTTP 502 bad gateway" errors from Azure Application Gateway.

HTTP 502 bad gateway errors can be divided into five root-cause categories:

- Health probe misconfiguration
- Back-end Transport Layer Security (TLS) certificate chain problems, such as common name (CN) and subject alternative name (SAN) mismatch or missing intermediate certificate authorities (CAs)
- Network or infrastructure blocking, including platform upgrade IP changes
- Back-end errors, such as Domain Name System (DNS) resolution, port, or Server Name Indication (SNI) misconfiguration
- A misconfigured routing rule that sends traffic to the wrong back end

This guide describes each category, provides exact commands, and explains what the output means.

## Symptoms

Common symptoms of HTTP 502 bad gateway errors include:

- Application Gateway returns HTTP 502 responses to clients.
- Back-end health in the [Azure portal](https://portal.azure.com) shows one or more back ends as **Unhealthy** or **Unknown**.
- You see the following portal message: `Backend pool [name] has no healthy servers that can handle the request`.
- Clients report intermittent connection errors that began after a configuration change or deployment.
- New Application Gateway deployment returns "502" errors immediately after provisioning.
- The back end uses HTTPS, and Application Gateway sends the following message: `The Common Name of the leaf certificate presented by the back-end server does not match the Probe or Backend Setting hostname of the application gateway`. 
- TLS handshake failures occur.
- "502" errors start occurring after an Azure platform upgrade without any customer-initiated configuration change.
- The back end uses Azure API Management, and default or misconfigured probe paths return "404" errors from Azure API Management.
- "502" errors occur in a multi-tier topology (for example, Azure Load Balancer errors either in front of or behind Application Gateway in the topology).

## Prerequisites

To troubleshoot "HTTP 502 bad gateway" errors in Application Gateway, you must have the following prerequisite items:

- **Permissions required**: `Network Contributor` role on the Application Gateway resource group, or equivalent (`Microsoft.Network/applicationGateways/read`)
- **Tools**: Azure CLI 2.*x*, Azure PowerShell 9.*x*, or an AI agent that uses Azure MCP
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
| --- | --- | --- |
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are for strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1a

Check whether the application gateway is provisioned and running. A gateway that's in a **Failed** provisioning state or a **Stopped** operational state returns "502" errors for every request, and makes back-end checks misleading. 

To check the gateway's provisioning and operational state, and to identify the SKU tier (v1 versus v2) for later steps, run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, operationalState:operationalState, sku:sku.{name:name,tier:tier}}" \
  --output json
```

> [!IMPORTANT]
> Record your gateway SKU now. The previous query returns a `sku.tier` value. A tier that ends in `_v2` (`Standard_v2` or `WAF_v2`) is a **v2** gateway. Any other tier (`Standard` or `WAF`) is a **v1** gateway. You have to know this value for later steps because the v1 and v2 platforms have different behaviors and diagnostic signals.

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| `provisioningState: Succeeded` and `operationalState: Running`. | The gateway is provisioned and serving traffic. | Perform [Step 1b](#step-1b). |
| `operationalState: Stopped`. | The gateway is stopped and is serving no traffic. | Perform [Resolution G](#resolution-g) to start the gateway. |
| `operationalState: Starting` or `operationalState: Stopping`. | The gateway is in mid-transition. | Wait 1–2 minutes, and then rerun the precheck operation. |
| `provisioningState: Failed`. | The last configuration update failed and left the gateway in a bad state. | Perform [Resolution G](#resolution-g) to recover the gateway. |
| `provisioningState: Updating`. | A configuration change is still applying. | Wait for it to reach `Succeeded`, and then retest. |

### Step 1b

Check whether Application Gateway can successfully reach and probe each back-end server.

Run the following commands in Azure CLI to check the health status of each back-end IP in each back-end pool. Also, run the commands to identify any pools that have no servers configured at all (an empty `servers` array). This situation also causes "502" errors.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show-backend-health \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| All back-end IPs show `"health": "Healthy"`. | The gateway can reach all back ends. | Perform [Step 3](#step-3) to check routing rules. |
| One or more IPs show `"health": "Unhealthy"`. | The gateway can't reach those specific back ends. | Perform [Step 2a](#step-2a) to investigate connectivity. |
| All IPs show `"health": "Unknown"`. | The health probe hasn't run yet. The gateway might be newly deployed. | Wait 2–3 minutes and then rerun [Step 1a](#step-1a). |
| A pool object is present but `backendHttpSettingsCollection[].servers` is empty (`[]`) indicating an empty `servers` array. | The back-end pool exists but has no target servers configured. | Perform [Resolution D](#resolution-d) to configure the back-end pool. |
| `"backendAddressPools": []`, indicating there's no pool object. | No back-end pool is configured on the gateway. | Perform [Resolution D](#resolution-d) to configure the back-end pool. |
| A `ResourceNotFound` error. | The subscription, resource group, or gateway name is incorrect. | Verify your variables and rerun this step. |

### Step 2a

Check which HTTP settings and probe are associated with the unhealthy back end and which port Application Gateway uses for health probes.

Run the following commands in Azure CLI to identify the HTTP settings linked to the unhealthy back-end pool, the probe attached to those HTTP settings, and the port and protocol used for health probes.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{httpSettings:backendHttpSettingsCollection[].{name:name,port:port,protocol:protocol,probeName:probe.id}, pools:backendAddressPools[].{name:name,targets:backendAddresses}}" \
  --output json
```

Record the following values from the output:

- The **port** in `httpSettings`. This port is the one Application Gateway uses for health probes. Name it something like `{BACKEND_PORT}`.
- The **protocol**, either HTTP or HTTPS.
- Whether a **custom probe** is assigned (`probeName` has a value) or the default probe is used.

### Interpret the results

| Observation | Next steps |
| --- | --- |
| `probeName` is null (no custom probe). | The default probe is used. The probe path is `/` and the expected response is any `2xx` or `3xx` value. Perform [Step 2b](#step-2b). |
| `probeName` references a custom probe. | A custom probe path and match condition is configured. Perform [Step 2c](#step-2c). |

### Step 2b

Check whether the back-end application returns a healthy HTTP response on the path `/` for the configured port and protocol.

Run the following commands in Azure CLI to verify the default probe configuration and understand what response it expects from the back end.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway probe list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

If no probes are listed, the default probe is active. The default probe performs the following actions:

- Sends an HTTP GET request to `/` on the port and protocol in the HTTP settings.
- Considers any HTTP 200–399 response to be healthy.

If the back end returns `4xx`, `5xx`, or times out, Application Gateway marks it **Unhealthy**.

| Observation | Next steps |
| --- | --- |
| Back-end application returns `4xx` on `/` (for example, the app returns a "404" error on the root path). | To configure a custom probe that has the correct path, perform [Resolution B](#resolution-b). |
| The back-end port isn't listening (the connection is refused). | To fix back-end connectivity, perform [Resolution A](#resolution-a). |
| The back end returns `2xx`, but the gateway shows **Unhealthy**, and your previously determined `sku.tier` value doesn't end in `_v2` (indicating a v1 gateway, either `Standard` or `WAF`). | To unblock the network security group (NSG) or firewall that's blocking the Application Gateway management subnet (*v1 SKU only*), perform [Resolution C](#resolution-c). |
| The back end returns `2xx`, but the gateway shows **Unhealthy**, and your previously determined `sku.tier` value ends in `_v2` (`Standard_v2` or `WAF_v2`). | To identify the "502" error from access logs, keep diagnosing the probe path or host. Perform [Step 6a](#step-6a). |

### Step 2c

Check the specific path, timeout, and match conditions on the custom probe that are assigned to the unhealthy back end.

To inspect the custom probe configuration, including the path it probes, the expected healthy response codes, and the timeout value, run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$PROBE_NAME" ] && read -rp "Probe Name:        " PROBE_NAME

az network application-gateway probe show \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$PROBE_NAME" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| The `"path"` value doesn't match an existing route in your app. | The back end returns a "404" error. The probe treats this situation as `unhealthy`. | To update the probe path, perform [Resolution B](#resolution-b). |
| `"match": {"statusCodes": ["200-399"]}` but the back end returns a redirect value of either `301` or `302` to HTTPS. | The probe uses the `301` value, but HTTPS might not be configured. | To add `301` to match codes, or switch the probe to HTTPS, perform [Resolution B](#resolution-b). |
| The probe `path` value looks valid. The only symptom is that the back end is marked as **Unhealthy on a timeout**. | You can't tell from the probe configuration alone whether the back end is *unreachable* (blocked or not listening) or merely *slow*. A low `"timeout"` value isn't an indication of a slow back end because a blocked connection can also time out. Increasing the timeout only helps a back end that's reachable but slow. Therefore, you must verify reachability first. | Perform [Step 2c-1](#step-2c-1) to verify reachability before you change anything. |
| The back end uses HTTPS (the probe `protocol` value is `Https`.) | TLS validation, not connectivity, might be the problem. | Perform [Step 2d](#step-2d). |

### Step 2c-1

Check whether the network path from the Application Gateway subnet to the back end on the probe port is actually open. This check separates a *blocked* connection ([Resolution A](#resolution-a)) from a *reachable-but-slow* back end ([Resolution B](#resolution-b)). Run this check before you change the probe timeout. An increase in the timeout value doesn't fix a blocked path, and a low timeout value on its own is indeterminate.

1. Run Azure CLI to capture the Application Gateway subnet Classless Inter-Domain Routing (CIDR) (this value is the same value that [Resolution A](#resolution-a) uses).

   **Azure CLI (read-only)**

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   SUBNET_ID=$(az network application-gateway show \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "gatewayIPConfigurations[0].subnet.id" \
     --output tsv)
   
   az network vnet subnet show \
     --ids "$SUBNET_ID" \
     --query "addressPrefix" \
     --output tsv
   ```

1. Record the returned CIDR value, and name it something like `{APPGW_SUBNET_CIDR}`. 

1. Run Azure CLI to list any `Deny` rules that block the subnet from reaching the back end on the probe port (the port that's shown in [Step 2a](#step-2a)).

   **Azure CLI (read-only)**

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   
   az network nsg list \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "[].{NSG:name, Rules:securityRules[?access=='Deny'].{Name:name, Priority:priority, Direction:direction, DestPort:destinationPortRange, Source:sourceAddressPrefix}}" \
     --output json
   ```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| A `Deny` rule whose `Source` covers the Application Gateway subnet CIDR and whose `DestPort` includes the probe port. | Because the probe is blocked at the network layer, the back end never receives it. An increase in the timeout limit doesn't help. | To fix back-end connectivity, perform [Resolution A](#resolution-a). |
| No `Deny` rule blocks the gateway subnet on the probe port, and you verify that this back-end app is slow to start (for example, a heavyweight runtime warm-up). | The path is open, and the back end is genuinely slow to answer in time. | To increase the probe timeout limit, perform [Resolution B](#resolution-b). |
| No `Deny` rule blocks the gateway subnet on the probe port, and you have no evidence that the app is slow. | The path looks open, but the back end still isn't answering the probe healthily. This condition usually indicates that the back end isn't listening on the probe port, or that a host-level firewall, and not a timeout problem, is blocking it. | To fix back-end connectivity, perform [Resolution A](#resolution-a). |

 > [!NOTE]
> A probe timeout that has a low `timeout` value looks identical whether the back end is slow or completely blocked. An increase in the timeout for a blocked back end wastes a change cycle and doesn't fix the "502" error.

### Step 2d

Check whether the back end's TLS certificate chain is valid, complete, and matches the hostname that Application Gateway uses in health probes. 

To check the HTTP settings protocol, hostname, and trusted root certificate configuration for TLS validation, run the following commands in Azure CLI.

> [!NOTE]
> This step applies only if the HTTP settings protocol is "HTTPS."

1. Verify HTTP protocol and hostname settings:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway http-settings list \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "[].{name:name, protocol:protocol, port:port, hostName:hostName, pickHostNameFromBackendAddress:pickHostNameFromBackendAddress}" \
     --output table
   ```

1. Check the trusted root certificates:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway root-cert list \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --output table
   ```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| The value is `protocol: Http` for all HTTP settings. | The back end uses HTTP. TLS issues don't apply. | To check network connectivity, perform [Resolution A](#resolution-a). |
| The value is `protocol: Https`, and back-end certificate CN and SAN values match the probe hostname. | TLS configuration is likely correct. | Perform [Resolution A](#resolution-a) to check network connectivity. |
| The value is `protocol: Https`, but the probe hostname doesn't match the back-end certificate CN and SAN values. | A CN or SAN mismatch exists, and probes fail TLS validation. | Perform [Resolution F](#resolution-f). |
| The value is `protocol: Https`, and no trusted root certificates are configured for a private CA back end. | Application Gateway can't validate the back-end certificate chain. | Perform [Resolution F](#resolution-f). |
| The back-end health probe log shows either **"The Common Name of the leaf certificate presented by the backend server does not match the Probe or backend Setting hostname of the application gateway."** or **"The leaf certificate is missing from the certificate chain presented by the backend server."** | A back-end-certificate trust or hostname problem exists. The exact wording is dependent on the back-end chain. | Perform [Resolution F](#resolution-f). |
| The back-end health probe log shows other TLS handshake failures or certificate errors. | The certificate chain is incomplete, or intermediate CAs are missing. | Perform [Resolution F](#resolution-f). |

### Step 3

Check whether request routing rules correctly map the listener to the correct back-end pool. 

> [!NOTE]
> This step is necessary only if [Step 1a](#step-1a) shows all back ends to be healthy, but "502" errors persist.

To list the routing rules and their associated listeners, back-end pools, and HTTP settings, run the following command in Azure CLI: 

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway rule list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway listener list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

| Observation | Meaning | Next steps |
| --- | --- | --- |
| The listener isn't bound to the correct port (for example, the listener is on port 80, but the client connects on port 443). | A listener port mismatch exists. | To fix the listener configuration, perform [Resolution E](#resolution-e). |
| The rule type is `PathBasedRouting`, but no URL path map is configured for the requested URL. | Unmatched paths route to a default back end that might not exist. | Perform [Resolution E](#resolution-e). |
| All rules and listeners look correct. | Routing configuration isn't the issue. | To check capacity, perform [Step 4](#step-4). |

### Step 4

Check whether the gateway returns "502" errors because it reaches its capacity or autoscale ceiling. When every instance is saturated, Application Gateway can shed requests that have "502" errors even though all back ends are healthy. Check this condition if [Step 1a](#step-1a) and [Step 1b](#step-1b) show no errors but "502" errors persist, especially if they correlate with traffic spikes.

To check the `CapacityUnits` metric for signs of saturation during the "502" error window, and to read the configured autoscale ceiling for comparison, run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

APPGW_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME"

az monitor metrics list \
  --resource "$APPGW_ID" \
  --metrics CapacityUnits FailedRequests UnhealthyHostCount \
  --aggregation Maximum Average \
  --interval PT5M \
  --offset 1h \
  --output table
```

Use these results to compare against the following commands that show the gateway's SKU capacity or autoscale ceiling (also run this check in Azure CLI):

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{sku:sku, autoscale:autoscaleConfiguration}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| The `CapacityUnits` value maximum is at or near `autoscaleConfiguration.maxCapacity` during the "502" error window. | Autoscale reaches its ceiling, and the gateway is saturated. | To raise the capacity ceiling, perform [Resolution H](#resolution-h). |
| A fixed capacity (v1, or manual `sku.capacity`) and `CapacityUnits` that are pinned near the instance limit. | The gateway has no headroom to absorb the load. | To increase the instance count, perform [Resolution H](#resolution-h). |
| The `UnhealthyHostCount` value is greater than 0 during the "502" error window. | The back ends are unhealthy. This is not a capacity-related problem. | Perform [Step 1b](#step-1b). |
| The `CapacityUnits` value is below the ceiling during "502" errors. | Capacity isn't the bottleneck. | Perform [Step 5](#step-5) if the back end is Azure App Service. Otherwise, perform [Step 6a](#step-6a). |

### Step 5

Check whether a "502" error from an Azure App Service back end is caused by a `Host` header or SNI mismatch, or by App Service access restrictions.

App Service is multitenant. It routes by the `Host` header and rejects requests whose host doesn't match a configured hostname. This mismatch is revealed as a "502" error in Application Gateway.

> [!NOTE]
> Run this check only if your back-end pool target is an App Service (either an `*.azurewebsites.net` address or a custom domain fronting one).

> [!IMPORTANT]
> **Perform [Resolution I](#resolution-i) only if the probe is healthy but client requests still have "502" errors.** [Resolution I](#resolution-i) applies if [Step 1b](#step-1b) shows this App Service back end as **Healthy** (the probe is reaching App Service by using a host that it accepts) but clients still receive "502" errors. This condition occurs because the routing rule's data-path HTTP setting sends an empty or unrecognized `Host`.
> If [Step 1b](#step-1b) shows this App Service back end as **Unhealthy**, the host or certificate break is affecting the probe. The probe is initially failing TLS CN validation. **Don't** continue here. Go to [Step 2d](#step-2d), and then perform [Resolution F](#resolution-f). The following diagnostic reveals the signal that separates the two cases.

### Verify probe health versus the data-path host

Check the routing rule's data-path HTTP setting (the `Host` sent on real client requests) next to the probe's own host configuration (the healthy host that's used in [Step 1b](#step-1b)). Run this check so that you can tell whether only the data path is broken (perform [Resolution I](#resolution-i)) or the probe is also broken (perform [Resolution F](#resolution-f)).

Run the following commands in Azure CLI to list the routing rules with their back-end HTTP settings and attached probes. Then, check the host-header configuration on the HTTP settings.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{routingRules:requestRoutingRules[].{rule:name, dataPathHttpSettings:backendHttpSettings.id, pool:backendAddressPool.id}, httpSettings:backendHttpSettingsCollection[].{name:name, dataPathHostName:hostName, pickHostNameFromBackendAddress:pickHostNameFromBackendAddress, probe:probe.id}, probes:probes[].{name:name, probeHost:host, pickHostNameFromBackendHttpSettings:pickHostNameFromBackendHttpSettings}}" \
  --output json
```

To correlate the probe health with the host header configuration, compare this output with the information from [Step 1a](#step-1a) and [Step 1b](#step-1b). 

- **Probe health (from [Step 1b](#step-1b))** — Is this App Service back end `Healthy`? If so, the probe is sending a host that App Service accepts (its certificate is `*.azurewebsites.net`).
- **Data-path host** — Find the `backendHttpSettings` that your `routingRules` entry points to. Then, note the `pickHostNameFromBackendAddress` and `dataPathHostName` (`hostName`) values of that HTTP setting. This value is the `Host` that's sent on real client requests.
- **Probe host** — The `probes` entry that's attached to that HTTP setting (`probeHost` / `pickHostNameFromBackendHttpSettings`). This value is the host that made the probe healthy.

If the probe is healthy but the data-path HTTP setting has `pickHostNameFromBackendAddress: false` and an empty `dataPathHostName`, the probe and the data path are sending different hosts. The probe's value is accepted but the data path's isn't. That gap is the App Service host-header mismatch. It's what distinguishes [Resolution I](#resolution-i) from [Resolution F](#resolution-f).

1. To check the host-header configuration on the HTTP settings, run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway http-settings list \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "[].{name:name, hostName:hostName, pickHostNameFromBackendAddress:pickHostNameFromBackendAddress}" \
     --output table
   ```

1. Verify the App Service hostnames and access restrictions:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
   [ -z "$WEBAPP_RG" ] && read -rp "App Service Resource Group: " WEBAPP_RG
   [ -z "$WEBAPP_NAME" ] && read -rp "App Service Name:        " WEBAPP_NAME
   
   az webapp config hostname list \
     --webapp-name "$WEBAPP_NAME" \
     --resource-group "$WEBAPP_RG" \
     --subscription "$SUBSCRIPTION" \
     --output table
   
   az webapp config access-restriction show \
     --name "$WEBAPP_NAME" \
     --resource-group "$WEBAPP_RG" \
     --subscription "$SUBSCRIPTION" \
     --output json
   ```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| [Step 1b](#step-1b) shows this App Service backend as **Unhealthy**. | The host or certificate is also failing the probe (such as a TLS CN mismatch). This is a host issue only, and not related to data paths. | Perform [Step 2d](#step-2d) and then [Resolution F](#resolution-f). |
| [Step 1b](#step-1b) shows as **Healthy** (the probe is green), the rule's data-path HTTP setting has a value of `pickHostNameFromBackendAddress: false`, and the `dataPathHostName` (`hostName`) value is empty. | The probe can reach App Service, but client requests carry the gateway's own front-end host, which App Service rejects as a "502" error. | Perform [Resolution I](#resolution-i) to set the back-end host header. |
| [Step 1b](#step-1b) shows as **Healthy** (the probe is green) and the rule's data-path HTTP setting `hostName` is set but doesn't match any entry from `az webapp config hostname list`. | The data-path host header doesn't map to a bound App Service hostname. | To align the host header, perform [Resolution I](#resolution-i). |
| [Step 1b](#step-1b) shows as **Healthy** (the probe is green) **and** access restrictions list a default `Deny` action that doesn't allow the Application Gateway subnet or public IP. | App Service is blocking the gateway before it reaches the app | To allow the gateway in access restrictions, perform [Resolution I](#resolution-i). |
| [Step 1b](#step-1b) shows as **Healthy** (the probe is green), the data-path value is `pickHostNameFromBackendAddress: true`, and there are no blocking access restrictions. | The host header and access restrictions look correct. | To inspect access logs, perform [Step 6a](#step-6a). |

### Step 6a

Check the exact "502" fingerprint from the gateway's own access logs. This check helps determine whether the gateway rejected the request instantly (`serverResponseLatency` is 0), the back end timed out (latency is the configured timeout), or the "502" error was generated by the gateway (`httpStatus`) or returned by the back end (`serverStatus`). This step requires diagnostic logging to a Log Analytics workspace.

> [!NOTE]
> This step uses the `log-analytics` Azure CLI extension (installed automatically on first use). It's read-only.

Run the following command in Azure CLI to check whether access logging is configured.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

APPGW_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME"

# Find any diagnostic setting that ships logs to a Log Analytics workspace.
WORKSPACE_RESOURCE_ID=$(az monitor diagnostic-settings list \
  --resource "$APPGW_ID" \
  --query "value[?workspaceId!=null].workspaceId | [0]" \
  --output tsv)

if [ -z "$WORKSPACE_RESOURCE_ID" ] || [ "$WORKSPACE_RESOURCE_ID" = "None" ]; then
  echo "SKIP: No Log Analytics diagnostic setting is configured on this Application Gateway."
  echo "      Access-log triage is unavailable. Continue with the Decision map using the"
  echo "      results from the Precheck and Steps 1-5."
else
  echo "OK: Access logs flow to workspace:"
  echo "    $WORKSPACE_RESOURCE_ID"
  echo "    Proceed to Step 6b."
fi
```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| `SKIP: No Log Analytics diagnostic setting...` | Access logs aren't being collected. There's no historical data to query. | Skip to the [Decision map](#decision-map) because this step is optional. |
| `OK: Access logs flow to workspace...` | A workspace is configured and queryable. | Perform [Step 6b](#step-6b). |

### Step 6b

To query the "502" fingerprint, run these commands in Azure CLI.

> [!NOTE]
> Run this step only if [Step 6a](#step-6a) reports `OK: Access logs flow to workspace...`.

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

APPGW_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME"

# Resolve the workspace GUID (customerId) the query needs.
WORKSPACE_RESOURCE_ID=$(az monitor diagnostic-settings list \
  --resource "$APPGW_ID" \
  --query "value[?workspaceId!=null].workspaceId | [0]" \
  --output tsv)
WORKSPACE_GUID=$(az monitor log-analytics workspace show \
  --ids "$WORKSPACE_RESOURCE_ID" \
  --query "customerId" \
  --output tsv)

az monitor log-analytics query \
  --workspace "$WORKSPACE_GUID" \
  --analytics-query "AGWAccessLogs | where TimeGenerated > ago(1h) | where httpStatus_d == 502 | summarize count() by serverStatus_s, bin(serverResponseLatency_d, 1) | order by count_ desc" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
| --- | --- | --- |
| "502" error rows that have `serverResponseLatency` and show a value of 0 and no `serverStatus`. | The gateway rejected the request before it reached a back end (no healthy host exists). | Perform [Step 1a](#step-1a), and then perform [Resolution A](#resolution-a). |
| "502" error rows that have `serverResponseLatency` with the value of the configured timeout. | The back end accepted the connection but didn't respond in time. | To determine the probe, timeout, or back-end performance, perform [Step 2c](#step-2c). |
| "502" error rows in which the `serverStatus` value is a back end `5xx`. | The back end itself returned the error code, and the gateway relayed it. | Investigate the back-end application. |
| The `AGWAccessLogs` table isn't found. | The logs might be stored in the legacy `AzureDiagnostics` table instead. | Rerun [Step 6b](#step-6b), but replace `AGWAccessLogs` with `AzureDiagnostics \| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"`. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
| --- | --- |
| One or more back ends are **Unhealthy**, and the connection is refused. | Perform [Resolution A](#resolution-a). |
| One or more back ends are **Unhealthy**, and the back end returns a "404" error on the probe path. | Perform [Resolution B](#resolution-b). |
| Back end is API Management, and the probe path isn't set to a value such as `/status-0123456789abcdef`. | Perform [Resolution B](#resolution-b). |
| The HTTPS back end has a certificate CN or SAN mismatch or missing intermediate CAs. | Perform [Resolution F](#resolution-f). |
| All back ends are **Unhealthy**, and NSG blocks the management range. | Perform [Resolution C](#resolution-c). |
| "502" errors began after platform upgrade, and the NSG or firewall uses instance IPs. | Perform [Resolution A](#resolution-a). |
| The back-end pool is empty, or no targets are configured. | Perform [Resolution D](#resolution-d). |
| The listener or routing rule is misconfigured. | Perform [Resolution E](#resolution-e). |
| The gateway is stopped or in a failed provisioning state. | Perform [Resolution G](#resolution-g). |
| `CapacityUnits` is saturated at the autoscale or instance ceiling. | Perform [Resolution H](#resolution-h). |
| The App Service back end has a host-header mismatch or access restrictions. | Perform [Resolution I](#resolution-i). |
| All diagnostics pass, but "502" errors are still occurring. | File an Azure support request. |

## Resolution A

**Problem**: Application Gateway can't establish a TCP connection to the back end on the configured port.

**Causes**

- The NSG on the back-end subnet blocks inbound traffic from the Application Gateway subnet.
- The firewall on the back-end virtual machine (VM) blocks the port.
- The back-end application isn't running or isn't listening on the expected port.

1. To check the Application Gateway subnet CIDR and any NSG rules that block it on the back-end port, run the following commands in Azure CLI.

   **Azure CLI (read-only)**

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway show \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "gatewayIPConfigurations[0].subnet.id" \
     --output tsv
   ```

   Record the subnet ID that's returned. The CIDR of this subnet is the Application Gateway subnet range.

   ```azurecli-interactive
   read -rp "Subnet ID (from above): " SUBNET_ID
   
   az network vnet subnet show \
     --ids "$SUBNET_ID" \
     --query "addressPrefix" \
     --output tsv
   ```

1. To list any `Deny` rules that block the subnet from reaching the back end on the probe port (the port that's shown in [Step 2a](#step-2a)), run the following command in Azure CLI.

   **Azure CLI (read-only)**

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   
   az network nsg list \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --query "[].{NSG:name, Rules:securityRules[?access=='Deny'].{Name:name, Priority:priority, Direction:direction, DestPort:destinationPortRange, Source:sourceAddressPrefix}}" \
     --output json
   ```

   Review for any `Deny` rules that block inbound traffic from the Application Gateway subnet CIDR to the back end on the back-end port.

   If you find such a rule, record its `name` and `priority`. You use both in the next step, in which the priority number determines whether your `Allow` rule can take precedence (in this case, a lower priority number takes precedence over a higher one).

   ```azurecli-interactive
   [ -z "$NSG_NAME" ] && read -rp "NSG Name (the one with the blocking Deny rule): " NSG_NAME
   [ -z "$DENY_RULE_NAME" ] && read -rp "Blocking Deny rule NAME (from above):          " DENY_RULE_NAME
   [ -z "$DENY_RULE_PRIORITY" ] && read -rp "Blocking Deny rule PRIORITY (from above):      " DENY_RULE_PRIORITY
   ```

1. To allow the Application Gateway subnet to reach the back end on the probe port, perform one of the following methods.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. 

   An `Allow` rule clears the fault only if it has a lower priority number than the blocking `Deny` rule that's found in the previous step (the lower the number, the higher the precedence). Simply adding an `Allow` rule at a higher number than the `Deny` rule leaves the `Deny` rule in control, and the "502" errors persist.

   Use one of the two following methods.

   **Method 1: Remove or deprioritize the blocking `Deny` rule**

   If the `Deny` rule from step 2 isn't intentional, run the following commands in Azure CLI to delete it:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$NSG_NAME" ] && read -rp "NSG Name:          " NSG_NAME
   [ -z "$DENY_RULE_NAME" ] && read -rp "Blocking Deny rule name (from A.2): " DENY_RULE_NAME
   
   az network nsg rule delete \
     --nsg-name "$NSG_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$DENY_RULE_NAME"
   ```

   If the `Deny` rule must stay but can't take priority over an `Allow` rule, raise its priority number (to lower its precedence) so that the `Allow` rule can take priority.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$NSG_NAME" ] && read -rp "NSG Name:          " NSG_NAME
   [ -z "$DENY_RULE_NAME" ] && read -rp "Blocking Deny rule name (from A.2): " DENY_RULE_NAME
   [ -z "$DENY_NEW_PRIORITY" ] && read -rp "New (higher) priority number for the Deny rule: " DENY_NEW_PRIORITY
   
   az network nsg rule update \
     --nsg-name "$NSG_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$DENY_RULE_NAME" \
     --priority "$DENY_NEW_PRIORITY"
   ```

   **Method 2: Add an `Allow` rule that has a lower priority number than the `Deny` rule**

   Create an `Allow` rule that has a priority that's numerically lower than the blocking `Deny` rule's priority that's noted in step 2. The number must also be unique among existing `Inbound` rules in this NSG. To avoid a `SecurityRuleConflict`, make sure that you use an available value that's less than the `$DENY_RULE_PRIORITY` value.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$NSG_NAME" ] && read -rp "NSG Name:          " NSG_NAME
   [ -z "$APPGW_SUBNET_CIDR" ] && read -rp "App Gateway Subnet CIDR (from A.1): " APPGW_SUBNET_CIDR
   [ -z "$BACKEND_PORT" ] && read -rp "Backend Port:      " BACKEND_PORT
   [ -z "$RULE_PRIORITY" ] && read -rp "Allow rule priority (MUST be lower than the Deny priority from A.2, and unique): " RULE_PRIORITY
   
   az network nsg rule create \
     --nsg-name "$NSG_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name Allow-AppGW-To-Backend \
     --priority "$RULE_PRIORITY" \
     --direction Inbound \
     --source-address-prefix "$APPGW_SUBNET_CIDR" \
     --destination-port-range "$BACKEND_PORT" \
     --protocol Tcp \
     --access Allow
   ```

1. Perform [Step 1b](#step-1b) again (as shown in the following commands). Back-end IPs should return `"health": "Healthy"` within one to two probe intervals.

   > [!NOTE]
   > If "502" errors were returned after an Azure platform upgrade with no customer-initiated change, the Application Gateway instance IPs likely changed. NSG or firewall rules that reference specific instance IPs instead of the Application Gateway subnet CIDR will break. To fix this problem, replace instance IP addresses in NSG or firewall rules with the Application Gateway subnet CIDR (the subnet range from step 1). Also, enable **connection draining** to reduce the effect during future platform upgrades.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --connection-draining-enabled true \
     --connection-draining-timeout 60
   ```

## Resolution B

**Problem**: The health probe checks a path that returns a result that the gateway considers as unhealthy (wrong path, wrong expected status code, or too short of a timeout).

1. Create a custom health probe that checks a path that your application returns either `2xx` or `3xx` for by using an explicit host so that the probe targets the correct back end.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$PROBE_NAME" ] && read -rp "Probe Name:        " PROBE_NAME
   [ -z "$PROBE_HOST" ] && read -rp "Backend Host (FQDN or IP the probe should send): " PROBE_HOST
   
   az network application-gateway probe create \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$PROBE_NAME" \
     --protocol Http \
     --host "$PROBE_HOST" \
     --path /health \
     --interval 30 \
     --timeout 30 \
     --threshold 3 \
     --match-status-codes "200-399"
   ```

   > [!NOTE]
   > The probe host must resolve to the back end that you're checking. Setting an explicit `--host` prevents the `ApplicationGatewayBackendHttpSettingsIncompatibleProbeSettingPickHostName` error that you encounter when the probe picks the host name from HTTP settings that don't define either a `hostName` or `pickHostNameFromBackendAddress=true`.

   > [!NOTE]
   > Adjust `--path` to a path in your application that returns a `2xx` or `3xx` response if the app is healthy (for example, `/healthz`, `/ping`, or `/status`).

1. Attach the new probe to the back-end HTTP settings so that the gateway uses it for health checks.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   [ -z "$PROBE_NAME" ] && read -rp "Probe Name:        " PROBE_NAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --probe "$PROBE_NAME"
   ```

1. Perform [Step 1b](#step-1b) again (seen in the following commands). Back-end IPs should return `"health": "Healthy"` within one to two probe intervals.

   > [!NOTE]
   > If the back-end is Azure API Management, the default and most custom probe paths generate "404" errors. Use probe path `/status-0123456789abcdef`, and set the probe hostname to the API Management gateway fully qualified domain name (FQDN) (for example, `myapim.azure-api.net`). This is the only API Management endpoint that returns a valid health response without requiring an API subscription key.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does. 

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$APIM_GATEWAY_FQDN" ] && read -rp "APIM Gateway FQDN: " APIM_GATEWAY_FQDN
   
   az network application-gateway probe create \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name apim-health-probe \
     --protocol Https \
     --host "$APIM_GATEWAY_FQDN" \
     --path /status-0123456789abcdef \
     --interval 30 \
     --timeout 30 \
     --threshold 3 \
     --match-status-codes "200-399"
   ```

## Resolution C

**Problem**: The NSG on the Application Gateway's own subnet blocks inbound traffic on ports 65503–65534 (v1) or 65200–65535 (v2). The Azure platform requires these ports for Application Gateway management traffic.

> [!NOTE]
> This scenario applies to v1 SKU gateways. On **Standard_v2** or **WAF_v2** gateways, the platform actively prevents this misconfiguration. Azure rejects any NSG rule that blocks GatewayManager inbound on the gateway subnet with `ApplicationGatewaySubnetInboundTrafficBlockedByNetworkSecurityGroup` and a message that resembles the following message: "Not permitted for Application Gateways that have V2 Sku." A v2 reader that observes "backend 2xx but Unhealthy" isn't in this scenario. GatewayManager access is guaranteed on v2. Return to [Step 2b](#step-2b), and continue to diagnose the probe path and host (for example, see [Step 6a](#step-6a)).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does. 

Add an inbound NSG rule that allows the Application Gateway management traffic (GatewayManager service tag on ports 65200–65535) that the platform requires. Choose a priority that is unique among the existing `Inbound` rules in the Application Gateway NSG. List the current rules first to find a free priority number by running `az network nsg rule list --nsg-name "$APPGW_NSG_NAME" --resource-group "$RG" --query "[?direction=='Inbound'].{Name:name,Priority:priority}" --output table`. Reuse an existing priority to get a return of `SecurityRuleConflict`.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$APPGW_NSG_NAME" ] && read -rp "App Gateway NSG Name: " APPGW_NSG_NAME
[ -z "$MGMT_RULE_PRIORITY" ] && read -rp "Rule priority (unique among Inbound rules, e.g. 100): " MGMT_RULE_PRIORITY

az network nsg rule create \
  --nsg-name "$APPGW_NSG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-AppGW-Management \
  --priority "$MGMT_RULE_PRIORITY" \
  --direction Inbound \
  --source-address-prefix GatewayManager \
  --destination-port-range "65200-65535" \
  --protocol Tcp \
  --access Allow
```

For more information, see [Azure Application Gateway infrastructure configuration requirements](/azure/application-gateway/configuration-infrastructure).

## Resolution D

**Problem**: The back-end pool has no target addresses configured.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

Populate the back-end pool by using the target back-end IP or FQDN.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name:  " BACKEND_POOL_NAME
read -rp "Backend IP or FQDN: " BACKEND_IP_OR_FQDN

az network application-gateway address-pool update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_POOL_NAME" \
  --servers "$BACKEND_IP_OR_FQDN"
```

## Resolution E

**Problem**: The listener is bound to the wrong port, or a path-based routing rule has no entry for the requested URL path.

For listener port issues, update the listener to the correct front-end port.

> [!NOTE]
> Port 443 isn't valid while the listener is bound to this front-end port and has a protocol value of `Http`. The control plane rejects this value and returns an `ApplicationGatewayPortNotValidForProtocol` error message. If you're migrating this listener to HTTPS, update the listener protocol to `Https`, and bind an SSL certificate. The port 443 change is accepted. The following example uses port 8080 — a valid port for an HTTP listener.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:     " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:      " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:    " RESOURCE_NAME
[ -z "$FRONTEND_PORT_NAME" ] && read -rp "Frontend Port Name:  " FRONTEND_PORT_NAME

az network application-gateway frontend-port update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$FRONTEND_PORT_NAME" \
  --port 8080
```

## Resolution F

**Problem**: Application Gateway can't validate the back end server's TLS certificate. This problem occurs if:

- The certificate CN or SAN doesn't match the hostname that Application Gateway sends in the health probe.
- Intermediate CA certificates are missing from the back end's certificate chain.
- The back end uses a private CA, and you didn't upload a trusted root certificate to Application Gateway.

1. Determine the hostname that Application Gateway sends in probe requests:

   - If `pickHostNameFromBackendAddress: true`, the probe hostname is the back-end IP or FQDN from the back-end pool.
   - If `hostName` is set in HTTP settings, the probe hostname is that static value.
   - If a custom probe has `host` set, the probe hostname is the custom probe's host value.

   Compare this hostname to the CN and SAN entries on the back-end certificate.

   Run the following command in Azure CLI:

   ```azurecli-interactive
   # Run from any host that can reach the back end (or from Cloud Shell)
   [ -z "$BACKEND_HOST" ] && read -rp "Backend Host (IP or FQDN): " BACKEND_HOST
   [ -z "$BACKEND_PORT" ] && read -rp "Backend Port: " BACKEND_PORT
   [ -z "$PROBE_HOSTNAME" ] && read -rp "Probe Hostname (from HTTP settings): " PROBE_HOSTNAME
   
   openssl s_client -connect "$BACKEND_HOST:$BACKEND_PORT" -servername "$PROBE_HOSTNAME" </dev/null 2>/dev/null | \
     openssl x509 -noout -subject -ext subjectAltName
   ```

   | Observation | Meaning | Next steps |
   | --- | --- | --- |
   | CN or SAN matches the probe hostname. | The hostname matches. | Go to the next step, and check the intermediate chain. |
   | CN and SAN don't include the probe hostname | A CN or SAN mismatch causes probe failure. | Align the probe hostname with the certificate (update HTTP settings `hostName` or probe `host`), or reissue the back-end certificate to include the correct SAN. |

1. Check for missing intermediate CA certificates in the back end's TLS chain.

   Run the following command in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$BACKEND_HOST" ] && read -rp "Backend Host (IP or FQDN): " BACKEND_HOST
   [ -z "$BACKEND_PORT" ] && read -rp "Backend Port: " BACKEND_PORT
   [ -z "$PROBE_HOSTNAME" ] && read -rp "Probe Hostname (from HTTP settings): " PROBE_HOSTNAME
   
   openssl s_client -connect "$BACKEND_HOST:$BACKEND_PORT" -servername "$PROBE_HOSTNAME" </dev/null 2>/dev/null
   ```

   Look for `verify error:num=21:unable to verify the first certificate` in the output. This error message indicates that the back end isn't sending intermediate CA certificates.

   **To fix on the back end server**: Concatenate the leaf certificate and all intermediate CA certificates into a single Personal Exchange Format (PFX) or Privacy Enhanced Mail (PEM) file. Then, reconfigure the back end's TLS binding by using the full chain.

1. If the back end uses a private CA, upload the root CA certificate to Application Gateway.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:     " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
   [ -z "$ROOT_CERT_NAME" ] && read -rp "Root Cert Name:     " ROOT_CERT_NAME
   read -rp "Path to Root CA .cer file: " PATH_TO_ROOT_CA_CER
   
   az network application-gateway root-cert create \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$ROOT_CERT_NAME" \
     --cert-file "$PATH_TO_ROOT_CA_CER"
   ```

   Then, associate the trusted root cert with the HTTP settings.

   > [!NOTE]
   > The back-end HTTP settings must include `protocol=Https` before you can associate a trusted root certificate. An association of a root certificate with an `Http` http-settings fail and generates an `ApplicationGatewayBackendHttpSettingsCannotHaveTrustedRootCertificate` error message. If this setting is currently `Http`, update it before you proceed.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:     " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --protocol Https \
     --port 443
   ```

   Associate the uploaded root certificate with the back-end HTTP settings.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:     " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   [ -z "$ROOT_CERT_NAME" ] && read -rp "Root Cert Name:     " ROOT_CERT_NAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --root-certs "$ROOT_CERT_NAME"
   ```

1. Perform [Step 1b](#step-1b) and [Step 2d](#step-2d). The back end should show `"health": "Healthy"`, and TLS validation errors should be resolved.

## Resolution G

**Problem**: The Application Gateway isn't in a healthy, running state. It's either **Stopped** or its last configuration update left it in a **Failed** provisioning state. In both cases, every request returns "502" error messages regardless of back-end health.

1. If [Step 1a](#step-1a) shows `operationalState: Stopped`, start the gateway.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI.

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway start \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION"
   ```

1. If [Step 1a](#step-1a) shows `provisioningState: Failed`, the last write to the gateway didn't finish. A no-operation (no-op) update reruns the goal state and often clears a transient failed state.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   
   az network application-gateway update \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION"
   ```

   If the gateway returns to a `Failed` state, the most recent configuration change is invalid (for example, a back end, certificate, or subnet that no longer exists). Identify and revert the last change, or file an Azure support request.

1. Rerun [Step 1a](#step-1a). `provisioningState` should be `Succeeded`, and `operationalState` should be `Running`. In this case, go to [Step 1b](#step-1b).

## Resolution H

**Problem**: The gateway reaches its capacity limit. An autoscaling v2 gateway reaches its `maxCapacity`, or a fixed-capacity gateway has too few instances to handle the current load. Therefore, the gateway returns excess requests as "502" error messages.

1. For an **autoscaling v2** gateway, raise the maximum capacity.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$MAX_CAPACITY" ] && read -rp "New max capacity (e.g., 20): " MAX_CAPACITY
   
   az network application-gateway update \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --max-capacity "$MAX_CAPACITY"
   ```

1. For a **fixed-capacity** gateway, increase the instance count.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$INSTANCE_COUNT" ] && read -rp "New instance count (e.g., 4): " INSTANCE_COUNT
   
   az network application-gateway update \
     --name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --capacity "$INSTANCE_COUNT"
   ```

1. Rerun [Step 4](#step-4). `CapacityUnits` should now stay below the new limit during peak load, and the "502" error rate should drop.

## Resolution I

**Problem**: The App Service back end rejects the gateway's request because the `Host` header doesn't match a bound App Service hostname, or App Service access restrictions block the gateway.

> [!NOTE]
> Use this resolution only if [Step 1b](#step-1b) shows this App Service back end as **Healthy** (the probe is green) while clients still receive "502" error messages. The *routing rule's* data-path HTTP setting is sending an empty or unrecognized `Host` even though the probe sends one App Service accepts. 
> If [Step 1b](#step-1b) shows the App Service back end as **Unhealthy**, the probe itself is failing (typically TLS CN validation), and the next steps are [Step 2d](#step-2d), and then [Resolution F](#resolution-f), not this Resolution. Use [Step 5](#step-5) to indicate the probe-health-vs-data-path-host signal that verifies which resolution you should use.

1. Set the back-end HTTP settings to forward the back-end address as the host header.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI.

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --host-name-from-backend-pool true
   ```

   If you front the App Service with a custom domain, set an explicit host header that matches a hostname from `az webapp config hostname list`.

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI.

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
   [ -z "$RG" ] && read -rp "Resource Group:    " RG
   [ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
   [ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME
   [ -z "$BACKEND_HOSTNAME" ] && read -rp "App Service hostname (from hostname list): " BACKEND_HOSTNAME
   
   az network application-gateway http-settings update \
     --gateway-name "$RESOURCE_NAME" \
     --resource-group "$RG" \
     --subscription "$SUBSCRIPTION" \
     --name "$HTTP_SETTINGS_NAME" \
     --host-name "$BACKEND_HOSTNAME"
   ```

1. If [Step 5](#step-5) shows that App Service access restrictions are blocking the gateway, add an allow rule for the Application Gateway. Use the gateway's outbound public IP (for a public App Service) or the gateway subnet (for private endpoint or virtual network (VNet) integration):

   > [!IMPORTANT]
   > The following commands are all write operations that require your approval before you run them. Review them to better understand what each command does.

   Run the following commands in Azure CLI:

   ```azurecli-interactive
   # -- Collect inputs (cached if already set in this session) --
   [ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
   [ -z "$WEBAPP_RG" ] && read -rp "App Service Resource Group: " WEBAPP_RG
   [ -z "$WEBAPP_NAME" ] && read -rp "App Service Name:        " WEBAPP_NAME
   [ -z "$ALLOW_CIDR" ] && read -rp "App Gateway public IP/CIDR or subnet: " ALLOW_CIDR
   
   az webapp config access-restriction add \
     --name "$WEBAPP_NAME" \
     --resource-group "$WEBAPP_RG" \
     --subscription "$SUBSCRIPTION" \
     --rule-name Allow-AppGateway \
     --priority 100 \
     --action Allow \
     --ip-address "$ALLOW_CIDR"
   ```

1. Rerun [Step 5](#step-5), and then [Step 1b](#step-1b). The back end should report `"health": "Healthy"`, and the "502" errors should stop.

## References

- [Application Gateway health monitoring overview](/azure/application-gateway/application-gateway-probe-overview)
- [Application Gateway infrastructure configuration requirements](/azure/application-gateway/configuration-infrastructure)
- [Troubleshoot Application Gateway with Azure Monitor](/azure/application-gateway/log-analytics)
- [Diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics)
- [End-to-end TLS encryption with Application Gateway](/azure/application-gateway/ssl-overview)
- [Configure end-to-end TLS by using Application Gateway](/azure/application-gateway/end-to-end-ssl-portal)
- [Integrate API Management in an internal VNet with Application Gateway](/azure/api-management/api-management-howto-integrate-internal-vnet-appgateway)
- [Connection draining for Application Gateway](/azure/application-gateway/configuration-http-settings#connection-draining)
