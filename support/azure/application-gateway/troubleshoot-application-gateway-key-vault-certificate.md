---
title: Troubleshoot Application Gateway Key Vault certificate errors
description: Troubleshoot Application Gateway Key Vault certificate errors, from identity and firewall access to URI and PFX issues. Learn how to restore HTTPS.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.custom: sap:End to end SSL or SSL offload
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - certificate-error
  - key-vault
  - key-vault-access-denied
  - cert-rotation
  - pfx-format
  - listener-cert
  - managed-identity
  - ssl-certificate
  - key-vault-firewall
  - secret-uri-versioned
  - certificate-expired
  - tls-handshake-failure
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/applicationGateways/write
  - Microsoft.KeyVault/vaults/read
  - Microsoft.KeyVault/vaults/secrets/read
  - Microsoft.ManagedIdentity/userAssignedIdentities/read
  - Microsoft.Authorization/roleAssignments/read
  - Microsoft.Authorization/roleAssignments/write
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - KEY_VAULT_NAME
  - CERT_NAME
---

# Troubleshoot certificate management and Azure Key Vault integration in Azure Application Gateway

## Summary

This article provides a structured diagnostic process to identify and resolve issues that affect Azure Application Gateway integration with Azure Key Vault for Transport Layer Security (TLS) and Secure Sockets Layer (SSL) certificates.

Application Gateway integrates with Azure Key Vault to source TLS and SSL certificates for HTTPS listeners. When this integration breaks, listeners don't serve traffic, or certificates stop autorotating. 

The most common root causes of these issues are: 

- The Application Gateway's managed identity lacks `Key Vault Secrets User` (or legacy `Get Secret`) permissions on the key vault. 
- The key vault network firewall blocks traffic from the Application Gateway subnet.
- The listener references a versioned secret URI which prevents automatic certificate rotation. 
- A PFX certificate is uploaded to Key Vault in the wrong format (missing private key, wrong encoding, or incomplete chain).

> [!NOTE]
> This article describes listener certificate issues. Application Gateway can't retrieve or use the TLS certificate from Key Vault for its HTTPS listeners. For back-end TLS certificate chain issues (such as common name (CN) or subject alternative name (SAN) mismatches or missing intermediate CAs between Application Gateway and the back-end server), see [Troubleshoot HTTP 502 errors — Resolution F](troubleshoot-http-502-bad-gateway.md#resolution-f).

## Symptoms

You might encounter one or more of the following symptoms:

- Deployment or update fails and returns a `"code": "ApplicationGatewayKeyVaultSecretException"` error message: `Unable to retrieve certificate '{CERT_NAME}' from Key Vault '{KEY_VAULT_NAME}'`.
- Deployment or update fails and returns a `"code": "LinkedAccessCheckFailed"` error message: `The user, group or application... does not have secrets get permission on key vault '{KEY_VAULT_NAME}'`.
- An error is recorded in the activity log: `Secret is not in expected format. Its content type must be either 'application/x-pkcs12' or 'application/x-pem-file'`.
- Application Gateway `provisioningState` is in a `Failed` state after you add or update an HTTPS listener certificate.
- The HTTPS listener returns TLS handshake failure to clients, and the certificate isn't served or is outdated.
- Certificate autorotation stops working. Application Gateway still serves an old or expired certificate even though Key Vault has a newer version.
- The [Azure portal](https://portal.azure.com) shows the certificate status as **Error** or **Warning** on the HTTPS listener configuration page.
- The `az network application-gateway ssl-cert show` command returns an error message or shows a stale `keyVaultSecretId` that has a version segment in the Uniform Resource Identifier (URI).
- Deployment fails and returns the following message: `Key Vault '{KEY_VAULT_NAME}' is not accessible. Please make sure that the Key Vault is accessible from the Application Gateway subnet`.
- You receive the following error message: `Certificate '{CERT_NAME}' in Key Vault '{KEY_VAULT_NAME}' is not a valid PFX or PEM certificate`.
- An Application Gateway health probe succeeds, but HTTPS clients experience `ERR_SSL_PROTOCOL_ERROR` or `SSL_ERROR_BAD_CERT_DOMAIN` errors.

## Prerequisites

To troubleshoot Key Vault certificate problems on Application Gateway, you need the following items:

- **Permissions required**: `Network Contributor` role on the Application Gateway resource group, `Key Vault Administrator` or `Key Vault Secrets Officer` role on the Key Vault resource (for role-based access control (RBAC) fixes), and `User Access Administrator` or `Owner` role for role assignment operations
- **Tools**: Azure CLI 2._x_, or an AI agent that has Azure MCP access (OpenSSL is optional for local Personal Information Exchange (PFX) file validation)
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing your Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name | `myAppGateway` |
| `{KEY_VAULT_NAME}` | Key Vault containing the TLS certificate | `myKeyVault` |
| `{CERT_NAME}` | Certificate (secret) name in Key Vault | `myAppCert` |

> [!TIP]
> Verify all variables before you run any commands. If you don't know the `{KEY_VAULT_NAME}` or `{CERT_NAME}` values, you can find them in [Step 1](#step-1) from the Application Gateway SSL certificate configuration.

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the Application Gateway is in a healthy provisioning state and whether the HTTPS listener certificates reference Key Vault. In case you don't know them, this check also discovers the `{KEY_VAULT_NAME}` and `{CERT_NAME}` values.

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
  --query "{provisioningState:provisioningState, operationalState:operationalState, sslCertificates:sslCertificates[].{name:name, keyVaultSecretId:properties.keyVaultSecretId, provisioningState:properties.provisioningState}, identity:identity}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `provisioningState: "Succeeded"`, all `sslCertificates` show a healthy state, and the reported symptom is no longer reproducing. | Application Gateway and certificates are healthy. The issue was transient or already resolved. | Verify that the symptom is gone. If it is, no further action is needed. |
| `provisioningState: "Succeeded"` but the reported symptom still reproduces. | A `Succeeded` state doesn't rule out a stale certificate. A valid-but-stale certificate also produces this state. | Continue diagnosing and perform [Step 2](#step-2). |
| `provisioningState: "Failed"`. | Application Gateway is in a failed state. A certificate or identity issue prevented the last operation. | Record the `keyVaultSecretId` from each SSL certificate and the `Failed` state (you'll reference it in [Step 7](#step-7)), then perform [Step 2](#step-2). |
| `sslCertificates` entries show `keyVaultSecretId: null`. | The certificate was uploaded directly (not Key Vault–backed). Key Vault troubleshooting isn't needed. | This article covers Key Vault–referenced certificates only. If the certificate is a direct-upload process, check certificate validity separately. |
| `identity` is `null` or missing. | No managed identity is assigned to the Application Gateway. | Perform [Step 2](#step-2) to verify the identity gap. |
| `keyVaultSecretId` contains a version segment (for example, `/secrets/{CERT_NAME}/abc123def456`). | This URI is versioned, and autorotation doesn't work. | Record the URI and continue to [Step 5](#step-5). |
| `keyVaultSecretId` ends with `/secrets/{CERT_NAME}` (no version). | This URI is a versionless, and autorotation should work. | Perform [Step 2](#step-2). |

> [!NOTE]
> A `provisioningState: "Succeeded"` result doesn't end the investigation while the symptom is still reproducing. Treat `Succeeded` as healthy *only* when the symptom is no longer reproducing. Otherwise, continue through the diagnostic steps. 

> [!TIP]
> Extract `{KEY_VAULT_NAME}` from the `keyVaultSecretId` URI (the segment between `https://` and `.vault.azure.net`). Extract `{CERT_NAME}` from the secret name segment. Use these discovered values for subsequent steps, if they're not already known.

### Step 2

Check whether the Application Gateway has a user-assigned managed identity configured. Application Gateway requires a user-assigned managed identity to authenticate to Key Vault.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway identity show \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `type: "UserAssigned"` with one or more identity resource IDs. | Managed identity is assigned. | Record the identity resource ID (the key under `userAssignedIdentities`), then perform [Step 3](#step-3). |
| `null`, an empty result, or the error `No identity found`. | No managed identity is assigned. Application Gateway can't authenticate to Key Vault. | Perform [Resolution A](#resolution-a), assign the identity, and then continue diagnostics. |
| `type: "SystemAssigned"` only. | System-assigned identity isn't supported for Key Vault integration on Application Gateway | Perform [Resolution A](#resolution-a). |

> [!TIP]
> Record the full user-assigned identity resource ID from the output. You need it in [Step 3](#step-3) to check Key Vault permissions. Extract the `{IDENTITY_PRINCIPAL_ID}` by running the command in [Step 3](#step-3), if it's necessary.

### Step 3

Check whether the Application Gateway's managed identity has the required permissions to read secrets from the key vault. This permission issue is the most common root cause for Key Vault integration failures.

1. Determine the identity's principal ID by using Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$IDENTITY_RESOURCE_ID" ] && read -rp "Identity Resource ID: " IDENTITY_RESOURCE_ID

az identity show \
  --ids "$IDENTITY_RESOURCE_ID" \
  --query "{principalId:principalId, clientId:clientId, name:name}" \
  --output json
```

2. Note the `principalId` value. This value is the `{IDENTITY_PRINCIPAL_ID}`.

3. Use Azure CLI to check the Key Vault access model (RBAC versus access policy):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME

az keyvault show \
  --name "$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{enableRbacAuthorization:properties.enableRbacAuthorization, accessPolicies:properties.accessPolicies}" \
  --output json
```

4. If Key Vault uses RBAC authorization (`enableRbacAuthorization: true`), run the following commands by using Azure CLI:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID:    " IDENTITY_PRINCIPAL_ID
[ -z "$KV_RG" ] && read -rp "Key Vault Resource Group: " KV_RG
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:           " KEY_VAULT_NAME

az role assignment list \
  --assignee "$IDENTITY_PRINCIPAL_ID" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$KV_RG/providers/Microsoft.KeyVault/vaults/$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table
```

5. If Key Vault uses access policies (`enableRbacAuthorization: false` or `null`), run the following commands by using Azure CLI:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:        " KEY_VAULT_NAME
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID: " IDENTITY_PRINCIPAL_ID

az keyvault show \
  --name "$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "properties.accessPolicies[?objectId=='$IDENTITY_PRINCIPAL_ID'].{objectId:objectId, secretPermissions:permissions.secrets, certificatePermissions:permissions.certificates}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| For RBAC: The `Key Vault Secrets User` or `Key Vault Administrator` role is assigned. | Identity has sufficient permissions. | Perform [Step 4](#step-4) |
| For RBAC: No role assignments found, or only the `Key Vault Reader` role is assigned. | Identity lacks secret-read permission. This condition is the root cause. | Perform [Resolution A](#resolution-a) |
| For RBAC: The role is assigned but scoped to a different resource (not this Key Vault). | There's a scope mismatch. The role must be scoped to the specific Key Vault or higher. | Perform [Resolution A](#resolution-a). |
| For Access Policy: `secretPermissions` includes `"get"`. | Identity has `Get Secret` permissions. | Perform [Step 4](#step-4) |
| For Access Policy: `secretPermissions` is missing `"get"`, or no policy is found for the identity. | Identity lacks `Get Secret` permissions. This condition is the root cause. | Perform [Resolution A](#resolution-a). |
| For Access Policy: The policy exists with `certificatePermissions` but not `secretPermissions`. | Application Gateway reads certificates as `secrets`, not certificates. | Perform [Resolution A](#resolution-a). |
| Error: `VaultNotFound`. | The Key Vault name is incorrect or is in a different subscription. | Verify the `{KEY_VAULT_NAME}` and subscription values. |

> [!IMPORTANT]
> Application Gateway retrieves certificates from Key Vault as `secrets`, not as Key Vault certificates. The identity must have `Get` permission on `secrets` even though the object was uploaded as a Key Vault certificate.

### Step 4

Check whether the Key Vault network firewall is configured to allow traffic from the Application Gateway subnet. If the Key Vault has a firewall enabled, requests from Application Gateway's subnet are blocked unless explicitly allowed.

1. Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME

az keyvault show \
  --name "$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{defaultAction:properties.networkAcls.defaultAction, bypass:properties.networkAcls.bypass, virtualNetworkRules:properties.networkAcls.virtualNetworkRules[].{id:id}, ipRules:properties.networkAcls.ipRules[].{value:value}}" \
  --output json
```

2. Determine the Application Gateway subnet ID by using Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "gatewayIPConfigurations[0].subnet.id" \
  --output tsv
```

3. Record this value as `{APPGW_SUBNET_ID}`.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `defaultAction: "Allow"`. | The Key Vault firewall isn't restricting access and the network is open. | Perform [Step 5](#step-5). |
| `defaultAction: "Deny"` and `{APPGW_SUBNET_ID}` appear in `virtualNetworkRules`. | The Application Gateway subnet is allowed through the firewall. | Perform [Step 5](#step-5). |
| `defaultAction: "Deny"` and `{APPGW_SUBNET_ID}` aren't in `virtualNetworkRules`. | The Key Vault firewall is blocking Application Gateway. This condition is the root cause. | Perform [Resolution B](#resolution-b). |
| `defaultAction: "Deny"` and `bypass` include `"AzureServices"`. | Azure trusted services can bypass the firewall. By default, Application Gateway isn't a trusted service for Key Vault. | Perform [Resolution B](#resolution-b). |
| `defaultAction: "Deny"` and `virtualNetworkRules` are empty. | There are no subnet rules. All virtual network (VNet) access is blocked. | Perform [Resolution B](#resolution-b). |
| Key Vault uses private endpoints only (no public access). | Application Gateway must reach Key Vault by using a private endpoint, or public access must be enabled. | Perform [Resolution B](#resolution-b). |

> [!IMPORTANT]
> Application Gateway v2 doesn't appear on the Key Vault trusted services list. Even if `bypass: "AzureServices"` is set, the Application Gateway subnet must be explicitly added to the Key Vault network rules, or a private endpoint must be configured.

### Step 5

Check whether the Application Gateway SSL certificate configuration references a versionless secret URI (required for autorotation) or a versioned URI (that pins to a specific certificate version and prevents automatic renewal).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway ssl-cert list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, keyVaultSecretId:keyVaultSecretId}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| URI format: `https://{KV_NAME}.vault.azure.net/secrets/{CERT_NAME}` (no trailing version). | This URI doesn't include a version and autorotation is enabled. | Perform [Step 6](#step-6). |
| URI format: `https://{KV_NAME}.vault.azure.net/secrets/{CERT_NAME}/{HEX_VERSION}`. | This URI includes a version and certificates are pinned to a specific version. autorotation doesn't work. | Perform [Resolution C](#resolution-c). |
| `keyVaultSecretId` is `null` or empty. | Certificate isn't Key Vault–backed (a direct upload operation). | Key Vault rotation doesn't apply. Manage certificate lifecycles manually. |

> [!NOTE]
> For autorotation, when you use a versionless secret URI, Application Gateway polls Key Vault every four hours for a newer version of the secret. If it finds a new version, it automatically updates the certificate without any gateway downtime or redeployment.

### Step 6

Check whether the certificate that's stored in Key Vault is in the correct format (PFX that uses a private key) and has a complete certificate chain. Application Gateway requires a PFX (PKCS#12) or Privacy Enhanced Mail (PEM) certificate that includes the private key and, for non-self-signed certificates, the full chain of intermediate CA certificates.

1. Run the following commands in Azure CLI:

**Azure CLI (retrieve the secret metadata):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:  " CERT_NAME

az keyvault secret show \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{contentType:contentType, enabled:attributes.enabled, expires:attributes.expires, notBefore:attributes.notBefore, created:attributes.created, updated:attributes.updated}" \
  --output json
```

2. To validate the PFX locally, use Azure CLI. 

> [!NOTE]
> This step is optional. It requires OpenSSL, the ability to download the certificate, or access to the original PFX file.

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$CERT_FILE" ] && read -rp "PFX File Base Name: " CERT_FILE
[ -z "$PFX_PASSWORD" ] && read -rp "PFX Password:       " PFX_PASSWORD

# Check if the PFX contains a private key and certificate chain
openssl pkcs12 -info -in "${CERT_FILE}.pfx" -nokeys -passin pass:"$PFX_PASSWORD" 2>&1

# Verify the private key is present
openssl pkcs12 -info -in "${CERT_FILE}.pfx" -nocerts -passin pass:"$PFX_PASSWORD" 2>&1

# Check certificate expiration
openssl pkcs12 -in "${CERT_FILE}.pfx" -clcerts -nokeys -passin pass:"$PFX_PASSWORD" 2>&1 | openssl x509 -noout -dates
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `contentType: "application/x-pkcs12"` and `enabled: true`. | The certificate is in PFX format and enabled. | Check expiration dates in the following steps. If `expires` is in the future, perform [Step 7](#step-7). |
| `contentType: "application/x-pem-file"` and `enabled: true` | The certificate is in PEM format (also valid). | Check expiration dates in the following steps. If `expires` is in the future, perform [Step 7](#step-7). |
| `contentType` is `null`, empty, or anything other than `application/x-pkcs12` or `application/x-pem-file`. | This value is the wrong content type, and Application Gateway might not recognize the certificate. | Perform [Resolution D](#resolution-d). |
| `enabled: false`. | The secret is disabled, and Application Gateway can't retrieve it. | Re-enable the secret in Key Vault. |
| The `expires` date is in the past | The certificate is expired. | Renew the certificate and upload a new version to Key Vault. |
| OpenSSL: `no certificate or crl found` or `no private key found`. | The PFX file is missing the private key, and Application Gateway requires it. | Perform [Resolution D](#resolution-d). |
| OpenSSL shows only a leaf certificate (no intermediate CAs). | The chain is incomplete and might cause trust failures on some clients. | Perform [Resolution D](#resolution-d). |
| OpenSSL shows leaf, intermediate, and root certificates | The full chain is present. | Perform [Step 7](#step-7). |

### Step 7

Check whether the certificate that the HTTPS listener is actively serving matches the current certificate version that's in Key Vault. [Step 2](#step-2)–[6](#step-6) confirm that permissions, network, URI format, and certificate content are all correct. However, Application Gateway polls only a versionless secret URI roughly every four hours, and a gateway that's stuck in `provisioningState: "Failed"` state (recorded in [Step 1](#step-1)) keeps serving an old version indefinitely. This step exposes the discriminating signal: A mismatch between the served certificate and the live Key Vault certificate. This mismatch means autorotation stalled, and the gateway needs a forced refresh even though every upstream check seems correct.

1. Get the certificate that the listener is currently serving.

This step connects to the listener over TLS, and prints the Secure Hash Algorithm 1 (SHA-1) fingerprint and expiry of the certificate that Application Gateway is presenting right now. This check is a read-only network probe and makes no changes.

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$APPGW_FQDN_OR_IP" ] && read -rp "App Gateway FQDN or IP: " APPGW_FQDN_OR_IP
[ -z "$LISTENER_HOSTNAME" ] && read -rp "Listener Hostname:      " LISTENER_HOSTNAME

# SHA-1 fingerprint + expiry of the certificate the listener is serving
openssl s_client -connect "$APPGW_FQDN_OR_IP:443" -servername "$LISTENER_HOSTNAME" 2>/dev/null \
  | openssl x509 -noout -enddate -fingerprint -sha1
```

The output should resemble `notAfter=May  1 00:00:00 2027 GMT` and `SHA1 Fingerprint=A1:B2:C3:...`. Record both values.

2. Get the current certificate version that's in Key Vault.

This step reads the thumbprint and expiry of the latest certificate version that's in Key Vault (that is, the version that `--version` defaults to). This version is the certificate that Application Gateway should be serving after a successful rotation.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:  " CERT_NAME

az keyvault certificate show \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{thumbprint:x509ThumbprintHex, expires:attributes.expires}" \
  --output json
```

> [!TIP]
> The served fingerprint from `openssl` is colon-separated and might be lowercase or uppercase (`A1:B2:C3:...`). The key vault `x509ThumbprintHex` is a continuous hex string (`A1B2C3...`). Compare them by removing the colons and ignoring case. When they match, they refer to the same value.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The served fingerprint (colons removed) doesn't equal the Key Vault `thumbprint`, *or* the served `notAfter` value is earlier than the Key Vault `expires` date. | The gateway is serving an older certificate than the current Key Vault version, and autorotation is stalled even though permissions, network, URI, and format are all correct. | Perform [Resolution E](#resolution-e). |
| [Step 1](#step-1) reported `provisioningState: "Failed"`, and [Step 2](#step-2)–[6](#step-6) all returned healthy values (identity present, permissions are good, firewall is open, the  URI is versionless, and there's a valid and enabled PFX). | The gateway is stuck in a failed state and isn't picking up the current certificate. It needs a forced refresh | Perform [Resolution E](#resolution-e). |
| The served fingerprint (colons removed) equals the Key Vault `thumbprint`, served `notAfter` matches the Key Vault `expires`, and [Step 1](#step-1) reported `provisioningState: "Succeeded"`. | The gateway is already serving the current Key Vault certificate. There's no stale-certificate or stuck-state anomaly. | If the symptom still reproduces, Key Vault integration is functioning correctly. File an Azure support request |
| `openssl s_client` can't connect, times out, or returns no certificate. | The listener is unreachable on port 443. This problem is a connectivity or listener issue, not a Key Vault integration problem. | This problem is out of scope for this guide. Investigate listener configuration, frontend IP, and NSG rules separately.|

> [!NOTE]
> This step is read-only. The forced-refresh remediation for a stalled rotation or stuck `Failed` state is performed in [Resolution E](#resolution-e).

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| No managed identity assigned to Application Gateway [(Step 2)](#step-2). | Perform [Resolution A](#resolution-a). |
| Managed identity lacks Key Vault secret-read permission [(Step 3)](#step-3). | Perform [Resolution A](#resolution-a). |
| Key Vault firewall blocks Application Gateway subnet [(Step 4)](#step-4). | Perform [Resolution B](#resolution-b). |
| SSL certificate uses a versioned secret URI [(Step 5)](#step-5). | Perform [Resolution C](#resolution-c). |
| Certificate format is wrong, missing a private key, or is an incomplete chain [(Step 6)](#step-6). | Perform [Resolution D](#resolution-d). |
| Served certificates don't match the current Key Vault version, or the gateway is stuck in `Failed` state despite [Step 2](#step-2)–[Step 6](#step-6) indicating healthy values [(Step 7)](#step-7). | Perform [Resolution E](#resolution-e). |
| Served certificate matches the current Key Vault version with no anomaly, and `provisioningState` is `Succeeded` [(Step 7)](#step-7), yet the symptom persists. | File an Azure support request |

## Resolution A

Either the application gateway has no user-assigned managed identity or the assigned identity lacks permission to read secrets from the key vault. Application Gateway authenticates to Key Vault by using a user-assigned managed identity, and reads certificates as Key Vault `secrets` (not as Key Vault `certificate` objects). Without the `Get` permission on secrets, every Key Vault certificate retrieval fails.

1. Check whether a user-assigned managed identity exists in the Application Gateway resource group. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG

az identity list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, id:id, principalId:principalId}" \
  --output table
```

If no suitable identity exists, create one in the next step. If an identity exists but isn't assigned to the gateway, go to step 3.

2. Create a user-assigned managed identity for the Application Gateway.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step creates a new user-assigned managed identity in your resource group. Assign this identity to the Application Gateway so that it can authenticate to Key Vault. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az identity create \
  --name "$RESOURCE_NAME-identity" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

Record the `id` (full resource ID) and `principalId` from the output.

3. Assign the user-assigned managed identity to the Application Gateway.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step assigns the managed identity to your Application Gateway. The gateway uses this identity to authenticate when it retrieves certificates from Key Vault. This operation can take 2–5 minutes as the gateway configuration is updated.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:     " RESOURCE_NAME
[ -z "$IDENTITY_RESOURCE_ID" ] && read -rp "Identity Resource ID: " IDENTITY_RESOURCE_ID

az network application-gateway identity assign \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --identity "$IDENTITY_RESOURCE_ID"
```

4. Grant the managed identity permission to read secrets from the key vault.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step grants the Application Gateway's managed identity permission to read secrets from your key vault. This permission is required for the gateway to retrieve TLS certificates.

**Option 1: Key Vault uses RBAC authorization:**

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID:    " IDENTITY_PRINCIPAL_ID
[ -z "$KV_RG" ] && read -rp "Key Vault Resource Group: " KV_RG
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:           " KEY_VAULT_NAME

az role assignment create \
  --assignee "$IDENTITY_PRINCIPAL_ID" \
  --role "Key Vault Secrets User" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$KV_RG/providers/Microsoft.KeyVault/vaults/$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION"
```

**Option 2: Key Vault uses access policies:**

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:        " KEY_VAULT_NAME
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID: " IDENTITY_PRINCIPAL_ID

az keyvault set-policy \
  --name "$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --object-id "$IDENTITY_PRINCIPAL_ID" \
  --secret-permissions get
```

5. Wait 1–2 minutes for RBAC propagation, and then rerun [Step 3](#step-3). The identity should now show `Key Vault Secrets User` (for RBAC) or `get` in `secretPermissions` (for access policy).

6. Trigger a certificate refresh to test end-to-end access. See [Resolution E](#resolution-e) for more details.

If the issue persists after you grant permissions, go to [Resolution B](#resolution-b). The Key Vault firewall might also be blocking access.

## Resolution B

*The Key Vault network firewall has `defaultAction: "Deny"` set, and the Application Gateway subnet isn't in the Key Vault's virtual network rules. Application Gateway v2 doesn't qualify as an Azure trusted service for Key Vault bypass. Even if `bypass: "AzureServices"` is enabled, the subnet must be explicitly allowed.

Common scenarios that trigger this include:

- Locking down Key Vault recently by using a firewall policy.
- Moving Application Gateway to a new subnet.
- Creating a new Key Vault that has `Disable public access` as a default value.

1. Check the Key Vault firewall configuration and Application Gateway subnet ID by using Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "gatewayIPConfigurations[0].subnet.id" \
  --output tsv
```

Record this value as `{APPGW_SUBNET_ID}`.

2. Check the Key Vault firewall rules. 

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This operation enables the `Microsoft.KeyVault` service endpoint on your Application Gateway subnet. Service endpoints allow traffic from the subnet to reach Key Vault over the Azure backbone network. This operation doesn't interrupt existing traffic but modifies the subnet configuration.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$APPGW_SUBNET_ID" ] && read -rp "App Gateway Subnet ID: " APPGW_SUBNET_ID

az network vnet subnet update \
  --ids "$APPGW_SUBNET_ID" \
  --service-endpoints Microsoft.KeyVault \
  --subscription "$SUBSCRIPTION"
```

3. After you enable the service endpoint, add the Application Gateway subnet to the Key Vault firewall allowlist.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This operation adds your Application Gateway subnet to the Key Vault's network firewall allowlist. After you make this change, Application Gateway can reach Key Vault through the VNet service endpoint. Other traffic that's not on the allowlist remains blocked.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:        " KEY_VAULT_NAME
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$APPGW_SUBNET_ID" ] && read -rp "App Gateway Subnet ID: " APPGW_SUBNET_ID

az keyvault network-rule add \
  --name "$KEY_VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --subnet "$APPGW_SUBNET_ID"
```

4. Create a private endpoint. If public network access is completely disabled on the key vault (not only firewalled), a private endpoint is required instead of VNet service endpoints.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. If public access is completely disabled on the key vault, you must create a private endpoint in a VNet that's reachable by Application Gateway. Then, you must configure an Azure Private DNS zone so that the key vault hostname resolves to the private IP. This process has multiple steps.

The steps to create a private endpoint for Key Vault are:

a. Create a private endpoint in the same VNet as Application Gateway (or a peered VNet).
b. Create a private DNS zone (`privatelink.vaultcore.azure.net`).
c. Link the private DNS zone to the VNet.
d. Create a DNS zone group on the private endpoint.

For more information, see [Use private endpoints for Azure Key Vault](/azure/key-vault/general/private-link-service).

5. Rerun [Step 4](#step-4). The `virtualNetworkRules` should now include `{APPGW_SUBNET_ID}`.

6. Trigger a certificate refresh to test end-to-end access. For more details, see [Resolution E](#resolution-e).

If the issue persists after fixing network access, go to [Resolution C](#resolution-c) or [Resolution D](#resolution-d) to check the URI format and certificate content.

## Resolution C

The Application Gateway HTTPS listener references a versioned Key Vault secret URI (for example, `https://myvault.vault.azure.net/secrets/mycert/abc123def456`). When a versioned URI is used, Application Gateway always retrieves that specific version of the secret even after a newer version is published. This means that certificate autorotation doesn't occur, and the listener continues serving an expired or outdated certificate.

1. From [Step 5](#step-5), identify which SSL certificate entries have a version segment in the `keyVaultSecretId`.

2. Record the certificate name (the `name` field). This name is `{SSL_CERT_NAME}`. (This name is the name within Application Gateway. It can differ from the Key Vault secret name.)

|The following is an example of a correct versionless URI format:

```text
https://{KEY_VAULT_NAME}.vault.azure.net/secrets/{CERT_NAME}
```

3. Update the Application Gateway SSL certificate configuration to use a versionless Key Vault secret URI.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This updates the Application Gateway SSL certificate reference to use a versionless Key Vault secret URI. After this change, Application Gateway automatically polls Key Vault every four (4) hours and picks up newer versions of the certificate without manual intervention. This operation can take 2–5 minutes and doesn't interrupt existing connections.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:             " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:           " RESOURCE_NAME
[ -z "$SSL_CERT_NAME" ] && read -rp "SSL Cert Name (on gateway): " SSL_CERT_NAME
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:             " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:           " CERT_NAME

az network application-gateway ssl-cert update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$SSL_CERT_NAME" \
  --key-vault-secret-id "https://$KEY_VAULT_NAME.vault.azure.net/secrets/$CERT_NAME"
```

4. Rerun [Step 5](#step-5). The `keyVaultSecretId` should now end with `/secrets/{CERT_NAME}` without a version segment.

To verify that the next rotation cycle will work, check that the current Key Vault secret version matches what the gateway is serving by using Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:  " CERT_NAME

az keyvault secret show \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{version:id, updated:attributes.updated, expires:attributes.expires}" \
  --output json
```

If the certificate in Key Vault was recently updated, the Application Gateway picks up the new version within four (4) hours. To force an immediate refresh, see [Resolution E](#resolution-e).

## Resolution D

The certificate that's stored in Key Vault is in an invalid format for Application Gateway. 

Common problems include:

- The PFX file is missing the private key (exported as certificate-only).
- The PFX file uses a nonstandard encryption algorithm (for example, `AES-256-CBC` instead of `TripleDES-SHA1`).
- The certificate chain is incomplete (missing intermediate CA certificates).
- The content type isn't set to `application/x-pkcs12` or `application/x-pem-file`.
- The PEM file has the certificate, and key in the wrong order or uses incorrect line endings.

1. From [Step 6](#step-6), verify which specific format problem you identified from the following list:

- Missing `contentType`
- Missing private key
- Incomplete certificate chain

2. Rebuild the certificate in the correct format by using the private key and full chain, and then upload it to Key Vault.

The certificate must meet the following requirements for Application Gateway.

| Requirement | Detail |
|---|---|
| Format | PKCS#12 (PFX) or PEM |
| Private key | **Must be included** |
| Encryption | TripleDES-SHA1 recommended (maximum compatibility) |
| Chain | Full chain: leaf → intermediate(s) → root (root is optional but recommended) |
| Password | Can be blank or have a password (Key Vault handles this) |

**Option 1: Rebuild a correct PFX file from PEM components using OpenSSL**

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$CERT_NAME" ] && read -rp "Certificate Name: " CERT_NAME

# Combine leaf cert, intermediate(s), and private key into a PFX
openssl pkcs12 -export \
  -out "${CERT_NAME}.pfx" \
  -inkey private.key \
  -in certificate.crt \
  -certfile intermediate-chain.crt \
  -legacy
```

The `-legacy` flag ensures TripleDES-SHA1 encoding. This encoding has the best compatibility with Azure services. Without it, newer OpenSSL versions might use the `AES-256-CBC` encoding that some Azure services can't parse.

**Option 2: Verify that the PFX file is correct before you upload**

Run the following commands in Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$CERT_NAME" ] && read -rp "Certificate Name: " CERT_NAME
[ -z "$PFX_PASSWORD" ] && read -rp "PFX Password:     " PFX_PASSWORD

# Should show: private key + leaf cert + intermediates
openssl pkcs12 -info -in "${CERT_NAME}.pfx" -passin pass:"$PFX_PASSWORD" 2>&1 | grep -E "subject=|issuer=|key type"
```

3. Upload the corrected certificate to Key Vault.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This process uploads a new version of the certificate to Key Vault. The existing versions are preserved (not deleted). If the application gateway uses a versionless secret URI, it automatically picks up this new version within four (4) hours. If it uses a versioned URI, you also have to apply [Resolution C](#resolution-c) to enable autorotation.

**Option 1: Upload as a Key Vault certificate (recommended because Key Vault manages metadata):**

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:  " CERT_NAME
[ -z "$PFX_PASSWORD" ] && read -rp "PFX Password:      " PFX_PASSWORD

az keyvault certificate import \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --file "${CERT_NAME}.pfx" \
  --password "$PFX_PASSWORD" \
  --subscription "$SUBSCRIPTION"
```

**Option 2: Upload as a Key Vault secret (alternative used when using raw PFX bytes):**

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:    " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:  " CERT_NAME

az keyvault secret set \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --file "${CERT_NAME}.pfx" \
  --encoding base64 \
  --content-type "application/x-pkcs12" \
  --subscription "$SUBSCRIPTION"
```

4. Rerun [Step 6](#step-6). The `contentType` should be `application/x-pkcs12`, and the certificate should be `enabled: true`.
5. Trigger a certificate refresh. For more information, see [Resolution E](#resolution-e).

## Resolution E

Application Gateway serves an older certificate than the current key vault version (autorotation stalls). Or, its in-memory certificate cache is stale after a change in permissions, network rules, or the certificate version. Application Gateway polls Key Vault every four hours automatically, but you can force an immediate refresh.

> [!IMPORTANT]
> Application Gateway refetches the certificate from Key Vault only when the configured `keyVaultSecretId` changes. If you reapply the same versionless secret URI or run an empty `az network application-gateway update` command, the action finishes successfully but doesn't force the gateway to pull the newer Key Vault version. The following forced-refresh temporarily points the listener at the latest versioned secret URI (a `keyVaultSecretId` change), then sets it back to the versionless URI so that future autorotation is preserved.

1. Force an immediate refresh.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. They force the Application Gateway to immediately reread the latest certificate from Key Vault by changing the configured secret URI to the newest version and then restoring the versionless URI. Existing connections aren't interrupted, but each update might take 2–5 minutes to complete.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:             " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:           " RESOURCE_NAME
[ -z "$SSL_CERT_NAME" ] && read -rp "SSL Cert Name (on gateway): " SSL_CERT_NAME
[ -z "$KEY_VAULT_NAME" ] && read -rp "Key Vault Name:             " KEY_VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name:           " CERT_NAME

# 1. Get the LATEST (versioned) secret id from Key Vault
LATEST_SECRET_ID=$(az keyvault secret show \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

# 2. Point the listener at the latest VERSIONED id — this changes keyVaultSecretId and forces an immediate refetch
az network application-gateway ssl-cert update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$SSL_CERT_NAME" \
  --key-vault-secret-id "$LATEST_SECRET_ID"

# 3. Restore the VERSIONLESS URI so future autorotation continues to work
az network application-gateway ssl-cert update \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$SSL_CERT_NAME" \
  --key-vault-secret-id "https://$KEY_VAULT_NAME.vault.azure.net/secrets/$CERT_NAME"
```

2. If the Application Gateway is stuck in `provisioningState: "Failed"`, and the previous step fails, try an empty update to reset the state.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway update \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --no-wait
```

3. Wait 5–10 minutes, then recheck `provisioningState`. If it returns to `Succeeded`, rerun step 1 to refresh the certificate.
4. After the refresh, run the following commands by using Azure CLI to verify that the listener is now serving the current Key Vault certificate:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:  " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, sslCertificates:sslCertificates[].{name:name, provisioningState:properties.provisioningState}}" \
  --output json
```

| Result | Meaning |
|---|---|
| `provisioningState: "Succeeded"`, and SSL certificates show healthy states. | The certificate refresh is successful. |
| `provisioningState: "Failed"` with a Key Vault error. | Underlying issues exist (permissions, network, format) and might not be resolved. Recheck [Resolution A](#resolution-a)-[Resolution D](#resolution-d) |
| `provisioningState: "Updating"`. | The operation is still in progress. Wait five minutes, and then recheck. |

5. Test the HTTPS endpoint directly to verify that the correct certificate is being served by using Azure CLI:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$APPGW_FQDN_OR_IP" ] && read -rp "App Gateway FQDN or IP: " APPGW_FQDN_OR_IP
[ -z "$LISTENER_HOSTNAME" ] && read -rp "Listener Hostname:      " LISTENER_HOSTNAME

# Check which certificate the listener is presenting
openssl s_client -connect "$APPGW_FQDN_OR_IP:443" -servername "$LISTENER_HOSTNAME" 2>/dev/null | openssl x509 -noout -subject -dates -issuer
```

If the certificate details match the latest Key Vault version, and the expiration date is correct, the issue is resolved.

---

## Related articles

- [TLS termination with Key Vault certificates on Application Gateway](/azure/application-gateway/key-vault-certs)
- [Troubleshoot Key Vault errors on Application Gateway](/azure/application-gateway/key-vault-certs#troubleshooting)
- [Application Gateway TLS policy overview](/azure/application-gateway/application-gateway-ssl-policy-overview)
- [Configure an Application Gateway with TLS termination using Azure CLI](/azure/application-gateway/tutorial-ssl-cli)
- [Azure Key Vault networking settings](/azure/key-vault/general/how-to-azure-key-vault-network-security)
- [Use private endpoints for Azure Key Vault](/azure/key-vault/general/private-link-service)
- [Managed identities for Azure resources overview](/azure/active-directory/managed-identities-azure-resources/overview)
- [Renew Application Gateway certificates](/azure/application-gateway/renew-certificates)
