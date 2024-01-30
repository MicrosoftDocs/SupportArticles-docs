---
title: PKCS12 without a supplied password has exceeded maximum allowed iterations error
description: Resolves an error that occurs during a fiscal registration process in Microsoft Dynamics 365 Commerce.
author: jialinhuang
ms.author: jialinhuang
ms.reviewer: josaw, brstor
ms.date: 01/30/2024
---
# "PKCS12 (PFX) without a supplied password has exceeded maximum allowed iterations" error in fiscal integration

This article provides a solution for an error that occurs in a fiscal integration process in Microsoft Dynamics 365 Commerce.

## Symptoms

In a [fiscal registration](/dynamics365/commerce/localizations/dev-itpro/fiscal-integration-for-retail-channel) process, when you try to submit a fiscal document, you receive the following error message:

> PKCS12 (PFX) without a supplied password has exceeded maximum allowed iterations. See https://go.microsoft.com/fwlink/?linkid=2233907 (Opens in new window or tab) for more information.

## Resolution

### Prerequisites

Before exploring the issue, you should know which type of certificates is supported in your scenario.

- If POS is running in offline mode, only local certificates are supported.
- For [Commerce Scale Unit (CSU) (cloud)](/dynamics365/fin-ops-core/dev-itpro/deployment/initialize-retail-channels), only certificates from [Azure Key Vault](/azure/key-vault/general/basic-concepts) are supported.
- For self-hosted CSU, certificates from both Azure Key Vault and local storage are supported.

### Export a PFX certificate without a password

If certificates from Azure Key Vault are used for digital signing, the certificates uploaded to Azure Key Vault should contain the private key and not have a password.

If you export the certificate using Certificate Export Wizard, a [personal information exchange (PFX) certificate](/mem/configmgr/mdm/deploy-use/create-pfx-certificate-profiles) format should be selected and you'll be prompted to enter a password. However, certificates with passwords aren't supported for digital signing in Microsoft Dynamics 365 Commerce. Run the following script to remove the password from a PFX certificate:

```pwsh
$pfxFilePath = '<Localpath of the pfx certificate>'
$pwd = '<Password of the pfx certificate>'
$collection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
$collection.Import($pfxFilePath, $pwd, [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
$pkcs12ContentType = [System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12
$certBytes = $collection.Export($pkcs12ContentType)
[System.IO.File]::WriteAllBytes($pfxFilePath, $certBytes)
```

## More information

- [Maintaining the Azure Key Vault storage](https://support.microsoft.com/topic/maintaining-azure-key-vault-storage-ebd478ba-446e-61cc-4a17-39c1a64cc2d6)
- [Set up Azure Key Vault client](/dynamics365/finance/localizations/global/setting-up-azure-key-vault-client)
- [Configure certificate profiles](/dynamics365/commerce/localizations/global/certificate-profiles-for-retail-stores)
