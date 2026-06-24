---
title: Troubleshoot routing, redirect, and hostname issues in Azure Application Gateway
description: Use step-by-step diagnostics to identify and resolve path-based routing gaps, redirect loops, host header rewrite errors, and listener priority conflicts in Azure Application Gateway.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.custom: sap:Configuration and Setup
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - 404-error
  - redirect-loop
  - hostname-mismatch
  - routing-rule
  - rewrite-error
  - path-based-routing
  - listener-priority
  - host-header-rewrite
  - wrong-backend
  - http-to-https-redirect
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/applicationGateways/write
  - Microsoft.Insights/diagnosticSettings/read
  - Microsoft.OperationalInsights/workspaces/query/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - LOG_ANALYTICS_WORKSPACE_ID
---

# Troubleshoot routing, redirect, and hostname issues in Azure Application Gateway

## Summary

This article provides a step-by-step guide to diagnose and resolve routing, redirect, and hostname issues in Azure Application Gateway. 

Routing, redirect, and hostname problems in Application Gateway typically have the following root causes: 

- Path-based routing rules that lack a path entry for the requested URL and return "404" errors. 
- Redirect loops that are caused by an HTTP-to-HTTPS redirect configuration that conflicts with a backend that also redirects. 
- Rewrite rules that corrupt the `Host` header by appending a port number.  
- Listener priority ordering that causes a lower-specificity listener to match before the intended listener. 

## Symptoms

You might encounter one or more of the following symptoms:

- HTTP `404 Not Found` errors are returned by Application Gateway for an URL path that exists on the backend.
- Your browser shows `ERR_TOO_MANY_REDIRECTS` or the equivalent redirect loop error.
- Browser developer tools (such as the **Network** tab) show a repeating chain of `301`and `302` redirects between HTTP and HTTPS.
- Back-end applications receive an incorrect `Host` header that have an unexpected appended port number (for example, `contoso.com:443` instead of `contoso.com`).
- Back-end applications return the wrong content or an error because they receive a hostname that they don't recognize.
- Requests route to an unexpected back-end pool (the wrong site's served).
- Application Gateway returns `404` errors for some URL paths but `200` for others, despite all paths being valid on the backend.
- After you configure an HTTP-to-HTTPS redirect, the application becomes unreachable or loops indefinitely.
- A multi-site Application Gateway serves the wrong site's content for a specific hostname.

## Prerequisites

- **Permissions required:** `Network Contributor` role on the Application Gateway resource group, or equivalent (`Microsoft.Network/applicationGateways/read` and `write`)
- **Tools:** Azure CLI 2.x, or an AI agent with Azure MCP access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `$RG` | Resource group containing your Application Gateway | `myResourceGroup` |
| `$RESOURCE_NAME` | Application Gateway resource name | `myAppGateway` |
| `$WORKSPACE_ID` | Log Analytics workspace ID (GUID) where Application Gateway diagnostics are sent | `yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy` |
| `$FAILING_URL` | The full URL the client is requesting that produces the error | `https://contoso.com/api/orders` |
| `$FAILING_HOSTNAME` | Hostname portion of `$FAILING_URL` (derived automatically, or enter it) | `contoso.com` |
| `$FAILING_URL_PATH` | Path portion of `$FAILING_URL` (derived automatically, or enter it) | `/api/orders` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time. `$FAILING_HOSTNAME` and `$FAILING_URL_PATH` are derived from `$FAILING_URL` automatically. If the Log Analytics workspace ID is unknown, it can be discovered in [Step 1b](#step-1b).

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1a

Check which listener receives the client request, which routing rule processes it, and which back-end pool (or redirect) is the target. This check establishes the end-to-end request path for the failing URL.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway rule list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway http-listener list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

Map the `$FAILING_URL` to a listener by matching the hostname and port, and then follow the routing rule to the back-end pool or redirect configuration.

| Observation | Meaning | Next steps |
|---|---|---|
| A listener matches the hostname and port, and the routing rule type is `Basic` pointing to a back-end pool. | Request routes directly to a back-end pool. No path-based routing is involved. | Perform [Step 3](#step-3). |
| A listener matches and the routing rule type is `PathBasedRouting` with a `urlPathMap`. | Request is routed based on URL path. Path coverage gaps can cause `404` errors. | Perform [Step 2a](#step-2a). |
| A listener matches and the rule has a `redirectConfiguration` value (no back-end pool). | This rule redirects requests (for example, HTTP-to-HTTPS) creating a potential redirect loop. | Perform [Step 3](#step-3). |
| No listener matches the hostname in `$FAILING_URL`. | No listener is configured for this hostname. Request might reach a catch-all or be rejected. | Perform [Step 2b](#step-2b). |
| Multiple listeners might match the hostname (for example, wildcard and exact match). | Listener priority determines which rule handles the request. | Perform [Step 2b](#step-2b). |


### Step 1b

Check which Log Analytics workspace receives Application Gateway access logs.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az monitor diagnostic-settings list \
  --resource "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, workspaceId:workspaceId, logs:logs[?category=='ApplicationGatewayAccessLog'].enabled}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `workspaceId` is populated and `ApplicationGatewayAccessLog` is `true`. | Access logs are flowing. Record the workspace ID as `$WORKSPACE_ID`. | Continue diagnostics. |
| `ApplicationGatewayAccessLog` is `false` or missing. | Access logging isn't enabled. You can't query routing patterns until this setting is configured. | Enable access logging by using the following command snippet, and then rerun this step. |
| No diagnostic settings found. | No diagnostics configured at all. | Enable access logging using the following command snippet, and then rerun this step. |

**Enable Application Gateway access logging**

If `ApplicationGatewayAccessLog` isn't enabled, turn it on before continuing. This action creates or updates a diagnostic setting that streams access logs to a Log Analytics workspace. It doesn't change how traffic is handled.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$WORKSPACE_RESOURCE_ID" ] && read -rp "Log Analytics workspace resource ID: " WORKSPACE_RESOURCE_ID

az monitor diagnostic-settings create \
  --name "appgw-access-logs" \
  --resource "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --workspace "$WORKSPACE_RESOURCE_ID" \
  --logs '[{"category":"ApplicationGatewayAccessLog","enabled":true}]'
```

Wait 5–10 minutes for logs to begin flowing, and then rerun the prior diagnostic-settings list command to verify `ApplicationGatewayAccessLog` is `true`.

### Step 2a

Check whether the URL path map includes a rule for the path in `$FAILING_URL`. A missing path rule causes Application Gateway to route the request to the default back-end pool, which might return 404 errors if it isn't configured or points to the wrong application.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway url-path-map list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

Extract the URL path from `$FAILING_URL` (for example, `/api/orders`) and compare it against every `paths` entry in the path rules.

| Observation | Meaning | Next steps |
|---|---|---|
| A path rule explicitly matches the failing URL path (for example, `/api/orders/*`). | Path is covered. The 404 errors aren't caused by a missing path rule. | Perform [Step 3](#step-3). |
| No path rule matches the failing URL path. | Requests go to the default back-end pool. That pool might not serve this path. | Perform [Resolution A](#resolution-a). |
| Path rules use exact paths (for example, `/api/orders`) but the client requests `/api/orders/` (trailing slash) or `/api/orders/123` (subpath). | Path matching is prefix-based only when using `/*` wildcard. Exact paths require exact matches. | Perform [Resolution A](#resolution-a). |
| `defaultBackendAddressPool` is `null` or points to an empty pool. | Unmatched paths have no valid back-end target and result in 404 errors. | Perform [Resolution A](#resolution-a). |

> [!TIP]
> Application Gateway path matching is case-sensitive. `/Api/Orders` doesn't match a rule for `/api/orders`. Be sure to check the case carefully.

### Step 2b

Check whether listener priorities cause a less-specific listener (for example, wildcard `*.contoso.com`) to match before a more specific one (for example, `app.contoso.com`), routing the request to the wrong back-end pool and rule.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "requestRoutingRules[].{name:name, priority:priority, ruleType:ruleType, listener:httpListener.id, backend:backendAddressPool.id, redirect:redirectConfiguration.id}" \
  --output json
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "httpListeners[].{name:name, hostName:hostName, hostNames:hostNames, protocol:protocol, port:frontendPort.id}" \
  --output json
```

### Interpret the results

Sort rules by priority (a lower number equals a higher priority, which is evaluated first). Map each rule to its listener hostname.

| Observation | Meaning | Next steps |
|---|---|---|
| All listeners have unique hostnames and correct priorities. The intended listener has the lowest priority number for its hostname. | Listener priority is correctly configured. | Perform [Step 3](#step-3). |
| A wildcard listener (`*.contoso.com`) has a lower priority number than a specific listener (`app.contoso.com`). | The wildcard matches first. `app.contoso.com` requests route to the wildcard's rule. | Perform [Resolution D](#resolution-d). |
| Two listeners on the same port have the same hostname but different priorities. | There's a duplicate listener. The higher-priority rule handles all traffic and the other rule is unreachable. | Perform [Resolution D](#resolution-d). |
| A multi-site listener is configured without a hostname (blank `hostName`). | This listener acts as a catch-all. It matches any hostname not matched by other listeners. | Verify that this situation is intentional, and if not perform [Resolution D](#resolution-d). |
| Listener for `$FAILING_URL` hostname exists but is on the wrong port (for example, HTTP listener on port 80 but client connects on 443). | Client connects to a port that has no matching listener for this hostname. | Perform [Resolution D](#resolution-d). |

### Step 3

Check whether rewrite rule sets associated with the routing rule modify the `Host` header, inject redirect responses, or create conflicts with existing redirect configurations that cause loops.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway rewrite-rule set list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway redirect-config list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

The `rewrite-rule set list` command returns each rewrite rule as a set, and each set carries its `rewriteRules[].actionSet.requestHeaderConfigurations`. The `Host` header rows in the following table are inspected. To see the individual rules inside one set, rerun the step by using `az network application-gateway rewrite-rule list --gateway-name "$RESOURCE_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" --rule-set-name <set-name>`.

Review each rewrite rule set for:

- Host header modifications that rewrite that set or modify `Host` in the request.
- URL rewrites that conflict with redirect configurations.
- Redirect configurations that can conflict with back-end behavior.

| Observation | Meaning | Next steps |
|---|---|---|
| No rewrite rule sets configured. | Rewrites aren't the issue. | Perform [Step 4](#step-4). |
| A rewrite rule set `RequestHeader: Host` to a value such as `{var_host}` or `{http_req_host}`. | Rewrite is overwriting the `Host` header and might append ports if it uses `{http_req_host}`. This designation includes the port number. | Perform [Resolution C](#resolution-c). |
| A rewrite rule set `RequestHeader: Host` to `{var_host}:{server_port}` or something similar. | `Host` header rewrites explicitly include the port, and the backend receives `contoso.com:443`. | Perform [Resolution C](#resolution-c). |
| A redirect configuration redirects HTTP-to-HTTPS, and a rewrite rule also modifies the URL to HTTPS. | This scenario is a double redirect,. Both the redirect configuration and the rewrite try to upgrade to HTTPS. | Perform [Resolution B](#resolution-b). |
| A redirect configuration targets an HTTPS listener, but that listener's rule also has a rewrite that redirects back to HTTP. | This scenario is a circular redirect. HTTP-to-HTTPS redirects and a rewrite sends back to HTTP. | Perform [Resolution B](#resolution-b). |
| A redirect configuration upgrades HTTP-to-HTTPS, the symptom is a redirect loop (`ERR_TOO_MANY_REDIRECTS`), and no rewrite rules modify the URL scheme. | The loop isn't caused by a rewrite. The backend itself is returning a redirect (for example, back to HTTP), so Application Gateway reintercepts it and loops. | Perform [Resolution B](#resolution-b). |
| A redirect configuration exists with `redirectType: Permanent` (`301`) and `includePath: true` / `includeQueryString: true`. | This scenario a standard redirect configuration. Verify that the target URL or listener is correct. | If the target is correct, perform [Step 4](#step-4). |
| Rewrite rules and redirect configurations look correct. | This situation isn't a rewrite issue. | Perform [Step 4](#step-4). |

### Step 4

Check whether the HTTP settings override the `Host` header that's sent to the backend, and what the back-end pool target fully qualified domain name (FQDN) actually is. If you enable `pickHostNameFromBackendAddress`, the backend receives the FQDN of the back-end target instead of the original client `Host` header. If you set `hostName`, the backend receives that static value. If you don't set either value, the original client `Host` header is passed through unchanged. A misconfiguration in this step can cause the backend to receive a hostname it doesn't recognize. This situation is especially true if you pass the original client `Host` to a multitenant platform as a service (PaaS) backend (such as Azure App Service, Azure Functions, and Azure API Management) that answers to only its own FQDN.

Run the following commands in Azure CLI:

The first command lists the HTTP settings (the `Host` header override behavior). The second command lists the back-end pool targets so that you can determine whether the backend is a multitenant PaaS service that requires its own FQDN. Both are read-only.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway http-settings list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, port:port, protocol:protocol, hostName:hostName, pickHostNameFromBackendAddress:pickHostNameFromBackendAddress, affinityCookieName:affinityCookieName, cookieBasedAffinity:cookieBasedAffinity}" \
  --output json
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway address-pool list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, backendAddresses:backendAddresses[].{fqdn:fqdn, ipAddress:ipAddress}}" \
  --output json
```

### Classify the back-end target

From the second command, examine the `fqdn` of the back-end pool that serves `$FAILING_URL` (the pool that you identified in [Step 1a](#step-1a)). A backend is a multitenant PaaS service that requires its own FQDN in the `Host` header if the target `fqdn` ends in one of the following values:

- `*.azurewebsites.net` — App Service or Azure Functions.
- `*.azurewebsites.windows.net` — App Service (internal or regional form).
- `*.azure-api.net` — API Management.
- Any other PaaS backend that only answers to its own hostname (it rejects or returns a default page for any other `Host` header).

If the target is a plain VM or Virtual Machine Scale Sets IP address, an on-premises FQDN, or any host that's configured to answer for the client's hostname, it isn't a multitenant PaaS backend.

### Interpret the results

Read the HTTP settings (first command) together with the prior backend target classification.

| Observation | Meaning | Next steps |
|---|---|---|
| `pickHostNameFromBackendAddress: true` and backends are App Services or FQDNs. | Correct for App Service backends. The `Host` header matches the backend's FQDN. | Perform [Step 5](#step-5). |
| `pickHostNameFromBackendAddress: true` but backends are IP addresses. | The `Host` header is the raw IP address, and backends might not recognize it. | Perform [Resolution E](#resolution-e). |
| `hostName` is set to a specific value. | There's a `Static Host` header override. Verify that this setting matches what the backend expects. | If correct, Perform [Step 5](#step-5). If wrong, perform [Resolution E](#resolution-e). |
| `hostName` is null, `pickHostNameFromBackendAddress` is false, and the back-end pool target is a multi-tenant PaaS FQDN (`*.azurewebsites.net`, `*.azurewebsites.windows.net`, `*.azure-api.net`, or any PaaS backend that only answers to its own hostname) | The original client Host (for example, `contoso.com`). It passed through unchanged. But the PaaS backend accepts only its own FQDN because the `Host` header isn't allowed to match. The backend then returns "404" error code or a default page regardless of whether the pool target is correct. | Perform [Resolution E](#resolution-e). |
| `hostName` is null, `pickHostNameFromBackendAddress` is false, and the back-end pool target isn't a PaaS FQDN (VM or Azure, on-premises host, or any backend that accepts the client's hostname). | Original client `Host` header is passed through to the backend. This situation is correct if the backend expects the same hostname that the client uses.| Perform [Step 5](#step-5). |
| `hostName` contains a port number (for example, `contoso.com:443`). | `Host` header includes port, and can cause back-end issues. | Perform [Resolution C](#resolution-c). |

### Step 5

Check the actual routing decisions that Application Gateway made for recent requests, such as which listener handled the request, which backend received it, and what HTTP status code was returned.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
# Derive the hostname and path from the failing URL (override by setting them first)
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"
FAILING_URL_PATH="${FAILING_URL_PATH:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://[^/]+##; s#\?.*##')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' | where requestUri_s contains '$FAILING_URL_PATH' or originalHost_s contains '$FAILING_HOSTNAME' | project TimeGenerated, httpStatus_d, requestUri_s, originalHost_s, host_s, serverRouted_s, listenerName_s, ruleName_s, httpMethod_s | order by TimeGenerated desc | take 50" \
  --timespan PT4H \
  --output json
```

> [!TIP]
> `$FAILING_URL_PATH` (for example, `/api/orders`) and `$FAILING_HOSTNAME` (for example, `contoso.com`) are derived automatically from `$FAILING_URL`. If your URL format is unusual, set `FAILING_URL_PATH` and `FAILING_HOSTNAME` explicitly before running the block.
 
### Interpret the results

Before you use the following table, when `httpStatus_d = 404` is populated with `serverRouted_s`, explicitly compare the `Host` header that was sent to the backend (`host_s`) against the backend's required FQDN (`serverRouted_s`. That value is the back-end pool target that you also saw in [Step 4](#step-4)).

- The backend rejects the request because of the `Host` header if `host_s` isn't equivalent to the backend's required FQDN, and the backend is a multitenant PaaS service that requires its own FQDN (the PaaS classification from [Step 4](#step-4), such as `*.azurewebsites.net`, `*.azurewebsites.windows.net`, `*.azure-api.net`, or any backend that answers to only its own hostname). This condition is addressed in [Resolution E](#resolution-e), even though the back-end pool target is correct.
- The target is a pool or listener misconfiguration only if the back-end pool target (`serverRouted_s`) is, itself, the wrong application (a pool that points somewhere that the request shouldn't go). ([Resolution A](#resolution-a) or [Resolution D](#resolution-d)).

> [!NOTE]
> On an HTTPS multitenant PaaS backend (such as App Service, Azure Functions, or API Management), a missing `Host` header override can be exposed as an HTTP `502` error instead of the `404`, as documented in the following table. If you remove the override, you also break the Transport Layer Security (TLS) Server Name Indication (SNI) that the backend presents. Therefore, the connection fails before a `404` error code can be returned. In either case, `host_s` shows the original client host instead of the backend FQDN that's addressed in [Resolution E](#resolution-e).

Evaluate the rows in order. The first matching row takes precedence.

| Observation | Meaning | Next step |
|---|---|---|
| `httpStatus_d = 404` and `serverRouted_s` is empty. | Application Gateway itself returned a `404` error code. No backend was selected (path didn't match any rule). | Perform [Resolution A](#resolution-a). |
| `httpStatus_d = 404`, `serverRouted_s` is populated, `host_s` equals the backend's FQDN, and the pool target is correct. | Request reached the correct backend with the correct `Host` header but the backend still returned a `404` error code. The path is missing on the backend, not in Application Gateway. | Verify the backend application serves this path. If there's a path rule is missing, perform [Resolution A](#resolution-a). |
| Repeating `httpStatus_d = 301` or `302` entries whose `listenerName_s` alternates between the HTTP listener and the HTTPS listener. | Redirect loop confirmed in logs. The request bounces between the HTTP and HTTPS listeners. | Perform [Resolution B](#resolution-b). |
| `host_s` (`Host` header sent to backend) differs from `originalHost_s` (client's original `Host` header) and includes a port number. | `Host` header rewrite is appending the port. | Perform [Resolution C](#resolution-c). |
| `listenerName_s` isn't the expected listener for this hostname. | Wrong listener matched. A priority ordering issue exists. | Perform [Resolution D](#resolution-d). |
| `host_s` differs from the FQDN the backend application requires (and isn't a port-appended case). | `Host` header override is sending the wrong hostname to the backend. | Perform [Resolution E](#resolution-e). |
| All fields look correct, including the correct listener, correct backend, and correct host header. | Routing configuration is correct. The issue might be on the backend itself. | Check back-end application logs directly. |
| No log entries found for this URL or hostname. | Request might not be reaching Application Gateway. Check Domain Name System (DNS), network security group (NSG), and front-end IP. | Verify DNS resolution and the network path to Application Gateway. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| Path-based rule has no entry for the requested URL path [Step 2a](#step-2a). | Perform [Resolution A](#resolution-a). |
| Default back-end pool is empty or unconfigured for unmatched paths [Step 2a](#step-2a). | Perform [Resolution A](#resolution-a). |
| HTTP-to-HTTPS redirects and backend redirects back creating a loop [Step 3](#step-3). | Perform [Resolution B](#resolution-b). |
| Redirect configuration and rewrite rule both try an HTTP-to-HTTPS upgrade [Step 3](#step-3). | Perform [Resolution B](#resolution-b). |
| `Host` header rewrite appends port number [Step 3](#step-3) or [Step 4](#step-4). | Perform [Resolution C](#resolution-c). |
| Wildcard listener has higher priority than specific listener [Step 2b](#step-2b). | Perform [Resolution D](#resolution-d). |
| Wrong listener matches the request hostname [Step 2b](#step-2b) or [Step 5](#step-5). | Perform [Resolution D](#resolution-d). |
| Backend receives wrong hostname through HTTP settings override [Step 4](#step-4). | Perform [Resolution E](#resolution-e). |
| Backend is a multi-tenant PaaS service (such as App Service, Azure Functions, or API Management) but HTTP settings pass the original client `Host` unchanged [Step 4](#step-4), or the backend returns a `404` error code while `host_s` doesn't match the backend's required FQDN [Step 5](#step-5). | Perform [Resolution E](#resolution-e). |
| Access logs show requests routed to the wrong back-end pool [Step 5](#step-5). | Review [Resolution A](#resolution-a) or [Resolution D](#resolution-d) based on whether it's a path or listener problem. |
| All diagnostics pass, but the problem persists. | File an Azure support request. |

## Resolution A

The URL path map doesn't include a path rule for the requested URL, so the request passes through to the default back-end pool. This default back-end pool might be empty, point to the wrong application, or return `404` error codes because it doesn't serve that path.

Common scenarios include:

- A new API endpoint (`/api/v2/orders`) was deployed, but the Application Gateway path map only has a `/api/v1/*` value.
- Path rules use exact paths (`/api/orders`), but clients request subpaths (`/api/orders/123`).
- Path rules were configured by using a different case (`/API/Orders` versus `/api/orders`).

Run the following commands in Azure CLI (as applicable):

1. Record the existing path rules and the default back-end pool for unmatched paths.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
[ -z "$URL_PATH_MAP_NAME" ] && read -rp "URL Path Map Name:  " URL_PATH_MAP_NAME

az network application-gateway url-path-map show \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$URL_PATH_MAP_NAME" \
  --output json
```

2. Record:

- All existing `paths` entries and their associated back-end pools.
- The `defaultBackendAddressPool` where unmatched paths route.
- The `$URL_PATH_MAP_NAME` for use in the next step.

3. Add a new path rule for the missing path. 

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This process adds a new path rule to the URL path map `$URL_PATH_MAP_NAME` so that requests to `$MISSING_PATH` are routed to back-end pool `$TARGET_BACKEND_POOL` by using HTTP settings `$TARGET_HTTP_SETTINGS`. The `--paths` argument lists both the exact base path (`$MISSING_PATH`) and the trailing-wildcard form (`$MISSING_PATH/*`) so that the exact failing URL and all of its subpaths are included. A wildcard alone (`$MISSING_PATH/*`) matches subpaths and the trailing slash but not the exact base path. This condition leaves the originally failing URL routed to the default pool. Other existing path rules aren't affected.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:     " RESOURCE_NAME
[ -z "$URL_PATH_MAP_NAME" ] && read -rp "URL Path Map Name:    " URL_PATH_MAP_NAME
[ -z "$NEW_RULE_NAME" ] && read -rp "New Path Rule Name:   " NEW_RULE_NAME
[ -z "$MISSING_PATH" ] && read -rp "Missing Path (e.g. /api/orders): " MISSING_PATH
[ -z "$TARGET_BACKEND_POOL" ] && read -rp "Target back-end pool:  " TARGET_BACKEND_POOL
[ -z "$TARGET_HTTP_SETTINGS" ] && read -rp "Target HTTP Settings: " TARGET_HTTP_SETTINGS

az network application-gateway url-path-map rule create \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --path-map-name "$URL_PATH_MAP_NAME" \
  --name "$NEW_RULE_NAME" \
  --paths "$MISSING_PATH" "$MISSING_PATH/*" \
  --address-pool "$TARGET_BACKEND_POOL" \
  --http-settings "$TARGET_HTTP_SETTINGS"
```

> [!TIP]
> Add both forms: the exact path (`/api/orders`) and the trailing wildcard (`/api/orders/*`). The exact path includes the base URL the client originally requested. The wildcard includes every subpath (`/api/orders/123`) and the trailing-slash form (`/api/orders/`). A wildcard alone doesn't match the exact base path, so the originally failing URL would otherwise stay routed to the default pool. This mirrors the exact-versus-wildcard matching behavior noted in [Step 2a](#step-2a).

4. Rerun [Step 2a](#step-2a) to verify the new path rule appears. Then request `$FAILING_URL`. It should now return the expected response instead of 404 errors.

You can also verify in access logs.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_URL_PATH="${FAILING_URL_PATH:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://[^/]+##; s#\?.*##')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and requestUri_s contains '$FAILING_URL_PATH' | project TimeGenerated, httpStatus_d, serverRouted_s, ruleName_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| `httpStatus_d` value is 200 (or expected status) and `serverRouted_s` shows the correct backend. | Path rule is working and fix confirmed. |
| `httpStatus_d` value is still 404 with empty `serverRouted_s`. | Path rule might not match. Check trailing wildcard and case sensitivity. |
| `httpStatus_d` value is 404 with populated `serverRouted_s`. | Request reached a backend but the backend returned 404 errors. Verify the backend serves this path. |

If the issue persists, go to [Resolution D](#resolution-d) (listener priority) or check the backend application directly.

## Resolution B

A redirect loop occurs when Application Gateway has an HTTP-to-HTTPS redirect configuration and the backend application also sends a redirect response (typically back to HTTP, or to a different URL that Application Gateway reintercepts). The result is an infinite loop: the HTTP-to-HTTPS (Application Gateway) backend responds with redirects to HTTP-to-HTTP-to-HTTPS (Application Gateway) and so on.

Common scenarios include:

- HTTP listener has a redirect rule to the HTTPS listener, but the backend is also configured to redirect HTTP-to-HTTPS (for example, `web.config` rewrite rules or `HSTS` redirect on the backend).
- A rewrite rule modifies the URL scheme to HTTPS while a redirect configuration also upgrades to HTTPS. Both instigate on the same request.
- The backend detects that `X-Forwarded-Proto` is `http` and sends a 301 value to the HTTPS URL, which Application Gateway then reintercepts on the HTTP listener.

Run the following commands in Azure CLI (as applicable):

1. Check the access logs for repeating patterns of 301 or 302 value responses that alternate between the HTTP and HTTPS listeners.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and originalHost_s contains '$FAILING_HOSTNAME' and httpStatus_d in (301, 302) | project TimeGenerated, httpStatus_d, requestUri_s, originalHost_s, listenerName_s, serverRouted_s, serverResponseLatency_d | order by TimeGenerated desc | take 20" \
  --timespan PT1H \
  --output json
```

Look for repeating patterns such as the following:

- Repeating `httpStatus_d` 301 or 302 value entries whose `listenerName_s` alternates between the HTTP listener and the HTTPS listener (the loop bounces between the two listeners).
- `serverRouted_s` populated only on the HTTPS listener (backend also returns a redirect).

2. Check the rewrite rule sets and redirect configurations associated with the routing rule for `$FAILING_URL` to see if both are trying to upgrade HTTP-to-HTTPS.

There are typically two scenarios. Choose the one that matches.

**Option 1: Fix the backend redirect if the backend sends a `Location: http://...` header**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. The backend application is redirecting to HTTP because it doesn't see HTTPS in the `X-Forwarded-Proto` header (or isn't configured to respect it). The fix adds a rewrite rule that sets `X-Forwarded-Proto: https` on requests arriving at the HTTPS listener, so the backend knows the client connection is HTTPS and stops redirecting.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway rewrite-rule set create \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name XForwardedProtoRewrite
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway rewrite-rule create \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --rule-set-name XForwardedProtoRewrite \
  --name SetXForwardedProto \
  --request-headers "X-Forwarded-Proto=https" \
  --sequence 100
```

Then associate the rewrite rule set with the HTTPS listener's routing rule:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$HTTPS_RULE_NAME" ] && read -rp "HTTPS Routing Rule Name: " HTTPS_RULE_NAME

az network application-gateway rule update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$HTTPS_RULE_NAME" \
  --rewrite-rule-set XForwardedProtoRewrite
```

**Option 2: Remove the duplicate HTTPS upgrade**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. Both a redirect configuration and a rewrite rule are trying to upgrade HTTP to HTTPS, creating a conflict. The recommended approach is to keep the redirect configuration (the standard method) and remove the conflicting rewrite rule.

Identify the conflicting rewrite rule from [Step 3](#step-3), then remove it:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$REWRITE_RULE_SET_NAME" ] && read -rp "Rewrite Rule Set Name:        " REWRITE_RULE_SET_NAME
[ -z "$CONFLICTING_REWRITE_RULE_NAME" ] && read -rp "Conflicting Rewrite Rule Name: " CONFLICTING_REWRITE_RULE_NAME

az network application-gateway rewrite-rule delete \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --rule-set-name "$REWRITE_RULE_SET_NAME" \
  --name "$CONFLICTING_REWRITE_RULE_NAME"
```

3. Clear the browser cache (redirect responses are often cached) and request `$FAILING_URL`. 

The request should finish without a redirect loop.

Verify this result in access logs:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and originalHost_s contains '$FAILING_HOSTNAME' | project TimeGenerated, httpStatus_d, requestUri_s, listenerName_s, serverRouted_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| A single 301 or 302 value on the HTTP listener (`listenerName_s`) followed by a 200 value on the HTTPS listener. `listenerName_s` no longer alternates. | Redirect works correctly. There was a one-time redirect, not a loop. |
| Repeating 301 or 302 value entries whose `listenerName_s` still alternates between the HTTP and HTTPS listeners. | Redirect loop not fully resolved. Check if the backend still sends redirect responses and verify the `X-Forwarded-Proto` header is reaching the backend. |
| `httpStatus_d` is now 200 on all requests (no redirects). | No redirects occurring. You might need the HTTP-to-HTTPS redirect if that's intended. |

If the issue persists, go to [Resolution C](#resolution-c) or file an Azure support request.

## Resolution C

A rewrite rule modifies the `Host` request header by using a server variable that includes the port number. For example, `{http_req_host}` resolves to `contoso.com:443`. The backend application receives `Host: contoso.com:443` instead of `Host: contoso.com`. This difference causes the backend application to return errors, wrong content, or reject the request.

Common scenarios include:

- A rewrite rule sets `Host` to `{http_req_host}`. This variable includes the port when the client sends it.
- A rewrite rule hardcodes `Host` to `hostname:port` format.
- A backend application (especially IIS or ASP.NET) uses the `Host` header for URL generation and produces broken links or redirects containing the port.

Run the following commands in Azure CLI (as applicable).

1. Locate the rewrite rule that sets `RequestHeader: Host` ([Step 3](#step-3)).

Record:

- `$REWRITE_RULE_SET_NAME`, the rewrite rule set name.
- `$REWRITE_RULE_NAME`, the specific rewrite rule name.
- The current header value expression.

1. Update the rewrite rule to set the `Host` header to `{var_host}` instead of `{http_req_host}`.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This update changes the rewrite rule to set the `Host` header to `{var_host}` instead of `{http_req_host}`. The `{var_host}` variable contains the hostname without the port number that the back-end application expects.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$REWRITE_RULE_SET_NAME" ] && read -rp "Rewrite Rule Set Name: " REWRITE_RULE_SET_NAME
[ -z "$REWRITE_RULE_NAME" ] && read -rp "Rewrite Rule Name:     " REWRITE_RULE_NAME

az network application-gateway rewrite-rule update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --rule-set-name "$REWRITE_RULE_SET_NAME" \
  --name "$REWRITE_RULE_NAME" \
  --request-headers "Host={var_host}"
```

As an alternative, remove the `Host` header rewrite entirely if the backend should receive the original client `Host` header.


> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$REWRITE_RULE_SET_NAME" ] && read -rp "Rewrite Rule Set Name: " REWRITE_RULE_SET_NAME
[ -z "$REWRITE_RULE_NAME" ] && read -rp "Rewrite Rule Name:     " REWRITE_RULE_NAME

az network application-gateway rewrite-rule update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --rule-set-name "$REWRITE_RULE_SET_NAME" \
  --name "$REWRITE_RULE_NAME" \
  --request-headers ""
```

> [!NOTE]
> If the rewrite rule has other header configurations that you want to keep, update them selectively instead of clearing all headers.

3. Request `$FAILING_URL` and then check that the backend receives the correct `Host` header.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and originalHost_s contains '$FAILING_HOSTNAME' | project TimeGenerated, originalHost_s, host_s, httpStatus_d, serverRouted_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| `host_s` shows hostname without a port (for example, `contoso.com`). | `Host` header is correct. |
| `host_s` still shows hostname with a port (for example, `contoso.com:443`). | Rewrite rule update might not be in effect. Wait 1–2 minutes, and then recheck. Verify that the correct rewrite rule set is associated with the routing rule. |

If the issue persists, go to [Resolution E](#resolution-e).

## Resolution D

Listener priority values cause Application Gateway to evaluate a less-specific listener (for example, wildcard `*.contoso.com` or a catch-all that has no hostname) before a more specific listener (for example, `app.contoso.com`). Therefore, the wrong routing rule handles the request.

Common scenarios include:

- Wildcard listener `*.contoso.com` has priority 100, but `app.contoso.com` listener has priority 200. The wildcard matches first.
- A catch-all listener (no hostname) has the highest priority (lowest number) and intercepts all requests.
- After you add a new multi-site listener, the priority is set higher than existing listeners.

Run the following commands in Azure CLI (as applicable).

1. List all rules sorted by priority [Step 2b](#step-2b).

Identify:

- The intended listener for `$FAILING_HOSTNAME` and its current priority.
- Any competing listener that matches the same hostname (wildcard or catch-all) with a higher priority (lower number).

Record:

- `$RULE_NAME`, the rule that should handle the request.
- `$CORRECT_PRIORITY`, the new priority value (lower number means higher priority).
- `$COMPETING_RULE_NAME`, the rule that is incorrectly matching first.
- `$COMPETING_NEW_PRIORITY`, the new priority for the competing rule (higher number).

2. Update the routing rule priorities.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This change sets the priority of routing rule `$RULE_NAME` to `$CORRECT_PRIORITY` so that it's evaluated before the less-specific rule `$COMPETING_RULE_NAME`. Specific-hostname listeners should always have higher priority (lower number) than wildcard or catch-all listeners.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$RULE_NAME" ] && read -rp "Routing Rule Name: " RULE_NAME
[ -z "$CORRECT_PRIORITY" ] && read -rp "New Priority:       " CORRECT_PRIORITY

az network application-gateway rule update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --priority "$CORRECT_PRIORITY"
```

If the competing rule also needs a priority adjustment:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME
[ -z "$COMPETING_RULE_NAME" ] && read -rp "Competing Rule Name:  " COMPETING_RULE_NAME
[ -z "$COMPETING_NEW_PRIORITY" ] && read -rp "Competing New Priority: " COMPETING_NEW_PRIORITY

az network application-gateway rule update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$COMPETING_RULE_NAME" \
  --priority "$COMPETING_NEW_PRIORITY"
```

**Priority guidelines**

- Exact hostname listeners: priority 100–199.
- Wildcard hostname listeners: priority 200–299.
- Catch-all (no hostname) listeners: priority 300 or greater.
- Leave gaps between priority values (for example, 100, 110, 120) for future additions.

3. Request `$FAILING_URL` and verify that the correct listener handles it.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and originalHost_s contains '$FAILING_HOSTNAME' | project TimeGenerated, listenerName_s, ruleName_s, httpStatus_d, serverRouted_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| `listenerName_s` shows the correct specific listener. | Priority fix is working. The correct rule handles traffic. |
| `listenerName_s` still shows the wildcard or catch-all listener.| Priority might not have updated. Verify the rule configuration in [Step 2b](#step-2b). |

If the problem persists, file an Azure support request.

## Resolution E

The back-end application receives a `Host` header that it doesn't recognize because the HTTP settings don't override the `Host` header (passing through the client's original header), or the override is set to the wrong value. This problem commonly occurs when the backend is App Service, Azure Function, or any multitenant PaaS that requires its own FQDN in the `Host` header.

Common scenarios include:

- Backend is App Service (`myapp.azurewebsites.net`) but receives `Host: contoso.com`. App Service doesn't recognize this hostname and returns a default page or error.
- Backend is an IP-based VM but `pickHostNameFromBackendAddress` sends the raw IP as the `Host` header.
- Multiple backends behind the same pool need different `Host` headers.

Run the following commands in Azure CLI (as applicable):

1. Identify the backend type and the correct `Host` header value for that backend.

| Backend type | Correct host header setting |
|---|---|
|  App Service or Azure Functions. | Enable `pickHostNameFromBackendAddress: true` (sends `myapp.azurewebsites.net`). |
| VM or Virtual Machine Scale Sets with IP addresses. | Set a static `hostName` (for example, `contoso.com`). |
| VM or Virtual Machine Scale Sets with FQDN in back-end pool. | Enable `pickHostNameFromBackendAddress: true` or set a static `hostName`. |
| Any backend that expects the original client hostname. | Leave both `hostName` and `pickHostNameFromBackendAddress` unset or false. |

2. Update the HTTP settings to send the correct `Host` header.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. Use the appropriate command based on the backend type identified in step 1

**Option 1: Pick hostname from back-end address (for App Service backends)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
[ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name: " HTTP_SETTINGS_NAME

az network application-gateway http-settings update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$HTTP_SETTINGS_NAME" \
  --host-name-from-backend-pool true
```

**Option 2: Set a static hostname**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:           " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:         " RESOURCE_NAME
[ -z "$HTTP_SETTINGS_NAME" ] && read -rp "HTTP Settings Name:       " HTTP_SETTINGS_NAME
[ -z "$CORRECT_BACKEND_HOSTNAME" ] && read -rp "Correct Backend Hostname: " CORRECT_BACKEND_HOSTNAME

az network application-gateway http-settings update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$HTTP_SETTINGS_NAME" \
  --host-name "$CORRECT_BACKEND_HOSTNAME"
```

3. Rerun [Step 4](#step-4) to verify that the HTTP settings now show the correct host header configuration. Request `$FAILING_URL` and verify that the backend returns the expected response.

Check access logs:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace ID: " WORKSPACE_ID
[ -z "$FAILING_URL" ] && read -rp "Failing URL:                " FAILING_URL
FAILING_HOSTNAME="${FAILING_HOSTNAME:-$(printf '%s' "$FAILING_URL" | sed -E 's#^[a-z]+://([^/:]+).*#\1#')}"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayAccessLog' and originalHost_s contains '$FAILING_HOSTNAME' | project TimeGenerated, originalHost_s, host_s, httpStatus_d, serverRouted_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| `host_s` matches the expected back-end hostname, and `httpStatus_d` is 200. | `Host` header override is correct. |
| `host_s` is correct, but the backend still returns an error. | Backend might have additional hostname validation problems. Check back-end configuration. |

## References

- [Application Gateway request routing rules overview](/azure/application-gateway/application-gateway-components#request-routing-rules)
- [URL path-based routing overview](/azure/application-gateway/url-route-overview)
- [Application Gateway redirect overview](/azure/application-gateway/redirect-overview)
- [Rewrite HTTP headers and URL with Application Gateway](/azure/application-gateway/rewrite-http-headers-url)
- [Application Gateway multi-site hosting](/azure/application-gateway/multiple-site-overview)
- [Application Gateway listener configuration](/azure/application-gateway/configuration-listeners)
- [Troubleshoot Application Gateway with Azure Monitor](/azure/application-gateway/monitor-application-gateway)
- [Application Gateway HTTP settings configuration](/azure/application-gateway/configuration-http-settings)
