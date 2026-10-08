---
title: Troubleshoot Application Gateway WAF custom rules and exclusions
description: Diagnose unexpected Azure Application Gateway WAF custom rules and exclusions. Fix rule priority, exclusion scope, and platform-limit issues.
ms.service: azure-web-application-firewall
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: osartavi, chadmat
ms.topic: troubleshooting
ms.date: 9/25/2026
ai-usage: ai-assisted
---

# Troubleshoot Application Gateway WAF custom rules, exclusions, and platform limits

## Summary

This article helps you troubleshoot custom rules, exclusions, and platform limits in Azure Web Application Firewall (WAF) on Application Gateway.

Application Gateway WAF custom rules and exclusions can behave unexpectedly when rule evaluation order, exclusion scope, or platform limits don't match your policy intent. This guide helps you identify the cause and apply the appropriate Azure CLI fix.

> [!TIP]
> Diagnostic logs are essential for determining why Application Gateway WAF allowed, blocked, or matched a request. We strongly recommend that you enable **Diagnostic settings** on the Application Gateway resource before troubleshooting and send both `ApplicationGatewayFirewallLog` and `ApplicationGatewayAccessLog` to a Log Analytics workspace. Use resource-specific tables when available. For setup instructions, see [Diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics). For WAF log fields and examples, see [Monitor logs for Azure Web Application Firewall](/azure/web-application-firewall/ag/web-application-firewall-logs).

## Symptoms

- Requests are allowed or blocked by a custom rule that you didn't expect to run first.
- A broad allow rule appears to bypass later block or rate-limit rules.
- Exclusions suppress too much inspection after a false-positive tuning change.
- Application Gateway WAF policy updates fail with validation messages such as unsupported selector, invalid match condition, or limit exceeded.
- Policy changes succeed but traffic behavior still doesn't match the intended rule logic.

## Prerequisites

- **Permissions required:** `Network Contributor` on the Application Gateway WAF policy resource group (or equivalent read/write permission on the policy)
- **Tools:** Azure CLI 2.x in a Bash shell (for example Azure Cloud Shell Bash) or an AI agent with Azure CLI access
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `SUBSCRIPTION` | Azure subscription ID containing the Application Gateway WAF policy | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `RG` | Resource group containing the Application Gateway WAF policy | `rg-prod-waf` |
| `POLICY_NAME` | Application Gateway WAF policy name | `waf-prod-policy` |

> [!TIP]
> Each script prompts for inputs and caches them in the current shell session so you enter each value once.

> [!IMPORTANT]
> The `azurecli-interactive` blocks in this article use Bash prompt syntax (`[ -z "$VAR" ] && read -rp ...`). Run them in a Bash shell.

---

## Diagnostic steps

> **These steps are read-only. They don't make any changes to your environment.**

> [!IMPORTANT]
> Application Gateway WAF evaluates enabled custom rules before managed rules. It evaluates custom rules in ascending priority order, so a rule with a lower priority number runs first. When a custom rule matches and takes an `Allow` or `Block` action, Application Gateway WAF stops evaluating the request against all remaining custom and managed rules. A `Log` action doesn't stop evaluation; later custom rules run in priority order, followed by managed rules. For more information, see [Application Gateway WAF custom-rule evaluation](/azure/web-application-firewall/ag/custom-waf-rules-overview).

---

### Step 1

**What this checks:** The effective Application Gateway WAF custom-rule order, action, and state so you can confirm whether an earlier `Allow` or `Block` rule stops evaluation and causes unexpected behavior.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy custom-rule list \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "sort_by(@,&priority)[].{name:name,priority:priority,action:action,state:state,ruleType:ruleType,matchCount:length(matchConditions)}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| A broad `Allow` or `Block` rule at a lower numeric priority than expected | That rule runs earlier than intended and stops evaluation of all remaining custom and managed rules | -> [Step 2](#step-2) |
| Rules are ordered as intended and actions look correct | Priority is probably not the primary issue | -> [Step 3](#step-3) |
| No custom rules returned | This scenario is not caused by custom-rule precedence | -> [Step 4](#step-4) |
| Command fails with authorization or resource errors | Context or permission issue, not policy logic | Fix access or context, then re-run Step 1 |

---

### Step 2

**What this checks:** Whether a specific custom rule is too broad (for example, `Any`, very wide value lists, or weak selectors) and therefore matches more traffic than intended.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME
[ -z "$RULE_NAME" ] && read -rp "Custom Rule Name from Step 1: " RULE_NAME

az network application-gateway waf-policy custom-rule match-condition list \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --name "$RULE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{operator:operator,negate:negationConditon,variables:matchVariables,values:matchValues,transforms:transforms}" \
  --output json
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `operator` is `Any`, or selectors or values are much broader than the intended endpoint or workflow | The rule scope is too wide and likely preempts intended downstream rules | -> [Resolution A](#resolution-a) |
| Rule conditions are narrow and match only intended traffic | Scope looks healthy | -> [Step 3](#step-3) |
| Rule not found | Step 1 inventory changed or wrong rule name was entered | Re-run Step 1, then Step 2 |

---

### Step 3

**What this checks:** Whether exclusions are broad or global instead of per-rule scoped, which can suppress managed-rule coverage more than intended.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy show \
  --resource-group "$RG" \
  --name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "managedRules.exclusions[].{matchVariable:matchVariable,selectorMatchOperator:selectorMatchOperator,selector:selector,ruleSetCount:length(exclusionManagedRuleSets)}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| Exclusions where `ruleSetCount` is `0` | Exclusion isn't scoped to specific managed rules and is likely too broad | -> [Resolution B](#resolution-b) |
| Exclusions that exist and each one is tied to rule sets or rule IDs | Exclusion scoping is likely healthy | -> [Step 4](#step-4) |
| No exclusions returned | Exclusion scope isn't the issue | -> [Step 4](#step-4) |

---

### Step 4

**What this step checks:** Whether recent failed policy operations indicate platform constraints, such as unsupported selectors or operators, invalid values, or limit and quota-related failures.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

POLICY_ID=$(az network application-gateway waf-policy show \
  --resource-group "$RG" \
  --name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query id -o tsv | tr -d "\r")

MSYS_NO_PATHCONV=1 az monitor activity-log list \
  --resource-id "$POLICY_ID" \
  --status Failed \
  --offset 14d \
  --subscription "$SUBSCRIPTION" \
  --query "[].{time:eventTimestamp,operation:operationName.value,status:status.value,subStatus:subStatus.value,message:properties.statusMessage}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| Messages that include unsupported selector or operator, invalid match configuration, or limit exceeded | This result indicates a platform-support or policy-limit problem. | -> [Resolution C](#resolution-c) |
| No failed operations and Steps 1-3 were healthy | The fault is outside this scenario's three main causes. | File an Azure support request with outputs from Steps 1-4. |
| Ambiguous failures without clear status message | You need deeper policy-engine diagnostics. | File an Azure support request with correlation IDs from the failed operations. |

---

## Decision map

| Diagnostic result | Next action |
|---|---|
| Step 1: Broad `Allow` or `Block` rule has unexpectedly high precedence | Go to [Step 2](#step-2) |
| Step 1: Rules are ordered as intended and actions look correct | Go to [Step 3](#step-3) |
| Step 1: No custom rules returned | Go to [Step 4](#step-4) |
| Step 1: Authorization/resource error | Fix access or context, then re-run [Step 1](#step-1) |
| Step 2: Match conditions are broad (`Any` or very wide selectors/values) | Go to [Resolution A](#resolution-a) |
| Step 2: Match conditions are narrow and intended | Go to [Step 3](#step-3) |
| Step 2: Rule not found | Re-run [Step 1](#step-1), then re-run [Step 2](#step-2) with the refreshed rule name |
| Step 3: Exclusion has `ruleSetCount = 0` | Go to [Resolution B](#resolution-b) |
| Step 3: Exclusions are tied to rule sets/rule IDs | Go to [Step 4](#step-4) |
| Step 3: No exclusions returned | Go to [Step 4](#step-4) |
| Step 4: Unsupported selector/operator, invalid match config, or limit exceeded | Go to [Resolution C](#resolution-c) |
| Step 4: No failed operations and Steps 1-3 are healthy | File an Azure support request with outputs from Steps 1-4 |
| Step 4: Ambiguous failures without clear status message | File an Azure support request and include failed-operation correlation IDs and Step 1-4 outputs |

---

## Resolution A

**Root cause:** A high-precedence Application Gateway WAF custom rule (or overly broad match condition) takes an `Allow` or `Block` action and stops evaluation before the intended rule flow.

### A.1 

**Capture the current custom rule configuration before you change it.**

**Azure CLI (read-only):**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy custom-rule list \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json > "waf-custom-rules-before.json"

echo "Saved backup to waf-custom-rules-before.json"
```

### A.2 

> **⚠️ WRITE OPERATION - get approval before you execute this command**

> [!TIP]
> Update only one rule at a time so you can verify behavior after each change.

This command updates the selected Application Gateway WAF custom-rule priority and action so the evaluation order and stop-evaluation behavior match your intended flow.

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME
[ -z "$RULE_NAME" ] && read -rp "Rule to update: " RULE_NAME
[ -z "$NEW_PRIORITY" ] && read -rp "New priority (lower runs earlier): " NEW_PRIORITY
[ -z "$NEW_ACTION" ] && read -rp "New action (Allow|Block|Log|JSChallenge): " NEW_ACTION

az network application-gateway waf-policy custom-rule update \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --name "$RULE_NAME" \
  --priority "$NEW_PRIORITY" \
  --action "$NEW_ACTION" \
  --subscription "$SUBSCRIPTION" \
  --verbose
```

### A.3 

Re-run [Step 1](#step-1) and [Step 2](#step-2).

Healthy state after this fix:
- Priority order matches your intended evaluation flow.
- The updated rule no longer preempts unrelated traffic.

If behavior is still broader than intended, proceed to [Resolution B](#resolution-b) to tighten exclusion scope.

---

## Resolution B

**Root cause:** Exclusions are globally scoped or too broad, so managed-rule inspection is bypassed for more traffic than intended.

### B.1 

**Capture current exclusions before you change them.**

**Azure CLI (read-only):**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy managed-rule exclusion list \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json > "waf-exclusions-before.json"

echo "Saved backup to waf-exclusions-before.json"
```

### B.2 

> **⚠️ WRITE OPERATION - get approval before you execute this command**

> [!TIP]
> This command removes existing exclusions. Run it only after you have a backup from B.1.

This command removes managed-rule exclusions from the target Application Gateway WAF policy so previously excluded matches return to normal managed-rule inspection.

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy managed-rule exclusion remove \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --verbose
```

### B.3 

> **⚠️ WRITE OPERATION - get approval before you execute this command**

This command creates a narrowly scoped exclusion tied to specific rule sets and rule ID targets so inspection remains active for other traffic.

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME
[ -z "$MATCH_VARIABLE" ] && read -rp "Match variable (for example RequestHeaderNames): " MATCH_VARIABLE
[ -z "$SELECTOR_OPERATOR" ] && read -rp "Selector operator (Contains|EndsWith|Equals|EqualsAny|StartsWith): " SELECTOR_OPERATOR
[ -z "$SELECTOR" ] && read -rp "Selector value: " SELECTOR
[ -z "$RULESET_TYPE" ] && read -rp "Rule set type (OWASP|Microsoft_DefaultRuleSet|Microsoft_BotManagerRuleSet|Microsoft_HTTPDDoSRuleSet): " RULESET_TYPE
[ -z "$RULESET_VERSION" ] && read -rp "Rule set version (for example 3.2): " RULESET_VERSION
[ -z "$GROUP_NAME" ] && read -rp "Managed rule group name: " GROUP_NAME
[ -z "$RULE_IDS" ] && read -rp "Rule IDs (space-separated): " RULE_IDS

az network application-gateway waf-policy managed-rule exclusion rule-set add \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --match-variable "$MATCH_VARIABLE" \
  --match-operator "$SELECTOR_OPERATOR" \
  --selector "$SELECTOR" \
  --type "$RULESET_TYPE" \
  --version "$RULESET_VERSION" \
  --group-name "$GROUP_NAME" \
  --rule-ids $RULE_IDS \
  --subscription "$SUBSCRIPTION" \
  --verbose
```

Re-run [Step 3](#step-3).

Healthy state after this fix:
- Exclusions are tied to specific rule sets and rule IDs.
- Managed-rule coverage remains active outside the narrowly scoped exception.

---

## Resolution C

**Root cause:** Policy updates are failing due to unsupported match constructs or platform constraints, or policy-setting values don't align with supported enforcement behavior.

### C.1 

**Review current policy settings to confirm current enforcement values.**

**Azure CLI (read-only):**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME

az network application-gateway waf-policy policy-setting list \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

### C.2 

> **⚠️ WRITE OPERATION - get approval before you execute this command**

> [!TIP]
> Apply only supported values that match your application profile, then validate behavior with representative traffic.

This command updates Application Gateway WAF policy-setting enforcement and size-limit values on the target policy so the configuration aligns with supported platform behavior.

**Azure CLI:**
```azurecli-interactive
# -- Collect inputs (cached if already set in this session) --
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$POLICY_NAME" ] && read -rp "Application Gateway WAF Policy Name: " POLICY_NAME
[ -z "$INSPECT_LIMIT_KB" ] && read -rp "Request body inspect limit KB: " INSPECT_LIMIT_KB
[ -z "$MAX_BODY_KB" ] && read -rp "Max request body size KB: " MAX_BODY_KB
[ -z "$FILE_UPLOAD_MB" ] && read -rp "Max file upload size MB: " FILE_UPLOAD_MB

az network application-gateway waf-policy policy-setting update \
  --resource-group "$RG" \
  --policy-name "$POLICY_NAME" \
  --request-body-enforcement true \
  --request-body-inspect-limit-in-kb "$INSPECT_LIMIT_KB" \
  --max-request-body-size-in-kb "$MAX_BODY_KB" \
  --file-upload-enforcement true \
  --file-upload-limit-in-mb "$FILE_UPLOAD_MB" \
  --subscription "$SUBSCRIPTION" \
  --verbose
```

### C.3 

Re-run [Step 4](#step-4).

Healthy state after this fix:
- No new failed operation messages after the fix timestamp report unsupported or limit-related validation errors.
- Policy updates complete and behavior aligns with supported Application Gateway WAF capabilities.

If failed messages still indicate an unsupported selector or capability, redesign the rule using supported match variables/operators and keep the previous output for support escalation.

---

## Related articles

- [Application Gateway WAF custom rules](/azure/web-application-firewall/ag/custom-waf-rules-overview)
- [Application Gateway WAF exclusions](/azure/web-application-firewall/ag/application-gateway-waf-configuration)
- [Request size and upload limits for Application Gateway WAF](/azure/web-application-firewall/ag/application-gateway-waf-request-size-limits)
- [Application Gateway WAF policy overview and association scope](/azure/web-application-firewall/ag/policy-overview)
