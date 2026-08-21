---
title: Authentication required error message in Azure Container Registry
description: Understand how to resolve a scenario in which an authentication required error occurs when you try to access Azure Container Registry.
ms.date: 08/20/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: zhixinsun, shiyao, pihe
ms.service: azure-container-registry
ms.topic: troubleshooting
ai-usage: ai-assisted
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure Container Registry user, I want to fix an "unauthorized: authentication required" error so that I can pull a container image or artifact successfully.
---
# Authentication required error when trying to access Azure Container Registry

## Summary

This article describes how to resolve an **unauthorized: authentication required** error that occurs when you try to pull a container image or artifact from a Microsoft Azure Container Registry.

## Symptoms

When you pull a container image or artifact from Azure Container Registry, the pull fails with an authentication error that resembles the following message:

> Head "https\://\<container-registry-name>.azurecr.io/v2/\<repository>/manifests/\<tag>": unauthorized: authentication required, visit <https://aka.ms/acr/authorization> for more information.


> [!NOTE]
> This article applies when the registry returns `authentication required`. If the pull fails with a different error, use the matching article:
>
> - [`Client with IP address is not allowed access`](./client-ip-address-not-allowed-access.md)
> - [`Context deadline exceeded`](./context-deadline-exceeded.md)
> - [`I/O time-out`](./download-failed-443-io-time-out.md)
> - [`Manifest tag is not found`](./manifest-tag-not-found.md)
> - [Fail to pull images to Azure Web App](./pull-image-to-web-app-fail.md)
> - [`Request canceled while waiting for connection`](./request-canceled-waiting-connection-timeout-exceeded.md)
>
> For the general troubleshooting workflow, see [Troubleshoot issues when you pull from Azure Container Registry](./troubleshoot-issues-pull-container-registry.md).


## Cause

Azure Container Registry is private by default. Unless you [enable anonymous pull access](/azure/container-registry/anonymous-pull-access), the client must provide a valid credential, and the authenticated identity must be authorized to pull from the target repository.

The failure can occur at either of these stages:

| Stage | Common causes | Possible error |
| --- | --- | --- |
| Authentication or token exchange | No credential, incorrect password, disabled administrator account, disabled repository token, expired credential, or a Microsoft Entra identity that can't obtain an ACR token | `unauthorized: authentication required` |
| Repository authorization | Missing pull role, a role that isn't valid for the registry's role assignment mode, an ABAC condition that doesn't match the repository, or a scope map without `content/read` | `authentication required` or `pull access denied` |

Registry authentication and repository authorization are separate. Successful registry authentication doesn't prove that the credential can pull from a particular repository.

## Solution 1: Authenticate to the container registry

Identify the authentication method used by the failing client, and then validate the corresponding credential.

For supported authentication methods and client-specific sign-in instructions, see [Authenticate with Azure Container Registry](/azure/container-registry/container-registry-authentication).

### Microsoft Entra identity

For an interactive user, sign in again and authenticate to the registry:

```azurecli
az login
az acr login --name <registry-name>
```

For unattended workloads, validate the service principal or managed identity that actually performs the pull. Check that:

- The service principal client ID and tenant are correct.
- The client secret or certificate hasn't expired or been replaced.
- The intended system-assigned or user-assigned managed identity is configured on the pulling resource.
- The registry accepts the Microsoft Entra token audience used by the client. For more information, see [Configure registry acceptance of Microsoft Entra authentication scopes](/azure/container-registry/container-registry-disable-authentication-as-arm).

Microsoft Entra registry tokens issued through `az acr login` are valid for three hours. Run `az acr login` again if the cached token has expired.

### Administrator account

Confirm that the registry administrator account is enabled and that the client uses the current username and one of the current passwords:

```azurecli
az acr show --name <registry-name> --query adminUserEnabled
```

The administrator account has registry-wide push and pull permissions and is intended mainly for testing. Prefer a Microsoft Entra identity or repository-scoped token for production workloads.

### Repository-scoped token

Confirm that:

- The token status is `enabled`.
- The token password isn't expired or regenerated.
- The client uses the token name as the username.

For more information, see [Non-Microsoft Entra token-based repository permissions](/azure/container-registry/container-registry-token-based-repository-permissions).

### Clear stale Docker credentials

Docker can continue to send an old cached credential after a password or token is changed. Clear the cached credential, authenticate again, and retry the pull:

```console
docker logout <registry-name>.azurecr.io
docker login <registry-name>.azurecr.io
docker pull <registry-name>.azurecr.io/<repository>:<tag>
```

If anonymous pull is enabled, clear existing Docker credentials before testing an unauthenticated pull. An invalid cached credential can prevent an otherwise valid anonymous pull.

## Solution 2: Add authorization permission to pull from the container registry

First, determine the registry's role assignment permissions mode:

```azurecli
az acr show \
  --name <registry-name> \
  --resource-group <resource-group> \
  --query roleAssignmentMode \
  --output tsv
```

Use the authorization model that matches the registry:

| Registry authorization model | Pull permission |
| --- | --- |
| **RBAC Registry Permissions** | Assign `AcrPull` to the Microsoft Entra user, service principal, or managed identity. |
| **RBAC Registry + ABAC Repository Permissions** | Assign `Container Registry Repository Reader`. If the assignment has an ABAC condition, ensure that the condition includes the target repository. |
| **Non-Microsoft Entra repository token** | Associate the token with a scope map that grants `content/read` on the target repository. |

For detailed role definitions and permissions, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles).

> [!IMPORTANT]
> An ABAC-enabled registry doesn't honor the legacy `AcrPull`, `AcrPush`, or `AcrDelete` roles. In this mode, `Owner`, `Contributor`, and `Reader` grant control-plane access but don't grant repository data-plane access.

For example, assign `AcrPull` to an identity on a registry that uses **RBAC Registry Permissions**:

```azurecli
ACR_ID=$(az acr show --name <registry-name> --query id --output tsv)

az role assignment create \
  --assignee-object-id <principal-id> \
  --assignee-principal-type ServicePrincipal \
  --role AcrPull \
  --scope "$ACR_ID"
```

For an ABAC-enabled registry, assign the repository reader role instead:

```azurecli
az role assignment create \
  --assignee-object-id <principal-id> \
  --assignee-principal-type ServicePrincipal \
  --role "Container Registry Repository Reader" \
  --scope "$ACR_ID"
```

Role assignments and role assignment mode changes can take time to propagate. After the configuration is effective, authenticate again and validate authorization with an actual pull. For example, if you use Docker:

```console
docker pull <registry-name>.azurecr.io/<repository>:<tag>
```

Don't use successful registry authentication as the only validation. Authentication can succeed while the pull is denied because of an ABAC role mismatch or a scope map that lacks `content/read`.

### Optional: Review authentication events

Azure Container Registry doesn't collect or store resource logs by default. This step applies only if you configured a diagnostic setting to route `ContainerRegistryLoginEvents` to a Log Analytics workspace before the issue occurred, and you have access to that workspace.

Query the authentication failures:

```kusto
ContainerRegistryLoginEvents
| where ResultDescription != "200"
| project TimeGenerated, Identity, CallerIpAddress, ResultDescription
| order by TimeGenerated desc
```

For information about configuring diagnostic settings and querying ACR resource logs, see [Monitor Azure Container Registry](/azure/container-registry/monitor-service).

### References

- [Troubleshoot issues when you pull from Azure Container Registry](./troubleshoot-issues-pull-container-registry.md)
- [Monitor Azure Container Registry](/azure/container-registry/monitor-service)
- [Troubleshoot registry login](/azure/container-registry/container-registry-troubleshoot-login-authn-authz)
- [Azure ABAC repository permissions in Azure Container Registry](/azure/container-registry/container-registry-rbac-abac-repository-permissions)
- [Non-Microsoft Entra token-based repository permissions](/azure/container-registry/container-registry-token-based-repository-permissions)


 
