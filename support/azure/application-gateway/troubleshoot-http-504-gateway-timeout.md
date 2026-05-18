---
title: "Troubleshoot HTTP 504 Gateway Timeout errors in Azure Application Gateway"
description: "Step-by-step diagnostics to identify and resolve HTTP 504 Gateway Timeout responses from Azure Application Gateway."
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 5/14/2026
ai.hint.symptom-tags:
  - 504-error
  - gateway-timeout
  - request-timeout
  - backend-slow
  - high-latency
  - server-response-latency
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/applicationGateways/backendhealth/action
  - Microsoft.Network/applicationGateways/write
  - Microsoft.Insights/diagnosticSettings/read
  - Microsoft.Compute/virtualMachines/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
---

# Troubleshoot HTTP 504 Gateway Timeout errors in Azure Application Gateway

## Summary

HTTP 504 Gateway Timeout errors from Application Gateway occur when the backend server doesn't respond within the configured request timeout threshold. The most common root causes are: backend application processing time exceeds the timeout setting, backend resource exhaustion (high CPU, memory, or disk IOPS), or network-level delays between Application Gateway and the backend.

## Symptoms

- HTTP 504 responses returned to clients by Application Gateway
- Intermittent timeouts that correlate with traffic spikes or specific API endpoints
- Application Gateway access logs show high `serverResponseLatency` values
- Backend application response times have increased with no Application Gateway configuration change
- Portal message: `The request to the backend timed out`

## Prerequisites

- **Permissions required:** `Network Contributor` role on the Application Gateway resource group, or equivalent (`Microsoft.Network/applicationGateways/read`)
- **Tools:** Azure CLI 2.x, Azure PowerShell 9.x, or an AI agent with Azure MCP
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |

> **TIP:** Before running any commands, confirm all variables above. Additional variables (Log Analytics workspace ID, backend resource IDs, subnet IDs) are discovered during the diagnostic steps — you do not need them upfront.

---

## Diagnostic steps

> **These steps are read-only. No changes will be made to your environment.**

---

### Step 1

**What this checks:** The request timeout value in the HTTP settings. Application Gateway waits this many seconds for a response from the backend before returning 504 to the client.

#### Run this command

**Azure CLI:**
```azurecli-interactive
az network application-gateway http-settings list \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, port:port, protocol:protocol, requestTimeout:requestTimeout}" \
  --output table
```

**Azure PowerShell:**
```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.BackendHttpSettingsCollection |
  Select-Object Name, Port, Protocol, RequestTimeout |
  Format-Table -AutoSize
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `requestTimeout` is 20 seconds (default) | The default is appropriate for most web applications — 20 seconds is already generous for typical page loads and API calls. Only increase if the backend legitimately performs long-running operations (report generation, file processing, batch APIs). | Note the value, then → [Step 2](#step-2) — check actual backend response times |
| `requestTimeout` is set to 30–120 seconds and 504s still occur | Backend is responding slower than even an extended timeout allows | → [Step 2](#step-2) — check actual backend response latency |
| `requestTimeout` is very high (e.g., 300+ seconds) and 504s still occur | Extreme backend delay or network issue — the timeout is not the problem | → [Step 2](#step-2) — investigate backend and network path |

---

### Step 1b

**What this checks:** Which Log Analytics workspace receives Application Gateway access logs. You need this workspace ID to query logs in Step 2.

**Azure CLI:**
```azurecli-interactive
az monitor diagnostic-settings list \
  --resource "/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.Network/applicationGateways/{RESOURCE_NAME}" \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, workspaceId:workspaceId, logs:logs[?category=='ApplicationGatewayAccessLog'].enabled}" \
  --output json
```

**Azure PowerShell:**
```powershell
Get-AzDiagnosticSetting `
  -ResourceId "/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.Network/applicationGateways/{RESOURCE_NAME}"
```

| If you see... | Meaning | Next step |
|---|---|---|
| `workspaceId` is populated and `ApplicationGatewayAccessLog` is `true` | Access logs are flowing — record the `workspaceId` value (this is an ARM resource ID) | → Get the workspace GUID below, then → [Step 2](#step-2) |
| `ApplicationGatewayAccessLog` is `false` or missing | Access logging is not enabled — you cannot query access logs until this is configured | → [Resolution D](#resolution-d) — enable access logging first |
| No diagnostic settings found | No diagnostics configured at all | → [Resolution D](#resolution-d) |

> **Important:** The `workspaceId` returned above is an ARM resource ID, but the `az monitor log-analytics query` command in Step 2 requires the **workspace GUID** (`customerId`). Run this command to get the GUID:

**Azure CLI:**
```azurecli-interactive
az monitor log-analytics workspace show \
  --ids "{WORKSPACE_ARM_RESOURCE_ID}" \
  --query customerId \
  --output tsv
```

**Azure PowerShell:**
```powershell
(Get-AzOperationalInsightsWorkspace | Where-Object ResourceId -eq "{WORKSPACE_ARM_RESOURCE_ID}").CustomerId
```

Record the returned GUID as `{LOG_ANALYTICS_WORKSPACE_ID}` for use in Step 2.

---

### Step 2

**What this checks:** The actual time the backend takes to respond, as recorded in Application Gateway access logs.

> **Prerequisite:** Diagnostic settings must be enabled and the `ApplicationGatewayAccessLog` category must be sent to Log Analytics. If not configured, see [Step 1b](#step-1b). If you recently enabled diagnostic settings, log data may take 15–20 minutes to appear.

#### Run this command

**Azure CLI:**
```azurecli-interactive
az monitor log-analytics query \
  --workspace {LOG_ANALYTICS_WORKSPACE_ID} \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' | where Resource == toupper('{RESOURCE_NAME}') | where httpStatus_d == 504 | project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s | order by TimeGenerated desc | take 50" \
  --timespan PT24H \
  --output json
```

**Azure PowerShell:**
```powershell
$query = @"
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
| where Resource == toupper("{RESOURCE_NAME}")
| where httpStatus_d == 504
| project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s
| order by TimeGenerated desc
| take 50
"@
Invoke-AzOperationalInsightsQuery `
  -WorkspaceId "{LOG_ANALYTICS_WORKSPACE_ID}" `
  -Query $query `
  -Timespan (New-TimeSpan -Hours 24)
```

**KQL query (if running directly in Log Analytics portal):**
```kql
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
| where Resource == toupper("{RESOURCE_NAME}")
| where httpStatus_d == 504
| project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s
| order by TimeGenerated desc
| take 50
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `serverResponseLatency_s` exceeds `requestTimeout` value from Step 1 | Backend is responding slower than the timeout allows | → [Resolution A](#resolution-a) — increase timeout, or → [Step 3](#step-3) — investigate backend |
| `serverResponseLatency_s` is consistently at a specific value (e.g., exactly 20s or 30s) that is **below** `requestTimeout` | The backend application itself has an internal timeout (e.g., web server `proxy_read_timeout`, PHP `max_execution_time`, or application-level request timeout) that is shorter than the Application Gateway timeout. The backend closes the connection at its own limit, causing Application Gateway to return 504. | → [Step 2b](#step-2b) — check backend health, then → [Resolution B](#resolution-b) — investigate and fix the backend application's internal timeout configuration |
| `serverResponseLatency_s` is near zero but `timeTaken_d` is high | Network delay between Application Gateway and backend, or the backend dropped the connection | → [Resolution C](#resolution-c) — check network path |
| 504s correlate with specific `requestUri_s` patterns | Certain API endpoints or pages are slow | → [Step 3](#step-3) — investigate those specific backend endpoints |
| No access log data found | Access logging is not enabled | → [Resolution D](#resolution-d) — enable access logging |

---

### Step 2b

**What this checks:** Whether Application Gateway can successfully reach the backend servers and whether the health probes are passing. This is one of the most fundamental diagnostics — a backend marked as **Unhealthy** will cause all requests to fail.

#### Run this command

**Azure CLI:**
```azurecli-interactive
az network application-gateway show-backend-health \
  --name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "backendAddressPools[].backendHttpSettingsCollection[].servers[].{address:address, health:health, healthProbeLog:healthProbeLog}" \
  --output json
```

**Azure PowerShell:**
```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$health = Get-AzApplicationGatewayBackendHealth `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$health.BackendAddressPools.BackendHttpSettingsCollection.Servers |
  Select-Object Address, Health, HealthProbeLog |
  Format-Table -AutoSize
```

> **Note:** This command may take 30–60 seconds to complete because it performs a live health probe against the backend.

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `health` is `Healthy` and probe returns 200 | Backend is reachable and responding to health probes — the issue is specific to request processing time, not availability | → [Step 3](#step-3) — check backend resource utilization |
| `health` is `Unhealthy` with probe timeout or connection refused | Backend is not responding to health probes — requests will fail with 502 or 504 | Check that the backend application is running and listening on the correct port. Verify NSG rules allow traffic from the Application Gateway subnet. |
| `health` is `Unhealthy` with non-200 status code | Backend responds but with an error (e.g., 403, 500) — health probe path may be misconfigured | Verify the health probe path returns 200 on the backend. Check probe settings with `az network application-gateway probe list`. |
| Mixed results (some healthy, some unhealthy) | Partial backend failure — some instances are down | Investigate the unhealthy instances specifically |

---

### Step 3

**What this checks:** Whether the backend VM or app service is under resource pressure (CPU, memory, disk IOPS) that could explain slow responses.

#### Step 3a

First, identify which backend servers are in the Application Gateway backend pool:

**Azure CLI:**
```azurecli-interactive
az network application-gateway address-pool list \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, backends:backendAddresses[].{ip:ipAddress, fqdn:fqdn}}" \
  --output json
```

**Azure PowerShell:**
```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.BackendAddressPools |
  Select-Object Name, @{N='Backends';E={($_.BackendAddresses | ForEach-Object { $_.IpAddress ?? $_.Fqdn }) -join ', '}} |
  Format-Table -AutoSize
```

Record the backend IP addresses or FQDNs returned. If the backends are Azure VMs in the same resource group as the Application Gateway, use `{RESOURCE_GROUP}` below. Otherwise, identify the resource group containing the backend resources.

#### Step 3b

For Azure VM backends

**Azure CLI:**
```azurecli-interactive
az vm list \
  --resource-group {BACKEND_RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, vmSize:hardwareProfile.vmSize}" \
  --output table
```

```azurecli-interactive
az monitor metrics list \
  --resource {BACKEND_VM_RESOURCE_ID} \
  --subscription {SUBSCRIPTION_ID} \
  --metric "Percentage CPU" "Available Memory Bytes" "Disk Read Operations/Sec" "Disk Write Operations/Sec" \
  --interval PT5M \
  --start-time {START_TIME} \
  --end-time {END_TIME} \
  --output table
```

**Azure PowerShell:**
```powershell
Get-AzMetric `
  -ResourceId "{BACKEND_VM_RESOURCE_ID}" `
  -MetricName "Percentage CPU", "Available Memory Bytes" `
  -TimeGrain 00:05:00 `
  -StartTime (Get-Date).AddHours(-2) `
  -EndTime (Get-Date)
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| CPU consistently above 90% | Backend CPU saturated — requests queue up | → [Resolution B](#resolution-b) — scale or optimize backend |
| Available memory near zero | Memory exhaustion — backend may be swapping or OOM-killing processes | → [Resolution B](#resolution-b) — scale or optimize backend |
| Disk IOPS at or near the VM SKU limit | Disk throughput bottleneck — common with Standard HDD or undersized disks | → [Resolution B](#resolution-b) — upgrade disk tier or VM SKU |
| All metrics within normal range | Backend infrastructure is healthy — investigate application-level performance | → [Resolution B](#resolution-b) — profile the application |

---

## Decision map

| Diagnostic result | Next action |
|---|---|
| Request timeout too low for backend processing time | [Resolution A — Increase request timeout](#resolution-a) |
| Backend application has its own internal timeout shorter than Application Gateway timeout | [Resolution B — Scale or optimize backend](#resolution-b) — fix backend app timeout configuration |
| Backend health probe unhealthy | Verify backend application is running, check NSG rules, verify probe path |
| Backend CPU/memory/disk exhausted | [Resolution B — Scale or optimize backend](#resolution-b) |
| Network delay between Application Gateway and backend | [Resolution C — Fix network path](#resolution-c) |
| Access logging not enabled (cannot diagnose) | [Resolution D — Enable access logging](#resolution-d) |
| All diagnostics pass, 504s still occurring | File an Azure support request |

---

## Resolution A

**Root cause:** The Application Gateway request timeout (default 20 seconds) is shorter than the backend's response time.

### A.1

> **⚠️ WRITE OPERATION — requires customer approval before executing**

> **TIP:** Review the following command and understand what it does before executing. Set the request timeout to accommodate your backend's expected response time with a reasonable margin.

**Azure CLI:**
```azurecli-interactive
az network application-gateway http-settings update \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {HTTP_SETTINGS_NAME} \
  --timeout 60
```

**Azure PowerShell:**
```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$settings = Get-AzApplicationGatewayBackendHttpSetting `
  -ApplicationGateway $gw `
  -Name "{HTTP_SETTINGS_NAME}"

Set-AzApplicationGatewayBackendHttpSetting `
  -ApplicationGateway $gw `
  -Name "{HTTP_SETTINGS_NAME}" `
  -Port $settings.Port `
  -Protocol $settings.Protocol `
  -RequestTimeout 60

Set-AzApplicationGateway -ApplicationGateway $gw
```

> **Note:** Maximum request timeout is 86400 seconds (24 hours). Typical values for web applications are 30–120 seconds. Setting this very high doesn't fix the root cause — it only masks slow backend responses.

### A.2

Monitor access logs after the change. `serverResponseLatency_s` should now be within the new timeout, and 504 errors should stop for requests where the backend responds within the new threshold.

If 504s persist even with increased timeout, proceed to [Resolution B](#resolution-b) to address backend performance.

---

## Resolution B

**Root cause:** The backend server can't process requests within the timeout due to resource constraints or application-level performance issues.

### B.1

> **⚠️ WRITE OPERATION — requires customer approval before executing**

For Azure VMs, resize to a larger SKU:

```azurecli-interactive
az vm resize \
  --resource-group {BACKEND_RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {BACKEND_VM_NAME} \
  --size Standard_D4s_v5
```

For App Service backends, scale up the App Service Plan:

```azurecli-interactive
az appservice plan update \
  --resource-group {BACKEND_RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {APP_SERVICE_PLAN_NAME} \
  --sku P2v3
```

### B.2

> **⚠️ WRITE OPERATION — requires customer approval before executing**

Add additional backend servers to the Application Gateway backend pool to distribute load:

```azurecli-interactive
az network application-gateway address-pool update \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {BACKEND_POOL_NAME} \
  --servers {EXISTING_BACKENDS} {NEW_BACKEND_IP_OR_FQDN}
```

### B.3

If backend infrastructure metrics are healthy but responses are slow, the issue is at the application level:

- Profile the slow API endpoints to identify bottlenecks (database queries, external service calls, CPU-intensive processing).
- Enable Application Insights on the backend to trace slow requests.
- Implement caching for expensive operations.
- Review connection pooling settings for database connections.

---

## Resolution C

**Root cause:** Network delay or packet loss between Application Gateway and the backend, causing responses to arrive after the timeout.

### C.1

First, discover the Application Gateway subnet ID:

**Azure CLI:**
```azurecli-interactive
az network application-gateway show \
  --name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "gatewayIPConfigurations[0].subnet.id" \
  --output tsv
```

**Azure PowerShell:**
```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.GatewayIPConfigurations[0].Subnet.Id
```

Record the returned value as `{APPGW_SUBNET_ID}`, then check for route tables and NSGs:

**Azure CLI (read-only):**
```azurecli-interactive
az network vnet subnet show \
  --ids {APPGW_SUBNET_ID} \
  --query "{routeTable:routeTable.id, nsg:networkSecurityGroup.id}" \
  --output json
```

If a route table exists, check for routes that redirect backend traffic through a Network Virtual Appliance (NVA):

```azurecli-interactive
az network route-table route list \
  --route-table-name {ROUTE_TABLE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --output table
```

| If you see... | Meaning | Next step |
|---|---|---|
| No route table or only default routes | Network path is direct — latency not caused by routing | Check backend application performance |
| Route to backend subnet via NVA | Traffic traverses a firewall/NVA — adds latency | Verify NVA capacity and whether it's a bottleneck |

---

## Resolution D

**Root cause:** Cannot diagnose 504 errors without access log data.

> **⚠️ WRITE OPERATION — requires customer approval before executing**

```azurecli-interactive
az monitor diagnostic-settings create \
  --resource {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --resource-type Microsoft.Network/applicationGateways \
  --subscription {SUBSCRIPTION_ID} \
  --name appgw-diagnostics \
  --workspace {LOG_ANALYTICS_WORKSPACE_ID} \
  --logs "[{\"category\":\"ApplicationGatewayAccessLog\",\"enabled\":true},{\"category\":\"ApplicationGatewayPerformanceLog\",\"enabled\":true}]"
```

After enabling, wait for traffic to flow through the gateway (15–30 minutes), then re-run [Step 2](#step-2).

---

## Related articles

- [Application Gateway health monitoring overview](/azure/application-gateway/application-gateway-probe-overview)
- [Application Gateway HTTP settings configuration](/azure/application-gateway/configuration-http-settings)
- [Backend health and diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics)
- [Troubleshoot Application Gateway with Azure Monitor](/azure/application-gateway/log-analytics)
- [Connection draining for Application Gateway](/azure/application-gateway/configuration-http-settings#connection-draining)
CorrelationId: fae42fbf-5182-4eb5-bcf9-73643df96ed8, TimeStamp: 2026-05-14_23:40:22