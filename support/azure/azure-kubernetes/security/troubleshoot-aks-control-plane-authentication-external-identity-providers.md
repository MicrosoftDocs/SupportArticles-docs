---
title: Troubleshoot AKS control plane authentication using external identity providers
description: Helps you troubleshoot authentication issues when accessing the Azure Kubernetes Service control plane by using external identity providers
ms.reviewer: shasb
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.date: 11/09/2025
ms.custom: sap:Identity and Security Management
zone_pivot_groups: aks-external-identity-provider
#customer intent: As a DevOps Engineer or cluster administrator, I want to troubleshoot authentication issues with external identity providers so that I can successfully authenticate to the AKS control plane.
---
# Troubleshoot AKS control plane authentication using external identity providers

<!--
::: zone-pivot-group zone="aks-external-identity-provider"
:::
-->

This article helps you troubleshoot authentication issues when you access the Azure Kubernetes Service (AKS) control plane by using external identity providers.

## Prerequisites

- Azure CLI version 2.61.0 or later. To determine the version, run `az --version`. If you have to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).
- A tool to connect to the Kubernetes cluster, such as the `kubectl` tool. To install `kubectl` by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The JSON Web Token (JWT) authenticator configuration file that's used for your AKS cluster.
- Access to [jwt.ms](https://jwt.ms) or a similar JWT token decoder tool for debugging tokens.

## Troubleshooting checklist

### Step 1: Verify identity provider configuration

Make sure that your identity provider is correctly configured and accessible. Follow these steps:

::: zone pivot="github"

1. Verify that your GitHub repository has **Actions** enabled.
2. Verify that the OpenID Connect (OIDC) provider settings are correctly configured in your workflow.
3. Make sure that the audience claim in your workflow matches the authenticator configuration.

::: zone-end

::: zone pivot="google-identity"

Verify that the OAuth 2.0 client ID and client secret are correct.

::: zone-end

::: zone pivot="keycloak-self-hosted"

1. Verify that the OpenID Connect (OIDC) provider settings are correctly configured.
2. Make sure that the audience claim matches the authenticator configuration.

::: zone-end

### Step 2: Validate the issuer URL

The issuer URL must be accessible from the AKS cluster nodes. Follow these steps.

1. Verify Domain Name System (DNS) resolution for the issuer URL:

   ::: zone pivot="github"
   
   ```bash
   nslookup token.actions.githubusercontent.com
   ```
   
   ::: zone-end
   
   ::: zone pivot="google-identity"
   
   ```bash
   nslookup accounts.google.com
   ```
   
   ::: zone-end

   ::: zone pivot="keycloak-self-hosted"
   
   ```bash
   nslookup <FQDN OF KEYCLOAK INSTANCE>
   ```
   
   ::: zone-end

2. Test network connectivity from a cluster node:

   ::: zone pivot="github"
   
   ```bash
   curl -v https://token.actions.githubusercontent.com/.well-known/openid-configuration
   ```
   
   ::: zone-end
   
   ::: zone pivot="google-identity"
   
   ```bash
   curl -v https://accounts.google.com/.well-known/openid-configuration
   ```
   
   ::: zone-end

   ::: zone pivot="keycloak-self-hosted"
   
   ```bash
   curl -v https://<FQDN OF KEYCLOAK INSTANCE>/realms/<NAME OF REALM>/.well-known/openid-configuration
   ```
   
   ::: zone-end

3. Verify that firewall rules and network security groups allow outbound HTTPS traffic to the identity provider.

### Step 3: Inspect the JWT authenticator configuration

Review your JWT authenticator configuration for common issues. Follow these steps:

1. Verify that the issuer URL exactly matches the `iss` claim in your tokens.
2. Verify that the audience claim in the configuration matches the `aud` claim in your tokens.
3. Make sure that Common Expression Language (CEL) expressions in claim mappings are syntactically correct.
4. Verify that all username and group mappings include the `aks:jwt:` prefix.

Example configuration:

::: zone pivot="github"

```json
{
  "issuer": {
      "url": "https://token.actions.githubusercontent.com",
      "audiences": [
          "my-api"
      ]
  },
  "claimValidationRules": [
      {
          "expression": "has(claims.sub)",
          "message": "must have sub claim"
      }
  ],
  "claimMappings": {
      "username": {
          "expression": "'aks:jwt:github:' + claims.sub"
      }
  },
  "userValidationRules": [
      {
          "expression": "has(user.username)",
          "message": "must have username"
      },
      {
          "expression": "!user.username.startsWith('aks:jwt:github:system')",
          "message": "username must not start with 'aks:jwt:github:system'"
      }
  ]
}
```

::: zone-end

::: zone pivot="google-identity"

```json
{
    "issuer": {
        "url": "https://accounts.google.com",
        "audiences": [
            "your-client-id.apps.googleusercontent.com"
        ]
    },
    "claimValidationRules": [
        {
            "expression": "has(claims.sub)",
            "message": "must have sub claim"
        }
    ],
    "claimMappings": {
        "username": {
            "expression": "'aks:jwt:google:' + claims.sub"
        },
        "groups": {
            "expression": "has(claims.groups) ? claims.groups.split(',').map(g, 'aks:jwt:' + g) : []"
        }
    },
    "userValidationRules": [
        {
            "expression": "has(user.username)",
            "message": "must have username"
        },
        {
            "expression": "!user.username.startsWith('aks:jwt:google:system')",
            "message": "username must not start with 'aks:jwt:google:system'"
        }
    ]
}
```

::: zone-end

::: zone pivot="keycloak-self-hosted"

```json
{
    "issuer": {
        "url": "https://<FQDN OF KEYCLOAK INSTANCE>/realms/<NAME OF REALM>",
        "audiences": [
            "<NAME OF CLIENT IN KEYCLOAK REALM>"
        ]
    },
    "claimValidationRules": [
        {
            "expression": "has(claims.sub)",
            "message": "must have sub claim"
        }
    ],
    "claimMappings": {
        "username": {
            "expression": "'aks:jwt:keycloak:' + claims.sub"
        },
        "groups": {
            "expression": "has(claims.groups) ? claims.groups.split(',').map(g, 'aks:jwt:keycloak:' + g) : []"
        }
    },
    "userValidationRules": [
        {
            "expression": "has(user.username)",
            "message": "must have username"
        },
        {
            "expression": "!user.username.startsWith('aks:jwt:keycloak:system')",
            "message": "username must not start with 'aks:jwt:keycloak:system'"
        }
    ]
}
```

::: zone-end

### Step 4: Decode and verify JWT tokens

Verify claims, and obtain and inspect the JWT token. Follow these steps:

::: zone pivot="github"

1. For GitHub Actions OIDC, tokens are typically obtained within a workflow. Obtain a token:

   ```bash
   # This is typically done within a GitHub Actions workflow
   # where ACTIONS_ID_TOKEN_REQUEST_TOKEN and ACTIONS_ID_TOKEN_REQUEST_URL are available
   curl -H "Authorization: bearer $ACTIONS_ID_TOKEN_REQUEST_TOKEN" \
     "$ACTIONS_ID_TOKEN_REQUEST_URL&audience=my-api"
   ```

::: zone-end

::: zone pivot="google-identity"

1. Get a token from Google Identity:

   ```bash
   kubectl oidc-login get-token \
     --oidc-issuer-url=https://accounts.google.com \
     --oidc-client-id=your-client-id \
     --oidc-client-secret=your-client-secret
   ```

::: zone-end

::: zone pivot="keycloak-self-hosted"

1. Get a token from Keycloak:

   ```bash
   kubectl oidc-login get-token \
     --oidc-issuer-url="https://<FQDN OF KEYCLOAK INSTANCE>/realms/<NAME OF REALM>" \
     --oidc-client-id="<NAME OF CLIENT IN KEYCLOAK REALM>" \
     --oidc-client-secret="<SECRET OF REFERENCED CLIENT IN KEYCLOAK REALM>"
   ```

::: zone-end

2. Decode the token at [jwt.ms][jwt-ms], and verify the following items:
   
   - The `iss` claim matches your issuer URL exactly.
   - The `aud` claim matches your configured audience.
   - The token isn't expired (`exp` claim).
   - Required claims for username and groups are present.
   - Claims match the format that's expected by your CEL expressions.

### Step 5: Check AKS API server logs

Review the AKS API server logs for authentication errors. Follow these steps:

1. Use diagnostic settings to [enable resource logs][aks-resource-logs] for your AKS cluster. Choose **Kubernetes API Server** when creating the diagnostic setting.
2. Check logs in Azure Monitor or Azure Log Analytics for authentication failures.
3. Look for error messages related to JWT validation or claim mapping.

## Common issues and solutions

### Issue 1: 401 Unauthorized errors

**Cause 1: Token audience mismatch**

The audience claim in the token doesn't match the configured audience in the JWT authenticator.

**Solution: Update the authenticator configuration**

Verify the audience claim in your token, and update the JWT authenticator configuration.

```azurecli-interactive
az aks jwtauthenticator update \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name external-auth \
    --config-file updated-jwt-config.json
```

**Cause 2: Incorrect issuer URL**

The issuer URL in the configuration doesn't exactly match the `iss` claim in the token.

**Solution: Correct the issuer URL**

Update the issuer URL in your JWT authenticator configuration file to match the exact issuer in your tokens, including the protocol (https://) and any trailing slashes.

**Cause 3: Identity provider misconfiguration**

The OAuth client or OIDC provider settings are incorrect.

**Solution: Verify identity provider settings**

::: zone pivot="github"

1. Verify that the workflow file includes the correct `permissions` for `id-token: write`.
2. Make sure that the `audience` parameter matches your authenticator configuration.

::: zone-end

::: zone pivot="google-identity"

1. Go to the [Google Cloud Console](https://console.cloud.google.com).
2. Navigate to **APIs & Services** > **Credentials**.
3. Verify the OAuth 2.0 client ID and secrets.

::: zone-end


### Issue 2: Token validation failures

**Cause: Invalid CEL expressions in claim mappings**

CEL expressions might have syntax errors or return unexpected data types.

**Solution: Verify CEL expressions**

1. Review the CEL expressions in your configuration.
2. Test expressions by using a CEL evaluator to make sure that they return strings for username and arrays of strings for groups.
3. Update the configuration to have the corrected expressions.

The following code is an example of a valid CEL expression for extracting groups:
   
   ```json
   {
     "groups": {
       "expression": "claims.groups.filter(g, g.startsWith('team-'))",
       "prefix": "aks:jwt:"
     }
   }
   ```

### Issue 3: Network connectivity issues

**Cause: Cluster nodes cannot reach the identity provider**

Issues that affect network security groups, firewalls, certificate or the DNS prevent the cluster from accessing the identity provider.

**Solution 1: Verify DNS resolution**

1. Connect to a cluster node by using `kubectl debug`:

   ```bash
   kubectl debug node/<node-name> -it --image=mcr.microsoft.com/azurelinux/base/core:3.0
   ```

2. Test DNS resolution:

   ::: zone pivot="github"
   
   ```bash
   nslookup token.actions.githubusercontent.com
   ```
   
   ::: zone-end
   
   ::: zone pivot="google-identity"
   
   ```bash
   nslookup accounts.google.com
   ```
   
   ::: zone-end

**Solution 2: Update network security rules**

1. Review network security group rules that are associated with your AKS cluster.
2. Make sure that outbound HTTPS (port 443) traffic is allowed to your identity provider's domain.
3. If you use Azure Firewall, add application rules for the identity provider URLs.

::: zone pivot="keycloak-self-hosted"

**Solution 3: Check and replace certificate**

1. Check Azure Log Analytics Workspace for error message `502 Bad Gateway`

    ```KQL
    AKSControlPlane
    | where Category == "kube-apiserver"
    | where Level == "ERROR"
    ```

    Although the error message highlights potential network issues, it could also be certificate related. 

    ```
    oidc authenticator: initializing plugin: 502 Bad Gateway: Request to 'https://<FQDN OF KEYCLOAK INSTANCE>/realms/<NAME OF REALM>/.well-known/openid-configuration' cannot be made. Please make sure the OIDC identity provider is publicly accessible, and it is reachable from your cluster node(s).
    ```

2. Make sure that the correct and valid certificate has been uploaded and the entire certificate trust chain (from certificate up to root, including intermediate certificates) is known and trusted.
3. Restart the web service to ensure that the certificate is loaded.

::: zone-end

### Issue 4: Missing `aks:jwt:` prefix in username or groups

**Cause: Claim mappings don't include the required prefix**

To prevent conflicts with other authentication methods, all usernames and groups must be prefixed by using `aks:jwt:`.

**Solution: Add the required prefix**

Update your JWT authenticator configuration to include the `aks:jwt:` prefix. For example:

::: zone pivot="github"

For GitHub Actions OIDC, create a file that's named `jwt-config.json` that has the following configuration:

```json
{
  "issuer": {
      "url": "https://token.actions.githubusercontent.com",
      "audiences": [
          "my-api"
      ]
  },
  "claimValidationRules": [
      {
          "expression": "has(claims.sub)",
          "message": "must have sub claim"
      }
  ],
  "claimMappings": {
      "username": {
          "expression": "'aks:jwt:github:' + claims.sub"
      }
  },
  "userValidationRules": [
      {
          "expression": "has(user.username)",
          "message": "must have username"
      },
      {
          "expression": "!user.username.startsWith('aks:jwt:github:system')",
          "message": "username must not start with 'aks:jwt:github:system'"
      }
  ]
}
```

::: zone-end

::: zone pivot="google-identity"

### Google OAuth 2.0 Configuration

1. Create a file that's named `jwt-config.json` that has the following configuration:

```json
{
    "issuer": {
        "url": "https://accounts.google.com",
        "audiences": [
            "your-client-id.apps.googleusercontent.com"
        ]
    },
    "claimValidationRules": [
        {
            "expression": "has(claims.sub)",
            "message": "must have sub claim"
        }
    ],
    "claimMappings": {
        "username": {
            "expression": "'aks:jwt:google:' + claims.sub"
        },
        "groups": {
            "expression": "has(claims.groups) ? claims.groups.split(',').map(g, 'aks:jwt:' + g) : []"
        }
    },
    "userValidationRules": [
        {
            "expression": "has(user.username)",
            "message": "must have username"
        },
        {
            "expression": "!user.username.startsWith('aks:jwt:google:system')",
            "message": "username must not start with 'aks:jwt:google:system'"
        }
    ]
}
```

::: zone-end

::: zone pivot="keycloak-self-hosted"

### Keycloak OIDC Configuration

1. Create a file that's named `jwt-config.json` that has the following configuration:

```json
{
    "issuer": {
        "url": "https://<FQDN OF KEYCLOAK INSTANCE>/realms/<NAME OF REALM>",
        "audiences": [
            "<NAME OF CLIENT IN KEYCLOAK REALM>"
        ]
    },
    "claimValidationRules": [
        {
            "expression": "has(claims.sub)",
            "message": "must have sub claim"
        }
    ],
    "claimMappings": {
        "username": {
            "expression": "'aks:jwt:keycloak:' + claims.sub"
        },
        "groups": {
            "expression": "has(claims.groups) ? claims.groups.split(',').map(g, 'aks:jwt:keycloak:' + g) : []"
        }
    },
    "userValidationRules": [
        {
            "expression": "has(user.username)",
            "message": "must have username"
        },
        {
            "expression": "!user.username.startsWith('aks:jwt:keycloak:system')",
            "message": "username must not start with 'aks:jwt:keycloak:system'"
        }
    ]
}
```

::: zone-end

Update the authenticator:

```azurecli-interactive
az aks jwtauthenticator update \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name external-auth \
    --config-file updated-jwt-config.json
```

## Advanced troubleshooting

### Enable verbose logging

To get more detailed information about authentication failures:

1. Enable diagnostic settings on your AKS cluster.
2. Configure the Log Analytics workspace to capture `Kubernetes API Server` logs.
3. Check API server logs for any JWT authenticator-related issue such as incorrect claim mappings that cause validation errors.

### Resources

- [jwt-ms token decoder tool](https://jwt.ms)
- [Supported resource logs for Microsoft.ContainerService/managedClusters](/azure/aks/monitor-aks-reference#supported-resource-logs-for-microsoftcontainerservicemanagedclusters)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
