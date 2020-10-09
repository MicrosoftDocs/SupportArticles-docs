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

This article provides steps to help you troubleshoot interaction issues that occur between Microsoft Teams and Microsoft Exchange Server.

#### Getting Started

Bear in mind that you should have already given the main Exchange and Microsoft Teams interaction article to validate versioning, and assure environment compatibility [Exchange and Teams Interact](https://docs.microsoft.com/MicrosoftTeams/exchange-teams-interact)

## Symptoms

#### Issue 1: A delegate can not schedule a Teams meeting on behalf of a delegator

A user whose mailbox is hosted on Exchange Server adds another user as a delegate to manage the Outlook calendar. The delegate who is using the Teams Add-in for Outlook can not schedule a Teams meeting on behalf of the delegator, and Outlook returns the following error message:

> Looks like you don't have permission to schedule meetings for this account. Talk to the owner to get permission and try again.

#### Issue 2: You experience issues when you try to use the Teams Calendar App

Either of the following issues occurs:

- The Calendar icon isn't displayed in the Teams client.
- The Microsoft Teams Calendar App displays a "Sorry, we couldn't get your meeting details" error message when you use the Teams desktop client or web client.

Teams Calendar App requires access to the Exchange mailbox through Exchange Web Services (EWS). The Exchange mailbox can be online or on-premises in the scope of Exchange hybrid deployment.

#### Issue 3: Teams Presence information is incorrect

The Teams client can update the "Presence Status" based on the mailbox' calendar data. The required access to the calendar folder in the mailbox is done by the Teams backend in Microsoft 365 using the REST API of Exchange Online, Exchange Server 2016 or Exchange 2019. 


## Prerequisites

To integrate the Microsoft Teams service with your installation of Exchange Server, make sure that your local Exchange Server environment meets the following requirements:

- Microsoft Teams must check whether the mailbox is hosted in Exchange Online or on-premises. The service then decides where to access the mailbox accordingly. To enable the Teams service to check the mailbox location through the Autodiscover call to the Exchange Online service, you have to deploy an Exchange Hybrid environment by running the Exchange Hybrid Wizard, as described in [Create a hybrid deployment with the Hybrid Configuration wizard](https://docs.microsoft.com/exchange/hybrid-deployment/deploy-hybrid).

- To enable Microsoft Teams to authenticate to your on-premises Exchange environment to query the mailbox settings, you have to configure the new Exchange OAuth authentication protocol. It's preferable that you do this by running the Exchange Hybrid Wizard, as described in [Configure OAuth authentication between Exchange and Exchange Online organizations](https://docs.microsoft.com/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

- The server that's running Exchange Server must have a Partner application configured to have an application ID of Skype for Business Online, `00000004-0000-0ff1-ce00-000000000000`. The ID is used by the Teams scheduling service and a linked user account that has the following properties:

  - The account is hidden from the Exchange address book. It's a best practice to hide the account from the address book because it's a disabled user account.
  - The account has an Exchange management role assignment of **UserApplication**.

    To complete the integration, follow Steps 1-3 in [this article](https://docs.microsoft.com/skypeforbusiness/deploy/integrate-with-exchange-server/oauth-with-online-and-on-premises). Step 2 in the article includes the role assignment for **ArchiveApplication**. Although this isn't required for Teams delegation, it's required to archive Skype for Business Online Chat to an Exchange mailbox.

    > [!NOTE]
    > This requirement applies to only the Teams delegation issue but not to the Teams calendar App issue.

- You should configure your internet-facing firewall or reverse proxy server to allow Microsoft Teams to access the servers that are running Exchange Server by adding the URLs and IP address ranges for Skype for Business Online and Microsoft Teams into the allow list. For more information, see the "Skype for Business Online and Microsoft Teams" section of [Office 365 URLs and IP address ranges](https://docs.microsoft.com/office365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams).

- Exchange Autodiscover V2 is required to allow the Teams service to perform an unauthenticated discovery against the user's mailbox that's located in Exchange Server. Autodiscover V2 is fully supported in Exchange Server 2013 Cumulative Update 19 or later. This is good enough to enable Teams delegation to work correctly. However, Teams Calendar App requires Exchange Server 2016 Cumulative Update 3 or later to be installed. Therefore, for full feature support, Exchange Server 2016 Cumulative Update 3 or later is required.

## Common troubleshooting steps

> [!NOTE]
> The following troubleshooting steps apply to both [Issue 1](#symptoms) and [Issue 2](#symptoms).

#### Step 1: Verify that the Autodiscover service works well

Microsoft Teams service uses the Exchange Autodiscover service to locate the EWS URL that is published by the server that's running Exchange Server. To verify that the Autodiscover process is working well, follow these steps:

1. Ask the user to navigate to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/Ola/input).
1. Input the requested information (make sure that the **Use Autodiscover to detect server settings** check box is selected).
1. Select the **Perform Test** button to start the Autodiscover test.

If the test fails, you must first resolve the Autodiscover issue.

:::image type="content" source="media/teams-exchange-interaction-issue/image1.png" alt-text="Screenshot of RCA.":::

> [!NOTE]
> For the Teams delegation issue, the delegator's mailbox is the target mailbox to test. For the Teams calendar App issue, the affected user's mailbox is the target mailbox to test.

#### Step 2: Verify that the Autodiscover service can route the Autodiscover requests to on-premises

In Windows PowerShell, run the following command for EWS:

```powershell
Invoke-RestMethod -Uri "https://outlook.office365.com/autodiscover/autodiscover.json?Email=onpremisemailbox@contoso.com&Protocol=EWS" -UserAgent Teams
```
and for REST API:

```powershell
Invoke-RestMethod -Uri "https://outlook.office365.com/autodiscover/autodiscover.json?Email=onpremisemailbox@contoso.com&Protocol=REST" -UserAgent Teams
```

> [!NOTE]
> For the Teams delegation issue, the delegator's mailbox is the target mailbox to test. For the Teams calendar App issue, the affected user's mailbox is the target mailbox to test.

For a mailbox hosted on-premises, the EWS URL and REST API URL should point to the on-premises external URLs. The output should resemble the following:

> Protocol Url
>
> \-------- ---
>
> EWS <https://mail.contoso.com/EWS/Exchange.asmx>

or

> Protocol Url
>
> \-------- ---
>
> REST <https://mail.contoso.com/api>

If this test fails, or if the URL is incorrect, review the [Prerequisites](#prerequisites) section. This is because the problem is likely caused by an Exchange hybrid configuration issue, a firewall or reverse proxy that is blocking external requests.

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

Open the Exchange Management Shell on one of the Exchange-based servers, and then run the following Exchange PowerShell command to verify that the **Editor** access right has been granted to the delegate:

```powershell
Get-MailboxFolderPermission -Identity <delegator's UserPrincipalName>:\calendar  | Format-List
```

Check whether the **AccessRights** parameter contains a value of **Editor**. If not, run the following command to grant the permission:

```powershell
Set-MailboxFolderPermission -Identity <delegator's UserPrincipalName>\Calendar -User <delegate's UserPrincipalName> -AccessRights Editor
```

Alternatively, ask the delegator to follow the steps in [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 2: Verify that the delegate has been granted "GrantSendOnBehalfTo" by the delegator

Run the following command to verify that the **GrantSendOnBehalfTo** permission was granted to the delegate:

```powershell
Get-Mailbox -Identity <delegator's UserPrincipalName> | Format-List *grant*
```

Verify that the **GrantSendOnBehalfTo** parameter contains the delegate's alias. If not, run the following command to grant the permission:

```powershell
Set-Mailbox <delegator's UserPrincipalName> -Grantsendonbehalfto @{add="<delegate's UserPrincipalName>"}
```

Alternatively, ask the delegator to follow the steps in [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run the following Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, this means that the administrator allows only the clients that are listed in **EwsAllowList** to access EWS. If the **EwsAllowList** is set to an empty set value **EwsAllowList={}**, it will also block all users.

> [!NOTE]
> Blocking EWS can also result in the Teams Calendar App. See [Verify that Teams Calendar App is enabled](https://docs.microsoft.com/microsoftteams/troubleshoot/known-issues/teams-exchange-interaction-issue#troubleshoot-the-teams-calendar-app-issue).

Make sure that **\*SchedulingService\*** is listed as an array member of the **EwsAllowList** parameter. If not, run the following command to add it:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="*SchedulingService*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True** or **Null** (blank). Otherwise, the Teams service will also be blocked from accessing the EWS.

### Step 4: Verify that Teams isn't blocked from accessing EWS for the delegator's mailbox

Run the following Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the delegator's mailbox:

```powershell
Get-CasMailbox <delegator's UserPrincipalName> | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, this means that the administrator allows only the clients that are listed in **EwsAllowList** to access EWS.

Make sure that **\*SchedulingService\*** is listed as an array member of the **EwsAllowList** parameter. If not, run the following Exchange PowerShell command to add it:

```powershell
Set-CASMailbox <delegator's UserPrincipalName> -EwsAllowList @{Add="*SchedulingService*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True**. Otherwise, the Teams service will also be blocked from accessing the EWS.

### Step 5: Escalate the issue

If you can verify that no problems affect the prerequisites or configurations that are mentioned in this article, file a service request with Microsoft Support, and attach the following information:

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

2. Select **App setup policy** that is assigned for that user. In the example above, the global (Org-Wide default) policy is being used. Confirm that the calendar App (ID `ef56c0de-36fc-4ef8-b417-3d82ba9d073c`) is displayed.

    :::image type="content" source="media/teams-exchange-interaction-issue/image3.png" alt-text="Screenshot of teams policy.":::

    If the calendar App is missing, restore it. For more information, see [Manage app setup policies in Microsoft Teams](https://docs.microsoft.com/microsoftteams/teams-app-setup-policies).

#### Step 2: Verify Teams upgrade Coexistence mode allows Teams meetings

1. Open the Microsoft Teams admin center.
2. Go to **Users**, and select the affected user.
3. Verify that the **Coexistence mode** setting is a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/image4.png" alt-text="Screenshot of teams policy2.":::

4. If the user Coexistence mode was set to **Use Org-wide settings**, this means that the default tenant Coexistence mode will be used.
5. Go to **Org-wide settings**, and select **Teams Upgrade**.
6. Verify that the default **Coexistence mode** setting is a value other than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/image5.png" alt-text="Screenshot of teams users island.":::

#### Step 3: Verify that Teams isn't blocked from accessing EWS for the entire organization

Run the following Exchange PowerShell command to check whether the parameter **EwsApplicationAccessPolicy** was set to **EnforceAllowList** for the entire organization:

```powershell
Get-OrganizationConfig | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, that means that the administrator allows only the clients that are listed in **EwsAllowList** to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the **EwsAllowList** parameter. If they aren't, run the following command to add them:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True** or **Null** (blank). Otherwise, the Teams service will also be blocked from accessing EWS.

#### Step 4: Verify that Teams isn't blocked from accessing EWS for the affected user

Run the following Exchange PowerShell command to check whether the **EwsApplicationAccessPolicy** parameter was set to **EnforceAllowList** for the user mailbox:

```powershell
Get-CASMailbox <UserPincipalName> | Select-Object Ews*
```

If the parameter was set to **EnforceAllowList**, this means that the administrator allows only the clients that are listed in **EwsAllowList** to access EWS.

Make sure that **MicrosoftNinja/\***, **\*Teams/\***, and **SkypeSpaces/\*** are listed as array members of the **EwsAllowList** parameter. If they aren't, run the following Exchange PowerShell command to add them:

```powershell
Set-CASMailbox <UserPincipalName> -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}
```

If the **EwsEnabled** parameter is set to **False**, you have to set it to **True**. Otherwise, the Teams service will also be blocked from accessing EWS.

#### Step 5: Escalate the issue

If you can verify that no problems affect the prerequisites and configurations that are mentioned in this article, file a service request with Microsoft Support, and attach the following information:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Microsoft Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## Troubleshoot the Teams "Presence Status" issue

> [!NOTE]
> The troubleshooting steps below only apply to the [Issue 3](#symptoms).

#### Step 1: Verify that Teams Calendar App is enabled

1. Check the Apllication in the Windows Eventviewer for EventID 1309. Look into the details and check if the request URL starts with:

https://mail.contoso.com:443/api/v2.0/me/calendarView?$top=0&$...

In that case, you need to modify the web.config to allow the Teams Presence calls on your Exchange servers. To do that follow these steps:

a) locate the web.config file in the folder "C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy\Rest\"

b) Open it using a text editor such as Notepad

c) Locate the line:
<httpRuntime maxRequestLength="2097151" maxUrlLength="2048" requestPathInvalidCharacters="&lt;,>,*,%,\,?" requestValidationMode="2.0" />

and change it to:
<httpRuntime maxRequestLength="2097151" maxUrlLength="2048" maxQueryStringLength="4096" requestPathInvalidCharacters="&lt;,>,*,%,\,?" requestValidationMode="2.0" />

d) Restart the IIS apply the change.

e) Repeat this steps on all your Exchange servers. Keep im mind that this change needs to be made again after deploying any Exchange Security- or Cummulative update to the server.

#### Step 5: Escalate the issue

If you can verify that no problems affect the prerequisites and configurations that are mentioned in this article, file a service request with Microsoft Support, and attach the following information:

- The UserPrincipalName or E-Mail-Address of the affected user.
- The time in UTC when the issue was reproduced.
- Microsoft Teams client debug logs. For more information about how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## References

- [How Exchange and Microsoft Teams interact](https://docs.microsoft.com/microsoftteams/exchange-teams-interact)
- [Configuring Teams calendar access for on-premises Exchange mailboxes](https://techcommunity.microsoft.com/t5/exchange-team-blog/configuring-teams-calendar-access-for-exchange-on-premises/ba-p/1484009)
