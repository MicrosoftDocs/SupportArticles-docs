---
title: Troubleshoot the ServicePrincipalValidationClientError error code
description: Troubleshoot the ServicePrincipalValidationClientError error in AKS. Learn how to reset or replace a service principal to successfully deploy your cluster.
ms.date: 10/23/2024
ms.reviewer: rissing, chiragpa, erbookbi, momajed, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ServicePrincipalValidationClientError error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the ServicePrincipalValidationClientError error code

## Summary

This article discusses how to identify and resolve the ServicePrincipalValidationClientError error that can occur when you create, upgrade, scale, or update credentials on a Microsoft Azure Kubernetes Service (AKS) cluster that uses a service principal. The error means Azure Kubernetes Service could not obtain a Microsoft Entra token with the service principal credentials stored for the cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), Azure CLI version 2.0.65 or later. Run az --version to check.
-	Permission to read the cluster and to reset credentials on the Microsoft Entra application used as the cluster service principal.
- For an existing cluster, confirm it still uses a service principal before following this article:
az aks show --resource-group <resource-group> --name <aks-cluster> --query servicePrincipalProfile.clientId -o tsv
If the output is msi, the cluster uses a managed identity. This error does not apply. See [Managed identities in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/managed-identity-overview).


## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> adal: Refresh request failed. Status Code = '401'.
>
> Response body: {
>
> "error": "invalid_client",
>
> "error_description": "AADSTS7000215: **Invalid client secret provided. Ensure the secret being sent in the request is the client secret value, not the client secret ID, for a secret added to app '123456789-1234-1234-1234-1234567890987'.\r\n**
>
> Trace ID: 12345\r\n
>
> Correlation ID: 6789\r\n
>
> Timestamp: 2022-02-03 03:07:11Z",
>
> "error_codes": [7000215],
>
> "timestamp": "2022-02-03 03:07:11Z",
>
> "trace_id": "12345",
>
> "correlation_id": "6789",
>
> "error_uri": "<https://login.microsoftonline.com/error?code=7000215>"
>
> } Endpoint <https://login.microsoftonline.com/123456787/oauth2/token?api-version=1.0>

## Cause

The Microsoft Entra application secret that AKS uses is missing, expired, mismatched, or was never applied to the cluster. Common causes:
- 	Expired client secret (AADSTS7000222). AKS service principal secrets expire unless rotated.
-   The configured client secret is invalid or doesn't match the application credential. This scenario can result in the AADSTS7000215 error. Ensure that you're using the client secret value, not the secret ID.
-   The client secret was reset in Microsoft Entra ID, but the credentials weren't updated on the AKS cluster. In this situation, the cluster can continue using the previous credential until its service principal credentials are updated.

-   New service principal created, but role assignments have not propagated (can take around 30 minutes).


## Solution 1: Reset the service principal secret in AKS

To resolve this issue, reset the service principal secret by using one of the following methods:

- Reset the service principal's credential by running the [az ad sp credential reset](/cli/azure/ad/sp/credential#az-ad-sp-credential-reset) command:

  ```azurecli-interactive
  az ad sp credential reset --name "01234567-89ab-cdef-0123-456789abcdef" --query password --output tsv
  ```

- Specify the expiration date by running the following command: 

  ```azurecli-interactive
  az ad sp credential reset --name <service-principal-name> --credential-description "New secret for AKS" --years 1
  ```

The preceding command resets the secret and displays it as output. Then, you can specify the new secret when you try to create the new cluster again.

For failed operations in an existing cluster, ensure that you update your AKS cluster with the new secret:

```azurecli-interactive
az aks update-credentials --resource-group <resource-group> --name <aks-cluster> --reset-service-principal --client-secret <new-client-secret>
```
> [!Note]
> On clusters that use Virtual Machine Scale Sets, resetting cluster credentials can trigger a node image upgrade so nodes pick up the new credential. Plan a maintenance window.

## Solution 2: Create a new service principal for AKS

You can create a new service principal and get the secret that's associated with it by running the [az ad sp create-for-rbac](/cli/azure/ad/sp#az-ad-sp-create-for-rbac) command:

```azurecli-interactive
az ad sp create-for-rbac --role Contributor
```

The output of the command should resemble the following JSON string:

```json
{
  "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
  "name": "23456789-abcd-ef01-2345-6789abcdef01",
  "password": "3456789a-bcde-f012-3456-789abcdef012",
  "tenant": "456789ab-cdef-0123-4567-89abcdef0123"
}
```

Note the `appId` and `password` values that are generated. After you get these values, you can rerun the cluster creation command for the new service principal and secret.

To update your AKS cluster with the new service principal's credential, run the following command:

```azurecli-interactive
az aks update-credentials --resource-group <resource-group> --name <aks-cluster> --service-principal <new-client-id> --client-secret <new-client-secret>
```
## Solution 3: Use a managed identity (preferred)

New AKS clusters use a system-assigned managed identity by default. Managed identities do not use a client secret and do not require this rotation.
If the cluster still uses a service principal, consider migrating to a managed identity after you restore operations. See [Managed identities in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/managed-identity-overview).

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

 
