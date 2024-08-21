---
title: Resolve free/busy errors
description: Provides troubleshooting steps for errors that a user might encounter when they try to access free/busy information.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Outlook for Windows
  - Outlook for Mac
  - Outlook for iOS
  - CSSTroubleshoot
  - CI 181230
ms.reviewer: mburuiana, rayfong, kezuo, gbratton, shanefe, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook on the web
  - Outlook for Android
  - Outlook for iOS
  - Outlook for Mac
search.appverid: MET150
ms.date: 05/29/2024
---

# Resolve free/busy errors

To troubleshoot an error that's related to free/busy information, select the applicable error message from the table of contents (TOC) at the top of this article.

If the troubleshooting steps don't help you resolve the issue, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021).

## An error occurred when verifying security for the message

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Autodiscover failed for email address \<smtp address\> with error System.Web.Services.Protocols.SoapHeaderException: An error occurred when verifying security for the message at System.Web. Services.Protocols. SoapHttpClientProtocol. ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall) at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)

This error can occur if WSSecurity authentication isn't enabled or has to be reset, or after you renew federation certificates in Exchange Server.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. To refresh metadata in the Microsoft Federation Gateway, run the following command two times in the on-premises Exchange Management Shell (EMS):

   ```PowerShell
   Get-FederationTrust | Set-FederationTrust -RefreshMetadata
   ```

   For more information, see [Free/busy lookups stop working in a cross-premises environment or in an Exchange Server hybrid deployment](/exchange/troubleshoot/calendars/freebusy-lookups-stop-working).

2. Follow these steps to toggle WSSecurity authentication:

   1. Follow the procedure in [Users from a federated organization can't see the free/busy information of another Exchange organization](https://support.microsoft.com/topic/users-from-a-federated-organization-cannot-see-the-free-busy-information-of-anotherexchange-organization-938f0ba7-1303-de00-57a0-6ff73ccceece) to enable&mdash;or reset if already enabled&mdash;WSSecurity authentication in both the Autodiscover and EWS virtual directories on all on-premises Exchange servers.

      **Notes**

      - Perform this step even if the output of the PowerShell cmdlets `Get-AutodiscoverVirtualDirectory` and `Get-WebServicesVirtualDirectory` indicate that WSSecurity authentication is already enabled.

      - The procedure affects only cross-premises free/busy and won't affect other client-server connections.

   2. Run the `iisreset /noforce` command in a PowerShell or Command Prompt window on each on-premises Exchange server to restart IIS.

   3. Restart all on-premises Exchange servers.

3. Check for and resolve any time-skew warnings or errors in the System event log.

4. Set the `TargetSharingEpr` parameter value in the organization relationship to the on-premises external Exchange Web Services (EWS) URL by running the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   Set-OrganizationRelationship "O365 to On-premises*" -TargetSharingEpr <on-premises EWS external URL>
   ```

   After you set the `TargetSharingEpr` parameter value, the cloud mailbox bypasses Autodiscover and connects directly to the EWS endpoint of the on-premises mailbox.

   **Note**: The default value of the `TargetSharingEpr` parameter is blank. The Autodiscover parameters `TargetAutodiscoverEpr` or `DiscoveryEndpoint` usually contain the on-premises EWS external URL (Autodiscover endpoint). To get the `TargetAutodiscoverEpr` and `DiscoveryEndpoint` parameter values, run the following PowerShell cmdlets:

   ```PowerShell
   Get-OrganizationRelationship | FL TargetAutodiscoverEpr
   Get-IntraOrganizationConnector | FL DiscoveryEndpoint
   ```

5. Make sure that the `TargetApplicationUri` parameter value in the organization relationship matches the `AccountNamespace` parameter value in the [federated organization identifier](/powershell/module/exchange/set-federatedorganizationidentifier). To find the `TargetApplicationUri` parameter value, run the [Test-OrganizationRelationship](/powershell/module/exchange/test-organizationrelationship) PowerShell cmdlet. To find the `AccountNamespace` parameter value, see [Demystifying hybrid free/busy](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-what-are-the-moving-parts/ba-p/607704).

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed: Unable to connect to the remote server

### Issue

You have  cloud user who can't view the free/busy information for an on-premises user, or vice-versa. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed. , inner exception: System.Net.WebException: Unable to connect to the remote server ; System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond CUSTOMER_IP:443 / MICROSOFT_IP:443 at System.Net.Sockets.Socket.EndConnect(IAsyncResult asyncResult)

This error can occur if network connectivity issues prevent inbound or outbound connections between IP addresses in Exchange Online and endpoints in Exchange Server.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Verify that the firewall on each on-premises Exchange server allows inbound or outbound connections between Exchange Server endpoints and Exchange Online IP addresses. To identify firewall issues, make a free/busy request from Exchange Online and then check the on-premises firewall, reverse proxy, and network logs. For more information about how to configure a firewall, see [Firewall considerations for federated delegation](/previous-versions/office/exchange-server-2010/dd638083(v=exchg.141)) and [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

2. Verify that requests from Exchange Online reach the on-premises Client Access servers. Follow these steps on all on-premises Client Access servers:

   1. Make a free/busy request from Exchange Online.

   2. Check the IIS logs in the _W3SVC1_ folder for the default website to verify that the free/busy request is logged. The _W3SVC1_ folder path is `%SystemDrive%\inetpub\logs\LogFiles\W3SVC1`.

   3. Check the HTTP proxy logs in the following folders to verify that the free/busy request is logged:

      - _%ExchangeInstallPath%\Logging\HttpProxy\Autodiscover_

      - _%ExchangeInstallPath%\Logging\HttpProxy\Ews_

3. Test connectivity from Exchange Online to the on-premises Exchange Web Services (EWS) endpoint by running the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   Test-MigrationServerAvailability -RemoteServer <on-premises mail server FQDN> -ExchangeRemoteMove -Credentials (Get-Credential)
   ```

   **Notes**

   - This test is useful if you restrict inbound connections from the internet to allow only Exchange Online IP addresses to connect to your on-premises EWS endpoint.

   - If only a few cloud users are affected by this issue, and their mailboxes are hosted on the same mail server in Exchange Online, check whether that mail server can connect to on-premises endpoints. It's possible that an on-premises endpoint blocks connections from the outbound external IP address of that mail server.

   - When you're prompted for credentials, enter your domain administrator credentials in "domain\administrator" format.

[Back to top](#resolve-freebusy-errors)

## Autodiscover failed for email address: HTTP status 404

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Autodiscover failed for email address \<user SMTP address\> with error System.Net.WebException: The request failed with HTTP status code `404 Not Found`.

This error can occur if Autodiscover endpoints are nonfunctional or misconfigured.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Check whether the Autodiscover endpoint is valid:

   1. Run the following commands to get the Autodiscover endpoint URL from the `DiscoveryEndpoint` or `TargetAutodiscoverEpr` parameter:

      ```PowerShell
      Get-IntraOrganizationConnector | FL DiscoveryEndpoint
      Get-OrganizationRelationship | FL TargetAutodiscoverEpr
      ```

   2. Navigate to the Autodiscover endpoint URL in a web browser. A valid Autodiscover endpoint won't return HTTP status code `404 Not Found`.

2. Make sure that the domain of the on-premises user is specified in the organization settings (intra-organization connector or organization relationship) of the cloud user:

   1. Run the following PowerShell cmdlets in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

      ```PowerShell
      Get-IntraOrganizationConnector | FL TargetAddressDomains
      Get-OrganizationRelationship -Identity <cloud to on-premises ID> | FL DomainNames
      ```

      Verify that the domain of the on-premises user is listed in the output of either command. For example, if cloud user `user1@contoso.com` looks up the free/busy for on-premises user `user2@contoso.ro`, verify that the on-premises domain `contoso.ro` is listed.

   2. If the domain of the on-premises user doesn't exist in the organization settings of the cloud user, add the domain by running the following PowerShell cmdlet:

      ```PowerShell
      Set-IntraOrganizationConnector -Identity <connector ID> -TargetAddressDomains @{add="<on-premises domain>"}
      ```

3. Make sure that the SVC handler mapping exists in both the Autodiscover and EWS virtual directories under **Default Web Site** in IIS Manager. For more information, see [FederationInformation couldn't be received](/exchange/troubleshoot/administration/endpoint-connection-405-error) and [Exception has been thrown by the target](/exchange/troubleshoot/move-mailboxes/hybrid-deployment-errors).

   **Note**: The `AutodiscoverDiscoveryHander` mapping (*.svc) isn't used for federation free/busy lookup.

[Back to top](#resolve-freebusy-errors)

## Exception proxy web request failed

**LID: 43532**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Exception Proxy web request failed. , inner exception: The request failed with HTTP status 401: Unauthorized diagnostics: 2000005;reason= "The user specified by the user-context in the token is ambiguous." ;error_category="invalid_user"

This error can occur if the UPN, SMTP address, or SIP address of the on-premises user is used by another on-premises mailbox.

### Resolution

To fix the issue, follow these steps:

1. Search for on-premises user objects that have a duplicate UPN, SMTP address, or SIP address by using custom LDAP queries. You can run LDAP queries by using LDP.exe or the Active Directory Users and Computers MMC snap-in.

   For example, to show all users that have `user@corp.contoso.com` as the UPN, `user@contoso.com` as the SMTP address, or `user@contoso.com` as the SIP address, use the following LDAP query:

   ```PowerShell
   (|(userPrincipalName=user@corp.contoso.com)(proxyAddresses=SMTP:user@contoso.com)(proxyAddresses=sip:user@contoso.com))
   ```

   For more information about how to use LDP.exe or Active Directory Users and Computers to find Active Directory objects, see [LDP examples](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771022(v=ws.11)).

2. Change the duplicate address or delete the duplicate user object.

[Back to top](#resolve-freebusy-errors)

## An existing connection was forcibly closed by the remote host

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed. , inner exception: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive. System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host.

This error can occur if an on-premises firewall blocks an inbound connection from an external outbound IP address in Exchange Online.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Check whether free/busy requests from Exchange Online reach IIS on an Exchange server. Make a free/busy request from Exchange Online and search for the following IIS log entries that were made at the time of the free/busy request:

   - An Autodiscover entry in the _%ExchangeInstallPath%\Logging\HttpProxy\Autodiscover_ folder that contains "ASAutoDiscover/CrossForest/EmailDomain".

     **Note**: If you manually set the `TargetSharingEpr` parameter in the organization relationship to the on-premises external Exchange Web Services (EWS) URL, Autodiscover is bypassed, and this entry won't exist.

   - An EWS entry in the _%ExchangeInstallPath%\Logging\HttpProxy\Ews_ folder that contains "ASProxy/CrossForest/EmailDomain".

   **Note**: Timestamps in IIS logs use UTC time.

2. Verify that the firewall on each on-premises Exchange server allows inbound or outbound connections between Exchange Server endpoints and Exchange Online IP addresses. To identify firewall issues, make free/busy requests from Exchange Online, and then check the on-premises firewall, reverse proxy, and network logs. For more information about how to configure a firewall, see [Firewall considerations for federated delegation](/previous-versions/office/exchange-server-2010/dd638083(v=exchg.141)) and [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

3. If your organization uses [organization relationships](/exchange/sharing/organization-relationships/create-an-organization-relationship) to implement free/busy, make sure a federation certificate is installed on each Exchange server. Run the following commands in the Exchange Management Shell (EMS):

   ```PowerShell
   Test-FederationTrustCertificate
   Get-FederatedOrganizationIdentifier -IncludeExtendedDomainInfo | FL
   ```

   If the federation certificate is installed, the command output shouldn't contain any errors or warnings.

4. Follow these steps to toggle WSSecurity authentication:

   1. Follow the procedure in [Users from a federated organization can't see the free/busy information of another Exchange organization](https://support.microsoft.com/topic/users-from-a-federated-organization-cannot-see-the-free-busy-information-of-anotherexchange-organization-938f0ba7-1303-de00-57a0-6ff73ccceece) to enable—or reset if already enabled—WSSecurity authentication in both the Autodiscover and EWS virtual directories on all on-premises Exchange servers. Perform this step even if WSSecurity authentication is already enabled.

   2. Recycle the Autodiscover and EWS application pools in IIS Manager.

   3. Run the `iisreset /noforce` command in a PowerShell or Command Prompt window on each on-premises Exchange server to restart IIS.

5. If only a few cloud users are affected by this issue, and their mailboxes are hosted on the same mail server in Exchange Online, check whether that mail server can connect to on-premises endpoints. It's possible that an on-premises endpoint blocks connections from the outbound IP address of that mail server.

[Back to top](#resolve-freebusy-errors)

## Configuration information for forest/domain could not be found in Active Directory

**LID: 47932**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user, or vice-versa. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Configuration information for forest/domain \<domain\> could not be found in Active Directory.

This error can occur if organization settings are misconfigured.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Verify that the domain of a user whose free/busy information is requested exists in the organization settings of the user that's trying to view the free/busy information. Select one of the following procedures depending on the free/busy direction.

   - **Cloud to on-premises**

     For a cloud user that tries to view the free/busy information for an on-premises user, follow these steps:

     1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then run the following PowerShell cmdlets to get the federated domains:

        ```PowerShell
        Get-IntraOrganizationConnector | FL TargetAddressDomains
        Get-OrganizationRelationship -Identity <cloud to on-premises ID> | FL DomainNames
        ```

        Verify that the domain of the on-premises user is listed in the output of either command. For example, if cloud user `user1@contoso.com` looks up the free/busy for on-premises user `user2@contoso.ro`, verify that the on-premises domain `contoso.ro` is listed.

        > [!NOTE]
        > You can also find the domain names by running `(Get-IntraOrganizationConfiguration).OnPremiseTargetAddresses` in Exchange Online PowerShell, or by running `(Get-FederatedOrganizationIdentifier).Domains` in the on-premises Exchange Management Shell (EMS).

     2. If the domain of the on-premises user doesn't exist in the organization settings of the cloud user, add the domain by running the following PowerShell cmdlet:

         ```PowerShell
         Set-IntraOrganizationConnector -Identity <connector ID> -TargetAddressDomains @{add="<on-premises domain>"}​
         ```

   - **On-premises to cloud**

     For an on-premises user that tries to view the free/busy information for a cloud user, follow these steps:

     1. In the EMS, run the following PowerShell cmdlets:

        ```PowerShell
        Get-IntraOrganizationConnector | FL TargetAddressDomains
        Get-OrganizationRelationship -Identity <on-premises to cloud ID> | FL DomainNames
        ```

        Check whether the domain of the cloud user is a match for one of the domains listed in the command output. For example, if on-premises user `user1@contoso.ro` looks up free/busy information for cloud user `user2@contoso.com`, verify that the cloud domain `contoso.com` is present in the output of either command.

     2. If the domain of the cloud user doesn't exist in the organization settings of the on-premises user, add the domain. Run the following command:

        ```PowerShell
        Set-IntraOrganizationConnector -Identity <connector ID> -TargetAddressDomains @{add="<cloud domain>"}​
        ```

2. Make sure that your hybrid Exchange deployment has a full hybrid configuration. If it's necessary, rerun the Hybrid Configuration Wizard (HCW) and select **Full Hybrid Configuration** instead of **Minimal Hybrid Configuration.** A [minimal hybrid configuration](https://techcommunity.microsoft.com/t5/exchange-team-blog/hcw-improvement-the-minimal-hybrid-configuration-option/ba-p/605072) doesn't create an organization relationship (federation trust) or intra-organization connectors.

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed: HTTP status 401

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find either of the following error messages.

**Error message 1**

> Proxy web request failed. ,inner exception: The request failed with HTTP status 401: Unauthorized.

**Error message 2**

> Autodiscover failed for email address. ,inner exception: The request failed with HTTP status 401: Unauthorized.

This error can occur if a perimeter device in front of Exchange Server is configured to preauthenticate (require username and password) instead of passing requests from Exchange Online directly through to Exchange Server. The Autodiscover and EWS virtual directories in hybrid Exchange deployments don't support preauthentication.

Examples of perimeter devices include reverse proxies, firewalls, and Microsoft Threat Management Gateway (TMG).

Error message 1 indicates that an EWS request failed.

Error message 2 indicates that an Autodiscover request failed.

### Troubleshooting steps

To troubleshoot the free/busy issue regardless of which error message you received, use the following steps. After you complete each step, check whether the free/busy issue is fixed.

1. Check whether preauthentication is enabled. Follow these steps:

   1. Run the [Free/Busy test](https://testconnectivity.microsoft.com/tests/FreeBusy/input) in the Remote Connectivity Analyzer to check whether preauthentication is enabled. The cloud mailbox is the **Source Mailbox**, and the on-premises mailbox is the **Target Mailbox**. After the test completes, check the pass-through authentication status at the endpoint. If you see a red checkmark, disable preauthentication and retest. If you see a green checkmark, continue to the next step because it could be a false positive.

   2. Check whether a free/busy request from Exchange Online reaches IIS. Perform a free/busy query and then search the IIS logs in Exchange Server for any of the following entries at the time of the query:

      - In the _%ExchangeInstallPath%\Logging\HttpProxy\Autodiscover_ folder, search for an Autodiscover entry that has the HTTP status code `401 Unauthorized` and contains the text "ASAutoDiscover/CrossForest/EmailDomain".

        **Note**: If the `TargetSharingEpr` parameter in the organization relationship specifies an on-premises EWS external URL, then Autodiscover is bypassed and this entry won't appear.

      - In the _%ExchangeInstallPath%\Logging\HttpProxy\Ews_ folder, search for an EWS entry that has the HTTP status code `401 Unauthorized` and contains the text "ASProxy/CrossForest/EmailDomain".

      **Note**: Timestamps in IIS logs use UTC time. Some entries that have the HTTP status code `401 Unauthorized` are normal.

      The specified entries indicate that the free/busy request reached IIS and usually rules out preauthentication issues. If you don't find the specified entries, check your reverse proxy and firewall logs to understand where the free/busy request got stuck.

2. Make sure that you have enabled WSSecurity (Exchange Server 2010) or OAuth authentication (Exchange Server 2013 and later versions) on the EWS and Autodiscover virtual directories. Also, verify that you have enabled the default authentication settings in IIS for the Autodiscover and EWS virtual directories. For more information, see [Default authentication settings for Exchange virtual directories](/previous-versions/office/exchange-server-2010/gg247612(v=exchg.141)?redirectedfrom=MSDN) and [Default settings for Exchange virtual directories](/exchange/clients/default-virtual-directory-settings).

3. Follow the resolution steps in [An error occurred when verifying security for the message](#an-error-occurred-when-verifying-security-for-the-message). If WSSecurity is configured, make sure that you perform the step that toggles WSSecurity. If OAuth authentication is configured instead of WSSecurity, toggle OAuth authentication on the Autodiscover and EWS virtual directories by running the following commands:

   ```PowerShell
   Set-WebServicesVirtualDirectory "<ServerName>\ews (Exchange Back End)" -OAuthAuthentication:$False
   Set-WebServicesVirtualDirectory "<ServerName>\ews (Exchange Back End)" -OAuthAuthentication:$True 
   Set-AutodiscoverVirtualDirectory "<ServerName>\Autodiscover (Exchange Back End)" -OAuthAuthentication:$False 
   Set-AutodiscoverVirtualDirectory "<ServerName>\Autodiscover (Exchange Back End)" -OAuthAuthentication:$True 
   ```

4. Verify that you have an up-to-date federation trust. Run the following command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to retrieve the federation trust information for your Exchange organization:

   ```PowerShell
   Get-FederationTrust
   ```

   The command output should contain the following information:

   | Name | ApplicationIdentifier | ApplicationUri |
   |-|-|-|
   | WindowsLiveId | 260563 | outlook.com |
   | MicrosoftOnline | 260563 | outlook.com |

   **Note**: The `WindowsLiveId` trust is a consumer instance of the Microsoft Federation Gateway. The `MicrosoftOnline` trust is a business instance of the Microsoft Federation Gateway.

   For an up-to-date federation trust, make sure that the `ApplicationIdentifier` is `260563` and not `292841`, and that the `ApplicationUri` is `outlook.com` and not `outlook.live.com`. If you have an outdated federation trust, contact [Microsoft Support](https://support.microsoft.com/contactus).

[Back to top](#resolve-freebusy-errors)

## Autodiscover failed for email address: InvalidUser

**LID: 33676**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The response from the Autodiscover service at 'https://Autodiscover/Autodiscover.svc/WSSecurity' failed due to an error in user setting 'ExternalEwsUrl'. Error message: InvalidUser.

The error message might show up when you run the [Free/Busy test](https://testconnectivity.microsoft.com/tests/FreeBusy/input) in the Remote Connectivity Analyzer.

This error can occur if the cloud mailbox or Autodiscover endpoint is misconfigured.

### Troubleshooting steps

1. Verify that the cloud user has a secondary SMTP address that includes the `onmicrosoft.com` domain by running the following command:

   ```PowerShell
   Get-Mailbox -Identity <mailbox ID> | FL EmailAddresses
   ```

   For example, a user who has the primary SMTP address `user1@contoso.com` should have a secondary SMTP address that's similar to `user1@contoso.mail.onmicrosoft.com`.

   If the cloud user is managed from Exchange Server, add the secondary SMTP address to Exchange Server, and then synchronize identity data between your on-premises environment and Microsoft Entra ID.

2. Run the following commands to set the `TargetSharingEpr` parameter value in the [organization relationship](/powershell/module/exchange/set-organizationrelationship) to the on-premises external Exchange Web Services (EWS) URL:

   ```PowerShell
   Connect-ExchangeOnline
   Set-OrganizationRelationship "O365 to On-premises*" -TargetSharingEpr <on-premises EWS external URL>
   ```

   After you set the `TargetSharingEpr` parameter value, the cloud mailbox bypasses Autodiscover and connects directly to the EWS endpoint of the on-premises mailbox.

[Back to top](#resolve-freebusy-errors)

## The caller does not have access to free/busy data

**LID: 47652, 44348, 40764**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user, or vice-versa. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Microsoft.Exchange.InfoWorker.Common.Availability.NoFreeBusyAccessException: The caller does not have access to free/busy data.

This error can occur if the mailbox of the user whose free/busy information is requested is misconfigured.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Check the calendar permissions of the user whose free/busy information is requested by running the following command:

   ```PowerShell
   Get-MailboxFolderPermission -Identity <mailbox ID>:\Calendar
   ```

   The `AccessRights` value for the `Default` user in the command output should be `AvailabilityOnly` or `LimitedDetails`. If the `AccessRights` value is `None`, run the following PowerShell cmdlet to set that value to either `AvailabilityOnly` or `LimitedDetails`:

   ```PowerShell
   Set-MailboxFolderPermission -Identity <mailbox ID>:\Calendar -AccessRights <access rights value>
   ```

2. Use the applicable method to check the organization relationship:

   - If a cloud user can't view the free/busy information for an on-premises user:

     Verify that the on-premises organization relationship specifies the cloud domain that can access the on-premises free/busy information. An example cloud domain is `contoso.mail.onmicrosoft.com`. For information about how to modify the organization relationship in Exchange Server, see [Use PowerShell to modify the organization relationship](/exchange/modify-an-organization-relationship-exchange-2013-help). Also verify that the **From** email address of the cloud user has the same cloud domain, for example `lucine.homsi@contoso.mail.onmicrosoft.com`.

   - If an on-premises user can't view the free/busy information for a cloud user:

     Verify that the cloud organization relationship specifies the on-premises domain that can access the cloud free/busy information. An example on-premises domain is `contoso.com`. For information about how to modify the organization relationship in Exchange Online, see [Use Exchange Online PowerShell to modify the organization relationship](/exchange/sharing/organization-relationships/modify-an-organization-relationship). Also verify that the **From** email address of the on-premises user has the same on-premises domain, for example `lucine.homsi@contoso.com`.

[Back to top](#resolve-freebusy-errors)

## An error occurred when processing the security tokens in the message

**LID: 59916**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> ProxyWebRequestProcessingException ErrorProxyRequestProcessingFailed  
> Proxy web request failed. , inner exception: An error occurred when processing the security tokens in the message.

This error can occur if the certificates or metadata in the Microsoft Federation Gateway are invalid.

### Troubleshooting steps

1. Check the expiration date and thumbprints of the on-premises federation trust certificates by running the following PowerShell cmdlets:

   ```PowerShell
   Get-FederationTrust | FL
   Test-FederationTrust
   Test-FederationTrustCertificate
   ```

2. To refresh metadata in the Microsoft Federation Gateway, run the following command two times in the on-premises Exchange Management Shell (EMS):

   ```PowerShell
   Get-FederationTrust | Set-FederationTrust -RefreshMetadata
   ```

   For more information, see [Free/busy lookups stop working](/exchange/troubleshoot/calendars/freebusy-lookups-stop-working).

[Back to top](#resolve-freebusy-errors)

## The cross-organization request is not allowed because the requester is from a different organization

**LID: 39660**

### Issue

You have a hybrid mesh scenario in which a cloud user in a nonhybrid Exchange Online tenant can't view the free/busy information for a cloud user in another Exchange Online tenant that goes hybrid. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The cross-organization request for mailbox \<SMTP address\> is not allowed because the requester is from a different organization  
> Recipient: \<SMTP address\>  
> Exception Type: CrossOrganizationProxyNotAllowedForExternalOrganization  
> Exception Message: The cross-organization request for \<SMTP address\> is not allowed because the requester is from a different organization.

For example, a user `lucine@adatum.com` in a nonhybrid Exchange Online tenant can't view the free/busy of a cloud user `chanok@contoso.com` in a hybrid tenant. The cloud user `chanok@contoso.com` has a proxy email address `chanok@contoso.mail.onmicrosoft.com`. The nonhybrid tenant has two organization relationships: `contoso.com` (on-premises) and `contoso.mail.onmicrosoft.com` (cloud). Autodiscover for `contoso.com` points to Exchange Server, and Autodiscover for `contoso.mail.onmicrosoft.com` points to Exchange Online. The user in the nonhybrid tenant receives the error message when querying the free/busy information for `chanok@contoso.com`, because Autodiscover for `contoso.com` points doesn't point to Exchange Online.

> [!NOTE]
> For the equivalent on-premises hybrid mesh scenario, see [Hybrid mesh](https://techcommunity.microsoft.com/t5/exchange-team-blog/the-hybrid-mesh/ba-p/605910).

### Workaround

To work around this issue, your organization can use one of the following methods:

- Users in the nonhybrid Exchange Online tenant should query the free/busy of a cloud user in a hybrid tenant by using the email address for which Autodiscover points to Exchange Online. For example, `lucine@adatum.com` queries free/busy information for `chanok@contoso.mail.onmicrosoft.com`. To successfully query free/busy information, users in the nonhybrid Exchange Online tenant must know which users in the hybrid tenant are hosted in the cloud, and for each of those users, the email address for which Autodiscover points to Exchange Online.

- An admin of the nonhybrid Exchange Online tenant should set the external email address of each cloud user in the hybrid tenant to the email address for which Autodiscover points to Exchange Online. For example, an admin in the nonhybrid Exchange Online tenant sets the target email address of `chanok@contoso.com` in the hybrid tenant to `chanok@contoso.mail.onmicrosoft.com`. To make this change, the admin must know which users in the hybrid tenant are hosted in the cloud, and for each of those users, the email address for which Autodiscover points to Exchange Online. For more information about cross-tenant synchronization of user email addresses, see [What is cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview).

### More information

A user might encounter a similar issue in the following scenario:

- The user is in a nonhybrid Exchange Server tenant.
- The user tries to view the free/busy for an on-premises user in a hybrid tenant.
- Autodiscover for the hybrid tenant points to Exchange Online.

For example, a user in a nonhybrid Exchange Server tenant can't view the free/busy information for on-premises user `chanok@contoso.com` in a hybrid tenant because Autodiscover for `contoso.com` points to Exchange Online (`autodiscover-s.outlook.com`).

[Back to top](#resolve-freebusy-errors)

## The request failed with HTTP status 401: Unauthorized (missing signing certificate)

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> System.Net.WebException: The request failed with HTTP status 401: Unauthorized.

If you run the [Test-OAuthConnectivity](/powershell/module/exchange/test-oauthconnectivity) cmdlet, you see the following error message in the command output:

> Microsoft.Exchange.Security.OAuth.OAuthTokenRequestFailedException: Missing signing certificate.

For example, you run the following command:

```PowerShell
Test-OAuthConnectivity -Service AutoD -TargetUri <on-premises Autodiscover URL> -Mailbox <mailbox ID> -Verbose | FL
```

The `TargetUri` parameter value is the on-premises Autodiscover service URL. An example of that URL is `https://mail.contoso.com/Autodiscover/Autodiscover.svc`.

This error can occur if the authentication configuration has an invalid OAuth certificate.

### Resolution

To fix the issue, follow these steps:

1. Run the following PowerShell cmdlet in the Exchange Management Shell (EMS) to get the thumbprint of the OAuth certificate that's used by the authentication configuration:

   ```PowerShell
   Get-AuthConfig | FL CurrentCertificateThumbprint
   ```

   If the command output doesn't return a certificate thumbprint, go to step 3. Otherwise, continue to the next step.

2. Run the following PowerShell cmdlet to check whether the certificate that's identified in step 1 exists in Exchange Server:

   ```PowerShell
   Get-ExchangeCertificate -Thumbprint (Get-AuthConfig).CurrentCertificateThumbprint | FL
   ```

   If Exchange Server doesn't return any certificate, go to step 3 to create new certificate.

   If Exchange Server returns a certificate, but its thumbprint differs from the thumbprint that you obtained in step 1, go to step 4. In step 4, specify the thumbprint of the certificate that Exchange Server returned.

3. Run the following PowerShell cmdlet to create a new OAuth certificate:

   ```PowerShell
   New-ExchangeCertificate -KeySize 2048 -PrivateKeyExportable $true -SubjectName "CN=Microsoft Exchange Server Auth Certificate" -FriendlyName "Microsoft Exchange Server Auth Certificate" -DomainName <Domain> -Services SMTP
   ```

   > [!NOTE]
   > If you're prompted to replace the SMTP certificate, don't accept the prompt.

   In step 4, specify the thumbprint of the new certificate that you created in this step.

4. Run the following PowerShell cmdlets to update the authentication configuration to use the specified certificate:

   ```PowerShell
   $date=Get-Date 
   Set-AuthConfig -NewCertificateThumbprint <certificate thumbprint> -NewCertificateEffectiveDate $date
   Set-AuthConfig -PublishCertificate
   ```

   > [!NOTE]
   > If you're warned that the effective date is less than 48 hours from now, choose to continue.

5. Run the following PowerShell cmdlet to remove any references to the previous certificate:

   ```PowerShell
   Set-AuthConfig -ClearPreviousCertificate
   ```

[Back to top](#resolve-freebusy-errors)

## The application is missing a linked account for RBAC roles, or the linked account has no RBAC role assignments, or the calling users account is logon disabled

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> System.Web.Services.Protocols.SoapException: The application is missing a linked account for RBAC roles, or the linked account has no RBAC role assignments, or the calling users account is logon disabled.

### Troubleshooting steps

To troubleshoot the issues that are mentioned in the error message, use the following steps. After you complete steps 1 and 2, check whether the free/busy issue is fixed.

1. Make sure that the "Exchange Online-ApplicationAccount" entry exists in the list of Exchange Server partner applications. To check, run the following PowerShell cmdlet in the Exchange Management Console (EMS):

   ```PowerShell
   Get-PartnerApplication | FL LinkedAccount
   ```

   The account entry should appear as `<root domain FQDN>/Users/Exchange Online-ApplicationAccount`. If the entry is listed, go to step 2.

   If the account entry isn't listed, add the account by following these steps:

   1. Run the following PowerShell cmdlets to find the account in the on-premises Active Directory:

      ```PowerShell
      Set-ADServerSettings -ViewEntireForest $true 
      Get-User "Exchange Online-ApplicationAccount" 
      ```

      If the account is listed in Active Directory, go to step 1b.

      If the account isn't listed in Active Directory, it might have been deleted. Use [ADRestore](/sysinternals/downloads/adrestore) to check the account status and restore it, if it's deleted. If you restored the account by using ADRestore, go to step 1b.

      If you're can't restore the account by using ADRestore, follow the procedure that's discussed in [Active Directory and domains for Exchange Server](/exchange/plan-and-deploy/prepare-ad-and-domains). If that procedure doesn't restore the account, manually create the account in Active Directory, and then continue to step 1b.

   2. Run the following PowerShell cmdlet to add the Active Directory account to the list of Exchange Server partner applications:

      ```PowerShell
      Set-PartnerApplication "Exchange Online" -LinkedAccount "<root domain FQDN>/Users/Exchange Online-ApplicationAccount"
      ```

   3. Restart all on-premises Exchange servers, or restart IIS by running the `iisreset /noforce` command in a PowerShell or Command Prompt window on each server.

2. Run the following PowerShell cmdlet in the EMS to check the role-based access control (RBAC) assignments:

   ```PowerShell
   Get-ManagementRoleAssignment -RoleAssignee "Exchange Online-ApplicationAccount" | FL Name,Role
   ```

   For example, the command output might list the following role assignments:

   :::image type="content" source="media/resolve-free-busy-errors/role-assignments.png" alt-text="Screenshot of the role-assignments command output." lightbox="media/resolve-free-busy-errors/role-assignments-lrg.png":::

3. Search the following logs for the issues that are stated in the error message:

   - Exchange Web Services (EWS) logs that are located in the _%ExchangeInstallPath%\Logging\Ews_ folder
   - Application event logs
   - System event logs

4. Search the logs that are listed in step 3 for an error message that references [AuthzInitializeContextFromSid](/windows/win32/api/authz/nf-authz-authzinitializecontextfromsid). If you find that error message, see the following resources:

   - [Some applications and APIs require access to authorization information on account objects](/troubleshoot/windows-server/identity/apps-apis-require-access)

   - [Access checks fail because of AuthZ](/troubleshoot/windows-server/group-policy/authz-fails-access-denied-error-application-access-check)

[Back to top](#resolve-freebusy-errors)

## The entered and stored passwords do not match

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Soap fault exception received. The entered and stored passwords do not match.

You see the same error message when you run the following cmdlet to check whether the cloud user can retrieve a delegation token for the on-premises user mailbox:

```PowerShell
Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud mailbox ID> -Verbose
```

### Cause

An inconsistency exists in the Azure credentials for specific cloud users.

### Resolution

To fix the issue, follow these steps:

1. Reset the cloud user's password. Choose either the same or a different password.

2. Update the user principal name (UPN) of the cloud user to use the `onmicrosoft.com` domain, and then revert the UPN to its former value. For example, if the UPN of the cloud user is `user@contoso.com`, change it to the temporary UPN, `user@contoso.mail.onmicrosoft.com`, and then revert the UPN to `user@contoso.com`. To do this, use either [Azure AD PowerShell](/powershell/module/azuread) or the [MSOL service](/powershell/azure/active-directory/install-msonlinev1).

   - **Use Azure AD PowerShell**

     Run the following PowerShell cmdlets:

     ```PowerShell
     Connect-AzureAD
     Set-AzureADUser -ObjectID <original UPN> -UserPrincipalName <temporary UPN>
     Set-AzureADUser -ObjectID <temporary UPN> -UserPrincipalName <original UPN>
     ```

   - **Use the MSOL service**

     Run the following PowerShell cmdlets:

     ```PowerShell
     Connect-MsolService
     Set-MsolUserPrincipalName -UserPrincipalName <original UPN> -NewUserPrincipalName <temporary UPN>
     Set-MsolUserPrincipalName -UserPrincipalName <temporary UPN> -NewUserPrincipalName <original UPN>
     ```

3. Make sure that the `ImmutableId` value of the on-premises user object is null. Check the `ImmutableId` value for the on-premises user object by running the following command in the Exchange Management Shell (EMS):

   ```PowerShell
   Get-RemoteMailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
   ```

   Use one of the following methods, depending on the `ImmutableId` value.

   - **ImmutableId value is null**

     If the `ImmutableId` value is null, toggle its value:

     1. Set the `ImmutableId` of the remote mailbox object to the UPN of the cloud user by running the following PowerShell cmdlet in the EMS:

        ```PowerShell
        Set-RemoteMailbox -Identity <cloud mailbox> -ImmutableId <UPN>
        ```

        For example: `Set-RemoteMailbox user@contoso.com -ImmutableId user@contoso.onmicrosoft.com`.

     2. Sync the change to the cloud by running the following PowerShell cmdlets in the EMS:

        ```PowerShell
        Import-Module ADSync
        Start-ADSyncSyncCycle -PolicyType Delta
        ```

        To verify that the `ImmutableId` value has been updated, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

        ```PowerShell
        Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
        ```

     3. Revert the `ImmutableId` of the remote mailbox object to null by running the following PowerShell cmdlet in the EMS:

        ```PowerShell
        Set-RemoteMailbox -Identity <cloud mailbox> -ImmutableId $null
        ```

     4. Sync the change to the cloud by running the following PowerShell cmdlet in the EMS:

        ```PowerShell
        Start-ADSyncSyncCycle -PolicyType Delta
        ```

        To verify that the `ImmutableId` value has been updated, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

        ```PowerShell
        Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
        ```

   - **ImmutableId value isn't null**

     If the `ImmutableId` value isn't null, run the following command in the EMS to set the `ImmutableId` value to null:

     ```PowerShell
     Set-RemoteMailbox -Identity <user> -ImmutableId $null
     ```

     You can verify that the `ImmutableId` value has been updated by running the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

     ```PowerShell
     Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
     ```

[Back to top](#resolve-freebusy-errors)

## The password has to be changed or the password for the account has expired

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find one of the following error messages.

**Error message 1**

> The password for the account has expired

**Error message 2**

> The password has to be changed

You see the same error message when you run the following cmdlet to check whether the cloud user can retrieve a delegation token for the on-premises user mailbox:

```PowerShell
Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud mailbox ID> -Verbose
```

This error might occur if an inconsistency exists in the Azure credentials for specific cloud users.

### Resolution

Select the resolution that matches the error message.

**Resolution for error message 1**

To fix the issue, use either [Azure AD PowerShell](/powershell/module/azuread) or the [MSOL service](/powershell/azure/active-directory/install-msonlinev1).

- **Use Azure AD PowerShell**

  Run the following PowerShell cmdlets:

  ```PowerShell
  Connect-AzureAD
  Set-AzureADUser -ObjectId <account UPN> -PasswordPolicies DisablePasswordExpiration
  ```

- **Use MSOL service**

  Run the following PowerShell cmdlets:

  ```PowerShell
  Connect-MsolService
  Set-MsolUser -UserPrincipalName <account UPN> -PasswordNeverExpires $true
  ```

**Resolution for error message 2**

To fix the issue, run the following PowerShell cmdlets:

```PowerShell
Connect-MsolService
Set-MsolUserPassword -UserPrincipalName <UPN> -ForceChangePassword $false
```

For more information, see [Can't see free/busy information after migrated from Exchange on-premises](https://support.microsoft.com/topic/can-t-see-free-busy-information-after-migrated-from-exchange-on-premises-to-online-4dc6f43d-da4f-78ce-65cb-7c2b752c15e3).

[Back to top](#resolve-freebusy-errors)

## Provision is needed before federated account can be logged in

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Provision is needed before federated account can be logged in. ErrorWin32InteropError

You also get the same error message when you run the following cmdlet to check whether the cloud user can retrieve a delegation token for the on-premises user mailbox:

```PowerShell
Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud mailbox ID> -Verbose
```

This error can occur if there's an inconsistency in the configuration of federated users in Microsoft Entra ID.

### Resolution

> [!NOTE]
> If the issue affects most or all cloud users in your organization, contact [Microsoft Support](https://support.microsoft.com/).

To fix the issue, update the user principal name (UPN) of the cloud user to use the `onmicrosoft.com` domain then switch it back to its former value (federated domain). For example, if the UPN of the cloud user is `user@contoso.com`, switch it to the temporary UPN `user@contoso.mail.onmicrosoft.com` and then back to `user@contoso.com`. To do this, use either of the following approaches ([Azure AD PowerShell](/powershell/module/azuread) or [MSOL service](/powershell/azure/active-directory/install-msonlinev1)):

- **Use Azure AD PowerShell**

  Run the following PowerShell cmdlets:

  ```PowerShell
  Connect-AzureAD
  Set-AzureADUser -ObjectID <original UPN> -UserPrincipalName <temporary UPN>
  Set-AzureADUser -ObjectID <temporary UPN> -UserPrincipalName <original UPN>
  ```

- **Use the MSOL service**

  Run the following PowerShell cmdlets:

  ```PowerShell
  Connect-MsolService
  Set-MsolUserPrincipalName -UserPrincipalName <original UPN> -NewUserPrincipalName <temporary UPN>
  Set-MsolUserPrincipalName -UserPrincipalName <temporary UPN> -NewUserPrincipalName <original UPN>
  ```

[Back to top](#resolve-freebusy-errors)

## The request timed out

**LID: 43404**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The request timed out  
> Request could not be processed in time. Timeout occurred during 'Waiting-For-Request-Completion'.  
> Microsoft.Exchange.InfoWorker.Common.Availability.TimeoutExpiredException: Request could not be processed in time. Timeout occurred during 'Waiting-For-Request-Completion'.  
> Name of the server where exception originated: \<server name\>.

You also get the same error message if you run the following cmdlet to check whether the cloud user can retrieve a delegation token for the on-premises user mailbox:

```PowerShell
Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud mailbox ID> -Verbose
```

This error can occur if there are network or transient issues. The error message is generic.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. To rule out transient issues, verify that the cloud user consistently gets the same error message during repeated attempts to get the free/busy information of the on-premises user.

2. Check whether you can retrieve a delegation token when you run each of the following cmdlets:

   ```PowerShell
   Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud mailbox ID> -Verbose
   Test-FederationTrust -UserIdentity <on-premises mailbox ID> -Verbose
   Test-FederationTrustCertificate
   ```

   **Note**: Run the [Test-FederationTrust](/powershell/module/exchange/test-federationtrust) cmdlet on all on-premises Exchange servers.

3. Verify that Exchange Server has outbound internet access to both of the following resources:

   - The Microsoft Federation Gateway (or an authorization server, if you use OAuth)

   - The availability URL for Microsoft 365: `https://outlook.office365.com/ews/exchange.asmx`

   For more information, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges) and [Firewall Considerations for Federated Delegation](/previous-versions/office/exchange-server-2010/dd638083(v=exchg.141)).

4. Make sure that the system account in Exchange Server has internet access to the following URLs. Follow these steps on each Exchange server:

   1. Run the following [PsExec](/sysinternals/downloads/psexec) command to start a PowerShell session that starts a web browser from the system account:

      ```PowerShell
      PsExec.exe -i -s "C:\Program Files\Internet Explorer\iexplore.exe"
      ```

   2. Test browser access (no OAuth) from the system account to the following Microsoft Federation Gateway URLs:

      - `https://nexus.microsoftonline-p.com/federationmetadata/2006-12/federationmetadata.xml`

        The browser should display an xml page.

      - `https://login.microsoftonline.com/extSTS.srf`

        The browser should prompt you to download the file.

      - `https://domains.live.com/service/managedelegation2.asmx`

        The browser should display a list of operations that are supported by ManageDelegation2.

   3. Test browser access (OAuth) from the system account to the following Microsoft authorization server URLs:

      - `https://outlook.office365.com/ews/exchange.asmx`

        The browser should display a sign-in prompt.

      - `https://login.windows.net/common/oauth2/authorize`

        The browser should display the sign-in error, "Sorry, but we're having trouble signing you in."

      - `https://accounts.accesscontrol.windows.net/<tenant guid>/tokens/OAuth/2`

        The browser should display the HTTP status code `400 Bad Request`, or the sign-in error message, "Sorry, but we're having trouble signing you in."

5. Get the details of a free/busy request by checking the Exchange Web Services (EWS) logs:

   1. Make a free/busy request from Exchange Online.

   2. Find the entry in the EWS logs, and check the value in the `time-taken` column. The EWS logs are located in the _%ExchangeInstallPath%\Logging\Ews_ folder.

   3. Check the IIS logs in the _W3SVC1_ folder of the default website to verify that the free/busy request is logged. The _W3SVC1_ folder path is `%SystemDrive%\inetpub\logs\LogFiles\W3SVC1`.

[Back to top](#resolve-freebusy-errors)

## The specified member name is either invalid or empty

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> S:Fault xmlns:S="http://www.w3.org/2003/05/soap-envelope"\>\<S:Code><S:Value>S:Sender\</S:Value><S:Subcode\>\<S:Value\>wst:FailedAuthentication\</S:Value\>\</S:Subcode\>\</S:Code\>\<S:Reason\>\<S:Text xml:lang="en-US">Authentication Failure\</S:Text\>\</S:Reason\>\<S:Detail\>\<psf:error xmlns:psf="http://schemas.microsoft.com/Passport/SoapServices/SOAPFault"\>\<psf:value>0x80048821\</psf:value\>\<psf:internalerror\>\<psf:code\>0x80041034\</psf:code\>\<psf:text\>The specified member name is either invalid or empty. \</psf:text\>\</psf:internalerror\>\</psf:error\>\</S:Detail\>\</S:Fault\> Microsoft.Exchange.Net.WSTrust.SoapFaultException: Soap fault exception received. at Microsoft.Exchange.Net.WSTrust.SecurityTokenService.EndIssueToken(IAsyncResult asyncResult) at Microsoft.Exchange.InfoWorker.Common.Availability.ExternalAuthenticationRequest.Complete(IAsyncResult asyncResult)

The error might occur for either of the following reasons:

- An inconsistency in the Microsoft Entra ID for users that request a delegation token
- An inconsistency in the configuration of federated users in Active Directory Federation Services (AD FS)

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Update the user principal name (UPN) of the cloud user to use the `onmicrosoft.com` domain, and then revert the UPN to its former value. For example, if the UPN of the cloud user is `user@contoso.com`, change it to the temporary UPN, `user@contoso.mail.onmicrosoft.com`; and then revert the UPN to `user@contoso.com`. To do this, use either of the following methods ([Azure AD PowerShell](/powershell/module/azuread) or [MSOL service](/powershell/azure/active-directory/install-msonlinev1)):

   - **Use Azure AD PowerShell**

     Run the following PowerShell cmdlets:

     ```PowerShell
     Connect-AzureAD
     Set-AzureADUser -ObjectID <original UPN> -UserPrincipalName <temporary UPN>
     Set-AzureADUser -ObjectID <temporary UPN> -UserPrincipalName <original UPN>
     ```

   - **Use the MSOL service**

     Run the following PowerShell cmdlets:

     ```PowerShell
     Connect-MsolService
     Set-MsolUserPrincipalName -UserPrincipalName <original UPN> -NewUserPrincipalName <temporary UPN>
     Set-MsolUserPrincipalName -UserPrincipalName <temporary UPN> -NewUserPrincipalName <original UPN>
     ```

2. Check the AD FS rules, endpoints, and logs.

3. Search for an error that's related to the `ImmutableID` of the cloud user in the command output of the following PowerShell cmdlet:

   ```PowerShell
   Test-OrganizationRelationship -Identity "O365 to On-premises*" -UserIdentity <cloud user ID> -Verbose
   ```

   For example, the command output might contain the following error message:

   > "The email address "XGuNpVunD0afQeVNfyoUIQ==" isn't correct. Please use this format: user name, the @ sign, followed by the domain name. For example, `tonysmith@contoso.com` or `tony.smith@contoso.com`.  
   > \+ CategoryInfo : NotSpecified: (:) [Test-OrganizationRelationship], FormatException"

   If you receive a similar error message, use one of the following methods to make sure that the `ImmutableId` value is null (empty value):

   - If the cloud user isn't synced from on-premises, check the `ImmutableId` value by running the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

     ```PowerShell
     Get-Mailbox -Identity <cloud mailbox> | FL ImmutableId
     ```

     If the `ImmutableId` value isn't null, run the following PowerShell cmdlet in Exchange Online PowerShell:

     ```PowerShell
     Set-Mailbox -Identity <cloud mailbox> -ImmutableId $null
     ```

   - If the cloud user is synced from on-premises, check the `ImmutableId` value for the on-premises user object by running the following command in the Exchange Management Shell (EMS):

     ```PowerShell
     Get-RemoteMailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
     ```

     Use either of the following methods, depending on the `ImmutableId` value:

     - **ImmutableId value is null**

       If the `ImmutableId` value is null, toggle its value:

       1. Set the `ImmutableId` of the remote mailbox object to the UPN of the cloud user by running the following PowerShell cmdlet in the EMS:

          ```PowerShell
          Set-RemoteMailbox -Identity <cloud mailbox> -ImmutableId <UPN>
          ```

          For example: `Set-RemoteMailbox user@contoso.com -ImmutableId user@contoso.onmicrosoft.com`.

       2. Sync the change to the cloud by running the following PowerShell cmdlets in the EMS:

          ```PowerShell
          Import-Module ADSync
          Start-ADSyncSyncCycle -PolicyType Delta
          ```

          To verify that the `ImmutableId` value was updated, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

          ```PowerShell
          Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
          ```

       3. Revert the `ImmutableId` of the remote mailbox object to null by running the following PowerShell cmdlet in the EMS:

          ```PowerShell
          Set-RemoteMailbox -Identity <cloud mailbox> -ImmutableId $null
          ```

       4. Sync the change to the cloud by running the following PowerShell cmdlet in the EMS:

          ```PowerShell
          Start-ADSyncSyncCycle -PolicyType Delta
          ```

          Verify that the `ImmutableId` value was updated. To do this, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

          ```PowerShell
          Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
          ```

     - **ImmutableId value isn't null**

       If the `ImmutableId` value isn't null, run the following command in the EMS to set the `ImmutableId` value to null:

       ```PowerShell
       Set-RemoteMailbox -Identity <user> -ImmutableId $null
       ```

       To verify that the `ImmutableId` value was updated, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

       ```PowerShell
       Get-Mailbox -Identity <cloud mailbox> | FL UserPrincipalName,ImmutableId
       ```

4. Check the organization relationship settings. For more information, see [Demystifying Hybrid Free/Busy](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-what-are-the-moving-parts/ba-p/607704).

5. If the error message is generated for a cloud user who can't view the free/busy information for an on-premises user, follow these steps:

   1. Run the following PowerShell cmdlet:

      ```PowerShell
      Test-FederationTrust -UserIdentity <on-premises user> -Verbose -Debug
      ```

   2. Re-create the federation trust. For more information, see [Remove a federation trust](/exchange/remove-a-federation-trust-exchange-2013-help) and [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).

[Back to top](#resolve-freebusy-errors)

## The result set contains too many calendar entries

**LID: 54796**

### Issue

You have a cloud user who can't view the free/busy information for another cloud user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Exception: The result set contains too many calendar entries. The allowed size = 1000; the actual size = 5009.

This error occurs if the number of calendar entries in a single timeslot exceeds 1,000 items. A single free/busy request can't retrieve more than 1,000 items.

### Resolution

Remove some of the calendar items from the timeslot so as not to exceed the limit of 1,000 items that can be retrieved in a single free/busy request.

For more information, see [You can't view free/busy information on another user's Calendar in Exchange Online](/exchange/troubleshoot/calendars/cannot-view-another-user-calendar-free-busy-information).

[Back to top](#resolve-freebusy-errors)

## Work hours start time must be less than or equal to end time

### Issue

You have a cloud user who can't view the free/busy information for a room list. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Exception: Microsoft.Exchange.InfoWorker.Common.InvalidParameterException: Work hours start time must be less than or equal to end time.  
> Microsoft.Exchange.InfoWorker.Common.MeetingSuggestions.AttendeeWorkHours.Validate(TimeSpan startTime, TimeSpan endTime).

This error might occur if one or more of the following calendar settings for a room mailbox in a room list are invalid:

- `WorkingHoursStartTime`
- `WorkingHoursEndTime`
- `WorkingHoursTimeZone`

The work hours start time must be less than or equal to the work hours end time, and the work hours' time zone must be set.

### Resolution

To fix the issue, follow these steps:

1. Run the following PowerShell cmdlet to check the calendar settings of each mailbox in the room list to identify the room mailbox that has invalid settings:

   ```PowerShell
   Get-DistributionGroupMember -Identity <room list name> | Get-MailboxCalendarConfiguration | FL Identity,WorkingHours* 
   ```

2. Run the following PowerShell cmdlet to set the required parameter values for a room mailbox:

   ```PowerShell
   Set-MailboxCalendarConfiguration -Identity <room ID> -WorkingHoursStartTime <start time> -WorkingHoursEndTime <end time> -WorkingHoursTimeZone <time zone>
   ```

   For more information, see [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration).

[Back to top](#resolve-freebusy-errors)

## The request failed with HTTP status 401: Unauthorized (token has an invalid signature)

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> System.Net.WebException: The request failed with HTTP status 401: Unauthorized.

When you run the following PowerShell cmdlet to test OAuth authentication:

```PowerShell
Test-OAuthConnectivity -Service EWS -TargetUri <external EWS URL> -Mailbox <cloud mailbox ID> -Verbose | FL
```

You receive the following command output:

```Output
System.Net.WebException: The remote server returned an error: (401) Unauthorized. Boolean reloadConfig, diagnostics: 2000000; reason="The token has an invalid signature.";error_category="invalid_signature".
```

**Note**: The `TargetUri` parameter value in the Test-OAuthConnectivity command is an external Exchange Web Services (EWS) URL, such as `https://mail.contoso.com/ews/exchange.asmx`.

This error might occur if the Microsoft authorization server settings are invalid.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Refresh the authorization metadata on the specified Microsoft authorization server that's trusted by Exchange. Run the following PowerShell cmdlet in the EMS (on-premises):

   ```PowerShell
   Set-AuthServer <name of the authorization server> -RefreshAuthMetadata 
   ```

   Wait about 15 minutes for the command to fully take effect, or restart IIS by running the `iisreset /noforce` command in a PowerShell or Command Prompt window on each Exchange Server.

2. Check the Microsoft authorization server settings in your Exchange organization by running the following PowerShell cmdlet in the EMS:

   ```PowerShell
   Get-AuthServer | FL Name, IssuerIdentifier, TokenIssuingEndpoint, AuthMetadataUrl, Enabled
   ```

   The following command output is an example of valid settings:

   ```Output
   Name : WindowsAzureACS
   IssuerIdentifier : 00000001-0000-0000-c000-000000000000
   TokenIssuingEndpoint : https://accounts.accesscontrol.windows.net/XXXXXXXX-5045-4d00-a59a-c7896ef052a1/tokens/OAuth/2
   AuthMetadataUrl : https://accounts.accesscontrol.windows.net/contoso.com/metadata/json/1
   Enabled : True
   ```

   If the Microsoft authorization server settings aren't valid, try rerunning the Hybrid Configuration Wizard to reset the Microsoft authorization server settings to valid values.

[Back to top](#resolve-freebusy-errors)

## The request failed with HTTP status 401: Unauthorized (key was not found)

### Issue

You have an on-premises user who can't view the free/busy information for a cloud user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> System.Net.WebException: The request failed with HTTP status 401: Unauthorized.

When you run the following PowerShell cmdlet in the EMS to test OAuth authentication:

```PowerShell
Test-OAuthConnectivity -Service EWS -TargetUri https://outlook.office365.com/ews/exchange.asmx -Mailbox <on-premises mailbox ID> -Verbose | FL
```

You receive the following command output:

> System.Net.WebException: The remote server returned an error: (401) Unauthorized.  
> Error: Unable to get token from Auth Server. Error code: 'invalid_client'. Description: 'AADSTS70002:  
> Error validating credentials. AADSTS50012: Client assertion contains an invalid signature. [Reason - The key was not found., Thumbprint of key used by client: '\<thumbprint\>'.

This error can occur if the OAuth certificate in Exchange Server doesn't exist in Exchange Online.

### Resolution

To fix the issue, use the following steps:

1. Determine whether your on-premises Exchange Server OAuth certificate exists in your Exchange Online organization:

   1. Run the following PowerShell cmdlet in the Exchange Management Shell (EMS) to get the OAuth certificate in Exchange Server:

      ```PowerShell
      Get-ExchangeCertificate -Thumbprint (Get-AuthConfig).CurrentCertificateThumbprint | FL
      ```

      The command output contains the `Thumbprint` value.

   2. Run the following PowerShell cmdlets to get the Exchange Online OAuth certificate by using the [MSOL service](/powershell/azure/active-directory/install-msonlinev1):

      ```PowerShell
      Connect-MsolService
      Get-MsolServicePrincipalCredential -ServicePrincipalName "00000002-0000-0ff1-ce00-000000000000" -ReturnKeyValues $true
      ```

      If the `Value` parameter value in the command output is empty, an OAuth certificate doesn't exist in Exchange Online. In that case, go to step 3 to upload the on-premises certificate to Exchange Online.

      If the `Value` parameter value isn't empty, save the value to a file that has a ".cer" extension. Open the file in Microsoft [Certificate Manager tool](/dotnet/framework/tools/certmgr-exe-certificate-manager-tool) to view the Exchange Online OAuth certificate. Compare the `Thumbprint` value in the Exchange Online certificate to the thumbprint of the on-premises certificate that you obtained in step 1a. If the thumbprint values match, go to step 4. If the thumbprint values don't match, choose one of the following options:

      - Go to step 2 to replace the existing on-premises certificate with the Exchange Online certificate.

      - Go to step 3 to replace the existing Exchange Online certificate with the on-premises certificate.

2. Replace the existing on-premises certificate with the Exchange Online certificate:

   1. Run the following PowerShell cmdlet to update the on-premises certificate thumbprint:

      ```PowerShell
      Set-AuthConfig -NewCertificateThumbprint <thumbprint of Exchange Online certificate> -NewCertificateEffectiveDate (Get-Date) 
      ```

      If you're notified that the certificate effective date is less than 48 hours from now, accept the prompt to continue.

   2. Run the following PowerShell cmdlet to publish the on-premises certificate:

      ```PowerShell
      Set-AuthConfig -PublishCertificate  
      ```

   3. Run the following PowerShell cmdlet to remove any references to the previous certificate: 

      ```PowerShell
      Set-AuthConfig -ClearPreviousCertificate 
      ```

   4. Go to step 4.

3. [Export the on-premises authorization certificate](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#step-3-export-the-on-premises-authorization-certificate), and then [upload the certificate to your Exchange Online organization](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#step-4-upload-the-on-premises-authorization-certificate-to-microsoft-entra-access-control-service-acs).

4. Run the following PowerShell cmdlet to check whether the SPN in the on-premises authentication configuration is `00000002-0000-0ff1-ce00-000000000000`:

   ```PowerShell
   Get-AuthConfig | FL ServiceName
   ```

   If the SPN value is different, update the SPN by running the following PowerShell cmdlet:

   ```PowerShell
   Set-AuthConfig -ServiceName "00000002-0000-0ff1-ce00-000000000000"
   ```

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed: Response is not well-formed XML

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed., inner exception: Response is not well-formed XML

If you run the [Synchronization, Notification, Availability, and Automatic Replies test](https://testconnectivity.microsoft.com/tests/O365EwsTask/input) for the on-premises user, you receive the following error message:

> The response received from the service didn't contain valid XML

These errors can occur for any of the following reasons:

- External Exchange Web Services (EWS) issue
- Misconfiguration of network devices, such as a reverse proxy or firewall

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Check whether a free/busy request from Exchange Online can reach IIS on an Exchange server. Perform a free/busy query and then search the IIS logs for entries that have HTTP status code `200 OK` or `401 Unauthorized` at the time of the query. Those entries indicate that the free/busy request reached IIS. **Note**: Timestamps in IIS logs use UTC time.

   If you don't find those entries, check the reverse proxy and firewall logs to determine where the free/busy request got stuck.

2. Perform a free/busy query, and then search the Exchange Server application log in the Windows Event Viewer for entries that were made at the time of the query to help narrow down the cause of the issue.

[Back to top](#resolve-freebusy-errors)

## Unable to connect to the remote server

### Issue

You have an on-premises user who can't view the free/busy information for a cloud user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Failed to communicate with `https://login.microsoftonline.com/extSTS.srf`., inner exception: Unable to connect to the remote server.

This error might occur if one or more Exchange servers can't connect to a Microsoft Federation Gateway URL.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Run the following PowerShell cmdlets in the Exchange Management Shell (EMS) to check whether you can retrieve a delegation token:

   ```PowerShell
   Test-OrganizationRelationship -Identity "On-premises to O365*" -UserIdentity <on-premises user ID> -Verbose
   Test-FederationTrust -UserIdentity <on-premises user ID> -Verbose
   Test-FederationTrustCertificate
   ```

2. Verify that your on-premises Exchange servers have outbound internet access to both of the following resources:

   - The Microsoft Federation Gateway, or the Microsoft authorization server if you use OAuth authentication.

   - The availability URL for Microsoft 365: `https://outlook.office365.com/ews/exchange.asmx`.

   For more information, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges) and [Firewall considerations for federated delegation](/previous-versions/office/exchange-server-2010/dd638083(v=exchg.141)).

3. Verify that the System account in Exchange Server has internet access to the following URLs. Follow these steps on all Exchange Servers in your organization:

   1. Run the following [PsExec](/sysinternals/downloads/psexec) command to start a PowerShell session that launches a web browser from the System account:

      ```PowerShell
      PsExec.exe -i -s "C:\Program Files\Internet Explorer\iexplore.exe"
      ```

   2. Test browser access (no OAuth authentication) from the System account to the following Microsoft Federation Gateway URLs:

      - `https://nexus.microsoftonline-p.com/federationmetadata/2006-12/federationmetadata.xml`

        The browser should display an xml page.

      - `https://login.microsoftonline.com/extSTS.srf`

        The browser should prompt you to download the file.

      - `https://domains.live.com/service/managedelegation2.asmx`

        The browser should display a list of operations that are supported by ManageDelegation2.

   3. Test browser access (OAuth authentication) from the System account to the following Microsoft authorization server URLs:

      - `https://outlook.office365.com/ews/exchange.asmx`

        The browser should display a sign-in prompt.

      - `https://login.windows.net/common/oauth2/authorize`

        The browser should display the sign-in error message, "Sorry, but we're having trouble signing you in."

      - `https://accounts.accesscontrol.windows.net/<tenant guid>/tokens/OAuth/2`

        The browser should display the HTTP status code `400 Bad Request` or the sign-in error message, "Sorry, but we're having trouble signing you in."

[Back to top](#resolve-freebusy-errors)

## Autodiscover failed for email address: The remote name could not be resolved

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Autodiscover failed for E-Mail Address \<user email address\> with error System.Net.WebException: The remote name could not be resolved: '\<on-premises host name\>'.

This error might occur if the on-premises Autodiscover endpoint URL or the public DNS settings are incorrect.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Run the following PowerShell cmdlets in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the value of the `TargetAutodiscoverEpr` parameter:

   ```PowerShell
   Get-IntraOrganizationConnector | FL TargetAutodiscoverEpr
   Get-OrganizationRelationship | FL TargetAutodiscoverEpr
   ```

   For example, if the on-premises hostname value in the error message is `mail.contoso.com`, the Autodiscover endpoint URL is likely to be `https://autodiscover.contoso.com/autodiscover/autodiscover.svc`.

   If the `TargetAutodiscoverEpr` parameter value is correct, go to step 3. Otherwise, go to step 2.

2. Update the Autodiscover endpoint URL by using one of the following methods:

   - Run the Hybrid Configuration Wizard (HCW) to restore the default Autodiscover endpoint.

   - Manually update either the `DiscoveryEndpoint` parameter or the `TargetAutodiscoverEpr` parameter by running either of the following PowerShell cmdlets:

     - `Set-IntraOrganizationConnector -Identity <cloud connector ID> -DiscoveryEndpoint <Autodiscover endpoint URL>`

     - `Set-OrganizationRelationship <O365 to On-premises*> -TargetAutodiscoverEpr <Autodiscover endpoint URL>`

3. Make sure that the on-premises host name in the error message (for example: `mail.contoso.com`) is resolvable in public DNS. The DNS entry for the host name should point to the on-premises Autodiscover service at the Autodiscover endpoint URL.

   **Note**: If you can't fix the issue and you want a temporary workaround, run either of the following PowerShell cmdlets to manually update the `TargetSharingEpr` parameter value to the external Exchange Web Services (EWS) URL. The external EWS URL should resemble `https://<EWS hostname>/ews/exchange.asmx` and be resolvable in DNS.

   - `Set-IntraOrganizationConnector <cloud connector ID> -TargetSharingEpr <external EWS URL>`

   - `Set-OrganizationRelationship <O365 to On-premises*> -TargetSharingEpr <external EWS URL>`

   > [!NOTE]
   > If you set the `TargetSharingEpr` parameter value, the cloud mailbox bypasses Autodiscover and connects directly to the EWS endpoint.

[Back to top](#resolve-freebusy-errors)

## Failed to get ASURL. Error 8004010F

### Issue

You have an on-premises user who can't view the free/busy information for a cloud user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Failed to get ASURL. Error 8004010F.

This is a general error that's related to the Autodiscover service.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Make sure that Autodiscover for the affected user returns the Exchange Web Services (EWS) URL for the user.

2. Run the [email autoconfiguration test](https://answers.microsoft.com/en-us/msoffice/forum/all/mailboxes-test-e-mail-autoconfiguration/19f9c90a-4640-46c4-a574-dbec29bdb8ba) in the affected user's Outlook client to make sure that Autodiscover returns the EWS URL for the user.

3. Make sure that free/busy works between on-premises users who are hosted on different Exchange servers.

4. If you have load balancers, check whether the load balancers caused the issue. To do this, [modify the Windows Hosts file](/windows/powertoys/hosts-file-editor) (on the computer that has the user's Outlook client installed) to bypass the load balancers and point to a specific Client Access server.

5. If free/busy works between on-premises users, check whether all on-premises Exchange servers have outbound access to [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges#microsoft-365-common-and-office-online).

6. Check whether each Exchange server can retrieve a delegation token. To do this, run the following PowerShell cmdlet in the EMS on all on-premises Exchange servers:

   ```PowerShell
   Test-FederationTrust -UserIdentity <on-premises user ID> -Verbose
   ```

   If the command fails to retrieve a delegation token, check whether the server can connect to Office 365 at the proxy or firewall level.

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed: Object moved

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed. , inner exception: System.Net.WebException: The request failed with the error message: Object moved.

This error might occur if the `TargetSharingEpr` parameter value in the organization settings is set to an incorrect Exchange Web Services (EWS) endpoint URL.

You can run the following PowerShell cmdlets to get the `TargetSharingEpr` parameter value from the organization settings (intra-organization connector or organization relationship):

```PowerShell
Get-IntraOrganizationConnector | FL TargetSharingEpr
Get-OrganizationRelationship | FL TargetSharingEpr
```

Verify that the `TargetSharingEpr` parameter value doesn't resolve in public DNS.

**Note**: The Hybrid Configuration Wizard (HCW) doesn't set a value for the `TargetSharingEpr` parameter unless you select **Use Exchange Modern Hybrid Technology** to [install a Hybrid Agent](/exchange/hybrid-deployment/hybrid-agent). In that scenario, the HCW sets the `TargetSharingEpr` parameter to an external EWS URL endpoint value that resembles `https://<GUID>.resource.mailboxmigration.his.msappproxy.net/ews/exchange.asmx`. You can also set the `TargetSharingEpr` parameter value manually. If the `TargetSharingEpr` value is set to an endpoint, Outlook bypasses Autodiscover and connects directly to that endpoint.

### Resolution

To fix the issue, run either of the following commands to manually update the `TargetSharingEpr` parameter value to an external EWS URL that resolves in DNS:

- `Set-IntraOrganizationConnector <cloud connector ID> -TargetSharingEpr <external EWS URL>`
- `Set-OrganizationRelationship <O365 to On-premises*> -TargetSharingEpr <external EWS URL>`

[Back to top](#resolve-freebusy-errors)

## The request was aborted: Could not create SSL/TLS secure channel

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user, or vice versa. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The request was aborted: Could not create SSL/TLS secure channel.

**Cause 1: Cloud user can't view the free/busy information for an on-premises user**

The issue might occur if TLS 1.2 is misconfigured or disabled in an on-premises endpoint that Microsoft 365 connects to, such as Exchange Server or a firewall.

**Cause 2: On-premises user can't view the free/busy information for a cloud user**

The issue might also occur for any of the following reasons:

- The Microsoft 365 certificate (`outlook.office365.com`) is missing from the [trusted root Certification Authorities (CA) store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store).
- A [Cypher suite](/windows/win32/secauthn/cipher-suites-in-schannel) mismatch exists.
- Other SSL/TLS issues.

### Troubleshooting steps

Use the following tools to diagnose on-premises TLS 1.2 issues:

- Run the [SSL server test](https://testconnectivity.microsoft.com/tests/SslServer/input) in the Microsoft Remote Connectivity Analyzer.
- Run the [HealthChecker script](https://microsoft.github.io/CSS-Exchange/Diagnostics/HealthChecker/) in the Exchange Management Shell (EMS) on each Exchange server.

For information about TLS configuration, see [Exchange Server TLS configuration best practices](/exchange/plan-and-deploy/post-installation-tasks/security-best-practices/exchange-tls-configuration) and [Preparing for TLS 1.2](/purview/prepare-tls-1.2-in-office-365).

For information about how to check for certificates in the trusted root CA store, see [View certificates with the MMC snap-in](/dotnet/framework/wcf/feature-details/how-to-view-certificates-with-the-mmc-snap-in).

For information about supported TLS cipher suites, see [TLS cipher suites supported by Microsoft 365](/purview/technical-reference-details-about-encryption).

[Back to top](#resolve-freebusy-errors)

## The user specified by the user-context in the token does not exist

### Issue

You have an on-premises user who can't view the free/busy information for a cloud user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The user specified by the user-context in the token does not exist. error_category="invalid_user". 401: Unauthorized.

You get the same error message if you run the [Test-OAuthConnectivity](/powershell/module/exchange/test-oauthconnectivity) PowerShell cmdlet.

The error might occur if the on-premises user mailbox and the corresponding mail-user object in Microsoft Entra ID aren't synced. Until they're synced, the mail-user object in Microsoft Entra ID might be unprovisioned.

### Resolution

To fix the issue, use [Microsoft Entra Connect](/entra/identity/hybrid/connect/whatis-azure-ad-connect) to sync the on-premises user and the corresponding mail-user object in Microsoft Entra ID.

[Back to top](#resolve-freebusy-errors)

## The hostname component of the audience claim value is invalid

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> The hostname component of the audience claim value 'https://\<hybrid.domain.com\>' is invalid; error_category="invalid_resource" 

The error can occur for either of the following reasons.

**Cause 1**

SSL offloading and OAuth authentication are both enabled. SSL offloading doesn't work if OAuth authentication is enabled.

**Cause 2**

A network device in front of Exchange Server is blocking free/busy requests.

### Solution

**Workaround for Cause 1**

Select either of the following workarounds:

- Disable SSL offloading for both Exchange Web Services (EWS) and Autodiscover in the on-premises environment. For more information, see [Configuring SSL offloading for the Autodiscover](/exchange/configuring-ssl-offloading-in-exchange-2013-exchange-2013-help#configuring-ssl-offloading-for-the-autodiscover-service) and [Configuring SSL offloading for EWS](/exchange/configuring-ssl-offloading-in-exchange-2013-exchange-2013-help#configuring-ssl-offloading-for-exchange-web-services-ews), and [default SSL settings](/exchange/clients/default-virtual-directory-settings).

- Run the following PowerShell cmdlet to disable OAuth authentication by disabling the cloud intra-organization connector:

  ```PowerShell
  Set-IntraOrganizationConnector "HybridIOC*" -Enabled $false
  ```

  When the intra-organization connector is disabled, DAuth authentication is enabled through the organization relationship. To check the organization relationship, run the following PowerShell cmdlet:

  ```PowerShell
  Get-OrganizationRelationship
  ```

  For more information about the organization relationship settings, see [Demystifying Hybrid Free/Busy](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-what-are-the-moving-parts/ba-p/607704).

**Resolution for Cause 2**

Configure the network device in front of Exchange not to block free/busy requests.

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed with HTTP status 503: Service unavailable

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed, inner exception: System.Net.WebException: The request failed with HTTP status 503: Service Unavailable...

This error might occur if there's a stopped Microsoft Windows service, server component, IIS application pool, or a misconfigured endpoint.

### Troubleshooting steps

After you complete each step, check whether the free/busy issue is fixed.

1. Make sure that the Windows services that Exchange Server requires are running. To check the status of services, run the following PowerShell cmdlet on each Exchange server in your organization:

   ```PowerShell
   Test-ServiceHealth
   ```

   Use the Services console to start any stopped services that are required by Exchange Server.

2. Check that the required Exchange Server components are active. To check the status of components, run the following PowerShell cmdlet on each Exchange server in your organization:

   ```PowerShell
   Get-ServerComponentState <server name>
   ```

   To activate an inactive component, use the [Set-ServerComponentState](/powershell/module/exchange/set-servercomponentstate) PowerShell cmdlet.

3. Make sure that the following IIS application pools for Exchange Web Services (EWS) and Autodiscover are started:

   - MSExchangeServicesAppPool
   - MSExchangeSyncAppPool
   - MSExchangeAutodiscoverAppPool

4. Test whether the Autodiscover endpoint is valid. Follow these steps:

   1. Run the following PowerShell cmdlets to get the Autodiscover endpoint URL from the `DiscoveryEndpoint` or `TargetAutodiscoverEpr` parameter values:

      ```PowerShell
      Get-IntraOrganizationConnector | FL DiscoveryEndpoint
      Get-OrganizationRelationship | FL TargetAutodiscoverEpr
      ```

   2. Navigate to the Autodiscover endpoint URL in a web browser, or run the `Invoke-WebRequest -Uri "<endpoint URL>" -Verbose` PowerShell cmdlet, to make sure that the URL valid. Preferably, check the URL from an external network.

5. Test whether the EWS URL is valid by following these steps:

   1. Run the following PowerShell cmdlets to get the EWS URL from the `TargetSharingEpr` parameter value in the organization settings:

      ```PowerShell
      Get-IntraOrganizationConnector | FL TargetSharingEpr
      Get-OrganizationRelationship | FL TargetSharingEpr
      ```

   b. Navigate to the EWS URL in a web browser, or run the `Invoke-WebRequest -Uri "<endpoint URL>" -Verbose` PowerShell cmdlet to make sure that the URL is valid. Preferably, check the URL from an external network.

6. Check the IIS logs for free/busy requests that return HTTP status code `503 Service Unavailable`:

   1. Make a free/busy request from Exchange Online.

   2. Check for HTTP status code `503 Service Unavailable` entries in the IIS logs in the _W3SVC1_ folder for the default website on each Exchange server. The _W3SVC1_ folder path is `%SystemDrive%\inetpub\logs\LogFiles\W3SVC1`. Those entries can help identify the server that has the issue.

   3. If the free/busy request isn't logged in the _W3SVC1_ folder, check whether the request is logged in the error logs in the _HTTPERR_ folder on each Exchange server. The _HTTPERR_ folder path is `%SystemRoot%\System32\LogFiles\HTTPERR`. If the free/busy request is logged in the _HTTPERR_ logs, check for misconfigured IIS settings.

7. Check the header of the server response that you receive when you connect to the on-premises EWS URL to verify that IIS (not a different web server) sent the response. To do this, run the following commands in a PowerShell session that isn't connected to on-premises EWS (don't run the commands in the Exchange Management Shell):

   ```PowerShell
   $req = [System.Net.HttpWebRequest]::Create("<EWS URL>") 
   $req.UseDefaultCredentials = $false $req.GetResponse()
   $ex = $error[0].Exception
   $ex.InnerException.Response $resp.Headers["Server"]
   ```

   For example, if you see "Microsoft-HTTPAPI/2.0" in the command output instead of "Microsoft -IIS/10.0", it's likely that a Web Application Proxy (WAP) service (not IIS) responded to the request. Check whether the WAP service is down.

[Back to top](#resolve-freebusy-errors)

## Proxy web request failed with HTTP status 504: Gateway timeout

**LID: 43532**

### Issue

You have a cloud user who can't view the free/busy information for an on-premises user. When you [diagnose](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) the issue, you find the following error message:

> Proxy web request failed, inner exception: The request failed with HTTP status 504: Gateway Timeout...

This error might occur if a Hybrid Agent in your organization is configured incorrectly.

### Resolution

To fix the issue, use the following steps. After you complete each step, check whether the free/busy issue is fixed.

1. Check the `TargetSharingEpr` parameter value in the organization settings. The value should resemble `https://<GUID>.resource.mailboxmigration.his.msappproxy.net/EWS/Exchange.asmx`. To determine the value of the `TargetSharingEpr` parameter, run the following PowerShell cmdlets:

   ```PowerShell
   Get-IntraOrganizationConnector | FL TargetSharingEpr
   Get-OrganizationRelationship | FL TargetSharingEpr
   ```

   If the `TargetSharingEpr` parameter value is incorrect:

   1. Run the Hybrid Configuration Wizard (HCW), and select **Use Exchange Classic Hybrid Topology**.

   2. Rerun the HCW, and select **Use Exchange Modern Hybrid Topology**. This procedure forces the HCW to reset the `TargetSharingEpr` parameter value.

2. [Check the status of the Microsoft Hybrid Service](/exchange/hybrid-deployment/hybrid-agent) on the server where the Hybrid Agent is installed. If the service is stopped, start it.

3. [Check the status of the Hybrid Agent](/exchange/hybrid-deployment/hybrid-agent). If the status is **Inactive**:

   1. Run the Hybrid Configuration Wizard (HCW), and select **Use Exchange Classic Hybrid Topology**.

   2. Rerun the HCW, and select **Use Exchange Modern Hybrid Topology**. This procedure forces the HCW to reinstall the Hybrid Agent.

   3. Install the [Hybrid Agent PowerShell module](/exchange/hybrid-deployment/hybrid-agent), and then run the [Get-HybridApplication](/exchange/hybrid-deployment/hybrid-agent) PowerShell cmdlet to find the internal URL that the Hybrid Agent points to.

4. Browse to the internal URL that you found in step 3. Resolve any errors that you find, such as certificate errors.

5. [Configure the Hybrid Agent to direct requests to a load balancer](/exchange/hybrid-deployment/hybrid-agent) instead of a server that's running Microsoft Exchange Server to rule out issues that might exist on that server.

6. [Verify that the Hybrid Agent supports free/busy requests and mailbox migration](/exchange/hybrid-deployment/hybrid-agent).

[Back to top](#resolve-freebusy-errors)
