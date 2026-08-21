---
title: Cannot push images or artifacts to Azure Container Registry
description: Troubleshoot Azure Container Registry push errors for images and artifacts, including authentication, network, and permission issues. Find the right solution.
ms.date: 08/20/2026
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: zhixinsun, shiyao, pihe
ms.service: azure-container-registry
ms.custom: sap:Image Push Issues
ai-usage: ai-assisted
---

# Troubleshoot push errors in Azure Container Registry

## Summary

This article helps you troubleshoot issues that you might encounter when you push images or artifacts to an Azure container registry.

## Symptoms and initial troubleshooting

Before you change the registry configuration, identify whether the failure is a client-side issue or an Azure Container Registry-side issue:

- **Client-side issues** occur before the registry accepts the push request. Examples include an unavailable container client, an invalid local image or artifact reference, invalid credentials, DNS or route failures, and proxy or TLS trust problems.
- **Azure Container Registry-side issues** occur after the request reaches the registry. Examples include insufficient repository permissions, repository or image locks, registry firewall rules, manifest validation, customer-managed key access, and HTTP `5xx` responses.

This article provides commands for Docker and Podman. Other OCI-compatible clients, such as ORAS, can also push content to Azure Container Registry. When you use another client, run its equivalent commands and review its client-specific error output.

First, verify the local client.

**Option 1: Docker**

Confirm that the Docker daemon is running:

```console
docker info
```

**Option 2: Podman**

Podman is daemonless. Confirm that the client can access its local runtime and image storage:

```console
podman info
```

Next, confirm the registry login server:

```azurecli
az acr show --name <registry-name> --query loginServer --output tsv
```

The expected output is a lowercase login server such as `<registry-name>.azurecr.io`.

Run the following command to check the local environment and access to the target registry:

```azurecli
az acr check-health --name <registry-name> --ignore-errors --yes
```

If an issue is detected, the output includes an error code and description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!IMPORTANT]
> The `--ignore-errors` parameter tells the command to continue after a failed check. Review the complete output instead of treating command completion as proof that every check passed.

You can also test the registry challenge endpoint:

```console
curl -Iv --max-time 5 https://<registry-login-server>/v2/
```

An unauthenticated request normally returns HTTP `401 Unauthorized` together with a `WWW-Authenticate` challenge. This response confirms that DNS, TCP port 443, TLS, and the registry challenge endpoint are reachable. A `401` response to this unauthenticated probe isn't by itself a registry failure.

> [!NOTE]
> Helm-related or Notary-related errors from `az acr check-health` might indicate only that a local client is missing or incompatible. Docker Content Trust (DCT) is deprecated and will be removed from Azure Container Registry on March 31, 2028. For image signing and verification, migrate to [Notary Project and Notation](/azure/container-registry/container-registry-content-trust-deprecation).
>
> If Docker isn't installed because you use Podman, a Docker-related health check error identifies only that the Docker check couldn't run. Continue with the Podman-specific checks in this article.

Use the following table to select the first troubleshooting branch.

| Side | Error signature | Likely failure area | Start with |
| --- | --- | --- | --- |
| Client | Docker reports `Cannot connect to the Docker daemon`, or `podman info` fails | Local container client | [Local client or content](#client-side-scenario-1-the-local-client-or-content-is-unavailable) |
| Client | `tag does not exist`, `invalid reference format`, or `no such host` | Local image reference, login server, or DNS | [Local client or content](#client-side-scenario-1-the-local-client-or-content-is-unavailable) |
| Client | `UNAUTHORIZED` or `authentication required` | Authentication or expired credentials | [Authentication](#client-side-scenario-2-authentication-fails) |
| Client | `Client.Timeout exceeded while awaiting headers` | DNS, route, firewall, proxy, or endpoint connectivity | [Connection timeout](#client-side-scenario-3-request-canceled-while-waiting-for-connection) |
| Client | `proxyconnect tcp` or `x509: certificate signed by unknown authority` | Proxy configuration or TLS trust | [Proxy or TLS](#client-side-scenario-4-proxy-or-tls-certificate-errors) |
| Azure Container Registry | `insufficient_scope: authorization failed` | Push authorization, role mode, role condition, or token scope map | [Authorization](#azure-container-registry-side-scenario-1-push-authorization-fails) |
| Azure Container Registry | `The operation is disallowed on this registry` | Repository or image lock, or registry storage limit | [Operation is disallowed](#azure-container-registry-side-scenario-2-the-operation-is-disallowed-on-this-registry) |
| Azure Container Registry | `DENIED` and `client with IP ... is not allowed access` | Registry public-network firewall | [Registry firewall](#azure-container-registry-side-scenario-3-denied-client-is-not-allowed-access) |
| Azure Container Registry | `MANIFEST_INVALID` | Manifest size or syntax | [Manifest validation](#azure-container-registry-side-scenario-4-manifest-invalid) |
| Azure Container Registry | `Access to Key Encryption Key is forbidden` or `CMK_ERROR` | Customer-managed key, identity, or Key Vault access | [Customer-managed key](#azure-container-registry-side-scenario-5-customer-managed-key-errors) |
| Azure Container Registry | HTTP `429` or `TOOMANYREQUESTS` | Rate limiting or excessive concurrency | [Rate limiting](#azure-container-registry-side-scenario-6-too-many-requests) |
| Azure Container Registry | Repeated HTTP `5xx` responses | Possible transient or service-side failure | [Service-side failure](#azure-container-registry-side-scenario-7-http-5xx-or-intermittent-push-failures) |

## Client-side issues

### Client-side scenario 1: The local client or content is unavailable

When you use Docker, you might receive one of the following errors:

> `Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`

> `tag does not exist: <registry-login-server>/<repository>:<tag>`

> `invalid reference format: repository name must be lowercase`

> `dial tcp: lookup <registry-login-server>: no such host`

#### Solution 1: Verify the Docker client and image

Run `docker info`. If the command can't connect to the daemon, start or restart Docker.

Confirm that the local image and tag exist:

```console
docker image inspect <local-image>:<tag>
```

Tag the image by using the exact lowercase authentication server returned by `az acr show`:

```console
docker tag <local-image>:<tag> <registry-login-server>/<repository>:<tag>
docker push <registry-login-server>/<repository>:<tag>
```

#### Solution 2: Verify the Podman client and image

Run `podman info`. If the command fails, resolve the local Podman runtime or storage issue before you troubleshoot Azure Container Registry.

Confirm that the local image and tag exist:

```console
podman image inspect <local-image>:<tag>
```

Tag and push the image by using the exact lowercase authentication server returned by `az acr show`:

```console
podman tag <local-image>:<tag> <registry-login-server>/<repository>:<tag>
podman push <registry-login-server>/<repository>:<tag>
```

If DNS returns `no such host`, don't continue retrying the push. Compare the hostname in the image reference with the registry's `loginServer` value and then troubleshoot DNS resolution.

For ORAS or another artifact client, verify that the referenced local files and the exact target reference are correct before you push.

For complete client configuration and registry-name checks, see [Troubleshoot registry login](/azure/container-registry/container-registry-troubleshoot-login-authn-authz#potential-solutions).

### Client-side scenario 2: Authentication fails

> `unauthorized: authentication required`

Some clients render the message in lowercase, while Registry API responses use the uppercase `UNAUTHORIZED` code. Both forms indicate the same authentication failure.

Sign in to Azure first:

```azurecli
az login
```

Authentication proves the identity of the client. A successful client authentication confirms authentication, but doesn't prove that the identity has push permission.

#### Solution 1: Authenticate Docker

Authenticate Docker through Azure CLI:

```azurecli
az acr login --name <registry-name>
```

#### Solution 2: Authenticate Podman

Azure CLI uses Docker by default. Set `DOCKER_COMMAND` to `podman` when you authenticate.

For Bash:

```bash
DOCKER_COMMAND=podman az acr login --name <registry-name>
```

For PowerShell:

```azurepowershell
$env:DOCKER_COMMAND = "podman"
az acr login --name <registry-name>
Remove-Item Env:DOCKER_COMMAND
```

For detailed troubleshooting of Microsoft Entra identities, service principals, admin users, and repository tokens, see [Troubleshoot Azure Container Registry authentication issues](acr-authentication-errors.md) and [Sign in by using an alternative container tool instead of Docker](/azure/container-registry/container-registry-authentication#sign-in-by-using-an-alternative-container-tool-instead-of-docker).

After you correct the credentials, test the actual push operation. If authentication succeeds but the push returns `insufficient_scope: authorization failed`, continue to [Azure Container Registry-side scenario 1](#azure-container-registry-side-scenario-1-push-authorization-fails).

### Client-side scenario 3: Request canceled while waiting for connection

> `Get "https://<registry-login-server>/v2/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)`

#### Solution: Verify connectivity to the registry login server on port 443

> [!TIP]
> The registry login server is also known as the Registry REST API endpoint. Its name is usually `<registry-name>.azurecr.io` and must be lowercase.

Authentication, content discovery, and push uploads use the registry login server. For a geo-replicated registry, a push can also use a regional endpoint.

Test DNS resolution and HTTPS connectivity:

```console
nslookup <registry-login-server>
curl -Iv --max-time 5 https://<registry-login-server>/v2/
```

For detailed NSG, route table, and firewall diagnostics, see [Request canceled while waiting for connection](request-canceled-waiting-connection-timeout-exceeded.md). For the complete public endpoint, private endpoint, virtual network, and client firewall workflow, see [Troubleshoot network issues with a registry](/azure/container-registry/container-registry-troubleshoot-access).

### Client-side scenario 4: Proxy or TLS certificate errors

You might receive one of the following errors:

> `proxyconnect tcp: dial tcp <proxy-address>: connect: connection refused`

> `tls: failed to verify certificate: x509: certificate signed by unknown authority`

#### Solution: Work with your network or security administrator

These errors indicate a proxy connectivity or certificate trust issue in the client-managed network path. Work with your network or security administrator to review the proxy path and certificate trust configuration. Don't disable TLS verification or configure the registry as insecure.

## Azure Container Registry-side issues

### Azure Container Registry-side scenario 1: Push authorization fails

> `insufficient_scope: authorization failed`

Authorization determines whether an authenticated identity can push to the target repository.

#### Solution: Verify the role assignment mode and push role

Check the registry's role assignment permissions mode:

```azurecli
az acr show --name <registry-name> --resource-group <resource-group> --query roleAssignmentMode --output tsv
```

List the role assignments for the identity:

```azurecli
az role assignment list --assignee <principal-id> --scope <registry-resource-id> --include-inherited --output table
```

Use the write role that corresponds to the registry mode:

| Role assignment permissions mode | Role for push | Important behavior |
| --- | --- | --- |
| **RBAC Registry Permissions** | `AcrPush` | The role grants registry-wide pull and push permissions. |
| **RBAC Registry + ABAC Repository Permissions** | `Container Registry Repository Writer` | Legacy `AcrPull`, `AcrPush`, and `AcrDelete` roles aren't honored. An optional ABAC condition must match the target repository. |

For ABAC-enabled registries, review the role assignment condition and make sure that the full repository name matches the condition. Follow [Configure Azure ABAC repository permissions](/azure/container-registry/container-registry-rbac-abac-repository-permissions#configure-azure-abac-repository-permissions) for the complete role-assignment procedure.

If you use a non-Microsoft Entra repository token, its scope map must include `content/read` and `content/write` for the target repository. Follow [Manage tokens and scope maps](/azure/container-registry/container-registry-token-based-repository-permissions#manage-tokens-and-scope-maps) to inspect or update the token.

### Azure Container Registry-side scenario 2: The operation is disallowed on this registry

> `The operation is disallowed on this Azure Container Registry, repository or image. View troubleshooting steps at https://aka.ms/acr/faq/#why-does-my-pull-or-push-request-fail-with-disallowed-operation`

#### Solution 1: Make sure the repository or image isn't locked

This issue might occur if the write operation is disabled for a repository or image. This state denies delete and push operations. Azure Container Registry allows you to configure changeable attributes to prevent accidental deletion, write, or read operations over a repository or image.

Check the current repository or image attributes by using one of the following commands:

```azurecli
# Check the repository attributes.
az acr repository show --name <registry-name> --repository <repository> --output jsonc

# Check the image attributes by tag.
az acr repository show --name <registry-name> --image <repository>:<tag> --output jsonc

# Check the image attributes by manifest digest.
az acr repository show --name <registry-name> --image <repository>@sha256:<digest> --output jsonc
```

Example output:

```output
{
  "changeableAttributes": {
    "deleteEnabled": false,
    "listEnabled": true,
    "readEnabled": true,
    "writeEnabled": false
  },
  "createdTime": "2024-08-20T15:22:51.0355721Z",
  "imageName": "myimage",
  "lastUpdateTime": "2024-08-20T15:23:01.2739647Z",
  "manifestCount": 1,
  "registry": "myregistry.azurecr.io",
  "tagCount": 2
}
```

If `writeEnabled` is `false`, unlock the repository or image by using the appropriate command:

```azurecli
# Unlock the repository.
az acr repository update --name <registry-name> --repository <repository> --write-enabled true

# Unlock the image by tag.
az acr repository update --name <registry-name> --image <repository>:<tag> --write-enabled true

# Unlock the image by manifest digest.
az acr repository update --name <registry-name> --image <repository>@sha256:<digest> --write-enabled true
```

#### Solution 2: Verify that the registry hasn't reached its storage limit

Check the registry's current usage and limit:

```azurecli
az acr show-usage --name <registry-name> --output table
```

The storage limit depends on the registry SKU. For the current limits and options when a registry approaches its limit, see [Azure Container Registry SKU features and limits](/azure/container-registry/container-registry-skus#sku-features-and-limits).

### Azure Container Registry-side scenario 3: Denied, client is not allowed access

> `denied: {"errors":[{"code":"DENIED","message":"client with IP '<client-ip>' is not allowed access. Refer https://aka.ms/acr/firewall to grant access."}]}`

#### Solution: Make sure the registry firewall allows the client

By default, Azure Container Registry accepts connections over the internet from hosts on any network. A registry can instead restrict public access to specific IP addresses or CIDR ranges, or disable public network access.

Check the current public-network configuration:

```azurecli
az acr show --name <registry-name> --query "{publicNetworkAccess:publicNetworkAccess,defaultAction:networkRuleSet.defaultAction,ipRules:networkRuleSet.ipRules}" --output jsonc
```

If public access is enabled but the default action is `Deny`, add the client's current public IP address or CIDR range to the allowed list. If public network access is disabled, connect through a configured private endpoint.

Because the registry firewall applies to both push and pull operations, see [Client with IP is not allowed access](client-ip-address-not-allowed-access.md) for detailed remediation.

If public network access is disabled and the registry FQDN resolves to a public IP address instead of the private endpoint IP address, see [Can't get private IP address of an Azure Container Registry FQDN](cant-resolve-container-registry-fqdn-private-ip-address.md).

### Azure Container Registry-side scenario 4: Manifest invalid

You might receive one of the following registry responses:

> `MANIFEST_INVALID: manifest invalid`

> `http: request body too large`

#### Solution 1: Keep the manifest within the supported limit

Azure Container Registry has a maximum manifest size of 4 MiB. This limit applies to the manifest JSON document, not to the combined size of the referenced image layers.

If the client reports `MANIFEST_INVALID` with `request body too large`, reduce the manifest size. For example, remove unnecessary annotations or descriptors, or split an unusually large artifact index into smaller artifacts. For the current limit, see [Azure Container Registry SKU features and limits](/azure/container-registry/container-registry-skus#sku-features-and-limits).

Some clients validate a manifest locally and stop before they send an HTTP request. Enable the client's debug or verbose output and determine whether the error came from the client or from an HTTP response returned by the registry.

**Option 1: Docker**

```console
docker --debug push <registry-login-server>/<repository>:<tag>
```

**Option 2: Podman**

```console
podman --log-level=debug push <registry-login-server>/<repository>:<tag>
```

#### Solution 2: Restore a soft-deleted manifest before pushing the same digest

> [!NOTE]
> The Azure Container Registry soft delete policy is currently in preview.

When soft delete is enabled, pushing an image to a soft-deleted repository restores the repository. However, Azure Container Registry doesn't allow a push that shares the same manifest digest with a soft-deleted image. Restore that image before you retry the push.

List the soft-deleted manifests for the repository:

```azurecli
az acr manifest list-deleted --registry <registry-name> --name <repository>
```

Restore the image by tag and digest:

```azurecli
az acr manifest restore --registry <registry-name> --name <repository>:<tag> --digest sha256:<digest>
```

For limitations and other restore options, see [Recover deleted artifacts with the soft delete policy](/azure/container-registry/container-registry-soft-delete-policy#view-and-restore-soft-deleted-artifacts).

### Azure Container Registry-side scenario 5: Customer-managed key errors

You might receive one of the following errors:

> `Access to Key Encryption Key is forbidden. View troubleshooting steps at https://aka.ms/acr/cmk`

> `CMK_ERROR`

> `The identity associated with the registry is inactive. This could be due to attempted removal of the identity. Reassign the identity manually.`

#### Solution: Verify the key and registry encryption identity

Run the health check and review the complete output for `CMK_ERROR`:

```azurecli
az acr check-health --name <registry-name> --ignore-errors --yes
```

Use the push error and current configuration to identify the condition:

- If the Key Vault or key was deleted, disabled, or made inaccessible, recover or re-enable it.
- If the registry encryption identity is inactive, reassign the identity to the registry.
- If `az acr check-health` reports `CMK_ERROR`, use it as supporting diagnostic evidence. The health check error isn't itself a registry data-plane response code.

For identity removal or expiry, Key Vault firewall changes, and deleted keys or vaults, follow [Troubleshoot a customer-managed key](/azure/container-registry/tutorial-troubleshoot-customer-managed-keys). Then rerun the health check and retry the push.

### Azure Container Registry-side scenario 6: Too many requests

You might receive one of the following responses:

> `TOOMANYREQUESTS: too many requests`

> `429 Too Many Requests`

#### Solution: Honor the retry guidance and reduce the request rate

If the response includes a `Retry-After` header, wait for the specified period before you retry. Otherwise, retry a bounded number of times with exponential backoff. Reduce concurrent uploads or other registry requests that use the same registry.

For throughput, concurrency, and service-tier guidance, see [Troubleshoot performance issues with Azure Container Registry](/azure/container-registry/container-registry-troubleshoot-performance) and [Azure Container Registry SKU features and limits](/azure/container-registry/container-registry-skus#sku-features-and-limits).

### Azure Container Registry-side scenario 7: HTTP 5xx or intermittent push failures

An isolated client timeout doesn't prove that Azure Container Registry returned a service-side error. First complete the local, authentication, authorization, network, proxy, TLS, registry policy, manifest, CMK, and rate-limit checks in this article.

If the client receives repeated HTTP `5xx` responses:

1. Retry a small number of times with exponential backoff. Don't use an unbounded retry loop.
1. Capture the full client output or debug trace, including the HTTP status and any correlation or request ID.
1. Record the exact UTC start and end times, registry resource ID, repository and tag, source location and public IP address, client version, and command.
1. For a geo-replicated registry, record whether the client used the global authentication server or a regional endpoint.
1. Check [Azure Service Health](/azure/service-health/overview) and [Azure Resource Health](/azure/service-health/resource-health-overview) for matching events.

If the issue is reproducible and the evidence shows repeated `5xx` responses, provide this information to Azure Support. If the client shows only a DNS failure, connection refusal, TLS error, or timeout without a registry HTTP response, continue troubleshooting the client or network path instead.

## Collect information for support

Before you contact Azure Support, collect the following nonsecret information. Record the version of the OCI client that produced the error.

**Option 1: Docker**

```console
docker version
docker info
```

**Option 2: Podman**

```console
podman version
podman info
```

```azurecli
az version
az acr show --name <registry-name> --query "{id:id,location:location,sku:sku.name,loginServer:loginServer,roleAssignmentMode:roleAssignmentMode,publicNetworkAccess:publicNetworkAccess}" --output jsonc
az acr check-health --name <registry-name> --ignore-errors --yes
```

Also include:

- The full push command and complete error output.
- The exact UTC time range and time zone.
- The source environment, source public IP address, and whether a proxy or TLS inspection device is present.
- The authentication method and principal object ID. Don't include passwords, secrets, access tokens, or refresh tokens.
- The target repository and tag.
- Any HTTP status, correlation ID, request ID, Service Health event, or Resource Health event.

## Related content

- [Check the health of an Azure container registry](/azure/container-registry/container-registry-check-health)
- [Troubleshoot Azure Container Registry authentication issues](acr-authentication-errors.md)
- [Troubleshoot registry login, authentication, and authorization](/azure/container-registry/container-registry-troubleshoot-login-authn-authz)
- [Request canceled while waiting for connection](request-canceled-waiting-connection-timeout-exceeded.md)
- [Troubleshoot network issues with a registry](/azure/container-registry/container-registry-troubleshoot-access)
- [Client with IP is not allowed access](client-ip-address-not-allowed-access.md)
- [Can't get private IP address of an Azure Container Registry FQDN](cant-resolve-container-registry-fqdn-private-ip-address.md)
- [Recover deleted artifacts with the soft delete policy](/azure/container-registry/container-registry-soft-delete-policy)
- [Troubleshoot performance issues with Azure Container Registry](/azure/container-registry/container-registry-troubleshoot-performance)
- [Azure Container Registry permissions and role assignments overview](/azure/container-registry/container-registry-rbac-built-in-roles-overview)
- [Azure ABAC repository permissions in Azure Container Registry](/azure/container-registry/container-registry-rbac-abac-repository-permissions)
- [Non-Microsoft Entra token-based repository permissions](/azure/container-registry/container-registry-token-based-repository-permissions)
- [Troubleshoot a customer-managed key](/azure/container-registry/tutorial-troubleshoot-customer-managed-keys)
- [Transition from Docker Content Trust to Notary Project](/azure/container-registry/container-registry-content-trust-deprecation)
- [Azure Service Health overview](/azure/service-health/overview)
- [Azure Resource Health overview](/azure/service-health/resource-health-overview)
