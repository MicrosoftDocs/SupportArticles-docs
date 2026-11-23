---
title: Troubleshoot Microsoft Entra ID portal RDP through Azure Bastion
description: Diagnose a missing Microsoft Entra ID authentication option or failed sign-in when you use portal RDP through Azure Bastion. Follow these steps to fix it.
ms.service: azure-bastion
ms.date: 09/21/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: allensu, doarmstr
ai-usage: ai-assisted
---

# Troubleshoot Microsoft Entra ID portal RDP connections through Azure Bastion

## Summary

The Microsoft Entra ID authentication option might be missing or sign-in might fail because the Windows virtual machine (VM) isn't ready for Microsoft Entra sign-in, the user lacks the required authentication or Reader roles, graphical session recording or an IP-based connection is in use, or Conditional Access blocks the authentication.

This guide applies only when you open a Windows VM in the Azure portal and select **Connect > Bastion**, **RDP**, and **Microsoft Entra ID**. It doesn't apply to Linux Secure Shell (SSH), native-client Remote Desktop Protocol (RDP), or IP-based RDP.

## Symptoms

- **Microsoft Entra ID** doesn't appear under **Authentication type**.
- Selecting **Connect** doesn't open the Microsoft Entra sign-in page or a new Azure Bastion session tab.
- Microsoft Entra sign-in completes, but the VM rejects the connection with `Your account is configured to prevent you from using this device`.
- The connection reports `Your credentials didn't work` or `The sign-in method you're trying to use isn't allowed`.
- The Microsoft Entra sign-in log shows a Conditional Access failure.
- The session remains at `Connecting...` after authentication succeeds.

## Prerequisites

- **Supported target:** Windows 10 version 20H2 or later, Windows 11 version 21H2 or later, or Windows Server 2022 or later.
- **Bastion SKU:** Basic or higher. Developer SKU isn't supported.
- **Browser:** Microsoft Edge or Google Chrome with popups allowed for `cdn.bastion.azure.com`.
- **Diagnostic permissions:** Reader on the VM, its network interface card (NIC), the Azure Bastion host, and the target virtual network when Azure Bastion is in a peered virtual network. VM Run Command requires `Microsoft.Compute/virtualMachines/runCommand/action`.
- **Remediation permissions:** Permission to assign Azure roles and update the VM identity, extensions, or Azure Bastion configuration.
- **Tools:** Azure CLI 2.x in Azure Cloud Shell with the `bastion` extension version 2.62.0 or later. Cloud Shell installs the extension when you first run an `az network bastion` command.

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Subscription that contains the target VM | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `$VM_ID` | Full resource ID of the Windows VM | `/subscriptions/.../virtualMachines/myVm` |
| `$BASTION_ID` | Full resource ID of the Azure Bastion host | `/subscriptions/.../bastionHosts/myBastion` |
| `$USER_OBJECT_ID` | Object ID of the member user who connects | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |

> [!TIP]
> Each Azure CLI block prompts for values and caches them for the Cloud Shell session.

## Connect from the portal

1. In the Azure portal, open the **target Windows VM**. Don't start this flow from an IP address on the Azure Bastion resource.
1. Select **Connect** > **Bastion**.
1. Set **Protocol** to **RDP** and use port `3389` unless RDP is configured on a custom port.
1. For **Authentication type**, select **Microsoft Entra ID (Azure AD)**.
1. Select **Connect**. Allow the popup for `cdn.bastion.azure.com` if the browser blocks it.
1. Complete Microsoft Entra authentication, MFA, and Conditional Access. Portal RDP uses passwordless authentication; don't enter a local VM password.

If the authentication option is missing or the connection fails, continue with the diagnostic steps.

## Diagnostic steps

> [!NOTE]
> The checks in this section are read-only. VM Run Command executes discovery commands in the guest but doesn't change its configuration.

### Step 1

**What this checks:** Whether the Azure Bastion host and Windows VM meet the feature gates that control whether the portal offers Entra authentication.

```azurecli-interactive
# Collect inputs (cached if already set in this session)
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:     " SUBSCRIPTION
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID:  " BASTION_ID

az account set --subscription "$SUBSCRIPTION"

echo "=== Target VM ==="
az vm show --ids "$VM_ID" \
  --query "{name:name,location:location,provisioningState:provisioningState,osType:storageProfile.osDisk.osType,image:storageProfile.imageReference,systemAssignedIdentity:identity.type}" \
  --output json

echo "=== Entra login extension ==="
az vm extension list --ids "$VM_ID" \
  --query "[?name=='AADLoginForWindows'].{name:name,publisher:publisher,provisioningState:provisioningState,typeHandlerVersion:typeHandlerVersion}" \
  --output json

echo "=== Bastion host ==="
az network bastion show --ids "$BASTION_ID" \
  --query "{name:name,provisioningState:provisioningState,sku:sku.name,sessionRecording:enableSessionRecording}" \
  --output json
```

| If you see... | Meaning | Next step |
|---|---|---|
| Windows Server 2022 or later (or a supported Windows client), `systemAssignedIdentity` contains `SystemAssigned`, extension state is `Succeeded`, Azure Bastion is `Succeeded`, Basic or higher, and recording is `false` or `null` | The feature gates pass. | [Step 2](#step-2) |
| An older Windows version | Portal Microsoft Entra RDP doesn't support this target. | [Resolution A](#resolution-a) |
| Identity is `null` or doesn't contain `SystemAssigned` | The extension can't complete Microsoft Entra join without the VM identity. | [Resolution B](#resolution-b) |
| Extension output is `[]`, or its state isn't `Succeeded` | Entra sign-in isn't enabled or extension provisioning failed. | [Resolution B](#resolution-b) |
| Azure Bastion SKU is `Developer` | This guide's portal Microsoft Entra RDP flow requires Basic or higher. | [Resolution C](#resolution-c) |
| `sessionRecording` is `true` | Graphical session recording and portal Microsoft Entra RDP can't be used together. | [Resolution C](#resolution-c) |
| Either resource has a failed provisioning state | Resolve the deployment failure before testing authentication. | Use the Azure Bastion or VM deployment troubleshooting documentation. |

### Step 2

**What this step checks:** Whether the connecting identity is a same-tenant member and has the VM sign-in role and resource visibility required by Azure Bastion.

```azurecli-interactive
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID:    " BASTION_ID
[ -z "$USER_OBJECT_ID" ] && read -rp "Connecting user object ID: " USER_OBJECT_ID

az account set --subscription "$SUBSCRIPTION"

echo "=== Connecting identity ==="
az rest --method get \
  --url "https://graph.microsoft.com/v1.0/users/$USER_OBJECT_ID?\$select=id,userPrincipalName,userType" \
  --query "{objectId:id,userPrincipalName:userPrincipalName,userType:userType}" \
  --output json

NIC_ID=$(az vm show --ids "$VM_ID" --query "networkProfile.networkInterfaces[0].id" --output tsv)
VM_SUBNET_ID=$(az network nic show --ids "$NIC_ID" --query "ipConfigurations[0].subnet.id" --output tsv)
VM_VNET_ID="${VM_SUBNET_ID%/subnets/*}"

echo "=== Required resource IDs ==="
printf 'VM=%s\nNIC=%s\nTargetVNet=%s\nBastion=%s\n' "$VM_ID" "$NIC_ID" "$VM_VNET_ID" "$BASTION_ID"

echo "=== Effective role assignments for the connecting user and groups ==="
az role assignment list \
  --assignee-object-id "$USER_OBJECT_ID" \
  --include-groups \
  --include-inherited \
  --all \
  --query "[].{role:roleDefinitionName,scope:scope,principalType:principalType}" \
  --output table
```

Review the returned scopes, including inherited resource-group or subscription scopes. The user needs one VM sign-in role and Reader access to the resources shown in the preceding step. Reader on the target VNet is required when the Azure Bastion host is in a peered VNet.

Evaluate `userType` first. If it is `Guest`, stop at [Resolution D](#resolution-d); sufficient role assignments don't override guest ineligibility and must not route you to Step 3.

| If you see... | Meaning | Next step |
|---|---|---|
| `userType` is `Guest` | B2B guests can access Azure Bastion but can't authenticate to an Azure VM with MicrosoftEntra ID. | [Resolution D](#resolution-d) |
| No `Virtual Machine Administrator Login` or `Virtual Machine User Login` assignment covers the VM | Owner or Contributor alone doesn't grant VM sign-in. | [Resolution E](#resolution-e) |
| The sign-in role exists but Reader access doesn't cover the VM, NIC, Azure Bastion host, or required target VNet | Azure Bastion can't resolve all resources for the connection. | [Resolution E](#resolution-e) |
| All required assignments cover the resources | Authorization is configured. | [Step 3](#step-3) |
| `Insufficient privileges` prevents listing assignments | The current account can't complete this diagnostic. | Ask an RBAC administrator to verify the assignments, then continue to Step 3. |

### Step 3

**What this check does:** Checks whether Windows completed Microsoft Entra join, RDP is listening, and the VM can reach the identity endpoints required by `AADLoginForWindows`.

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

az vm run-command invoke --ids "$VM_ID" \
  --command-id RunPowerShellScript \
  --scripts '$join = dsregcmd /status; $join | Select-String "AzureAdJoined|DeviceId|TenantId"; Get-Service TermService | Select-Object Status,StartType; Get-NetTCPConnection -LocalPort 3389 -State Listen -ErrorAction SilentlyContinue | Select-Object LocalAddress,LocalPort,State' \
  --query "value[0].message" \
  --output tsv
```

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

az vm run-command invoke --ids "$VM_ID" \
  --command-id RunPowerShellScript \
  --scripts '$targets = "login.microsoftonline.com","enterpriseregistration.windows.net","pas.windows.net"; foreach ($target in $targets) { $result = Test-NetConnection $target -Port 443 -WarningAction SilentlyContinue; [pscustomobject]@{Target=$target;Tcp443=$result.TcpTestSucceeded;ResolvedAddress=$result.RemoteAddress;TenantId=$null;Error=$null} }; try { $identity = Invoke-RestMethod -Headers @{Metadata="true"} -Uri "http://169.254.169.254/metadata/identity/info?api-version=2018-02-01"; [pscustomobject]@{Target="AzureIMDS";Tcp443=$null;ResolvedAddress=$null;TenantId=$identity.tenantId;Error=$null} } catch { [pscustomobject]@{Target="AzureIMDS";Tcp443=$null;ResolvedAddress=$null;TenantId=$null;Error=$_.Exception.Message} }' \
  --query "value[0].message" \
  --output tsv
```

| If you see... | Meaning | Next step |
|---|---|---|
| `AzureAdJoined : YES`, `TermService` is `Running`, port 3389 is listening, all three endpoints show `Tcp443=True`, and IMDS returns the expected tenant | VM identity and RDP prerequisites pass. | [Step 4](#step-4) |
| `AzureAdJoined : NO`, no device ID, or IMDS has no tenant ID | The VM didn't complete Microsoft Entra join or can't use its managed identity. | [Resolution B](#resolution-b) |
| Any identity endpoint shows `Tcp443=False` or no resolved address | DNS, firewall, proxy, or routing blocks the VM's Microsoft Entra dependency. | [Resolution F](#resolution-f) |
| `TermService` isn't running or port 3389 isn't listening | Authentication isn't the immediate blocker. | [Resolution G](#resolution-g) |
| `AuthorizationFailed` for Run Command | The caller lacks the Run Command action. | Have a VM administrator run the checks in an elevated PowerShell session on the VM. |

### Step 4

**What this step checks:** Whether the failure occurs in the browser popup or in Microsoft Entra Conditional Access after Microsoft Entra configuration passes.

1. Retry from Microsoft Edge or Google Chrome in an InPrivate or Incognito window.
1. Allow popups for `cdn.bastion.azure.com`, and then start the connection from **VM > Connect > Bastion**.
1. Confirm the portal directory matches the VM tenant ID returned in Step 3.
1. If a MicrosoftEntra sign-in page appears but denies access, open **Microsoft Entra ID > Monitoring & health > Sign-in logs**. Find the failed event at the same UTC time and inspect **Failure reason** and **Conditional Access**.

Use this read-only check to identify the tenant that owns the VM and compare it with the tenant you selected in the portal. The Azure Bastion resource doesn't expose browser popup state or Conditional Access results. Use the preceding browser and sign-in-log checks to gather those signals.

```azurecli-interactive
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

az account set --subscription "$SUBSCRIPTION"

echo "=== Active Azure context ==="
az account show \
  --query "{signedInUser:user.name,activeTenant:tenantId}" \
  --output json

echo "=== Target VM tenant ==="
az vm show --ids "$VM_ID" \
  --query "{vm:name,vmTenant:identity.tenantId}" \
  --output json
```

| If you see... | Meaning | Next step |
|---|---|---|
| `activeTenant` and `vmTenant` differ | The selected directory doesn't match the tenant that owns the VM identity. | [Resolution D](#resolution-d) |
| No popup, but the connection works after allowing `cdn.bastion.azure.com` or using a clean profile | A popup rule or browser extension blocked the authentication window. | Keep the domain allow-listed and retry. |
| The sign-in log shows a Conditional Access failure | Microsoft Entra evaluated and denied the session. | [Resolution D](#resolution-d) |
| Authentication succeeds and the session then stays at `Connecting...` or returns a generic connection error | Identity is no longer the failing stage; the RDP data path is blocked. | [Resolution G](#resolution-g) |
| All checks pass and no relevant failed sign-in is present | The failure might be transient or platform-side. | Collect the details in [File a support request](#file-a-support-request). |

## Decision map

| Diagnostic result | Next action |
|---|---|
| Unsupported Windows version | [Resolution A](#resolution-a) |
| VM or Azure Bastion provisioning state is failed | Resolve the deployment failure, then rerun [Step 1](#step-1). |
| Missing system identity, missing or failed extension, or VM not MicrosoftEntra joined | [Resolution B](#resolution-b) |
| Developer SKU, session recording enabled, or IP-based RDP flow | [Resolution C](#resolution-c) |
| Guest or wrong-tenant identity, or Conditional Access denial | [Resolution D](#resolution-d) |
| Missing VM login role or Reader access | [Resolution E](#resolution-e) |
| `Insufficient privileges` prevents role-assignment listing | Have an RBAC administrator verify the assignments in [Step 2](#step-2), then continue to [Step 3](#step-3). |
| VM can't resolve or reach Microsoft Entra endpoints | [Resolution F](#resolution-f) |
| Run Command returns `AuthorizationFailed` | Have a VM administrator run the [Step 3](#step-3) guest checks in an elevated PowerShell session, then continue to [Step 4](#step-4). |
| Entra auth succeeds but RDP doesn't establish | [Resolution G](#resolution-g) |
| The connection works after allowing `cdn.bastion.azure.com` or using a clean browser profile | Keep the domain allow-listed and retry the portal connection. |
| Every diagnostic passes and failure persists | [File a support request](#file-a-support-request) |

## Resolution A

**Root cause:** The target runs an unsupported Windows version. Portal Microsoft Entra RDP requires Windows 10 version 20H2 or later, Windows 11 version 21H2 or later, or Windows Server 2022 or later.

Use these read-only commands to record the guest version and source image before you choose an upgrade or replacement path.

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

echo "=== Guest version ==="
az vm get-instance-view --ids "$VM_ID" \
  --query "{computerName:instanceView.computerName,osName:instanceView.osName,osVersion:instanceView.osVersion}" \
  --output json

echo "=== Source image ==="
az vm show --ids "$VM_ID" \
  --query "{osType:storageProfile.osDisk.osType,image:storageProfile.imageReference}" \
  --output json
```

Use a supported target image or upgrade the guest OS through your normal operating-system lifecycle process. For an immediate workaround, connect through Azure Bastion with a supported local or domain credential method. Don't install `AADLoginForWindows` to force support on an older image.

## Resolution B

**Root cause:** The VM doesn't have a system-assigned identity, `AADLoginForWindows` is absent or failed, or Windows didn't complete MicrosoftEntra join.

> [!IMPORTANT]
> **⚠️ WRITE OPERATION — approval required before execution**
> Before you run these commands, confirm that you have approval from the VM owner. The first command enables a system-assigned managed identity; the second installs or repairs the Microsoft Entra login extension.

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

az vm identity assign --ids "$VM_ID" --output json --verbose --debug

VM_NAME=$(echo "$VM_ID" | awk -F/ '{print $9}')
VM_RG=$(echo "$VM_ID" | awk -F/ '{print $5}')

az vm extension set \
  --publisher Microsoft.Azure.ActiveDirectory \
  --name AADLoginForWindows \
  --resource-group "$VM_RG" \
  --vm-name "$VM_NAME" \
  --output json \
  --verbose \
  --debug
```

Wait for `provisioningState: Succeeded`, then rerun Steps 1 and 3. If the extension still fails, review `C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.ActiveDirectory.AADLoginForWindows\*\CommandExecution.log` and the **User Device Registration/Admin** event log.

## Resolution C

**Root cause:** The selected Azure Bastion configuration or connection flow doesn't support portal Microsoft Entra RDP. Common cases are Developer SKU, graphical session recording enabled, or an IP-based RDP connection.

- Use Basic or higher and start from the target VM's **Connect > Bastion** page.
- Don't use the Azure Bastion **Connect** page with a target IP address; Microsoft Entra authentication isn't supported for IP-based RDP.
- Choose between graphical session recording and portal Microsoft Entra RDP. They can't be enabled together.

For Developer SKU, use this read-only block to collect the virtual network and check whether the dedicated `AzureBastionSubnet` prerequisite already exists.

```azurecli-interactive
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID: " BASTION_ID

BASTION_VNET_ID=$(az network bastion show --ids "$BASTION_ID" --query "virtualNetwork.id" --output tsv)

echo "=== Current Bastion configuration ==="
az network bastion show --ids "$BASTION_ID" \
  --query "{name:name,location:location,sku:sku.name,virtualNetwork:virtualNetwork.id}" \
  --output json

echo "=== Required dedicated subnet ==="
az network vnet subnet show \
  --ids "$BASTION_VNET_ID/subnets/AzureBastionSubnet" \
  --query "{name:name,addressPrefix:addressPrefix,provisioningState:provisioningState}" \
  --output json
```

If the subnet command returns `ResourceNotFound`, create an `AzureBastionSubnet` with a prefix of `/26` or larger. Developer uses shared infrastructure, and `az network bastion update` can't add the dedicated IP configuration. Follow the [Azure CLI procedure to replace Developer with Basic or higher](/azure/bastion/upgrade-sku#upgrade-from-developer-sku), and supply the environment-specific subnet prefix and public IP name required by that procedure.

> [!IMPORTANT]
> **⚠️ WRITE OPERATION — approval required before execution**
> Disabling session recording can affect compliance controls. Before you run this command, confirm that you have approval from the Azure Bastion owner.

```azurecli-interactive
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID: " BASTION_ID

az network bastion update \
  --ids "$BASTION_ID" \
  --session-recording false \
  --output json \
  --verbose \
  --debug
```

After the update completes, reopen the VM's Azure Bastion connection page and confirm **Microsoft Entra ID** appears.

## Resolution D

**Root cause:** The identity isn't an eligible same-tenant member, the portal is in the wrong directory, or a Conditional Access policy denies the sign-in.

Use this read-only block to collect the target tenant and the connecting user's membership type. If the user query is denied, have an identity administrator collect the same fields in the Microsoft Entra admin center.

```azurecli-interactive
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID
[ -z "$USER_OBJECT_ID" ] && read -rp "Connecting user object ID: " USER_OBJECT_ID

az account set --subscription "$SUBSCRIPTION"

echo "=== Target tenant ==="
az vm show --ids "$VM_ID" \
  --query "{vm:name,tenantId:identity.tenantId}" \
  --output json

echo "=== Connecting user ==="
az rest --method get \
  --url "https://graph.microsoft.com/v1.0/users/$USER_OBJECT_ID?\$select=id,userPrincipalName,userType" \
  --query "{objectId:id,userPrincipalName:userPrincipalName,userType:userType}" \
  --output json
```

- You can grant a B2B guest access to Azure Bastion but they can't use Microsoft Entra authentication to sign in to the VM. Use a member account in the VM tenant or another supported authentication method.
- Switch the Azure portal to the directory whose tenant ID matches Step 3.
- Use the failed Microsoft Entra sign-in event to identify the exact Conditional Access control. Have the identity team correct device compliance, authentication strength, sign-in risk, location, or user scope as appropriate.
- Don't broadly disable Conditional Access. Retest with a narrowly scoped test user or policy exclusion approved by the identity owner.

## Resolution E

**Root cause:** The user lacks the VM data-plane login role or one of the Reader assignments that Azure Bastion needs to resolve the connection resources. Owner and Contributor don't grant VM sign-in by themselves.

> [!IMPORTANT]
> **⚠️ WRITE OPERATION — approval required before execution**
> Before you run these commands, confirm that an RBAC administrator approved the user, role, and scope. Use `Virtual Machine User Login` unless administrator access is required.

```azurecli-interactive
[ -z "$USER_OBJECT_ID" ] && read -rp "User object ID:          " USER_OBJECT_ID
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID:  " VM_ID
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID:     " BASTION_ID

NIC_ID=$(az vm show --ids "$VM_ID" --query "networkProfile.networkInterfaces[0].id" --output tsv)
VM_SUBNET_ID=$(az network nic show --ids "$NIC_ID" --query "ipConfigurations[0].subnet.id" --output tsv)
VM_VNET_ID="${VM_SUBNET_ID%/subnets/*}"
BASTION_SUBNET_ID=$(az network bastion show --ids "$BASTION_ID" --query "ipConfigurations[0].subnet.id" --output tsv)
BASTION_VNET_ID="${BASTION_SUBNET_ID%/subnets/*}"

az role assignment create --assignee-object-id "$USER_OBJECT_ID" --assignee-principal-type User \
  --role "Virtual Machine User Login" --scope "$VM_ID" --verbose --debug
az role assignment create --assignee-object-id "$USER_OBJECT_ID" --assignee-principal-type User \
  --role Reader --scope "$VM_ID" --verbose --debug
az role assignment create --assignee-object-id "$USER_OBJECT_ID" --assignee-principal-type User \
  --role Reader --scope "$NIC_ID" --verbose --debug
az role assignment create --assignee-object-id "$USER_OBJECT_ID" --assignee-principal-type User \
  --role Reader --scope "$BASTION_ID" --verbose --debug

if [ -n "$BASTION_SUBNET_ID" ] && [ "${BASTION_VNET_ID,,}" != "${VM_VNET_ID,,}" ]; then
  az role assignment create --assignee-object-id "$USER_OBJECT_ID" --assignee-principal-type User \
    --role Reader --scope "$VM_VNET_ID" --verbose --debug
fi
```

When Azure Bastion is in a peered VNet, the conditional command grants Reader on the target VNet. Allow several minutes for role propagation, rerun Step 2, and retry.

## Resolution F

**Root cause:** The Windows VM can't resolve or reach one or more Microsoft Entra sign-in dependencies.

Use this read-only block to collect the target NIC's effective routes and security rules and retest the required identity endpoints. Run it again after the network owner changes the actual blocking control point.

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID

NIC_ID=$(az vm show --ids "$VM_ID" --query "networkProfile.networkInterfaces[0].id" --output tsv)

echo "=== Effective routes ==="
az network nic show-effective-route-table --ids "$NIC_ID" --output table

echo "=== Effective network security groups ==="
az network nic list-effective-nsg --ids "$NIC_ID" --output json

echo "=== Identity endpoint tests ==="
az vm run-command invoke --ids "$VM_ID" \
  --command-id RunPowerShellScript \
  --scripts '$targets = "login.microsoftonline.com","enterpriseregistration.windows.net","pas.windows.net"; foreach ($target in $targets) { $result = Test-NetConnection $target -Port 443 -WarningAction SilentlyContinue; [pscustomobject]@{Target=$target;Tcp443=$result.TcpTestSucceeded;ResolvedAddress=$result.RemoteAddress} }' \
  --query "value[0].message" \
  --output tsv
```

Allow outbound TCP 443 and working DNS resolution from the VM to:

- `login.microsoftonline.com`
- `enterpriseregistration.windows.net`
- `pas.windows.net`

Also preserve direct access to Azure Instance Metadata Service at `169.254.169.254`. Configure the allow rules in the actual control point identified by your network team, such as Azure Firewall, an NVA, proxy, DNS server, or guest firewall. Don't add a broad Internet allow when a narrower FQDN/application rule is available.

Rerun Step 3. All endpoint tests must return `Tcp443=True`, IMDS must return the expected tenant, and `dsregcmd /status` must show `AzureAdJoined : YES`.

## Resolution G

**Root cause:** Microsoft Entra authentication succeeded, but Azure Bastion can't establish the RDP session to the target VM. This is a network or guest RDP issue, not an identity failure.

Use this read-only block to collect the Azure Bastion subnet controls, the target NIC's effective policy, and the guest RDP listener state.

```azurecli-interactive
[ -z "$VM_ID" ] && read -rp "Windows VM resource ID: " VM_ID
[ -z "$BASTION_ID" ] && read -rp "Bastion resource ID:    " BASTION_ID

NIC_ID=$(az vm show --ids "$VM_ID" --query "networkProfile.networkInterfaces[0].id" --output tsv)
BASTION_SUBNET_ID=$(az network bastion show --ids "$BASTION_ID" --query "ipConfigurations[0].subnet.id" --output tsv)

echo "=== Bastion subnet controls ==="
az network vnet subnet show --ids "$BASTION_SUBNET_ID" \
  --query "{subnet:id,networkSecurityGroup:networkSecurityGroup.id,routeTable:routeTable.id}" \
  --output json

echo "=== Target NIC effective policy ==="
az network nic list-effective-nsg --ids "$NIC_ID" --output json
az network nic show-effective-route-table --ids "$NIC_ID" --output table

echo "=== Guest RDP state ==="
az vm run-command invoke --ids "$VM_ID" \
  --command-id RunPowerShellScript \
  --scripts 'Get-Service TermService | Select-Object Status,StartType; Get-NetTCPConnection -LocalPort 3389 -State Listen -ErrorAction SilentlyContinue | Select-Object LocalAddress,LocalPort,State; Get-NetFirewallProfile | Select-Object Name,Enabled,DefaultInboundAction' \
  --query "value[0].message" \
  --output tsv
```

Use [Troubleshoot Azure Bastion connection failures](/troubleshoot/azure/bastion/troubleshoot-connection-blocked-ports) to check the Azure Bastion subnet NSG, VM subnet/NIC NSG, TCP 3389, guest firewall, browser HTTPS path, and routing. Don't change Microsoft Entra roles when the sign-in event succeeded and the failure starts at `Connecting...`.

## File a support request

If every diagnostic passes and the failure persists, collect:

- UTC timestamp and user object ID
- VM and Azure Bastion resource IDs
- Azure Bastion host provisioning state, SKU, and region
- Screenshot of the connection page and exact error text
- Microsoft Entra sign-in correlation ID, failure reason, and Conditional Access result
- `AADLoginForWindows` provisioning state and handler version
- Step 3 output showing join state, RDP listener, endpoint tests, and tenant ID
- Whether another same-tenant member can connect to the same VM with Microsoft Entra ID
- Whether the same user can connect to another supported VM through the same Azure Bastion host

File an Azure support request for **Azure Bastion** when the portal or Azure Bastion flow fails before Microsoft Entra produces a sign-in event. Route the request to **Microsoft Entra ID** when the sign-in event shows an identity or Conditional Access failure. Route the request to **Azure Virtual Machines - Windows** when the token reaches the VM but `AADLoginForWindows`, Microsoft Entra join, or Windows logon rejects it.

## References

- [Configure Microsoft Entra ID authentication for Azure Bastion](/azure/bastion/bastion-entra-id-authentication)
- [Connect to a Windows VM using RDP and Azure Bastion](/azure/bastion/bastion-connect-vm-rdp-windows)
- [Sign in to a Windows VM using Microsoft Entra ID](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows)
- [Troubleshoot Azure Bastion connection failures](/troubleshoot/azure/bastion/troubleshoot-connection-blocked-ports)