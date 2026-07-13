---
title: Troubleshoot Azure private DNS zone deletion failure
description: Fix Azure private DNS zone deletion and migration failures caused by virtual network links, resource locks, or quota limits. Follow step-by-step diagnostics to resolve the issue.
ms.service: azure-dns
ms.topic: troubleshooting
ms.date: 7/10/2026
ms.reviewer: chadmat
ms.author: kaushika
ai.hint.symptom-tags:
  - private-dns-zone-delete-failed
  - orphaned-vnet-link
  - virtual-network-link-stale
  - dns-zone-in-use
  - dns-zone-migration-failed
  - record-set-quota-exceeded
  - resource-lock-blocking-delete
  - resource-group-move-sync-lag
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/delete
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/delete
  - Microsoft.Network/privateDnsZones/*/read
  - Microsoft.Authorization/locks/read
  - Microsoft.Authorization/locks/delete
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - ZONE_NAME
---

# Troubleshoot an Azure private DNS zone that you can't delete or migrate

## Summary

Azure private DNS zone delete, migrate, and resource-group-move operations almost always fail because of an unresolved dependency, not a platform refusal. Four causes drive most failures: a virtual network link still exists on the zone (often from a deleted or cross-subscription VNet that no longer renders in the portal), a `CanNotDelete` resource lock is in place, the zone exceeds the default record-set quota during a bulk migration, or the operation succeeded and the portal is lagging during ARM convergence. This article helps you identify the cause and how to clear it.

## Symptoms

You might experience one or more of the following symptoms:

- The portal or CLI returns `The DNS zone <zone> can not be deleted because it has virtual network links` (`PreconditionFailed` / `DnsZoneInUse`).
- `az network private-dns zone delete` fails with `Cannot delete resource while nested resources exist` even though `az network private-dns link vnet list` returns an empty array.
- A delete or move operation fails with `ScopeLocked` or `Cannot proceed with operation because resource <id> used by resource <id> is not in Succeeded state`.
- A bulk record-set import or migration aborts with `RecordSetCountLimitExceeded` or `Quota exceeded for resource type`.
- After a `Move-AzResource` or resource-group move, records appear missing in the portal but `az network private-dns record-set list` still returns them.
- Repeated retries from the portal succeed only after some delay, with no configuration change between attempts.

## Prerequisites

- **Permissions required:** `Private DNS Zone Contributor` (or equivalent) on the zone, plus `Microsoft.Authorization/locks/*` to inspect and remove resource locks.
- **Tools:** Azure CLI 2.50 or later (or an AI agent with Azure CLI access). `jq` is available in Cloud Shell.
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription that hosts the zone | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the private DNS zone | `dns-prod-rg` |
| `{ZONE_NAME}` | Fully qualified private DNS zone name | `privatelink.blob.core.windows.net` |

> [!TIP]
> Each script below prompts you for the required values interactively - just select **Try It** to open Cloud Shell and answer the prompts. The session caches values, so you only enter them once.

---

## Diagnostic steps

> **These steps are read-only. They don't make any changes to your environment.**

---

### Step 1

**What this step checks:** It captures the exact error returned by the failing delete or migrate operation, plus the zone's current dependency counts. The error code routes you to the correct branch. If you skip this check, the rest of this guide is wasted effort. This step only reads state; it doesn't retry the delete.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

# Read-only: current zone state and dependency counts.
az network private-dns zone show \
  --name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{state:provisioningState, vnetLinks:numberOfVirtualNetworkLinks, recordSets:numberOfRecordSets}" \
  --output json 2>&1 || true

# Read-only: the error code from your most recent failed delete or move.
ZONE_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/privateDnsZones/$ZONE_NAME"
az monitor activity-log list \
  --resource-id "$ZONE_ID" \
  --offset 6h \
  --query "reverse(sort_by([?status.value=='Failed'], &eventTimestamp))[0:5].{time:eventTimestamp, op:operationName.localizedValue, status:status.value, code:properties.statusCode, sub:subStatus.value}" \
  --output table
```

#### Interpret the result

**Route by the failed-operation error `code` first - it's the primary discriminator.** Read the `code` (and `sub`) of the most recent failed operation from the activity-log table in the preceding section. If the activity log doesn't yet record the failure, use the error `code` or error text your delete or move command returned. Match the **first** row in the following table whose error `code` matches, and follow it.

The `vnetLinks` and `recordSets` counts from the `zone show` call are **context only - they never override the error code.** A healthy, normally-linked zone routinely reports `vnetLinks` greater than `0`, so a zone failing for a lock, quota, or visibility-lag reason also shows `vnetLinks > 0`. The link count routes you to [Step 2](#step-2) **only when the error itself is a virtual-network-link precondition** (`PreconditionFailed` / `DnsZoneInUse`). A non-link error code always wins over the link count.

| If the failed-operation `code` (or error text) is... | Meaning | Next step |
|---|---|---|
| `PreconditionFailed` or `DnsZoneInUse`, or the message names `virtual network links` | Delete is blocked by a virtual-network-link precondition | → [Step 2](#step-2) |
| `ScopeLocked` or `ResourceLocked` | A `CanNotDelete` lock is in place at the zone, RG, or subscription scope | → [Step 4](#step-4) |
| `RecordSetCountLimitExceeded` or `QuotaExceeded` | Migration or bulk update tripped a record-set or processing limit - even if `vnetLinks` is greater than `0` | → [Step 5](#step-5) |
| `ResourceNotFound` from the `zone show` call, or the failed operation actually shows `Succeeded` | Zone is already deleted or moved. The portal cache or ARM control-plane sync is lagging - even if `vnetLinks` is greater than `0` | → [Step 6](#step-6) |
| `Cannot delete resource while nested resources exist` and `vnetLinks` is `0` | Hidden or orphaned link object that doesn't render through the standard CLI | → [Step 3](#step-3) |
| No failed operation is recorded anywhere, the zone still won't delete, and the only signal is `vnetLinks` greater than `0` | An attached VNet link is the most likely blocker. Verify it directly | → [Step 2](#step-2) |
| Any other error code | Capture `correlationId` from the activity log and route based on the subsystem named in the message | → [Decision map](#decision-map) |

---

### Step 2

**What this check does:** It checks for visible virtual network links on the zone. The standard delete path enforces these dependencies.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az network private-dns link vnet list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| One or more rows listed | You must remove visible links before you can delete the zone | → [Resolution A](#resolution-a) |
| Empty result `[]` but Step 1 returned a `nested resources` error | The zone has hidden or orphaned links that this command doesn't show | → [Step 3](#step-3) |
| Empty result and Step 1 returned `ResourceNotFound` | The zone is already gone; this is a portal-cache problem | → [Step 6](#step-6) |
| `AuthorizationFailed` | The signed-in identity lacks `Microsoft.Network/privateDnsZones/virtualNetworkLinks/read` permission | Have a zone owner re-run the command, then return to this step |

---

### Step 3

**What this check does:** Finds orphaned or invisible VNet links by using the raw ARM API. The standard `link vnet list` command can omit links whose backing VNet was deleted, lives in a different subscription, or is stuck mid-provisioning. Calling the management plane directly returns the authoritative list.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

# Authoritative enumeration of every virtualNetworkLink child resource on
# the zone, including links whose VNet has been deleted.
az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/privateDnsZones/$ZONE_NAME/virtualNetworkLinks?api-version=2024-06-01" \
  --query "value[].{name:name, state:properties.provisioningState, vnet:properties.virtualNetwork.id, registration:properties.registrationEnabled}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| One or more links listed that didn't appear in [Step 2](#step-2) | Orphaned, cross-subscription, or stale links - these links block deletion | → [Resolution B](#resolution-b) |
| A link with `state: Failed` or `Updating` | Link is stuck in a non-terminal state and blocks the parent zone | → [Resolution B](#resolution-b) |
| Same set of links as [Step 2](#step-2) | No hidden links; route by the original error from [Step 1](#step-1) | → [Decision map](#decision-map) |
| Empty `value: []` and Step 1 still fails with nested-resources | Re-check after 5 minutes for control-plane convergence. If the problem persists, open a support case. | → [Step 6](#step-6) |

---

### Step 4

**What this check does:** Resource locks at zone, resource-group, and subscription scope. A `CanNotDelete` lock at any ancestor scope blocks the delete and is invisible if you only inspect the zone itself.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az account set --subscription "$SUBSCRIPTION"

echo "─── Locks on zone ───"
az lock list \
  --resource-group "$RG" \
  --resource-name "$ZONE_NAME" \
  --resource-type Microsoft.Network/privateDnsZones \
  --output table

echo "─── Locks on resource group ───"
az lock list --resource-group "$RG" --output table

echo "─── Locks on subscription ───"
az lock list --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| At least one lock with `Level: CanNotDelete` at any scope above the zone | Delete is blocked until the lock is removed | → [Resolution C](#resolution-c) |
| At least one lock with `Level: ReadOnly` at any scope above the zone | `ReadOnly` blocks both updates and deletes, so it also blocks the zone delete | → [Resolution C](#resolution-c) |
| No locks at any scope | Locks aren't the cause; route back to the [Step 1](#step-1) error | → [Decision map](#decision-map) |

---

### Step 5

**What this check does:** It checks whether the zone is at or near the per-zone record-set limit. Bulk migrations (Azure DNS Migration Tool, Terraform plans, ARM exports) commonly hit this limit without a clear error.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

# Count record-sets in the zone. The default per-zone limit is 25,000
# record sets; the default records-per-record-set limit is 20.
RECORDSET_COUNT=$(az network private-dns record-set list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "length(@)" \
  --output tsv)

echo "Record sets in $ZONE_NAME: $RECORDSET_COUNT"

# Find any record set with > 15 records — close to the 20-record default.
az network private-dns record-set list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?length(aRecords || \`[]\`) > \`15\` || length(aaaaRecords || \`[]\`) > \`15\` || length(txtRecords || \`[]\`) > \`15\`].{name:name, type:type}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `RECORDSET_COUNT` ≥ 25,000 | Zone is at the default record-set limit; new records are rejected | → [Resolution D](#resolution-d) |
| `RECORDSET_COUNT` between 20,000 and 25,000 and a migration is planned | Migration hits the limit mid-flight | → [Resolution D](#resolution-d) |
| One or more record sets show ≥ 15 records of a single type | Approaching the 20-records-per-set default; bulk imports adding records to existing sets fail | → [Resolution D](#resolution-d) |
| Counts well below the limits and Step 1 returned `RecordSetCountLimitExceeded` | The limit was hit on a different zone in the same operation; re-run this step against that zone | → [Step 5](#step-5) |
| Counts well below limits and migration still fails for another reason | Quota isn't the cause | → [Decision map](#decision-map) |

---

### Step 6

**What this check does:** It verifies whether the operation actually succeeded and if you're seeing portal cache lag. After a resource-group move or a long-running delete, the portal can show the zone for several minutes after ARM already removed it. CLI is the source of truth.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

echo "─── Direct read against the zone ───"
az network private-dns zone show \
  --name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, state:provisioningState, recordCount:numberOfRecordSets}" \
  --output json 2>&1 || true

echo "─── Recent activity log for the zone ───"
ZONE_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/privateDnsZones/$ZONE_NAME"
az monitor activity-log list \
  --resource-id "$ZONE_ID" \
  --offset 24h \
  --query "[?status.value=='Failed' || operationName.value=='Microsoft.Network/privateDnsZones/delete' || operationName.value=='Microsoft.Resources/subscriptions/resourceGroups/moveResources/action'].{time:eventTimestamp, op:operationName.localizedValue, status:status.value, code:properties.statusCode, corr:correlationId}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `ResourceNotFound` from the `zone show` call | Zone is already deleted at the ARM level; portal catches up | → [Resolution E](#resolution-e) |
| Activity log shows `delete` with `status: Succeeded` in the last few minutes | Delete already completed; portal is lagging | → [Resolution E](#resolution-e) |
| Activity log shows `moveResources/action` with `status: Succeeded` and records missing in portal | RG move succeeded; record visibility is converging | → [Resolution E](#resolution-e) |
| Activity log shows `delete` with `status: Failed` and a non-link reason not yet covered | Capture the correlation ID and open a support case | File a support request with the correlation ID |
| Zone still exists and no recent terminal events | Operation is still in flight; wait 5 minutes and re-run [Step 1](#step-1) | → [Step 1](#step-1) |

---

## Decision map

| Diagnostic result | Next action |
|---|---|
| Step 1: `PreconditionFailed` + `virtual network links` AND Step 2 lists links | [Resolution A — remove visible VNet links](#resolution-a) |
| Step 1: `Cannot delete resource while nested resources exist` AND Step 2 is empty AND Step 3 lists links | [Resolution B — remove orphaned/invisible links via ARM](#resolution-b) |
| Step 1: `ScopeLocked` / `ResourceLocked` AND Step 4 lists a `CanNotDelete` lock | [Resolution C — remove or downgrade the resource lock](#resolution-c) |
| Step 1: `RecordSetCountLimitExceeded` / `QuotaExceeded` AND Step 5 confirms record-set count near or at limit | [Resolution D — stage migration and request quota increase](#resolution-d) |
| Step 1: `ResourceNotFound` OR Step 6 shows the operation already succeeded | [Resolution E — wait out portal sync, do not retry](#resolution-e) |
| All diagnostics pass and the operation still fails | File an Azure support request with the correlation ID captured in [Step 1](#step-1) |

---

## Resolution A

**Root cause:** One or more virtual network links still reference the zone. Azure private DNS rejects zone deletion while any link exists, even links you no longer use.

### A.1

Confirm the exact link names from [Step 2](#step-2). For each link, also note `registrationEnabled` - if it was the auto-registration link for a VNet, removing it stops auto-registration on that VNet.

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az network private-dns link vnet list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, vnet:virtualNetwork.id, registration:registrationEnabled, state:provisioningState}" \
  --output table
```

Record each `name` value; you use it in A.2.

### A.2

> **⚠️ WRITE OPERATION - requires customer approval before executing**

> [!TIP]
> Review the following command and understand what it does before executing. This is a write operation. Removing the auto-registration link of a VNet permanently breaks name auto-registration for VMs in that VNet against this zone.

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME
[ -z "$LINK_NAME" ] && read -rp "Link name to delete:    " LINK_NAME

az network private-dns link vnet delete \
  --name "$LINK_NAME" \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --yes
```

Repeat for every link returned by A.1.

### A.3

Re-run [Step 2](#step-2). When the list is empty, retry the original delete:

> **⚠️ WRITE OPERATION - requires customer approval before executing**

> [!TIP]
> Review the following command and understand what it does before executing. This is a write operation. Deleting a private DNS zone permanently removes the zone and every record set it contains; recovery requires re-creating the zone and re-importing records.

**Azure CLI:**
```azurecli-interactive
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az network private-dns zone delete \
  --name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --yes
```

If deletion still fails with `nested resources exist`, proceed to [Resolution B](#resolution-b).

---

## Resolution B

**Root cause:** The zone has one or more orphaned virtual network links - child resources whose backing VNet was deleted, lives in a foreign subscription you no longer have access to, or is stuck in a non-terminal provisioning state. The standard `link vnet` commands omit these links because they can't resolve the VNet target, but the link object itself still exists and still blocks the parent zone.

### B.1

From [Step 3](#step-3), capture the full resource ID of every orphaned link. Build it from the zone scope:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/privateDnsZones/$ZONE_NAME/virtualNetworkLinks?api-version=2024-06-01" \
  --query "value[].id" \
  --output tsv
```

### B.2

> **⚠️ WRITE OPERATION - requires customer approval before executing**

> [!TIP]
> Review the following command and understand what it does before executing. This command deletes the orphaned link record in ARM. The backing VNet is unaffected (and in many cases no longer exists).

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$LINK_ID" ] && read -rp "Orphaned link resource ID: " LINK_ID

az rest --method delete \
  --url "https://management.azure.com${LINK_ID}?api-version=2024-06-01"
```

If `az rest delete` returns `202 Accepted` with no body, the delete is asynchronous - wait 30-60 seconds for ARM to converge. If it returns `409 Conflict` with `LinkedScopeIsNotInSucceededState`, the link is stuck mid-update. Let it converge and retry, or open a support case with the correlation ID.

Repeat for every orphaned link from B.1.

### B.3

Re-run [Step 3](#step-3). When the list is empty, retry the zone delete from [A.3](#a3). If links keep reappearing, ARM didn't finish propagating the upstream change (for example a recently-deleted VNet). Wait 10 minutes and re-check before opening a support case.

---

## Resolution C

**Root cause:** A `CanNotDelete` or `ReadOnly` resource lock at the zone, resource-group, or subscription scope is blocking the delete. Both lock levels prevent deletion. ARM evaluates locks across scopes, so a lock at any ancestor scope is sufficient to block a child operation.

### C.1

From [Step 4](#step-4), identify the lock that applies. Note the scope (zone, RG, or subscription), the lock's `name`, and (if known) the team or process that created it. Locks are usually placed deliberately - confirm with the owning team before removing.

### C.2

> **⚠️ WRITE OPERATION - requires customer approval before executing**

> [!TIP]
> Review the following command and understand what it does before executing. Removing a lock removes a guardrail; only remove a lock at the scope you actually need to mutate.

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$LOCK_ID" ] && read -rp "Lock resource ID to delete: " LOCK_ID

az lock delete --ids "$LOCK_ID"
```

If the lock must remain in place for governance reasons, don't rely on downgrading it - a `ReadOnly` lock also blocks deletion. Either remove the lock for a coordinated maintenance window, scope it more tightly so it no longer covers the zone, or have the lock owner perform the delete.

### C.3

Re-run [Step 1](#step-1). If the original error code was `ScopeLocked` and the lock list is now empty, retry the delete from [A.3](#a3). If a different error returns, route via the [Decision map](#decision-map).

---

## Resolution D

**Root cause:** The zone is at or approaching the default record-set quota (25,000 record sets per private DNS zone) or the per-record-set limit (20 records of a single type). Bulk migrations and ARM template imports trip this gate without explicit pre-checks.

### D.1

Decide between two paths based on [Step 5](#step-5):

- **Splittable migration:** You can partition the source zone across multiple destination zones (for example, by subdomain). Stage the migration in batches, each well below 25,000 record sets.
- **Single-zone migration:** The namespace must remain a single authoritative zone. File a quota-increase request before retrying.

### D.2

To file a quota increase, open a support request scoped to the subscription and the `Microsoft.Network` provider. For the request type, select **Service and subscription limits (quotas)**. For the quota type, select **Networking → Private DNS**. Specify the target record-set count and the zone name.

> [!TIP]
> Until the quota request is approved, don't retry the failing migration. Repeated failures generate noise without changing the outcome.

### D.3

For staged migrations, plan batches that each leave headroom of at least 10% below the per-zone limit:

**Azure CLI (read-only - sample to size a batch):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

# Group record-sets by type to see where the volume is concentrated.
az network private-dns record-set list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].type" \
  --output tsv | sort | uniq -c | sort -rn
```

Use the type distribution to design batches that respect both the per-zone (25,000) and per-record-set (20 records) limits.

### D.4

After the staged migration completes (or the quota increase is granted), re-run [Step 5](#step-5) and confirm `RECORDSET_COUNT` matches the expected total and no record set exceeds the per-set limit.

---

## Resolution E

**Root cause:** The delete or move operation already succeeds at the ARM control-plane layer. The portal cache, downstream Resource Graph indexers, or peered services are still converging. This condition isn't an outage and retrying doesn't fix it.

### E.1

Treat CLI as the source of truth. The portal is a view, not the system of record:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

# A clean ResourceNotFound here means the zone is gone in ARM.
az network private-dns zone show \
  --name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json 2>&1 || true
```

If this command returns `ResourceNotFound`, the zone is deleted. The portal reconciles within 15 minutes. Force a refresh by closing the resource blade and re-navigating from the resource group.

### E.2

For records missing after RG move:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Destination Resource Group: " RG
[ -z "$ZONE_NAME" ] && read -rp "Private DNS Zone Name:  " ZONE_NAME

az network private-dns record-set list \
  --zone-name "$ZONE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "length(@)" \
  --output tsv
```

Compare this count to the count taken before the RG move. If the counts match, records are intact - don't restore from a backup. The portal blade for the destination zone might show 0 records for up to 30 minutes after a move. Don't retry the move.

### E.3

If after 30 minutes the portal still shows the deleted zone or the record count still disagrees with [E.2](#e2), open a support case by using the correlation IDs from [Step 1](#step-1) and [Step 6](#step-6).

---

## Related articles

- [Manage private DNS zones with Azure CLI](/cli/azure/network/private-dns/zone)
- [Manage virtual network links with Azure CLI](/cli/azure/network/private-dns/link/vnet)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources)
- [Azure subscription and service limits — DNS](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-dns-limits)
