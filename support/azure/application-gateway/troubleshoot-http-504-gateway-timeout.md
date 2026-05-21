---
title: Troubleshoot HTTP 504 Gateway timeout errors in Azure Application Gateway
description: Diagnose and fix HTTP 504 Gateway timeout errors in Azure Application Gateway. Check backend response times, health probes, and network latency to resolve timeouts.
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

# Troubleshoot HTTP 504 Gateway timeout errors in Azure Application Gateway

## Summary

"HTTP 504" timeout errors from Microsoft Azure Application Gateway occur if the back-end server doesn't respond within the configured request timeout threshold. The most common causes include:

- back-end application processing time that exceeds the timeout setting
- back-end resource exhaustion (high CPU, memory, or disk input/output operations per second (IOPS))
- Network-level delays between Application Gateway and the backend

## Symptoms

Common symptoms include:

- Application Gateway returns "HTTP 504" responses to clients.
- Intermittent timeouts that correlate to traffic spikes or specific API endpoints.
- Application Gateway access logs show high `serverResponseLatency` values.
- back-end application response times increase without any Application Gateway configuration change.
- The following portal message appears: `The request to the backend timed out`.

## Prerequisites

- **Permissions required**: `Network Contributor` role on the Application Gateway resource group or equivalent (`Microsoft.Network/applicationGateways/read`)
- **Tools**: Azure CLI 2._x_, Azure PowerShell 9._x_, or an AI agent with Azure MCP Server

### Command variables

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |

> [!TIP]
> Before you run any commands, verify all the variables that are listed in the table. Additional variables (such as Log Analytics workspace ID, back-end resource IDs, subnet IDs) are discovered during the diagnostic steps. You don't need them to start.

## Diagnostic steps

> [!NOTE]
> These steps are read-only. No changes are made to your environment.

### Step 1a: Determine the appropriate request timeout setting

This step determine whether the request timeout setting is appropriate for your back-end application. Application Gateway waits this many seconds for a response from the backend before it returns "504" to the client.

To check the `requestTimeout` value for each HTTP setting, run the following command, as appropriate.

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
| `requestTimeout` is 20 seconds (default). | The default is appropriate for most web applications. 20 seconds is a long time for typical page loads and API calls. Increase the time only if the backend legitimately performs long-running operations (such as report generation, file processing, and batch APIs). | Note the value because you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `requestTimeout` is set to 30–120 seconds, and "504" errors still occur. | The backend is responding slower than an extended timeout usually allows. | Note the value because you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `requestTimeout` is very high (for example, greater than 300 seconds), and "504" errors still occur. | Backend delays or network issues are occurring. Timeout isn't the problem. | Note the value because you'll use it in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs).  |

### Step 1b: Check Application Gateway access logs status and target

This step checks which Log Analytics workspace receives Application Gateway access logs. You need this workspace ID to query logs in [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs).

To check diagnostic settings for the Application Gateway resource, run the following command, as appropriate.

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
| `workspaceId` is populated, and `ApplicationGatewayAccessLog` is `true`. | Access logs are enabled. Record the `workspaceId` value (this value is an Azure Resource Manager (ARM) resource ID) | Note the value because you'll use it in [Step 2a - Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs). |
| `ApplicationGatewayAccessLog` is `false` or missing. | Access logging isn't enabled. You can't query access logs until this setting is configured. | Enable access logs. For more information, see [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging). |
| No diagnostic settings found. | No diagnostics are configured. | Enable access logs. For more information, see [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging). |

The `workspaceId` that's returned is an ARM resource ID, but the `az monitor log-analytics query` command in [Step 2a - Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs) requires the **workspace GUID** (`customerId`). 

To get the GUID, run the following command, as appropriate.

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

This step checks the actual amount of time that the backend takes to respond, as recorded in Application Gateway access logs.

**Prerequisites** 

You must enable diagnostic settings and send the `ApplicationGatewayAccessLog` category to Log Analytics. If you don't have this configuration, see [Step 1b: Check Application Gateway access logs status and target](#step-1b-check-application-gateway-access-logs-status-and-target). If you recently enabled diagnostic settings, log data can take 15–20 minutes to appear.

To query the last 50 access log entries that have "HTTP 504" status codes (sorted by most recent), run the following command, as appropriate.

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
| `serverResponseLatency_s` exceeds `requestTimeout` value from [Step 1a: Determine whethr the request timeout setting is appropriate for your backend application](#step-1a-determine-whether-the-request-timeout-setting-is-appropriate-for-your-backend-application). | Backend is responding slower than the timeout allows. | To increase the timeout, see [Resolution 1: Increase request timeout](#resolution-1-increase-request-timeout). Or, to investigate the backend, see [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk). |
| `serverResponseLatency_s` is consistently at a specific value (for example, exactly 20 seconds or 30 seconds) that is less than the `requestTimeout` setting. | The back-end application itself has an internal timeout (for example, the web server `proxy_read_timeout`, PHP `max_execution_time`, or application-level request timeout) that's shorter than the Application Gateway timeout. The backend closes the connection at its own limit. This causes Application Gateway to return "504" errors. | To check backend health, see [Step 2b: Check backend health probe status](#step-2b-check-backend-health-probe-status). Then, to investigate and fix the back-end application's internal timeout configuration, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| `serverResponseLatency_s` is near zero but `timeTaken_d` is high. | Network delays occur between Application Gateway and the backend, or the backend dropped the connection. | To check the network path, see [Resolution 3: Fix network path](#resolution-3-fix-network-path). |
| 504 errors correlate with specific `requestUri_s` patterns. | Certain API endpoints or pages are slow. | To investigate those specific backend endpoints, see [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk). |
| No access log data found. | Access logging isn't enabled. | For more information, see [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging). |

### Step 2b: Check backend health probe status

This check verifies whether Application Gateway can successfully reach the back-end servers and whether the health probes are passing. This check is one of the most fundamental diagnostics because a backend that's marked as **Unhealthy** causes all requests to fail.

To check the health status of back-end servers as seen by Application Gateway, run the following command, as appropriate.

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
| `health` is `Healthy` and probe returns a **200** status code. | The backend is reachable and responding to health probes. The issue is specific to request processing time, not availability. | To check backend resource usage, see [Step 3a: Check backend resource utilization (CPU, memory, disk )](#step-3a-check-backend-resource-utilization-cpu-memory-disk). |
| `health` is `Unhealthy` with a probe timeout or connection refused. | Backend isn't responding to health probes. Requests fail with 502 or 504 errors. | Check that the back-end application is running and listening on the correct port. Verify network security group (NSG) rules allow traffic from the Application Gateway subnet. |
| `health` is `Unhealthy` with a **non-200** status code. | Backend responds but returns an error code such as "403" or "500." The health probe path might be misconfigured. | Verify that the health probe path returns **200** on the backend. Check probe settings by using `az network application-gateway probe list`. |
| Mixed results (some healthy, some unhealthy). | A partial backend failure exists, and some instances are down. | Investigate the unhealthy instances specifically. |

### Step 3a: Check backend resource utilization (CPU, memory, disk)

This check verifies whether the back-end VM or app service is under resource pressure (CPU, memory, disk IOPS) that indicates slow responses.

To identify which back-end servers are in the Application Gateway back-end pool, run the following command, as appropriate.

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

Record the back-end IP addresses or fully qualified domain names (FQDNs) that are returned. If the backends are Azure virtual machines (VMs) in the same resource group as the Application Gateway, use `{RESOURCE_GROUP}` in [Step 3b: Check backend VM resource utilization metrics](#step-3b-check-backend-vm-resource-utilization-metrics). Otherwise, identify the resource group that contains the back-end resources.

#### Step 3b: Check back-end VM resource usage metrics

To check the resource usage metrics for Azure VM backends, run the following commands, as appropriate.

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
| CPU consistently above 90 percent (%). | The back-end CPU is saturated, and requests queue up. | To scale or optimize the backend, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| Available memory is near zero. | Memory exhaustion. The backend might be swapping or encountering Out of Memory Killer (OOM Killer) processes in Linux.  | To scale or optimize the backend, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| Disk IOPS at or near the VM SKU limit. | Disk throughput is bottlenecked. This condition is common for Standard HDD or undersized disks. | To upgrade the disk tier or VM SKU, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| All metrics are within normal range. | The back-end infrastructure is healthy. Investigate application-level performance. | To profile the application, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |

## Decision map

Use the following decision map table to determine which resolution path to take, based on the diagnostic results from the previous steps.

| Diagnostic result | Next action |
|---|---|
| The request timeout is too low for backend processing time. | See [Resolution 1: Increase request timeout](#resolution-1-increase-request-timeout). |
| The back-end application has its own internal timeout that's shorter than the Application Gateway timeout. | To fix back-end application timeout configuration, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| The backend health probe is unhealthy. | To verify that the backend application is running, see [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). Then, check NSG rules, and verify the probe path. |
| The backend CPU, memory, or disk is exhausted. | See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend). |
| There is a network delay between Application Gateway and backend. | See [Resolution 3: Fix network path](#resolution-3-fix-network-path). |
| Access logging isn't enabled (can't diagnose). | See [Resolution 4: Enable diagnostic logging](#resolution-4-enable-diagnostic-logging). |
| All diagnostics pass but "504" errors still occur. | File an Azure support request. |

## Resolution 1: Increase request timeout

The Application Gateway request timeout (default 20 seconds) is shorter than the backend's response time.

### Step 1: Increase the request timeout in HTTP settings

> [!IMPORTANT]
> The following commands are write operations and require customer approval before they can be run.

> [!TIP]
> Review the following command, and understand what it does before you run it. Set the request timeout to accommodate your backend's expected response time by using a reasonable margin.

To update the `requestTimeout` value for the relevant HTTP settings, run the following command, as appropriate.

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
> The maximum request timeout is 86,400 seconds (24 hours). Typical values for web applications are 30–120 seconds. You won't fix the root cause of this problem by increasing this timeout value. A greater value only masks slow backend responses.

### Step 2: Monitor access logs

Monitor access logs after the change. `serverResponseLatency_s` should now be within the new timeout, and "504" errors should stop for requests in which the backend responds within the new threshold.

If "504" responses persist after the timeout value is increased, investigate backend performance. See [Resolution 2: Scale or optimize backend](#resolution-2-scale-or-optimize-backend).

---

## Resolution 2: Scale or optimize backend

The back-end server can't process requests within the timeout due to resource constraints or application-level performance issues.

> [!IMPORTANT]
> The following commands are write operations and require customer approval before they can be run.

To check backend health and resource usage, run the following command, as appropriate.

### Step 1: Resize VM SKU

To resize to a larger SKU, use Azure CLI to run the following command, as appropriate.

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
> The following commands are write operations and require customer approval before they can be run.

Use Azure CLI to add additional back-end servers to the Application Gateway back-end pool to distribute the load:

```azurecli-interactive
az network application-gateway address-pool update \
  --gateway-name {RESOURCE_NAME} \
  --resource-group {RESOURCE_GROUP} \
  --subscription {SUBSCRIPTION_ID} \
  --name {BACKEND_POOL_NAME} \
  --servers {EXISTING_BACKENDS} {NEW_BACKEND_IP_OR_FQDN}
```

### Step 3: Optimize application performance

If back-end infrastructure metrics are healthy but responses are slow, the problem is at the application level. Perform the following optimizations:

- Profile the slow API endpoints to identify bottlenecks (such as database queries, external service calls, and CPU-intensive processing).
- Enable Application Insights on the backend to trace slow requests.
- Implement caching for larger operations.
- Review connection pooling settings for database connections.

## Resolution 3: Fix network path

Network delay or packet loss exists between Application Gateway and the backend. This condition causes responses to arrive after the timeout.

### Discover Application Gateway subnet ID

To get the subnet ID of the Application Gateway, run the following command, as appropriate.

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

Record the returned value as `{APPGW_SUBNET_ID}`. Then, use Azure CLI to check for route tables and NSGs.

**Azure CLI (read-only)**

```azurecli-interactive
az network vnet subnet show \
  --ids {APPGW_SUBNET_ID} \
  --query "{routeTable:routeTable.id, nsg:networkSecurityGroup.id}" \
  --output json
```

If a route table exists, check for routes that redirect back-end traffic through a Network Virtual Appliance (NVA):

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
| No route table exists or only default routes exist. | The network path is direct. No latency is caused by routing. | Check back-end application performance. |
| NVA routing to the back-end subnet. | The traffic is traversing a firewall or NVA, and it adds latency. | Verify NVA capacity and whether it's a bottleneck. |

## Resolution 4: Enable diagnostic logging

You can't diagnose "504" errors without having access to log data.

### Enable Application Gateway access logs to Log Analytics

> [!IMPORTANT]
> The following command is a write operation. It requires customer approval before it can be run.

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

After you enable access, wait for traffic to flow through the gateway (15–30 minutes). Then, run [Step 2a: Check backend response times for 504 errors in access logs](#step-2a-check-backend-response-times-for-504-errors-in-access-logs) again.

## References

- [Application Gateway health monitoring overview](/azure/application-gateway/application-gateway-probe-overview)
- [Application Gateway HTTP settings configuration](/azure/application-gateway/configuration-http-settings)
- [Backend health and diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics)
- [Troubleshoot Application Gateway with Azure Monitor](/azure/application-gateway/log-analytics)
- [Connection draining for Application Gateway](/azure/application-gateway/configuration-http-settings#connection-draining)
