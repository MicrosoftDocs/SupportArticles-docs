---
title: Troubleshoot BadRequest or InvalidClientSecret errors in AKS
description: Identify and resolve expired or invalid service principal client secrets that block AKS cluster creation or upgrade. Learn how to fix them now.
ms.date: 09/21/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: pihe, shiyao, zhixinsun
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot BadRequest or InvalidClientSecret error

## Summary

This article explains how to identify and resolve the `AADSTS7000222` (expired client secret) and `AADSTS7000215` (invalid client secret) errors that occur when you try to create or upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

Ensure that you meet the following prerequisites:

- [Azure CLI](/cli/azure/install-azure-cli) is installed and configured.
- When creating or updating a service-principal-based AKS cluster, you have a valid service principal with a non-expired client secret.

## Symptoms and cause

When you try to create or upgrade an AKS cluster, you receive one of the following error messages as listed in the following table.

| Error code | Message | Cause |
|---|---|---|
| `BadRequest` | **The credentials in ServicePrincipalProfile were invalid.** Please see <https://aka.ms/aks-sp-help> for more details. (Details: adal: Refresh request failed. Status Code = '401'. Response body: {"error": "invalid_client", "error_description": "**AADSTS7000222: The provided client secret keys for app '\<application-id>' are expired.** Visit the Azure portal to create new keys for your app: <https://aka.ms/NewClientSecret>, or consider using certificate credentials for added security: <https://aka.ms/certCreds>." | An expired SP secret was supplied during creation, or the secret stored in AKS expired before an update or upgrade. A valid replacement might already exist in Entra but hasn't been applied to AKS. |
| `BadRequest` | **The credentials in ServicePrincipalProfile were invalid.** The details contain **AADSTS7000215: Invalid client secret provided.** Ensure the secret being sent in the request is the client secret value, not the client secret ID, for a secret added to app '\<application-id>'. | The creation or credential-reset request supplies an incorrect secret or a mismatched client ID/secret pair. An existing cluster can also encounter this error if it still uses a credential deleted from Entra. |
| `InvalidClientSecret` | **Customer auth is not valid for tenant: \<tenant-id>**: adal: Refresh request failed. Status Code = '401'. Response body: {"error": "invalid_client", "error_description": "**AADSTS7000222: The provided client secret keys for app '\<application-id>' are expired.** Visit the Azure portal to create new keys for your app: <https://aka.ms/NewClientSecret>, or consider using certificate credentials for added security: <https://aka.ms/certCreds>." | An expired SP secret is being used, as in the `AADSTS7000222` scenarios above. |

### Verify the cause

Use a command line tool or Azure PowerShell to set the target subscription and cluster.

# [Bash](#tab/bash)

Run the following commands.

```bash
set +x
set -euo pipefail
SUBSCRIPTION_ID="<subscription-id>"
RESOURCE_GROUP="<resource-group-name>"
CLUSTER_NAME="<cluster-name>"

az account set --subscription "$SUBSCRIPTION_ID"
```

# [PowerShell](#tab/powershell)

Run the following commands.

```powershell
$SubscriptionId = "<subscription-id>"
$ResourceGroup = "<resource-group-name>"
$ClusterName = "<cluster-name>"

az account set --subscription $SubscriptionId
if ($LASTEXITCODE -ne 0) { throw "Could not select the subscription." }
```

---

### For a new cluster

Check `--service-principal` and `--client-secret` in the creation command, or `servicePrincipalProfile` in the deployment template. The secret must be the matching application's unexpired **Value**, not its secret ID. Use a command line tool or Azure PowerShell to check its expiration dates.

# [Bash](#tab/bash)

Run the following command.

```bash
APP_ID="<application-client-id-from-the-create-command>"
az ad app credential list --id "$APP_ID"
```

# [PowerShell](#tab/powershell)

Run the following command.

```powershell
$AppId = "<application-client-id-from-the-create-command>"
az ad app credential list --id $AppId
if ($LASTEXITCODE -ne 0) { throw "Could not read credential metadata. Check tenant and application permissions." }
```

---

### For an existing cluster

To retrieve the cluster's service principal client ID and check its credential expiration dates, see [Check the expiration date of your service principal](/azure/aks/update-credentials#check-the-expiration-date-of-your-service-principal).

If `az aks update-credentials` fails, check the service principal and secret value that you supplied to that command.

Alternatively, you can use the [Azure portal](https://portal.azure.com) to verify that the service principal name and secret are correct and aren't expired.

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.
2. In the navigation pane of Microsoft Entra ID, select **App registrations**.
3. On the **Owned applications** tab, select the affected application.
4. Find the service principal name and secret information, and verify that the information is correct and current.

Compare the expiration with the failure time in Coordinated Universal Time (UTC). These checks show metadata, not the secret value stored in AKS. For `AADSTS7000215`, also verify the supplied value against the approved credential source.

## Solution

1. Obtain valid credentials for the application. For `AADSTS7000222`, replace the expired secret. For `AADSTS7000215`, first correct the secret value and client ID pairing. A typing error or using a secret ID instead of the value doesn't require a new secret. If you need a replacement, see [Reset the existing service principal credentials](/azure/aks/update-credentials#reset-the-existing-service-principal-credentials) or [Create a new service principal](/azure/aks/update-credentials#create-a-new-service-principal) if you need to replace the service principal.
2. Apply the credentials according to the failed operation. The following table summarizes the actions for each operation.

   | Operation | Action |
   |---|---|
   | Create AKS | Correct the service principal and secret in the original creation command or deployment, then retry. If no cluster exists, don't run `az aks update-credentials`. |
   | Update or upgrade an existing AKS cluster | Follow [Update AKS cluster with service principal credentials](/azure/aks/update-credentials#update-aks-cluster-with-service-principal-credentials), then retry the original operation after the credential update succeeds. |
   | Update service principal credentials | Follow the same [credential-update procedure](/azure/aks/update-credentials#update-aks-cluster-with-service-principal-credentials) with the corrected client ID and secret value. |

Follow the credential rotation precautions in the linked documentation and confirm that the originally requested operation completes successfully.


## References

- [Update or rotate AKS credentials](/azure/aks/update-credentials).
- [Use a service principal with AKS](/azure/aks/kubernetes-service-principal).
- [Manage application credentials with Azure CLI](/cli/azure/ad/app/credential).
- [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).
- [AADSTS7000222: expired client secret](https://login.microsoftonline.com/error?code=7000222).
- [AADSTS7000215: invalid client secret](https://login.microsoftonline.com/error?code=7000215).

