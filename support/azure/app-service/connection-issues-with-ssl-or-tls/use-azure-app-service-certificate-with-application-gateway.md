---
title: Use Azure App Service Certificate with Application Gateway
description: Learn how to use an Azure App Service Certificate with Application Gateway through Azure Key Vault for secure certificate management and renewal.
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/14/2026
ms.reviewer: kaushika
ms.custom: sap:Connection issues with SSL or TLS, SSL Certificates and Domains
---

# Use Azure App Service Certificate with Application Gateway

## Summary

Microsoft Azure provides various tools and services to secure your web applications by using SSL/TLS certificates. One such offering, the **Azure App Service Certificate**, is tightly integrated with Azure App Services. However, many organizations use **Azure Application Gateway** as a reverse proxy, load balancer, and Web Application Firewall (WAF). Understandably, such organizations want to use the same certificate across all services.

This article provides a comprehensive guide for using App Service Certificates in Application Gateway, including usage steps, restrictions, and best practices. By understanding the limitations and using the Azure Key Vault service effectively, you can build a robust certificate management workflow across both App Services and Application Gateway.

## About App Service Certificate

Azure App Service Certificate is a first-party SSL certificate that's issued by DigiCert or GoDaddy and is designed for use together with Azure App Services. The certificate is stored securely in Azure Key Vault and supports autorenewal if it's integrated correctly.

**Key characteristics**

Key characteristics of App Service Certificate include:

- Domain-validated SSL certificates.
- Designed primarily for App Services.
- Stored in a key vault for secure usage.
- Autorenewal supported if linked correctly.

However, you can't use App Service Certificates directly in Application Gateway unless you take additional steps.

## How to use App Service Certificate in Application Gateway

You can use App Service Certificate in Azure Application Gateway, but not directly. Application Gateway requires a certificate in `.pfx` format (having a private key) to configure HTTPS listeners. By default, you can't download App Service Certificates as PFX files. Therefore, you have to follow specific steps to extract and configure them.

### Option 1: Manual export and upload

1. **Purchase and configure the certificate**: Buy and verify an App Service Certificate through Azure App Service.

1. **Import into Key Vault**: Go to the App Service Certificate resource. Then, use the **Key Vault** blade to store the certificate in a key vault of your choice.

1. **Export as .pfx from Key Vault**: Use Azure PowerShell or Azure CLI to download the certificate as a `.pfx` file that has a private key.

    - Example that uses Azure CLI:

    ```bash
        az keyvault secret download \
        --vault-name `YourKeyVaultName` \
        --name `CertificateName` \
        --file cert.pfx \
        --encoding base64
    ```

1. **Upload to Application Gateway**: Go to Application Gateway \> Listeners \> + Add Listener. Select **HTTPS**, upload the `.pfx` file, and then enter the password.

1. **Associate with a rule**: Create a routing rule, and link it to the HTTPS listener. For detailed steps, see [Create a routing rule in Application Gateway](/azure/application-gateway/configuration-request-routing-rules).

### Option 2: Use Key Vault reference (recommended)

1. **Store App Service Certificate in Key Vault**: Go to the App Service Certificate resource. Then, use the **Key Vault** blade to store the certificate in a key vault of your choice.

1. **Enable Managed Identity for Application Gateway**: Enable user-assigned.

1. **Grant Access to key vault**: In the key vault, go to **Access Policies**, and add a policy for Application Gateway identity that has `secret get` permissions.

1. Due to current limitations, you need to assign user-assigned managed identity and SSL certificate to Application Gateway. Use Azure PowerShell to complete this step.

```PowerShell

# Connect to Azure and Authenticate
Connect-AzAccount
Select-AzSubscription -Subscription <customer subscription>
Install-Module -Name Az.ManagedServiceIdentity
# Define Variables
$AppGwName = "<YourApplicationGatewayName>"
$RGName = "<YourResourceGroupName>"
$UserIdentityName = "<YourUserAssignedManagedIdentityName>"
$vaultName = "<YourKeyVaultName>"
$secretName = "<YourCertificateSecretName>"
# Construct Key Vault Secret ID
$secretId = "https://${vaultName}.vault.azure.net:443/secrets/${secretName}/"
# Retrieve Application Gateway Object
$AppGw = Get-AzApplicationGateway -Name $AppGwName -ResourceGroupName $RGName
# Add SSL Certificate (Key Vault Reference)
Add-AzApplicationGatewaySslCertificate -ApplicationGateway $AppGw -Name $secretName -KeyVaultSecretId $secretId
# Retrieve User-Assigned Managed Identity
$identity = Get-AzUserAssignedIdentity -Name $UserIdentityName -ResourceGroupName $rgname
# Assign Managed Identity to Application Gateway
Set-AzApplicationGatewayIdentity -ApplicationGateway $AppGw -UserAssignedIdentityId $identity.Id
# Apply Changes to Azure
Set-AzApplicationGateway -ApplicationGateway $AppGw

```

1. **Reference Certificate from Key Vault**: Go to **Application Gateway** \> **Listeners** \> **+ Add Listener**, select **HTTPS**, and then select **Certificate** which you added in the previous step.

> [!NOTE]
> Currently, Key Vault integration supports only certificates that have the private key in `.pfx` format.

## Limitations and considerations

1. **Direct use not supported:**

    - You can't bind an App Service Certificate to Application Gateway directly in the same way as you can for App Services.

1. **Export required for manual use:**

    - You must extract the `.pfx` format from Key Vault before you can use it in Application Gateway (if you're not using a Key Vault reference).

1. **Autorenewal challenges:**

    - App Service Certificates support autorenewal only for App Services.
    - When used in Application Gateway, autorenewal doesn't automatically propagate.
    - You must manually update the certificate in Application Gateway after you renew it.
        - Use **Azure Automation** or **Logic App** to automate this update process. See [Renew certificates in Application Gateway](/azure/application-gateway/renew-certificates) for more information.

1. **Certificate format restrictions:**

    - Application Gateway accepts only `.pfx` files.
    - Application Gateway rejects `.cer` and `.pem` files.
    - Self-signed certificates are supported but must be uploaded as `.pfx`.
    - See [Self-signed certificates for Application Gateway](/azure/application-gateway/self-signed-certificates).

## Best practices

- Use Key Vault-based integration for better security and easier management.
- Automate certificate renewal by using scripts or Azure Automation.
- Regularly audit access policies in Key Vault.
- Keep secure backup copies of your exported `.pfx` files.

### Summary

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
