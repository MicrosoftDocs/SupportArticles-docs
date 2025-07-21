---
title: Using Azure App Service Certificate with Azure Front Door
description: Provides detailed steps to use Azure App Service Certificate together with Azure Front Door.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 07/21/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: Connection issues with SSL or TLS
---

# Use Azure App Service Certificate with Azure Front Door

Microsoft Azure Front Door (Standard and Premium) is a modern global load balancer and application delivery network that supports custom TLS certificates through Azure Key Vault. This article discusses how to use an Azure App Service Certificate securely together with Microsoft Azure Front Door by using managed identities and Bring Your Own Certificate (BYOC) support. This integration enables you to deliver encrypted traffic that has automatic renewal, enterprise-grade performance, and global scale.

## Overview

Azure App Service Certificates provide a simple, integrated way to purchase, provision, and manage SSL/TLS certificates. These certificates are issued by trusted Certificate Authorities (such as DigiCert) and work together with App Services. They can also be extended to secure traffic that's routed through Azure Front Door.

To purchase a certificate, see [Buy and configure an App Service Certificate](https://learn.microsoft.com/azure/app-service/configure-ssl-app-service-certificate?tabs=portal#buy-and-configure-an-app-service-certificate).

> [!IMPORTANT]
> After you purchase a certificate, you must manually complete the **Store** step in the **Certificate Configuration** blade to import the certificate into Azure Key Vault. This step is required before the certificate can be used together with other Azure services.

### Step 1: Enable managed identity on Azure Front Door

A managed identity enables Azure Front Door to securely retrieve the certificate from Azure Key Vault:

1. Navigate to your Azure Front Door profile.
2. Under **Security**, select **Identity**, and then enable a managed identity:
   - **System-assigned** (Recommended): Tied to the Front Door
     lifecycle
   - **User-assigned** (Optional): For reuse across multiple services
3. Select **Save**.

For more information, see [Use managed identities to access Azure Key Vault certificates](https://learn.microsoft.com/azure/frontdoor/managed-identity).

### Step 2: Configure Key Vault Access for Front Door

Grant permission to Azure Front Door to access the certificate by using one of the following methods:

#### Method A: Azure RBAC (recommended)

1. Open **Key Vault** > **Access control (IAM)** > **+ Add** > **Add role assignment**.
2. Assign the **Key Vault Secrets User** role.
3. Select **Managed identity**, then select the system-assigned identity of Azure Front Door.
4. Select **Review + assign**.

    ```bash
        az role assignment create \
          --assignee-object-id <frontdoor-identity-object-id> \
          --role "Key Vault Secrets User" \
          --scope "/subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.KeyVault/vaults/<vault-name>"
    ```

To retrieve the identity object ID:

```bash
    az front-door show \
      --name <frontdoor-name> \
      --resource-group <rg> \
      --query identity.principalId -o tsv
```

> [!NOTE]
> Make sure that the Key Vault firewall allows trusted services or specific Front Door IP ranges.

#### Method B: Key Vault Access Policy

1. Navigate to your key vault > **Access policies**.
2. Select **+ Add Access Policy**.
3. Grant **Get** and **List** permissions for **Secrets** and **Certificates**.
4. Assign the policy to the managed identity for Azure Front Door.
5. Save the access policy.

> [!NOTE]
> This method is suitable for legacy scenarios or if RBAC isn't enabled.

### Step 3: Add certificate as a secret in Azure Front Door

Before you do this step, make sure that the App Service Certificate is successfully stored in Azure Key Vault through the App Service Certificate blade. For more information, see [Buy and configure an App Service Certificate](https://learn.microsoft.com/azure/app-service/configure-ssl-app-service-certificate?tabs=portal#buy-and-configure-an-app-service-certificate).

To add the certificate:

1. Go to your Azure Front Door (Standard/Premium) profile.
2. Under **Security**, select **Secrets** > **+ Add**.
3. Select your key vault, and then select the stored App Service Certificate.
4. Select the version. (Use `Latest` to enable automatic certificate rotation.)
5. Select **Add**.

> [!NOTE]
> Azure Front Door supports automatic certificate renewal when you reference the `Latest` version. Updates in Key Vault are reflected in Front Door within 72 hours. For more information, see [Renew customer-managed TLS certificates](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#renew-customer-managed-tls-certificates).
> [!IMPORTANT]
> Certificates must be stored in a Key Vault within the same subscription and must include a complete certificate chain that uses supported algorithms. For more information, see [Use your own certificate with Azure Front Door](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#use-your-own-certificate).

### Step 4: Configure a custom domain with BYOC

1. In your Front Door profile, go to **Domains** > **+ Add**.
2. Provide the domain details:
    - **Custom domain**: for example, `www.contoso.com`
    - **DNS zone**: Choose Azure DNS, if applicable.
    - **DNS management**: Azure-managed (recommended) or external
3. Verify domain ownership:
    - Use **TXT record** if you use custom DNS provider
4. Under **HTTPS Configuration**:
    - **Certificate type**: `Bring Your Own Certificate (BYOC)`
    - **Secret**: Select the secret that you added in Step 3 (for example, `certname-latest`).
    - **TLS policy**: Select a supported policy (for example, `TLS 1.2_2023`)
5. Select **Add** to finish the setup.

After verification is made, Front Door serves traffic securely by using the certificate from Azure Key Vault. For more information, see [Add a custom domain in Azure Front Door](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-add-custom-domain).

## Summary

| Task | Tool | Notes
| --- | --- | ---
| Enable identity | Azure portal or CLI | System-assigned identity is recommended
| Grant access | IAM Role or Access Policy | Use `Key Vault Secrets User` or equivalent
| Add secret | Azure portal | Reference `-latest` to enable autorotation
| Bind domain | Azure portal | Validate domain and configure HTTPS

## References

- [Configure HTTPS custom domain (Front Door)](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell)
- [Add custom domain in Front Door](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-add-custom-domain)
- [Azure Front Door managed identity access](https://learn.microsoft.com/azure/frontdoor/managed-identity)
- [Buy and configure an App Service Certificate](https://learn.microsoft.com/azure/app-service/configure-ssl-app-service-certificate?tabs=portal)
