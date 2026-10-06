---
title: Troubleshoot Network Watcher packet-capture failures and unsupported targets
description: Fix Azure Network Watcher packet capture failures caused by unsupported targets, agent errors, storage settings, and session conflicts. Follow these steps.
ms.service: azure-network-watcher
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.review: chadmat
ms.topic: troubleshooting
ms.date: 10/02/2026
ai-usage: ai-assisted
---

# Troubleshoot Network Watcher packet capture failures and unsupported targets

## Summary

This article helps you troubleshoot Azure Network Watcher packet capture failures and unsupported targets.

Azure Network Watcher packet capture fails when the requested target isn't a virtual machine (VM) or virtual machine scale set (VMSS), the target has a missing or unhealthy Network Watcher Agent extension, or the capture destination and session name conflict with service requirements. Use this guide to help you identify the supported capture point before checking the agent, storage, and existing capture state.

## Symptoms

- Network Watcher doesn't list an App Service, function app, Azure Kubernetes Service (AKS) cluster, load balancer, firewall, or other managed service as a packet capture target.
- A packet capture create operation returns `Unsupported target type` or rejects the target resource ID.
- A capture remains in a failed state or reports an agent communication error.
- A storage capture fails to upload, or no capture file appears in the `network-watcher-logs` container after the session stops.
- A retry reports that the packet capture name or metadata already exists.
- A VMSS capture fails on one instance even though the extension exists in the scale-set model.

## Prerequisites

- **Permissions required:** `Network Contributor` on the Network Watcher and target VM or VMSS scopes, plus `Reader` on the storage account. Installing or repairing an extension requires VM or VMSS extension write permission.
- **Tools:** Azure Cloud Shell in Bash mode with Azure CLI 2.x and `jq`.
- **Starting information:** Have the requested capture target's full resource ID. If the failed capture used storage, also have the storage account resource ID. The diagnostics determine whether the target and destination are supported and usable.
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Subscription ID containing the requested target | `00000000-0000-0000-0000-000000000000` |
| `$RG` | Resource group to search for a supported IaaS capture point | `prod-network-rg` |
| `$TARGET_RESOURCE_ID` | Full resource ID of the requested capture target | `/subscriptions/.../virtualMachines/prod-vm` |
| `$LOCATION` | Azure region of the target and Network Watcher | `eastus` |
| `$PACKET_CAPTURE_NAME` | Existing failed capture name, or a unique name for a new capture | `prod-vm-20260825` |
| `$VMSS_INSTANCE_ID` | VMSS instance ID to inspect and capture | `0` |
| `$CAPTURE_DESTINATION` | Capture destination, either `local` or `storage` | `local` |
| `$STORAGE_ACCOUNT_RESOURCE_ID` | Full resource ID of the storage account, when using storage | `/subscriptions/.../storageAccounts/prodcaptures` |
| `$LOCAL_FILE_PATH` | Valid path on the target VM for a local capture | `/var/captures/prod-vm.cap` |

> **TIP:** Each script prompts for required values interactively. Values are cached for the Cloud Shell session, so you enter them only once.

> [!IMPORTANT]
> Run the diagnostics in order. An unsupported managed-service target can't be repaired by changing the Network Watcher Agent or storage account.

---

## Diagnostic steps

> **These steps are read-only. They don't make any changes to your environment.**

---

### Step 1

**What this step checks:** Whether the requested resource is a supported VM or VMSS capture target. This check happens before any agent or storage troubleshooting begins.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:             " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Requested target resource ID: " TARGET_RESOURCE_ID

TARGET_JSON=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

RESOURCE_TYPE=$(jq -r '.type // "" | ascii_downcase' <<< "$TARGET_JSON")
case "$RESOURCE_TYPE" in
  microsoft.compute/virtualmachines)
    CAPTURE_TARGET_TYPE=AzureVM
    ;;
  microsoft.compute/virtualmachinescalesets)
    CAPTURE_TARGET_TYPE=AzureVMSS
    ;;
  *)
    CAPTURE_TARGET_TYPE=Unsupported
    ;;
esac

echo "CAPTURE_TARGET_TYPE=$CAPTURE_TARGET_TYPE"
jq '{name,resourceGroup,location,type,id}' <<< "$TARGET_JSON"
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `CAPTURE_TARGET_TYPE=AzureVM` | The resource is a supported VM target | -> [Step 2](#step-2) |
| `CAPTURE_TARGET_TYPE=AzureVMSS` | The resource is a supported VMSS target. You capture a specific instance later. | -> [Step 2](#step-2) |
| `CAPTURE_TARGET_TYPE=Unsupported` | Network Watcher can't install its capture agent on this resource type. | -> [Resolution A](#resolution-a) |
| `ResourceNotFound` | The resource ID is wrong, deleted, or in a subscription unavailable to the signed-in identity. | Correct the resource ID and rerun Step 1 |
| `AuthorizationFailed` | The identity can't read the requested resource. | Obtain read access at the target scope, then rerun Step 1 |

---

### Step 2

**What this checks:** Whether the supported target model contains the Network Watcher Agent type that matches its operating system and whether extension provisioning succeeded.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "VM or VMSS resource ID: " TARGET_RESOURCE_ID

TARGET_JSON=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

TARGET_RG=$(jq -r '.resourceGroup' <<< "$TARGET_JSON")
TARGET_NAME=$(jq -r '.name' <<< "$TARGET_JSON")
RESOURCE_TYPE=$(jq -r '.type | ascii_downcase' <<< "$TARGET_JSON")

if [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachines" ]]; then
  OS_TYPE=$(az vm show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
  EXTENSIONS_JSON=$(az vm extension list \
    --resource-group "$TARGET_RG" \
    --vm-name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --output json \
    --verbose) || exit
elif [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachinescalesets" ]]; then
  OS_TYPE=$(az vmss show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'virtualMachineProfile.storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
  EXTENSIONS_JSON=$(az vmss extension list \
    --resource-group "$TARGET_RG" \
    --vmss-name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --output json \
    --verbose) || exit
else
  echo "SUPPORTED_TARGET=false"
  exit 0
fi

if [[ "${OS_TYPE,,}" == "windows" ]]; then
  EXPECTED_EXTENSION_TYPE=NetworkWatcherAgentWindows
else
  EXPECTED_EXTENSION_TYPE=NetworkWatcherAgentLinux
fi

MATCHING_EXTENSIONS=$(jq \
  --arg expected "$EXPECTED_EXTENSION_TYPE" \
  '[.[] | select(.publisher == "Microsoft.Azure.NetworkWatcher" and ((.typePropertiesType // .virtualMachineExtensionType // .properties.type // .type // "") == $expected))]' \
  <<< "$EXTENSIONS_JSON")

echo "OS_TYPE=$OS_TYPE"
echo "EXPECTED_EXTENSION_TYPE=$EXPECTED_EXTENSION_TYPE"
echo "MATCHING_EXTENSION_COUNT=$(jq 'length' <<< "$MATCHING_EXTENSIONS")"
jq '[.[] | select(.publisher == "Microsoft.Azure.NetworkWatcher") | {name,publisher,type:(.typePropertiesType // .virtualMachineExtensionType // .properties.type // .type),provisioningState,autoUpgradeMinorVersion,enableAutomaticUpgrade}]' \
  <<< "$EXTENSIONS_JSON"
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `MATCHING_EXTENSION_COUNT=0` | The agent is absent or the Windows/Linux extension type doesn't match the target OS | -> [Resolution B](#resolution-b) |
| Matching extension with `provisioningState: Succeeded` on an Azure VM | The VM model has the correct provisioned agent | -> [Step 3](#step-3) |
| Matching extension with `provisioningState: Succeeded` on an Azure VMSS | The VMSS model is correct, but the selected instance might not have the model | -> [Step 2a](#step-2a) |
| Matching extension with any provisioning state other than `Succeeded` | The agent installation or update failed | -> [Resolution B](#resolution-b) |
| `SUPPORTED_TARGET=false` | The supplied resource isn't a VM or VMSS | -> [Resolution A](#resolution-a) |
| `AuthorizationFailed` | The identity can't read the target or its extensions | Obtain VM or VMSS read access, then rerun Step 2 |

---

### Step 2a

**What this checks:** Whether the selected VMSS instance applied the latest scale-set model and reports a successful Network Watcher Agent status.

Run this step only for a VMSS target.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "VMSS resource ID:         " TARGET_RESOURCE_ID
[ -z "$VMSS_INSTANCE_ID" ] && read -rp "VMSS instance ID:         " VMSS_INSTANCE_ID

TARGET_JSON=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

TARGET_RG=$(jq -r '.resourceGroup' <<< "$TARGET_JSON")
TARGET_NAME=$(jq -r '.name' <<< "$TARGET_JSON")
EXTENSION_NAME=$(az vmss extension list \
  --resource-group "$TARGET_RG" \
  --vmss-name "$TARGET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[?publisher=='Microsoft.Azure.NetworkWatcher'] | [0].name" \
  --output tsv \
  --verbose) || exit

INSTANCE_VIEW=$(az vmss list-instances \
  --resource-group "$TARGET_RG" \
  --name "$TARGET_NAME" \
  --expand instanceView \
  --subscription "$SUBSCRIPTION" \
  --query "[?instanceId=='$VMSS_INSTANCE_ID'] | [0]" \
  --output json \
  --verbose) || exit

if [[ "$INSTANCE_VIEW" == "null" ]]; then
  echo "ResourceNotFound: VMSS instance $VMSS_INSTANCE_ID isn't present."
  exit 1
fi

echo "EXPECTED_EXTENSION_NAME=$EXTENSION_NAME"
jq \
  --arg extensionName "$EXTENSION_NAME" \
  '{latestModelApplied,vmAgent:.instanceView.vmAgent,extension:[.instanceView.extensions[]? | select(.name == $extensionName) | {name,typeHandlerVersion,statuses}]}' \
  <<< "$INSTANCE_VIEW"
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `latestModelApplied: true` and the extension status code ends in `ProvisioningState/succeeded` | The selected instance has a healthy Network Watcher Agent | -> [Step 3](#step-3) |
| `latestModelApplied: false` | The selected instance didn't receive the current VMSS extension model | -> [Resolution B](#resolution-b) |
| An empty `extension` array | The agent model isn't applied to this instance | -> [Resolution B](#resolution-b) |
| Extension status code ends in `ProvisioningState/failed` or contains an error message | Agent provisioning failed on this instance | -> [Resolution B](#resolution-b) |
| `ResourceNotFound` for the instance | The instance ID isn't present in the VMSS | List current instance IDs, correct `$VMSS_INSTANCE_ID`, and rerun Step 2a |

---

### Step 3

**What this checks:** Whether the selected destination is local storage or a storage account whose region, tier, shared-key setting, and network policy support packet-capture output.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "VM or VMSS resource ID:  " TARGET_RESOURCE_ID
if [ -z "$CAPTURE_DESTINATION" ]; then
  read -rp "Capture destination (local/storage) [local]: " CAPTURE_DESTINATION
  CAPTURE_DESTINATION=${CAPTURE_DESTINATION:-local}
fi

TARGET_LOCATION=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --query location \
  --output tsv \
  --verbose) || exit

if [[ "${CAPTURE_DESTINATION,,}" == "local" ]]; then
  echo "CAPTURE_DESTINATION=local"
  echo "TARGET_LOCATION=$TARGET_LOCATION"
  exit 0
fi

[ -z "$STORAGE_ACCOUNT_RESOURCE_ID" ] && read -rp "Storage account resource ID: " STORAGE_ACCOUNT_RESOURCE_ID

STORAGE_JSON=$(az storage account show \
  --ids "$STORAGE_ACCOUNT_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

STORAGE_LOCATION=$(jq -r '.location' <<< "$STORAGE_JSON")
if [[ "${TARGET_LOCATION,,}" == "${STORAGE_LOCATION,,}" ]]; then
  REGION_MATCH=true
else
  REGION_MATCH=false
fi

echo "CAPTURE_DESTINATION=storage"
echo "TARGET_LOCATION=$TARGET_LOCATION"
echo "REGION_MATCH=$REGION_MATCH"
jq '{name,id,location,kind,skuTier:.sku.tier,allowSharedKeyAccess,publicNetworkAccess,networkDefaultAction:.networkRuleSet.defaultAction,virtualNetworkRules:.networkRuleSet.virtualNetworkRules}' \
  <<< "$STORAGE_JSON"
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `CAPTURE_DESTINATION=local` | Storage-account restrictions don't apply | -> [Step 4](#step-4) |
| `REGION_MATCH=true`, `skuTier: Standard`, shared-key access isn't `false`, and `networkDefaultAction: Allow` | The storage account's control-plane prerequisites are satisfied | -> [Step 4](#step-4) |
| `REGION_MATCH=false` | Packet capture can't use a storage account in another region | -> [Resolution C](#resolution-c) |
| `skuTier: Premium` | Premium storage isn't supported for packet-capture output | -> [Resolution C](#resolution-c) |
| `allowSharedKeyAccess: false` | Network Watcher can't authorize its SAS-token upload | -> [Resolution C](#resolution-c) |
| `publicNetworkAccess: Disabled` | The target can't upload through the storage public endpoint | -> [Resolution C](#resolution-c) |
| `networkDefaultAction: Deny` | The storage firewall restricts packet-capture uploads; the account isn't usable until its approved network policy permits the target | -> [Resolution C](#resolution-c) |
| `ResourceNotFound` | The storage resource ID is wrong, deleted, or inaccessible | Correct the ID or go to [Resolution C](#resolution-c) |

---

### Step 4

**What this checks:** Whether the requested packet-capture name already exists and whether an existing session is still running or stopped with errors.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$LOCATION" ] && read -rp "Target Azure region:   " LOCATION
[ -z "$PACKET_CAPTURE_NAME" ] && read -rp "Packet-capture name:   " PACKET_CAPTURE_NAME

CAPTURES_JSON=$(az network watcher packet-capture list \
  --location "$LOCATION" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

MATCHING_CAPTURE=$(jq --arg name "$PACKET_CAPTURE_NAME" '[.[] | select(.name == $name)]' <<< "$CAPTURES_JSON")
MATCHING_CAPTURE_COUNT=$(jq 'length' <<< "$MATCHING_CAPTURE")
echo "MATCHING_CAPTURE_COUNT=$MATCHING_CAPTURE_COUNT"

if [[ "$MATCHING_CAPTURE_COUNT" -gt 0 ]]; then
  jq '.[0] | {name,provisioningState,target,targetType,storageLocation,timeLimitInSeconds}' <<< "$MATCHING_CAPTURE"
  az network watcher packet-capture show-status \
    --location "$LOCATION" \
    --name "$PACKET_CAPTURE_NAME" \
    --subscription "$SUBSCRIPTION" \
    --output json \
    --verbose
fi
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `MATCHING_CAPTURE_COUNT=0` | No Network Watcher session uses this name | -> [Resolution E](#resolution-e) |
| `packetCaptureStatus: Running` | The name belongs to an active session | -> [Resolution D](#resolution-d) |
| `packetCaptureStatus: Stopped` and `packetCaptureError` is empty | The prior session completed, but its Network Watcher resource still occupies the name | -> [Resolution D](#resolution-d) |
| `packetCaptureError` reports an extension or agent failure | The control plane reached the session, but the target agent couldn't complete it | -> [Resolution B](#resolution-b) |
| `packetCaptureError` reports storage, SAS, access, or upload failure | The capture destination isn't usable from the target | -> [Resolution C](#resolution-c) |
| `ResourceNotFound` from `show-status` after the list returned a match | The session was deleted between the two calls | Use a unique name and go to [Resolution E](#resolution-e) |

---

## Decision map

| Source | Diagnostic result | Next action |
|---|---|---|
| Step 1 | `CAPTURE_TARGET_TYPE=AzureVM` | [Step 2](#step-2) |
| Step 1 | `CAPTURE_TARGET_TYPE=AzureVMSS` | [Step 2](#step-2) |
| Step 1 | `CAPTURE_TARGET_TYPE=Unsupported` | [Resolution A](#resolution-a) |
| Step 1 | `ResourceNotFound` | Correct `$TARGET_RESOURCE_ID`, then rerun [Step 1](#step-1) |
| Step 1 | `AuthorizationFailed` | Obtain read access at the target scope, then rerun [Step 1](#step-1) |
| Step 2 | Matching extension is absent | [Resolution B](#resolution-b) |
| Step 2 | Matching extension is `Succeeded` on a VM | [Step 3](#step-3) |
| Step 2 | Matching extension is `Succeeded` on a VMSS | [Step 2a](#step-2a) |
| Step 2 | Matching extension isn't `Succeeded` | [Resolution B](#resolution-b) |
| Step 2 | `SUPPORTED_TARGET=false` | [Resolution A](#resolution-a) |
| Step 2 | `AuthorizationFailed` | Obtain VM or VMSS read access, then rerun [Step 2](#step-2) |
| Step 2a | Latest model is applied and extension status is `ProvisioningState/succeeded` | [Step 3](#step-3) |
| Step 2a | `latestModelApplied: false` | [Resolution B](#resolution-b) |
| Step 2a | Extension array is empty | [Resolution B](#resolution-b) |
| Step 2a | Extension status is failed or contains an error | [Resolution B](#resolution-b) |
| Step 2a | `ResourceNotFound` for the instance | List current instance IDs, correct `$VMSS_INSTANCE_ID`, then rerun [Step 2a](#step-2a) |
| Step 3 | `CAPTURE_DESTINATION=local` | [Step 4](#step-4) |
| Step 3 | Storage region, tier, shared-key, and network checks pass | [Step 4](#step-4) |
| Step 3 | `REGION_MATCH=false` | [Resolution C](#resolution-c) |
| Step 3 | `skuTier: Premium` | [Resolution C](#resolution-c) |
| Step 3 | `allowSharedKeyAccess: false` | [Resolution C](#resolution-c) |
| Step 3 | `publicNetworkAccess: Disabled` | [Resolution C](#resolution-c) |
| Step 3 | `networkDefaultAction: Deny` without a confirmed approved path | [Resolution C](#resolution-c) |
| Step 3 | Storage account returns `ResourceNotFound` | Correct `$STORAGE_ACCOUNT_RESOURCE_ID`, or use [Resolution C](#resolution-c) |
| Step 4 | `MATCHING_CAPTURE_COUNT=0` | [Resolution E](#resolution-e) |
| Step 4 | `packetCaptureStatus: Running` | [Resolution D](#resolution-d) |
| Step 4 | `packetCaptureStatus: Stopped` with no error | [Resolution D](#resolution-d) |
| Step 4 | Agent or extension error | [Resolution B](#resolution-b) |
| Step 4 | Storage, SAS, access, or upload error | [Resolution C](#resolution-c) |
| Step 4 | `show-status` returns `ResourceNotFound` after a list match | Use a unique name, then go to [Resolution E](#resolution-e) |
| E.2 | Capture is running without an error | Reproduce the traffic, then stop the capture after collecting enough evidence |
| E.2 | Capture stops with `TimeExceeded` and no error | Confirm the `.cap` file at the selected destination |
| E.2 | Agent, extension, platform communication, or provisioning error | [Resolution B](#resolution-b) |
| E.2 | Storage, SAS, authorization, access, DNS, or upload error | [Resolution C](#resolution-c) |
| E.2 | Name, metadata, or already-exists error | [Resolution D](#resolution-d) |
| E.2 | Local capture succeeds but the managed-service boundary remains invisible | [Resolution A](#resolution-a) |
| E.2 | Any other nonempty error remains | File an Azure support request with the status output and capture resource ID |

---

## Resolution A

**Root cause:** Network Watcher packet capture is agent-based. It captures traffic on Azure VMs and VMSS instances; it can't directly attach to App Service, Functions, AKS clusters, load balancers, Azure Firewall, private endpoints, or another managed-service boundary.

> [!NOTE]
> The Network Watcher Agent extension isn't supported on AKS clusters. Don't install it on AKS-managed nodes to work around this boundary.

### A.1

List supported IaaS capture points in the resource group that contains the affected workload or its network virtual appliance.

**Azure CLI (read-only):**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:                    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Workload or network resource group: " RG

IAAS_TARGETS=$(az resource list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?type=='Microsoft.Compute/virtualMachines' || type=='Microsoft.Compute/virtualMachineScaleSets'].{name:name,type:type,location:location,id:id}" \
  --output json \
  --verbose) || exit

jq -r 'to_entries[] | "\(.key + 1)) \(.value.name) | \(.value.type) | \(.value.location) | \(.value.id)"' <<< "$IAAS_TARGETS"

TARGET_COUNT=$(jq 'length' <<< "$IAAS_TARGETS")
if [[ "$TARGET_COUNT" -gt 0 ]]; then
  [ -z "$TARGET_NUMBER" ] && read -rp "Select the capture-point number: " TARGET_NUMBER
  if ! [[ "$TARGET_NUMBER" =~ ^[0-9]+$ ]] || [[ "$TARGET_NUMBER" -lt 1 ]] || [[ "$TARGET_NUMBER" -gt "$TARGET_COUNT" ]]; then
    echo "Selection must be a number from 1 to $TARGET_COUNT."
    exit 1
  fi
  TARGET_RESOURCE_ID=$(jq -r --argjson index "$((TARGET_NUMBER - 1))" '.[$index].id' <<< "$IAAS_TARGETS")
  echo "TARGET_RESOURCE_ID=$TARGET_RESOURCE_ID"
fi
```

| If you see... | Meaning | Next step |
|---|---|---|
| A VM or VMSS that sends or receives the affected flow | That IaaS resource is a supported capture point | Set `$TARGET_RESOURCE_ID` to its full ID and rerun [Step 1](#step-1) |
| Only an NVA that is deployed as a VM or VMSS | Network Watcher can capture at that VM boundary, subject to the NVA vendor's support policy | Confirm vendor approval, then rerun [Step 1](#step-1) with that IaaS ID |
| No VM or VMSS on the required side of the flow | Network Watcher has no supported attachment point for this scenario | Use the managed service's native network trace, firewall logs, or application diagnostics |

### A.2

Don't substitute a load balancer, managed cluster, web app, function app, subnet, NIC, or private endpoint resource ID in the packet-capture command. Capture on a supported VM or VMSS endpoint, or use the service-native diagnostic that owns the managed boundary.

---

## Resolution B

**Root cause:** The diagnostics found that the target is supported, but its Network Watcher Agent is missing, has the wrong Windows/Linux type, failed provisioning, or wasn't applied to the selected VMSS instance.

### B.1

Install or force-update the OS-appropriate extension. For a VMSS, apply the updated model to the selected instance.

> **⚠️ WRITE OPERATION — requires customer approval before executing**

> **TIP:** Review the commands before executing. They update the target's extension model and, for a VMSS, apply that model to one instance.

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "VM or VMSS resource ID: " TARGET_RESOURCE_ID

TARGET_JSON=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

TARGET_RG=$(jq -r '.resourceGroup' <<< "$TARGET_JSON")
TARGET_NAME=$(jq -r '.name' <<< "$TARGET_JSON")
RESOURCE_TYPE=$(jq -r '.type | ascii_downcase' <<< "$TARGET_JSON")

if [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachines" ]]; then
  OS_TYPE=$(az vm show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
else
  OS_TYPE=$(az vmss show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'virtualMachineProfile.storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
fi

if [[ "${OS_TYPE,,}" == "windows" ]]; then
  EXTENSION_TYPE=NetworkWatcherAgentWindows
else
  EXTENSION_TYPE=NetworkWatcherAgentLinux
fi

if [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachines" ]]; then
  az vm extension set \
    --resource-group "$TARGET_RG" \
    --vm-name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --name "$EXTENSION_TYPE" \
    --extension-instance-name AzureNetworkWatcherExtension \
    --publisher Microsoft.Azure.NetworkWatcher \
    --version 1.4 \
    --enable-auto-upgrade true \
    --force-update \
    --verbose
else
  [ -z "$VMSS_INSTANCE_ID" ] && read -rp "VMSS instance ID to update: " VMSS_INSTANCE_ID
  az vmss extension set \
    --resource-group "$TARGET_RG" \
    --vmss-name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --name "$EXTENSION_TYPE" \
    --extension-instance-name AzureNetworkWatcherExtension \
    --publisher Microsoft.Azure.NetworkWatcher \
    --version 1.4 \
    --enable-auto-upgrade true \
    --force-update \
    --verbose && \
  az vmss update-instances \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --instance-ids "$VMSS_INSTANCE_ID" \
    --subscription "$SUBSCRIPTION" \
    --verbose
fi
```

### B.2

Rerun [Step 2](#step-2). For a VMSS, also rerun [Step 2a](#step-2a). Continue only when the matching extension and selected instance report `Succeeded`.

If provisioning still fails, use the extension status message from [Step 2](#step-2) or [Step 2a](#step-2a) to identify the failing dependency. Record that message and the extension resource ID before filing an Azure support request.

---

## Resolution C

**Root cause:** [Step 3](#step-3) found an unsupported storage configuration, or [Step 4](#step-4) reported a storage access, DNS, SAS, or upload failure. Packet capture uses a SAS token, so a storage destination must be Standard tier, in the target's region, permit shared-key access, and have a network policy that permits the upload.

### C.1

Use a local capture to separate packet-capture health from storage access. The capture in [Resolution E](#resolution-e) chooses an OS-valid default path when `$CAPTURE_DESTINATION` is `local`.

Set the session value before continuing:

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$CAPTURE_DESTINATION" ] && read -rp "Capture destination (local/storage) [local]: " CAPTURE_DESTINATION
CAPTURE_DESTINATION=${CAPTURE_DESTINATION:-local}

echo "CAPTURE_DESTINATION=$CAPTURE_DESTINATION"
```

| If you see... | Meaning | Next step |
|---|---|---|
| `CAPTURE_DESTINATION=local` | The next capture won't depend on storage-account access | -> [Resolution E](#resolution-e) |
| `CAPTURE_DESTINATION=storage` | You chose to repair or replace the storage path | Continue to C.2 |

### C.2

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command requests shared-key authorization on the approved storage account and verifies whether the setting was applied. If Azure Policy preserves the restriction, the script selects a local capture instead.

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:             " SUBSCRIPTION
[ -z "$STORAGE_ACCOUNT_RESOURCE_ID" ] && read -rp "Approved storage account ID: " STORAGE_ACCOUNT_RESOURCE_ID

STORAGE_UPDATE=$(az storage account update \
  --ids "$STORAGE_ACCOUNT_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --allow-shared-key-access true \
  --output json \
  --verbose) || exit

SHARED_KEY_ACCESS=$(jq -r '.allowSharedKeyAccess' <<< "$STORAGE_UPDATE")
jq '{name,id,allowSharedKeyAccess,publicNetworkAccess,networkDefaultAction:.networkRuleSet.defaultAction}' <<< "$STORAGE_UPDATE"

if [[ "$SHARED_KEY_ACCESS" == "true" ]]; then
  echo "SHARED_KEY_UPDATE_APPLIED=true"
else
  CAPTURE_DESTINATION=local
  echo "SHARED_KEY_UPDATE_APPLIED=false"
  echo "CAPTURE_DESTINATION=$CAPTURE_DESTINATION"
fi
```

Don't open a restricted storage firewall broadly to make a capture work. If the approved account uses `networkDefaultAction: Deny`, keep the capture local or use a different approved Standard account whose existing network policy permits the target. Rerun [Step 3](#step-3) for the replacement account.

### C.3

Rerun [Step 3](#step-3). If C.2 reports `SHARED_KEY_UPDATE_APPLIED=false`, keep `$CAPTURE_DESTINATION` set to `local`. Continue to [Resolution E](#resolution-e) only when the selected destination meets every applicable row. In E.2, a running capture with no error verifies the selected destination; a storage, DNS, access, SAS, or upload error returns you here with the observed failure.

---

## Resolution D

**Root cause:** A running or stopped Network Watcher packet-capture resource already uses the requested name. A stale session or agent metadata can also collide with a retry that reuses that name.

### D.1

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This script stops a running session, deletes its Network Watcher resource, and generates a unique name for the retry. It doesn't delete an existing capture file from storage or the VM.

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$LOCATION" ] && read -rp "Target Azure region:   " LOCATION
[ -z "$PACKET_CAPTURE_NAME" ] && read -rp "Existing capture name: " PACKET_CAPTURE_NAME

STATUS=$(az network watcher packet-capture show-status \
  --location "$LOCATION" \
  --name "$PACKET_CAPTURE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query packetCaptureStatus \
  --output tsv \
  --verbose) || exit

if [[ "${STATUS,,}" == "running" ]]; then
  az network watcher packet-capture stop \
    --location "$LOCATION" \
    --name "$PACKET_CAPTURE_NAME" \
    --subscription "$SUBSCRIPTION" \
    --verbose || exit
fi

az network watcher packet-capture delete \
  --location "$LOCATION" \
  --name "$PACKET_CAPTURE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --verbose || exit

PACKET_CAPTURE_NAME="capture-$(date -u +%Y%m%d%H%M%S)"
echo "NEW_PACKET_CAPTURE_NAME=$PACKET_CAPTURE_NAME"
```

### D.2

Rerun [Step 4](#step-4) with the generated name. Continue when it returns `MATCHING_CAPTURE_COUNT=0`.

---

## Resolution E

**Root cause:** No prerequisite failure remains. A short, bounded capture now proves whether the target agent and selected destination work together.

### E.1

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This script starts a five-minute capture, defaults to an OS-valid local path, and limits a VMSS capture to the selected instance.

> **TIP:** Packet captures can contain sensitive payload data. Limit access to the output and retain it only as long as required for troubleshooting.

**Azure CLI:**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "VM or VMSS resource ID: " TARGET_RESOURCE_ID
if [ -z "$PACKET_CAPTURE_NAME" ]; then
  read -rp "Unique capture name [generated]: " PACKET_CAPTURE_NAME
  PACKET_CAPTURE_NAME=${PACKET_CAPTURE_NAME:-capture-$(date -u +%Y%m%d%H%M%S)}
fi
if [ -z "$CAPTURE_DESTINATION" ]; then
  read -rp "Capture destination (local/storage) [local]: " CAPTURE_DESTINATION
  CAPTURE_DESTINATION=${CAPTURE_DESTINATION:-local}
fi

TARGET_JSON=$(az resource show \
  --ids "$TARGET_RESOURCE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json \
  --verbose) || exit

TARGET_RG=$(jq -r '.resourceGroup' <<< "$TARGET_JSON")
TARGET_NAME=$(jq -r '.name' <<< "$TARGET_JSON")
RESOURCE_TYPE=$(jq -r '.type | ascii_downcase' <<< "$TARGET_JSON")

CAPTURE_ARGS=(network watcher packet-capture create
  --resource-group "$TARGET_RG"
  --name "$PACKET_CAPTURE_NAME"
  --subscription "$SUBSCRIPTION"
  --time-limit 300)

if [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachines" ]]; then
  OS_TYPE=$(az vm show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
  CAPTURE_ARGS+=(--vm "$TARGET_RESOURCE_ID")
elif [[ "$RESOURCE_TYPE" == "microsoft.compute/virtualmachinescalesets" ]]; then
  [ -z "$VMSS_INSTANCE_ID" ] && read -rp "VMSS instance ID:      " VMSS_INSTANCE_ID
  OS_TYPE=$(az vmss show \
    --resource-group "$TARGET_RG" \
    --name "$TARGET_NAME" \
    --subscription "$SUBSCRIPTION" \
    --query 'virtualMachineProfile.storageProfile.osDisk.osType' \
    --output tsv \
    --verbose) || exit
  CAPTURE_ARGS+=(--target "$TARGET_RESOURCE_ID" --target-type AzureVMSS --include "$VMSS_INSTANCE_ID")
else
  echo "Unsupported target type: $(jq -r '.type' <<< "$TARGET_JSON")"
  exit 1
fi

if [[ "${CAPTURE_DESTINATION,,}" == "storage" ]]; then
  [ -z "$STORAGE_ACCOUNT_RESOURCE_ID" ] && read -rp "Storage account resource ID: " STORAGE_ACCOUNT_RESOURCE_ID
  CAPTURE_ARGS+=(--storage-account "$STORAGE_ACCOUNT_RESOURCE_ID")
else
  if [[ "${OS_TYPE,,}" == "windows" ]]; then
    DEFAULT_LOCAL_FILE_PATH="C:\\Captures\\$PACKET_CAPTURE_NAME.cap"
  else
    LINUX_CAPTURE_BASENAME=$(tr -cd '[:alnum:]' <<< "$PACKET_CAPTURE_NAME")
    DEFAULT_LOCAL_FILE_PATH="/var/captures/$LINUX_CAPTURE_BASENAME.cap"
  fi
  if [ -z "$LOCAL_FILE_PATH" ]; then
    read -rp "Local capture path [$DEFAULT_LOCAL_FILE_PATH]: " LOCAL_FILE_PATH
    LOCAL_FILE_PATH=${LOCAL_FILE_PATH:-$DEFAULT_LOCAL_FILE_PATH}
  fi
  CAPTURE_ARGS+=(--file-path "$LOCAL_FILE_PATH")
fi

az "${CAPTURE_ARGS[@]}" \
  --output json \
  --verbose
```

### E.2

Check the capture status after traffic crosses the target interface.

**Azure CLI (read-only):**
```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$LOCATION" ] && read -rp "Target Azure region:   " LOCATION
[ -z "$PACKET_CAPTURE_NAME" ] && read -rp "Packet-capture name:   " PACKET_CAPTURE_NAME

az network watcher packet-capture show-status \
  --location "$LOCATION" \
  --name "$PACKET_CAPTURE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query '{packetCaptureStatus:packetCaptureStatus,stopReason:stopReason,packetCaptureError:packetCaptureError,captureStartTime:captureStartTime}' \
  --output json \
  --verbose
```

| If you see... | Meaning | Next step |
|---|---|---|
| `packetCaptureStatus: Running` and an empty `packetCaptureError` | The capture started successfully | Reproduce the traffic, then stop the capture when you collect enough evidence |
| `packetCaptureStatus: Stopped`, `stopReason: TimeExceeded`, and an empty `packetCaptureError` | The bounded capture completed successfully | Confirm the `.cap` file at the selected destination |
| Agent, extension, platform communication, or provisioning text in `packetCaptureError` | The target agent path still fails | -> [Resolution B](#resolution-b) |
| Storage, SAS, authorization, access, DNS, or upload text in `packetCaptureError` | The storage destination still fails | -> [Resolution C](#resolution-c) |
| Name, metadata, or already-exists text in `packetCaptureError` | The retry collided with stale state | -> [Resolution D](#resolution-d) |
| Empty errors and a successful local capture, but the original managed-service boundary remains invisible | Network Watcher is healthy but doesn't own that capture boundary | -> [Resolution A](#resolution-a) |
| A different nonempty error remains after the matching resolution | The service returned an uncovered failure | File an Azure support request with this status output and the capture resource ID |

---

## References

- [Packet capture overview](/azure/network-watcher/packet-capture-overview)
- [Manage packet captures](/azure/network-watcher/packet-capture-manage)
- [Manage Network Watcher Agent for Windows](/azure/network-watcher/network-watcher-agent-windows)
- [Manage Network Watcher Agent for Linux](/azure/network-watcher/network-watcher-agent-linux)
- [Troubleshoot virtual machine extension issues](/azure/virtual-machines/extensions/troubleshoot)