---
title: Using Azure App Service Certificate with Application Gateway: Detailed Guide
description: Provides detailed steps to use Azure App Service certificate together with Application Gateway.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: Connection issues with SSL or TLS
---

# Use Azure App Service Certificate with Application Gateway

Azure provides various tools and services to secure your web applications by using SSL/TLS certificates. One such offering, the **Azure App Service Certificate**, is tightly integrated with Azure App Services. However, many organizations use **Azure Application Gateway** as a reverse proxy, load balancer, and Web Application Firewall (WAF). Understandably, such organizations want to use the same certificate across all services. 

This article provides a comprehensive guide for using App Service Certificates in Application Gateway, including usage steps, restrictions, and best practices.

## About App Service Certificate

Azure App Service Certificate is a first-party SSL certificate that's issued by DigiCert or GoDaddy and is designed for use together with Azure App Services. The certificate is stored securely in an Azure key vault and supports auto-renewal if it's integrated correctly.

Key Characteristics:

- Domain-validated SSL certificate
- Designed primarily for Azure App Services
- Stored in a key vault for secure usage
- Auto-renewal supported if linked correctly

However, App Service Certificates are not directly usable in Application Gateway unless you take additional steps.

## How to use App Service Certificate in Application Gateway

You can use App Service Certificate in Azure Application Gateway, but not directly. Application Gateway requires a certificate in `.pfx` format (having a private key) to configure HTTPS listeners. App Service Certificates are not exposed as downloadable PFXs by default. Therefore, you have to follow specific steps to extract and configure them.

## How to use App Service Certificate in Application Gateway

### Option 1: Manual export and upload

1. **Purchase and configure the certificate**: Buy and verify an App Service Certificate through Azure App Service.

2. **Import into Key Vault**: Navigate to the App Service Certificate resource. Then, use the **Key Vault** blade to store the certificate in a key vault of your choice.

3. **Export as .pfx from Key Vault**: Use Azure PowerShell or Azure CLI to download the certificate as a `.pfx` file that has a private key.

    - Example using Azure CLI:

    ```bash
        az keyvault secret download \
        --vault-name `YourKeyVaultName` \
        --name `CertificateName` \
        --file cert.pfx \
        --encoding base64
    ```

4. **Upload to Application Gateway**: Go to Application Gateway \> Listeners \> + Add Listener. Select **HTTPS**, upload the `.pfx` file, and then enter the password.

5. **Associate with a rule**: Create a routing rule, and link it to the HTTPS listener. For detailed steps, see [Create a routing rule in Application Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-request-routing-rules)

### Option 2: Use Key Vault Reference (recommended)

1. **Store App Service Certificate in Key Vault** (same as above).

2. **Enable Managed Identity for Application Gateway**: Enable user-assigned or system-assigned managed identity.

3. **Grant Access to Key Vault**: In the key vault, go to **Access Policies**, and add a policy for Application Gateway identity that has `get`, `list`,
      and `secret management` permissions.

4. **Reference Certificate from Key Vault**: Go to **Application Gateway** \> **Listeners** \> **+ Add Listener**, select **HTTPS**, and then select **Key Vault certificate**.

> [!NOTE]
> Currently, Key Vault integration supports only certificates that have the private key in `.pfx` format.

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
