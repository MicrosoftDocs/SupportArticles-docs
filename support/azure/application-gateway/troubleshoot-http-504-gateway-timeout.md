---
title: Troubleshoot HTTP 504 Gateway Timeout errors in Azure Application Gateway
description: Diagnose and fix HTTP 504 Gateway Timeout errors in Azure Application Gateway. Check backend response times, health probes, and network latency to resolve timeouts now.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.author: chadmat
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

HTTP 504 Gateway Timeout errors from Application Gateway occur when the backend server doesn't respond within the configured request timeout threshold. The most common causes include:

- Backend application processing time exceeds the timeout setting. 
- Backend resource exhaustion (high CPU, memory, or disk input/output operations per second (IOPS)). 
- Network-level delays between Application Gateway and the backend.

## Symptoms

Common symptoms include:

- Application Gateway returns HTTP 504 responses to clients.
- Intermittent timeouts that correlate with traffic spikes or specific API endpoints.
- Application Gateway access logs show high `serverResponseLatency` values.
- Backend application response times increase with no Application Gateway configuration change.
- The following portal message appears: `The request to the backend timed out`.

## Prerequisites

- **Permissions required**: `Network Contributor` role on the Application Gateway resource group or equivalent (`Microsoft.Network/applicationGateways/read`).
- **Tools**: Azure CLI 2.x, Azure PowerShell 9.x, or an AI agent with Azure MCP Server.
- **The following table lists variables used in the commands**:

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |

> [!TIP]
> Before running any commands, verify all the variables listed in the previous table. Additional variables (like Log Analytics workspace ID, backend resource IDs, subnet IDs) are discovered during the diagnostic steps. You don't need them to start.

## Diagnostic steps

> [!NOTE]
> These steps are read-only. No changes are made to your environment.

### Step 1a: Determine if the request timeout setting is appropriate for your backend application

This step checks the request timeout value in the HTTP settings. Application Gateway waits this many seconds for a response from the backend before returning 504 to the client.

Run the following command to check the `requestTimeout` value for each HTTP setting:

**Azure CLI**

```azurecli-interactive
az network application-gateway http-settings list \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, port:port, protocol:protocol, requestTimeout:requestTimeout}" \
  --output table
```

**Azure PowerShell**

```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.BackendHttpSettingsCollection |
  Select-Object Name, Port, Protocol, RequestTimeout |
  Format-Table -AutoSize
```

#### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `requestTimeout` is 20 seconds (default). | The default is appropriate for most web applications. 20 seconds is a long time for typical page loads and API calls. Only increase the time if the backend legitimately performs long-running operations (like report generation, file processing, and batch APIs). | Note the value as you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `requestTimeout` is set to 30–120 seconds and 504 errors still occur. | The backend is responding slower than an extended timeout usually allows. | Note the value as you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `requestTimeout` is very high (for example, greater than 300 seconds) and 504 errors still occur. | There are backend delays or network issues. Timeout isn't the problem. | Note the value as you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs).  |

### Step 1b: Check if Application Gateway access logs are enabled and where they're sent

This step checks which Log Analytics workspace receives Application Gateway access logs. You need this workspace ID to query logs in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs).

Run the following command to check diagnostic settings for the Application Gateway resource:

**Azure CLI**

```azurecli-interactive
az monitor diagnostic-settings list \
  --resource "/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.Network/applicationGateways/{RESOURCE_NAME}" \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, workspaceId:workspaceId, logs:logs[?category=='ApplicationGatewayAccessLog'].enabled}" \
  --output json
```

**Azure PowerShell**

```powershell
Get-AzDiagnosticSetting `
  -ResourceId "/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.Network/applicationGateways/{RESOURCE_NAME}"
```

| If you see... | Meaning | Next steps |
|---|---|---|
| `workspaceId` is populated and `ApplicationGatewayAccessLog` is `true`. | Access logs are enabled. Record the `workspaceId` value (this is an Azure Resource Manager (ARM) resource ID) | Note the value as you'll use it in [Step 2a - Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `ApplicationGatewayAccessLog` is `false` or missing. | Access logging isn't enabled. You can't query access logs until this is configured. | Enable access logs. See [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging) for more details. |
| No diagnostic settings found. | No diagnostics are configured. | Enable access logs. See [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging) for more details. |

The `workspaceId` returned is an ARM resource ID, but the `az monitor log-analytics query` command in [Step 2a - Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs) requires the **workspace GUID** (`customerId`). 

Run this command to get the GUID:

**Azure CLI**

```azurecli-interactive
az monitor log-analytics workspace show \
  --ids "{WORKSPACE_ARM_RESOURCE_ID}" \
  --query customerId \
  --output tsv
```

**Azure PowerShell**

```powershell
(Get-AzOperationalInsightsWorkspace | Where-Object ResourceId -eq "{WORKSPACE_ARM_RESOURCE_ID}").CustomerId
```

Record the returned GUID as `{LOG_ANALYTICS_WORKSPACE_ID}` in [Step 2a - Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs).

### Step 2a: Check backend response times for 504 errors in access logs

This step checks the actual time the backend takes to respond as recorded in Application Gateway access logs.

**Prerequisite** 

You must enable diagnostic settings and send the `ApplicationGatewayAccessLog` category to Log Analytics. If you don't have this configuration, see [Step 1b: Check if Application Gateway access logs are enabled and where they're sent](#step-1b-check-if-application-gateway-access-logs-are-enabled-and-where-theyre-sent). If you recently enabled diagnostic settings, it can take 15–20 minutes for log data to appear.

Run the following command to query the last 50 access log entries with HTTP 504 status codes, sorted by most recent:

**Azure CLI**

```azurecli-interactive
az monitor log-analytics query \
  --workspace {LOG_ANALYTICS_WORKSPACE_ID} \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' | where Resource == toupper('{RESOURCE_NAME}') | where httpStatus_d == 504 | project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s | order by TimeGenerated desc | take 50" \
  --timespan PT24H \
  --output json
```

**Azure PowerShell**

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

**KQL query (if running directly in Log Analytics portal)**

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

| If you see... | Meaning | Next steps |
|---|---|---|
| `serverResponseLatency_s` exceeds `requestTimeout` value from [Step 1a: Determine if the request timeout setting is appropriate for your backend application](#step-1a-determine-if-the-request-timeout-setting-is-appropriate-for-your-backend-application). | Backend is responding slower than the timeout allows. | See [Resolution 1: Increase request timeout](#resolution-1-increase-request-timeout) to increase  the timeout or [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk) to investigate the backend. |
| `serverResponseLatency_s` is consistently at a specific value (for example, exactly 20 seconds or 30 seconds) that is less than the `requestTimeout` setting. | The backend application itself has an internal timeout (for example, the web server `proxy_read_timeout`, PHP `max_execution_time`, or application-level request timeout) that's shorter than the Application Gateway timeout. The backend closes the connection at its own limit, causing Application Gateway to return 504 errors. | See [Step 2b: Check backend health probe status](#step-2b-check-backend-health-probe-status) to check backend health, then [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to investigate and fix the backend application's internal timeout configuration. |
| `serverResponseLatency_s` is near zero but `timeTaken_d` is high. | There's network delay between Application Gateway and the backend, or the backend dropped the connection. | See [Resolution 3: Fix network path](#resolution-3-fix-network-path) to check the network path. |
| 504 errors correlate with specific `requestUri_s` patterns. | Certain API endpoints or pages are slow. | See [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk) to investigate those specific backend endpoints. |
| No access log data found. | Access logging isn't enabled. | See [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging) for more details. |

### Step 2b: Check backend health probe status

This check verifies whether Application Gateway can successfully reach the backend servers and whether the health probes are passing. This check is one of the most fundamental diagnostics because a backend marked as **Unhealthy** causes all requests to fail.

Run this command to check the health status of backend servers as seen by Application Gateway:

**Azure CLI**

```azurecli-interactive
az network application-gateway show-backend-health \
  --name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "backendAddressPools[].backendHttpSettingsCollection[].servers[].{address:address, health:health, healthProbeLog:healthProbeLog}" \
  --output json
```

**Azure PowerShell**

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

> [!NOTE]
> This command might take 30–60 seconds to complete because it performs a live health probe against the backend.

#### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `health` is `Healthy` and probe returns a **200** status code. | The backend is reachable and responding to health probes. The issue is specific to request processing time, not availability. | See [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk) to check backend resource utilization. |
| `health` is `Unhealthy` with a probe timeout or connection refused. | Backend isn't responding to health probes. Requests fail with 502 or 504 errors. | Check that the backend application is running and listening on the correct port. Verify network security group (NSG) rules allow traffic from the Application Gateway subnet. |
| `health` is `Unhealthy` with a **non-200** status code. | Backend responds but with an error like 403 or 500. The health probe path might be misconfigured. | Verify the health probe path returns **200** on the backend. Check probe settings with `az network application-gateway probe list`. |
| Mixed results (some healthy, some unhealthy). | There's a partial backend failure and some instances are down. | Investigate the unhealthy instances specifically. |


### Step 3a: Check backend resource utilization (CPU, memory, disk)

This check verifies whether the backend VM or app service is under resource pressure (CPU, memory, disk IOPS) that indicates slow responses.

Run the following command to identify which backend servers are in the Application Gateway backend pool:

**Azure CLI**

```azurecli-interactive
az network application-gateway address-pool list \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "[].{name:name, backends:backendAddresses[].{ip:ipAddress, fqdn:fqdn}}" \
  --output json
```

**Azure PowerShell**

```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.BackendAddressPools |
  Select-Object Name, @{N='Backends';E={($_.BackendAddresses | ForEach-Object { $_.IpAddress ?? $_.Fqdn }) -join ', '}} |
  Format-Table -AutoSize
```

Record the backend IP addresses or fully qualified domain names (FQDNs) returned. If the backends are Azure virtual machines (VMs) in the same resource group as the Application Gateway, use `{RESOURCE_GROUP}` in [Step 3b: Check backend VM resource utilization metrics](#step-3b-check-backend-vm-resource-utilization-metrics). Otherwise, identify the resource group containing the backend resources.

#### Step 3b: Check backend VM resource utilization metrics

Run the following commands to check the resource utilization metrics for Azure VM backends:

**Azure CLI**

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

**Azure PowerShell**

```powershell
Get-AzMetric `
  -ResourceId "{BACKEND_VM_RESOURCE_ID}" `
  -MetricName "Percentage CPU", "Available Memory Bytes" `
  -TimeGrain 00:05:00 `
  -StartTime (Get-Date).AddHours(-2) `
  -EndTime (Get-Date)
```

#### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| CPU consistently above 90 percent (%). | The backend CPU is saturated and requests queue up. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to scale or optimize the backend. |
| Available memory is near zero. | Memory exhaustion. The backend might be swapping or encountering Out of Memory Killer (OOM Killer) processes in Linux.  | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to scale or optimize the backend. |
| Disk IOPS at or near the VM SKU limit. | Disk throughput is bottlenecked. This condition is common with Standard HDD or undersized disks. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to upgrade the disk tier or VM SKU. |
| All metrics are within normal range. | The backend infrastructure is healthy. Investigate application-level performance. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to profile the application. |

## Decision map

Use the following decision map table to determine which resolution path to take based on the diagnostic results from the previous steps:

| Diagnostic result | Next action |
|---|---|
| The request timeout is too low for backend processing time. | See [Resolution 1: Increase request timeout](#resolution-1-increase-request-timeout). |
| The backend application has its own internal timeout shorter than Application Gateway timeout. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to fix backend app timeout configuration. |
| The backend health probe is unhealthy. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to verify the backend application is running, check NSG rules, and verify the probe path. |
| The backend CPU, memory, or disk is exhausted. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| There is a network delay between Application Gateway and backend. | See [Resolution 3: Fix network path](#resolution-3-fix-network-path). |
| Access logging isn't enabled (can't diagnose). | See [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging). |
| All diagnostics pass and 504 errors still occur. | File an Azure support request. |

## Resolution 1: Increase request timeout

The Application Gateway request timeout (default 20 seconds) is shorter than the backend's response time.

### Step 1: Increase the request timeout in HTTP settings

> [!IMPORTANT]
> The following commands are write operations and require customer approval before running.

> [!TIP]
> Review the following command and understand what it does before running. Set the request timeout to accommodate your backend's expected response time with a reasonable margin.

Run the following commands to update the `requestTimeout` value for the relevant HTTP settings:

**Azure CLI**

```azurecli-interactive
az network application-gateway http-settings update \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {HTTP_SETTINGS_NAME} \
  --timeout 60
```

**Azure PowerShell**

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

> [!NOTE]
> The maximum request timeout is 86,400 seconds (24 hours). Typical values for web applications are 30–120 seconds. Setting this value to a greater timeout value doesn't fix the root cause. It only masks slow backend responses.

### Step 2: Monitor access logs

Monitor access logs after the change. `serverResponseLatency_s` should now be within the new timeout and 504 errors should stop for requests where the backend responds within the new threshold.

If 504s persist with the increased timeout, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend) to address backend performance.

---

## Resolution 2: Scale or optimize backend

The backend server can't process requests within the timeout due to resource constraints or application-level performance issues.

> [!IMPORTANT]
> The following commands are write operations and require customer approval before running.

Run the following commands to check backend health and resource utilization:

### Step 1: Resize VM SKU

Use Azure CLI to run the following command to resize to a larger SKU:

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

### Step 2: Add more backend instances

> [!IMPORTANT]
> The following commands are write operations and require customer approval before running.

Use Azure CLI to add additional backend servers to the Application Gateway backend pool to distribute the load:

```azurecli-interactive
az network application-gateway address-pool update \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {BACKEND_POOL_NAME} \
  --servers {EXISTING_BACKENDS} {NEW_BACKEND_IP_OR_FQDN}
```

### Step 3: Optimize application performance

If backend infrastructure metrics are healthy but responses are slow, the problem is at the application level. Perform the following optimizations:

- Profile the slow API endpoints to identify bottlenecks (like database queries, external service calls, and CPU-intensive processing).
- Enable Application Insights on the backend to trace slow requests.
- Implement caching for larger operations.
- Review connection pooling settings for database connections.

## Resolution 3: Fix network path

Network delay or packet loss exists between Application Gateway and the backend, causing responses to arrive after the timeout.

### Discover Application Gateway subnet ID

Run the following command to get the subnet ID of the Application Gateway:

**Azure CLI**

```azurecli-interactive
az network application-gateway show \
  --name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --query "gatewayIPConfigurations[0].subnet.id" \
  --output tsv
```

**Azure PowerShell**

```powershell
$gw = Get-AzApplicationGateway `
  -Name "{RESOURCE_NAME}" `
  -ResourceGroupName "{RESOURCE_GROUP}"

$gw.GatewayIPConfigurations[0].Subnet.Id
```

Record the returned value as `{APPGW_SUBNET_ID}`. Then use Azure CLI to check for route tables and NSGs:

**Azure CLI (read-only)**

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

#### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| There's no route table or only default routes. | The network path is direct. There's no latency caused by routing. | Check backend application performance. |
| NVA routing to the backend subnet. | The traffic is traversing a firewall or NVA and adds latency. | Verify NVA capacity and whether it's a bottleneck. |

## Resolution 4: Enable diagnostic logging

You can't diagnose 504 errors without access log data.

### Enable Application Gateway access logs to Log Analytics

> [!IMPORTANT]
> The following command is a write operation and requires customer approval before running.

Use Azure CLI to enable Application Gateway access logs and send them to a Log Analytics workspace:

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

After enabling, wait for traffic to flow through the gateway (15–30 minutes) then run [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs) again.

## References

- [Application Gateway health monitoring overview](/azure/application-gateway/application-gateway-probe-overview)
- [Application Gateway HTTP settings configuration](/azure/application-gateway/configuration-http-settings)
- [Backend health and diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics)
- [Troubleshoot Application Gateway with Azure Monitor](/azure/application-gateway/log-analytics)
- [Connection draining for Application Gateway](/azure/application-gateway/configuration-http-settings#connection-draining)
