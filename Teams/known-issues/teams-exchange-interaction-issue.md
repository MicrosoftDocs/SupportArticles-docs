---
title: Troubleshoot Microsoft Teams and Exchange Server interaction issues
description: Provides steps to troubleshoot interaction issues that occur between Microsoft Teams and Exchange Server.
author: TobyTu
ms.author: chunlli
manager: dcscontentpm
editor: v-jesits
audience: ITPro 
ms.topic: article 
ms.prod: microsoft-teams
ms.technology: microsoft-graph
localization_priority: Normal
ms.custom: 
- CI 121615
- CSSTroubleshoot
ms.reviewer: chunlli
appliesto:
- Microsoft Teams
search.appverid: 
- MET150 
---
# Troubleshoot Microsoft Teams and Exchange Server interaction issues

This article provides steps to troubleshoot interaction issues between Microsoft Teams and Microsoft Exchange Server.

#### Getting Started

Learn [How Exchange and Teams Interact](https://docs.microsoft.com/MicrosoftTeams/exchange-teams-interact) to validate version and environment compatibility.

## Symptoms

#### Issue 1: A delegate cannot schedule a Teams meeting on behalf of a delegator

A user whose mailbox is hosted on Exchange Server adds another user as a delegate to manage the Outlook calendar. The delegate who is using the Teams Add-in for Outlook cannot schedule a Teams meeting on behalf of the delegator, and Outlook returns this error message:

> Looks like you don't have permission to schedule meetings for this account. Talk to the owner to get permission and try again.

#### Issue 2: You experience issues when you try to use the Teams Calendar App

Either of these issues occurs:

- The Calendar icon isn't displayed in the Teams client.
- The Microsoft Teams Calendar App displays a "Sorry, we couldn't get your meeting details" error message when you use the Teams desktop client or web client.

Teams Calendar App requires access to the Exchange mailbox through Exchange Web Services (EWS). The Exchange mailbox can be online or on-premises in the scope of Exchange hybrid deployment.

#### Issue 3: The Teams presence status is stuck on Out of Office or doesn't display 'In a meeting' when the user is attending an Outlook calendar meeting

A user whose mailbox is hosted on an on-premises Exchange server turned off the Outlook client automatic replies but the Teams presence status displays 'Out of Office' to all Teams clients from the same organization. This may last a few days.

> [!NOTE]
> For users whose mailbox is hosted on-premises, it's expected to have presence delays with a maximum of an hour.

A user is attending an Outlook calendar meeting but the Teams presence status doesn't update to 'In a meeting'.

## Prerequisites

To integrate the Microsoft Teams service with your installation of Exchange Server, make sure your local Exchange Server environment meets these requirements:

- Microsoft Teams must check whether the mailbox is hosted on Exchange Online or on-premises. The service then decides where to access the mailbox. To enable the Teams service to check the mailbox location through the REST API call to the Exchange Online service, you have to deploy an Exchange Hybrid environment by running the Exchange Hybrid Wizard, as described in [Create a hybrid deployment with the Hybrid Configuration wizard](https://docs.microsoft.com/exchange/hybrid-deployment/deploy-hybrid).

- To enable Microsoft Teams to authenticate to your on-premises Exchange environment to query the mailbox settings, you have to configure the new Exchange OAuth authentication protocol. It's preferable that you do this by running the Exchange Hybrid Wizard, as described in [Configure OAuth authentication between Exchange and Exchange Online organizations](https://docs.microsoft.com/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

- The server that's running Exchange Server must have a Partner application configured to have an application ID of Skype for Business Online, `00000004-0000-0ff1-ce00-000000000000`. The ID is used by the Teams scheduling service and a linked user account that has these properties:

  - The account is hidden from the Exchange address book. It's a best practice to hide the account from the address book because it's a disabled user account.
  - The account has an Exchange management role assignment of **UserApplication**.

    To complete the integration, follow Steps 1-5 in [this article](https://docs.microsoft.com/skypeforbusiness/deploy/integrate-with-exchange-server/oauth-with-online-and-on-premises). Step 1 is usually for the Exchange Hybrid Configuration Wizard and step 2 in the article includes the role assignment for **ArchiveApplication**.

    > [!NOTE]
    > This requirement applies to only the Teams delegation issue.

- You should configure your internet-facing firewall or reverse proxy server to allow Microsoft Teams to access the servers that are running Exchange Server by adding the URLs and IP address ranges for Skype for Business Online and Microsoft Teams into the allow list. For more information, see the "Skype for Business Online and Microsoft Teams" section of [Office 365 URLs and IP address ranges](https://docs.microsoft.com/office365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams).

- Exchange Autodiscover V2 is required to allow the Teams service to perform an unauthenticated discovery against the user's mailbox that's located in Exchange Server. Autodiscover V2 is fully supported in Exchange Server 2013 Cumulative Update 19 or later. This is good enough to enable Teams delegation to work correctly. However, Teams Calendar App requires Exchange Server 2016 Cumulative Update 3 or later to be installed. Therefore, for full feature support, Exchange Server 2016 Cumulative Update 3 or later is required.

## Common troubleshooting steps

> [!NOTE]
> These troubleshooting steps apply to all the issues listed above.

#### Step 1: Verify that the Autodiscover service works properly

Microsoft Teams service uses the Exchange Autodiscover service to locate the EWS URL that is published by the server that's running Exchange Server. To verify that the Autodiscover process is working properly:

1. Ask the user to navigate to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/Ola/input).
1. Input the requested information (make sure that the **Use Autodiscover to detect server settings** check box is selected).
1. Select the **Perform Test** button to start the Autodiscover test.

If the test fails, you must first resolve the Autodiscover issue.

:::image type="content" source="media/teams-exchange-interaction-issue/image1.png" alt-text="Screenshot of RCA.":::

> [!NOTE]
> For the Teams delegation issue, the delegator's mailbox is the target mailbox to test. For the Teams calendar App issue and Teams presence issue, the affected user's mailbox is the target mailbox to test.

#### Step 2: Verify that the Autodiscover service can route the Autodiscover requests to on-premises

In Windows PowerShell, run this command:

```powershell
Invoke-RestMethod -Uri "https://outlook.office365.com/autodiscover/autodiscover.json?Email=onpremisemailbox@contoso.com&Protocol=EWS&RedirectCount=5" -UserAgent Teams
```

> [!NOTE]
> For the Teams delegation issue, the delegator's mailbox is the target mailbox to test. For the Teams calendar App issue and Teams presence issue, the affected user's mailbox is the target mailbox to test.

For a mailbox hosted on-premises, the EWS URL should point to the on-premises external EWS. The output should resemble the following:

> Protocol Url
>
> \-------- ---
>
> EWS <https://mail.contoso.com/EWS/Exchange.asmx>

If this test fails, or if the EWS URL is incorrect, review the [Prerequisites](#prerequisites) section. This is because the problem is likely caused by an Exchange hybrid configuration issue, or a firewall or reverse proxy that is blocking external requests.

#### Step 3: Verify that the Exchange OAuth authentication protocol is enabled and functional

To verify Exchange OAuth authentication is enabled and functional, run the `Test-OAuthCOnnectivity` command as described in [Configure OAuth authentication between Exchange and Exchange Online organizations](https://docs.microsoft.com/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#how-do-you-know-this-worked).

Additionally, run the **Free/Busy** connectivity test that is available in the Microsoft Remote Connectivity Analyzer. To do this, follow these steps:

1. Navigate to [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

2. Select the **Free/Busy** test to verify that an Office 365 mailbox can access the free/busy information of an on-premises mailbox, and vice versa.

    You have to run this test two times by swapping the source mailbox email address with the target mailbox email address. This is because each run is unidirectional. This test doesn't necessarily have to be run by using affected accounts. Test can be run by using any pair of an on-premises mailbox and an Office 365 mailbox.

    To learn more about how to troubleshoot free/busy issues in a hybrid deployment of on-premises and Exchange Online in Office 365, see [this article](https://support.microsoft.com/help/2555008).

## Troubleshoot the Teams delegation issue

> [!NOTE]
> These troubleshooting steps apply to only the [Issue 1](#symptoms).

#### Step 1: Verify that the delegate has been granted the Editor permission to access the delegator's calendar

Open the Exchange Management Shell on one of the Exchange-based servers, and then run this Exchange PowerShell command to verify that the **Editor** access right has been granted to the delegate:

```powershell
Get-MailboxFolderPermission -Identity <delegator's UserPrincipalName>:\calendar  | Format-List
```

Check whether the **AccessRights** parameter contains a value of **Editor**. If not, run this command to grant the permission:

```powershell
Set-MailboxFolderPermission -Identity <delegator's UserPrincipalName>\Calendar -User <delegate's UserPrincipalName> -AccessRights Editor
```

Alternatively, ask the delegator to follow the steps in [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 2: Verify that the delegate has been granted "GrantSendOnBehalfTo" by the delegator

Run this command to verify that the **GrantSendOnBehalfTo** permission was granted to the delegate:

```powershell
Get-Mailbox -Identity <delegator's UserPrincipalName> | Format-List *grant*
```

Verify that the **GrantSendOnBehalfTo** parameter contains the delegate's alias. If not, run this command to grant the permission:

```powershell
Set-Mailbox <delegator's UserPrincipalName> -Grantsendonbehalfto @{add="<delegate's UserPrincipalName>"}
```

Alternatively, ask the delegator to follow the steps in [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run this Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only clients listed in **EwsAllowList** are allowed to access EWS. An empty value **EwsAllowList** (**EwsAllowList={}**) prevents all users from accessing EWS.

> [!NOTE]
> Blocking EWS can also result in the Teams Calendar App issues. See [Verify that Teams Calendar App is enabled](https://docs.microsoft.com/microsoftteams/troubleshoot/known-issues/teams-exchange-interaction-issue#troubleshoot-the-teams-calendar-app-issue).

Make sure that **\*SchedulingService\*** is listed as an array member of the **EwsAllowList** parameter. If not, run this command to add it:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="*SchedulingService*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True** or **Null** (blank). Otherwise, the Teams service will be blocked from accessing the EWS.

### Step 4: Verify that Teams isn't blocked from accessing EWS for the delegator's mailbox

Run this Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the delegator's mailbox:

```powershell
Get-CasMailbox <delegator's UserPrincipalName> | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only clients listed in **EwsAllowList** are allowed to access EWS.

Make sure that **\*SchedulingService\*** is listed as an array member of the **EwsAllowList** parameter. If not, run this Exchange PowerShell command to add it:

```powershell
Set-CASMailbox <delegator's UserPrincipalName> -EwsAllowList @{Add="*SchedulingService*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True**. Otherwise, the Teams service will be blocked from accessing the EWS.

### Step 5: Escalate the issue

If you verified that there's no problem with the prerequisites or configurations mentioned in this article, submit a service request to Microsoft Support with this information:

- The UserPrincipalName for both delegator and delegate.
- The Teams Meeting Add-in logs under the folder `%appdata%\\microsoft\\teams\\meeting-addin`.
- The time in UTC when the issue was reproduced.
- Teams client debug logs collected from the delegate's machine. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## Troubleshoot the Teams calendar App issue

> [!NOTE]
> The troubleshooting steps below only apply to the [Issue 2](#symptoms).

#### Step 1: Verify that Teams Calendar App is enabled

1. Open Microsoft Teams admin center, go to **Users** and select **View policies** for the affected user.

    :::image type="content" source="media/teams-exchange-interaction-issue/image2.png" alt-text="Screenshot of teams users.":::

2. Select the **App setup policy** assigned to that user. In the example above, the global (Org-Wide default) policy is being used. Confirm that the calendar App (ID `ef56c0de-36fc-4ef8-b417-3d82ba9d073c`) is displayed.

    :::image type="content" source="media/teams-exchange-interaction-issue/image3.png" alt-text="Screenshot of teams policy.":::

    If the calendar App is missing, restore it. For more information, see [Manage app setup policies in Microsoft Teams](https://docs.microsoft.com/microsoftteams/teams-app-setup-policies).

#### Step 2: Verify Teams upgrade Coexistence mode allows Teams meetings

1. Open the Microsoft Teams admin center.
2. Go to **Users**, and select the affected user.
3. Verify that the **Coexistence mode** setting is a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/image4.png" alt-text="Screenshot of teams policy2.":::

4. If the user Coexistence mode was set to **Use Org-wide settings**, the default tenant Coexistence mode will be used.
5. Go to **Org-wide settings**, and select **Teams Upgrade**.
6. Verify that the default **Coexistence mode** setting is a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/image5.png" alt-text="Screenshot of teams users island.":::

#### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run this Exchange PowerShell command to check whether the parameter **EwsApplicationAccessPolicy** was set to **EnforceAllowList** for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only clients that are listed in **EwsAllowList** are allowed to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the **EwsAllowList** parameter. If they aren't, run this command to add them:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True** or **Null** (blank). Otherwise, the Teams service will be blocked from accessing EWS.

#### Step 4: Verify that Teams isn't blocked from accessing EWS for the affected user

Run this Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the user mailbox:

```powershell
Get-CASMailbox <UserPincipalName> | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only clients that are listed in **EwsAllowList** are allowed to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the **EwsAllowList** parameter. If they aren't, run this Exchange PowerShell command to add them:

```powershell
Set-CASMailbox <UserPincipalName> -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True**. Otherwise, the Teams service will also be blocked from accessing EWS.

#### Step 5: Verify that the Microsoft Teams Calendar App test is successful

1. Ask the user to go to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/TeamsCalendarMissing/input).
2. Input the requested information.
3. Select the **Perform Test** button to start the Microsoft Teams Calendar App test.

If the test fails, you should attempt to resolve the issue and rerun the test.

:::image type="content" source="media/teams-exchange-interaction-issue/calendar-test.png" alt-text="Screenshot of testing calendar":::

#### Step 6: Escalate the issue

If you verified that there's no problem with the prerequisites and configurations mentioned in this article, submit a service request toMicrosoft Support with this information:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## Troubleshoot the Teams presence issue

These troubleshooting steps apply to only the [Issue 3](#symptoms).

#### Step 1: Verify that the URL for the on-premises Exchange REST API has been published on the public network

Run [Step 2](#common-troubleshooting-steps) in the Common Troubleshooting Steps above against the user's mailbox to locate the on-premises Exchange EWS URL, and change the URL format (replace "/EWS/Exchange.asmx" with "/api") in this manner: `https://mail.contoso.com/EWS/Exchange.asmx` to `https://mail.contoso.com/api`.

Try to access the REST API URL from a browser in the external network. If you get a 401 response from the on-premises Exchange environment, the REST API URL has been published. Otherwise, contact the local network team to get the URL published.

> [!NOTE]
> Teams presence service doesn't support the fallback to the EWS URL if the access to the Exchange REST API fails.

#### Step 2: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run this Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only clients that are listed in **EwsAllowList** are allowed to access EWS. An empty value **EwsAllowList** (**EwsAllowList={}**) prevents all clients from accessing EWS.

Make sure that **\*Microsoft.Skype.Presence.App/\*** is listed as an array member of the **EwsAllowList** parameter. If not, run this command to add it:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="*Microsoft.Skype.Presence.App/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True** or **Null** (blank). Otherwise, the Teams service will be blocked from accessing the EWS.

#### Step 3: Verify that Teams isn't blocked from accessing EWS for the user's mailbox

Run this Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the user's mailbox:

```powershell
Get-CasMailbox <user's UserPrincipalName> | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, only the clients that are listed in **EwsAllowList** are allowed to access EWS.

Make sure **\*Microsoft.Skype.Presence.App/\*** is listed as an array member of the **EwsAllowList** parameter. If not, run this Exchange PowerShell command to add it:

```powershell
Set-CASMailbox <user's UserPrincipalName> -EwsAllowList @{Add="* Microsoft.Skype.Presence.App/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True**. Otherwise, the Teams service will be blocked from accessing the EWS.

#### Step 4: Escalate the issue

If you verified there's no problem with the prerequisites and configurations mentioned in this article, submit a service request to Microsoft Support with this information:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## References

- [How Exchange and Microsoft Teams interact](https://docs.microsoft.com/microsoftteams/exchange-teams-interact)
- [Configuring Teams calendar access for on-premises Exchange mailboxes](https://techcommunity.microsoft.com/t5/exchange-team-blog/configuring-teams-calendar-access-for-exchange-on-premises/ba-p/1484009)
