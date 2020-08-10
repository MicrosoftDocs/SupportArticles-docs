---
title: Troubleshoot Microsoft Teams and Exchange Server interaction issues
description: Provides steps to troubleshoot the interaction issues between Microsoft Teams and Exchange Server.
author: TobyTu
ms.author: chunlli
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: microsoft-teams
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

This article provides steps to help you troubleshoot the interaction issues between Microsoft Teams and Exchange Server.

## Symptoms

#### Problem 1: A delegate fails to schedule a Teams meeting on behalf of a delegator

A user whose mailbox is hosted on Exchange Server adds another user as a delegate to manage Outlook calendar. The delegate fails to schedule a Teams meeting on behalf of the user using the Teams Add-in for Outlook and the Add-in returns this error message:

> Looks like you don't have permission to schedule meetings for this account. Talk to the owner to get permission and try again.

#### Problem 2: Having issues using Teams Calendar App

Either Calendar icon isn't showing in Teams client or Calendar App displays "Sorry, we couldn't get your meeting details" when using Teams desktop client or Web client.

Microsoft Teams Calendar App requires access to Exchange mailbox via Exchange Web Services (EWS). The Exchange mailbox can be online or on-premises in the scope of Exchange hybrid deployment.

## Prerequisites

To integrate the Microsoft Teams service with your Exchange Server, ensure that your local Exchange Server environment meets the following requirements:

1. Microsoft Teams needs to check if the mailbox is hosted in Exchange Online or on-premises then decides where to access the mailbox accordingly. To enable the Teams service to check the mailbox's location via the Rest API call to the Exchange Online service, you need to deploy an Exchange Hybrid environment by running the Exchange Hybrid Wizard, as described in [Create a hybrid deployment with the Hybrid Configuration wizard](https://docs.microsoft.com/exchange/hybrid-deployment/deploy-hybrid)

2. To enable Microsoft Teams to authenticate to your on-premises Exchange environment to query the mailbox settings, you need to configure the new Exchange OAuth authentication protocol preferably by running the Exchange Hybrid Wizard, as described in [Configure OAuth authentication between Exchange and Exchange Online organizations.](https://docs.microsoft.com/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help)

3. The Exchange server must have a Partner Application configured with an application ID of Skype for Business Online, `00000004-0000-0ff1-ce00-000000000000`. The ID is used by the Teams scheduling service and a linked user account that has the following properties:

      - Hidden from the Exchange address book. It's a best practice to hide it from the address book because it's a disabled user account.
      - Exchange management role assignment of UserApplication.

    To complete the integration, follow Steps 1-3 in [How do you configure OAuth authentication between your on-premises Exchange and Exchange Online organizations](https://docs.microsoft.com/skypeforbusiness/deploy/integrate-with-exchange-server/oauth-with-online-and-on-premises) document. Step 2 in the document above includes role assignment for ArchiveApplication, which is not required for Teams delegation, but is for Archiving Skype for Business Online Chat to an Exchange mailbox.

    > [!NOTE]
    > This requirement only applies to the Teams delegation issue but not to the Teams calendar App issue.

4. Configure your internet-facing firewall or reverse proxy server to allow Microsoft Teams to access the Exchange Server by adding the URLs and IP address ranges for Skype for Business Online and Microsoft Teams into the whitelist. For more information, see [Office 365 URLs and IP address ranges](https://docs.microsoft.com/office365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams).

5. Auto Discover (AutoD) V2 is required to allow the Teams service to perform an unauthenticated discovery against the user's mailbox located in Exchange Server. AutoD V2 is fully supported in Exchange Server 2013 (Cumulative Update 19) or later, which is good enough to enable Teams delegation to work properly, however Teams Calendar App requires Exchange Server 2016 (Cumulative Update 3) or later to be installed. So for a full feature support, Exchange Server 2016 (Cumulative Update 3) or later is required.

## Common troubleshooting steps

> [!NOTE]
> The troubleshooting steps below apply to both issues.

#### Step 1: Verify that the Autodiscover to your Exchange Server works well

Microsoft Teams service uses the Exchange Autodiscover service to locate the EWS URL that is published by the on-premises. To verify that the Autodiscover process is working well, follow these steps:

1. Ask the user to navigate to the URL <https://testconnectivity.microsoft.com/tests/Ola/input>.
1. Input the requested information (make sure that the checkbox **Use Autodiscover to detect server settings** is checked).
1. Select the button **Perform Test** to start the Autodiscover test.

You need to resolve the Autodiscover issue first if the test fails.

:::image type="content" source="media/teams-exchange-interaction-issue/image1.png" alt-text="Screenshot of RCA.":::

> [!NOTE]
> For the Teams delegation issue, the target mailbox to test is the delegator's mailbox. For the Teams calendar App issue, the target mailbox to test is the affected user's mailbox.

#### Step 2: Verify that the Office 365 Autodiscover V2 service is able to route the Autodiscover requests to the on-premises

Open the Windows PowerShell and run the following command.

```powershell
Invoke-RestMethod -Uri "<https://outlook.office365.com/autodiscover/autodiscover.json?Email=onpremisemailbox@contoso.com&Protocol=EWS&RedirectCount=5>" -Agent Teams
```

> [!NOTE]
> For the Teams delegation issue, the target mailbox to test is the delegator's mailbox. For the Teams calendar App issue, the target mailbox to test is the affected user's mailbox.

For a mailbox hosted on-premises, EWS Url should point to the on-premises external EWS. Similar to the following output:

> Protocol Url
>
> \-------- ---
>
> EWS <https://mail.contoso.com/EWS/Exchange.asmx>

If this test fails or EWS Url is incorrect, review the prerequisites section as this is likely an Exchange Hybrid configuration issue or firewall or reverse proxy blocking external requests.

#### Step 3: Verify that the Exchange OAuth authentication protocol is enabled and functional

To verify Exchange OAuth authentication is enabled and functional, run the `Test-OAuthCOnnectivity` command as described in [Configure OAuth authentication between Exchange and Exchange Online organizations.](https://docs.microsoft.com/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help#how-do-you-know-this-worked)

Additionally, the **Free/Busy** connectivity test that is available in **Microsoft Remote Connectivity Analyzer** should also be performed. Follow the steps described below:

1. Navigate to <https://testconnectivity.microsoft.com/tests/o365>.

2. Select **Free/Busy** test to verify that an Office 365 mailbox can access the free/busy information of an on-premises mailbox, and vice versa.

    You need to execute this test twice by swapping the source mailbox address with the target mailbox email address as each execution is unidirectional. This test does not necessarily need to be performed using affected accounts. Test can be performed using any pair of an on-premises mailbox and an Office 365 mailbox.

    To learn more about how to troubleshoot free/busy issues in a hybrid deployment of on-premises and Exchange Online in Office 365, see [this article](https://support.microsoft.com/help/2555008).

## Troubleshooting steps for the Teams delegation issue

> [!NOTE]
> The troubleshooting steps below only apply to the Teams delegation issue.

#### Step 1: Verify that the delegate has been granted the Editor permission to access the delegator's calendar

Open the Exchange Management Shell on one of the Exchange servers then run the Exchange PowerShell command below to verify that the **Editor** access right has been granted to the delegate:

```powershell
 Get-MailboxFolderPermission -Identity \<delegator's UserPrincipalName\> | Format-List
```

Verify if **AccessRights** parameter contains the value of **Editor**. If not, run the command below to grant the permission:

```powershell
Set-MailboxFolderPermission -Identity \<delegator's UserPrincipalName\>\\Calendar -User \<delegate's UserPrincipalName\> -AccessRights Editor | Format-List
```

Alternatively, ask the delegator to follow the steps in [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 2: Verify that the delegate has been granted the 'GrantSendOnBehalfTo' permission by the delegator

Run the command below to verify that the 'GrantSendOnBehalfTo' permission has been granted to the delegate.

```powershell
Get-Mailbox -Identity \<delegator's UserPrincipalName\> | Format-List \*grant\*
```

Verify if the **GrantSendOnBehalfTo** parameter contains the delegate's alias. If not, run the command below to grant the permission.

```powershell
Set-Mailbox "\<delegator's UserPrincipalName\>" -Grantsendonbehalfto @{add="\<delegate's UPN\>"}
```

Alternatively, ask the delegator to follow the steps [this article](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926) to reconfigure the delegation in the Outlook client.

#### Step 3: Verify that Teams is not blocked from accessing EWS for the entire organization

Run the Exchange PowerShell command below to check if the parameter **EwsApplicationAccessPolicy** has been set to **EnforceAllowList** for the entire organization. If it has been set to **EnforceAllowList**, that means the administrator only allows the clients that are listed in **EwsAllowList** to access EWS.

```powershell
Get-OrganizationConfig | Select-Object Ews\*
```

Make sure that **SchedulingService** is listed as an array member of parameter **EwsAllowList**. If not, run the command below to add it:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="\*SchedulingService\*"}
```

If the parameter **EwsEnabled** is set to **False**, you need to set it to **True** or **Null** (blank), otherwise the Teams service will be blocked from accessing the EWS as well.

### Step 4: Verify that Teams is not blocked from accessing EWS for the delegator's mailbox

Run the Exchange PowerShell command below to check if the parameter **EwsApplicationAccessPolicy** has been set to **'EnforceAllowList'** for the delegator's mailbox. If it has been set to **'EnforceAllowList'**, that means the administrator only allows the clients that are listed in **EwsAllowList** to access EWS.

```powershell
Get-CasMailbox \<delegator's UserPrincipalName\> | Select-Object Ews\*
```

Make sure that **SchedulingService** is listed as an array member of parameter **EwsAllowList**. If not, run the Exchange PowerShell command below to add it:

```powershell
Set-CASMailbox \<delegator's UserPrincipalName\> -EwsAllowList @{Add="\*SchedulingService\*"}
```

If the **EwsEnabled** parameter is set to **False**, you need to either set it to **True** or **Null** (blank), otherwise the Teams service will be blocked from accessing the EWS as well.

### Step 5: Escalate the issue

If you could confirm there is nothing wrong with the prerequisites and configurations mentioned above, create a service request to Microsoft Support with the following information attached:

- The UserPrincipalName for both delegator and delegate.
- The Teams Meeting Add-in logs under the folder `%appdata%\\microsoft\\teams\\meeting-addin`.
- The time in UTC when the issue was reproduced.
- Teams client debug logs collected from the delegate's machine. For more information regarding how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## Troubleshooting steps for the Teams calendar App issue

> [!NOTE]
> The troubleshooting steps below only apply to the Teams calendar App issue.

#### Step 1: Verify that Teams Calendar App is enabled

1. Open Microsoft Teams admin center, go to **Users** and select **View policies** for the affected user.

    :::image type="content" source="media/teams-exchange-interaction-issue/image2.png" alt-text="Screenshot of teams users.":::

2. Select **App setup policy** that is assigned for that user. In the example above, the global (Org-Wide default) policy is being used. Confirm that the calendar App (ID `ef56c0de-36fc-4ef8-b417-3d82ba9d073c`) is displayed.

    :::image type="content" source="media/teams-exchange-interaction-issue/image3.png" alt-text="Screenshot of teams policy.":::

    If the calendar App is missing, add it back. For more information, see [Manage app setup policies in Microsoft Teams](https://docs.microsoft.com/microsoftteams/teams-app-setup-policies).

#### Step 2: Verify Teams upgrade coexisting mode allows Teams meetings

1. Open Microsoft Teams admin center.
2. Go to **Users** and select affected user.
3. Confirm that the **Coexistence mode** is set to other value than **Skype for Business only** or **Skype for Business with Teams collaboration**.

    :::image type="content" source="media/teams-exchange-interaction-issue/image4.png" alt-text="Screenshot of teams policy2.":::

4. If user **Coexistence mode** was set to **Use Org-wide settings,** meaning that the tenant default coexistence mode will be used.
5. Go to **Org-wide settings** and select **Teams Upgrade.**
6. Confirm that the default **Coexistence mode** is set to other value than **Skype for Business only** or **Skype for Business with Teams collaboration.**

    :::image type="content" source="media/teams-exchange-interaction-issue/image5.png" alt-text="Screenshot of teams users island.":::

#### Step 3: Verify that Teams is not blocked from accessing EWS for the entire organization

Run the Exchange PowerShell command below to check if the parameter **EwsApplicationAccessPolicy** has been set to **EnforceAllowList** for the entire organization. If it has been set to **EnforceAllowList**, that means the administrator only allows the clients that are listed in **EwsAllowList** to access EWS.

```powershell
Get-OrganizationConfig | Select-Object Ews\*
```

Make sure that **MicrosoftNinja/\*,** **\*Teams/*** and **SkypeSpaces/*** are listed as array members of parameter **EwsAllowList**. If not, run the command below to add them:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="MicrosoftNinja/\*","\*Teams/\*","SkypeSpaces/\*"}
```

If the parameter **EwsEnabled** is set to **False**, you need to set it to **True** or **Null** (blank), otherwise the Teams service will be blocked from accessing EWS as well.

#### Step 4: Verify that Teams is not blocked from accessing EWS for the affected user

Run the Exchange PowerShell command below to check if the parameter **EwsApplicationAccessPolicy** has been set to **EnforceAllowList** for the user mailbox. If it has been set to **EnforceAllowList**, that means the administrator only allows the clients that are listed in **EwsAllowList** to access EWS.

```powershell
Get-CasMailbox \<UserPincipalName\> | Select-Object Ews\*
```

Make sure that **MicrosoftNinja/\*,** **\*Teams/\*** and **SkypeSpaces/\*** are listed as array members of parameter **EwsAllowList**. If not, run the Exchange PowerShell command below to add them.

```powershell
Set-CASMailbox \<UserPincipalName\> -EwsAllowList @{Add="MicrosoftNinja/\*","\*Teams/\*","SkypeSpaces/\*"}
```

If the **EwsEnabled** parameter is set to **False**, you need either to set to **'True'** or **'Null'** (blank), otherwise the Teams service will be blocked from accessing EWS as well.

#### Step 5: Escalate the issue

If you could confirm there is nothing wrong with the prerequisites and configurations mentioned above, create a service request to Microsoft Support with the following information attached:

- The UserPrincipalName of the affected user.
- The time in UTC when the issue was reproduced.
- Microsoft Teams client debug logs. For more information regarding how to collect these logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

## Reference

- [How Exchange and Microsoft Teams interact](https://docs.microsoft.com/microsoftteams/exchange-teams-interact)
- [Configuring Teams calendar access for on-premises Exchange mailboxes](https://techcommunity.microsoft.com/t5/exchange-team-blog/configuring-teams-calendar-access-for-exchange-on-premises/ba-p/1484009)
