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

Intune integrates with network access control (NAC) partners to help organizations secure corporate data when devices try to access on-premises resources. If the device is enrolled in Intune and is compliant with Intune device compliance policies, the NAC solution allows the device to access corporate resources. For more information about how the NAC integration works, see [Network access control (NAC) integration with Intune](/mem/intune/protect/network-access-control-integrate).

Cisco Identity Services Engine (ISE) integration with Microsoft Intune MDM Services uses Azure Active Directory (Azure AD) token-based authentication to access Intune services, and then uses that information to grant or deny network access to mobile devices.

## Import the public certificate from the Intune tenant into ISE

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Use the browser to get the certificate details. For example, in Microsoft Edge, select the HTTPS lock symbol, and then select **Certificate**. In the Certificate window, select the **Certification Path** tab.

   :::image type="content" source="media/integrate-cisco-ise-intune/certification-path.png" alt-text="Cerfication path":::

3. In the local machine certificate store, find the Baltimore CyberTrust Root certificate, and then export the root certificate.

   :::image type="content" source="media/integrate-cisco-ise-intune/export-certificate.png" alt-text="Export Baltimore CyberTrust Root certificate":::

4. In ISE, select **Administration** > **System** > **Certificates** > **Trusted Certificates**, and then import the root certificate that you exported in step 3. Give the certificate a meaningful name, such as *Azure MDM*.

## Export the Cisco ISE self-signed certificate

1. In the ISE console, select **Administration** > **System** > **Certificates** > **System Certificates**, select the Default self-signed server certificate, and then select **Export**.
2. Select **Export Certificate Only (default)**, and then select a location to save it to.
3. Run the following PowerShell script on the exported certificate file:

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

4. Keep the values for `$base64Thumbprint`, `$base64Value`, and `$keyid`. They will be used in the [Configure the application manifest and upload to Azure](#configure-the-application-manifest-and-upload-to-azure) step.

## Create an ISE application in Azure

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory**.
2. Under **Manage**, select **App registrations**, then select **New registration**.
3. Enter the following information for the application:

   - **Name**: Enter a name for your application, such as *Cisco ISE*.
   - **Supported account types**: Select an option to specify who can use the application.
   - **Redirect URI (optional)**: Select **Web**, and then enter the [redirect URI](/azure/active-directory/develop/quickstart-register-app#add-a-redirect-uri) for the location that the access token is sent to.

   :::image type="content" source="media/integrate-cisco-ise-intune/register-application.png" alt-text="Register an application":::

4. Select **Register** to complete the app registration.

## Configure the application manifest and upload to Azure

1. After the registration is complete, the Azure portal displays the application's **Overview** page, which includes the **Application (client) ID**.

   :::image type="content" source="media/integrate-cisco-ise-intune/application-overview.png" alt-text="Application overview after registration":::

2. On the application **Overview** page, select **Manifest** under **Manage**.
3. Select **Download** to download the manifest file, and then save it as a JSON file. Do not change the name of the manifest file.

   :::image type="content" source="media/integrate-cisco-ise-intune/download-manifest.png" alt-text="Download the manifest file":::

4. Update the **keyCredentials** field in the JSON file as shown in the following example:

   - Replace **Base64 Encoded String of ISE PAN cert** with the exported, edited certificate file from ISE, which is the `$base64Value` value from the PowerShell script in [Export the Cisco ISE self-signed certificate](#export-the-cisco-ise-self-signed-certificate).
   - Replace `keyId` with the `$keyid` value from the PowerShell script.
   - Replace `customKeyIdentifier` with the `$base64Thumbprint` value from the PowerShell script.

    ```json
    "keyCredentials": [
                              {
                                "customKeyIdentifier": "$base64Thumbprint_from_above",
                                "keyId": "$keyid_from_above",
                                "type": "AsymmetricX509Cert",
                                "usage": "Verify",
                                "value": "Base64 Encoded String of ISE PAN cert"
                              }
                      ]
    ```

   For more information about the KeyCredentials complex type, see [KeyCredential Type](/previous-versions/azure/ad/graph/api/entity-and-complex-type-reference#keycredential-type).
5. Save the JSON file, and then select **Upload** to upload it to Azure.

## Get the endpoints to configure Cisco ISE

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **App registrations** > **Endpoints**.
2. Note the following endpoints:

    - MICROSOFT AZURE AD GRAPH API ENDPOINT
    - OAUTH 2.0 TOKEN ENDPOINT
3. Also note the **Application (client) ID** of the ISE application.

These values are used when you [configure the Microsoft Intune server in ISE](#configure-the-microsoft-intune-server-in-ise).

## Configure API permissions

1. In the [Azure portal](https://portal.azure.com/), select **Azure Active Directory** > **App registrations**, and then select the ISE application.
2. Select **API permissions** > **Add a permission**.
3. Select **Microsoft Graph** from the APIs.
4. Select **Delegated permissions**, and then select the following permissions:

   |Permission|Description|
   |----------|-----------|
   |`Directory.Read.All`|Read directory data|
   |`User.Read`|Sign in and read user profile|
   |`DeviceManagementConfiguration.Read.All`|Read Microsoft Intune Device Configuration and Policies|
   |`DeviceManagementServiceConfig.Read.All`|Read Microsoft Intune configuration|
   |`openid`|Sign users in|
   |`offline_access`|Maintain access to data you have given it access to|
5. Select **Application permissions**, expand **Directory**, and then select the `Directory.Read.All` permission.
6. Select **Intune** from the APIs, select **Application permissions**, and then select the `get_device_compliance` permission.
7. Select **Add permissions**.
8. Select **Grant admin consent for \<tenant>** to grant administrator consent to the configured permissions. Select **Yes** when you are prompted to confirm the consent action.

   :::image type="content" source="media/integrate-cisco-ise-intune/configured-permissions.png" alt-text="Grant admin consent":::

## Configure the Microsoft Intune server in ISE

For more information about how to configure external MDM servers, see [Define Mobile Device Management Servers in ISE](https://www.cisco.com/c/en/us/td/docs/security/ise/2-1/admin_guide/b_ise_admin_guide_21/b_ise_admin_guide_20_chapter_01000.html#id_15092).

The following fields are important for Microsoft Intune:

- **Auto Discovery URL**: The endpoint at which an application can access directory data in your Microsoft Azure AD directory by using the Graph API. Enter the value of Microsoft Azure AD Graph API Endpoint from the Azure portal. The URL is in the form of `https://<hostname>/<tenant_ID>` (for example, `https://graph.windows.net/47f09275-5bc0-4807-8aae-f35cb0341329`). An expanded version of this URL is also in the property file, which is in the form of `https://<Graph_API_Endpoint>/<TenantId_Or_Domain>/servicePrincipalsByAppId/<Microsoft Intune AppId>/serviceEndpoints?api-version=1.6&client-request-id=<Guid.NewGuid()>`.
- **Client ID**: The unique identifier for your application. Use this attribute if your application accesses data in another application, such as the Microsoft Azure AD Graph API, Microsoft Intune API, and so on.
- **Token Issuing URL**: The endpoint at which your application can obtain an access token by using OAuth 2.0. Enter the value of the Oauth 2.0 Token Endpoint from the Azure portal. After your application is authenticated, Azure AD issues an access token to your application (ISE). This token allows your application to call the Graph API or Intune API.
- **Token Audience**: The recipient resource that the token is intended for, which is a public, well-known APP ID URL to the Microsoft Intune API.
