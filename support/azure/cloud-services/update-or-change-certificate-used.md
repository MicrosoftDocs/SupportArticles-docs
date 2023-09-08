---
title: Update or change the certificate used in Azure Cloud Services
description: Learn how to update or change the certificate that's used in Azure Cloud Services (extended support). 
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, zhangjerry, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
ms.custom: devx-track-azurepowershell
ms.topic: how-to
#Customer intent: As an Azure Cloud Services (extended support) user, I want to get instructions about how to update or change the certificate that's used so that my cloud application is available to customers with zero or minimal downtime.
---

# Update or change the certificate used in Azure Cloud Services (extended support)

This article discusses how to update or change the certificate that's used in Microsoft Azure Cloud Services (extended support) when the certificate approaches or reaches its expiration date. The article outlines how to do the required steps in the Azure portal, Azure PowerShell, or Microsoft Visual Studio.

## Preparatory steps

Before you can update or change the certificate, you must have a validated, self-signed certificate in [Personal Information Exchange (.pfx) file format](/windows-hardware/drivers/install/personal-information-exchange---pfx--files). To self-sign a certificate, follow the [PowerShell instructions in Certificates overview for Azure Cloud Services (classic)](/azure/cloud-services/cloud-services-certs-create#powershell). If you already have a Certificate Authority (CA) certificate, you don't have to self-sign the certificate.

The certificate has to be uploaded to a key vault certificate page. To upload to Azure Key Vault, follow steps 1 through 6 of the upload instructions in [Use certificates with Azure Cloud Services (extended support)](/azure/cloud-services-extended-support/certificates-and-key-vault#upload-a-certificate-to-key-vault).

## Certificate changes

To make your certificate update or change go into effect, use the instructions for your preferred implementation method on one of the following tabs:

### [Portal](#tab/azure-portal)

1. In the [Azure portal](https://portal.azure.com), search for and select **Cloud services (extended support)**.
1. In the list of cloud services, select the name of your cloud service.
1. In the cloud service menu pane, select **Configuration**.
1. In the cloud service configuration page, add the following lines of XML code within the **\<Role>** element. This code specifies the certificate that you want to use, including the certificate name, the thumbprint algorithm (Secure Hash Algorithm 1, or SHA-1), and the thumbprint (a 40-digit hexadecimal hash value).

   ```xml
   <Certificates>
     <Certificate
       name="Certificate1"
       thumbprint="0123456789ABCDEF0123456789ABCDEF01234567"
       thumbprintAlgorithm="sha1"
     />
   </Certificates>
   ```

   Make sure that the certificate thumbprint that you add here matches the real thumbprint of the certificate that you uploaded to the key vault.

1. Select **Save**.
1. Select the key vault to which you uploaded the certificate.
1. In the list of certificates, wait for the **Status** column in your certificate entry to change to a value of **Found**.
1. Select **OK**.

### [PowerShell](#tab/azure-powershell)

1. Modify the local service configuration file (*ServiceConfiguration.Local.cscfg*) to add or modify the necessary lines for the certificate that's used within the role. This code specifies the certificate that you want to use, including the certificate name, the thumbprint algorithm (Secure Hash Algorithm 1, or SHA-1), and the thumbprint (a 40-digit hexadecimal hash value). Add the certificate information in the **\<Certificates>** element inside the **\<Role>** element, as shown in the following XML code snippet:

   ```xml
   <Role name="WebRole1">
     <Instances count="1" />
     <Certificates>
       <Certificate
         name="Certificate1"
         thumbprint="0123456789ABCDEF0123456789ABCDEF01234567"
         thumbprintAlgorithm="sha1"
       />
     </Certificates>
   </Role>
   ```

   Make sure that the certificate thumbprint that you add here matches the real thumbprint of the certificate that you uploaded to the key vault.

   > [!NOTE]
   > The code change in PowerShell is nearly identical to the configuration change on the Azure portal. The only difference is that the PowerShell change modifies the local version of the service configuration file instead of the cloud version that's on the portal.

1. Go to the ["Manual migration from classic Cloud Service to Cloud Service Extended Support with ARM template"](https://techcommunity.microsoft.com/t5/azure-paas-blog/manual-migration-from-classic-cloud-service-to-cloud-service/ba-p/2263817) Azure PaaS Blog article, and follow steps 7 through 9. These instructions show you how to do the following steps:

   - Package the project.
   - Upload the generated service package (*\<project-name>.cspkg*) file into a storage account container for your cloud service.

     > [!NOTE]
     > Despite what's stated in the instructions, you don't have to upload the cloud service configuration (*ServiceConfiguration.Cloud.cscfg*) file. Only the service package file has to be uploaded here.

   - Generate a shared access signature (SAS) URL for the uploaded service package file.

1. Sign in to Azure by running the [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) cmdlet.
1. In the following PowerShell script, replace the placeholders at the beginning of the script with the actual values for each variable, and then run the script to update your cloud service:

   ```azurepowershell
   # Enter values for placeholders in the following variables.
   $vaultName = "<key-vault-resource-name>"
   $resourceGroupKeyVault = "<resource-group-name-where-key-vault-is-deployed>"
   $certificateName = "<name-of-certificate-saved-in-key-vault>"
   $cloudService = @{
       Name = "<name-of-cloud-service>"
       ResourceGroupName = "<resource-group-name-where-cloud-service-is-deployed>"
       SubscriptionId = "<subscription-guid>"
   }
   $cscfgFilePath = "<local-path-to-your-service-configuration-file-cscfg>"
   $cspkgUrl = "<sas-token-url-of-the-service-package-file-cspkg>"

   # Code execution
   $keyVault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroupKeyVault
   $certificate = Get-AzKeyVaultCertificate -VaultName $vaultName -Name $certificateName
   $vaultSecretGroupObject = @{
       CertificateUrl = $certificate.SecretId
       Id = $keyVault.ResourceId
   }
   $secretGroup = New-AzCloudServiceVaultSecretGroupObject @vaultSecretGroupObject
   $osProfile = @{secret = @($secretGroup)}

   $cses = Get-AzCloudService @cloudService
   $cses.Configuration = Get-Content $cscfgFilePath | Out-String
   $cses.PackageUrl = $cspkgUrl
   $cses.OSProfile = $osProfile
   $cses | Update-AzCloudService
   ```

> [!WARNING]
> If you update the service configuration (.cscfg) file but forget or fail to update the operating system (OS) profile of the cloud service (in the second-to-last line of the script), the cloud service won't be able to download the new certificate from the correct key vault. Therefore, it will be unable to install the certificate into underlying role instances, and the script will generate the following error message:
>
> > *Update-AzCloudService : The thumbprints specified in the CSCFG do not have corresponding certificates in osProfile.secrets. Add the missing certificates in osProfile.secrets. Missing thumbprints: WebRole1|\<40-hex-digit-sha1-thumbprint-hash-value>. To understand more about how to use KeyVault for certificates, please follow the documentation at <https://aka.ms/cses-kv>*

### [Visual Studio](#tab/visual-studio)

1. Modify the local service configuration file (*ServiceConfiguration.Local.cscfg*) to add or modify the necessary lines for the certificate that's used within the role. This code specifies the certificate that you want to use, including the certificate name, the thumbprint algorithm (Secure Hash Algorithm 1, or SHA-1), and the thumbprint (a 40-digit hexadecimal hash value). Add the certificate information in the **\<Certificates>** element inside the **\<Role>** element, as shown in the following XML code snippet:

   ```xml
   <Role name="WebRole1">
     <Instances count="1" />
     <Certificates>
       <Certificate
         name="Certificate1"
         thumbprint="0123456789ABCDEF0123456789ABCDEF01234567"
         thumbprintAlgorithm="sha1"
       />
     </Certificates>
   </Role>
   ```

   Make sure that the certificate thumbprint that you add here matches the real thumbprint of the certificate that you uploaded to the key vault.

   > [!NOTE]
   > The code change in Visual Studio is nearly identical to the configuration change on the Azure portal. The only difference is that the Visual Studio change modifies the local version of the service configuration file instead of the cloud version that's on the portal.

1. In the Visual Studio **Solution Explorer** pane, right-click the project, and then select **Publish**.
1. In the **Publish Azure Application** wizard, complete the required fields in the **Sign in** tab if necessary, and then select the **Next** button.
1. On the **Settings** tab, find the **Key vault** field, and then select the key vault to which you uploaded the certificate.
1. Select the **Publish** button.

---

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
