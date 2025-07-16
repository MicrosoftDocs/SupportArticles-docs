---
title: Using Azure App Service Certificate with Application Gateway:Detailed Guide
description: Get detailed steps on how to use Azure App Service certificate with application gateway.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: Connection issues with SSL or TLS
---

# Using Azure App Service Certificate with Application Gateway: Detailed Guide

Azure provides various tools and services to secure your web
applications with SSL/TLS certificates. One such offering is the **Azure
App Service Certificate**, which is tightly integrated with Azure App
Services. However, many organizations use **Azure Application Gateway**
as a reverse proxy, load balancer, and Web Application Firewall (WAF),
and naturally want to use the same certificate across services. This
blog provides a comprehensive guide on how to use App Service
Certificates in Application Gateway, outlining the usage steps,
restrictions, and best practices.

## What is an App Service Certificate?

Azure App Service Certificate is a first-party SSL certificate issued by
DigiCert or GoDaddy and designed for use with Azure App Services. It is
stored securely in an Azure Key Vault and supports auto-renewal when
integrated properly.

Key Characteristics:

- Domain-validated SSL certificate
- Designed primarily for Azure App Services
- Stored in Key Vault for secure usage
- Auto-renewal supported when linked properly

However, **App Service Certificates are not directly usable in
Application Gateway** without additional steps.

## Can You Use App Service Certificate in Application Gateway?

Yes, but not directly. Azure Application Gateway requires a
certificate in **PFX format (with a private key)** to configure HTTPS
listeners. App Service Certificates are not exposed as downloadable PFXs
by default, so you need to follow specific steps to extract and
configure them.

## How to Use App Service Certificate in Application Gateway

### Option 1: Manual Export and Upload

1. **Purchase and Configure the Certificate**

    - Buy and verify an App Service Certificate via Azure App Service.

2. **Import into Key Vault**

    - Navigate to the App Service Certificate resource.
    - Use the **Key Vault** blade to store the certificate in a Key Vault
      of your choice.

3. **Export as PFX from Key Vault**

    - Use Azure PowerShell or Azure CLI to download the certificate as a
      `.pfx` file with a private key.

    - Example using Azure CLI:

    ```bash
        az keyvault secret download \
        --vault-name `YourKeyVaultName` \
        --name `CertificateName` \
        --file cert.pfx \
        --encoding base64
    ```

4. **Upload to Application Gateway**

    - Go to Application Gateway \> Listeners \> + Add Listener.
    - Choose HTTPS, upload the `.pfx` file, and enter the password.

5. **Associate with a Rule**

    - Create a routing rule and link it to the HTTPS listener. For
      detailed steps, refer to the official documentation: [Create a
      routing rule in Application
      Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-request-routing-rules)

### Option 2: Use Key Vault Reference (Recommended)

1. **Store App Service Certificate in Key Vault** (same as above).

2. **Enable Managed Identity for Application Gateway**

    - Enable user-assigned or system-assigned managed identity.

3. **Grant Access to Key Vault**

    - In the Key Vault, go to Access Policies.
    - Add policy for Application Gateway identity with `get`, `list`,
      and `secret management` permissions.

4. **Reference Certificate from Key Vault**

    - In Application Gateway \> Listeners \> + Add Listener
    - Choose HTTPS and select **Key Vault certificate**.

> [!NOTE]
> As of writing, Key Vault integration only supports certificates with the private key in `.pfx` format.

## Limitations and Considerations

1. **Direct Use Not Supported:**

    - You cannot bind an App Service Certificate to Application Gateway directly like you can for App Services.

2. **Export Required for Manual Use:**

    - You must extract the `.pfx` format from Key Vault before using it in
    Application Gateway (if not using Key Vault reference).

3. **Auto-Renewal Challenges:**

    - App Service Certificates support auto-renewal only for App Services.
    - When used in Application Gateway, auto-renewal **does not
  automatically propagate**.
    - You must **manually update the certificate** in Application Gateway
  after renewal.
    - Recommended to use **Azure Automation or Logic App** to automate this
  update process. Refer to [Renew certificates in Application
  Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/renew-certificates).

4. **Certificate Format Restrictions:**

    - Only `.pfx` files are accepted by Application Gateway.
    - `.cer` or `.pem` files will be rejected.
    - Self-signed certificates are supported but must be uploaded as PFX.
    - See [Self-signed certificates for Application Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/self-signed-certificates).

## Best Practices

- Use Key Vault-based integration for better security and easier
  management.
- Automate certificate renewal using scripts or Azure Automation.
- Regularly audit access policies in Key Vault.
- Keep backup copies of your exported `.pfx` files securely.

## Summary

| Feature | App Service | Application Gateway
| --- | --- | ---
| Certificate Format | Managed by platform | Requires `.pfx`
| Auto-Renewal | Supported | Manual (requires automation)
| Key Vault Integration | Built-in | Supported (requires setup)
| Direct Use of App Service Certificate | ✅ App Service only | ❌ Not supported

## Useful Links

- [Renew certificates in Application
  Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/renew-certificates)
- [SSL certificates overview - Application
  Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/ssl-overview)
- [Use self-signed certificates in Application
  Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/self-signed-certificates)
- [Configure App Service
  Certificate](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate?tabs=portal)
- [Create a routing rule in Application
  Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-request-routing-rules)

Using App Service Certificates in Application Gateway is certainly
possible and secure - with the right steps. By understanding the
limitations and using Key Vault effectively, you can build a robust
certificate management workflow across both App Services and Application
Gateway.
