---
title: Container group fails to pull Azure Container Registry images using managed identity authentication
description: Troubleshoot ACI image pull failures from Azure Container Registry when you use a managed identity. Identify common errors and apply the matching solution.
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.date: 09/09/2026
ms.service: azure-container-instances
ms.reviewer: tysonfreeman, kegonzal, jiayil 
ms.custom: sap:Management
ai-usage: ai-assisted
---

# Container group fails to pull images from Azure Container Registry by using managed identity authentication

## Summary

This article describes how to troubleshoot image pull failures when you deploy container groups to Azure Container Instances (ACI) from Azure Container Registry by using managed identity authentication.

When you deploy a container group to ACI, the container group might fail to pull an image from Azure Container Registry when you use a managed identity. Use the returned error message to identify the cause and apply the corresponding solution.

## Identify the deployment error

- If you deploy by using `az container create` and the container group isn't created, use Azure CLI to identify the returned error with the following command.

- If you deploy by using an Azure Resource Manager (ARM) or Bicep template and the container group isn't created, use Azure CLI to run the following [az deployment operation group list](/cli/azure/deployment/operation/group#az-deployment-operation-group-list) command to retrieve the error from the failed resource group deployment.

```azurecli
az deployment operation group list \
  --resource-group <resource-group-name> \
  --name <deployment-name> \
  --query "[?properties.provisioningState=='Failed'].properties.statusMessage" \
  --output json
```

- If the container group resource was created, run the following [az container show](/cli/azure/container#az-container-show) command to retrieve the provisioning state and container events.

```azurecli
az container show \
  --resource-group <resource-group-name> \
  --name <container-group-name> \
  --query "{provisioningState:provisioningState,events:containers[].instanceView.events}" \
  --output json
```

## The ACI API version doesn't support a managed identity

### Error

The deployment fails and returns an error that resembles the following output.

```output
Deployment failed. Correlation ID: <Correlation ID>. {
  "error": {
    "code": "InvalidImageRegistryCredentialType",
    "message": "Identity in 'imageRegistryCredentials' of container group '<container group name>' is not supported."
  }
}
```

### Cause

The container group uses an ACI API version earlier than `2021-07-01`. Earlier API versions don't support an identity in `imageRegistryCredentials`.

### Solution

Change the `apiVersion` of the `Microsoft.ContainerInstance/containerGroups` resource to `2021-07-01` or later.

Run the following command.

```json
{
  "type": "Microsoft.ContainerInstance/containerGroups",
  "apiVersion": "2021-09-01"
}
```

Redeploy the container group after you update the API version.

## The registry credential contains conflicting authentication types

### Error

The deployment fails and returns an error that resembles the following output.

```output
Deployment failed. Correlation ID: <Correlation ID>. {
"error": {
    "code": "AmbiguousImageResitryCredentialType",
    "message": "The registry credential type in the 'imageRegistryCredentials' of container group '<container group name>' cannot be detected. Please set exactly one of username or identity"
}
}
```

> [!NOTE]
> `AmbiguousImageResitryCredentialType` is the error code returned by the service. The word `Resitry` in the error code is misspelled.

### Cause

The same `imageRegistryCredentials` entry contains both managed identity authentication and username-based authentication. For example, the entry contains `identity` together with `username` or `password`.

### Solution

Use only managed identity authentication in the registry credential.

Follow these steps:

1. Keep the `server` and `identity` properties.
2. Remove `username` and `password` from the same registry credential.

The registry credential should resemble the following example.

```json
{
  "imageRegistryCredentials": [
    {
      "server": "<registry-name>.azurecr.io",
      "identity": "<user-assigned-managed-identity-resource-id>"
    }
  ]
}
```

Redeploy the container group after you update the registry credential.

## The image registry identity is invalid

### Error

The deployment fails and returns an error that resembles the following output.

```output
Deployment failed. Correlation ID: <Correlation ID>. {
"error": {
    "code": "InvalidImageRegistryIdentity",
    "message": "The identity in the 'imageRegistryCredentials' of container group '<container group name>' not found in container group identity list."
}
}
```

### Possible cause 1

The user-assigned managed identity in `imageRegistryCredentials.identity` isn't assigned to the container group.

### Resolution 1

Configure the same user-assigned managed identity in the container group identity and the registry credential.

Run the following command.

```json
{
  "identity": {
    "type": "UserAssigned",
    "userAssignedIdentities": {
      "<user-assigned-managed-identity-resource-id>": {}
    }
  },
  "properties": {
    "imageRegistryCredentials": [
      {
        "server": "<registry-name>.azurecr.io",
        "identity": "<user-assigned-managed-identity-resource-id>"
      }
    ]
  }
}
```

If you deploy by using Azure CLI, specify the same user-assigned managed identity in both `--assign-identity` and `--acr-identity`. 

Run the following command.

```azurecli
az container create \
  --resource-group <resource-group-name> \
  --name <container-group-name> \
  --image <registry-name>.azurecr.io/<repository>:<tag> \
  --assign-identity <user-assigned-managed-identity-resource-id> \
  --acr-identity <user-assigned-managed-identity-resource-id> \
  --os-type Linux
```

### Possible cause 2

The container group uses its system-assigned managed identity as the Azure Container Registry image pull identity. ACI supports only a user-assigned managed identity for this scenario.

### Resolution 2

Create or select a user-assigned managed identity. Assign it to the container group, and specify its resource ID in `imageRegistryCredentials.identity`, as shown in [Resolution 1](#resolution-1).

Redeploy the container group after you update the identity configuration.

## The registry credential is missing a required property

### Error

The deployment fails and returns an error that resembles the following output.

```output
Deployment failed. Correlation ID: <Correlation ID>. {
"error": {
    "code": "InvalidRequestContent",
    "message": "The request content was invalid and could not be deserialized: 'Required property 'server' not found in JSON. Path 'properties.imageRegistryCredentials[0]', line 1, position 586.'."
}
}
```

### Cause

The container group definition is malformed. In this example, the `server` property is missing from `imageRegistryCredentials`.

### Solution

Ensure that the container group definition includes:

- The `server` and `identity` properties of [ImageRegistryCredential](/rest/api/container-instances/container-groups/create-or-update#imageregistrycredential).
- The `type` and `userAssignedIdentities` properties of [ContainerGroupIdentity](/rest/api/container-instances/container-groups/create-or-update#containergroupidentity).

The relevant sections should resemble the following example.

```json
{
  "identity": {
    "type": "UserAssigned",
    "userAssignedIdentities": {
      "<user-assigned-managed-identity-resource-id>": {}
    }
  },
  "properties": {
    "imageRegistryCredentials": [
      {
        "server": "<registry-name>.azurecr.io",
        "identity": "<user-assigned-managed-identity-resource-id>"
      }
    ]
  }
}
```

Redeploy the container group after you correct the container group definition.

## The image is inaccessible

### Error

The deployment fails and returns an error that resembles the following output.

```output
Deployment failed. Correlation ID: <Correlation ID>. {
  "error": {
    "code": "InaccessibleImage",
    "message": "The image '<registry>.azurecr.io/<image>:<tag>' in container group '<container group name>' is not accessible. Please check the image and registry credential."
  }
}
```

### Possible cause 1

The registry authentication server, repository, image tag, or digest in the container group definition is incorrect, or the image doesn't exist in Azure Container Registry.

### Resolution 1

To verify that the image tag exists in the repository, see ["Manifest unknown: manifest tagged by 'tag' is not found" error](/troubleshoot/azure/azure-container-registry/manifest-tag-not-found).

For other image reference issues, see [Troubleshoot issues when you pull from Azure Container Registry](/troubleshoot/azure/azure-container-registry/troubleshoot-issues-pull-container-registry) to verify the registry, repository, and image reference.

After you correct the image reference, redeploy the container group.

### Possible cause 2

The user-assigned managed identity doesn't have the pull role required by the registry's role assignment permissions mode. An attribute-based access control (ABAC) condition might also exclude the target repository.

### Resolution 2

To determine the registry's authorization mode and grant the user-assigned managed identity access to the target repository, see [Add authorization permission to pull from the container registry](/troubleshoot/azure/azure-container-registry/authentication-required#solution-2-add-authorization-permission-to-pull-from-the-container-registry).

After the role assignment takes effect, redeploy the container group.

### Possible cause 3

Azure Container Registry is restricted by a private endpoint or public IP network rules, but trusted services is disabled. Therefore, ACI can't bypass the registry's network rules.

### Resolution 3

To verify that trusted services applies to the registry's network configuration and enable the setting, see [Allow trusted services to securely access a network-restricted container registry](/azure/container-registry/allow-access-trusted-services).

Registry network configuration changes can take time to propagate. Wait for the setting to take effect, and then redeploy the container group.

## The Azure Container Registry private endpoint uses the ACI-delegated subnet

### Error

When you create an Azure Container Registry private endpoint, the operation fails and returns an error that resembles the following output.

```output
Private endpoint <private-endpoint-resource-id> cannot be created as subnet <aci-subnet-resource-id> is delegated.
```

### Cause

You're creating the Azure Container Registry private endpoint in a subnet that's delegated to `Microsoft.ContainerInstance/containerGroups`. An ACI-delegated subnet can contain only container groups.

### Solution

Create the Azure Container Registry private endpoint in a different subnet that isn't delegated to ACI.

Follow these steps:

1. Create or select a nondelegated subnet that has connectivity to the ACI virtual network.
2. Create the Azure Container Registry private endpoint in that subnet.

For more information, see [Deploy container image from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi).

## Verify the resolution

After the configuration change takes effect, redeploy the container group. Then use Azure CLI to run the following [az container show](/cli/azure/container#az-container-show) command.

```azurecli
az container show \
  --resource-group <resource-group-name> \
  --name <container-group-name> \
  --query "{provisioningState:provisioningState,state:instanceView.state,events:containers[].instanceView.events}" \
  --output json
```

Verify that:

- `provisioningState` is `Succeeded`
- The container group reaches the expected running state
- The container events include `Pulled` and `Started`
- No new `InaccessibleImage` error appears after the redeployment

Container events can take time to appear. If the deployment succeeds but `Started` isn't present yet, wait and run the command again. Events from an earlier failed deployment don't indicate that the updated configuration failed. Use the timestamps to verify the events that the new deployment generated.

For other Azure Container Registry image pull errors, see [Troubleshoot issues when you pull from Azure Container Registry](/troubleshoot/azure/azure-container-registry/troubleshoot-issues-pull-container-registry).
