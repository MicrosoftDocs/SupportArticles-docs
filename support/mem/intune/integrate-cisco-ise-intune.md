---
title: Integrate Cisco ISE with Intune
description: Introduces how to configure Microsoft Intune as an MDM server for Cisco ISE. 
author: helenclu
ms.author: luche
ms.reviewer: shhodge
ms.date: 10/13/2020
ms.prod-support-area-path: 
---
# Support tip: Integrate Cisco ISE with Intune

Intune integrates with network access control (NAC) partners to help organizations secure corporate data when devices try to access on-premises resources. If the device is enrolled in Intune and is compliant, the NAC solution allows the device to access corporate resources. For more information about how the NAC integration works, see [Network access control (NAC) integration with Intune](/mem/intune/protect/network-access-control-integrate).

Cisco Identity Services Engine (ISE) integration with Microsoft Intune MDM Services leverages Azure Active Directory (Azure AD) token-based authentication to access Intune services and leverage the information to grant or deny network access to mobile devices.

## Import the public certificate from the Intune tenant into ISE

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Use the browser to get the certificate details. For example, with Microsoft Edge, select the HTTPS lock symbol, and then select **Certificate**. In the Certificate window, select the **Certification Path** tab.

   :::image type="content" source="media/integrate-cisco-ise-intune/certification-path.png" alt-text="Cerfication path":::

3. In local machine certificate store, find the Baltimore CyberTrust Root certificate, and then export the root certificate.

   :::image type="content" source="media/integrate-cisco-ise-intune/export-certificate.png" alt-text="Export Baltimore CyberTrust Root certificate":::

4. In ISE, select **Administration** > **System** > **Certificates** > **Trusted Certificates**, and import the root certificate that you save in step 3. Give the certificate a meaningful name, such as *Azure MDM*.

## Export the Cisco ISE self-signed certificate

1. In the ISE console, select **Administration** > **System** > **Certificates** > **System Certificates**, select the Default self-signed server certificate, and then select **Export**.
2.	Select **Export Certificate Only (default)**, and select a place to save it.
3.	Run the following PowerShell script on the exported certificate file:

    ```powershell
    $cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $cer.Import(“mycer.cer”)
    $bin = $cer.GetRawCertData()
    $base64Value = [System.Convert]::ToBase64String($bin)
 
    $bin = $cer.GetCertHash()
    $base64Thumbprint = [System.Convert]::ToBase64String($bin)
 
    $keyid = [System.Guid]::NewGuid().ToString()
    ```

   After the script runs, the values are stored in the variables. Type the variable name at the PowerShell prompt to review the values, as shown in the following example:

   :::image type="content" source="media/integrate-cisco-ise-intune/script-demo.png" alt-text="Review variable values":::

4. Keep the values for `$base64Thumbprint`, `$base64Value`, and `$keyid`. They will be used in Configure the application manifest and upload to Azure.

## Create a Cisco ISE application in Azure

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **Enterprise applications - All Applications** > **Categories** > **Add an application**.
2. Select **Add an application my organization is developing**.

   :::image type="content" source="media/integrate-cisco-ise-intune/add-application.png" alt-text="Add an application":::

3. Select **New application registration**.
4. Enter the following information for the application:

   - **Name**: select a name for your application, such as *CiscoISE*.
   - **Application type**: select **Web app / API**.
   - **Sign-on URL**: enter the URL at which your application is hosted, such as `https://CiscoISE.contoso.onmicrosoft.com`.
   - **App ID URI**: a unique identifier for your application. The URI must be in a verified custom domain for an external user to grant your application access to their data in Azure AD. For example, if your tenant is `contoso.onmicrosoft.com`, the APP ID URI can be `https://app.contoso.onmicrosoft.com`.

5.	Select **Create** to create the application.

## Configure the application manifest and upload to Azure

1.	In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **App registrations**, select the ISE application you created.
2. From the application's **Overview** page, select **Manifest**.
3. A web-based manifest editor opens. Select **Download** to download the manifest file and save it as a JSON file. Do not change the name of the manifest file.  
4. Update the **keyCredentials** field in the json file as shown in the following example. Replace **Base64 Encoded String of ISE PAN cert** with the exported, edited certificate file from ISE, which is the `$base64Value` from the PowerShell script in Export the Cisco ISE self-signed certificate. Replace `keyId` with the `$keyid` value from the PowerShell script. Replace `customKeyIdentifier` with the `$base64Thumbprint` value from the PowerShell script.

    ```json
    "keyCredentials": [
                              {
                                “customKeyIdentifier“: “$base64Thumbprint_from_above”,
                                “keyId“: “$keyid_from_above“,
                                "type": "AsymmetricX509Cert",
                                "usage": "Verify",
                                "value": "Base64 Encoded String of ISE PAN cert"
                              }
                      ]
    ```                   

   For more information about the KeyCredentials complex type, see [KeyCredential Type](/previous-versions/azure/ad/graph/api/entity-and-complex-type-reference#keycredential-type).
5. Save the json file, and then select **Upload** to upload it to Azure.

## Get the endpoints to configure Cisco ISE

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **App registrations** > **Endpoints**.
2. Take note of the following endpoints:

    - MICROSOFT AZURE AD GRAPH API ENDPOINT
    - OAUTH 2.0 TOKEN ENDPOINT
3. Also take note of the **Application (client) ID** of the ISE application.

These values are used when you configure the Microsoft Intune server in ISE.

## Configure application permissions and delegated permissions

The following screenshot shows the application permissions and delegated permissions to be configured:

:::image type="content" source="media/integrate-cisco-ise-intune/permission-settings.png" alt-text="Permissions":::

To configure the permissions, follow these steps:

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **App registrations**, and then select the ISE application.
2. Select **API permissions** > **Add a permission**.
3. Select **Microsoft Graph** from the APIs.
4. Select **Delegated permissions**, select the following permissions, and then select **Add permissions**.

   |Permission|Description|
   |----------|-----------|
   |`Directory.Read.All`|Read directory data|
   |`User.Read`|Sign in and read user profile|
   |`DeviceManagementConfiguration.Read.All`|Read Microsoft Intune device Configuration and policies|
   |`DeviceManagementServiceConfig.Read.All`|Read Microsoft Intune configuration|
   |`openid`|Sign users in|
   |`offline_access`|Access user's data anytime|
5. Select **Application permissions**, expand **Directory**, select the `Directory.Read.All` permission, and then select **Add permissions**.
6. Select **Intune** from the APIs, select **Application permissions**, select the `get_device_compliance` permission, and then select **Add permissions**.
7. To grant admin consent to the permissions configured for the application, select **Grant admin consent for \<tenant_ID>**, select **Yes** when you are prompted to confirm the consent action.

   :::image type="content" source="media/integrate-cisco-ise-intune/configured-permissions.png" alt-text="Configured permissions":::

## Configure the Microsoft Intune server in ISE

For more information about how to configure external MDM servers, see [Define Mobile Device Management Servers in ISE](https://www.cisco.com/c/en/us/td/docs/security/ise/2-1/admin_guide/b_ise_admin_guide_21/b_ise_admin_guide_20_chapter_01000.html#id_15092). 

The following fields are important for Microsoft Intune:

- **Auto Discovery URL**: Enter the value of Microsoft Azure AD Graph API Endpoint from the Azure portal. This URL is the endpoint at which an application can access directory data in your Microsoft Azure AD directory by using the Graph API. The URL is in the form of `https://<hostname>/<tenant_ID>`, for example, `https://graph.windows.net/47f09275-5bc0-4807-8aae-f35cb0341329`. An expanded version of this URL is also in the property file, which is in the form of `https://<Graph_API_Endpoint>/<TenantId_Or_Domain>/servicePrincipalsByAppId/<Microsoft Intune AppId>/serviceEndpoints?api-version=1.6&client-request-id=<Guid.NewGuid()>`.
- **Client ID**: The unique identifier for your application. Use this attribute if your application accesses data in another application, such as the Microsoft Azure AD Graph API, Microsoft Intune API, and so on.
- **Token Issuing URL**: Enter the value of the Oauth2.0 Authorization Endpoint from the Azure portal. It is the endpoint at which your application can obtain an access token using OAuth2.0. After your application is authenticated, Azure AD issues your application (ISE) an access token. This token allows your application to call the Graph API or Intune API.
- **Token Audience**: The recipient resource that the token is intended for, which is a public, well-known APP ID URL to the Microsoft Intune API.
