---
title: Read key vault certificate secrets from a cloud service-hosted app
description: Learn how an application that's hosted on Azure Cloud Services (extended support) can read certificate secrets that are stored in Azure Key Vault.
ms.date: 09/26/2022
ms.topic: how-to
editor: v-jsitser
ms.reviewer: v-maallu, prpillai, piw, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure Cloud Services (extended support) user, I want to know how an application that's hosted on a cloud service can read certificate secrets that are stored in Azure Key Vault so that I can authenticate customers without the use of managed identities.
---

# Read key vault certificate secrets on Azure Cloud Services (extended support)

This article discusses how to set up an application that's hosted by Microsoft Azure Cloud Services (extended support) so that it can read certificate secrets from a key vault.

## Overview

Unlike an application that's hosted in [Azure App Service](/azure/app-service/overview), an application that's hosted by Azure Cloud Services (extended support) must be able to read certificate secrets from a key vault. Although the [authentication best practice for Azure Key Vault](/azure/key-vault/general/developers-guide#authentication-best-practices) recommends that you use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview), Cloud Services (extended support) doesn't currently support this feature. In Cloud Services (extended support), an application has to employ [certificate credentials for application authentication on the Microsoft identity platform](/azure/active-directory/develop/active-directory-certificate-credentials).

In your application code, you should use the <xref:Azure.Security.KeyVault.Secrets.SecretClient> class in the <xref:Azure.Security.KeyVault.Secrets> namespace. The following table outlines other APIs to use for specific tasks.

| Task | API | Namespace |
|--|--|--|
| Fetch the certificate | The <xref:System.Security.Cryptography.X509Certificates.X509Store.Certificates?displayProperty=nameWithType> property | <xref:System.Security.Cryptography.X509Certificates> |
| Authenticate the certificate | The <xref:Azure.Identity.ClientCertificateCredential.%23ctor(System.String,System.String,System.String)> class constructor | <xref:Azure.Identity> |

The following C# code snippet shows how to read a certificate secret from a key vault into a `SecretClient` object:

```csharp
var store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
store.Open(OpenFlags.ReadOnly);
X509Certificate2 cert = store.Certificates.OfType<X509Certificate2>().FirstOrDefault(
    x => x.Thumbprint == certificateThumbprint
);
store.Close();

// Fetch tenantID and clientID from App registration.
var credential = new ClientCertificateCredential(tenantID, clientID, cert);
var client = new SecretClient(new Uri(keyVaultUrl), credential);
```

## More information

- For more information about how to authenticate through a service principal and certificate, see [Authentication in Azure Key Vault](/azure/key-vault/general/authentication).

- [Use certificates with Azure Cloud Services (extended support)](/azure/cloud-services-extended-support/certificates-and-key-vault).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
