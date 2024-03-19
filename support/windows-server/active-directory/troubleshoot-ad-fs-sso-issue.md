---
title: ADFS SSO troubleshooting
description: Introduce how to troubleshoot ADFS SSO issues.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Troubleshoot SSO issues with Active Directory Federation Services (AD FS)

This article helps you resolve single sign-on (SSO) issues with Active Directory Federation Services (AD FS).

Select one of the following section according to the type of issue that you encounter.

_Applies to:_ &nbsp; Active Directory Federation Services  
_Original KB number:_ &nbsp; 4034932

## NTLM or forms-based authentication prompt

During troubleshooting single sign-on (SSO) issues with Active Directory Federation Services (AD FS), if users received unexpected NTLM or forms-based authentication prompt, follow the steps in this article to troubleshoot this issue.

### Check Windows Integrated Authentication settings

To troubleshoot this issue, check Windows Integrated Authentication settings in the client browser, AD FS settings and authentication request parameters.

#### Check the client browser of the user

Check the following settings in Internet Options:

- On the **Advanced** tab, make sure that the **Enable Integrated Windows Authentication** setting is enabled.
- Following **Security** > **Local intranet** > **Sites** > **Advanced**, make sure that the AD FS URL is in the list of websites.
- Following **Security > Local intranet > Custom level**, make sure that the **Automatic logon only in Intranet Zone** setting is selected.

If you use Firefox, Chrome or Safari, make sure the equivalent settings in these browsers are enabled.

#### Check the AD FS settings

##### Check the WindowsIntegratedFallback setting

1. Open Windows PowerShell with the Run as administrator option.
2. Get the global authentication policy by running the following command:

   ```powershell
   Get-ADFSGlobalAuthenticationPolicy | fl WindowsIntegratedFallbackEnabled
   ```

3. Examine the value of the **WindowsIntegratedFallbackEnabled** attribute.

If the value is **True**, forms-based authentication is expected. This means that the authentication request comes from a browser that doesn't support Windows Integrated Authentication. See the next section about how to get your browser supported.

If the value is **False**, Windows Integrated Authentication should be expected.

##### Check the WIASupportedUsersAgents setting

1. Get the list of supported user agents by running the following command:

   ```powershell
   Get-ADFSProperties | Select -ExpandProperty WIASupportedUserAgents
   ```

2. Examine the list of user agent strings that the command returns.

Verify if the user agent string of your browser is in the list. If not, add the user agent string by following the steps below:

1. Go to [http://useragentstring.com/](http://useragentstring.com/) that detects and shows you the user agent string of your browser.
2. Get the list of supported user agents by running the following command:

   ```powershell
   $wiaStrings = Get-ADFSProperties | Select -ExpandProperty WIASupportedUserAgents
   ```

3. Add the user agent string of your browser by running the following command:

   ```powershell
   $wiaStrings = $wiaStrings+"NewUAString"
   ```

   Example:

   ```powershell
   $wiaStrings = $wiaStrings+" =~Windows\s*NT.*Edge"+"Mozilla/5.0"
   ```

4. Update the WIASupportedUserAgents setting by running the following command:

   ```powershell
   Set-ADFSProperties -WIASupportedUserAgents $wiaStrings
   ```

#### Check the authentication request parameters

##### Check if the authentication request specifies forms-based authentication as the authentication method

1. If the authentication request is a WS-Federation request, check if the request includes **wauth= urn:oasis:names:tc:SAML:1.0:am:password**.
2. If the authentication request is a SAML request, check if the request includes a **samlp:AuthnContextClassRef** element with value **urn:oasis:names:tc:SAML:2.0:ac:classes:Password**.

For more information, see [Overview of authentication handlers of AD FS sign-in pages](/previous-versions/adfs-2.0/ee895365(v=msdn.10)).

##### Check if the application is Microsoft Online Services for Office 365

If the application that you want to access is not Microsoft Online Services, what you experience is expected and controlled by the incoming authentication request. Work with the application owner to change the behavior.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

If the application is Microsoft Online Services, what you experience may be controlled by the **PromptLoginBehavior** setting from the trusted realm object. This setting controls whether Microsoft Entra tenants send prompt=login to AD FS. To set the **PromptLoginBehavior** setting, follow these steps:

1. Open Windows PowerShell with the "Run as administrator" option.
2. Get the existing domain federation setting by running the following command:

   ```powershell
   Get-MSOLDomainFederationSettings -DomainName DomainName | FL *
   ```

3. Set the PromptLoginBehavior setting by running the following command:

   ```powershell
   Set-MSOLDomainFederationSettings -DomainName DomainName -PromptLoginBehavior <TranslateToFreshPasswordAuth|NativeSupport|Disabled> -SupportsMFA <$TRUE|$FALSE> -PreferredAuthenticationProtocol <WsFed|SAMLP>
   ```

   The values for the PromptLoginBehavior parameter are:

   1. **TranslateToFreshPasswordAuth**: Microsoft Entra ID sends wauth and wfresh to AD FS instead of prompt=login. This leads to an authentication request to use forms-based authentication.
   2. **NativeSupport**: The prompt=login parameter is sent as is to AD FS.
   3. **Disabled**: Nothing is sent to AD FS.

To learn more about the Set-MSOLDomainFederationSettings command, see [Active Directory Federation Services prompt=login parameter support](/windows-server/identity/ad-fs/operations/ad-fs-prompt-login).

<a name='azure-active-directory-azure-ad-scenario'></a>

### Microsoft Entra scenario

If the authentication request sent to Microsoft Entra ID include [the prompt=login parameter](/windows-server/identity/ad-fs/operations/ad-fs-prompt-login), disable the prompt=login capability by running the following command:

```powershell
Set-MsolDomainFederationSettings –DomainName DomainName -PromptLoginBehavior Disabled
```

After you run this command, Office 365 applications won't include the prompt=login parameter in each authentication request.

<a name='non-azure-ad-scenario'></a>

### Non Microsoft Entra scenario

Request parameters like **WAUTH** and **RequestedAuthNContext** in authentication requests can have authentication methods specified. Check if other request parameters enforcing the unexpected authentication prompt. If so, modify the request parameter to use the expected authentication method.

### Check if SSO is disabled

If SSO is disabled, enable it and test if the issue is resolved.

## Multi-factor authentication prompt

To troubleshoot this issue, check if the claim rules in the relying party are correctly set for multi-factor authentication.

Multi-factor authentication can be enabled at an AD FS server, at a relying party, or specified in an authentication request parameter. Check the configurations to see if they are correctly set. If multi-factor authentication is expected but you're repeatedly prompted for it, check the relying party issuance rules to see if multi-factor authentication claims are passed through to the application.

For more information about multi-factor authentication in AD FS, see the following articles:

- [Under the hood tour on Multi-Factor Authentication in ADFS – Part 1: Policy](https://blogs.msdn.microsoft.com/ramical/2014/01/30/under-the-hood-tour-on-multi-factor-authentication-in-adfs-part-1-policy/)
- [Under the hood tour on Multi-Factor Authentication in ADFS – Part 2: MFA aware Relying Parties](https://blogs.msdn.microsoft.com/ramical/2014/02/18/under-the-hood-tour-on-multi-factor-authentication-in-adfs-part-2-mfa-aware-relying-parties/)

### Check the configuration on the AD FS server and the relying party

To check the configuration on the AD FS server, validate the global additional authentication rules. To check the configuration on the relying party, validate the additional authentication rules for the relying party trust.

1. To check the configuration on the AD FS server, run the following command in a Windows PowerShell window.

   ```powershell
   Get-ADFSAdditionalAuthenticationRule
   ```

   To check the configuration on the relying party, run the following command:

   ```powershell
   Get-ADFSRelyingPartyTrust -TargetName RelyingParty | Select -ExpandProperty AdditionalAuthenticationRules
   ```

   > [!NOTE]
   > If the commands return nothing, the additional authentication rules are not configured. Skip this section.

2. Observe the claim rule set configured.

### Verify if multi-factor authentication is enabled in the claim rule set

A claim rule set is composed of the following sections:

- The condition statement: `C:[Type=``…,Value=…]`
- The issue statement: `=> issue (Type=``…,Value=…)`

If the issue statement contains the following claim, multi-factor authentication is specified.  
`Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "http://schemas.microsoft.com/claims/multipleauthn"`

Here are examples that require multi-factor authentication to be used for non-workplace joined devices and for extranet access respectively:

- `c:[Type == "http://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser", Value == "false"] => issue(Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "http://schemas.microsoft.com/claims/multipleauthn")`
- `c:[Type == "http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", Value == "false"] => issue(Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "http://schemas.microsoft.com/claims/multipleauthn")`

### Check the relying party issuance rules

If the user repeatedly receives multi-factor authentication prompts after they perform the first authentication, it is possible that the replying party is not passing through the multi-factor authentication claims to the application. To check if the authentication claims are passed through, follow these steps:

1. Run the following command in Windows PowerShell:

   ```powershell
   Get-ADFSRelyingPartyTrust -TargetName ClaimApp
   ```

2. Observe the rule set defined in the IssuanceAuthorizationRules or IssuanceAuthorizationRulesFile attributes.

The rule set should include the following issuance rule to pass through the multi-factor authentication claims:  
`C:[Type==http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod, Value==" http://schemas.microsoft.com/claims/multipleauthn"]=>issue(claim = c)`

### Check the authentication request parameter

#### Check if the authentication request specifies multi-factor authentication as the authentication method

- If the authentication request is a WS-Federation request, check if the request includes `wauth= http://schemas.microsoft.com/claims/multipleauthn`.
- If the authentication request is a SAML request, check if the request includes a **samlp:AuthnContextClassRef** element with value `http://schemas.microsoft.com/claims/multipleauthn`.

For more information, see [Overview of authentication handlers of AD FS sign-in pages](/previous-versions/adfs-2.0/ee895365(v=msdn.10)).

#### Check if the application is Microsoft Online Services for Office 365

If the application that you want to access is Microsoft Online Services for Office 365, check the SupportsMFA domain federation setting.

1. Get the current SupportsMFA domain federation setting by running the following command:

   ```powershell
   Get-MSOLDomainFederationSettings -DomainName DomainName | FL *
   ```

2. If the SupportsMFA setting is FALSE, set it to TRUE by running the following command:  

   ```powershell
   Set-MSOLDomainFederationSettings -DomainName DomainName -SupportsMFA $TRUE
   ```

### Check if SSO is disabled

If SSO is disabled, enable it and test if the issue is resolved.

## Users can't log in the target site or service

This issue can occur at the AD FS sign-in page or at the application side.

If the issue occurs at the AD FS sign-in page, you receive an "An error occurred", "HTTP 503 Service is unavailable" or some other error message. The URL of the error page shows the AD FS service name such as `fs.contoso.com`.

If the issue occurs at the application side, the URL of the error page shows the IP address or the site name of the target service.

Follow the steps in the following section according where you encounter this issue.

### This issue occurs at the AD FS sign-in page

To troubleshoot this issue, check if all all users are impacted by the issue, and if the users can access all the relying parties.

#### All users are impacted by the issue, and the user can't access any of the relying parties

Let's check the internal sign-in functionality using IdpInitiatedSignOn. To do this, use the IdpInititatedSignOn page to verify if the AD FS service is up and running and the authentication functionality is working correctly. To open the IdpInitiatedSignOn page, follow these steps:

1. Enable the IdpInitiatedSignOn page by running the following command on the AD FS server:  

   ```powershell
   Set-AdfsProperties -EnableIdPInitiatedSignonPage $true
   ```

2. From a computer that is inside your network, visit the following page:  
   `https://<FederationInstance>/adfs/ls/idpinitiatedsignon.aspx`

3. Enter the correct credentials of a valid user on the sign-in page.

##### The sign-in is successful

If the sign-in is successful, check if the AD FS service state is running.

1. On the AD FS server, open Server Manager.
2. In the Server Manager, click **Tools** > **Services**.
3. Check if the **Status** of **Active Directory Federation Services** is **Running**.

Then, check the external sign-in functionality using IdpInitiatedSignOn. Use the IdpInititatedSignOn page to quickly verify if the AD FS service is up and running and the authentication functionality is working correctly. To open the IdpInitiatedSignOn page, follow these steps:

1. Enable the IdpInitiatedSignOn page by running the following command on the AD FS server:  

   ```powershell
   Set-AdfsProperties -EnableIdPInitiatedSignonPage $true
   ```

2. From a computer that is outside of your network, visit the following page:  
   `https://<FederationInstance>/adfs/ls/idpinitiatedsignon.aspx`

3. Enter the correct credentials of a valid user on the sign-in page.

If the sign-in is unsuccessful, see [Check the AD FS related components and services](#check-the-adfs-related-components-and-services) and [Check the proxy trust relationship](#check-the-proxy-trust-relationship).

If the sign-in is successful, continue the troubleshooting with the steps in [All users are impacted by the issue, and the user can access some of the relying parties](#all-users-are-impacted-by-the-issue-and-the-user-can-access-some-of-the-relying-parties).

##### The sign-in is unsuccessful

If the sign-in is unsuccessful, [check the AD FS related components and services](#check-the-adfs-related-components-and-services).

Check if the AD FS service state is running.

1. On the AD FS server, open Server Manager.
2. In the Server Manager, click **Tools** > **Services**.
3. Check if the **Status** of **Active Directory Federation Services** is **Running**.

Check if the endpoints are enabled. AD FS provides various endpoints for different functionalities and scenarios. Not all endpoints are enabled by default. To check the status of the endpoints, following these steps:

1. On the AD FS server, open the AD FS Management Console.
2. Expand **Service** > **Endpoints**.
3. Locate the endpoints and verify if the statuses are enabled on the **Enabled** column.  

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/adfs-endpoints-enabled.png" alt-text="Double check the status of all the A D F S endpoints are enabled.":::

Then, check if Microsoft Entra Connect is installed. We recommend that you use Microsoft Entra Connect which makes SSL certificate management easier.

If Microsoft Entra Connect is installed, ensure that you [use it to manage and update SSL certificates](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update).

If Microsoft Entra Connect is not installed, check if the SSL certificate meets the following AD FS requirements:

- The certificate is from a trusted root certification authority.

  AD FS requires that SSL certificates are from a trusted root certification authority. If AD FS is accessed from non-domain joined computers, we recommend that you use an SSL certificate from a trusted third-party root certification authority like DigiCert, VeriSign, etc. If the SSL certificate is not from a trusted root certification authority, SSL communication can break.
- The subject name of the certificate is valid.

  The subject name should match the federation service name, not the AD FS server name or some other name. To get the federation service name, run the following command on the primary AD FS server:  
  `Get-AdfsProperties | select hostname`
- The certificate is not revoked.

  Check for certificate revocation. If the certificate is revoked, SSL connection can't be trusted and will be blocked by clients.

If the SSL certificate does not meet these requirements, try to get a qualified certificate for SSL communication. We recommend that you use Microsoft Entra Connect which makes SSL certificate management easier. See [Update the TLS/SSL certificate for an Active Directory Federation Services (AD FS) farm](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update).

If the SSL certificate meets these requirements, check the following configurations of the SSL certificate.

###### Check if the SSL certificate is installed properly

The SSL certificate should be installed to the **Personal** store for the local computer on each federation server in your farm. To install the certificate, double click the .PFX file of the certificate and follow the wizard.

To verify if the certificate is installed to the correct place, follow these steps:

1. List the certificates that are in the **Personal** store for the local computer by running the following command:  
   `dir Cert:\LocalMachine\My`
2. Check if the certificate is in the list.

###### Check if the correct SSL certificate is in use

Get the thumbprint of the certificate that is in use for SSL communication and verify if the thumbprint matches the expected certificate thumbprint.

To get the thumbprint of the certificate that is in use, run the following command in Windows PowerShell:

```powershell
Get-AdfsSslCertificate
```

If the wrong certificate is used, set the correct certificate by running the following command:

```powershell
Set-AdfsSslCertificate –Thumbprint CorrectThumprint
```

###### Check if the SSL certificate is set as the service communication certificate

The SSL certificate needs to be set as the service communication certificate in your AD FS farm. This does not happen automatically. To check if the correct certificate is set, follow these steps:

1. In the AD FS Management Console, expand **Service** > **Certificates**.
2. Verify if the certificate listed under **Service communications** is the expected certificate.

If the wrong certificate is listed, set the correct certificate, and then grant the AD FS service the **Read** permission to the certificate. To do this, follow these steps:

1. Set the correct certificate:
   1. Right-click **Certificates**, and then click **Set Service Communication Certificate**.
   2. Select the correct certificate.
2. Verify if the AD FS service has the **Read** permission to the certificate:

   1. Add the **Certificates** snap-in for the local computer account to the Microsoft Management Console (MMC).
   2. Expand **Certificates (Local Computer)** > **Personal** > **Certificates**.
   3. Right-click the SSL certificate, click **All Tasks** > **Manage Private Keys**.
   4. Verify if **adfssrv** is listed under **Group and user names** with the **Read** permission.
3. If adfssrv is not listed, grant the AD FS service the **Read** permission to the certificate:

   1. Click **Add**, click **Locations**, click the server, and then click **OK**.
   2. Under **Enter the object names to select**, enter **nt service\adfssrv**, click **Check Names**, and then click **OK**.  
   If you are using AD FS with Device Registration Service (DRS), enter **nt service\drs** instead.
   3. Grant the **Read** permission, and then click **OK**.

###### Check if Device Registration Service (DRS) is configured in AD FS

If you've configured AD FS with DRS, make sure that the SSL certificate is also properly configured for RDS. For example, if there are two UPN suffixes `contoso.com` and `fabrikam.com`, the certificate must have `enterpriseregistration.contoso.com` and `enterpriseregistration.fabrikma.com` as the Subject Alternative Names (SANs).

To check if the SSL certificate has the correct SANs, follow these steps:

1. List all the UPN suffixes being used in the organization by running the following command:

   ```powershell
   Get-AdfsDeviceRegistratrionUpnSuffix
   ```

2. Verify if the SSL certificate has the required SANs configured.
3. If SSL certificate does not have the correct DRS names as SANs, get a new SSL certificate that has the correct SANs for DRS, and then use it as the SSL certificate for AD FS.

Then, check the certificate configuration on WAP servers and the fallback bindings:

- Check if the correct SSL certificate is set on all WAP servers.
  1. Make sure that the SSL certificate is installed in the **Personal** store for the local computer on each WAP server.
  2. Get the SSL certificate used by WAP by running the following command:

     ```powershell
     Get-WebApplicationProxySslCertificate
     ```

  3. If the SSL certificate is wrong, set the correct SSL certificate by running the following command:  

     ```powershell
     Set-WebApplicationProxySslCertificate -Thumbprint Thumbprint
     ```

- Check the certificate bindings and update them if necessary.
  
  To support non-SNI cases, administrators may specify fallback bindings. Other than the standard federationservicename:443 binding, look for fallback bindings under the following application IDs:
  
  - \{5d89a20c-beab-4389-9447-324788eb944a\}: This is the application ID for AD FS.
  - \{f955c070-e044-456c-ac00-e9e4275b3f04\}: This is the application ID for Web Application Proxy.
  
  For example, if the SSL certificate is specified for a fallback binding like 0.0.0.0:443, make sure that the binding is updated accordingly when the SSL certificate gets updated.

#### All users are impacted by the issue, and the user can access some of the relying parties

First, let's get the relying party and OAuth client information. If you use a conventional relying party, follow these steps:

1. On the primary AD FS server, open Windows PowerShell with the **Run as administrator** option.
2. Add the AD FS 2.0 component to Windows PowerShell by running the following command:

   ```powershell
   Add-PSSnapin Microsoft.Adfs.PowerShell
   ```

3. Get the relying party information by running the following command:

   ```powershell
   $rp = Get-AdfsRelyingPartyTrust RPName
   ```

4. Get the OAuth client information by running the following command:

   ```powershell
   $client = Get-AdfsClient ClientName
   ```

If you use the Application Group feature in Windows Server 2016, follow the steps below:

1. On the primary AD FS server, open Windows PowerShell with the **Run as administrator** option.
2. Get the relying party information by running the following command:  
`$rp = Get-AdfsWebApiApplication ResourceID`
3. If the OAuth client is public, get the client information by running the following command:

   ```powershell
   $client = Get-AdfsNativeClientApplication ClientName
   ```

   If the client is confidential, get the client information by running the following command:

   ```powershell
   $client = Get-AdfsServerApplication ClientName
   ```

Now continue with the following troubleshooting methods.

##### Check the settings of the relying party and client

The relying party identifier, client ID and redirect URI should be provided by the owner of the application and the client. However, there could still be a mismatch between what the owner provides and what are configured in AD FS. For example, a mismatch could be caused by a typo. Check if the settings provided by the owner match those configured in AD FS. The steps in the previous page get you the settings configured in AD FS via PowerShell.

|Settings provided by the owner|Settings configured in AD FS|
|---|---|
|Relying party ID|$rp.Identifier|
|Relying party redirect URI|A prefix or wildcard match of<br /><ul><li>$rp.WSFedEndpoint for a WS-Fed relying party</li><li>$rp.SamlEndpoints for a SAML relying party</li></ul>|
|Client ID|$client.ClientId|
|Client redirect URI|A prefix match of $client.RedirectUri|

If items in the table matches, additionally check if these settings match between what they appear in the authentication request sent to AD FS and what are configured in AD FS. Try reproducing the issue during which you capture a Fiddler trace on the authentication request sent by the application to AD FS. Examine the request parameters to do the following checks depending on the request type.

###### OAuth requests

An OAuth request looks like the following:

`https://sts.contoso.com/adfs/oauth2/authorize?response_type=code&client_id=ClientID&redirect_uri=https://www.TestApp.com&resource=https://www.TestApp.com`

Check if the request parameters match the settings configured in AD FS.

|Request parameters|Settings configured in AD FS|
|---|---|
|client_id|$client.ClientId|
|redirect_uri|A prefix match of @client_RedirectUri|

The "resource" parameter should represent a valid relying party in AD FS. Get the relying party information by running one of the following commands.

- If you use a conventional relying party, run the following command:  
`Get-AdfsRelyingPartyTrust -Identifier "ValueOfTheResourceParameter"`
- If you use the Application Group feature in Windows Server 2016, run the following command:  
`Get-AdfsWebApiApplication "ValueOfTheResourceParameter"`

###### WS-Fed requests

A WS-Fed request looks like the following:

`https://fs.contoso.com/adfs/ls/?wa=wsignin1.0&wtrealm=https://claimsweb.contoso.com&wctx=rm=0&id=passive&ru=/&wct=2014-10-21T22:15:42Z`

Check if the request parameters match the settings configured in AD FS:

|Request parameters|Settings configured in AD FS|
|---|---|
|wtrealm|$rp.Identifier|
|wreply|A prefix match or wildcard match of $rp.WSFedEndpoint|

###### SAML requests

A SAML request looks like the following:

`https://sts.contoso.com/adfs/ls/?SAMLRequest=EncodedValue&RelayState=cookie:29002348&SigAlg=http://www.w3.org/2000/09/Fxmldsig#rsa-sha1&Signature=Signature`

Decode the value of the SAMLRequest parameter by using the "From DeflatedSAML" option in the Fiddler Text Wizard. The decoded value looks like the following:

```xml
<samlp:AuthnRequest ID="ID" Version="2.0" IssueInstant="2017-04-28T01:02:22.664Z" Destination="https://TestClaimProvider-Samlp-Only/adfs/ls" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified" ForceAuthn="true" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"><Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">http://fs.contoso.com/adfs/services/trust</Issuer><samlp:NameIDPolicy Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" AllowCreate="true" /></samlp:AuthnRequest>
```

Do the following checks within the decoded value:

- Check if the host name in the value of Destination matches the AD FS host name.
- Check if the value of Issuer matches `$rp.Identifier`.

Additional notes for SAML:

- $rp.SamlEndpoints: Shows all types of SAML endpoints. The response from AD FS is sent to the corresponding URLs configured in the endpoints. A SAML endpoint can use redirect, post or artifact bindings for message transmission. All these URLs can be configured in AD FS.
- $rp.SignedSamlRequestsRequired: If the value is set, the SAML request sent from the relying party needs to be signed. The "SigAlg" and "Signature" parameters need to be present in the request.
- $rp.RequestSigningCertificate: This is the signing certificate used to generate the signature on the SAML request. Make sure that the certificate is valid and ask the application owner to match the certificate.

##### Check the encryption certificate

If `$rp.EncryptClaims` returns **Enabled**, relying party encryption is enabled. AD FS uses the encryption certificate to encrypt the claims. Do the following checks:

- $rp.EncryptionCertificate: Use this command to get the certificate and check if it is valid.
- $rp. EncryptionCertificateRevocationCheck: Use this command to check if the certificate meets the revocation check requirements.

##### The previous two methods don't work

To continue the troubleshooting, see [Use the Dump Token app](#use-the-dump-token-app).

#### Not all users are impacted by the issue, and the user can't access any of the relying parties

In this scenario, do the following checks.

##### Check if the user is disabled

Check the user status in Windows PowerShell or the UI. If the user is disabled, enable the user.

###### Check the user status with Windows PowerShell

1. Log in to any of the domain controllers.
2. Open Windows PowerShell.
3. Check the user status by running the following command:

   ```powershell
   Get-ADUser -Identity <samaccountname of the user> | Select Enabled
   ```

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/get-enabled-aduser.png" alt-text="Use the Get-ADUser command to check the user enabled status.":::

###### Check the user status in the UI

1. Log in to any of the domain controllers.
2. Open the **Active Directory Users and Computers** management console.
3. Click the **Users** node, right-click the user in the right pane, and then click **Properties**.
4. Click the **Account** tab.
5. Under **Account options**, verify if **Account is disabled** is checked.

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/account-is-disabled.png" alt-text="Double check whether the Account is disabled option is checked.":::

6. If the option is checked, uncheck it.

##### Check if the user properties were updated recently

If any property of the user is updated in the Active Directory, it results in a change in the metadata of the user object. Check the user metadata object to see which properties were updated recently. If changes are found, make sure that they are picked up by the related services. To check if there were property changes to a user, following these steps:

1. Log in to a domain controller.
2. Open Windows PowerShell.
3. Get the metadata of the user object by running the following command:  
   `repadmin /showobjmeta <destination DC> "user DN"`

   An example of the command is:  
   `repadmin /showobjmeta localhost "CN=test user,CN=Users,DC=fabidentity,DC=com"`
4. In the metadata, examine the Time/Date column for each attribute for any clue to a change. In the following example, the userPrincipleName attribute takes a newer date than the other attributes which represents a change to the user object metadata.

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/repadmin-showobjmeta.png" alt-text="Output of the repadmin showobjmeta command." border="false":::

##### Check the forest trust if the user belongs to another forest

In a multi-forest AD FS environment, a two-way forest trust is required between the forest where AD FS is deployed and the other forests which utilize the AD FS deployment for authentication. To verify if the trust between the forests is working as expected, follow these steps:

1. Log in to a domain controller in the forest where AD FS is deployed.
2. Open the **Active Directory Domains and Trusts** management console.
3. In the management console, right-click the domain that contains the trust that you want to verify, and then click **Properties**.
4. Click the **Trusts** tab.
5. Under **Domains trusted by this domain (outgoing trusts)** or **Domains that trust this domain (incoming trusts)**, click the trust to be verified, and then click **Properties**.
6. Click **Validate**.  
   In the **Active Directory Domain Services** dialog box, select either of the options.

   - If you select **No**, we recommend that you repeat the same procedure for the reciprocal domain.
   - If you select **Yes**, provide an administrative user credential for the reciprocal domain. There is no need to perform the same procedure for the reciprocal domain.

     :::image type="content" source="media/troubleshoot-adfs-sso-issue/adds-validate-incoming-trust.png"  alt-text="Validate the incoming trust in the Active Directory Domain Services dialog box." border="false":::

If these steps did not help you solve the issue, continue the troubleshooting with the steps in the [Not all users are impacted by the issue, and the user can access some of the relying parties](#not-all-users-are-impacted-by-the-issue-and-the-user-can-access-some-of-the-relying-parties) section.

#### Not all users are impacted by the issue, and the user can access some of the relying parties

In this scenario, check if this issue occurs in a Microsoft Entra scenario. If so, do these checks to troubleshoot this issue. If not, see [Use the Dump Token app](#use-the-dump-token-app) to troubleshoot this issue.

<a name='check-if-the-user-is-synced-to-azure-ad'></a>

##### Check if the user is synced to Microsoft Entra ID

If a user is trying to log in to Microsoft Entra ID, they will be redirected to AD FS for authentication for a federated domain. One of the possible reasons for a failed login is that the user is not yet synced to Microsoft Entra ID. You might see a loop from Microsoft Entra ID to Active Directory FS after the first authentication attempt at AD FS. To determine whether the user is synced to Microsoft Entra ID, follow these steps:

1. [Download](https://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185) and install the Azure AD PowerShell module for Windows PowerShell.
1. Open Windows PowerShell with the "Run as administrator" option.
1. Initiate a connection to Microsoft Entra ID by running the following command:  
`Connect-MsolService`
1. Provide the global administrator credential for the connection.
1. Get the list of users in the Microsoft Entra ID by running the following command:  
`Get-MsolUser`
1. Verify if the user is in the list.

If the user is not in the list, sync the user to Microsoft Entra ID.

##### Check immutableID and UPN in issuance claim rule

Microsoft Entra ID requires immutableID and the user's UPN to authenticate the user.

> [!NOTE]
> immutableID is also called sourceAnchor in the following tools:
>
> - Azure AD Sync
> - Azure Active Directory Sync (DirSync)

Administrators can use Microsoft Entra Connect for automatic management of AD FS trust with Microsoft Entra ID. If you are not managing the trust via Microsoft Entra Connect, we recommend that you do so by [downloading Microsoft Entra Connect](https://go.microsoft.com/fwlink/?LinkId=615771) Microsoft Entra Connect enables automatic claim rules management based on sync settings.

To check if the claim rules for immutableID and UPN in AD FS matches what Microsoft Entra ID uses, follow these steps:

1. Get sourceAnchor and UPN in Microsoft Entra Connect.

   1. Open Microsoft Entra Connect.
   2. Click **View current configuration**.

      :::image type="content" source="media/troubleshoot-adfs-sso-issue/microsoft-azure-active-directory-connect.png"  alt-text="Select the View current configuration in the Microsoft Entra Connect additional tasks page." border="false":::

   3. On the **Review Your Solution** page, make a note of the values of **SOURCE ANCHOR** and **USER PRINCIPAL NAME**.

      :::image type="content" source="media/troubleshoot-adfs-sso-issue/azure-active-directory-connect.png"  alt-text="Get the values of SOURCE ANCHOR and USER PRINCIPAL NAME in the Microsoft Entra Connect page.":::

2. Verify the values of immutableID (sourceAnchor) and UPN in the corresponding claim rule configured in the AD FS server.

   1. On the AD FS server, open the AD FS management console.
   2. Click **Relying Party Trusts**.
   3. Right-click the relying party trust with Microsoft Entra ID, and then click **Edit Claim Issuance Policy**.
   4. Open the claim rule for immutable ID and UPN.
   5. Verify if the variables queried for values of immutableID and UPN are the same as those appear in Microsoft Entra Connect.

      :::image type="content" source="media/troubleshoot-adfs-sso-issue/edit-rule-issue-upn-and-immutableid.png" alt-text="Verify the values of immutableID and UPN in the corresponding claim rule configured in the A D F S server.":::

3. If there is a difference, use one of the methods below:

   - If AD FS is managed by Microsoft Entra Connect, reset the relying party trust by using Microsoft Entra Connect.
   - If AD FS is not managed by Microsoft Entra Connect, correct the claims with the right attributes.

If these checks did not help you solve the issue, see [Use the Dump Token app](#use-the-dump-token-app) to troubleshoot this issue.

### This issue occurs at the application side

If the token signing certificate was renewed recently by AD FS, check if the new certificate is picked up by the federation partner. In case AD FS uses a token decrypting certificate that was also renewed recently, do the same check as well. To check if the current AD FS token signing certificate on AD FS matches the one on the federation partner, follow these steps:

1. Get the current token signing certificate on AD FS by running the following command:

   ```powershell
   Get-ADFSCertificate -CertificateType token-signing
   ```

2. In the list of certificates returned, find the one with **IsPrimary = TRUE**, and make a note of the thumbprint.
3. Get the thumbprint of the current token signing certificate on the federation partner. The application owner needs to provide you this.
4. Compare the thumbprints of the two certificates.

Do the same check if AD FS uses a renewed token decrypting certificate, except that the command to get the token decrypting certificate on AD FS is as follows:

```powershell
Get-ADFSCertificate -CertificateType token-decrypting
```

#### The thumbprints of the two certificates match

If the thumbprints match, ensure the partners are using the new AD FS certificates.

If there are certificate mismatches, ensure that the partners are using the new certificates. Certificates are included in the federation metadata published by the AD FS server.

> [!NOTE]
> The partners refer to all your resource organization or account organization partners, represented in your AD FS by relying party trusts and claims provider trusts.

- The partners can access the federation metadata

  If the partners can access the federation metadata, ask the partners to use the new certificates.

- The partners can't access the federation metadata

  In this case, you must manually send the partners the public keys of the new certificates. To do this, follow these steps:
  1. Export the public keys as .cert files, or as .p7b files to include the entire certificate chains.
  2. Send the public keys to the partners.
  3. Ask the partners to use the new certificates.

#### The thumbprints of the two certificates don't match

Then, check if there is a token-signing algorithm mismatch. To do this, follow these steps:

1. Determine the algorithm used by the relying party by running the following command:

   ```powershell
   Get-ADFSRelyingPartyTrust -Name RPName | FL SignatureAlgorithm
   ```  

   The possible values are SHA1 or SHA256.

2. Check with the application owner for the algorithm used on the application side.
3. Check if the two algorithms match.

If the two algorithms match, check if the Name ID format matches what the application requires.

1. On the AD FS server, dump the issuance transform rules by running the following command:

   ```powershell
   (Get-AdfsRelyingPartyTrust -Name RPName).IssuanceTransformRules
   ```

2. Locate the rule that issues the NameIdentifier claim. If such a rule doesn't exist, skip this step.  

   Here is an example of the rule:

   `c:[Type == "http://schemas.microsoft.com/LiveID/Federation/2008/05/ImmutableID"] => issue(Type = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier", Value = c.Value, Properties["http://schemas.xmlsoap.org/ws/2005/05/identity/claimproperties/format"] = "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified");`  

   Notice the NameIdentifier format in the following syntax:  

   `Properties["Property-type-URI"] = "ValueURI"`

   The possible formats are listed below. The first format is the default.

   - urn:oasis:names:tc:SAML:1.1:nameid-format:unspecifie.
   - urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress
   - urn:oasis:names:tc:SAML:2.0:nameid-format:persistent
   - urn:oasis:names:tc:SAML:2.0:nameid-format:transient

3. Ask the application owner for the NameIdentifier format required by the application.
4. Verify if the two NameIdentifier formats match.
5. If the formats don't match, configure the NameIdentifier claim to use the format that the application requires. To do this, follow these steps:

   1. Open the AD FS management console.
   2. Click **Relying Party Trusts**, select the appropriate federation partner, and then click **Edit Claims Issuance Policy** in the **Actions** pane.
   3. Add a new rule if there is no rule to issue the NameIdentifier claim, or update an existing rule. Select **Name ID** for **Incoming claim type**, and then specify the format that the application requires.

   :::image type="content"  source="media/troubleshoot-adfs-sso-issue/add-transform-claim-rule-wizard.png" alt-text="Add a transform claim rule if there is no rule to issue the NameIdentifier claim, or update an existing rule.":::

If the two algorithms mismatch, update the signing algorithm used by the relying party trust.

1. Open the AD FS management console.
2. Right-click the relying party trust, and then click **Properties**.
3. On the **Advanced** tab, select the algorithm to match what the application requires.

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/urndumptoken-properties.png" alt-text="Select the algorithm to match what the application requires under the Advanced tab in the Properties setting dialog box.":::

#### About certificate auto renewal

If the token signing certificate or token decrypting certificate are self-signed, AutoCertificateRollover is enabled by default on these certificates and AD FS manages the auto renewal of the certificates when they are close to expiration.

To determine if you're using self-signed certificates, follow these steps:

1. Run the following command:

   ```powershell
   Get-ADFSCerticate -CertificateType "token-signing"
   ```

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/get-adfscertificate.png" alt-text="Run the Get-ADFSCerticate cmdlet, Certificate Type token-signing." border="false":::

2. Examine the certificate attributes.  

   If the Subject and Issuer attributes both start with "CN=ADFS Signing...", the certificate is self-signed and managed by AutoCertRollover.

To confirm if the certificates renew automatically, follow these steps:

1. Run the following command:

   ```powershell
   Get-ADFSProperties | FL AutoCertificateRollover
   ```

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/get-adfsproperties-autocertificaterollover.png" alt-text="Run the Get-ADFSProperties cmdlet to confirm if the certificates renew automatically." border="false":::

2. Examine the AutoCertificateRollover attribute.

   - If **AutoCertificateRollover = TRUE**, AD FS automatically generates new certificates (30 days prior to expiration by default) and sets them as the primary certificates (25 days prior to expiration).
   - If **AutoCertificateRollover = FALSE**, you need to manually replace the certificates.

## Check the ADFS-related components and services

This article introduces how to check the ADFS-related components and services. These steps could help when you are troubleshooting sign-on (SSO) issues with Active Directory Federation Services (ADFS).

### Check DNS

Accessing ADFS should point directly to one of the WAP (Web Application Proxy) servers or the load balancer in front of the WAP servers. Do the following checks:

- Ping the federation service name (e.g. `fs.contoso.com`). Confirm if the IP address the Ping resolves to is of one of the WAP servers or of the load balancer of the WAP servers.
- Check if there is an A record for the federation service in the DNS server. The A record should point to one of the WAP servers or to the load balancer of the WAP servers.

If WAP is not implemented in your scenario for external access, check if accessing ADFS points directly to one of the ADFS servers or the load balancer in front of the ADFS servers:

- Ping the federation service name (e.g. `fs.contoso.com`). Confirm if the IP address that you get resolves to one of the ADFS servers or the load balancer of the ADFS servers.
- Check if there is an A record for the federation service in the DNS server. The A record should point to one of the ADFS servers or to the load balancer of the ADFS servers.

### Check the load balancer if it is used

Check if firewall is blocking traffic between:

- The ADFS server and the load balancer.
- The WAP (Web Application Proxy) server and the load balancer if WAP is used.

If probe is enabled on the load balancer, check the following:

- If you are running Windows Server 2012 R2, ensure that the [August 2014 update rollup](https://support.microsoft.com/help/2975719/august-2014-update-rollup-for-windows-rt-8.1,-windows-8.1,-and-windows-server-2012-r2) is installed.
- Check if port 80 is enabled in the firewall on the WAP servers and ADFS servers.
- Ensure that probe is set for port 80 and for the endpoint /adfs/probe.

### Check the firewall settings

Check if inbound traffic through TCP port 443 is enabled on:

- the firewall between the Web Application Proxy server and the federation server farm.
- the firewall between the clients and the Web Application Proxy server.

Check if inbound traffic through TCP port 49443 is enabled on the firewall between the clients and the Web Application Proxy server when the following conditions are true:

- TLS client authentication using X.509 certificate is enabled.
- You are using ADFS on Windows Server 2012 R2.  
  
> [!NOTE]
> The configuration is not required on the firewall between the Web Application Proxy server and the federation servers.

### Check if the endpoint is enabled on the proxy

ADFS provides various endpoints for different functionalities and scenarios. Not all endpoints are enabled by default. To check the whether the endpoint is enabled on the proxy, following these steps:

1. On the ADFS server, open the ADFS Management Console.
2. Expand **Service** > **Endpoints**.
3. Locate the endpoint and verify if the status is enabled on the **Proxy Enabled** column.

   :::image type="content" source="media/troubleshoot-adfs-sso-issue/adfs-endpoints.png" alt-text="Verify the A D F S endpoints status shown on the Proxy Enabled column.":::

## Check the proxy trust relationship

If Web Application Proxy (WAP) is deployed, the proxy trust relationship must be established between the WAP server and the AD FS server. Check if the proxy trust relationship is established or starts to fail at some point in time.

> [!NOTE]
> Information on this page applies to AD FS 2012 R2 and later.

### Background information

The proxy trust relationship is client certificate based. When you run the Web Application Proxy post-install wizard, the wizard generates a self-signed client certificate using the credentials that you specified in the wizard. Then the wizard inserts the certificate into the AD FS configuration database and adds it to the AdfsTrustedDevices certificate store on the AD FS server.

For any SSL communication, http.sys uses the following priority order for SSL certificate bindings to match a certificate:

|Priority|Name|Parameters|Description|
|---|---|---|---|
|1|IP|IP:port|Exact IP and Port match|
|2|SNI|Hostname:port|Exact hostname match (connection must specify SNI)|
|3|CCS|Port|Invoke Central Certificate Store|
|4|IPv6 wildcard|Port|IPv6 wildcard match (connection must be IPv6)|
|5|IP wildcard|Port|IP wildcard match (connection can be IPv4 or IPv6)|

AD FS 2012 R2 and later are independent of Internet Information Services (IIS) and runs as a service on top of http.sys. hostname:port SSL certificate bindings are used by AD FS. During client certificate authentication, AD FS sends a certificate trust list (CTL) based on the certificates in the AdfsTrustedDevices store. If an SSL certificate binding for your AD FS server uses IP:port or the CTL store is not AdfsTrustedDevices, proxy trust relationship may not be established.

Get the SSL certificate bindings for AD FS

On the AD FS server, run the following command in Windows PowerShell:  
`netsh http show sslcert`

In the list of bindings returned, look for those with the Application ID of 5d89a20c-beab-4389-9447-324788eb944a. Here is an example of a healthy binding. Note the "Ctl Store Name" line.

```output
Hostname:port : adfs.contoso.com:443
Certificate Hash : 3638de9b03a488341dfe32fc3ae5c480ee687793
Application ID : {5d89a20c-beab-4389-9447-324788eb944a}
Certificate Store Name : MY
Verify Client Certificate Revocation : Enabled
Verify Revocation Using Cached Client Certificate Only : Disabled
Usage Check : Enabled
Revocation Freshness Time : 0
URL Retrieval Timeout : 0
Ctl Identifier : (null)  
Ctl Store Name : AdfsTrustedDevices
DS Mapper Usage : Disabled
Negotiate Client Certificate : Disabled
```

### Run script to automatically detect problems

To automatically detect problems with the proxy trust relationship, run the following script. Based on the problem detected, take the action accordingly.

```powershell
param
(
  [switch]$syncproxytrustcerts
)
function checkhttpsyscertbindings()
{
Write-Host; Write-Host("1 – Checking http.sys certificate bindings for potential issues")
$httpsslcertoutput = netsh http show sslcert
$adfsservicefqdn = (Get-AdfsProperties).HostName
$i = 1
$certbindingissuedetected = $false
While($i -lt $httpsslcertoutput.count)
{
        $ipport = $false
        $hostnameport = $false
        if ( ( $httpsslcertoutput[$i] -match "IP:port" ) ) { $ipport = $true }
        elseif ( ( $httpsslcertoutput[$i] -match "Hostname:port" ) ) { $hostnameport = $true }
        ## Check for IP specific certificate bindings
        if ( ( $ipport -eq $true ) )
        {
            $httpsslcertoutput[$i]
            $ipbindingparsed = $httpsslcertoutput[$i].split(":")
            if ( ( $ipbindingparsed[2].trim() -ne "0.0.0.0" ) -and ( $ipbindingparsed[3].trim() -eq "443") )
            {
                $warning = "There is an IP specific binding on IP " + $ipbindingparsed[2].trim() + " which may conflict with the AD FS port 443 cert binding." | Write-Warning
                $certbindingissuedetected = $true
            }
            $i = $i + 14
            continue
        }
        ## check that CTL Store is set for ADFS service binding
        elseif ( $hostnameport -eq $true )
        {
            $httpsslcertoutput[$i]
            $ipbindingparsed = $httpsslcertoutput[$i].split(":")
            If ( ( $ipbindingparsed[2].trim() -eq $adfsservicefqdn ) -and ( $ipbindingparsed[3].trim() -eq "443") -and ( $httpsslcertoutput[$i+10].split(":")[1].trim() -ne "AdfsTrustedDevices" ) )
            {
                Write-Warning "ADFS Service binding does not have CTL Store Name set to AdfsTrustedDevices"
                $certbindingissuedetected = $true
            }
        $i = $i + 14
        continue
        }
    $i++
}
If ( $certbindingissuedetected -eq $false ) { Write-Host "Check Passed: No certificate binding issues detected" }
}
function checkadfstrusteddevicesstore()
{
## check for CA issued (non-self signed) certs in the AdfsTrustedDevices cert store
Write-Host; Write-Host "2 – Checking AdfsTrustedDevices cert store for non-self signed certificates"
$certlist = Get-Childitem cert:\LocalMachine\AdfsTrustedDevices -recurse | Where-Object {$_.Issuer -ne $_.Subject}
If ( $certlist.count -gt 0 )
{
    Write-Warning "The following non-self signed certificates are present in the AdfsTrustedDevices store and should be removed"
    $certlist | Format-List Subject
}
Else { Write-Host "Check Passed: No non-self signed certs present in AdfsTrustedDevices cert store" }
}
function checkproxytrustcerts
{
    Param ([bool]$repair=$false)
    Write-Host; Write-Host("3 – Checking AdfsTrustedDevices cert store is in sync with ADFS Proxy Trust config")
    $doc = new-object Xml
    $doc.Load("$env:windir\ADFS\Microsoft.IdentityServer.Servicehost.exe.config")
    $connString = $doc.configuration.'microsoft.identityServer.service'.policystore.connectionString
    $command = "Select ServiceSettingsData from [IdentityServerPolicy].[ServiceSettings]"
    $cli = new-object System.Data.SqlClient.SqlConnection
    $cli.ConnectionString = $connString
    $cmd = new-object System.Data.SqlClient.SqlCommand
    $cmd.CommandText = $command
    $cmd.Connection = $cli
    $cli.Open()
    $configString = $cmd.ExecuteScalar()
    $configXml = new-object XML
    $configXml.LoadXml($configString)
    $rawCerts = $configXml.ServiceSettingsData.SecurityTokenService.ProxyTrustConfiguration._subjectNameIndex.KeyValueOfstringArrayOfX509Certificate29zVOn6VQ.Value.X509Certificate2
    #$ctl = dir cert:\LocalMachine\ADFSTrustedDevices
    $store = new-object System.Security.Cryptography.X509Certificates.X509Store("ADFSTrustedDevices","LocalMachine")
    $store.open("MaxAllowed")
    $atLeastOneMismatch = $false
    $badCerts = @()
    foreach($rawCert in $rawCerts)
    {   
        $rawCertBytes = [System.Convert]::FromBase64String($rawCert.RawData.'#text')
        $cert=New-Object System.Security.Cryptography.X509Certificates.X509Certificate2(,$rawCertBytes)
        $now = Get-Date
        if ( ($cert.NotBefore -lt $now) -and ($cert.NotAfter -gt $now))
        {
            $certThumbprint = $cert.Thumbprint
         $certSubject = $cert.Subject
         $ctlMatch = dir cert:\localmachine\ADFSTrustedDevices\$certThumbprint -ErrorAction SilentlyContinue
         if ($ctlMatch -eq $null)
         {
       $atLeastOneMismatch = $true
          Write-Warning "This cert is NOT in the CTL: $certThumbprint – $certSubject"
       if ($repair -eq $true)
       {
        write-Warning "Attempting to repair"
        $store.Add($cert)
        Write-Warning "Repair successful"
       }
                else
                {
                    Write-Warning ("Please install KB.2964735 or re-run script with -syncproxytrustcerts switch to add missing Proxy Trust certs to AdfsTrustedDevices cert store")
                }
         }
        }
    }
    $store.Close()
    if ($atLeastOneMismatch -eq $false)
    {
     Write-Host("Check Passed: No mismatched certs found. CTL is in sync with DB content")
    }
}
checkhttpsyscertbindings
checkadfstrusteddevicesstore
checkproxytrustcerts($syncproxytrustcerts)
Write-Host; Write-Host("All checks completed.")
```

### Problem 1: There is an IP specific binding

The binding may conflict with the AD FS certificate binding on port 443.

The IP:port binding takes the highest precedence. If an IP:port binding is in the AD FS SSL certificate bindings, http.sys always uses the certificate for the binding for SSL communication. To solve this problem, use the following methods.

1. Remove the IP:port binding

   Be aware that the IP:port binding may come back after you removed it. For example, an application configured with this IP:port binding may automatically recreate it on the next service start-up.

2. Use another IP address for AD FS SSL communication

   If the IP:port binding is required, resolve the ADFS service FQDN to another IP address that is not used in any bindings. That way, http.sys will use the Hostname:port binding for SSL communication.

3. Set AdfsTrustedDevices as the CTL Store for the IP:port binding

   This is the last resort if you can't use the methods above. But it is better to understand the following conditions before you change the default CTL store to AdfsTrustedDevices:

   - Why the IP:port binding is there.
   - If the binding relies on the default CTL store for client certificate authentication.

### Problem 2: The AD FS certificate binding doesn't have CTL Store Name set to AdfsTrustedDevices

If Microsoft Entra Connect is installed, use Microsoft Entra Connect to set CTL Store Name to AdfsTrustedDevices for the SSL certificate bindings on all AD FS servers. If Microsoft Entra Connect is not installed, regenerate the AD FS certificate bindings by running the following command on all AD FS servers.

```powershell
Set-AdfsSslCertificate -Thumbprint Thumbprint
```

### Problem 3: A certificate that is not self-signed exists in the AdfsTrustedDevices certificate store

If a CA issued certificate is in a certificate store where only self-signed certificates would normally exist, the CTL generated from the store would only contain the CA issued certificate. The AdfsTrustedDevices certificate store is such a store that is supposed to have only self-signed certificates. These certificates are:

- MS-Organization-Access: The self-signed certificate used for issuing workplace join certificates.
- ADFS Proxy Trust: The certificates for each Web Application Proxy server.

:::image type="content" source="media/troubleshoot-adfs-sso-issue/adfs-certificate.png"  alt-text="The certificates for each Web Application Proxy server.":::

Therefore, delete any CA issued certificate from the AdfsTrustedDevices certificate store.

### Problem 4: Install KB2964735 or re-run the script with -syncproxytrustcerts

When a proxy trust relationship is established with an AD FS server, the client certificate is written to the AD FS configuration database and added to the AdfsTrustedDevices certificate store on the AD FS server. For an AD FS farm deployment, the client certificate is expected to be synced to the other AD FS servers. If the sync doesn't happen for some reason, a proxy trust relationship will only work against the AD FS server the trust was established with, but not against the other AD FS servers.

To solve this problem, use one of the following methods.

#### Method 1

Install the update documented in [KB 2964735](https://support.microsoft.com/topic/700e0502-c19a-54e4-9c5f-65c2844d9a9f) on all AD FS servers. After the update is installed, a sync of the client certificate is expected to happen automatically.

#### Method 2

Run the script with the – syncproxytrustcerts switch to manually sync the client certificates from the AD FS configuration database to the AdfsTrustedDevices certificate store. The script should be run on all the AD FS servers in the farm.

> [!NOTE]
> This is not a permanent solution because the client certificates will be renewed on a regular basis.

### Problem 5: All checks are passed. But the problem persists

Check if there is a time or time zone mismatch. If time matches but the time zone doesn't, proxy trust relationship will also fail to be established.

Check if there is SSL termination between the AD FS server and the WAP server

If SSL termination is happening on a network device between AD FS servers and the WAP server, communication between AD FS and WAP will break because the communication is based on client certificate.

Disable SSL termination on the network device between the AD FS and WAP servers.

## Use the Dump Token app

The Dump Token app is helpful when debugging problems with your federation service as well as validating custom claim rules. It is not an official solution but a good independent debugging solution that is recommended for the troubleshooting purposes.

### Before using the Dump Token app

Before using the Dump Token app, you need to:

1. Get the information of the relying party for the application you want to access. If OAuth authentication is implemented, get the OAuth client information as well.
2. Set up the Dump Token app.

### Get the relying party and OAuth client information

If you use a conventional relying party, follow these steps:

1. On the AD FS server, open Windows PowerShell with the **Run as administrator** option.
2. Add the AD FS 2.0 component to Windows PowerShell by running the following command:

   ```powershell
   Add-PSSnapin Microsoft.Adfs.PowerShell
   ```

3. Get the relying party information by running the following command:

   ```powershell
   $rp = Get-AdfsRelyingPartyTrust RPName
   ```

4. Get the OAuth client information by running the following command:

   ```powershell
   $client = Get-AdfsClient ClientName
   ```

If you use the Application Group feature in Windows Server 2016, follow the steps below:

1. On the AD FS server, open Windows PowerShell with the **Run as administrator** option.
2. Get the relying party information by running the following command:

   ```powershell
   $rp = Get-AdfsWebApiApplication ResourceID
   ```

3. If the OAuth client is public, get the client information by running the following command:

   ```powershell
   $client = Get-AdfsNativeClientApplication ClientName
   ```

   If the OAuth client is confidential, get the client information by running the following command:

   ```powershell
   $client = Get-AdfsServerApplication ClientName
   ```

### Set up the Dump Token app

To set up the Dump Token app, run the following commands in the Windows PowerShell window:

```powershell
$authzRules = "=>issue(Type = `"http://schemas.microsoft.com/authorization/claims/permit`", Value = `"true`");"
$issuanceRules = "x:[]=>issue(claim=x);"
$redirectUrl = "https://dumptoken.azurewebsites.net/default.aspx"
$samlEndpoint = New-AdfsSamlEndpoint -Binding POST -Protocol SAMLAssertionConsumer -Uri $redirectUrl
Add-ADFSRelyingPartyTrust -Name "urn:dumptoken" -Identifier "urn:dumptoken" -IssuanceAuthorizationRules $authzRules -IssuanceTransformRules $issuanceRules -WSFedEndpoint $redirectUrl -SamlEndpoint $samlEndpoint
```

Now continue with the following troubleshooting methods. At the end of each method, see if the problem is solved. If not, use another method.

### Troubleshooting methods

#### Check the authorization policy to see if the user is impacted

In this method, you start by getting the policy details, and then use the Dump Token app to diagnose the policy to see if the user is impacted.

##### Get the policy details

$rp.IssuanceAuthorizationRules shows the authorization rules of the relying party.

In Windows Server 2016 and later versions, you can use $rp. AccessControlPolicyName to configure authentication and authorization policy. If $rp. AccessControlPolicyName has value, an access control policy is in place which governs the authorization policy. In that case, $rp.IssuanceAuthorizationRules is empty. Use $rp.ResultantPolicy to find out details about the access control policy.

If $rp.ResultantPolicy doesn't have the details about the policy, look into the actual claim rules. To get the claim rules, follow these steps:

1. Set the access control policy to $null by running the following command:  
   `Set-AdfsRelyingPartyTrust -TargetRelyingParty $rp -AccessControlPolicyName $null`
2. Get the relying party information by running the following command:  
   `$rp = Get-AdfsRelyingPartyTrust RPName`
3. Check `$rp.IssuanceAuthorizationRules` and `$rp. AdditionalAuthenticationRules`.

##### Use the Dump Token app to diagnose the authorization policy

1. Set the Dump Token authentication policy to be the same as the failing relying party.
2. Have the user open one of the following links depending on the authentication policy you set.

   - WS-Fed: `https://FederationInstance/adfs/ls?wa=wsignin1.0&wtrealm=urn:dumptoken`
   - SAML-P: `https://FederationInstance/adfs/ls/IdpInitiatedSignOn?LoginToRP=urn:dumptoken`
   - Force multi-factor authentication: `https://FederationInstance/adfs/ls?wa=wsignin1.0&wtrealm=urn:dumptoken&wauth=http://schemas.microsoft.com/claims/multipleauthn`

3. Log in on the Sign-In page.

What you get is the set of claims of the user. See if there is anything in the authorization policy that explicitly denies or allows the user based on these claims.

#### Check if any missing or unexpected claim causes access deny to the resource

1. Configure the claim rules in the Dump Token app to be the same as the claim rules of the failing relying party.
2. Configure the Dump Token authentication policy to be the same as the failing relying party.
3. Have the user open one of the following links depending on the authentication policy you set.

   - WS-Fed: `https://FederationInstance/adfs/ls?wa=wsignin1.0&wtrealm=urn:dumptoken`
   - SAML-P: `https://FederationInstance/adfs/ls/IdpInitiatedSignOn?LoginToRP=urn:dumptoken`
   - Force multi-factor authentication: `https://FederationInstance/adfs/ls?wa=wsignin1.0&wtrealm=urn:dumptoken&wauth=http://schemas.microsoft.com/claims/multipleauthn`

4. Log in on the Sign-In page.

This is the set of claims the relying party is going to get for the user. If any claims are missing or unexpected, look at the issuance policy to find out the reason.

If all the claims are present, check with the application owner to see which claim is missing or unexpected.

#### Check if a device state is required

If the authorization rules check for device claims, verify if any of these device claims are missing in the list of claims you get from the Dump Token app. The missing claims could block device authentication. To get the claims from the Dump Token app, follow the steps in the **Use the Dump Token app to diagnose the authorization policy** section in the **Check authorization policy if the user was impacted** method.

The following are the device claims. The authorization rules may use some of them.

- `http://schemas.microsoft.com/2012/01/devicecontext/claims/registrationid`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/displayname`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/identifier`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/ostype`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/osversion`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/ismanaged`
- `http://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser`
- `http://schemas.microsoft.com/2014/02/devicecontext/claims/isknown`
- `http://schemas.microsoft.com/2014/02/deviceusagetime`
- `http://schemas.microsoft.com/2014/09/devicecontext/claims/iscompliant`
- `http://schemas.microsoft.com/2014/09/devicecontext/claims/trusttype`

If there is a missing claim, follow the steps in [Configure On-Premises Conditional Access using registered devices](/windows-server/identity/ad-fs/operations/configure-device-based-conditional-access-on-premises) to make sure the environment is setup for device authentication.

If all the claims are present, see if the values of the claims from the Dump Token app match the values required in the authorization policy.
