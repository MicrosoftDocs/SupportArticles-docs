---
title: Troubleshoot free/busy issues in Exchange hybrid
description: Resolves free/busy issues in an Exchange hybrid deployment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Microsoft 365
search.appverid: MET150
---
# Troubleshoot free/busy issues in Exchange hybrid environment

**Who is it for?**

Tenant administrators. Elevated access is required for many of the steps.

**How does it work?**

We'll begin by asking you the issue you are facing. Then we'll take you through a series of troubleshooting steps that are specific to your situation.

**Estimated time of completion:**

30-60 minutes.

## Welcome to the hybrid environment free/busy troubleshooter

Select the option that best describes the issue that you are facing:

> [!NOTE]
> If you want to review how free/busy works in a hybrid deployment, select the **I want to better understand how Hybrid Free/Busy is supposed to work** option.

- [My Cloud user cannot see Free/busy for an on-premises user](#does-freebusy-work-on-premises)
- [My On-premises user cannot see Free/busy for a cloud user](#on-premises-user-cant-see-cloud-users-freebusy)
- [I want to see some common tools for troubleshooting Free/busy issues](#tools-and-resources)
- [I want to better understand how Hybrid Free/Busy is supposed to work](#on-premises-exchange-server-version-in-your-environment)

### On-premises Exchange server version in your environment

To better understand how Hybrid Free/Busy is supposed to work, review the following flowcharts. Select the version of the on-premises Exchange server that matches your environment:

- [Exchange 2010/2013](#the-exchange-20102013-freebusy-workflow)
- [Exchange 2007](#the-exchange-2007-freebusy-workflow)
- [Exchange 2003](#exchange-2003-freebusy-workflow)

### The Exchange 2010/2013 free/busy workflow

The following diagram shows the Exchange 2010/2013 free/busy workflow:

:::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/free-busy-workflow.png" alt-text="Screenshot of the Exchange 2010/2013 free/busy workflow.":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Welcome to the hybrid environment free/busy troubleshooter](#welcome-to-the-hybrid-environment-freebusy-troubleshooter).

### The Exchange 2007 free/busy workflow

The following diagram shows the Exchange 2007 free/busy workflow:

:::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/exchange-2007-free-busy-workflow.png" alt-text="Screenshot of the Exchange 2007 free/busy workflow.":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Welcome to the hybrid environment free/busy troubleshooter](#welcome-to-the-hybrid-environment-freebusy-troubleshooter).

### Exchange 2003 free/busy workflow

The following diagram shows the Exchange 2003 free/busy workflow:

:::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/exchange-2003-free-busy-workflow.png" alt-text="Screenshot of the Exchange 2003 free/busy workflow.":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Welcome to the hybrid environment free/busy troubleshooter](#welcome-to-the-hybrid-environment-freebusy-troubleshooter).

### Does Free/busy work on-premises

Sign in to an on-premises user's mailbox and then try to view the Free/Busy for another on-premises user. This test is to verify that you do not have any issues with availability information retrieval within your on-premises environment.

Were you able to see the Free/busy information?

- If yes, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cant-see-on-premises-users-freebusy).
- If no, see [You have an on-premises free/busy issue](#you-have-an-on-premises-freebusy-issue).

### You have an on-premises free/busy issue

This troubleshooter is used to diagnose free/busy issues in a hybrid environment. This doesn't seem to be your immediate issue. After the on-premises free/busy issues are addressed, restart this troubleshooter.
For information about how to troubleshoot some common on-premises free/busy issues, see [Troubleshooting Free/Busy Information for Outlook 2007](/previous-versions/office/exchange-server-2007/bb397225(v=exchg.80)).

### Cloud user can't see On-premises user's Free/Busy

Use the following methods to verify that Autodiscover can be resolved from an external source and that the Firewall is open.

#### Method 1: Verify that Autodiscover is resolving to the on-premises Exchange CAS server

1. From an external computer, open Command Prompt and type the following commands and press ENTER after each command:

   - NSLookup
   - autodiscover.<*Your_Domain.com*>

2. In the response to the command, the "Address" value should be the external IP of the on-premises Exchange CAS server. For example: Name: `autodiscover.contoso.com` Address: 38.96.29.10

#### Method 2: Verify that you can send an Autodiscover POST request to potential Autodiscover URLs

1. Go to [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).
2. On Microsoft Office Outlook Connectivity Tests, select Outlook Autodiscover, and then select **Next**.
3. Complete the Outlook Autodiscover form (Email address, User Name and password), then select **Perform Test**.

If the Exchange connectivity tests fail for autodiscover, check the on-premises Autodiscover Internet Access configuration. For more information, see [the Microsoft TechNet topic Configure the Autodiscover Service for Internet Access](/previous-versions/office/exchange-server-2010/aa995928(v=exchg.141)).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cannot-see-on-premises-users-freebusy-if-issue-not-resolved).

### Cloud user cannot see On-premises user's Free/Busy (if issue isn't resolved)

Verify that the autodiscover endpoint is pointing to the on-premises Exchange Hybrid Server(s).

Check the IIS logs on the Exchange Hybrid server to verify that the Autodiscover POST request is being received by this server:

1. On the Exchange Hybrid Server, select **Start** > **Run**, type *%SystemDrive%\inetpub\logs\LogFiles*, and then press ENTER.
2. Open the W3SVC1 folder, then open the most recent IIS log file.
3. Search for Autodiscover.
4. The following screenshot shows an example of the Autodiscover POST request on IIS log:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/autodiscover-post-request.png" alt-text="Screenshot of an example of the Autodiscover POST request on IIS log.":::

If you do not see any entry for Autodiscover in your on-premises Exchange hybrid deployment server, the firewall may be pointing to a wrong CAS server.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cannot-see-on-premises-users-freebusy-if-issue-still-not-resolved).

### Cloud user cannot see On-premises user's Free/Busy (if issue not resolved)

Is the domain name present in the org relationship?

To verify the domain name value in the Organization Relationship, follow these steps:

1. [Connect to Exchange Online by using Windows PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. In Windows PowerShell, run the following command:

    ```powershell
    Get-OrganizationRelationship -Identity "Exchange Online to On Premises Organization Relationship" | FL
    ```

3. Check **DomainName** value. The vanity domain (`yourdomain.com`) should be present.
4. If the **DomainName** value is missing your vanity domain, run the following command:

    ```powershell
    Set-OrganizationRelationship -Identity "Exchange Online to On Premises Organization Relationship" -DomainName yourdomain.com
    ```

 **Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cannot-see-on-premises-users-freebusy-if-issue-isnt-resolved).

### Cloud user can't see On-premises user's Free/Busy (if issue can't be solved)

Is IIS handler Mapping missing?

Determine whether Internet Information Services (IIS) configuration is missing the svc-Integrated handler mapping for the Autodiscover endpoint.

1. On the on-premises Exchange 2010 hybrid deployment server, open Internet Information Services (IIS) Manager.
2. Expand **ServerName** > **Site** > **Default Web Site**, and then select Autodiscover.
3. On IIS section, open Handler Mappings. The following screenshot shows an example of the svc-Integrated handler mapping in IIS:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/handler-mapping.png" alt-text="Screenshot of an example of the svc-Integrated handler mapping.":::

If the IIS is missing the svc-Integrated handler mapping, see ["Exception has been thrown by the target" error in a hybrid deployment of Microsoft 365 and your on-premises environment](https://support.microsoft.com/help/2626696).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cannot-see-on-premises-users-freebusy-should-verify-org-relationship-settings).

### Cloud user cannot see On-premises user's Free/Busy (if issue is still not solved)

Follow these steps to verify if EWS has External URL set:

1. On the on-premises Exchange hybrid deployment server, open Exchange Management Shell, and then run the following cmdlet:

    ```powershell
    Get-WebServicesVirtualDirectory | FL Name,Server,externalURL
    ```

1. If the ExternalURL is missing on the Exchange hybrid deployment server, run the following cmdlet:

    ```powershell
    Set-WebServicesVirtualDirectory -Identity "ServerName\EWS (Default Web Site)" -ExternalUrl https://mail.contoso.com/ews/exchange.asmx
    ```

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cant-see-on-premises-users-freebusy-if-issue-is-still-not-solved).

### Cloud user cannot see On-premises user's Free/Busy (if issue still not resolved)

Verify that the Microsoft Exchange Web Services (EWS) is resolvable and there are no firewall issues.

Check IIS logs on the Exchange 2010/2013 CAS server(s) to confirm that Web Services request is being received by this server:

1. On the Exchange 2010/2013 CAS server, select **Start** > **Run**, type *%SystemDrive%\inetpub\logs\LogFiles*, and then press ENTER.
2. Open the W3SVC1 folder, and then open the latest IIS log file.
3. In the latest IIS log file, search for **exchange.asmx/wssecurity**. The following screenshot shows an example of the request in the IIS log:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/example-of-request.png" alt-text="Screenshot of an example of the Web Services request.":::

4. If you do not see any entry for **exchange.asmx/wssecurity** in your on-premises Exchange 2010/2013 hybrid deployment server, the firewall may be pointing to a wrong CAS server, or you may have pre-authentication configured on the firewall. For information about how to bypass firewall pre-authentication, see [Configure Forefront TMG for a hybrid environment](/sharepoint/hybrid/configure-forefront-tmg-for-a-hybrid-environment).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user cannot see On-premises user's Free/Busy](#cloud-user-cannot-see-on-premises-users-freebusy-if-issue-is-still-not-solved).

### Cloud user can't see On-premises user's Free/Busy (if issue isn't solved)

Is IIS handler mapping missing on EWS?

Determine whether Internet Information Services (IIS) configuration is missing the svc-Integrated handler mapping for the EWS endpoint

1. On the on-premises Exchange hybrid deployment server, open Internet Information Services (IIS) Manager.
2. Expand **ServerName** > **Site** > **Default Web Site**, and then select **EWS**.
3. In the **IIS** area, open **Handler Mappings**. The following screenshot shows an example of the svc-Integrated handler mapping in IIS:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/svc-integrated-handler-mapping.png" alt-text="Screenshot of an example of the svc-Integrated handler mapping in IIS.":::

4. If the IIS is missing the svc-Integrated handler mapping, see [Exception has been thrown by the target" error in a hybrid deployment of Microsoft 365 and your on-premises environment](https://support.microsoft.com/help/2626696).

**Did this solve your issue?**

- IF yes, congratulations, your issue is resolved!
- If no, see [Cloud user can't see On-premises user's Free/Busy](#cloud-user-cant-see-on-premises-users-freebusy-if-issue-cant-be-solved).

### Cloud user can't see On-premises user's Free/Busy (if issue is still not solved)

Is WSSecurity enabled as an authentication method?

On the on-premises Exchange hybrid deployment server, run the following command in Exchange Management Shell:

```powershell
Get-WebServicesVirtualDirectory | fl name,server,externalURL,ExternalAuthenticationMethods
```

If the WSSecurity is missing for ExternalAuthenticationMethods is missing on Exchange hybrid deployment server run the following command:

```powershell
Set-WebServicesVirtualDirectory -Identity "ServerName\EWS (Default Web Site)" -WSSecurityAuthentication $true
```

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Cloud user can't see On-premises user's Free/Busy](#cloud-user-cant-see-on-premises-users-freebusy-if-issue-isnt-solved).

### Cloud user cannot see On-premises user's Free/Busy (should verify Org Relationship settings)

Verify Org Relationship settings are configured correctly to enable Free/busy for the users.

#### For Online Settings

1. [Connect to Exchange Online by using Windows PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. In Windows PowerShell, run the following command:

    ```powershell
    Get-OrganizationRelationship -Identity "Exchange Online to On Premises Organization Relationship" | FL
    ```

The output should resemble the following

- TargetApplicatioURI: `FYDIBOHF25SPDLT.Contoso.com`
- TargetAutodiscoverURI: `https://autodiscover.contoso.com/autodiscover/autodiscover.svc/wssecurity`
- DomainNames: {`Contoso.com`}
- FreeBusyAccessEnabled: True
- FreeBusyAccessLevel: LimitedDetails

If a value must be changed, use the `set-OrganizationRelationship` cmdlet to fix the property. For more information about syntax and options, see [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship).

#### For On-Premises settings

1. On the Exchange 2010/2013 CAS, run the following command in the Exchange Management Shell:

    ```powershell
    Get-OrganizationRelationship -Identity "On Premises to Exchange Online Organization Relationship"
    ```

The output should resemble the following:

- TargetApplicatioURI: `outlook.com`
- TargetAutodiscoverURI: `https://podxxx.outlook.com/autodiscover/autodiscover.svc/wssecurity`
- DomainNames: {`xxxx.mail.onmicrosoft.com`,`contoso.com`}
- FreeBusyAccessEnabled: True
- FreeBusyAccessLevel: LimitedDetails

If a value must be changed, use the `set-OrganizationRelationship` cmdlet to fix the property. For more information about syntax and options, see [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Contact support](#contact-support).

### On-Premises user can't see cloud user's Free/busy

On which version of Exchange is the on-premises users' mailbox located?

- [Exchange 2003](#your-exchange-2003-user-cannot-see-cloud-users-freebusy)
- [Exchange 2007](#your-exchange-2007-user-cannot-access-cloud-users-freebusy)
- [Exchange 2010](#exchange-20102013-user-cannot-see-cloud-users-freebusy)
- [Exchange 2013](#exchange-20102013-user-cannot-see-cloud-users-freebusy)

### Your Exchange 2003 user cannot see cloud user's free/busy

Can you reproduce the issue by using an on-premises Exchange 2010 mailbox?

1. Log on to Outlook or an OWA client as a user who has an Exchange 2010 on-premises mailbox.
2. Create a new meeting request and add a cloud user to the meeting request.
3. When you view the scheduling assistant do you see hash marks for the cloud user?

- If yes, see [On-premises user cannot see cloud user's Free/busy](#on-premises-user-cannot-see-cloud-users-freebusy).
- If no, see [Your Exchange 2003 user cannot see cloud user's free/busy](#your-exchange-2003-user-cannot-see-cloud-users-freebusy-cant-reproduce).

### Your Exchange 2003 user cannot see cloud user's free/busy (if issue not solved)

Verify that there is no hard-coded Public folder routing that would prevent the legacy Free/busy request from succeeding.

> [!NOTE]
> This is not a common issue.

Verify that the `ms-Exch-Folder-Affinity-List` attribute on the **Exchange Server 2003** properties has Exchange 2010 ObjectGUID with the lowest cost (The format of this property is as follows: {guid of server},cost).

1. On a Domain Controller, select **Start**, select **Run**, type *adsiedit.msc*, and then select **OK**.
2. Right-click **ADSI Edit**, and then select **Connect to**.
3. On **Select a well known Naming Context**, select **Configuration**, and then select **OK**.
4. Expand **Configuration** > **Services** > **Microsoft Exchange** > **First Organization** > **Exchange Administrative Group (FYDIBOHF23SPDLT)** > **Servers**.
5. Right-click **Exchange 2010 server**, and then select **Properties**.
6. Copy the objectGUID value and then paste it in a notepad text file.
7. Move to **Configuration** > **Services** > **Microsoft Exchange** > **First Organization** > **First Administrative Group** > **Servers**.
8. Right-click **Exchange Server 2003**, and then select **Properties**.
9. Verify that `ms-Exch-Folder-Affinity-List` value is set with Exchange 2010 **objectGUID**. If the Exchange 2010 **objectGUID** is not listed on `ms-Exch-Folder-Affinity-List`, you can add it by using the format: {guid of server},cost.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Contact support](#contact-support).

### Your Exchange 2003 user cannot see cloud user's free/busy (can't reproduce)

Is the External Free/busy present and replicated correctly?

Add the OU=EXTERNAL (FYDIBOHF25SPDLT) public folder:

1. Connect to the on-premises Exchange 2010 SP1 or later public folder server.
2. Open Windows PowerShell.
3. Run the cmdlet `Add-PsSnapin Microsoft.Exchange.Management.Powershell.Setup`.
4. Run the cmdlet `Install-FreeBusyFolder`.

> [!NOTE]
> The OU=EXTERNAL (FYDIBOHF25SPDLT) public folder should only be present on Exchange 2010 servers and NOT replicated to Exchange 2003 or Exchange 2007.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Your Exchange 2003 user cannot see cloud user's free/busy](#your-exchange-2003-user-cannot-see-cloud-users-freebusy-if-issue-not-resolved).

### Your Exchange 2003 user cannot see cloud user's free/busy (if issue not resolved)

Verify that the recipient object on the on-premises server has the correct LegacyExchangeDN configured.

Every cloud mailbox will have a corresponding on-premises Mail enabled object. For this kind of Free/busy query, we use the LegacyExchangeDN to route our request to the Proper Public folder server. To make sure that this value is accurate, follow these steps:

1. On the Exchange 2010 server, run the following command in the Exchange Management Shell:

    ```powershell
    Get-RemoteMailbox Username |fl LegacyExchangeDN
    ```

    where username is the name of the cloud user that you are trying to see free/busy information for.

1. In the results, verify that the External (FYDIBOHF25SPDLT) is in the path. For example, the results should show the path as follows:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/fydibohf25spdlt.png" alt-text="Screenshot of External (FYDIBOHF25SPDLT).":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Your Exchange 2003 user cannot see cloud user's free/busy](#your-exchange-2003-user-cannot-see-cloud-users-freebusy-if-issue-isnt-resolved).

### Your Exchange 2003 user cannot see cloud user's free/busy (if issue isn't resolved)

Verify Permissions on Public folder.

To use the Exchange 2010 Public Folder Management Console to change the client permissions for the External (FYDIBOHF25SPDLT) free/busy replica, follow these steps:

1. Start the Exchange 2010 Exchange Management Console.
2. In the console tree, select **Toolbox**.
3. In the result pane, select **Public Folder Management Console**, and then in the action pane, select **Open Tool**. The Public Folder Management Console appears.
4. In the **Public Folder Management Console**, in the action pane, select **Connect to Server**.
5. In **Connect to server**, select **Browse** to view a list of the available Mailbox servers that contain a public folder database.
6. In **Select Public Folder Servers**, select the Exchange 2010 server. Select **OK**, and then select **OK**.
7. In the Public Folder tree, move to **System Public Folder** > **SCHEDULE+ FREE/BUSY**.
8. In the Result pane, right-click **EX:/O=FIRST ORGANIZATION/OU=EXTERNAL (FYDIBOHF25SPDLT)**, and then select **Properties**.
9. On the **Permissions** tab, confirm that **Edit all permission level** is selected for the **Default user:

      :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/permissions-tab.png" alt-text="Screenshot of the Permissions tab details.":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Your Exchange 2003 user cannot see cloud user's free/busy](#your-exchange-2003-user-cannot-see-cloud-users-freebusy-if-issue-is-still-not-solved).

### Your Exchange 2003 user cannot see cloud user's free/busy (if issue is still not solved)

Is the arbitration mailbox missing or corrupted?

The Arbitration mailbox can be edited by using ADSIEdit. The federated.email account should be located in the default users container of Active Directory for the Exchange 2010 domain.

Use one of the following options:

1. Use adsiedit.

   1. Connect to the default naming context in Active Directory.
   2. Browse to the Users container and view the properties of the federated email account.
   3. Change the proxyaddress attributes of the account to either have ONE of the SMTP addresses already federated, or add the already existing proxy address namespace present into the federation trust.

2. From the Exchange Server 2003 open **Active Directory Users and Computers**.

   1. Move to the Users container and right-click the FederatedEmail account - then select **Properties**.
   2. If you go to the email addresses tab that you can add another proxy address to match the federation namespaces already configured, or add the pre-existing primary SMTP namespace to the federation trust.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Your Exchange 2003 user cannot access cloud user's free/busy](#your-exchange-2003-user-cannot-see-cloud-users-freebusy-if-issue-not-solved).

### Your Exchange 2007 user cannot access cloud user's free/busy

Can you repro with an on-premises Exchange 2010 or 2013 mailbox?

1. Sign in to your Outlook or OWA client as a user who has an Exchange 2010 or 2013 on-premises mailbox.
2. Create a new meeting request and add a cloud user to the meeting request.
3. When you view the scheduling assistant do you see hash marks for the cloud user?

- If yes, see [Exchange 2010/2013 user cannot see cloud user's free/busy](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5037).
- If no, see [Your Exchange 2007 user can't access cloud user's free/busy](#your-exchange-2007-user-cant-access-cloud-users-freebusy).

### Your Exchange 2007 user can't access cloud user's free/busy

Check the availability address space to make sure that it has the correct settings. This might be a misconfiguration of the AvailabilityAddressSpace. Check that ProxyURL value on AvailabilityAddressSpace configuration matches the InternalURL of the Exchange 2010/2013 CAS Web Service virtual directory. To do so, follow these steps:

1. On the on-premises server, run the following commands in Exchange Management Shell:

    ```powershell
    Get-AvailabilityAddressSpace | FL ProxyUrl
    Get-WebServicesVirtualDirectory | FL Server,InternalUrl
    ```

2. If the ProxyURL and InternalURL values do not match, run the following commands:

    ```powershell
    Remove-AvailabilityAddressSpace -Identity 'contoso.mail.onmicrosoft.com'

    Add-AvailabilityAddressSpace -ForestName contoso.mail.onmicrosoft.com' -AccessMethod 'InternalProxy' -UseServiceAccount
    'True' -ProxyUrl https://cas2010.contoso.com/ews/exchange.asmx
    ```

3. If the `ProxyURL` and `InternalURL` values do match, make sure that you can access the URL from the Exchange 2007 CAS server. To do this, move to `ProxyURL` of the `AvailabilityAddressSpace` from CAS 2007. Authenticate with the Exchange 2007 source mailbox credential. The expected result is as follows:

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/expected-result.png" alt-text="Screenshot of the expected result for authentication with the Exchange 2007 source mailbox credential.":::

> [!NOTE]
> The InternalURL of the Exchange 2010/2013 CAS Web Service virtual directory should differ from Exchange 2007 CAS Web Service virtual directory.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Contact support](#contact-support).

### Exchange 2010/2013 user cannot see cloud user's free/busy

Sign in to an on-premises user's mailbox and then try to view the Free/Busy for another on-premises user. This test is to verify that you do not have any issues with availability information retrieval within your on-premises environment.

Were you able to see the Free/busy information?

- If yes, see [On-premises user cannot see cloud user's Free/busy](#on-premises-user-cannot-see-cloud-users-freebusy).
- If no, see [On-premises Free/busy is not working for 2010/2013](#on-premises-freebusy-is-not-working-for-20102013).

### On-premises user cannot see cloud user's Free/busy

Determine what error message you are receiving from OWA.

1. Use the affected user's account to log on to the on-premises OWA.
2. Create a new meeting request, and then add the on-premises user to the meeting.
3. When the Hash marks are returned rest the pointer over them to display the error message. Note the error code number in the error message.

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/determine-what-error-you-receive.png" alt-text="Determine what error message you are receiving from OWA.":::

Select the appropriate error message in the following list to help narrow the troubleshooting steps that you must follow:

- [The attendee's server couldn't be found. For more information, please contact your helpdesk. (Error Code: 5039)](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5039).
- [The attendee's server couldn't be contacted. (Error Code: 5016)](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5016).
- [You don't have permission to see free/busy information for this attendee. (Error code 5037)](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5037).

### Exchange 2010/2013 user cannot see cloud user's free/busy (Error Code 5039)

If you must have web proxy settings in your environment, verify that the on-premises Exchange 2010 and Exchange 2013 servers are set to use it.

On the on-premises Exchange 2010 and Exchange 2013 server(s), run the following command in the Exchange Management Shell:

```powershell
Get-ExchangeServer | fl InternetWebProxy
```

In most environments the results will be blank. However, if you have an outgoing proxy in your on-premises environment you may have to configure the correct proxy settings.

To resolve this issue, run the following command, where the address and port number `http://192.168.5.56:8080` is replaced with your server address and port number:

```powershell
Set-ExchangeServer -InternetWebProxy http://192.168.5.56:8080
```

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Exchange 2010/2013 user cannot see cloud user's free/busy](#exchange-20102013-user-cannot-see-cloud-users-freebusy-if-issue-not-resolved).

### Exchange 2010/2013 user cannot see cloud user's free/busy (if issue not resolved)

Make sure that the time set on your server is not inaccurate by more than 5 minutes. If the server time is more than 5-minutes difference from real time, the communications with the federation gateway become invalid. This causes free/busy to fail.

For information about how to fix server time issues, see [How to configure an authoritative time server in Windows Server](https://support.microsoft.com/help/816042).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Contact support](#contact-support).

### Exchange 2010/2013 user cannot see cloud user's free/busy (Error Code 5016)

Determine whether the correct target address is specified on the MEU on-premises. Every Cloud Mailbox will have a corresponding on-premises object. This object must have the correct remote routing address (also known as the target address) specified. The remote routing address should contain a domain name similar to `TenantName.Mail.OnMicrosoft.com`.

To verify that the remote routing address is set, follow these steps:

1. On the Exchange 2010 server or Exchange 2013 server, run the following command in the Exchange Management Shell:

    ```powershell
    Get-RemoteMailbox Username |fl RemoteRoutingAddress
    ```

    where username is the name of the cloud user that you are trying to see free/busy information for.

1. Verify that the address contains `TenantName.Mail.OnMicrosoft.com`

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/get-remotemailbox.png" alt-text="Output of Get-RemoteMailbox.":::

> [!NOTE]
> If you did not use the Hybrid configuration wizard, the domain name should reflect the remote routing domain that you have selected.

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Exchange 2010/2013 user cannot see cloud user's free/busy](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5039).

### Exchange 2010/2013 user cannot see cloud user's free/busy (Error code 5037)

Verify that the Org Relationship settings are configured correctly to enable Free/busy for the users.

#### For online settings

[Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).

In Windows PowerShell, run the following command:

```powershell
Get-OrganizationRelationship -Identity "Exchange Online to On Premises Organization Relationship" | FL
```

The output should resemble the following:

- TargetApplicatioURI: `AppURL.Contoso.com`
- TargetAutodiscoverURI: `https://autodiscover.contoso.com/autodiscover/autodiscover.svc/wssecurity`
- DomainNames: {`Contoso.com`}
- FreeBusyAccessEnabled: True
- FreeBusyAccessLevel: LimitedDetails

If a value must be changed, use the `set-OrganizationRelationship` cmdlet to fix the property. For more information about syntax and options, see [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship).

#### For on-premises settings

From the Exchange 2010/2013 CAS, run the following command in Exchange Management Shell:

```powershell
Get-OrganizationRelationship -Identity "On Premises to Exchange Online Organization Relationship"
```

The output should resemble the following:

- TargetApplicatioURI: `outlook.com`
- TargetAutodiscoverURI: `https://podxxx.outlook.com/autodiscover/autodiscover.svc/wssecurity`
- DomainNames: {`xxxx.mail.onmicrosoft.com`,`contoso.com`}
- FreeBusyAccessEnabled: True
- FreeBusyAccessLevel: LimitedDetails

If a value must be changed, use the `set-OrganizationRelationship` cmdlet to fix the property. For more information about syntax and options, see [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship).

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Exchange 2010/2013 user cannot see cloud user's free/busy](#exchange-20102013-user-cannot-see-cloud-users-freebusy-if-issue-isnt-solved).

### Exchange 2010/2013 user cannot see cloud user's free/busy (if issue isn't solved)

Verify that a token can be created that has test-federation trust.

From the on-premises environment, verify that you can retrieve a delegation token that will be used for Free/busy authorization:

1. Open the Exchange Management Shell from the on-premises Exchange 2010 or 2013 server.
2. Run the command `Test-FederationTrust -UserIdentity User@company.com -verbose` where User is the on-premises user who has issues viewing the cloud user's free/busy information.
3. The output should show success for every test. If there is a failure, use the Hybrid Configuration Wizard again to try to reset the federation trust.

   :::image type="content" source="media/troubleshoot-freebusy-issues-in-exchange-hybrid/test-federation-trust.png" alt-text="Output of Test-FederationTrust.":::

**Did this solve your issue?**

- If yes, congratulations, your issue is resolved!
- If no, see [Exchange 2010/2013 user cannot see cloud user's free/busy](#exchange-20102013-user-cannot-see-cloud-users-freebusy-error-code-5016).

### On-premises Free/busy is not working for 2010/2013

This guide is used to troubleshoot Hybrid free/busy issues. Based on you answers, you have on-premises issues. For information about how to troubleshoot common on-premises free/busy issues, see [Troubleshooting Free/Busy Information for Outlook 2007](/previous-versions/office/exchange-server-2007/bb397225(v=exchg.80)).

### Contact support

Sorry, we cannot resolve an unidentified issue by using this guide. For more help to resolve this issue, go to [Microsoft Support](https://support.microsoft.com/).

Other useful resources:

- [Remote Connectivity Analyzer tool](https://testconnectivity.microsoft.com/tests/o365)
- [How to troubleshoot issues that prevent a user from viewing other users' free/busy information in Office Outlook 2007 and in Outlook 2010 in Microsoft 365](https://support.microsoft.com/office/how-to-troubleshoot-issues-that-prevent-a-user-from-viewing-other-users-free-busy-information-in-office-outlook-2007-and-in-outlook-2010-in-microsoft-365-02249bf3-bca1-47b3-8403-c38b8b59ea4e?ui=en-us&rs=en-us&ad=us)
- [Video: Troubleshooting Issues with Free/Busy Information in Office Outlook Clients for Microsoft 365](https://www.youtube.com/watch?v=Sjp3KCVPMso)
- [Free/busy lookups stop working in a cross-premises environment or in an Exchange Server hybrid deployment](freebusy-lookups-stop-working.md)

### Tools and resources

The following are some additional tools and resources for diagnosing issues with Hybrid Free/busy:

- [Remote Connectivity Analyzer tool](https://testconnectivity.microsoft.com/tests/o365)
- [How to troubleshoot issues that prevent a user from viewing other users' free/busy information in Office Outlook 2007 and in Outlook 2010 in Microsoft 365](https://support.microsoft.com/office/how-to-troubleshoot-issues-that-prevent-a-user-from-viewing-other-users-free-busy-information-in-office-outlook-2007-and-in-outlook-2010-in-microsoft-365-02249bf3-bca1-47b3-8403-c38b8b59ea4e?ui=en-us&rs=en-us&ad=us)
- [Video: Troubleshooting Issues with Free/Busy Information in Office Outlook Clients for Microsoft 365](https://www.youtube.com/watch?v=Sjp3KCVPMso)

**Is this information helpful?**

- If yes, congratulations, your issue is resolved!
- If no, sorry, we cannot resolve this issue by using this guide.
