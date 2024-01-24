---
title: Troubleshoot AD FS issues
description: Describes how to troubleshoot authentication issues that may arise for federated users in Microsoft Entra ID or Office 365. Provides a comprehensive list of symptoms and their solutions.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, abizerh, fszita, meerak
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot, has-azure-ad-ps-ref
ms.subservice: active-directory
---
# Troubleshoot AD FS issues in Microsoft Entra ID and Office 365

This article discusses workflow troubleshooting for authentication issues for federated users in Microsoft Entra ID or Office 365.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3079872

## Symptoms

- Federated users can't sign in to Office 365 or Microsoft Azure even though managed cloud-only users who have a domainxx.onmicrosoft.com UPN suffix can sign in without a problem.
- Redirection to Active Directory Federation Services (AD FS) or STS doesn't occur for a federated user. Or, a "Page cannot be displayed" error is triggered.
- You receive a certificate-related warning on a browser when you try to authenticate with AD FS. Which states that certificate validation fails or that the certificate isn't trusted.
- "Unknown Auth method" error or errors stating that `AuthnContext` isn't supported. Also, errors at the AD FS or STS level when you're redirected from Office 365.
- AD FS throws an "Access is Denied" error.
- AD FS throws an error stating that there's a problem accessing the site; which includes a reference ID number.
- The user is repeatedly prompted for credentials at the AD FS level.
- Federated users can't authenticate from an external network or when they use an application that takes the external network route (Outlook, for example).
- Federated users can't sign in after a token-signing certificate is changed on AD FS.
- A "Sorry, but we're having trouble signing you in" error is triggered when a federated user signs in to Office 365 in Microsoft Azure. This error includes error codes such as 8004786C, 80041034, 80041317, 80043431, 80048163, 80045C06, 8004789A, or BAD request.

## Troubleshooting workflow

1. Access [Microsoft Office Home](https://login.microsoftonline.com/), and then enter the federated user's sign-in name (**someone**@**example**.**com**). After you press **Tab** to remove the focus from the login box, check whether the status of the page changes to **Redirecting** and then you're redirected to your Active Directory Federation Service (AD FS) for sign-in.

    When redirection occurs, you see the following page:

    :::image type="content" source="media/troubleshoot-ad-fs-issues/office-365-redirecting.png" alt-text="Page that is shown when the A D F S redirection occurs.":::

    1. If no redirection occurs and you're prompted to enter a password on the same page, which means that Microsoft Entra ID or Office 365 doesn't recognize the user or the domain of the user to be federated. To check whether there's a federation trust between Microsoft Entra ID or Office 365 and your AD FS server, run the `Get-msoldomain` cmdlet from Azure AD PowerShell. If a domain is federated, its authentication property will be displayed as **Federated**, as in the following screenshot:

        :::image type="content" source="media/troubleshoot-ad-fs-issues/federated-domain.png" alt-text="Cmdlet Get-msoldomain output shows that there is a federation trust between Microsoft Entra ID or Office 365 and your A D F S server.":::

    2. If redirection occurs but you aren't redirected to your AD FS server for sign-in, check whether the AD FS service name resolves to the correct IP and whether it can connect to that IP on TCP port 443.

        If the domain is displayed as **Federated**, obtain information about the federation trust by running the following commands:

        ```powershell
        Get-MsolFederationProperty -DomainName <domain>
        Get-MsolDomainFederationSettings -DomainName <domain>
        ```

        Check the URI, URL, and certificate of the federation partner that's configured by Office 365 or Microsoft Entra ID.

2. After you're redirected to AD FS, the browser may throw a certificate trust-related error, and for some clients and devices it may not let you establish an SSL (Secure Sockets Layer) session with AD FS. To resolve this issue, follow these steps:

    1. Make sure that the AD FS service communication certificate that's presented to the client is the same one that's configured on AD FS.

        :::image type="content" source="media/troubleshoot-ad-fs-issues/service-communications.png" alt-text="Make sure the A D F S service communication certificate is the same one that's configured on A D F S.":::

        Ideally, the AD FS service communication certificate should be the same as the SSL certificate that's presented to the client when it tries to establish an SSL tunnel with the AD FS service.

        In AD FS 2.0:

        - Bind the certificate to IIS->default first site.
        - Use the AD FS snap-in to add the same certificate as the service communication certificate.

        In AD FS 2012 R2:

        - Use the AD FS snap-in or the `Add-adfscertificate` command to add a service communication certificate.
        - Use the `Set-adfssslcertificate` command to set the same certificate for SSL binding.

    2. Make sure that AD FS service communication certificate is trusted by the client.
    3. If non-SNI-capable clients are trying to establish an SSL session with AD FS or WAP 2-12 R2, the attempt may fail. In this case, consider adding a Fallback entry on the AD FS or WAP servers to support non-SNI clients. For more information, see [How to support non-SNI capable clients with Web Application Proxy and AD FS 2012 R2](https://blogs.technet.com/b/applicationproxyblog/archive/2014/06/19/how-to-support-non-sni-capable-clients-with-web-application-proxy-and-ad-fs-2012-r2.aspx).

3. You may meet an "Unknown Auth method" error or errors stating that `AuthnContext` isn't supported at the AD FS or STS level when you're redirected from Office 365. It's most common when redirect to the AD FS or STS by using a parameter that enforces an authentication method. To enforce an authentication method, use one of the following methods:
   - For WS-Federation, use a WAUTH query string to force a preferred authentication method.
   - For SAML2.0, use the following:

        ```xml
        <saml:AuthnContext>
        <saml:AuthnContextClassRef>
        urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport
        </saml:AuthnContextClassRef>
        </saml:AuthnContext>
        ```

    When the enforced authentication method is sent with an incorrect value, or if that authentication method isn't supported on AD FS or STS, you receive an error message before you're authenticated.

    The following table shows the authentication type URIs that are recognized by AD FS for WS-Federation passive authentication.

    | Method of authentication wanted| wauth URI |
    |---|---|
    |User name and password authentication|urn:oasis:names:tc:SAML:1.0:am:password|
    |SSL client authentication|urn:ietf:rfc:2246|
    |Windows-integrated authentication|urn:federation:authentication:windows|

    Supported SAML authentication context classes

    | Authentication method| Authentication context class URI |
    |---|---|
    |User name and password|urn:oasis:names:tc:SAML:2.0:ac:classes:Password|
    |Password protected transport|urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport|
    |Transport Layer Security (TLS) client|urn:oasis:names:tc:SAML:2.0:ac:classes:TLSClient|
    |X.509 certificate|urn:oasis:names:tc:SAML:2.0:ac:classes:X509|
    |Integrated Windows authentication|urn:federation:authentication:windows|
    |Kerberos|urn:oasis:names:tc:SAML:2.0:ac:classes:Kerberos|

    To make sure that the authentication method is supported at AD FS level, check the following.

    AD FS 2.0

    Under /adfs/ls/web.config, make sure that the entry for the authentication type is present.

    ```xml
    <microsoft.identityServer.web>
    <localAuthenticationTypes>
     < add name="Forms" page="FormsSignIn.aspx" />  
    <add name="Integrated" page="auth/integrated/" />
    <add name="TlsClient" page="auth/sslclient/" />
    <add name="Basic" page="auth/basic/" />
    </localAuthenticationTypes>
    ```

    [AD FS 2.0: How to change the local authentication type](https://social.technet.microsoft.com/wiki/contents/articles/1600.ad-fs-2-0-how-to-change-the-local-authentication-type.aspx)

    AD FS 2012 R2

    1. Under AD FS Management, select **Authentication Policies** in the AD FS snap-in.

    2. In the Primary Authentication section, select **Edit** next to **Global Settings**. You can also right-click **Authentication Policies** and then select **Edit Global Primary Authentication**. Or, in the **Actions** pane, select **Edit Global Primary Authentication**.

    3. In the **Edit Global Authentication Policy** window, on the **Primary** tab, you can configure settings as part of the global authentication policy. For example, for primary authentication, you can select available authentication methods under **Extranet and Intranet**.

    Make sure that the required authentication method check box is selected.

4. If you get to your AD FS and enter you credentials but you cannot be authenticated, check for the following issues.

    1. Active Directory replication issue

        If AD replication is broken, changes made to the user or group may not be synced across domain controllers. Between domain controllers, there may be a password, UPN, GroupMembership, or Proxyaddress mismatch that affects the AD FS response (authentication and claims). You should start looking at the domain controllers on the same site as AD FS. Running a `repadmin /showreps` or a `DCdiag /v` command should reveal whether there's a problem on the domain controllers that AD FS is most likely to contact.

        You can also collect an AD replication summary to make sure that AD changes are being replicated correctly across all domain controllers. The `repadmin /showrepl * /csv > showrepl.csv` output is helpful for checking the replication status. For more information, see [Troubleshooting Active Directory replication problems](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc949120(v=ws.10)).

    2. Account locked out or disabled in Active Directory

        When an end user is authenticated through AD FS, he or she won't receive an error message stating that the account is locked or disabled. From AD FS and Logon auditing, you should be able to determine whether authentication failed because of an incorrect password, whether the account is disabled or locked, and so forth.

        To enable AD FS and Logon auditing on the AD FS servers, follow these steps:

        1. Use local or domain policy to enable success and failure for the following policies:
            - Audit logon event, located in `Computer configuration\Windows Settings\Security setting\Local Policy\Audit Policy`
            - Audit Object Access, located in `Computer configuration\Windows Settings\Security setting\Local Policy\Audit Policy`

                :::image type="content" source="media/troubleshoot-ad-fs-issues/local-domain-policy.png" alt-text="Use local or domain policy to enable success and failure.":::

        2. Disable the following policy:

            Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings

            This policy is located in `Computer configuration\Windows Settings\Security setting\Local Policy\Security Option`.

            :::image type="content" source="media/troubleshoot-ad-fs-issues/disable-policy.png" alt-text="Disable Force audit policy subcategory settings policy.":::

            If you want to configure it by using advanced auditing, see [Configuring Computers for Troubleshooting AD FS 2.0](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff641696(v=ws.10)).

        3. Configure AD FS for auditing:

            1. Open the AD FS 2.0 Management snap-in.
            2. In the **Actions** pane, select **Edit Federation Service Properties**.
            3. In the **Federation Service Properties** dialog box, select the **Events** tab.
            4. Select the **Success audits** and **Failure audits** check boxes.

                :::image type="content" source="media/troubleshoot-ad-fs-issues/federation-service-properties.png" alt-text="Enable A D F S auditing by selecting the Success audits and Failure audits check boxes under the Events tab in the Federation Service Properties dialog box." border="false":::
            5. Run `GPupdate /force` on the server.

    3. Service Principal Name (SPN) is registered incorrectly

        There may be duplicate SPNs or an SPN that's registered under an account other than the AD FS service account. For an AD FS Farm setup, make sure that SPN HOST/AD FSservicename is added under the service account that's running the AD FS service. For an AD FS stand-alone setup, where the service is running under Network Service, the SPN must be under the server computer account that's hosting AD FS.

        :::image type="content" source="media/troubleshoot-ad-fs-issues/ad-fs-service-name.png" alt-text="Input the A D F S service name under the Log On tab in the Active Directory Federation Services Properties dialog box." border="false":::

        Make sure that there aren't duplicate SPNs for the AD FS service, as it may cause intermittent authentication failures with AD FS. To list the SPNs, run `SETSPN -L <ServiceAccount>`.

        :::image type="content" source="media/troubleshoot-ad-fs-issues/list-spn.png" alt-text="Run SETSPN -L command to list the SPNs for the A D F S service.":::

        Run `SETSPN -A HOST/AD FSservicename ServiceAccount` to add the SPN.

        Run `SETSPN -X -F` to check for duplicate SPNs.

    4. Duplicate UPNs in Active Directory

        A user may be able to authenticate through AD FS when they're using SAMAccountName but be unable to authenticate when using UPN. In this scenario, Active Directory may contain two users who have the same UPN. It's possible to end up with two users who have the same UPN when users are added and modified through scripting (ADSIedit, for example).

        When UPN is used for authentication in this scenario, the user is authenticated against the duplicate user. So the credentials that are provided aren't validated.

        You can use queries like the following to check whether there are multiple objects in AD that have the same values for an attribute:

        ```powershell
        Dsquery * forestroot -filter UserPrincipalName=problemuser_UPN
        ```

        Make sure that the UPN on the duplicate user is renamed, so that the authentication request with the UPN is validated against the correct objects.

    5. In a scenario, where you're using your email address as the login ID in Office 365, and you enter the same email address when you're redirected to AD FS for authentication, authentication may fail with a "NO_SUCH_USER" error in the Audit logs. To enable AD FS to find a user for authentication by using an attribute other than UPN or SAMaccountname, you must configure AD FS to support an alternate login ID. For more information, see [Configuring Alternate Login ID](/windows-server/identity/ad-fs/operations/configuring-alternate-login-id).

        _On AD FS 2012 R2_  

        1. Install [Update 2919355](https://www.catalog.update.microsoft.com/Search.aspx?q=2919355).
        2. Update the AD FS configuration by running the following PowerShell cmdlet on any of the federation servers in your farm (if you have a WID farm, you must run this command on the primary AD FS server in your farm):

            ```powershell
            Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID <attribute> -LookupForests <forest domain>
            ```

            > [!NOTE]
            > AlternateLoginID is the LDAP name of the attribute that you want to use for login. And LookupForests is the list of forests DNS entries that your users belong to.

            To enable the alternate login ID feature, you must configure both the AlternateLoginID and LookupForests parameters with a non-null, valid value.

    6. The AD FS service account doesn't have read access to on the AD FS token that's signing the certificate's private key. To add this permission, follow these steps:

        1. When you add a new Token-Signing certificate, you receive the following warning:
            > Ensure that the private key for the chosen certificate is accessible to the service account for this Federation Service on each server in the farm.
        1. Select **Start**, select **Run**, type mmc.exe, and then press Enter.
        1. Select **File**, and then select **Add/Remove Snap-in**.
        1. Double-click **Certificates**.
        1. Select the computer account in question, and then select **Next**.
        1. Select **Local computer**, and select **Finish**.
        1. Expand **Certificates (Local Computer)**, expand **Persona** l, and then select **Certificates**.
        1. Right-click your new token-signing certificate, select **All Tasks**, and then select **Manage Private Keys**.

            :::image type="content" source="media/troubleshoot-ad-fs-issues/add-permission.png" alt-text="Steps to add Read access permission for your A D F S service account.":::

        1. Add Read access for your AD FS 2.0 service account, and then select **OK**.
        1. Close the Certificates MMC.

    7. The **Extended Protection** option for Windows Authentication is enabled for the AD FS or LS virtual directory. It may cause issues with specific browsers. Sometimes you may see AD FS repeatedly prompting for credentials, and it might be related to the Extended protection setting that's enabled for Windows Authentication for the AD FS or LS application in IIS.

        :::image type="content" source="media/troubleshoot-ad-fs-issues/extended-protection.png" alt-text="Turn on the Extended Protection option for Windows Authentication.":::

        When Extended Protection for authentication is enabled, authentication requests are bound to both the Service Principal Names (SPNs) of the server to which the client tries to connect and to the outer Transport Layer Security (TLS) channel over which Integrated Windows Authentication occurs. Extended protection enhances the existing Windows Authentication functionality to mitigate authentication relays or "man in the middle" attacks. However, certain browsers don't work with the Extended protection setting; instead they repeatedly prompt for credentials and then deny access. Disabling Extended protection helps in this scenario.

        For more information, see [AD FS 2.0: Continuously Prompted for Credentials While Using Fiddler Web Debugger](https://social.technet.microsoft.com/wiki/contents/articles/1426.ad-fs-2-0-continuously-prompted-for-credentials-while-using-fiddler-web-debugger.aspx).

        _For AD FS 2012 R2_  

        Run the following cmdlet to disable Extended protection:

        ```powershell
        Set-ADFSProperties -ExtendedProtectionTokenCheck None
        ```

    8. Issuance Authorization rules in the Relying Party (RP) trust may deny access to users. On the AD FS Relying Party trust, you can configure the Issuance Authorization rules that control whether an authenticated user should be issued a token for a Relying Party. Administrators can use the claims that are issued to decide whether to deny access to a user who's a member of a group that's pulled up as a claim.

          If certain federated users can't authenticate through AD FS, you may want to check the Issuance Authorization rules for the Office 365 RP and see whether the Permit Access to All Users rule is configured.

          :::image type="content" source="media/troubleshoot-ad-fs-issues/permit-access-all-users.png" alt-text="Configure the Permit Access to All Users rule.":::

          If this rule isn't configured, peruse the custom authorization rules to check whether the condition in that rule evaluates "true" for the affected user. For more information, see the following resources:
          - [Understanding Claim Rule Language in AD FS 2.0 & Higher](https://social.technet.microsoft.com/wiki/contents/articles/4792.understanding-claim-rule-language-in-ad-fs-2-0-higher.aspx)
          - [Configuring Client Access Policies](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn592182(v=ws.11))
          - [Limiting Access to Office 365 Services Based on the Location of the Client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh526961(v=ws.10))

          If you can authenticate from an intranet when you access the AD FS server directly, but you can't authenticate when you access AD FS through an AD FS proxy, check for the following issues:
          - Time sync issue on AD FS server and AD FS proxy

            Make sure that the time on the AD FS server and the time on the proxy are in sync. When the time on the AD FS server is off by more than five minutes from the time on the domain controllers, authentication failures occur. When the time on AD FS proxy isn't synced with AD FS, the proxy trust is affected and broken. So a request that comes through the AD FS proxy fails.
          - Check whether the AD FS proxy Trust with the AD FS service is working correctly. Rerun the proxy configuration if you suspect that the proxy trust is broken.

5. After your AD FS issues a token, Microsoft Entra ID or Office 365 throws an error. In this situation, check for the following issues:
   - The claims that are issued by AD FS in token should match the respective attributes of the user in Microsoft Entra ID. In the token for Microsoft Entra ID or Office 365, the following claims are required.

        WSFED:  
        UPN: The value of this claim should match the UPN of the users in Microsoft Entra ID.  
        ImmutableID: The value of this claim should match the sourceAnchor or ImmutableID of the user in Microsoft Entra ID.

        To get the User attribute value in Microsoft Entra ID, run the following command line:

        ```powershell
        Get-MsolUser -UserPrincipalName <UPN>
        ```

        SAML 2.0:  
        IDPEmail: The value of this claim should match the user principal name of the users in Microsoft Entra ID.  
        NAMEID: The value of this claim should match the sourceAnchor or ImmutableID of the user in Microsoft Entra ID.

        For more information, see [Use a SAML 2.0 identity provider to implement single sign-on](/previous-versions/azure/azure-services/dn641269(v=azure.100)).

        Examples:  
        This issue can occur when the UPN of a synced user is changed in AD but without updating the online directory. In this scenario, you can either correct the user's UPN in AD (to match the related user's logon name) or run the following cmdlet to change the logon name of the related user in the Online directory:

        ```powershell
        Set-MsolUserPrincipalName -UserPrincipalName [ExistingUPN] -NewUserPrincipalName [DomainUPN-AD]
        ```

        It might also be that you're using AADsync to sync MAIL as UPN and EMPID as SourceAnchor, but the Relying Party claim rules at the AD FS level haven't been updated to send MAIL as UPN and EMPID as ImmutableID.

   - There's a token-signing certificate mismatch between AD FS and Office 365.

        It's one of the most common issues. AD FS uses the token-signing certificate to sign the token that's sent to the user or application. The trust between the AD FS and Office 365 is a federated trust that's based on this token-signing certificate (for example, Office 365 verifies that the token received is signed by using a token-signing certificate of the claim provider [the AD FS service] that it trusts).

        However, if the token-signing certificate on the AD FS is changed because of Auto Certificate Rollover or by an admin's intervention (after or before certificate expiry), the details of the new certificate must be updated on the Office 365 tenant for the federated domain. It may not happen automatically; it may require an admin's intervention. When the Primary token-signing certificate on the AD FS is different from what Office 365 knows about, the token that's issued by AD FS isn't trusted by Office 365. So the federated user isn't allowed to sign in.

        Office 365 or Microsoft Entra ID will try to reach out to the AD FS service, assuming the service is reachable over the public network. We try to poll the AD FS federation metadata at regular intervals, to pull any configuration changes on AD FS, mainly the token-signing certificate info. If this process is not working, the global admin should receive a warning on the Office 365 portal about the token-signing certificate expiry and about the actions that are required to update it.

        You can use `Get-MsolFederationProperty -DomainName <domain>` to dump the federation property on AD FS and Office 365. Here you can compare the TokenSigningCertificate thumbprint, to check whether the Office 365 tenant configuration for your federated domain is in sync with AD FS. If you find a mismatch in the token-signing certificate configuration, run the following command to update it:

        ```powershell
        Update-MsolFederatedDomain -DomainName <domain> -SupportMultipleDomain
        ```

        You can also run the following tool to schedule a task on the AD FS server that will monitor for the Auto-certificate rollover of the token-signing certificate and update the Office 365 tenant automatically.

        - [Microsoft Office 365 Federation Metadata Update Automation Installation Tool](https://gallery.technet.microsoft.com/scriptcenter/office-365-federation-27410bdc)

        - [Verify and manage single sign-on with AD FS](/previous-versions/azure/azure-services/jj151809(v=azure.100))

   - Issuance Transform claim rules for the Office 365 RP aren't configured correctly.

        In a scenario where you have multiple TLDs (top-level domains), you might have logon issues if the Supportmultipledomain switch wasn't used when the RP trust was created and updated. For more information, see [SupportMultipleDomain switch, when managing SSO to Office 365](/archive/blogs/abizerh/supportmultipledomain-switch-when-managing-sso-to-office-365).

   - Make sure that token encryption isn't being used by AD FS or STS when a token is issued to Microsoft Entra ID or to Office 365.
6. There are stale cached credentials in Windows Credential Manager.

    Sometimes during login in from a workstation to the portal (or when using Outlook), when the user is prompted for credentials, the credentials may be saved for the target (Office 365 or AD FS service) in the Windows Credentials Manager (`Control Panel\User Accounts\Credential Manager`). This helps prevent a credentials prompt for some time, but it may cause a problem after the user password has changed and the credentials manager isn't updated. In that scenario, stale credentials are sent to the AD FS service, and that's why authentication fails. Removing or updating the cached credentials, in Windows Credential Manager may help.

7. Make sure that Secure Hash Algorithm that's configured on the Relying Party Trust for Office 365 is set to SHA1.

    When the trust between the STS / AD FS and Microsoft Entra ID / Office 365 is using SAML 2.0 protocol, the Secure Hash Algorithm configured for digital signature should be SHA1.

8. If none of the preceding causes apply to your situation, create a support case with Microsoft and ask them to check whether the User account appears consistently under the Office 365 tenant. For more information, see [A federated user is repeatedly prompted for credentials during sign-in to Office 365, Azure or Intune](/office365/troubleshoot/sign-In/federated-user-repeatedly-prompted-for-credentials).

9. Depending on which cloud service (integrated with Microsoft Entra ID) you are accessing, the authentication request that's sent to AD FS may vary. For example: certain requests may include additional parameters such as Wauth or Wfresh, and these parameters may cause different behavior at the AD FS level.

    We recommend that AD FS binaries always be kept updated to include the fixes for known issues. For more information about the latest updates, see the following table.

    |AD FS 2.0|AD FS 2012 R2|
    |---|---|
    |<ul><li>[Description of Update Rollup 3 for Active Directory Federation Services (AD FS) 2.0](https://support.microsoft.com/help/2790338) <br/> </li> <li>[Update is available to fix several issues after you install security update 2843638 on an AD FS server](https://support.microsoft.com/help/2896713 )</li>|[December 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/help/3013769) |
