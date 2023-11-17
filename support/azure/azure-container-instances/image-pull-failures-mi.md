---
title: Fails to pull ACR images using Managed Identity authentication
description: Describes how to troubleshoot image pull failures when you deploy to Azure Container Instances (ACI) from Azure Container Registry (ACR) by using a managed identity.
ms.date: 11/17/2023
ms.service: azure-container-instances
ms.reviewer: tysonfreeman, v-weizhu
---

# Fails to pull images from Azure Container Registry by using Managed Identity authentication

This article discusses how to troubleshoot image pull failures when you deploy to Azure Container Instances (ACI) from Azure Container Registry (ACR) by using a managed identity.

## Symptoms 

When you try to deploy a container group and pull images from an Azure container registry that runs behind a private endpoint by using a managed identity, the image pulls fail.

## Cause 

Here are some causes of image pull failures:

- From the ACI side:

  - Based on the ACI API version used when deploying the container group, the credential format provided in the [container group ARM template](/azure/templates/microsoft.containerinstance/containergroups?pivots=deployment-language-arm-template) might be invalid.
  - Using a managed identity in the container group might violate ACI limitations.
  - The container group definition in the ARM template might be malformed. 

- From the ACR side:

  - You might be using an earlier API version.
  - You might be using a private DNS zone for the container registry.

## Troubleshooting from the ACI side

1. Check if you're using ACI API version 2021-07-01 or later.

    If an unexpected ACI API version is used, you might see the "InvalidImageRegistryCredentialType" error:

    ```azurecli
    $ az deployment group create —g <resourcegroupname> --template—file containergroup_trusted.json 
    Deployment failed. Correlation ID: <Correlation ID>. { 
      "error": { 
        "code": "InvalidImageRegistryCredentialType", 
        "message": "Identity in 'imageRegistryCredentials' of container group 'acrtestcontainergroup' is not supported." 
      } 
    } 
    ```

    To resolve this issue, use ACI API version 2021-07-01 or later.

2. Check if you're not violating any ACI limitations.

    Limitations include:

    - Virtual network injected container groups.
    - Windows Server 2016 container groups.
    - Attempting to resolve ACR's private DNS zone.

3. Check if the container group definition is correctly formed.

    If the container group definition isn't correctly formed, you might see the following errors:

    - Error code: "AmbiguousImageResitryCredentialType"

        ```output
        Deployment failed. Correlation ID: <Correlation ID>. { 
        "error": { 
            "code": "AmbiguousImageResitryCredentialType", 
            "message": "The registry credential type in the 'imageRegistryCredentials' of container group 'acrtestcontainergroup' cannot be detected. Please set exactly one of username or identity" 
        } 
        } 
        ```
    - Error code: "InvalidImageRegistryIdentity"

        ```output
        Deployment failed. Correlation ID: <Correlation ID>. { 
        "error": { 
            "code": "InvalidImageRegistryIdentity", 
            "message": "The identity in the 'imageRegistryCredentials' of container group 'acrtestcontainergroup' not found in container group identity list." 
        } 
        } 
        ```
    - Error code: "InvalidRequestContent"

        ```outout
        Deployment failed. Correlation ID: <Correlation ID>. { 
        "error": { 
            "code": "InvalidRequestContent", 
            "message": "The request content was invalid and could not be deserialized: 'Required property 'server' not found in JSON. Path 'properties.imageRegistryCredentials[0]', line 1, position 586.'." 
        } 
        }
        ```

    To resolve this issue, you must provide the following properties in the ARM template:

    - The `server` and `identity` properties of [ImageRegistryCredential](/rest/api/container-instances/container-groups/create-or-update#imageregistrycredential)
    - The `type` and `userAssignedIdentity` properties of [ContainerGroupIdentity](/rest/api/container-instances/container-groups/create-or-update#containergroupidentity).

## Troubleshooting from the ACR side

1. Check if you have assigned the managed identity with the `AcrPull` role.

    If the `AcrPull` role isn't assigned, you might see the "InaccessibleImage" error:


    ```output
    Deployment failed. Correlation ID: <Correlation ID>. { 
      "error": { 
        "code": "InaccessibleImage", 
        "message": "The image 'myacr.azurecr.io/pythonworker:v1' in container group 'acrtestcontainergroup' is not accessible. Please check the image and registry credential." 
      } 
    } 
    ```

    To resolve this issue, grant the `AcrPull` role to the managed identity. For more information, refer to step 3 in this tutorial. 

2. Check if ACR has [trusted services](/azure/container-registry/allow-access-trusted-services) enabled.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
