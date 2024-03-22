---
title: Enable HTTPS communication in Azure Cloud Services
description: Learn how to enable HTTPS communication in Azure Cloud Services (extended support). 
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, zhangjerry, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
ms.custom: devx-track-azurepowershell
ms.topic: how-to
#Customer intent: As an Azure Cloud Services (extended support) user, I want to get instructions about how to enable HTTPS communication so that I can make my cloud applications available to customers securely.
---

# Enable HTTPS communication in Azure Cloud Services (extended support)

Communication with Microsoft Azure Cloud Services (extended support) is done by using the Hypertext Transfer Protocol Secure (HTTPS) protocol. This article discusses how to enable HTTPS communication for Cloud Services (extended support).

## Prerequisites

- [Visual Studio](https://visualstudio.microsoft.com/).

- An [Azure Cloud Services (extended support) project in Visual Studio](/visualstudio/azure/vs-azure-tools-azure-project-create).

- A [Secure Sockets Layer (SSL) certificate](/azure/cloud-services-extended-support/certificates-and-key-vault) in [Personal Information Exchange (.pfx) file format](/windows-hardware/drivers/install/personal-information-exchange---pfx--files). If you don't already have an SSL certificate assigned by CA, [use a PowerShell script to self-assign a certificate for test use](/azure/cloud-services/cloud-services-certs-create#powershell).

- An [Azure Key Vault resource](/azure/key-vault/general/overview) that's within the same resource group as your Azure Cloud Services (extended support) resource. If you don't already have one, you can [create a key vault resource by using the Azure portal](/azure/key-vault/general/quick-create-portal).

## General steps for project deployment

The general steps to deploy a Cloud Services (extended support) project into Azure are as follows:

1. Prepare your certificate.

1. Configure your project.

1. Package the project file into the service definition (.csdef), service configuration (.cscfg), and service package (.cspkg) files of your cloud service.

1. Change the configuration of the Cloud Services (extended support) resource, if necessary. For example, you could make any of the following modifications:

   1. Update the package URL.
   1. Configure the URL setting.
   1. Update the operating system secrets setting.

1. Deploy and update the new project into Azure.

> [!NOTE]
> The project can be deployed through several different methods, such as by using the following tools:
>
> - Visual Studio
> - An [Azure Resource Manager template](/azure/azure-resource-manager/templates/overview) (ARM template)
> - A continuous integration and continuous delivery (CI/CD) tool, such as [Azure DevOps](https://azure.microsoft.com/services/devops/)
>
> Regardless of the deployment method, the general deployment steps are the same.

The first two of these steps are necessary for all deployment methods. These steps are discussed in the [Code changes](#code-changes) section. The remaining steps are also important, but they don't always require manual user intervention. For example, the steps might be done automatically by a tool such as Visual Studio. The last three of these steps are discussed in the [Configuration changes](#configuration-changes) section.

## Code changes

To make the code changes to prepare your certificate and configure your project, take the following steps:

1. Follow the instructions to [upload a certificate to the key vault](/azure/cloud-services-extended-support/certificates-and-key-vault#upload-a-certificate-to-key-vault) through step 6.
1. Write down the thumbprint of the certificate (a 40-digit hexadecimal string).
1. In the [service configuration (.cscfg) file](/azure/cloud-services/schema-cscfg-file) of your project, add the certificate thumbprint to the role in which you want to use the certificate. For example, if you want to use the certificate as the SSL certificate to communicate with a WebRole, you might add XML code that resembles the following snippet for `WebRole1` as the first child of the root `ServiceConfiguration` element:

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

   You can customize the name of the certificate, but it must match the certificate name that's used in the service definition (.csdef) file.
1. In the [service definition (.csdef) file](/azure/cloud-services/schema-csdef-file), add the following elements.

   | Parent XPath                                     | Elements to add            | Attributes to use                                               |
   |--------------------------------------------------|----------------------------|-----------------------------------------------------------------|
   | `/ServiceDefinition/WebRole/Sites/Site/Bindings` | `Binding`                  | **name**, **endpointName**                                      |
   | `/ServiceDefinition/WebRole/Endpoints`           | `InputEndpoint`            | **name**, **protocol**, **port**, **certificate**               |
   | `/ServiceDefinition/WebRole`                     | `Certificates/Certificate` | **name**, **storeLocation**, **storeName**, **permissionLevel** |

   The `Certificates` element has to be added directly after the closing `Endpoints` tag. It doesn't contain any attributes. It contains only child `Certificate` elements.

   For example, your service definition file might resemble the following XML code:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <ServiceDefinition name="CSESOneWebRoleHTTPS" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceDefinition" schemaVersion="2015-04.2.6">
     <WebRole name="WebRole1" vmsize="Standard_D1_v2">
       <Sites>
         <Site name="Web">
           <Bindings>
             <Binding name="Endpoint1" endpointName="Endpoint1" />
             <Binding name="HttpsIn" endpointName="HttpsIn" />
           </Bindings>
         </Site>
       </Sites>
       <Endpoints>
         <InputEndpoint name="Endpoint1" protocol="http" port="80" />
         <InputEndpoint name="HttpsIn" protocol="https" port="443" certificate="Certificate1" />
       </Endpoints>
       <Certificates>
         <Certificate name="Certificate1" storeLocation="LocalMachine" storeName="My" permissionLevel="limitedOrElevated" />
       </Certificates>
     </WebRole>
   </ServiceDefinition>
   ```

   In this example, the service definition file is modified to bind an input endpoint of `HttpsIn` for the HTTPS protocol on port 443. It uses the `Certificate1` certificate for a store that has a name of `My` and a location of `LocalMachine` for just a limited or elevated permission level. The certificate names in the `InputEndpoint` and `Certificate` elements match each other. They also match the certificate name that was used in the service configuration (.cscfg) file from the previous step.

## Configuration changes

Instructions for changing your cloud service configuration differ according to how your cloud service was deployed. These instructions are shown on the following tabs. Each tab represents a different method of deployment.

### [Portal](#tab/azure-portal)

Before you proceed, see [Deploy a Azure Cloud Services (extended support) using the Azure portal](/azure/cloud-services-extended-support/deploy-portal). Then, follow these steps to make the correct configuration changes through the Azure portal:

1. Go to the blog entry that's titled [Manual migration from classic Cloud Service to Cloud Service Extended Support with ARM template][migrate], and follow steps 7 through 9. These instructions show you how to do the following steps:

   - Package the project.
   - Upload the generated service package (*\<project-name>.cspkg*) and cloud service configuration (*ServiceConfiguration.Cloud.cscfg*) files into a storage account container for your cloud service.

     > [!NOTE]
     > You'll also have to upload the service definition (*ServiceDefinition.csdef*) file by using the same process that's described for the other two files.

   - Generate a shared access signature (SAS) URL for each of the uploaded files.

1. In the [Azure portal](https://portal.azure.com), return to the **Overview** page of your cloud service, and then select **Update**.
1. On the **Update cloud service** page, make the following changes on the **Basics** tab:
   1. In the **Package/configuration/service definition location** field, select **From blob**.
   1. In the **Upload a package (.cspkg, .zip)** field, follow these steps:

      1. Select the **Browse** link.
      1. Select the storage account and container to which you uploaded files.
      1. In the container page, select the corresponding file (in this case, *\<project-name>.cspkg*), and then select the **Select** button.
   1. For the **Upload a configuration (.cscfg)** field (and *ServiceConfiguration.Cloud.cscfg* file), repeat the subprocedure that's outlined in the previous step.
   1. For the **Upload a service definition (.csdef)** field (and *ServiceDefinition.csdef* file), repeat the subprocedure again.
1. Select the **Configuration** tab.
1. In the **Key vault** field, select the key vault in which you uploaded the certificate (earlier in the [Code changes](#code-changes) section). After the certificate is found in the selected key vault, the listed certificate displays a **Status** of **Found**.
1. To deploy the newly configured project, select the **Update** button.

### [PowerShell](#tab/azure-powershell)

Before you proceed, see [Deploy a Cloud Service (extended support) using Azure PowerShell](/azure/cloud-services-extended-support/deploy-powershell). Then, follow these steps to make the configuration changes through a PowerShell script:

1. Go to the blog entry that's titled [Manual migration from classic Cloud Service to Cloud Service Extended Support with ARM template][migrate], and follow steps 7 through 9. These instructions show you how to do the following steps:

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

### [Resource Manager Template](#tab/azure-resource-manager)

Before you proceed, see [Deploy a Cloud Service (extended support) using ARM templates](/azure/cloud-services-extended-support/deploy-template). Then, follow these steps to configure your ARM template:

1. Go to the blog entry that's titled [Manual migration from classic Cloud Service to Cloud Service Extended Support with ARM template][migrate], and follow steps 7 through 10. These instructions show you how to do the following steps:

   - Package the project.
   - Upload the generated service package (*\<project-name>.cspkg*) and cloud service configuration (*ServiceConfiguration.Cloud.cscfg*) files into a storage account container for your cloud service.
   - Generate a shared access signature (SAS) URL for each of the uploaded files.
   - Get the following values from the key vault certificate page in the Azure portal:

     - Key vault certificate URL
     - Subscription ID
     - Name of the resource group in which the key vault is deployed
     - Service name for the key vault

   In your original ARM template for the cloud service, find the `osProfile` property. If the original cloud service project supports only HTTP communication, the `osProfile` property is empty (`"osProfile": {}`). To enable the cloud service to retrieve the correct certificate from the correct key vault, specify which key vault you want to use within the ARM template. You can use a parameter to represent this value. Or, you can hardcode the value into the ARM template, as shown in the following example:

   ```json
   "osProfile": {
     "secrets": [
       {
         "sourceVault": {
           "id": "/subscriptions/88889999-aaaa-bbbb-cccc-ddddeeeeffff/resourceGroups/cstocses/providers/Microsoft.KeyVault/vaults/cstocses"
         },
         "vaultCertificates": [
           {
             "certificateUrl": "https://cstocses.vault.azure.net/secrets/csescert/0123456789abcdef0123456789abcdef"
           }
         ]
       }
     ]
   }
   ```

   In the JSON text of the ARM template, the `id` value in the `sourceVault` parameter is part of the URL of the Key Vault page in the Azure portal. The `certificateUrl` value is the key vault certificate URL that you found earlier. The text formats for these values are shown in the following table.

   | Parameter                 | Format                                                                                                                       |
   |---------------------------|------------------------------------------------------------------------------------------------------------------------------|
   | Source vault ID           | `/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<key-vault-name>` |
   | Key vault certificate URL | `https://<key-vault-name>.vault.azure.net/secrets/<certificate-name>/<certificate-secret>`                                   |

1. Deploy your updated ARM template containing new parameters, such as the package SAS token, configuration SAS token, and more. To see how to declare and specify these parameters, you can review an [example ARM template file](https://gist.github.com/wuping2004/b96e0f9528472a768b3941bf52de47b0) and an [example ARM template parameters file](https://gist.github.com/wuping2004/bf96bc6eab892f6a3c63c11ea6e1d7b0). Then, wait for the deployment to finish.

> [!NOTE]
> If you receive an error message that states that the public IP address is being used, remove the public IP address from the service configuration (.cscfg) file and the ARM template parameters file. Don't remove the public IP address declaration from the ARM template file itself.

### [C#](#tab/csharp)

Before you proceed, see [Deploy Cloud Services (extended support) by using the Azure SDK](/azure/cloud-services-extended-support/deploy-sdk).

> [!NOTE]
> This section contains code that's rewritten from the official SDK example code that you can find at [GitHub example code page for Azure Cloud Services (extended support)](https://github.com/Azure-Samples/cloud-services-extended-support/tree/main/SDKSample/CreateCloudService/CreateCloudService).

This section describes how to use the Azure SDK and C# to make the correct configuration changes. To successfully use the SDK to deploy the cloud service project and modify the related configuration, you should register an application in Microsoft Entra ID. To do the registration, see the [Use the portal to create a Microsoft Entra application and service principal that can access resources](/azure/active-directory/develop/howto-create-service-principal-portal) article. The following table outlines the specific steps to take and the corresponding subsection to read in that article.

| Step | Subsection link |
|--|--|
| Assign your subscription the owner role for your application | [Assign a role to the application](/azure/active-directory/develop/howto-create-service-principal-portal#assign-a-role-to-the-application) |
| Copy the tenant ID and the application ID | [Get tenant and app ID values for signing in](/azure/active-directory/develop/howto-create-service-principal-portal#get-tenant-and-app-id-values-for-signing-in) |
| Create and copy a new application secret | [Option 2: Create a new application secret](/azure/active-directory/develop/howto-create-service-principal-portal#option-2-create-a-new-application-secret) |
| Configure the access policy for the key vault, and give permission to your application (of at least read level) in order to access the certificate | [Configure access policies on resources](/azure/active-directory/develop/howto-create-service-principal-portal#configure-access-policies-on-resources) |

Follow these steps to make the correct configuration changes:

1. Go to the blog entry that's titled [Manual migration from classic Cloud Service to Cloud Service Extended Support with ARM template][migrate] and follow steps 7 through 10. These instructions show you how to do the following steps:

   - Package the project.
   - Upload the generated service package (*\<project-name>.cspkg*) file into a storage account container for your cloud service.

     > [!NOTE]
     > Despite what's stated in the instructions, you don't have to upload the cloud service configuration (*ServiceConfiguration.Cloud.cscfg*) file. Only the service package file has to be uploaded here.

   - Generate a shared access signature (SAS) URL for the uploaded service package file.
   - Get the following values from the key vault certificate page in the Azure portal:

     - Key vault certificate URL
     - Subscription ID
     - Name of the resource group in which the key vault is deployed
     - Service name for the key vault

1. Download the [example project](https://github.com/wuping2004/documents/raw/main/SDKSample.zip) (a compressed archive file), and extract its contents.
1. Open the *SDKSample\\CreateCloudService\\CreateCloudService\\LoginHelper.cs* file in a text editor. In the `InitializeServiceClient` method, overwrite the values of the `tenantId`, `clientId`, and `clientCredentials` string variables with the values for the tenant ID, application ID, and application secret, respectively. These values are the ones that you copied when you registered your application.
1. Open the *SDKSample\\CreateCloudService\\CreateCloudService\\Program.cs* file in a text editor. In the `Main` method, overwrite some of the initialized values of the variables declared at the beginning of the method. The following table shows the variable names and the values that you have to use for them.

   | Variable name      | New value                                                                                                              |
   |--------------------|------------------------------------------------------------------------------------------------------------------------|
   | `m_subId`          | The ID of the subscription that contains the cloud service                                                             |
   | `csrgName`         | The name of the resource group that contains the cloud service                                                         |
   | `csName`           | The cloud service resource name                                                                                        |
   | `kvrgName`         | The name of the resource group that contains the key vault resource                                                    |
   | `kvName`           | The key vault resource name                                                                                            |
   | `kvsubid`          | The ID of the subscription that contains the key vault (this might differ from the cloud service subscription ID)      |
   | `secretidentifier` | The key vault certificate URL                                                                                          |
   | `filename`         | The local path to your service configuration file (*ServiceConfiguration.Cloud.cscfg*)                                 |
   | `packageurl`       | The SAS URL for the service package file (*\<project-name>.cspkg*)                                                     |

1. In the Visual Studio **Solution Explorer** pane, right-click the project node, and then select **Manage NuGet Packages**. On the **Browse** tab, search for, select, and install the following packages:

   - `Microsoft.Azure.Management.ResourceManager`
   - `Microsoft.Azure.Management.Compute`
   - `Microsoft.Azure.Management.Storage`
   - `Azure.Identity`
   - `Microsoft.Rest.ClientRuntime.Azure.Authentication`

1. Run the project, and then wait for messages to appear in the **Output** pane. If the pane displays "exit with code 0," the update and deployment should be working successfully. If it displays "exit with code 1," you might have to check for error messages to review any issues.

### [Visual Studio](#tab/visual-studio)

Before you proceed, see [Create and deploy to Cloud Services (extended support) in Visual Studio](/visualstudio/azure/cloud-services-extended-support?context=%2Fazure%2Fcloud-services-extended-support%2Fcontext%2Fcontext).

In Visual Studio, you have to make two configuration changes. You set up your service configuration so that the local context is aligned with the cloud context, and then you specify where your key vault is located.

For the service configuration, copy the contents of the cloud context (the *ServiceConfiguration.Cloud.cscfg* file), and paste them into the local context (the *ServiceConfiguration.Local.cscfg* file). Do you have a different configuration, or do you still need the local configuration file for other uses? If either condition is true, preserve the `certificate` elements from the existing local context.

In the Visual Studio **Solution Explorer** pane, right-click the project node, and then select **Publish**. Proceed through the **Publish Azure Application** wizard until you reach the **Settings** tab. On that tab, set the **Key vault** field to the location in which your key vault is saved. Finally, select the **Publish** button, and then wait for the deployment to finish.

---

After you make the configuration changes, customers will be able to communicate with your cloud services website by using the HTTPS protocol. If your certificate is self-signed, the browser might report a warning that the certificate isn't secure, but the browser won't block the connection.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[migrate]: https://techcommunity.microsoft.com/t5/azure-paas-blog/manual-migration-from-classic-cloud-service-to-cloud-service/ba-p/2263817
