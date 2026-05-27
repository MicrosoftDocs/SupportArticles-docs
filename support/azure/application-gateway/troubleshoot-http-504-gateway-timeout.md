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

> **TIP:** Each script below prompts you for the required values interactively — just click **Try It** to open Cloud Shell and answer the prompts. Values are cached for the session, so you only enter them once. Additional variables (Log Analytics workspace ID, backend resource IDs, subnet IDs) are discovered during the diagnostic steps — you do not need them upfront.

---

## Diagnostic steps

> **These steps are read-only. No changes will be made to your environment.**

---

### Step 1

**What this checks:** The request timeout value in the HTTP settings. Application Gateway waits this many seconds for a response from the backend before returning 504 to the client.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway http-settings list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, port:port, protocol:protocol, requestTimeout:requestTimeout}" \
  --output table
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

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

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

Get-AzDiagnosticSetting `
  -ResourceId "/subscriptions/$Subscription/resourceGroups/$ResourceGroup/providers/Microsoft.Network/applicationGateways/$ResourceName"
```

| If you see... | Meaning | Next step |
|---|---|---|
| `workspaceId` is populated and `ApplicationGatewayAccessLog` is `true` | Access logs are flowing — record the `workspaceId` value (this is an ARM resource ID) | → Get the workspace GUID below, then → [Step 2](#step-2) |
| `ApplicationGatewayAccessLog` is `false` or missing | Access logging is not enabled — you cannot query access logs until this is configured | → [Resolution D](#resolution-d) — enable access logging first |
| No diagnostic settings found | No diagnostics configured at all | → [Resolution D](#resolution-d) |

> **Important:** The `workspaceId` returned above is an ARM resource ID, but the `az monitor log-analytics query` command in Step 2 requires the **workspace GUID** (`customerId`). Run this command to get the GUID:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_ARM_ID" ] && read -rp "Workspace ARM Resource ID (from above): " WORKSPACE_ARM_ID

LOG_ANALYTICS_WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --ids "$WORKSPACE_ARM_ID" \
  --query customerId \
  --output tsv)
echo "Workspace GUID: $LOG_ANALYTICS_WORKSPACE_ID"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $WorkspaceArmId) { $WorkspaceArmId = Read-Host "Workspace ARM Resource ID (from above)" }

$LogAnalyticsWorkspaceId = (Get-AzOperationalInsightsWorkspace | Where-Object ResourceId -eq $WorkspaceArmId).CustomerId
Write-Host "Workspace GUID: $LogAnalyticsWorkspaceId"
```

Record the returned GUID — it is cached as `$LOG_ANALYTICS_WORKSPACE_ID` (bash) or `$LogAnalyticsWorkspaceId` (PowerShell) for use in Step 2.

---

### Step 2

**What this checks:** The actual time the backend takes to respond, as recorded in Application Gateway access logs.

> **Prerequisite:** Diagnostic settings must be enabled and the `ApplicationGatewayAccessLog` category must be sent to Log Analytics. If not configured, see [Step 1b](#step-1b). If you recently enabled diagnostic settings, log data may take 15–20 minutes to appear.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:           " RESOURCE_NAME
[ -z "$LOG_ANALYTICS_WORKSPACE_ID" ] && read -rp "Log Analytics Workspace GUID: " LOG_ANALYTICS_WORKSPACE_ID

az monitor log-analytics query \
  --workspace "$LOG_ANALYTICS_WORKSPACE_ID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' | where Resource == toupper('$RESOURCE_NAME') | where httpStatus_d == 504 | project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s | order by TimeGenerated desc | take 50" \
  --timespan PT24H \
  --output json
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }
if (-not $LogAnalyticsWorkspaceId) { $LogAnalyticsWorkspaceId = Read-Host "Log Analytics Workspace GUID" }

$query = @"
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
| where Resource == toupper("$ResourceName")
| where httpStatus_d == 504
| project TimeGenerated, clientIP_s, requestUri_s, serverResponseLatency_s, timeTaken_d, backendPoolName_s, backendSettingName_s
| order by TimeGenerated desc
| take 50
"@
Invoke-AzOperationalInsightsQuery `
  -WorkspaceId $LogAnalyticsWorkspaceId `
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
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show-backend-health \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "backendAddressPools[].backendHttpSettingsCollection[].servers[].{address:address, health:health, healthProbeLog:healthProbeLog}" \
  --output json
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$health = Get-AzApplicationGatewayBackendHealth `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

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
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway address-pool list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, backends:backendAddresses[].{ip:ipAddress, fqdn:fqdn}}" \
  --output json
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

$gw.BackendAddressPools |
  Select-Object Name, @{N='Backends';E={($_.BackendAddresses | ForEach-Object { $_.IpAddress ?? $_.Fqdn }) -join ', '}} |
  Format-Table -AutoSize
```

Record the backend IP addresses or FQDNs returned. If the backends are Azure VMs in the same resource group as the Application Gateway, use `$RG` below. Otherwise, identify the resource group containing the backend resources.

#### Step 3b

For Azure VM backends

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$BACKEND_RG" ] && read -rp "Backend Resource Group:     " BACKEND_RG

az vm list \
  --resource-group "$BACKEND_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, vmSize:hardwareProfile.vmSize}" \
  --output table

# Save the chosen VM's full ARM Resource ID
[ -z "$BACKEND_VM_ID" ] && read -rp "Backend VM name (from above): " BACKEND_VM_NAME
BACKEND_VM_ID=$(az vm show \
  --name "$BACKEND_VM_NAME" \
  --resource-group "$BACKEND_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv)
echo "Using VM: $BACKEND_VM_ID"
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$BACKEND_VM_ID" ] && read -rp "Backend VM Resource ID:     " BACKEND_VM_ID

START_TIME=$(date -u -d '2 hours ago' '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || date -u -v-2H '+%Y-%m-%dT%H:%M:%SZ')
END_TIME=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

az monitor metrics list \
  --resource "$BACKEND_VM_ID" \
  --subscription "$SUBSCRIPTION" \
  --metric "Percentage CPU" "Available Memory Bytes" "Disk Read Operations/Sec" "Disk Write Operations/Sec" \
  --interval PT5M \
  --start-time "$START_TIME" \
  --end-time "$END_TIME" \
  --output table
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $BackendResourceGroup) { $BackendResourceGroup = Read-Host "Backend Resource Group" }

# List VMs and auto-select if only one exists; otherwise prompt
if (-not $BackendVmResourceId) {
  $vms = Get-AzVM -ResourceGroupName $BackendResourceGroup
  if ($vms.Count -eq 1) {
    $BackendVmResourceId = $vms[0].Id
    Write-Host "Using VM: $($vms[0].Name)"
  } else {
    $vms | Select-Object Name, @{N='VmSize';E={$_.HardwareProfile.VmSize}} | Format-Table
    $vmName = Read-Host "Backend VM name (from above)"
    $BackendVmResourceId = ($vms | Where-Object Name -eq $vmName).Id
  }
}
```

```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $BackendVmResourceId) { $BackendVmResourceId = Read-Host "Backend VM Resource ID" }

Get-AzMetric `
  -ResourceId $BackendVmResourceId `
  -MetricName "Percentage CPU", "Available Memory Bytes" `
  -TimeGrain 00:05:00 `
  -StartTime (Get-Date).AddHours(-2) `
  -EndTime (Get-Date) |
  ForEach-Object {
    Write-Host "`n── $($_.Name.Value) ($($_.Unit)) ──"
    $_.Data | Format-Table TimeStamp, Average, Maximum -AutoSize
  }
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
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:      " RESOURCE_NAME

# Auto-select HTTP settings if only one exists; otherwise prompt (name visible from Step 1)
if [ -z "$HTTP_SETTINGS_NAME" ]; then
  HTTP_SETTINGS_NAME=$(az network application-gateway http-settings list \
    --gateway-name "$RESOURCE_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
    --query "[].name" --output tsv)
  if [ "$(echo "$HTTP_SETTINGS_NAME" | wc -l)" -gt 1 ]; then
    echo "Multiple HTTP settings found:"; echo "$HTTP_SETTINGS_NAME"
    read -rp "HTTP Settings Name (from above): " HTTP_SETTINGS_NAME
  else
    echo "Using HTTP settings: $HTTP_SETTINGS_NAME"
  fi
fi

read -rp "New timeout in seconds (default 60): " TIMEOUT; TIMEOUT=${TIMEOUT:-60}

az network application-gateway http-settings update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$HTTP_SETTINGS_NAME" \
  --timeout "$TIMEOUT"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

# Auto-select HTTP settings if only one exists; otherwise prompt (name visible from Step 1)
if (-not $HttpSettingsName) {
  $settingNames = @($gw.BackendHttpSettingsCollection.Name)
  if ($settingNames.Count -eq 1) {
    $HttpSettingsName = $settingNames[0]
    Write-Host "Using HTTP settings: $HttpSettingsName"
  } else {
    $gw.BackendHttpSettingsCollection | Select-Object Name, Port, Protocol, RequestTimeout | Format-Table
    $HttpSettingsName = Read-Host "HTTP Settings Name (from above)"
  }
}

$Timeout = Read-Host "New timeout in seconds (default 60)"
if (-not $Timeout) { $Timeout = 60 }

$settings = Get-AzApplicationGatewayBackendHttpSetting `
  -ApplicationGateway $gw `
  -Name $HttpSettingsName

Set-AzApplicationGatewayBackendHttpSetting `
  -ApplicationGateway $gw `
  -Name $HttpSettingsName `
  -Port $settings.Port `
  -Protocol $settings.Protocol `
  -CookieBasedAffinity $settings.CookieBasedAffinity `
  -RequestTimeout $Timeout

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

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$BACKEND_RG" ] && read -rp "Backend Resource Group:     " BACKEND_RG
[ -z "$BACKEND_VM_NAME" ] && read -rp "Backend VM Name:            " BACKEND_VM_NAME
read -rp "New VM size (default Standard_D4s_v5): " VM_SIZE; VM_SIZE=${VM_SIZE:-Standard_D4s_v5}

az vm resize \
  --resource-group "$BACKEND_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_VM_NAME" \
  --size "$VM_SIZE"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $BackendResourceGroup) { $BackendResourceGroup = Read-Host "Backend Resource Group" }
if (-not $BackendVmName) { $BackendVmName = Read-Host "Backend VM Name" }
$VmSize = Read-Host "New VM size (default Standard_D4s_v5)"
if (-not $VmSize) { $VmSize = "Standard_D4s_v5" }

$vm = Get-AzVM -ResourceGroupName $BackendResourceGroup -Name $BackendVmName
$vm.HardwareProfile.VmSize = $VmSize
Update-AzVM -ResourceGroupName $BackendResourceGroup -VM $vm
```

For App Service backends, scale up the App Service Plan:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$BACKEND_RG" ] && read -rp "Backend Resource Group:     " BACKEND_RG
[ -z "$APP_SERVICE_PLAN" ] && read -rp "App Service Plan Name:      " APP_SERVICE_PLAN
read -rp "New SKU (default P2v3): " SKU; SKU=${SKU:-P2v3}

az appservice plan update \
  --resource-group "$BACKEND_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$APP_SERVICE_PLAN" \
  --sku "$SKU"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $BackendResourceGroup) { $BackendResourceGroup = Read-Host "Backend Resource Group" }
if (-not $AppServicePlanName) { $AppServicePlanName = Read-Host "App Service Plan Name" }
$Sku = Read-Host "New SKU (default P2v3)"
if (-not $Sku) { $Sku = "P2v3" }

Set-AzAppServicePlan `
  -ResourceGroupName $BackendResourceGroup `
  -Name $AppServicePlanName `
  -Tier $Sku
```

### B.2

> **⚠️ WRITE OPERATION — requires customer approval before executing**

Add additional backend servers to the Application Gateway backend pool to distribute load:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:      " RESOURCE_NAME

# Auto-select backend pool if only one exists; otherwise prompt (name visible from Step 3a)
if [ -z "$BACKEND_POOL_NAME" ]; then
  BACKEND_POOL_NAME=$(az network application-gateway address-pool list \
    --gateway-name "$RESOURCE_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
    --query "[].name" --output tsv)
  if [ "$(echo "$BACKEND_POOL_NAME" | wc -l)" -gt 1 ]; then
    echo "Multiple backend pools found:"; echo "$BACKEND_POOL_NAME"
    read -rp "Backend Pool Name (from above): " BACKEND_POOL_NAME
  else
    echo "Using backend pool: $BACKEND_POOL_NAME"
  fi
fi

read -rp "Include all backend IPs/FQDNs you want in this pool (space-separated, include existing + new): " SERVERS

az network application-gateway address-pool update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_POOL_NAME" \
  --servers $SERVERS
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

# Auto-select backend pool if only one exists; otherwise prompt (name visible from Step 3a)
if (-not $BackendPoolName) {
  $poolNames = @($gw.BackendAddressPools.Name)
  if ($poolNames.Count -eq 1) {
    $BackendPoolName = $poolNames[0]
    Write-Host "Using backend pool: $BackendPoolName"
  } else {
    $gw.BackendAddressPools | Select-Object Name, @{N='Backends';E={($_.BackendAddresses | ForEach-Object { $_.IpAddress ?? $_.Fqdn }) -join ', '}} | Format-Table
    $BackendPoolName = Read-Host "Backend Pool Name (from above)"
  }
}

$Servers = (Read-Host "Backend IPs/FQDNs (space-separated, include existing + new)") -split '\s+'

Set-AzApplicationGatewayBackendAddressPool `
  -ApplicationGateway $gw `
  -Name $BackendPoolName `
  -BackendIPAddresses $Servers

Set-AzApplicationGateway -ApplicationGateway $gw
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
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

APPGW_SUBNET_ID=$(az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "gatewayIPConfigurations[0].subnet.id" \
  --output tsv)
echo "Subnet ID: $APPGW_SUBNET_ID"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name $ResourceName `
  -ResourceGroupName $ResourceGroup

$AppGwSubnetId = $gw.GatewayIPConfigurations[0].Subnet.Id
Write-Host "Subnet ID: $AppGwSubnetId"
```

The subnet ID is now cached as `$APPGW_SUBNET_ID` (bash) or `$AppGwSubnetId` (PowerShell). Check for route tables and NSGs:

**Azure CLI (read-only):**
```azurecli-interactive
# Uses $APPGW_SUBNET_ID from the previous command
az network vnet subnet show \
  --ids "$APPGW_SUBNET_ID" \
  --query "{routeTable:routeTable.id, nsg:networkSecurityGroup.id}" \
  --output json
```

**Azure PowerShell (read-only):**
```powershell
# Uses $AppGwSubnetId from the previous command — parse to get VNet/subnet names
$parts = $AppGwSubnetId -split '/'
$vnetRg = $parts[4]; $vnetName = $parts[8]; $subnetName = $parts[10]

$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $vnetRg
$subnet = $vnet.Subnets | Where-Object { $_.Name -eq $subnetName }
[PSCustomObject]@{
  RouteTable = $subnet.RouteTable.Id
  NSG        = $subnet.NetworkSecurityGroup.Id
} | Format-List
```

If a route table exists, check for routes that redirect backend traffic through a Network Virtual Appliance (NVA):

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$ROUTE_TABLE_NAME" ] && read -rp "Route Table Name:      " ROUTE_TABLE_NAME

az network route-table route list \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $RouteTableName) { $RouteTableName = Read-Host "Route Table Name" }

$rt = Get-AzRouteTable -ResourceGroupName $ResourceGroup -Name $RouteTableName
$rt.Routes | Select-Object Name, AddressPrefix, NextHopType, NextHopIpAddress | Format-Table
```

| If you see... | Meaning | Next step |
|---|---|---|
| No route table or only default routes | Network path is direct — latency not caused by routing | Check backend application performance |
| Route to backend subnet via NVA | Traffic traverses a firewall/NVA — adds latency | Verify NVA capacity and whether it's a bottleneck |

---

## Resolution D

**Root cause:** Cannot diagnose 504 errors without access log data.

First, identify the Log Analytics workspace to send logs to:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

# List available Log Analytics workspaces
az monitor log-analytics workspace list \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, resourceGroup:resourceGroup, id:id}" \
  --output table

# Save the chosen workspace ARM Resource ID
[ -z "$WORKSPACE_ARM_ID" ] && read -rp "Workspace name (from above): " WORKSPACE_NAME
WORKSPACE_ARM_ID=$(az monitor log-analytics workspace list \
  --subscription "$SUBSCRIPTION" \
  --query "[?name=='$WORKSPACE_NAME'].id" \
  --output tsv)
echo "Using workspace: $WORKSPACE_ARM_ID"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }

# List available Log Analytics workspaces
$workspaces = Get-AzOperationalInsightsWorkspace
$workspaces | Select-Object Name, ResourceGroupName, ResourceId | Format-Table

# Save the chosen workspace ARM Resource ID
if (-not $WorkspaceArmId) {
    $WorkspaceName = Read-Host "Workspace name (from above)"
    $WorkspaceArmId = ($workspaces | Where-Object Name -eq $WorkspaceName).ResourceId
}
Write-Host "Using workspace: $WorkspaceArmId"
```

Then enable diagnostic logging:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:                  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:                   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:                 " RESOURCE_NAME

az monitor diagnostic-settings create \
  --resource "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --resource-type Microsoft.Network/applicationGateways \
  --subscription "$SUBSCRIPTION" \
  --name appgw-diagnostics \
  --workspace "$WORKSPACE_ARM_ID" \
  --logs "[{\"category\":\"ApplicationGatewayAccessLog\",\"enabled\":true},{\"category\":\"ApplicationGatewayPerformanceLog\",\"enabled\":true}]"
```

**Azure PowerShell:**
```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gatewayId = (Get-AzApplicationGateway -Name $ResourceName -ResourceGroupName $ResourceGroup).Id

$accessLog = New-AzDiagnosticSettingLogSettingsObject -Category "ApplicationGatewayAccessLog" -Enabled $true
$perfLog = New-AzDiagnosticSettingLogSettingsObject -Category "ApplicationGatewayPerformanceLog" -Enabled $true

New-AzDiagnosticSetting -Name "appgw-diagnostics" `
  -ResourceId $gatewayId `
  -WorkspaceId $WorkspaceArmId `
  -Log @($accessLog, $perfLog)
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
