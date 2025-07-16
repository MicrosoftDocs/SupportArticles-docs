---
title: Using Azure App Service Certificate with Azure Front Door:A Complete Guide
description: Get detailed steps on how to use Azure App Service certificate with Azure Front Door.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: Connection issues with SSL or TLS
---

# Using Azure App Service Certificate with Azure Front Door: A Complete Guide

Azure Front Door (Standard/Premium) is a modern global load balancer and
application delivery network that supports custom TLS certificates
through Azure Key Vault. This guide walks you through how to securely
use an **Azure App Service Certificate** with Azure Front Door by
leveraging managed identities and Bring Your Own Certificate (BYOC)
support.

## Overview

Azure App Service Certificates provide a simple, integrated way to
purchase, provision, and manage SSL/TLS certificates. These
certificates, issued by trusted Certificate Authorities (such as
DigiCert), are ideal for use with App Services and can also be extended
to secure traffic routed through Azure Front Door.

To purchase a certificate, you may refer to this article: [Buy and configure an App Service Certificate](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate?tabs=portal#buy-and-configure-an-app-service-certificate).

> [!WARNING]
> After purchasing, you must manually complete the **Store** step in
> the **Certificate Configuration** blade to import the certificate into
> Azure Key Vault. This step is required before the certificate can be
> used with other Azure services.

### Step 1: Enable Managed Identity on Azure Front Door

A managed identity allows Azure Front Door to securely retrieve the
certificate from Azure Key Vault.

1. Navigate to your Azure Front Door profile.
2. Under **Security**, select **Identity**.
3. Enable a managed identity:
   - **System-assigned** (Recommended): Tied to the Front Door
     lifecycle.
   - **User-assigned** (Optional): For reuse across multiple services.
4. Click **Save**.

For more details, you may refer to this article: [Use managed identities to access Azure Key Vault certificates](https://learn.microsoft.com/en-us/azure/frontdoor/managed-identity).

### Step 2: Configure Key Vault Access for Front Door

Grant Azure Front Door permission to access the certificate using one of
the following methods:

#### Option A: Azure RBAC (Recommended)

1. Go to your Key Vault → **Access control (IAM)** → **+ Add** → **Add
role assignment**.
2. Assign the **Key Vault Secrets User** role.
3. Choose **Managed identity** and select the system-assigned identity
of Azure Front Door.
4. Click **Review + assign**.

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
>Ensure Key Vault's firewall allows trusted services or specific
> Front Door IP ranges.

#### Option B: Key Vault Access Policy

1. Navigate to your Key Vault → **Access policies**.
2. Click **+ Add Access Policy**.
3. Grant **Get** and **List** permissions for **Secrets** and
**Certificates**.
4. Assign the policy to Azure Front Door's managed identity.
5. Save the access policy.

> [!NOTE]
> This is suitable for legacy scenarios or where RBAC is not enabled.

### Step 3: Add Certificate as a Secret in Azure Front Door

Before proceeding, ensure the App Service Certificate has been
successfully stored in Azure Key Vault via the App Service Certificate
blade.

For more details, you may refer to this article: [Buy and configure an App Service Certificate](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate?tabs=portal#buy-and-configure-an-app-service-certificate).

To add the certificate:

1. Go to your Azure Front Door (Standard/Premium) profile.
2. Under **Security**, select **Secrets** → **+ Add**.
3. Choose your Key Vault and select the stored App Service Certificate.
4. Select the version -- using `Latest` enables automatic certificate
rotation.
5. Click **Add**.

> [!NOTE]
> Azure Front Door supports automatic certificate renewal when
> referencing the `Latest` version. Updates in Key Vault will be
> reflected in Front Door within 72 hours.

For more details, you may refer to this article: [Renew customer-managed TLS certificates](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#renew-customer-managed-tls-certificates).

> [!WARNING]
> Certificates must be stored in a Key Vault within the same
> subscription and must include a complete certificate chain using
> supported algorithms.

For more details, you may refer to this article: [Use your own certificate with Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#use-your-own-certificate).

### Step 4: Configure a Custom Domain with BYOC

1. In your Front Door profile, go to **Domains** → **+ Add**.
2. Provide the domain details:
    - **Custom domain**: e.g., `www.contoso.com`.
    - **DNS zone**: Choose Azure DNS if applicable.
    - **DNS management**: Azure-managed (recommended) or external.
3. Validate domain ownership:
    - Use **TXT record** if using a custom DNS provider.
4. Under **HTTPS Configuration**:
    - **Certificate type**: `Bring Your Own Certificate (BYOC)`.
    - **Secret**: Select the secret added in Step 3 (e.g.,
      `certname-latest`).
    - **TLS policy**: Select a supported policy (e.g., `TLS 1.2_2023`)
5. Click **Add** to complete setup.

Once verified, Front Door will serve traffic securely using the
certificate from Azure Key Vault.

For more details, you may refer to this article: [Add a custom domain in Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-add-custom-domain).

## Summary Table

| Task | Tool | Notes
| --- | --- | ---
| Enable  Identity | Azure Portal or CLI | System-assigned identity recommended
| Grant Access | IAM Role or Access Policy | Use `Key Vault Secrets User` or equivalent
| Add Secret | Azure Portal | Reference `-latest` to enable auto-rotation
| Bind Domain | Azure Portal | Validate domain and configure HTTPS

## References

- [Configure HTTPS custom domain (Front
  Door)](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell)
- [Add custom domain in Front
  Door](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-add-custom-domain)
- [Azure Front Door managed identity
  access](https://learn.microsoft.com/en-us/azure/frontdoor/managed-identity)
- [Buy and configure an App Service
  Certificate](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate?tabs=portal)

By following these steps, you can securely integrate an **Azure App
Service Certificate** with **Azure Front Door** to deliver encrypted traffic
with automatic renewal, enterprise-grade performance, and global scale.
