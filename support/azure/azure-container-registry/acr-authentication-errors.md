---
title: Troubleshoot Azure Container Registry authentication issues
description: Helps resolve the most common authentication errors that occur when you pull images from an Azure container registry.
ms.date: 08/19/2024
ms.reviewer: chiragpa, v-rekhanain, v-weizhu
ms.service: azure-container-registry
ms.custom: sap:Authenticate to registry
---
# Troubleshoot Azure Container Registry authentication issues

Azure Container Registry (ACR) is a private registry service. To perform operations such as push or pull (except the [anonymous pull](/azure/container-registry/anonymous-pull-access) operation), you have to authenticate against the ACR first.

This article helps you troubleshoot ACR authentication issues and provides solutions to the most common errors that occur when you pull images from a container registry.

## Initial troubleshooting

1. Identify the [authentication option](/azure/container-registry/container-registry-authentication#authentication-options) you're using. Once you choose one, reproduce the authentication issue to obtain the error.

1. Start troubleshooting by checking [the health of your Azure container registry](/azure/container-registry/container-registry-check-health).

    To check the container registry's health, run the following command:
    
    ```azurecli
    az acr check-health --name <acr-name> --ignore-errors --yes
    ```

    If a problem is detected, the command output provides an error code and description. For more information about the error code and possible solutions, see the [health check error reference](/azure/container-registry/container-registry-health-error-reference).

    > [!NOTE]
    > If you get errors related to Helm or Notary, it doesn't mean that you have an issue affecting your container registry or device. It only indicates that Helm or Notary isn't installed or that the Azure CLI isn't compatible with the currently installed version of Helm or Notary.

## Error 1: "DOCKER_COMMAND_ERROR Please verify if Docker client is installed and running"

Here's an example of the error details:

```output
You may want to use 'az acr login -n <acr-name> --expose-token' to get an access token, which does not require Docker to be installed.
<date and time> An error occurred: DOCKER_COMMAND_ERROR
Please verify if Docker client is installed and running.
```

### Solution 1: Make sure Docker is installed

The `az acr login` command calls the `docker login` command and uses the Microsoft Entra access token to authenticate against the ACR. It requires the Docker client and Docker daemon to be installed on the machine where you execute the command. To install Docker, see [Install Docker Engine](https://docs.docker.com/engine/install/).

### Solution 2: Use the "az acr login" command with the "--expose-token" parameter

When the Docker daemon doesn't run in your environment, if you need to authenticate with ACR, use [the az acr login command with the --expose-token parameter](/azure/container-registry/container-registry-authentication?tabs=azure-cli#az-acr-login-with---expose-token). This command is helpful when you need to run scripts that don't require the Docker daemon but only the Docker CLI (for example, when using the Azure Cloud Shell).

## Error 2: "This command requires running the docker daemon, which is not supported in Azure Cloud Shell"

Here's an example of the error details:

```output
This command requires running the docker daemon, which is not supported in Azure Cloud Shell. You may want to use 'az acr login -n <acr-name> --expose-token' to get an access token, which does not require Docker to be installed.
```

### Solution 1: Run the "az acr login -n \<acr-name>" command in another environment

The `az acr login -n <acr-name>` command requires the Docker client and Docker daemon to run. The Azure Cloud Shell provides only the Docker client. To resolve this error, run the `az acr login -n <acr-name>` command in an environment where the Docker daemon is installed.

### Solution 2: Use the "az acr login" command with the "--expose-token" parameter

The `az acr login -n <acr-name>` command requires the Docker client and Docker daemon to run. The Azure Cloud Shell provides only the Docker client. However, [the `az acr login` command with the `--expose-token` parameter](/azure/container-registry/container-registry-authentication?tabs=azure-cli#az-acr-login-with---expose-token) works for environments without the Docker daemon, like the Azure Cloud Shell.

## Error 3: "Unauthorized: authentication required"

Here's an example of the error details:

```output
Error response from daemon: Get "https://<acr-name>.azurecr.io/v2/": unauthorized: {"errors":[{"code":"UNAUTHORIZED","message":"authentication required, visit https://aka.ms/acr/authorization for more information."}]}
```

The error indicates authentication failed when accessing the ACR. This error can occur when running the `az acr login` or `docker login` command with an incorrect username and/or password, or expired credentials (when using a service principal, a token with a scope map, or an admin user).

### Solution: Use the correct/valid username and password

- If you're using an admin user to authenticate, check the credential in the **Access keys** blade and if they're the ones you used in the `docker login` or `az acr login` command.

     :::image type="content" source="media/acr-authentication-errors/access-keys-blade.png" alt-text="Screenshot that shows the ACR 'Access keys' blade.":::
 
    > [!NOTE]
    > A password that was used before might have been regenerated.

- If you're using a token associated with a scope map, check the credentials used. Once you generate a password for the token, you have to retrieve it and store the credentials safely because the password won't be displayed anymore after you close the screen. See the message in the following screenshot:

    :::image type="content" source="media/acr-authentication-errors/store-your-credentials-safely-after-generation.png" alt-text="Screenshot that shows the 'store your credentials safely after generation' message." lightbox="media/acr-authentication-errors/store-your-credentials-safely-after-generation.png":::
 
    If you're unsure of the password you used, consider [regenerating](/azure/container-registry/container-registry-repository-scoped-permissions#regenerate-token-passwords) it.

- If you're using a token associated with a scope map, an expiration date can be set for the password. To view the expiration date, you can run the Azure CLI commands described in [Show token details](/azure/container-registry/container-registry-repository-scoped-permissions#show-token-details), or open the token in the Azure portal and check the **Expiration date** as per the following screenshot:

    :::image type="content" source="media/acr-authentication-errors/token-expiration-data.png" alt-text="Screenshot that shows the 'Expiration date' column." lightbox="media/acr-authentication-errors/token-expiration-data.png":::
 
- If you're using a service principal, make sure it has the specific permissions to authenticate with the ACR. To find the specific permissions and available built-in roles, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles).

- If you're using a service principal, check the credential used. Once you generate a secret, you have to retrieve it and store the credentials safely because the password won't be displayed anymore after you close the screen. See the message in the following screenshot:

    :::image type="content" source="media/acr-authentication-errors/save-secret-when-created-before-leaving-page.png" alt-text="Screenshot that shows the 'save the secret when created before leaving the page' message." lightbox="media/acr-authentication-errors/save-secret-when-created-before-leaving-page.png":::
 
    If you're unsure of the secret value you used, consider [creating a new secret](/entra/identity-platform/quickstart-register-app#add-credentials).

- If you're using a service principal, make sure the secret isn't expired.

    You can check the secret validity by running the [az ad app credential list](/cli/azure/ad/app/credential#az-ad-app-credential-list) command:

    ```azurecli
    az ad app credential list --id "$SP_ID" --query "[].endDateTime" -o tsv
    ```

    Or, you can check the secret validity by verifying the **Expires** column in the Azure portal:

    :::image type="content" source="media/acr-authentication-errors/acr-secret-expires-value.png" alt-text="Screenshot that shows the ACR  'Expires' column.":::
 
    If the secret is expired, you can consider [creating a new secret](/entra/identity-platform/quickstart-register-app#add-credentials).

## Error 4: "Unable to get admin user credentials"

Here's an example of the error details:

```output
Unable to get AAD authorization tokens with message: <date> <time> An error occurred: CONNECTIVITY_REFRESH_TOKEN_ERROR
Access to registry '<acr-name>.azurecr.io' was denied. Response code: 401. Please try running 'az login' again to refresh permissions.
Unable to get admin user credentials with message: The resource with name '<acr-name>' and type 'Microsoft.ContainerRegistry/registries' could not be found in subscription '<subscription-name> (<subscription-id>)'.
```

### Solution: Make sure the identity used has the specific permissions

Make sure the identity (such as a user or a managed identity) used to authenticate has the specific permissions. To find the specific permissions and available built-in roles, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles).

## Error 5: "Client with IP \<ip-address> is not allowed access"

Here's an example of the error details:

```output
Unable to get AAD authorization tokens with message: <date> <time> An error occurred: CONNECTIVITY_REFRESH_TOKEN_ERROR
Access to registry '<acr-name>.azurecr.io' was denied. Response code: 403. Please try running 'az login' again to refresh permissions.
Error response from daemon: Get "https://<acr-name>.azurecr.io/v2/": denied: {"errors":[{"code":"DENIED","message":"client with IP \u0027<ip-address>\u0027 is not allowed access. Refer https://aka.ms/acr/firewall to grant access."}]}
```

### Solution: Make sure the device you're trying to authenticate has connectivity with the ACR

ACR has a built-in firewall, which is a mechanism to restrict public access. It can allow full access, allow access only to specific networks, or fully disable public access. However, proper connectivity is required for successful authentication. Ensure your IP address is permitted to access and sign in to the registry. For more information about configuring public access, see [Configure public IP network rules](/azure/container-registry/container-registry-access-selected-networks).

Alternatively, you can consider [using Azure Private Link to connect privately to the Azure container registry](/azure/container-registry/container-registry-private-link).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
