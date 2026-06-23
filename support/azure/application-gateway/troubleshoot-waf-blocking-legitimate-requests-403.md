---
title: Troubleshoot WAF blocking legitimate requests (HTTP "403" Forbidden errors) in Azure Application Gateway
description: Diagnose and fix Azure Application Gateway WAF false positives that cause HTTP "403" Forbidden errors. Follow the steps to restore traffic now.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.custom: sap:Facing 4xx errors
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - "403"-forbidden
  - waf-block
  - false-positive
  - waf-rule
  - waf-exclusion
  - sqli-false-positive
  - xss-false-positive
  - anomaly-score
  - managed-rule-override
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/read
  - Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/write
  - Microsoft.OperationalInsights/workspaces/query/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - LA_WORKSPACE_GUID
  - LA_WORKSPACE_RESOURCE_ID
---

# Troubleshoot WAF blocking legitimate requests (HTTP "403" Forbidden errors) in Azure Application Gateway

## Summary

This article provides a step-by-step diagnostic process to identify why Azure Application Gateway's Web Application Firewall (WAF) in Prevention mode is blocking legitimate requests and generating HTTP `"403" Forbidden` errors.

Azure Application Gateway WAF in Prevention mode can block legitimate requests by using HTTP `"403" Forbidden` errors when managed rules incorrectly match benign content such as form inputs, JSON payloads, or cookie values. 

The most common root causes are: 

- SQL injection rules that trigger on sign-in form fields or query parameters that contain SQL-like syntax. 
- Cross-site scripting rules that match JSON API payloads or HTML content in request bodies. 
- Anomaly-scoring thresholds that are exceeded by cookie values or complex request headers.

## Symptoms

You encounter one or more of the following symptoms:

- Application Gateway returns HTTP `"403" Forbidden` responses for requests that should be allowed.
- The response body contains `Microsoft-Azure-Application-Gateway/v2` and a WAF block reference or transaction ID.
- Specific API endpoints return HTTP `"403" Forbidden` responses while others work normally through the same Application Gateway.
- Sign-in form submissions fail and return HTTP `"403" Forbidden` responses after you enter certain characters (for example, `'`, `--`, `<script>`, or `SELECT`).
- JSON API POST and PUT requests fail and return HTTP `"403" Forbidden` responses if the payload contains HTML fragments, angle brackets, or SQL-like keywords.
- HTTP `"403" Forbidden` errors occur intermittently and only when specific users, cookies, or request patterns are involved.
- WAF diagnostic logs show `action_s == "Blocked"` entries that correlate with the failing requests.
- Application Gateway worked before enabling WAF in Prevention mode or after you upgrade the managed rule set version.
- The following error message is recorded in WAF logs for core rule set rules: `Mandatory rule. Cannot be disabled.`

## Prerequisites

To troubleshoot WAF blocking legitimate requests, you need the following items:

- **Permissions required**: `Network Contributor` role on the Application Gateway resource group, or equivalent read/write access to WAF policies (`Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/*`)
- **Tools**: Azure CLI 2.x, Azure PowerShell 9.x, or an AI agent with Azure MCP access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |
| `{LA_WORKSPACE_GUID}` | Log Analytics workspace customer ID (GUID), used by `az monitor log-analytics query` in [Step 2](#step-2), [Step 3a](#step-3a), and [Step 3b](#step-3b) | `yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy` |
| `{LA_WORKSPACE_RESOURCE_ID}` | Log Analytics workspace full Azure Resource Manager (ARM) resource ID (or workspace name), used by `az monitor diagnostic-settings create` in [Resolution E](#resolution-e). | `/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/myWorkspace` |

> [!TIP]
> Verify all variables before you run any commands. If the Log Analytics workspace ID is unknown, discover it in [Step 1b](#step-1b).

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether WAF is active, which mode it's in (Prevention versus Detection), and which managed rule set is in use. This check confirms that WAF is the component that produces the "403" errors. 

1. Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{sku:sku.tier, firewallPolicy:firewallPolicy.id}" \
  --output json
```

2. Record the `firewallPolicy.id` and extract the policy name from the resource ID. This name is `{WAF_POLICY_NAME}`.
3. Retrieve the WAF policy details by using Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy show \
  --name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

$gw = Get-AzApplicationGateway `
  -Name "$ResourceName" `
  -ResourceGroupName "$ResourceGroup"
$policyId = $gw.FirewallPolicy.Id
$policyName = ($policyId -split '/')[-1]

Get-AzApplicationGatewayFirewallPolicy `
  -Name $policyName `
  -ResourceGroupName "$ResourceGroup"
```

### Interpret the results

| Observation | Meaning | Next step |
|---|---|---|
| `"policySettings.mode": "Prevention"` | WAF is actively blocking requests. This result confirms that WAF can produce "403" errors. | Perform [Step 2]#step-2). |
| `"policySettings.mode": "Detection"` | WAF logs matches but isn't blocking requests. The "403" errors come from somewhere else (such as the backend, custom rules, or another component). | Investigate back-end application or custom rules directly. This guide might not apply. |
| `firewallPolicy` is `null` | No WAF policy is associated. Application Gateway isn't running WAF, and the "403" errors come from the backend. | Check back-end application logs for the source of the errors. |
| `sku.tier` is `Standard` or `Standard_v2` (not `WAF` or `WAF_v2`). | Application Gateway SKU doesn't support WAF. | The "403" errors aren't from WAF. Check the back-end application logs. |
| `"managedRules.managedRuleSets"` shows `OWASP` version `3.2` or `3.1` | This value records which rule set version is active and is needed to interpret rule IDs in later steps. | Perform [Step 2](#step-2). |
| `"managedRules.managedRuleSets"` shows `Microsoft_DefaultRuleSet` version `2.1`. | You're using the Azure-managed Default Rule Set (DRS). | Perform [Step 2](#step-2). |

### Step 1b

Check which Log Analytics workspace receives WAF diagnostic logs by using Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az monitor diagnostic-settings list \
  --resource "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, workspaceId:workspaceId, logs:logs[?category=='ApplicationGatewayFirewallLog'].enabled}" \
  --output json
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }

Get-AzDiagnosticSetting `
  -ResourceId "/subscriptions/$Subscription/resourceGroups/$ResourceGroup/providers/Microsoft.Network/applicationGateways/$ResourceName"
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `workspaceId` is populated and `ApplicationGatewayFirewallLog` is `true`. | WAF firewall logs flow to this workspace. Record the full ARM resource ID that's shown in `workspaceId` as `{LA_WORKSPACE_RESOURCE_ID}` (used in [Resolution E](#resolution-e)). The log-query steps need the workspace customer ID (GUID) as `{LA_WORKSPACE_GUID}`, as shown on the workspace's **Overview** page in the [Azure portal](https://portal.azure.com).  | Perform [Step 2](#step-2). |
| `ApplicationGatewayFirewallLog` is `false` or missing. | WAF firewall logging isn't enabled. You can't query WAF logs until you configure this setting. | Perform [Resolution E](#resolution-e) to enable diagnostic logging first. |
| No diagnostic settings found. | No diagnostics configured at all. | Perform [Resolution E](#resolution-e). |

### Step 2

Check the specific WAF log entries to see which requests were blocked, which rule triggered the block, and what part of the request matched.

> [!IMPORTANT]
> You must enable diagnostic settings on the Application Gateway, and send the `ApplicationGatewayFirewallLog` category to Log Analytics. If you didn't configure these settings, see [Step 1b](#step-1b).

> [!NOTE]
> If you recently enabled diagnostic settings on a new Log Analytics workspace, WAF log data might take 15–20 minutes to appear. If the query returns empty results, wait and retry.

Run the following commands in Azure CLI or Azure PowerShell:

**Azure CLI:**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s in ('Matched','Blocked') | project TimeGenerated, clientIp_s, requestUri_s, ruleId_s, action_s, ruleSetType_s, ruleGroup_s, Message, details_message_s, details_data_s, hostname_s | order by TimeGenerated desc | take 50" \
  --timespan PT24H \
  --output json
```

**Azure PowerShell:**
```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $WorkspaceId) { $WorkspaceId = Read-Host "Log Analytics Workspace ID" }

$query = @"
AzureDiagnostics
| where ResourceType == 'APPLICATIONGATEWAYS'
    and Category == 'ApplicationGatewayFirewallLog'
    and action_s in ('Matched','Blocked')
| project TimeGenerated, clientIp_s, requestUri_s, ruleId_s, action_s, ruleSetType_s,
    ruleGroup_s, Message, details_message_s, details_data_s, hostname_s
| order by TimeGenerated desc
| take 50
"@
Invoke-AzOperationalInsightsQuery `
  -WorkspaceId "$WorkspaceId" `
  -Query $query `
  -Timespan (New-TimeSpan -Hours 24)
```

### Interpret the results

From the output, record the following information for each blocked request that matches the customer's reported issue:

- **`ruleId_s`**: The managed rule ID that triggered the block (for example, `942100`, `941100`, `949110`).
- **`ruleGroup_s`**: The rule group (for example, `REQUEST-942-APPLICATION-ATTACK-SQLI`).
- **`Message`**: Human-readable description of what the rule detected.
- **`details_message_s`**: The rule description only (for example, `Detect Sql Injection at ARGS.`).
- **`details_data_s`**: The matched content (including the field) in the `[COLLECTION:selector:value]` form (for example, `{s&1c found within [ARGS:password:...]}`).
- **`requestUri_s`**: The Uniform Resource Identifier (URI) that was blocked.
- **`clientIp_s`**: Source IP of the blocked request.

In OWASP Core Rule Set (CRS) (anomaly-scoring) mode, the only `action_s == 'Blocked'` row is the aggregator rule `949110` (rule group `REQUEST-949-BLOCKING-EVALUATION`). Its `details_data_s` is empty and its `details_message_s` reads `Greater and Equal to Tx:inbound_anomaly_score_threshold at TX:anomaly_score.` It carries no field to exclude. 

The rules that matched the request (the `942xxx`, `941xxx`, and `920xxx` rows that the following table lists routes for) are logged as `action_s == 'Matched'`. This situation is why the previous query filters `action_s in ('Matched','Blocked')`. To find the real rule IDs and matched fields behind a `949110` block, examine the `Matched` rows that share the same `TimeGenerated` or transaction as the `949110` block.

> [!NOTE]
> In the WAF log schema, `ruleSetType_s` is reported as `OWASP CRS` (having a space) even though the policy resource reports `OWASP`. This condition matters only if you add a filter on `ruleSetType_s`.

| Observation | Meaning | Next step |
|---|---|---|
| Blocked entries with `ruleId_s` in the `942xxx` range (for example, `942100`, `942110`, `942130`, `942430`). | SQL injection rules triggered. There are common false positives on sign-in forms, search fields, or query parameters containing SQL-like syntax. | Perform [Step 3a](#step-3a). |
| Blocked entries with `ruleId_s` in the `941xxx` range (for example, `941100`, `941110`, `941130`, `941160`). | Cross-Site Scripting (XSS) rules are triggered. There are common false positives on JSON payloads, rich text, or HTML content in request bodies. | Perform [Step 3a](#step-3a). |
| Blocked entries with `ruleId_s` with values of `949110` or `980130` (anomaly scoring). | Inbound anomaly score exceeds the threshold. Multiple rules matched, and their combined score triggered the block. **Important**: This situation is an aggregation rule, not a root cause. Query for `action_s == 'Matched'` or `'Detected'` entries at the same timestamp to find the underlying rules that contributed to the score. | Perform [Step 3a](#step-3a). |
| Blocked entries with `ruleId_s` in the `920xxx` range (for example, `920350`). | Protocol enforcement rules are active and the request violates HTTP protocol constraints. The common false positive rule `920350` triggers when the `Host` header contains an IP address instead of a hostname (for example, `Host: 10.0.1.5`). This rule contributes to anomaly scores alongside other matches. | Perform [Step 3a](#step-3a). |
| No blocked entries found in the time range. | WAF didn't block any requests in this period. The "403" errors might come from the back-end application or a custom rule. | Expand `--timespan` to `PT72H` or check if you can reproduce the issue now. |
| Error: `BadArgumentError` or `workspace not found`. | Workspace ID is incorrect or the query permissions are insufficient. | Verify `{LA_WORKSPACE_GUID}` (the customer-ID GUID, not the ARM resource ID) and permissions. |

### Step 3a

Get a detailed breakdown of the specific rule, what part of the request it matched against (argument, header, cookie, or body), and the matched content to determine if it's a false positive.

Run the following commands in Azure CLI. Use the `{RULE_ID}` from the [Step 2](#step-2) results and query for detailed match information:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID:                " RULE_ID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s in ('Matched','Blocked') and ruleId_s == '$RULE_ID' | project TimeGenerated, requestUri_s, ruleId_s, action_s, ruleGroup_s, Message, details_message_s, details_data_s, details_file_s, details_line_s | take 10" \
  --timespan PT24H \
  --output json
```

### Interpret the results

Examine the `details_data_s` field. It carries the matched field in the `[COLLECTION:selector:value]` form (for example `{s&1c found within [ARGS:password:...]}`). The `details_message_s` field holds only the rule description (for example, `Detect Sql Injection at ARGS.`), so focus your interpretation on `details_data_s`.

| `details_data_s` pattern | What part of the request matched | Common false positive scenario |
|---|---|---|
| `found within [ARGS:username...]` or `[ARGS:password...]`. | A query parameter or form field value. | A sign-in form with `'` or `--` in the password field triggers a SQLi rule. |
| `found within [ARGS:<name>...]` for a JSON body field. | The POST and PUT request body content (OWASP CRS surfaces JSON body fields as `ARGS:<name>`). | The JSON API has a payload with `<script>` or SQL keywords in text fields. |
| `found within [REQUEST_COOKIES:<name>...]`. | A cookie value. | A session or application cookie with encoded characters triggers anomaly scoring. |
| `found within [REQUEST_HEADERS:Content-Type...]`. | A request header value. | A nonstandard content-type header triggers protocol enforcement. |
| `found within [ARGS_NAMES:<name>...]`. | The argument or parameter name itself. | A parameter named `select`, `union`, or `update` triggers a SQLi rule. |

Record these values for use in future steps:

- **`{RULE_ID}`**: The specific rule ID (for example, `942430`).
- **`{RULE_GROUP_NAME}`**: The rule group (for example, `REQUEST-942-APPLICATION-ATTACK-SQLI`).
- **`{MATCH_VARIABLE}`**: What was matched, including `RequestArgNames`, `RequestArgValues`, `RequestCookieNames`, `RequestCookieValues`, `RequestHeaderNames`, `RequestHeaderValues`, or `RequestBodyPostArgNames`.
- **`{SELECTOR}`**: The specific field name (for example, `username`, `password`, `__RequestVerificationToken`, `Content-Type`).

### Step 3b

Check how many *distinct* request fields and selectors the single `{RULE_ID}` identified in [Step 2](#step-2) affects. This count is the signal that separates a targeted exclusion (the rule misfires on one or a few nameable fields. Perform [Resolution A](#resolution-a)) from disabling the rule (the same rule fires across many different fields and endpoints with no single selector to exclude. Perform [Resolution B](#resolution-b)). Without this count, both resolutions look equally plausible and the choice becomes a guess.

#### Run this command

Use the `{RULE_ID}` from [Step 2](#step-2). This command summarizes every match produced by that one rule by the field or selector it matched, and counts the distinct fields involved. It's read-only.

> [!NOTE]
> If your block was the anomaly aggregator `949110`, don't run this query against `949110`. It has an empty `details_data_s` and no selector, so it returns no field. Run it against a contributing `ruleId_s` (for example `942100`) taken from the `action_s == 'Matched'` rows you noted in [Step 2](#step-2).

Run the following commands in Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID (contributing rule): " RULE_ID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s in ('Matched','Blocked') and ruleId_s == '$RULE_ID' | extend matchedField = extract('found within \\[([A-Za-z_]+:[^:\\]]+)', 1, details_data_s) | summarize BlockedCount = count(), DistinctFields = dcount(matchedField), Fields = make_set(matchedField, 50), Endpoints = make_set(requestUri_s, 50) by ruleId_s" \
  --timespan PT24H \
  --output json
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $WorkspaceId) { $WorkspaceId = Read-Host "Log Analytics Workspace ID" }
if (-not $RuleId) { $RuleId = Read-Host "WAF Rule ID" }

$query = @"
AzureDiagnostics
| where ResourceType == 'APPLICATIONGATEWAYS'
    and Category == 'ApplicationGatewayFirewallLog'
    and action_s in ('Matched','Blocked')
    and ruleId_s == '$RuleId'
| extend matchedField = extract('found within \\[([A-Za-z_]+:[^:\\]]+)', 1, details_data_s)
| summarize BlockedCount = count(), DistinctFields = dcount(matchedField),
    Fields = make_set(matchedField, 50), Endpoints = make_set(requestUri_s, 50)
    by ruleId_s
"@
Invoke-AzOperationalInsightsQuery `
  -WorkspaceId "$WorkspaceId" `
  -Query $query `
  -Timespan (New-TimeSpan -Hours 24)
```

### Interpret the results

Read `DistinctFields` (the count of distinct selectors the single rule matched) together with the `Fields` and `Endpoints` sets:

| Observation | Meaning | Next step |
|---|---|---|
| `DistinctFields` is `1` or a small, nameable set of specific fields (for example, only `ARGS:password`, or `ARGS:password` and `ARGS:username`). | The rule misfires on one or a few specific fields you can target individually. Record `{MATCH_VARIABLE}` and `{SELECTOR}` for each. | Perform [Resolution A](#resolution-a).|
| `DistinctFields` is large or the `Fields` or `Endpoints` sets show the same `{RULE_ID}` matching many different fields and URIs with no single selector you can name. | The rule fires across a broad pattern. Individual exclusions are impractical because there's no one field to exclude. The rule itself is over-matching the application. | Perform [Resolution B](#resolution-b). |
| When you rerun [Step 2](#step-2)'s summary without the `ruleId_s` filter, you see many different `ruleId_s` values. None of them are dominant. Also, the customer is onboarding or replatforming a new application, and can't yet enumerate the false positives. | This situation isn't a single-rule tuning problem. The entire application requires a tuning window. | Perform [Resolution C](#resolution-c). |

> [!NOTE]
>  If the blocked traffic is a trusted, known-safe source (a specific IP range or URL path) whose content is genuinely attack-like and must bypass *all* managed rules, see [Resolution D](#resolution-d). If WAF firewall logging was off so that you can't run [Step 2](#step-2) at all, see [Resolution E](#resolution-e). 

Record `{DISTINCT_SELECTOR_COUNT}`. This value is the `DistinctFields` value that's reported for `{RULE_ID}`.

### Step 4

Check whether the blocked request represents a genuine attack or a false positive from legitimate application traffic.

This step is a manual evaluation. Consider the following factors.

| Factor | Points toward **True Positive** (genuine attack) | Points toward **False Positive** (legitimate traffic) |
|---|---|---|
| **Source IP** | Unknown IP, not from expected client ranges. | Known user IP, internal application, or expected client range. |
| **Request URI** | Unusual path not part of the application. | Known application endpoint (for example, `/api/login`, `/api/data`). |
| **Matched content** | Classic attack payload: `' OR 1=1--`, `<script>alert(1)</script>`, or `../../etc/passwd`. | This data is normal application data (like user-entered text, JSON with HTML fragments, and encoded cookie values). |
| **Frequency** | Single or few requests from one IP. | Consistent pattern across many legitimate users. |
| **Application context** | The matched field isn't expected to contain that type of content. | The application legitimately sends SQL-like keywords, HTML content, or special characters in that field. |
| **Rule category** | Rule matches known exploit technique. | Rule matches generic pattern that overlaps with application functionality. |

### Decision map

Use the following table to determine next steps.

| Evaluation | Next steps |
|---|---|
| **False positive**: Legitimate application traffic is blocked. | Perform [Step 5](#step-5). Its **Route to the correct Resolution** table maps the [Step 3b](#step-3b) field count and your stated intent to exactly one Resolution (don't pick a Resolution without this mapping). |
| **True positive**: This situation is a genuine attack attempt that's correctly blocked. | No action needed - WAF is working as intended. Document and close. |
| **Uncertain**: Unable to determine from logs alone. | Perform [Step 5](#step-5) to test in Detection mode and gather more data. |

### Step 5

Check whether switching WAF to Detection mode allows the request through while still logging the match. This step confirms that WAF is the sole cause of the "403" errors.

> [!NOTE]
> This step involves observing the current WAF policy mode. If the policy is already in Detection mode, skip this step. If the policy is in Prevention mode, switching to Detection is a write operation covered in [Resolution C](#resolution-c).

Check the current WAF policy mode by using Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy show \
  --name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "policySettings.mode" \
  --output tsv
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $WafPolicyName) { $WafPolicyName = Read-Host "WAF Policy Name" }

(Get-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup").PolicySettings.Mode
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `Prevention`. | WAF is actively blocking the request. Use the information you gathered (like the [Step 3b](#step-3b) field count) plus your stated intent. | Use the [Route to the correct resolution](#route-to-the-correct-resolution) table. |
| `Detection`. | WAF is logging only. If you still see "403" errors, the block is from the backend or custom rules, not managed WAF rules. | Investigate the back-end application for the source of the errors. |

Verify existing exclusions and overrides. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy show \
  --name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{exclusions:managedRules.exclusions, overrides:managedRules.managedRuleSets[].ruleGroupOverrides}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `exclusions` is empty or `[]`. | No exclusions configured. You might need to add one. | Perform [Resolution A](#resolution-a). |
| `exclusions` contains entries but the rule still triggers. | Existing exclusions might not cover the correct match variable or selector. | Perform [Resolution A](#resolution-a) to review and update the exclusion. |
| `overrides` contains the `{RULE_ID}` with `"state": "Disabled"`. | The rule is already disabled but blocks still occur. Another rule might be responsible. | Recheck [Step 2](#step-2) for additional blocking rules. |

### Route to the correct resolution

By using the information that you gathered in [Step 2](#step-2), [Step 3b](#step-3b), this step, and your stated intent, this table routes you to exactly one resolution. Read it completely, and use the **first** row that matches. The order is meant to resolve ties, so you should never have to choose between two resolutions by intuition.

| Observable information and stated intent | Route to |
|---|---|
| WAF firewall logging was off. [Step 1b](#step-1b) showed `ApplicationGatewayFirewallLog` disabled. Therefore, you couldn't run [Step 2](#step-2). | Perform [Resolution E](#resolution-e) to enable WAF diagnostic logging first. |
| A trusted, known-safe source (a specific IP range or URL path) whose content is genuinely attack-like must bypass *all* managed rules. | Perform [Resolution D](#resolution-d) to create a custom allow rule. |
| You're onboarding or replatforming a new application, and you need a tuning window across many different rules that can't be enumerated yet. [Step 3b](#step-3b) showed many distinct `ruleId_s`, none dominant. | Perform [Resolution C](#resolution-c). |
| A single  `{RULE_ID}` is confined to one or a few nameable fields and `{DISTINCT_SELECTOR_COUNT}` from [Step 3b](#step-3b) is small. | Perform [Resolution A](#resolution-a) to create a targeted exclusion. |
| The same `{RULE_ID}` travels across many different fields and endpoints with no single selector to target, and `{DISTINCT_SELECTOR_COUNT}` from [Step 3b](#step-3b) is large. | Perform [Resolution B](#resolution-b) to disable the specific rule. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| WAF is in Prevention mode, and SQLi rule (`942xxx`) is triggered on a form field. | Perform [Resolution A](#resolution-a). |
| WAF is in Prevention mode, and XSS rule (`941xxx`) is triggered on a JSON body. | Perform [Resolution A](#resolution-a). |
| WAF is in Prevention mode, and an anomaly score (`949110/980130`) is exceeded by a cookie value. | Perform [Resolution A](#resolution-a) for the cookie. |
| WAF is in Prevention mode, and rule matches are confirmed false positives on a broad pattern. | Perform [Resolution B](#resolution-b). |
| You need time to tune WAF for a new application deployment. | Perform [Resolution C](#resolution-c). |
| You want to allow specific known-safe traffic before managed rules evaluate. | Perform [Resolution D](#resolution-d). |
| WAF firewall logging isn't enabled | Perform [Resolution E](#resolution-e) to enable WAF diagnostic logging. |
| WAF is in Detection mode, but you still see "403" errors. | The errors are from the backend, not WAF. Investigate the back-end application. |
| No WAF policy is associated or SKU is Standard (not WAF). | The errors are from the backend, not WAF. Investigate the back-end application. |
| All diagnostics pass, and WAF exclusions are applied, but problems persist. | File an Azure support request. |

## Resolution A

A managed WAF rule matches a specific part of the request (form field, header, cookie, or body argument) that contains legitimate application data. The rule correctly identifies a pattern that *could* be an attack. However, in this application's context, the content is benign.

Common scenarios include:

- A sign-in form `password` field triggers SQLi rule `942430` when a user enters `'` or `--`.
- A JSON API payload with a `description` field that contains HTML triggers XSS rule `941100`.
- An anti-forgery cookie `__RequestVerificationToken` triggers anomaly scoring.

1. Create a targeted exclusion for the specific rule, match variable, and selector (field name) that are causing the false positive. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID:                " RULE_ID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s == 'Blocked' and ruleId_s == '$RULE_ID' | project TimeGenerated, details_message_s, details_data_s, requestUri_s | take 5" \
  --timespan PT24H \
  --output json
```

2. From the `details_data_s` field, identify the exclusion match variable, and map the WAF log field to the exclusion variable.

| WAF log shows `found within...` | Exclusion match variable | Description |
|---|---|---|
| `ARGS:fieldname` | `RequestArgNames` | Query parameter or form field name |
| `ARGS:fieldname` (the value) | `RequestArgValues` | Query parameter or form field value |
| `REQUEST_COOKIES:cookiename` | `RequestCookieNames` or `RequestCookieValues` | Cookie name or value |
| `REQUEST_HEADERS:headername` | `RequestHeaderNames` or `RequestHeaderValues` | HTTP header name or value |
| `REQUEST_BODY` (`urlencoded` form post) | `RequestBodyPostArgNames` or `RequestBodyPostArgValues` | Classic `application/x-www-form-urlencoded` POST body argument name or value |
| A JSON body field shown as `ARGS:fieldname` | `RequestArgNames` or `RequestArgValues` | OWASP CRS surfaces JSON request-body fields as `ARGS:<name>` — exclude with `RequestArgValues` (the value) or `RequestArgNames` (the name), not `RequestBodyPostArgValues` |
| `ARGS_NAMES:argname` | `RequestArgNames` | The name of the argument itself |

- **Selector**: The specific field name (for example, `username`, `password`, `__RequestVerificationToken`, or `Content-Type`).
- **Selector match operator**: Use `Equals` for exact field name, `StartsWith` for prefix, `EndsWith` for suffix, `Contains` for partial match, or `EqualsAny` to match all values.

3. Create the exclusion using Azure CLI or Azure PowerShell.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This action creates a WAF exclusion so that rule `{RULE_ID}` no longer inspects the `{SELECTOR}` field in `{MATCH_VARIABLE}`. WAF stops checking that specific field for that specific rule, while all other rules and fields remain protected. This fix is the most targeted fix. It doesn't disable the rule entirely.

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:        " WAF_POLICY_NAME
[ -z "$MATCH_VARIABLE" ] && read -rp "Match Variable:         " MATCH_VARIABLE
[ -z "$SELECTOR_MATCH_OPERATOR" ] && read -rp "Selector Match Operator: " SELECTOR_MATCH_OPERATOR
[ -z "$SELECTOR" ] && read -rp "Selector (field name):  " SELECTOR

az network application-gateway waf-policy managed-rule exclusion add \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --match-variable "$MATCH_VARIABLE" \
  --selector-match-operator "$SELECTOR_MATCH_OPERATOR" \
  --selector "$SELECTOR"
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $WafPolicyName) { $WafPolicyName = Read-Host "WAF Policy Name" }
if (-not $MatchVariable) { $MatchVariable = Read-Host "Match Variable" }
if (-not $SelectorMatchOperator) { $SelectorMatchOperator = Read-Host "Selector Match Operator" }
if (-not $Selector) { $Selector = Read-Host "Selector (field name)" }

$policy = Get-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup"

$exclusion = New-AzApplicationGatewayFirewallExclusionConfig `
  -MatchVariable "$MatchVariable" `
  -SelectorMatchOperator "$SelectorMatchOperator" `
  -Selector "$Selector"

$policy.ManagedRules.Exclusions.Add($exclusion)

Set-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup" `
  -ManagedRule $policy.ManagedRules `
  -PolicySetting $policy.PolicySettings
```

**Common exclusion examples**

Sign-in form password field blocked by SQLi rule:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy managed-rule exclusion add \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --match-variable RequestArgValues \
  --selector-match-operator Equals \
  --selector password
```

JSON API body field blocked by XSS rule:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy managed-rule exclusion add \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --match-variable RequestArgValues \
  --selector-match-operator Equals \
  --selector description
```

Cookie value triggering anomaly scoring:
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy managed-rule exclusion add \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --match-variable RequestCookieValues \
  --selector-match-operator Equals \
  --selector __RequestVerificationToken
```

4. Resend the request that was previously blocked. Then verify in WAF logs that the rule no longer blocks it. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID:                " RULE_ID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and ruleId_s == '$RULE_ID' and action_s == 'Blocked' | order by TimeGenerated desc | take 5" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| No new blocked entries after the exclusion is applied. | Exclusion is working, and the false positive is resolved. |
| Blocked entries still appear by having the same `ruleId_s` value. | Exclusion might not match the correct variable or selector. Review step 1, and adjust. |
| Blocked entries appear by having a different `ruleId_s` value. | Multiple rules are triggering. Repeat step 3 for the additional rule, or perform [Resolution B](#resolution-b). |

You might encounter multirule triggers and a propagation delay. Classic attack payloads such as `' OR 1=1--` can trigger multiple overlapping SQLi rules simultaneously (for example, `942100`, `942110`, `942130`, `942180`, `942330`, and `942390`). A field-level exclusion for `RequestArgValues` or `{SELECTOR}` suppresses all rule matches for that field, but WAF exclusion changes can take 30–60 seconds to propagate. If the request is still blocked immediately after you apply an exclusion, wait 1–2 minutes, and then retest before you conclude that the exclusion is ineffective.

Additionally, nonbrowser clients (such as cURL, PowerShell `Invoke-WebRequest`, and API testing tools) can trigger protocol enforcement rules  in the `920xxx` range (for example, rule `920300` for a missing Accept header) that contribute to the anomaly score alongside the primary rule match. These protocol-level matches aren't caused by the application's payload but by the client's HTTP behavior. If the request passes from a browser but fails from an API client, check for `920xxx` rule matches in the logs.

If the issue persists after an exclusion, go to [Resolution B](#resolution-b).

## Resolution B

A specific managed WAF rule produces false positives across multiple request fields or patterns. This situation makes individual exclusions impractical. In this case, you have to disable the rule entirely.

> [!IMPORTANT]
> If you disable a managed rule, you remove WAF protection for that specific attack pattern across *all* requests to the Application Gateway. Disable rules only after you verify that the matched traffic is consistently a false positive, and that alternative protections (for example, back-end input validation) exist for the attack pattern that this rule applies to.

1. Identify the rule group that contains the `{RULE_ID}` that you want to disable. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy managed-rule rule-set list \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

2. Review the output to find the rule group that contains `{RULE_ID}`. Record the `{RULE_GROUP_NAME}` (for example, `REQUEST-942-APPLICATION-ATTACK-SQLI`).

| Common rule IDs | Rule group | What it detects |
|---|---|---|
| `942100`, `942110`, `942130` | `REQUEST-942-APPLICATION-ATTACK-SQLI` | SQL injection via tautologies, comments, keywords |
| `942430`, `942440` | `REQUEST-942-APPLICATION-ATTACK-SQLI` | Restricted SQL character anomaly detection |
| `941100`, `941110`, `941130` | `REQUEST-941-APPLICATION-ATTACK-XSS` | XSS attack filtering — HTML tag handlers, event handlers |
| `941160` | `REQUEST-941-APPLICATION-ATTACK-XSS` | XSS via HTML body content |
| `920230`, `920300`, `920320` | `REQUEST-920-PROTOCOL-ENFORCEMENT` | Missing Accept, Content-Type, or body with no Content-Type |
| `949110` | `REQUEST-949-BLOCKING-EVALUATION` | Inbound anomaly score exceeded (aggregation rule) |
| `980130` | `REQUEST-980-CORRELATION` | Inbound anomaly score exceeded (correlation) |

3. Disable the specific rule within the WAF policy.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This action disables WAF rule `{RULE_ID}` in rule group `{RULE_GROUP_NAME}`. The rule no longer inspects any requests. This action reduces protection for the specific attack pattern this rule covers. All other rules remain active. If you need a more targeted approach, perform [Resolution A](#resolution-a) instead.

Run the following commands using Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME
[ -z "$RULE_SET_TYPE" ] && read -rp "Managed Rule Set Type (e.g. OWASP): " RULE_SET_TYPE
[ -z "$RULE_SET_VERSION" ] && read -rp "Managed Rule Set Version (e.g. 3.2): " RULE_SET_VERSION
[ -z "$RULE_GROUP_NAME" ] && read -rp "Rule Group Name:   " RULE_GROUP_NAME
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID:       " RULE_ID

az network application-gateway waf-policy managed-rule rule-set add \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --type "$RULE_SET_TYPE" \
  --version "$RULE_SET_VERSION" \
  --group-name "$RULE_GROUP_NAME" \
  --rule rule-id="$RULE_ID" state=Disabled
```

> [!NOTE]
> In OWASP anomaly-scoring mode, disabling a single contributing rule might not stop "403" errors. If the remaining matched rules still push the inbound anomaly score over the threshold, the `949110` aggregator keeps blocking requests. If the request is still blocked after disabling one rule, repeat this command for every contributing rule you identified in [Step 2](#step-2) and [Step 3b](#step-3b).

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $WafPolicyName) { $WafPolicyName = Read-Host "WAF Policy Name" }
if (-not $RuleGroupName) { $RuleGroupName = Read-Host "Rule Group Name" }
if (-not $RuleId) { $RuleId = Read-Host "WAF Rule ID" }

$policy = Get-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup"

$override = New-AzApplicationGatewayFirewallPolicyManagedRuleOverride `
  -RuleId "$RuleId" `
  -State Disabled

$groupOverride = New-AzApplicationGatewayFirewallPolicyManagedRuleGroupOverride `
  -RuleGroupName "$RuleGroupName" `
  -Rule $override

# Apply the override to the first managed rule set
$policy.ManagedRules.ManagedRuleSets[0].RuleGroupOverrides.Add($groupOverride)

Set-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup" `
  -ManagedRule $policy.ManagedRules `
  -PolicySetting $policy.PolicySettings
```

4. Resend the request that was previously blocked, and verify the rule no longer triggers errors.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$RULE_ID" ] && read -rp "WAF Rule ID:                " RULE_ID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and ruleId_s == '$RULE_ID' | order by TimeGenerated desc | take 5" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| No entries for the disabled rule. | The rule is successfully disabled. |
| Entries still appear with `action_s == "Blocked"` value. | The override might not have taken effect yet. Wait 1–2 minutes and recheck. If it persists, verify that the override was applied to the correct rule set version. |
| Requests still return "403" errors but from a *different* rule. | Multiple rules are blocking requests. Repeat step 2 for additional rules or use [Resolution A](#resolution-a) for targeted exclusions. |

If the issue persists, go to [Resolution C](#resolution-c) or [Resolution D](#resolution-d).

## Resolution C

The WAF policy needs a tuning period in which rules log matches without blocking traffic. This period is appropriate when you deploy WAF for the first time, upgrade the managed rule set version, or onboard a new application behind an existing WAF.

> [!IMPORTANT]
> Detection mode means WAF **won't block any requests including genuine attacks**. Use this mode only as a temporary tuning measure, not as a permanent configuration for production traffic.

1. Switch the WAF policy mode from Prevention to Detection. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy show \
  --name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "policySettings" \
  --output json
```

Review the current `policySettings` values, especially `mode` (should be `Prevention`) and `requestBodyCheck` (note whether it's `true` or `false`).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This operation switches the WAF policy from Prevention mode to Detection mode. WAF continues to log all rule matches but **no longer blocks any requests**. This change allows you to identify all false positives by reviewing logs while legitimate traffic flows uninterrupted. Switch back to Prevention mode after tuning is complete. This change is usually done after 1–2 weeks of log review.

> [!IMPORTANT]
> `policy-setting update` rewrites the full `policySettings` block and silently resets `requestBodyCheck` to `false` if you don't specify a value. The following commands re-assert `--request-body-check true`. Be sure to verify the original value in step 1 and include its value (either `true` or `false`). The same applies to step 3 when you switch back to Prevention mode.

Perform the policy mode switch by using Azure CLI or Azure PowerShell:

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy policy-setting update \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --mode Detection \
  --state Enabled \
  --request-body-check true
```

**Azure PowerShell**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $WafPolicyName) { $WafPolicyName = Read-Host "WAF Policy Name" }

$policy = Get-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup"

$policy.PolicySettings.Mode = "Detection"

Set-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup" `
  -ManagedRule $policy.ManagedRules `
  -PolicySetting $policy.PolicySettings
```

2. While in Detection mode, periodically query WAF logs to identify all false positive patterns.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s == 'Detected' | summarize count() by ruleId_s, ruleGroup_s, details_message_s | order by count_ desc" \
  --timespan P7D \
  --output table
```

For each high-frequency detected rule, evaluate whether it's a false positive ([Step 4](#step-4)), and create targeted exclusions ([Resolution A](#resolution-a)) or disable rules ([Resolution B](#resolution-b)) as necessary.

3. After you finish tuning, revert the WAF policy mode to **Prevention**.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Switch back to Prevention mode only after you review detected matches and apply necessary exclusions or overrides. As in step 1, re-assert `--request-body-check` so `policy-setting update` doesn't silently reset it.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:   " WAF_POLICY_NAME

az network application-gateway waf-policy policy-setting update \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --mode Prevention \
  --state Enabled \
  --request-body-check true
```

After you revert to Prevention mode, monitor for "403" error responses. If false positives reoccur, add more exclusions ([Resolution A](#resolution-a)) or perform [Resolution D](#resolution-d).

## Resolution D

A specific known-safe traffic pattern (for example, from an internal application, a trusted IP range, or a specific URL path) has to bypass managed WAF rules entirely. Custom rules are evaluated before managed rules. Therefore, an `Allow` action in a custom rule prevents managed rules from blocking the request.

1. From [Step 2](#step-2) and [Step 3a](#step-3a), determine the distinguishing characteristic of the legitimate traffic by using the following table.

| Allow criteria | Custom rule match variable | Example |
|---|---|---|
| Specific source IP or range | `RemoteAddr` | Allow requests from `10.0.0.0/8` |
| Specific URL path | `RequestUri` | Allow requests to `/api/internal/*` |
| Specific request header | `RequestHeaders` | Allow requests with `X-Internal-App: true` |
| Combination of IP and path | Multiple match conditions | Allow `10.0.0.0/8` to `/api/webhook` |

2. Create a custom WAF rule with an `Allow` action that matches the trusted traffic pattern.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This process creates a custom WAF rule with priority `{RULE_PRIORITY}` that allows requests that match the specified condition to bypass managed WAF rules. Only requests that match this exact pattern are allowed through. All other traffic continues to be inspected by managed rules.

Use the following examples in either Azure CLI or Azure PowerShell.

**Example: Allow traffic from a specific IP range**

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:        " WAF_POLICY_NAME
[ -z "$RULE_PRIORITY" ] && read -rp "Custom Rule Priority:   " RULE_PRIORITY
[ -z "$TRUSTED_IP_RANGE" ] && read -rp "Trusted IP Range (CIDR): " TRUSTED_IP_RANGE

az network application-gateway waf-policy custom-rule create \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name AllowInternalTraffic \
  --priority "$RULE_PRIORITY" \
  --rule-type MatchRule \
  --action Allow \
  --match-conditions '[{"variables":[{"variableName":"RemoteAddr"}],"operator":"IPMatch","values":["'"$TRUSTED_IP_RANGE"'"]}]'
```

**Example: Allow traffic to a specific URL path**

**Azure CLI**

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$WAF_POLICY_NAME" ] && read -rp "WAF Policy Name:      " WAF_POLICY_NAME
[ -z "$RULE_PRIORITY" ] && read -rp "Custom Rule Priority: " RULE_PRIORITY
[ -z "$TRUSTED_PATH" ] && read -rp "Trusted URL Path (substring): " TRUSTED_PATH

az network application-gateway waf-policy custom-rule create \
  --policy-name "$WAF_POLICY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name AllowApiEndpoint \
  --priority "$RULE_PRIORITY" \
  --rule-type MatchRule \
  --action Allow \
  --match-conditions '[{"variables":[{"variableName":"RequestUri"}],"operator":"Contains","values":["'"$TRUSTED_PATH"'"]}]'
```

**Azure PowerShell (combined example — IP-based allow rule)**

```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $WafPolicyName) { $WafPolicyName = Read-Host "WAF Policy Name" }
if (-not $RulePriority) { $RulePriority = Read-Host "Custom Rule Priority" }
if (-not $TrustedIpRange) { $TrustedIpRange = Read-Host "Trusted IP Range (CIDR)" }

$policy = Get-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup"

$matchCondition = New-AzApplicationGatewayFirewallCondition `
  -MatchVariable (New-AzApplicationGatewayFirewallMatchVariable -VariableName "RemoteAddr") `
  -Operator IPMatch `
  -MatchValue "$TrustedIpRange"

$customRule = New-AzApplicationGatewayFirewallCustomRule `
  -Name "AllowInternalTraffic" `
  -Priority $RulePriority `
  -RuleType MatchRule `
  -MatchCondition $matchCondition `
  -Action Allow `
  -State Enabled

$policy.CustomRules.Add($customRule)

Set-AzApplicationGatewayFirewallPolicy `
  -Name "$WafPolicyName" `
  -ResourceGroupName "$ResourceGroup" `
  -ManagedRule $policy.ManagedRules `
  -PolicySetting $policy.PolicySettings `
  -CustomRule $policy.CustomRules
```

3. Resend the request that was previously blocked. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$LA_WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " LA_WORKSPACE_GUID
[ -z "$REQUEST_PATH" ] && read -rp "Request Path (substring):   " REQUEST_PATH

az monitor log-analytics query \
  --workspace "$LA_WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where ResourceType == 'APPLICATIONGATEWAYS' and Category == 'ApplicationGatewayFirewallLog' and action_s in ('Allowed', 'Blocked') and requestUri_s contains '$REQUEST_PATH' | project TimeGenerated, action_s, ruleId_s, requestUri_s, clientIp_s | order by TimeGenerated desc | take 10" \
  --timespan PT1H \
  --output json
```

| Result | Meaning |
|---|---|
| Entry shows `action_s == "Allowed"` with the custom rule name. | The custom rule is working, and traffic is allowed before managed rules evaluate. |
| The entry still shows `action_s == "Blocked"`. | The custom rule priority might be too low (the higher number, the lower the priority). Make sure that the custom rule priority number is lower than the managed rule evaluation. |
| No entries exist for the request. | The request might not be reaching Application Gateway. Make sure to check the routing. |

---

## Resolution E

Because WAF diagnostic logging isn't configured, you can't analyze blocked requests.

1. Check whether WAF diagnostics are enabled for the Application Gateway. 

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az monitor diagnostic-settings list \
  --resource "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

2. If no diagnostic settings exist for the Application Gateway, enable WAF diagnostics, and send the logs to a Log Analytics workspace.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This change enables WAF firewall diagnostic logging, and sends the logs to the specified Log Analytics workspace. This change is logging-only. It doesn't affect how WAF processes traffic. 

> [!NOTE]
> `diagnostic-settings create` needs the workspace's full ARM resource ID or name (`{LA_WORKSPACE_RESOURCE_ID}`), not the customer-ID GUID.

Run the following commands in Azure CLI:

```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:             " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:           " RESOURCE_NAME
[ -z "$LA_WORKSPACE_RESOURCE_ID" ] && read -rp "Log Analytics Workspace Resource ID: " LA_WORKSPACE_RESOURCE_ID

# Write the log categories to a JSON file (the CLI shorthand parser rejects an inline --logs JSON string):
cat > logs.json <<'EOF'
[
  { "category": "ApplicationGatewayFirewallLog", "enabled": true },
  { "category": "ApplicationGatewayAccessLog", "enabled": true }
]
EOF

az monitor diagnostic-settings create \
  --resource "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/applicationGateways/$RESOURCE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --name AppGW-WAF-Diagnostics \
  --workspace "$LA_WORKSPACE_RESOURCE_ID" \
  --logs @logs.json
```

**Azure PowerShell:**
```powershell
# -- Collect inputs (cached if already set in this session) --
if (-not $Subscription) { $Subscription = Read-Host "Subscription ID" }
if (-not $ResourceGroup) { $ResourceGroup = Read-Host "Resource Group" }
if (-not $ResourceName) { $ResourceName = Read-Host "App Gateway Name" }
if (-not $LogAnalyticsWorkspaceName) { $LogAnalyticsWorkspaceName = Read-Host "Log Analytics Workspace Name" }

$gw = Get-AzApplicationGateway `
  -Name "$ResourceName" `
  -ResourceGroupName "$ResourceGroup"

Set-AzDiagnosticSetting `
  -ResourceId $gw.Id `
  -WorkspaceId "/subscriptions/$Subscription/resourceGroups/$ResourceGroup/providers/Microsoft.OperationalInsights/workspaces/$LogAnalyticsWorkspaceName" `
  -Name "AppGW-WAF-Diagnostics" `
  -Category @("ApplicationGatewayFirewallLog", "ApplicationGatewayAccessLog") `
  -Enabled $true
```

3. WAF logs typically take 5–10 minutes to appear in Log Analytics after you enable diagnostics. After the logs appear, return to [Step 2](#step-2) to query the WAF logs.

## References

- [Azure Web Application Firewall on Application Gateway overview](/azure/web-application-firewall/ag/ag-overview)
- [Tune Web Application Firewall for Application Gateway](/azure/web-application-firewall/ag/application-gateway-waf-configuration)
- [Web Application Firewall exclusion lists](/azure/web-application-firewall/ag/application-gateway-waf-configuration#waf-exclusion-lists)
- [Custom rules for Web Application Firewall v2 on Application Gateway](/azure/web-application-firewall/ag/custom-waf-rules-overview)
- [Web Application Firewall CRS rule groups and rules](/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules)
- [Monitor Web Application Firewall logs](/azure/web-application-firewall/ag/web-application-firewall-logs)
- [Troubleshoot Web Application Firewall issues in Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot)
- [Best practices for Web Application Firewall on Application Gateway](/azure/web-application-firewall/ag/best-practices)
