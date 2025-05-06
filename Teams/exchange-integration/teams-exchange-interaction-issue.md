---
title: Resolve interaction issues between Teams and Exchange Server 
description: Provides steps to troubleshoot interaction issues that occur between Microsoft Teams and Exchange Server.
manager: dcscontentpm
editor: v-jesits
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\
  - CI 121615
  - CSSTroubleshoot
ms.reviewer: chunlli
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 11/22/2024
---
# Resolve interaction issues between Teams and Exchange Server

## Symptoms

You experience one or more of the following issues.

### Issue 1: A delegate is unable to schedule a Teams meeting on behalf of a delegator

A delegator whose mailbox is hosted on Exchange Server adds a delegate to manage their Microsoft Outlook calendar. However, the delegate who is using the Teams add-in for Outlook is unable to schedule a Teams meeting on behalf of the delegator, and Outlook returns the following error message:

> Looks like you don't have permission to schedule meetings for this account. Talk to the owner to get permission and try again.

### Issue 2: You experience issues when you try to use the Teams Calendar app

Either of these issues occurs:

- The Calendar icon isn't displayed in the Teams client.
- The Teams Calendar app displays a "Sorry, we couldn't get your meeting details" error message when you use the Teams desktop or web client.

The Teams Calendar app requires access to the Exchange mailbox through Exchange Web Services (EWS). The Exchange mailbox can be online or on-premises in the scope of an Exchange hybrid deployment.

### Issue 3: Your presence status in Teams is stuck on Out of Office or doesn't display "In a meeting" when you're attending an Outlook calendar meeting

Either of these issues occurs:

- Your mailbox is hosted on an on-premises Exchange server and you've turned off the Automatic Replies feature in the Outlook client. However, your Teams presence status displays "Out of Office" to all Teams clients from the same organization. This status may last a few days.

  **Note**: For users whose mailbox is hosted on-premises, it's expected to have presence delays with a maximum of an hour.
- You're attending an Outlook calendar meeting, but the Teams presence status doesn't update to "In a meeting".

## Prerequisites for integration of Teams and Exchange Server

To integrate the Teams service with your installation of Exchange Server, make sure your local Exchange Server environment meets these requirements:

- Validate the [version and environment compatibility](/MicrosoftTeams/exchange-teams-interact) of Microsoft Exchange Server and Microsoft Teams in your deployment.
- Microsoft Teams must be aware whether the mailbox is hosted on Exchange Online, on-premises, or in a [hybrid Exchange server deployment](/exchange/exchange-hybrid). Teams services call the Exchange Online services through an Autodiscover V2 call, which is redirected to on-premises servers hosting the mailbox in a hybrid configuration.
- Exchange Online integrates with the on-premises Exchange server environment, as described in [What is OAuth authentication](/exchange/using-oauth-authentication-to-support-ediscovery-in-an-exchange-hybrid-deployment-exchange-2013-help#what-is-oauth-authentication). It's preferable that you configure it by running the Exchange Hybrid Wizard, but the same result can be achieved manually as described in [Configure OAuth authentication between Exchange and Exchange Online organizations](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help). Exchange Online is represented by the application ID `00000002-0000-0ff1-ce00-000000000000`.
- Additionally, Teams services need to authenticate on behalf of the user to access the mailbox hosted on-premises also using OAuth. In this case the application ID of Skype for Business Online `00000004-0000-0ff1-ce00-000000000000` is used by the Teams scheduling service, together with MailUser referenced at [Configure Integration and OAuth between Skype for Business Online and Exchange Server](/skypeforbusiness/deploy/integrate-with-exchange-server/oauth-with-online-and-on-premises):
  - The account is hidden from the Exchange address book. It's a best practice to hide the account from the address book because it's a disabled account.
  - The account has an Exchange management role assignment of [UserApplication](/exchange/userapplication-role-exchange-2013-help).
  - For retention and archiving, a role assignment of [ArchiveApplication](/exchange/archiveapplication-role-exchange-2013-help) is required.
  - All steps in the article are required for full Teams and Exchange server on-premises.

  > [!NOTE]
  > An example of Microsoft identity platform and OAuth 2.0 usage can be found [here](/azure/active-directory/develop/v2-oauth2-on-behalf-of-flow).
- You should configure your internet-facing firewall or reverse proxy server to allow Microsoft Teams to access the servers that are running Exchange Server by adding the URLs and IP address ranges for Skype for Business Online and Microsoft Teams into the allowlist. For more information, see [Microsoft 365 URLs and IP address ranges - Microsoft Teams](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-teams&preserve-view=true).
- Exchange Autodiscover V2 is required to allow the Teams service to perform an unauthenticated discovery against the user's mailbox that's located in Exchange Server. Autodiscover V2 is fully supported in Exchange Server 2013 Cumulative Update 19 or later. This is enough to enable Teams delegation to work correctly. However, the Teams Calendar app requires Exchange Server 2016 Cumulative Update 3 or later to be installed. Therefore, for full feature support, Exchange Server 2016 Cumulative Update 3 or later is required.

## Common troubleshooting steps

> [!NOTE]
> These troubleshooting steps apply to all of the issues listed above.

### Run the Teams Exchange Integration connectivity test

Both administrators and non-administrators can run the [Teams Exchange Integration](https://testconnectivity.microsoft.com/tests/TeamsExchangeIntegration/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test validates Teams ability to interact with Exchange. For Exchange hybrid environments, run this test twice, once with a Microsoft 365 mailbox and once with an on-premises mailbox.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Teams Exchange Integration](https://testconnectivity.microsoft.com/tests/TeamsExchangeIntegration/input) connectivity test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

### Additional steps

After you run the Teams Exchange Integration connectivity test, follow these steps.

#### Step 1: Verify that the Autodiscover service is working correctly

The Teams service uses the Exchange Autodiscover service to locate the EWS URL that's published by the server that's running Exchange Server. To verify that the Autodiscover process is working correctly, run the [Outlook Connectivity](https://testconnectivity.microsoft.com/tests/Ola/input) test in the Microsoft Remote Connectivity Analyzer tool. The Remote Connectivity Analyzer tool uses a specific set of IP addresses to locate the EWS URL. For a list of these IP addresses for Microsoft 365, see the information for ID 46 in [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-365-common-and-office-online&preserve-view=true).

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Outlook Connectivity](https://testconnectivity.microsoft.com/tests/Ola/input) test.
1. In the **Email address** field, enter the email address of the affected mailbox.

   **Note**: For the Teams delegation issue, enter the delegator's mailbox. For the Teams Calendar app and Teams presence issues, enter the affected user's mailbox.
1. In the **Domain\User Name (or UPN)** field, enter the account name that has permissions to run this test in the domain\user (`contoso.com\user`) format or the UPN (`user@contoso.com`) format.
1. In the **Password** field, enter the password of the account that's specified in step 3.
1. Under **Autodiscover selection**, select **Use Autodiscover to detect server settings**.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

#### Step 2: Verify that the Autodiscover service can route the Autodiscover requests to on-premises

In Windows PowerShell, run the following command:

```powershell
Invoke-RestMethod -Uri "https://outlook.office365.com/autodiscover/autodiscover.json?Email=<Email address of the affected mailbox>&Protocol=EWS" -UserAgent Teams
```

> [!NOTE]
> For the Teams delegation issue, test the delegator's mailbox. For the Teams Calendar app and Teams presence issues, test the affected user's mailbox.

For a mailbox that's hosted on-premises, the EWS URL should point to the on-premises external EWS. The output should resemble the following example:

> Protocol Url
>
> \-------- ---
>
> EWS \<`https://mail.contoso.com/EWS/Exchange.asmx`\>

If this test fails, or if the EWS URL is incorrect, review the [Prerequisites for integration of Teams and Exchange Server](#prerequisites-for-integration-of-teams-and-exchange-server) section. The issue is likely caused by an Exchange hybrid configuration issue, or a firewall or reverse proxy that's blocking external requests.

#### Step 3: Verify that the Exchange OAuth authentication protocol is enabled and functional

To verify that Exchange OAuth authentication is enabled and functional, run the `Test-OAuthCOnnectivity` command as described in [Configure OAuth authentication between Exchange and Exchange Online organizations](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#how-do-you-know-this-worked).

Additionally, run the [Free/Busy](https://testconnectivity.microsoft.com/tests/FreeBusy/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This test verifies that a Microsoft 365 mailbox can access the free/busy information of an on-premises mailbox, and vice versa (one direction per test run).

> [!NOTE]
>
> - The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.
> - You must run this test two times by swapping the source mailbox email address with the target mailbox email address, because each run is unidirectional. You don't have to run this test by using an affected account. You can run the test by using any pair of an on-premises mailbox and a Microsoft 365 mailbox.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Free/Busy](https://testconnectivity.microsoft.com/tests/FreeBusy/input) connectivity test.
1. In the **Source Mailbox Email Address** field, enter the email address of the source mailbox.
1. In the **Authentication type** dropdown box, select **Modern authentication (OAuth)**.
1. Sign in by using the credentials of the source mailbox.
1. In the **Target Mailbox Email Address** field, enter the email address of the target mailbox.
1. In the **Service Selection** field, select the appropriate service.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

To learn more about how to troubleshoot free/busy issues in a hybrid deployment of on-premises and Exchange Online in Microsoft 365, see [this article](https://support.microsoft.com/help/2555008).

## Troubleshoot the Teams delegation issue

> [!NOTE]
> These troubleshooting steps apply only to [Issue 1](#issue-1-a-delegate-is-unable-to-schedule-a-teams-meeting-on-behalf-of-a-delegator).

### Run the Teams Meeting Delegation connectivity test

Both administrators and non-administrators can run the [Teams Meeting Delegation](https://testconnectivity.microsoft.com/tests/TeamsMeetingDelegation/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies that your account meets the requirements to schedule a Teams Meeting on behalf of a delegator.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Teams Meeting Delegation](https://testconnectivity.microsoft.com/tests/TeamsMeetingDelegation/input) connectivity test.
1. Sign in by using the credentials of the affected user account.
1. Enter the delegator's email address.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

If the test fails, follow these steps.

### Step 1: Verify that the delegate is granted the Author permission to the delegator's calendar

If the delegator's mailbox is hosted on an on-premises Exchange server, follow these steps:

1. Open classic Outlook by using the delegator's credentials.
1. Select **File** > **Account Settings** > **Delegate Access**.
1. In the **Delegates** dialog, select the delegate, and then select **Permissions**. If the delegate isn't listed, select **Add** to add the delegate.
1. In the **Delegate Permissions** dialog, make sure that the delegate has the **Author (can read and create items)** or **Editor (can read, create, and modify items)** permission to the **Calendar** folder.

   **Note**: The minimum permission required for a delegate to create a meeting on behalf of the delegator is the **Author (can read and create items)** permission. By default, when you add a delegate, the delegate is granted the **Editor (can read, create, and modify items)** permission to your **Calendar** folder.
1. Select **OK**.

After you perform these steps, the folder and the Send on Behalf permissions are stored in the delegator's mailbox. In addition, the delegate is added to the list of delegates that's stored in a hidden item in the delegator's mailbox.

If the delegator's mailbox is hosted in Exchange Online, you can follow the same steps listed above as when the the delegator's mailbox is hosted on an on-premises Exchange server. Or, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true), and run the [Set-Mailboxfolderpermission](/powershell/module/exchange/set-mailboxfolderpermission?view=exchange-ps&preserve-view=true) PowerShell command with administrator privileges:

```powershell
Set-Mailboxfolderpermission -identity <delegator's UserPrincipalName>\Calendar -User <delegate's UserPrincipalName> -AccessRights Author –SharingpermissionFlags Delegate
```

### Step 2: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run the following Exchange PowerShell command to check whether the `EwsApplicationAccessPolicy` parameter was set to `EnforceAllowList` for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only clients listed in `EwsAllowList` are allowed to access EWS. An empty value of `EwsAllowList` (EwsAllowList={}) prevents all users from accessing EWS.

> [!NOTE]
> Blocking EWS can also cause Teams Calendar App issues. For more information, see [Verify that Teams Calendar App is enabled](#troubleshoot-the-teams-calendar-app-issue).

Make sure that `SchedulingService` is listed as an array member of the `EwsAllowList` parameter. If not, run this command to add it:

```powershell
Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="*SchedulingService*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True** or **Null** (blank). Otherwise, the Teams service is blocked from accessing the EWS.

### Step 3: Verify that Teams isn't blocked from accessing EWS for the delegator's mailbox

Run the following Exchange PowerShell command to check whether the `EwsApplicationAccessPolicy` parameter was set to `EnforceAllowList` for the delegator's mailbox:

```powershell
Get-CasMailbox <delegator's UserPrincipalName> | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only clients listed in `EwsAllowList` are allowed to access EWS.

Make sure that `SchedulingService` is listed as an array member of the `EwsAllowList` parameter. If not, run this Exchange PowerShell command to add it:

```powershell
Set-CASMailbox <delegator's UserPrincipalName> -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="*SchedulingService*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True**. Otherwise, the Teams service is blocked from accessing the EWS.

### Step 4: Escalate the issue

If you verified that there's no problem with the prerequisites or configurations mentioned in this article, submit a service request to Microsoft Support with the following information:

- The UserPrincipalName for both the delegator and the delegate.
- The Teams Meeting Add-in logs under the `%appdata%\\microsoft\\teams\\meeting-addin` folder.
- The time in UTC when the issue was reproduced.
- Teams client debug logs collected from the delegate's machine. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).

## Troubleshoot the Teams calendar App issue

> [!NOTE]
> These troubleshooting steps apply only to [Issue 2](#issue-2-you-experience-issues-when-you-try-to-use-the-teams-calendar-app).

### Step 1: Verify that Teams Calendar App is enabled

1. Open Microsoft Teams admin center, select **Users** > **Manage users**, select the affected user, and then select **View policies**.

    :::image type="content" source="media/teams-exchange-interaction-issue/teams-admin-center-policies.png" alt-text="Screenshot of Microsoft Teams admin center windows. Assigned policies under Policies tab are listed.":::

2. Select the **App setup policy** assigned to that user. In the example above, the global (Org-Wide default) policy is assigned. Confirm that the calendar App (ID `ef56c0de-36fc-4ef8-b417-3d82ba9d073c`) is displayed.

    :::image type="content" source="media/teams-exchange-interaction-issue/teams-apps-setup-policies.png" alt-text="Screenshot of Teams apps setup policies, showing the calendar App.":::

    If the calendar App is missing, restore it. For more information, see [Manage app setup policies in Microsoft Teams](/microsoftteams/teams-app-setup-policies).

### Step 2: Verify that Teams upgrade Coexistence mode allows Teams meetings

1. Open the Microsoft Teams admin center.
1. Select **Users** > **Manage users**, and select the affected user.
1. Verify that the **Coexistence mode** setting is set to a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/coexistence-mode.png" alt-text="Screenshot shows Coexistence mode option under Account tab in Users item.":::

1. If the user's Coexistence mode is set to **Use Org-wide settings**, the default tenant Coexistence mode is used. In this case, follow these steps:

   1. Go to **Org-wide settings**, and select **Teams Upgrade**.
   1. Verify that the default **Coexistence mode** setting is set to a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

      :::image type="content" source="media/teams-exchange-interaction-issue/teams-upgrade.png" alt-text="Screenshot shows the Coexistence mode setting under Teams upgrade.":::

### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run this Exchange PowerShell command to check whether the parameter `EwsApplicationAccessPolicy` was set to `EnforceAllowList` for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only clients that are listed in `EwsAllowList` are allowed to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the `EwsAllowList` parameter. If they aren't, run this command to add them:

```powershell
Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True** or **Null** (blank). Otherwise, the Teams service is blocked from accessing EWS.

### Step 4: Verify that Teams isn't blocked from accessing EWS for the affected user

Run this Exchange PowerShell command to check whether the `EwsApplicationAccessPolicy` parameter was set to `EnforceAllowList` for the user mailbox:

```powershell
Get-CASMailbox <UserPincipalName> | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only clients that are listed in `EwsAllowList` are allowed to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the `EwsAllowList` parameter. If they aren't, run this Exchange PowerShell command to add them:

```powershell
Set-CASMailbox <UserPincipalName> -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True**. Otherwise, the Teams service is blocked from accessing EWS.

### Step 5: Verify that the Teams Calendar App connectivity test is successful

Both administrators and non-administrators can run the [Teams Calendar App](https://testconnectivity.microsoft.com/tests/TeamsCalendarMissing/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies that the Teams backend service can connect to an Exchange mailbox.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Teams Calendar App](https://testconnectivity.microsoft.com/tests/TeamsCalendarMissing/input) connectivity test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

### Step 6: Escalate the issue

If you verified that there's no problem with the prerequisites and configurations mentioned in this article, submit a service request to Microsoft Support with the following information:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).

## Troubleshoot the Teams presence issue

> [!NOTE]
> These troubleshooting steps apply only to [Issue 3](#issue-3-your-presence-status-in-teams-is-stuck-on-out-of-office-or-doesnt-display-in-a-meeting-when-youre-attending-an-outlook-calendar-meeting).

### Step 1: Verify that the URL for the on-premises Exchange REST API has been published on the public network

[Verify that the Autodiscover service can route the Autodiscover requests to on-premises](#step-2-verify-that-the-autodiscover-service-can-route-the-autodiscover-requests-to-on-premises) by using the user's mailbox to locate the on-premises Exchange EWS URL, and change the URL format. For example, change `https://mail.contoso.com/EWS/Exchange.asmx` to `https://mail.contoso.com/api`.

Try to access the REST API URL from a browser in the external network. If you get a 401 response from the on-premises Exchange environment, it indicates that the REST API URL has been published. Otherwise, contact the local network team to get the URL published.

> [!NOTE]
> Teams presence service doesn't support the fallback to the EWS URL if the access to the Exchange REST API fails.

### Step 2: Verify that the Teams Presence Based on Calendar Events connectivity test is successful

Both administrators and non-administrators can run the [Teams Presence Based on Calendar Events](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. The Remote Connectivity Analyzer tool uses a specific set of IP addresses to locate the EWS URL. For a list of these IP addresses for Microsoft 365, see the information for ID 46 in [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-365-common-and-office-online&preserve-view=true). This connectivity test verifies the requirements to update a user's presence status in Teams based on their calendar events in Microsoft Outlook.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Teams Presence Based on Calendar Events](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input) test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run this Exchange PowerShell command to check whether the `EwsApplicationAccessPolicy` parameter was set to `EnforceAllowList` for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only clients that are listed in `EwsAllowList` are allowed to access EWS. An empty value of `EwsAllowList` (EwsAllowList={}) prevents all clients from accessing EWS.

Make sure that **\*Microsoft.Skype.Presence.App/\*** is listed as an array member of the `EwsAllowList` parameter. If not, run this command to add it:

```powershell
Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="*Microsoft.Skype.Presence.App/*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True** or **Null** (blank). Otherwise, the Teams service is blocked from accessing the EWS.

### Step 4: Verify that Teams isn't blocked from accessing EWS for the user's mailbox

Run this Exchange PowerShell command to check whether the `EwsApplicationAccessPolicy` parameter was set to `EnforceAllowList` for the user's mailbox:

```powershell
Get-CasMailbox <user's UserPrincipalName> | Select-Object Ews*
```

If the parameter was set to `EnforceAllowList`, only the clients that are listed in `EwsAllowList` are allowed to access EWS.

Make sure that **\*Microsoft.Skype.Presence.App/\*** is listed as an array member of the `EwsAllowList` parameter. If not, run this Exchange PowerShell command to add it:

```powershell
Set-CASMailbox <user's UserPrincipalName> -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="* Microsoft.Skype.Presence.App/*"}
```

If the `EwsEnabled` parameter is set to **False**, you must set it to **True**. Otherwise, the Teams service is blocked from accessing the EWS.

### Step 5: Escalate the issue

If you verified there's no problem with the prerequisites and configurations mentioned in this article, submit a service request to Microsoft Support with the following information:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).
