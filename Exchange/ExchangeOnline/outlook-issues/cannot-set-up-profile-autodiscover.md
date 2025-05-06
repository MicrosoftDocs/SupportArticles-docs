---
title: Outlook can't set up a new profile by using Exchange Autodiscover for an Exchange Online mailbox in Microsoft 365
description: Describes an issue that blocks Outlook from setting up a new profile by using Exchange Autodiscover for an Exchange Online mailbox in Microsoft 365. Resolutions are provided.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
  - OutlookSetupProfile
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 02/27/2025
ms.reviewer: gbratton
---
# Outlook can't set up a new profile by using Exchange Autodiscover for an Exchange Online mailbox in Microsoft 365

## Symptoms

When you try to set up a new mail account for Microsoft 365 by using the Add New Account Wizard in Microsoft Outlook, your Outlook profile isn't automatically set up. Additionally, you receive the following error message when Outlook tries to set up the server settings for your profile:  

> An encrypted connection to your mail services is not available

When you test by using the Microsoft Remote Connectivity Analyzer, the following error message might be returned:  

> Autodiscover cannot process the given e-mail address. Only mailboxes and contacts are allowed.

## Cause

This problem occurs for one of the following reasons:

- The wrong email address was entered on the **Auto Account Setup** page of the Add New Account Wizard in Outlook.
- The required updates for Outlook to automatically connect to Exchange Online aren't installed for the version of Outlook that you're running.
- The Autodiscover CNAME record for your domain doesn't exist or isn't set up correctly.
- In organizations that use Active Directory synchronization, the **mail**, **mailNickname**, **displayName** , and **proxyAddresses** attributes aren't set up correctly for the synced user in the on-premises Active Directory.

> [!NOTE]
> This article discusses Outlook 2016, Outlook 2013, and Exchange Online. For help with connecting to Exchange Online from a mobile device, see [Set up and use Microsoft 365 on your phone or tablet](https://office.microsoft.com/redir/ha102818686.aspx). For help with connecting Outlook to a third-party service, contact your third-party mail provider.

## Resolution

### Recommended method

#### Method 1: Run the Classic Outlook Profile Setup troubleshooter in Get Help

[!INCLUDE [Get Help troubleshooter note](../../../includes/sara-note-new-outlook.md)]

The [Classic Outlook Profile Setup troubleshooter](https://aka.ms/SaRA-OutlookSetupProfile-sarahome) helps you configure your Microsoft 365 email in classic Outlook.

To run the troubleshooter, follow these steps:

1. Select the following button to start the troubleshooter.

   > [!div class="nextstepaction"]
   > [Classic Outlook Profile Setup troubleshooter](https://aka.ms/SaRA-OutlookSetupProfile-sarahome)

   If you receive a pop-up window that displays "This site is trying to open Get Help", select **Open**.
1. Follow the instructions in the Get Help app to run the troubleshooter.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.

### Other methods

### If you're using a custom domain

If Method 1 doesn't resolve the problem, and if you're using a custom domain with Microsoft 365, use the following methods in the order in which they're listed. If the first method doesn't resolve the problem, go to the next one.

#### Method 2: Upgrade to the latest version of Outlook

First, make sure that you enter the correct email address and password on the Auto Account Setup page of the Add New Account Wizard in Outlook.

If you're using Outlook 2010 or an earlier version, upgrade to the latest version of Outlook. For more information, see [Download and install Office using Microsoft 365 for business on your PC](https://support.office.com/article/download-and-install-office-using-office-365-for-business-on-your-pc-72977511-dfd1-4d8b-856f-405cfb76839c).

For more information about how to set up Outlook for Microsoft 365, see the following resources:

- [Set up email in Outlook (for Windows)](https://support.office.com/article/set-up-email-in-outlook-for-windows-6e27792a-9267-4aa4-8bb6-c84ef146101b?correlationid=623124d7-72bd-424b-9797-c596ad4d18bf)
- [Set up an email account in Outlook 2016 for Mac](https://support.office.com/article/set-up-an-email-account-in-outlook-2016-for-mac-86bd232e-0422-49b5-9b60-d1c5f1109f40)

If this method doesn't resolve the problem, go to Method 3.

#### Method 3: Make sure that the Autodiscover CNAME record is set up correctly

The Autodiscover CNAME record must exist and must be set up correctly. We strongly recommend that you set up Exchange Autodiscover when you're using Outlook to connect to Exchange Online mailboxes. Setting up Autodiscover and other related DNS records is required for Outlook connectivity in Exchange Online. Administrators can use the Domain Troubleshooting Wizard in Microsoft 365 or Microsoft Remote Connectivity Analyzer to confirm that the records are set up correctly.

**Use the Domain Troubleshooting Wizard in Microsoft 365**

To use the Domain Troubleshooting Wizard in Microsoft 365, follow these steps.

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)) by using an administrator account.
2. Select **Admin** to open the Microsoft 365 admin center.
3. In the left navigation pane, select **Domains**, then the domain name that's used by the affected user, and then select **Troubleshoot** to start the wizard.

**Use Microsoft Remote Connectivity Analyzer**

To use Remote Connectivity Analyzer to test whether Exchange Autodiscover is working correctly, follow these steps:

1. In a web browser, browse to the Microsoft Remote Connectivity Analyzer tool at the following website:

    [Remote Connectivity Analyzer Outlook Autodiscover test](https://testconnectivity.microsoft.com/tests/O365Ola/input)
2. Complete all the required fields on the form, and then select **Perform Test**.

    :::image type="content" source="media/cannot-set-up-profile-autodiscover/outlook-connectivity-required-fields.png" alt-text="Screenshot of the Outlook Connectivity form, showing required fields of email address, authentication type, and credentials.":::

3. When the test is finished, determine whether it's successful.

   - If the test is successful, Autodiscover is working correctly.
   - If the test fails, verify that the Autodiscover service is set up correctly. For more information, see the following resources:

     - If all mailboxes in your organization are in Exchange Online, add an Autodiscover CNAME record that points to "autodiscover.outlook.com". For more information, see [Create DNS records for Microsoft 365 at any DNS hosting provider](https://support.office.com/article/create-dns-records-for-office-365-at-any-dns-hosting-provider-7b7b075d-79f9-4e37-8a9e-fb60c1d95166) and [External Domain Name System records for Microsoft 365](/microsoft-365/enterprise/external-domain-name-system-records).

     - If you have an Exchange hybrid deployment, set up the Autodiscover public DNS records for your existing SMTP domains to point to an on-premises Exchange server. For more information, see [Hybrid deployment prerequisites](/exchange/hybrid-deployment-prerequisites).

#### Method 4: Make sure that the user's attributes in Active Directory are set correctly

If you have an Exchange hybrid deployment, you can use the [Get-RemoteMailbox](/powershell/module/exchange/get-remotemailbox) cmdlet to determine whether the correct attributes are set for the affected user. Common issues occur when a value isn't set for one or more of these attributes. The following example displays the correct attributes to set for the user.

|Attribute| Example |
|-|-|
|primarySMTPAddress|ted@contoso.com |
|alias|ted |
|displayName|Ted Bremer |
|emailAddresses|SMTP: ted@contoso.com X400:c=us;a= ;p=First Organization;o=Exchange;s=Bremer;g=Ted |
|remoteRoutingAddress|ted@contoso.mail.onmicrosoft.com |

To update these attributes, you can use the [Set-RemoteMailbox](/powershell/module/exchange/set-remotemailbox) cmdlet.

After the correct values are set for these attributes, [force directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_synchronizedirectories) to occur, and then try to set up the user's email account in Outlook.

### If you're not using a custom domain

#### Method 2: Use the Add New Account Wizard in Outlook

If Method 1 doesn't resolve the problem, and you're not using a custom domain together with Microsoft 365, you can use the Add New Account Wizard in Outlook to set up your Outlook profile by using the default "onmicrosoft.com"-based email address that's associated Exchange Online mailboxes for users when you signed up for Microsoft 365. When you use the Add New Account Wizard to set up a new mail profile, you specify your Microsoft 365 password and your default Microsoft 365 email address in the form of \<user\>@\<domain\>.onmicrosoft.com (for example, kim@contoso.onmicrosoft.com).

This method is supported and works for customers who might not plan to have their own vanity or custom domain. This method also supports Autodiscover. If your mailbox server location changes, Outlook is updated accordingly by using the new location of your mailbox server.

## More information

Microsoft doesn't support manually setting up a profile in Outlook for connectivity to mailboxes in Exchange Online in Microsoft 365. However, we can help you complete other tasks, such as setting up DNS and Autodiscover records as discussed in Method 2. This method lets you set up your account through the supported methods.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
