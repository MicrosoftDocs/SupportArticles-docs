---
title: Use Azure App Service Certificate with Application Gateway:Detailed Guide
description: Provides detailed steps to use Azure App Service Certificate together with Application Gateway.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 07/21/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: Connection issues with SSL or TLS
---

# Use Azure App Service Certificate with Application Gateway

Microsoft Azure provides various tools and services to secure your web applications by using SSL/TLS certificates. One such offering, the **Azure App Service Certificate**, is tightly integrated with Azure App Services. However, many organizations use **Azure Application Gateway** as a reverse proxy, load balancer, and Web Application Firewall (WAF). Understandably, such organizations want to use the same certificate across all services.

This article provides a comprehensive guide for using App Service Certificates in Application Gateway, including usage steps, restrictions, and best practices. By understanding the limitations and using the Azure Key Vault service effectively, you can build a robust certificate management workflow across both App Services and Application Gateway.

## About App Service Certificate

Azure App Service Certificate is a first-party SSL certificate that's issued by DigiCert or GoDaddy and is designed for use together with Azure App Services. The certificate is stored securely in Azure Key Vault and supports autorenewal if it's integrated correctly.

Key Characteristics:

- Domain-validated SSL certificate
- Designed primarily for Azure App Services
- Stored in a key vault for secure usage
- Autorenewal supported if linked correctly

However, App Service Certificates aren't directly usable in Application Gateway unless you take additional steps.

## How to use App Service Certificate in Application Gateway

You can use App Service Certificate in Azure Application Gateway, but not directly. Application Gateway requires a certificate in `.pfx` format (having a private key) to configure HTTPS listeners. App Service Certificates aren't exposed as downloadable PFXs by default. Therefore, you have to follow specific steps to extract and configure them.

### Option 1: Manual export and upload

1. **Purchase and configure the certificate**: Buy and verify an App Service Certificate through Azure App Service.

2. **Import into Key Vault**: Navigate to the App Service Certificate resource. Then, use the **Key Vault** blade to store the certificate in a key vault of your choice.

3. **Export as .pfx from Key Vault**: Use Azure PowerShell or Azure CLI to download the certificate as a `.pfx` file that has a private key.

    - Example that uses Azure CLI:

    ```bash
        az keyvault secret download \
        --vault-name `YourKeyVaultName` \
        --name `CertificateName` \
        --file cert.pfx \
        --encoding base64
    ```

4. **Upload to Application Gateway**: Go to Application Gateway \> Listeners \> + Add Listener. Select **HTTPS**, upload the `.pfx` file, and then enter the password.

5. **Associate with a rule**: Create a routing rule, and link it to the HTTPS listener. For detailed steps, see [Create a routing rule in Application Gateway](/azure/application-gateway/configuration-request-routing-rules)

### Option 2: Use Key Vault reference (recommended)

1. **Store App Service Certificate in Key Vault**: Navigate to the App Service Certificate resource. Then, use the **Key Vault** blade to store the certificate in a key vault of your choice.

2. **Enable Managed Identity for Application Gateway**: Enable user-assigned or system-assigned managed identity.

3. **Grant Access to key vault**: In the key vault, go to **Access Policies**, and add a policy for Application Gateway identity that has `get`, `list`,
      and `secret management` permissions.

4. **Reference Certificate from Key Vault**: Go to **Application Gateway** \> **Listeners** \> **+ Add Listener**, select **HTTPS**, and then select **Key Vault certificate**.

> [!NOTE]
> Currently, Key Vault integration supports only certificates that have the private key in `.pfx` format.

## Limitations and considerations

1. **Direct use not supported:**

    - You can't bind an App Service Certificate to Application Gateway directly in the same manner as you can for App Services.

2. **Export required for manual use:**

    - You must extract the `.pfx` format from Key Vault before you can use it in Application Gateway (if you're not using a Key Vault reference).

3. **Autorenewal challenges:**

    - App Service Certificates support autorenewal only for App Services.
    - When used in Application Gateway, autorenewal doesn't automatically propagate.
    - You must manually update the certificate in Application Gateway after you renew it.
    - We recommend that you use **Azure Automation** or **Logic App** to automate this update process. See [Renew certificates in Application Gateway](/azure/application-gateway/renew-certificates).

4. **Certificate format restrictions:**

    - Application Gateway accepts only `.pfx` files.
    - Application Gateway rejects `.cer` and `.pem` files.
    - Self-signed certificates are supported but must be uploaded as `.pfx`.
    - See [Self-signed certificates for Application Gateway](/azure/application-gateway/self-signed-certificates).

## Best practices

- Use Key Vault-based integration for better security and easier management.
- Automate certificate renewal by using scripts or Azure Automation.
- Regularly audit access policies in Key Vault.
- Keep secure backup copies of your exported `.pfx` files.

## Summary

| Feature | App Service | Application Gateway
| --- | --- | ---
| Certificate Format | Managed by platform | Requires `.pfx`
| Autorenewal | Supported | Manual (requires automation)
| Key Vault Integration | Built in | Supported (requires setup)
| Direct Use of App Service Certificate | ✅ App Service only | ❌ Not supported

## Useful links

- [Renew certificates in Application Gateway](/azure/application-gateway/renew-certificates)
- [SSL certificates overview - Application Gateway](/azure/application-gateway/ssl-overview)
- [Use self-signed certificates in Application Gateway](/azure/application-gateway/self-signed-certificates)
- [Configure App Service Certificate](/azure/app-service/configure-ssl-app-service-certificate?tabs=portal)
- [Create a routing rule in Application Gateway](/azure/application-gateway/configuration-request-routing-rules)

[!INCLUDE [third-party-information-disclaimer](../../../../includes/third-party-information-disclaimer.md)]
