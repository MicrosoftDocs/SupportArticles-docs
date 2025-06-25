---
title: Troubleshoot migration issues in Exchange hybrid
description: Troubleshoots issues with mailbox move in hybrid environment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
---
# Troubleshoot migration issues in Exchange Server hybrid environment

_Original KB number:_ &nbsp; 10094

This article troubleshoots the following issues:

- Problem moving a mailbox from an on-premises Exchange Server environment to Exchange Online (On-Boarding).
- Problem moving a mailbox back on-premises from Exchange Online (Off-boarding).

**Who is it for?**

Exchange Server administrators who run into problems with migration in Hybrid environment.

**How does it work?**

We'll begin by asking you the issue you are facing. Then we'll take you through a series of steps that are specific to your situation.

**Estimated time of completion:**

15-30 minutes.

## Welcome to the Hybrid migration Troubleshooter

If you are having issues determining what the best Migration Approach is for your environment, see [Exchange Deployment Assistant](/exchange/exchange-deployment-assistant?view=exchserver-2019&preserve-view=true).

> [!NOTE]
> This troubleshooter will not help you with troubleshooting Staged, Cutover, or IMAP migrations.

**Were you able to initiate the mailbox move?**

We need to determine if the mailbox move was successfully initiated, which means you were able to either go through the Exchange Administration Center (EAC), Exchange Management Console (EMC), or Remote PowerShell to begin the move request and you had no issues getting the request started.

- [I could not initiate a move request (more common)](#try-to-use-eac-to-perform-the-move)
- [I was able to initiate the move request](#review-the-status-of-the-move-request)
- [I am not certain if the move request was initiated](#review-the-status-of-the-move-request)

### Try to use EAC to perform the move

Mailbox moves are more likely to succeed when they are initiated from Exchange Administration Center (EAC) in Exchange Online. Connect to the EAC in Exchange Online and see if you can initiate the move from there.

#### Remove migration endpoint

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
2. In the top ribbon, select **Admin** and then select **Exchange**.
3. Select **Migration**.
4. Select on the ellipses (...) and select **Migration endpoints**.
5. Select the endpoint that is listed as **Exchange remote move**.
6. Select on the trash can to delete the endpoint.

#### On-Boarding Steps

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
1. In the top ribbon, select **Admin** and then select **Exchange**.
1. Select **Migration** > **+** > **Migrate to Exchange Online**.
1. On the **Select a migration type** page, select **Remote move migration** as the migration type for a hybrid mailbox move.
1. On the **Select the users** page, select the mailboxes you want to move to the cloud.
1. On the **Enter on-premises account credentials** page.
    > [!IMPORTANT]
    > provide your on-premises administrator credentials in the domain\user format.
1. On the **Confirm the migration endpoint** page, ensure that the on-premises endpoint shown is the CAS with MRS Proxy enabled.
1. Enter a name for the migration batch and initiate the move.

#### Off-Boarding Steps

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
1. In the top ribbon, select **Admin** and then select **Exchange**.
1. Select **Migration** > **+** > **Migrate From Exchange Online**.
1. On the **Select a migration type page**, select **Remote move migration** as the migration type for a hybrid mailbox move.
1. On the **Select the users page**, select the mailboxes you want to move to the cloud.
1. On the **Enter on-premises account credentials** page.
1. Enter the **on-premises Database Name**, this can be retrieve by running Get-MailboxDatabase from EMS.
    > [!IMPORTANT]
    > Provide your on-premises administrator credentials in the **domain\user** format.
1. On the **Confirm the migration endpoint** page, ensure that the on-premises endpoint shown is the CAS with MRS Proxy enabled.
1. Enter a name for the migration batch and initiate the move.

- If your issues are resolved, congratulations! Your scenario is complete.
- If your move still failed to initiate, see [Ensure that the migration endpoint is enabled and that the proper Authentication options are in place](#ensure-that-the-migration-endpoint-is-enabled-and-that-the-proper-authentication-options-are-in-place).

### Ensure that the migration endpoint is enabled and that the proper Authentication options are in place

When you are moving a mailbox to or from the cloud, we make a connection to the on-premises environment to the MRSProxy endpoint. Verify that the MRSProxy endpoint and the WSSecurity authentication type are enabled.

1. Open the Exchange Management Shell on the Exchange Server 2010 or 2013 hybrid server.
2. Check to see if the **MRSProxyEnabled** and **WSSecurityAuthentication** are both set to **True**. To do this, run the following cmdlet. The word Server in the below cmdlets should reflect the names of the external facing Exchange servers:

   ```powershell
   Get-WebServicesVirtualDirectory -Identity "Server\EWS (default Web site)" |fl Server,MRSProxyEnabled,WSSecurityAuthentication
   ```

3. If either is false run the following to enable the MRSProxy and set the authentication required to perform the move. To do this, run the following cmdlet:

   ```powershell
   Set-WebServicesVirtualDirectory -Identity "Server\EWS (default Web site)" -MRSProxyEnabled $true - WSSecurityAuthentication $True
   ```

> [!NOTE]
> These settings should be configured on all of the external facing Exchange servers.

- If your issues are resolved, congratulations! Your scenario is complete.
- [I have verified that MRSProxy and Authentication settings, what next?](#do-you-have-firewall-and-intrusion-detection-system-ids-properly-configured)

### Do you have Firewall and Intrusion Detection System (IDS) properly configured

You need to ensure that you have your firewall configured to allow certain EWS and Autodiscover endpoints to come through to the Exchange servers without being authenticated at a perimeter device. Additionally, you need to ensure that the migration requests are not treated like a denial of service attack.

#### Firewall endpoint/pre-authentication settings

The following are the instructions for how to properly publish EWS and Autodiscover via TMG, but you can apply this logic to your own device. Besides the explicit steps for TMG, at a high level you need to do the following:

1. Create a new publishing rule (often using the same listener that is already in place) that does not require pre-authentication.
2. Ensure that the rule applies to any traffic that comes over the following paths.
   - /ews/mrsproxy.svc
   - /ews/exchange.asmx/wssecurity
   - /autodiscover/autodiscover.svc/wssecurity
   - /autodiscover/autodiscover.svc

3. Ensure that this new rule is higher in priority than any existing Exchange-Related Firewall rules.

#### IDS settings

Hybrid Migrations can sometimes be treated like a denial of service attack by certain devices. The following logic can be applied to any intrusion detection system, but it was written for TMG specifically.

1. Open the Forefront TMG management console, and then in the tree select **Intrusion Prevention System**.
2. Select the **Behavioral Intrusion Detection** tab, and then select **Configure Flood Mitigation Settings**.
3. In the **Flood Mitigation** dialog box, follow these steps:
   - Select the **IP Exceptions** tab, and then type the IP addresses that the Microsoft 365 environment uses to connect during the mailbox move operation.
   - Select the **Flood Mitigation** tab, and then, next to **Maximum HTTP Requests per minute per IP address**, select **Edit**. In the **Custom limit** box, type a number to increase the limit.

     > [!NOTE]
     > The custom limit applies to IP addresses that are listed on the **IP Exceptions** tab. Increase only the custom limit. In the following example screen shot, the custom limit is set to 6,000. Depending on the number of mailboxes that are being moved, this number may not be sufficient. If you still receive the error message, increase the custom limit.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My TMG is properly configured or I do not have TMG, what next?](#remove-existing-move-requests)

### Remove existing move requests

Having a move request (even a successful one) could prevent a mailbox move from taking place. Connect PowerShell to Exchange Online and verify that there is no move request pending for the user in question. If there is a stale move request, you will need to remove it. The following steps outline how to determine if there is an existing move request and remove that request if it exists.

1. Connect to [Exchange Online through PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true) (Not via Exchange Management Shell (EMS)).
2. Run the command `Get-MoveRequest -Identity 'tony@contoso.com'`.
3. If there is a move request that is completed or failed, run `Remove-MoveRequest -Identity 'tony@contoso.com'`.

- If your issues are resolved, congratulations! Your scenario is complete.
- [I have confirmed that there is no stale move requests, what next?](#verify-that-the-appropriate-accepted-domains-are-in-place)

### Verify that the appropriate accepted domains are in place

Often when moving a mailbox to Exchange Online, it will fail because some of the accepted domains are missing in the service. Verify if all of the email domains assigned to this user are added and verified in the service.

1. Open Exchange Management Shell.
2. Run `(Get-Mailbox Tony).EmailAddresses`.
3. Take note of all of the email addresses that follow smtp: and write down the domain names. For instance, if the results include SMTP:`tony@contoso.com`, smtp:`Tony@foo.com`, you would need to write down `Contoso.com` and `Foo.com`.
4. Connect to [Exchange Online through PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true) (Not EMS).
5. Run `Get-AcceptedDomain` and ensure that the results include the domain(s) noted in step 3 above.
6. If any of the domains are missing, you should add and [verify the domain in the portal](/microsoft-365/admin/get-help-with-domains/change-nameservers-at-any-domain-registrar?view=o365-worldwide&preserve-view=true). Alternatively, you can license the user before you move the mailbox. Usually we use the option of licensing a user when one of the domains stamped on the mailbox is a .local or non-routable domain. Non-routable addresses cannot be added to the service therefore they will not be stamped on the user in Exchange Online.

- If your issues are resolved, congratulations! Your scenario is complete.
- [I have verified that the accepted domains are in place, what next?](#ensure-that-iis-is-properly-configured-to-accept-migration-traffic)

### Ensure that IIS is properly configured to accept migration traffic

In order for IIS to properly respond to a migration request we need to ensure that the Handler Mappings are in place. Verify that the EWS and Autodiscover handler mapping are in place.

1. Select the **Internet Information Services (IIS) Manager** from the **Administration Tools** menu.
2. Expand the **Server name**, then **Sites**, then **Default Web Site**, then left-click on **EWS**.
3. In the middle pane, select the **Handler Mappings** option.
4. Look to see if there is a mapping with the following:
   - Name= svc-Integrated
   - Path= *svc
   - State= Enabled
5. Repeat steps 1 through 4, but this time, check the autodiscover virtual directory.
6. If any of the values are missing, perform the remediation steps 7 and 8.

   :::image type="content" source="media/troubleshoot-migration-issues-in-exchange-hybrid/handler-mapping.png" alt-text="Screenshot of the Handler Mappings page under EWS.":::

7. On the Exchange 2010/2013 external facing server(s), open a Command Prompt window, and then move to the following folder:  
   C:\Windows\Microsoft.Net\Framework\v3.0\Windows Communication Foundation\
8. Type the `ServiceModelReg.exe -r` command, and then press Enter.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My IIS has the proper handler mappings in place, what next?](#ensure-that-the-required-attribute-synchronized-properly-this-is-not-a-common-problem)

### Ensure that the required attribute synchronized properly (this is not a common problem)

In order for a mailbox move to succeed you need to have a user account in both on-premises and Exchange Online that has a matching mailbox guid. Verify that the mailbox guid is in place and matches.

1. On the On-Premise Hybrid server, run the following cmdlet via Exchange Management Shell (EMS).

    ```powershell
    Get-RemoteMailbox -Identity "Alias" | fl ExchangeGuid
    ```

2. Connect Windows PowerShell to the Exchange Online, run the following cmdlet.

    ```powershell
    Get-Mailbox -Identity "Alias" | fl ExchangeGuid
    ```

3. If there is no mail user in the on-premises environment, you can perform the following from EMS:

   - Create a new user account:

     ```powershell
     New-MailUser -Name Ayla -SamAccountName Ayla -UserPrincipalName Ayla@contoso.com -ExternalEmailAddress Ayla@Contoso.mail.onmicrosoft.com
     ```

   - Ensure you stamp the newly created account with the proper Exchange GUID retrieved from step 2, this will be done in the On-Premises EMS:

     ```powershell
     Set-MailUser Testuser -ExchangeGuid xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     ```

- If your issues are resolved, congratulations! Your scenario is complete.
- [My move request still failed to initiate.](#run-the-migration-from-powershell)

### Run the migration from PowerShell

Initiating the migration from PowerShell often yields a more actionable error message. The following steps walk you through the process of moving a mailbox from on-premises to Exchange Online via PowerShell.

1. Connect to [Exchange Online through PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) (Not EMS).

2. Then create a variable to store your on-premises admin credentials. The credentials should be stored in the format of contoso\administrator and not `administrator@contoso.com`.

   **$onpremCred = Get-Credential**

3. Then run a cmdlet similar to the following, where `User` is the display name for the account you want to move, `Webmail.consoto.com` is the endpoint that has MRSProxy enabled on-premises, and `contoso.mail.onmicrosoft.com` is the routing domain used in Exchange online.

    ```powershell
    New-MoveRequest -Identity 'User' -Remote -RemoteHostName 'webmail.contoso.com' -RemoteCredential $onpremCred -TargetDeliveryDomain 'contoso.mail.onmicrosoft.com'
    ```

- If your issues are resolved, congratulations! Your scenario is complete.
- [My move request still failed to initiate](#the-issue-was-not-resolved).

### Review the status of the Move request

In order to better direct you in troubleshooting your migration issues, we need to determine the current status of the move requests. In order to determine the status, perform the following steps:

1. Connect to [Exchange Online through PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) (Not via the Exchange Management Shell (EMS)).

2. Run the following to check the status of any moves:

   - Get-MigrationBatch |fl \*status*,Identity
   - Get-MoveRequest |fl \*status*,Identity

- If the move status is Completed/Completed with warnings (link to solved page), congratulations! Your scenario is complete.
- [The move status is Suspended/Queued/In-Progress/Completion in progress/Syncing](#proper-expectations-for-mailbox-moves)
- [The move request status is Failed](#bypass-mailbox-and-item-level-corruption-issues)
- [No move request was returned](#try-to-use-eac-to-perform-the-move)

### Proper expectations for mailbox moves

Mailbox moves and migration batches are not handled at the same priority as client connectivity and mail flow tasks. Therefore if your server or the Microsoft datacenter is under heavy load, the Mailbox moves may be delayed. There is no reason to be alarmed if a move is in a queued state for a good deal of time since the move will more than likely be picked up relatively soon. It is best to not start troubleshooting a stalled move until there had been a long enough delay (such as 8 hours) with no progress or activity.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My move request is still not complete](#migrate-using-online-mode)

### Migrate using Online mode

If you are migrating from an Exchange 2003 server, it is better for user experience and performance if you move the mailbox first to Exchange Server 2010 then to Exchange Online.

Some customers choose to do two-hop migrations for large and sensitive Exchange Server 2003 mailboxes:

- **First hop** Migrate mailboxes from Exchange Server 2003 to an Exchange 2010 server, which is usually the hybrid coexistence server. The first hop is an offline move, but it's usually a very fast migration over a local network.
- **Second hop** Migrate mailboxes from Exchange Server 2010 to Microsoft 365.The second hop is an online move, which provides a better user experience and fault tolerance.

If your issues are resolved, congratulations! Your scenario is complete.

If your issues aren't resolved, see [My move request is still not complete or this step does not apply.](#network-performance-factors-to-consider)

### Network Performance factors to consider

This section describes best practices for improving network performance during migrations. The discussion is generally because the biggest impact on network performance during migration is related to third-party hardware and Internet service providers (ISPs). The [Microsoft 365 network connectivity test tool](/microsoft-365/enterprise/office-365-network-mac-perf-onboarding-tool) helps analyze network-related issues prior to deploying Microsoft 365 services.

For more information, see the following articles:

- [Microsoft 365 network connectivity test tool](/microsoft-365/enterprise/office-365-network-mac-perf-onboarding-tool)
- [Network connectivity in the Microsoft 365 Admin Center](/microsoft-365/enterprise/office-365-network-mac-perf-overview)

### Have an Intrusion detection issue (IDS)

Intrusion detection functionality configured on a network firewall often causes significant network delays and affects migration performance.

Add IP addresses for Microsoft data center servers to your allow list. For more information about the Microsoft 365 IP ranges, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true).

#### IDS settings

Hybrid Migrations can sometimes be treated like a denial of service attack by certain devices. The following logic can be applied to any intrusion detection system, but it was written for TMG specifically.

1. Open the Forefront TMG management console, and then in the tree select **Intrusion Prevention System**.

2. Select the **Behavioral Intrusion Detection** tab, and then select **Configure Flood Mitigation Settings**.

3. Expand this imageIn the Flood Mitigation dialog box, follow these steps:

   - Select the **IP Exceptions** tab, and then type the IP addresses that the Microsoft 365 environment uses to connect during the mailbox move operation. To view a list of the IP address ranges and URLs that are used by Exchange Online in Microsoft 365, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true).

   - Select the **Flood Mitigation** tab, and then, next to **Maximum HTTP Requests per minute per IP address**, select **Edit**. In the **Custom limit** box, type a number to increase the limit.

      > [!NOTE]
      > The custom limit applies to IP addresses that are listed on the **IP Exceptions** tab. Increase only the custom limit. In the following example screen shot, the custom limit is set to 6,000. Depending on the number of mailboxes that are being moved, this number may not be sufficient. If you still receive the error message, increase the custom limit.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My move request is still not complete or this does not apply.](#bypass-mailbox-and-item-level-corruption-issues-if-move-request-is-still-not-complete)

### Try to use the Exchange Administration Center (EAC) to perform the move

Mailbox moves are more likely to succeed when they are initiated from Exchange Administration Center (EAC) in Exchange Online. Connect to the EAC in Exchange Online and see if you can initiate the move from there.

#### Remove migration endpoint

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
2. In the top ribbon, select **Admin** and then select **Exchange**.
3. Select **Migration**.
4. Select on the ellipses (...) and select **Migration endpoints**.
5. Select the endpoint that is listed as **Exchange remote move**.
6. Select on the trash can to delete the endpoint.

#### On-Boarding Steps

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
1. In the top ribbon, select **Admin** and then select **Exchange**.
1. Select **Migration** > **+** > **Migrate to Exchange Online**.
1. On the **Select a migration type** page, select **Remote move migration** as the migration type for a hybrid mailbox move.
1. On the **Select the users** page, select the mailboxes you want to move to the cloud.
1. On the **Enter on-premises account credentials** page.
    > [!IMPORTANT]
    > provide your on-premises administrator credentials in the domain\user format.
1. On the **Confirm the migration endpoint** page, ensure that the on-premises endpoint shown is the CAS with MRS Proxy enabled.
1. Enter a name for the migration batch and initiate the move.

#### Off-Boarding Steps

1. Log into [https://portal.MicrosoftOnline.com](https://portal.microsoftonline.com/) with your tenant administrator credentials.
1. In the top ribbon, select **Admin** and then select **Exchange**.
1. Select **Migration** > **+** > **Migrate From Exchange Online**.
1. On the **Select a migration type page**, select **Remote move migration** as the migration type for a hybrid mailbox move.
1. On the **Select the users page**, select the mailboxes you want to move to the cloud.
1. On the **Enter on-premises account credentials** page.
1. Enter the **on-premises Database Name**, this can be retrieve by running Get-MailboxDatabase from EMS.
    > [!IMPORTANT]
    > Provide your on-premises administrator credentials in the **domain\user** format.
1. On the **Confirm the migration endpoint** page, ensure that the on-premises endpoint shown is the CAS with MRS Proxy enabled.
1. Enter a name for the migration batch and initiate the move.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My move still failed to initiate.](#do-you-have-your-firewall-and-intrusion-detection-system-ids-properly-configured)

### Do you have your Firewall and Intrusion Detection System (IDS) properly configured

You need to ensure that you have your firewall configured to allow certain EWS and Autodiscover endpoints to come through to the Exchange servers without being authenticated at a perimeter device. Additionally, you need to ensure that the migration requests are not treated like a denial of service attack.

#### Firewall endpoint/pre-authentication settings

The following are the instructions for how to properly publish EWS and Autodiscover via TMG, but you can apply this logic to your own device. Besides the explicit steps for TMG, at a high level you need to do the following:

1. Create a new publishing rule (often using the same listener that is already in place) that does not require pre-authentication.
2. Ensure that the rule applies to any traffic that comes over the following paths.
   - /ews/mrsproxy.svc
   - /ews/exchange.asmx/wssecurity
   - /autodiscover/autodiscover.svc/wssecurity
   - /autodiscover/autodiscover.svc

3. Ensure that this new rule is higher in priority than any existing Exchange-Related Firewall rules.

#### IDS settings

Hybrid Migrations can sometimes be treated like a denial of service attack by certain devices. The following logic can be applied to any intrusion detection system, but it was written for TMG specifically.

1. Open the Forefront TMG management console, and then in the tree select **Intrusion Prevention System**.
2. Select the **Behavioral Intrusion Detection** tab, and then select **Configure Flood Mitigation Settings**.
3. In the **Flood Mitigation** dialog box, follow these steps:
   - Select the **IP Exceptions** tab, and then type the IP addresses that the Microsoft 365 environment uses to connect during the mailbox move operation.
   - Select the **Flood Mitigation** tab, and then, next to **Maximum HTTP Requests per minute per IP address**, select **Edit**. In the **Custom limit** box, type a number to increase the limit.

     > [!NOTE]
     > The custom limit applies to IP addresses that are listed on the **IP Exceptions** tab. Increase only the custom limit. In the following example screen shot, the custom limit is set to 6,000. Depending on the number of mailboxes that are being moved, this number may not be sufficient. If you still receive the error message, increase the custom limit.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My TMG is proper configured or I do not have TMG, what next?](#ensure-that-iis-is-properly-set-to-accept-migration-traffic)

### Ensure that IIS is properly set to accept migration traffic

In order for IIS to properly respond to a migration request we need to ensure that the Handler Mappings are in place. Verify that the EWS and Autodiscover handler mapping are in place.

1. Select the **Internet Information Services (IIS) Manager** from the **Administration Tools** menu.
2. Expand the **Server name**, then **Sites**, then **Default Web Site**, then left-click on **EWS**.
3. In the middle pane, select the **Handler Mappings** option.
4. Look to see if there is a mapping with the following:
   - Name= svc-Integrated
   - Path= *svc
   - State= Enabled
5. Repeat steps 1 through 4, but this time, check the autodiscover virtual directory.
6. If any of the values are missing, perform the remediation steps 7 and 8.

   :::image type="content" source="media/troubleshoot-migration-issues-in-exchange-hybrid/handler-mapping.png" alt-text="Screenshot of the Handler Mappings page showing the correct values.":::

7. On the Exchange Server 2010 or 2013 external facing server(s), open a Command Prompt window, and then move to the following folder:  
   C:\Windows\Microsoft.Net\Framework\v3.0\Windows Communication Foundation\
8. Type the `ServiceModelReg.exe -r` command, and then press Enter.

- If your issues are resolved, congratulations! Your scenario is complete.
- [My IIS has the proper handler mappings in place, what next?](#move-mailbox-to-a-different-on-premises-server)

### Move mailbox to a different on-premises server

Often migration issues are caused by corrupt items or mailboxes. These issues can often be resolved by moving a mailbox between two different on-premises mailbox databases. The following walks you through the process of moving a user's mailbox from one database to another, then moving the mailbox to Exchange Online (if this is an off-boarding request, this step will need to be skipped).

- If your issues are resolved, congratulations! Your scenario is complete.
- [My mailbox was move to a different database or this does not apply, what next?](#migration-batches-stuck-and-try-to-use-move-requests-instead)

### Migration batches stuck and Try to use move requests instead

Sometimes a migration batch may become stuck at a certain stage of migration such as Completing. You may be able to get past this by cleaning up the old move requests.

1. Open PowerShell (Not via EMS) and connect to [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following to ensure that the move request completion was initiated:

    ```powershell
    Get-MoveRequest | ? {$_.Status -eq "AutoSuspended"} | Resume-MoveRequest
    ```

3. After giving time for the resumed move requests to complete, run the following:

    ```powershell
    Get-MoveRequest | ? {$_.Status -eq "Completed"} | Remove-MoveRequest
    ```

4. Remove any existing Migration batches:

    ```powershell
    Remove-MigrationBatch "Batch Name" -Force
    ```

- If your issues are resolved, congratulations! Your scenario is complete.
- [Resuming and cleaning up the move requests did not help.](#the-issue-was-not-resolved)

### Bypass mailbox and Item level corruption issues (if move request is still not complete)

Often a Mailbox move will fail due to item or mailbox level corruption. Allowing for some of the corrupt items to be skipped is often a good way to get a mailbox moved. However, there is the possibility of data loss if you use the below options

1. Open PowerShell (Not via EMS) and connect to [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell).

2. Create a variable to store your on-premises admin credentials. The credentials should be stored in the format of contoso\administrator and not `administrator@contoso.com`.  
   **$onpremCred = Get-Credential**

3. Then run a cmdlet similar to the following, where `User` is the display name for the account you want to move, `Webmail.consoto.com` is the endpoint that has MRSProxy enabled on-premises (usually this matches the OWA endpoint), and `contoso.mail.onmicrosoft.com` is the routing domain used in Exchange Online.

   **Example**: The following example may result in a minor loss of data since you are allowing some items to be skipped due to corruption:
  
   ```powershell
   New-MoveRequest -Identity 'User' -Remote -RemoteHostName 'webmail.contoso.com' -RemoteCredential $onpremCred -TargetDeliveryDomain 'contoso.mail.onmicrosoft.com' -BadItemLimit 40
   ```

- If the issue is resolved, congratulations! Your scenario is complete.
- [My move request still failed to initiate.](#the-issue-was-not-resolved)

### The issue was not resolved

Sorry, we couldn't resolve your issue with this guide. Provide feedback on this guide, and then use the resources below to continue troubleshooting. Visit the [Microsoft 365 Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1) for self-help support. Do one of the following:

- Use search to find a solution to your issue.
- Use the Help Center or the Troubleshooting tool that are both available from the top of every community page.
- Sign in with your Microsoft 365 admin credentials, and then post a question to the community.

### Bypass mailbox and Item level corruption issues

Often a Mailbox move will fail due to item or mailbox level corruption. Allowing for some of the corrupt items to be skipped is often a good way to get a mailbox moved. However, there is the possibility of data loss if you use the below options.

1. Open PowerShell (Not via EMS) and connect to [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell).

1. Create a variable to store your on-premises admin credentials. The credentials should be stored in the format of contoso\administrator and not `administrator@contoso.com`.  
    **$onpremCred = Get-Credential**

1. Then run a cmdlet similar to the following, where `User` is the display name for the account you want to move, `Webmail.consoto.com` is the endpoint that has MRSProxy enabled on-premises (usually this matches the OWA endpoint), and `contoso.mail.onmicrosoft.com` is the routing domain used in Exchange online.

   **Example**: The following example may result in a minor loss of data since you are allowing some items to be skipped due to corruption:

   ```powershell
   New-MoveRequest -Identity 'User' -Remote -RemoteHostName 'webmail.contoso.com' -RemoteCredential $onpremCred -TargetDeliveryDomain 'contoso.mail.onmicrosoft.com' -BadItemLimit 40
   ```

- If the issue is resolved, congratulations! Your scenario is complete.
- [My move request still failed.](#try-to-use-the-exchange-administration-center-eac-to-perform-the-move)
