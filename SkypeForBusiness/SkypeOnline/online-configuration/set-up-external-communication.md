---
title: Enable external communications
description: Helps your Skype for Business users communicate with Skype for Business or Skype users in other organizations.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: skype-for-business
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Skype for Business Online
search.appverid: MET150
---
# Set up Skype for Business Online external communications

_Original KB number:_ &nbsp; 10041

## Summary

This guide enables your Skype for Business users to IM and talk with Skype for Business contacts in other organizations, and also to Skype users who are signed in with a Microsoft account (formerly Windows Live ID). And you want to set it up so that everything works right the first time.

> [!NOTE]
> This is not the same as setting up external contacts in Outlook or sharing my website with outside people. Because each type of external contact has a different purpose.  
> A Skype for Business external contact is someone outside your organization who's using a compatible IM and conferencing client - either Skype for Business or Skype. However, all that's required for Outlook external contacts or website sharing is a valid email address. For more information, see [Collaborating with people outside your organization](/microsoft-365/solutions/collaborate-with-people-outside-your-organization?view=o365-worldwide).

First, we'll ask you a few quick questions about your Microsoft 365 setup. Then we'll give you all the information you need to complete up to four tasks.

This should take less than an hour of your time, plus up to 24 hours (for network propagation) if you haven't turned on external communications yet.

## Check your Microsoft 365 version

To check your Microsoft 365 version, sign in and go to **Admin** > **Licensing**.

What version of Microsoft 365 do you have?

- [Small Business](#if-the-version-is-small-business)
- [Midsize Business](#if-the-version-is-midsize-business)
- [Enterprise](#if-the-version-is-enterprise)

## If the version is Small Business

### Custom domain (Small Business)

Microsoft 365 creates a domain for you when you sign up (the domain name includes `.onmicrosoft.com`). But most companies prefer to use their own domain, like `fabrikam.com`, for their business email addresses and website.

If your current domain name ends in `.onmicrosoft.com`, you don't have a custom domain. For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

Are you using a custom domain with Office 365?

- If yes, see [Custom domain status (Small Business)](#custom-domain-status-small-business).
- If no, see [Turn on external communications](#turn-on-external-communications).

### Custom domain status (Small Business)

To set up your custom domain, sign in and select **Email address** in the Getting Started pane. (If you don't see the Getting Started pane, select **Setup** > **Open the Getting Started pane**.) For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

:::image type="content" source="media/set-up-external-communication/getting-started-pane.png" alt-text="screenshot of the Getting Started pane" border="false":::

Have you already set up your custom domain?

- If yes, see [Test your custom domain (Small Business)](#test-your-custom-domain-small-business).
- If no, see [Set up your custom domain (Small Business)](#set-up-your-custom-domain-small-business).

### Test your custom domain (Small Business)

After that make sure everything works as expected by running [Microsoft 365 Skype for Business Domain Name Server (DNS) Connectivity Test](https://www.testconnectivity.microsoft.com/tests/O365LyncDns/input).

When you've confirmed that your custom domain is set up correctly, continue to the next step.

#### Turn on external communications (Small Business)

Sign in to Microsoft 365, and go to **Admin** > **Service Settings** > **IM, meetings and conferencing** > **External communications**. For more information, see [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users).

:::image type="content" source="media/set-up-external-communication/turn-on-external-communications.png" alt-text="turn on external communications" border="false":::

First, if you haven't already done so, turn on external communications for everyone in your organization.

> [!IMPORTANT]
> It may take up to 24 hours for your changes to take effect. You can save your current progress and return if you need to.

#### Communicate with Skype for Business users in other organizations (Small Business)

If you want to communicate with external Skype for Business users, you'll need to make sure the admin in the other organization has set up external communications as well.

Do you want your users to communicate with Skype for Business users in other organizations?

- If yes, see [Contact the Skype for Business admin in the other organization](#contact-the-skype-for-business-admin-in-the-other-organization).
- If no, see [Inform your user](#inform-your-user).

### Set up your custom domain (Small Business)

#### Set up your custom domain

It's best to take the time and set up your custom domain now. The rest of this process will make much more sense after you've done so. Our goal: to help you get set up right the first time, so you can focus on your work and not on your software.

To set up your custom domain, sign in and select Email address in the Getting Started pane. (Go to **Setup** > **Open the Getting Started pane** if you don't see it.) For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

#### Test the custom domain

After that make sure everything works as expected by running [Microsoft 365 Skype for Business Domain Name Server (DNS) Connectivity Test](https://www.testconnectivity.microsoft.com/tests/O365LyncDns/input).

#### Turn on external communications (Small Business)

Sign in to Microsoft 365, and go to **Admin** > **Service Settings** > **IM, meetings and conferencing** > **External communications**. For more information, see [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users).

:::image type="content" source="media/set-up-external-communication/turn-on-external-communications.png" alt-text="turn on external communications" border="false":::

First, if you haven't already done so, turn on external communications for everyone in your organization.

> [!IMPORTANT]
> It may take up to 24 hours for your changes to take effect. You can save your current progress and return if you need to.

#### Communicate with Skype for Business users in other organizations (Small Business)

If you want to communicate with external Skype for Business users, you'll need to make sure the admin in the other organization has set up external communications as well.

Do you want your users to communicate with Skype for Business users in other organizations?

- If yes, see [Contact the Skype for Business admin in the other organization](#contact-the-skype-for-business-admin-in-the-other-organization).
- If no, see [Inform your user](#inform-your-user).

### Turn on external communications

Sign in to Microsoft 365, and go to **Admin** > **Service Settings** > **IM, meetings and conferencing** > **External communications**. For more information, see [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users).

:::image type="content" source="media/set-up-external-communication/turn-on-external-communications.png" alt-text="turn on external communications" border="false":::

First, if you haven't already done so, turn on external communications for everyone in your organization.

> [!IMPORTANT]
> It may take up to 24 hours for your changes to take effect. You can save your current progress and return if you need to.

#### Communicate with Skype for Business users in other organizations

If you want to communicate with external Skype for Business users, you'll need to make sure the admin in the other organization has set up external communications as well.

Do you want your users to communicate with Skype for Business users in other organizations?

- If yes, see [Contact the Skype for Business admin in the other organization](#contact-the-skype-for-business-admin-in-the-other-organization).
- If no, see [Inform your user](#inform-your-user).

### Contact the Skype for Business admin in the other organization

To communicate with external Skype for Business users:

1. Contact the admin in the other organization using this [email template](https://download.microsoft.com/download/C/F/4/CF47B781-7BC3-43DD-98CC-6309EAAA16E9/O365_LECSA_admin_email_template.doc).
2. Once they've turned on external communications, you and the other admin can add each other as Skype for Business contacts to test things out.
3. After you and the other admin have verified that you can use Skype for Business to communicate with each other, go to the next step.
4. Use this [email template](https://download.microsoft.com/download/C/B/D/CBD06981-8F2F-4229-A478-04B1531B560A/O365_LECSA_end_user_email_template.doc) to let your users know how adding external contacts works in your organization. The template includes links to these important end-user topics:

    - [Adding people to your contacts list in Lync](https://support.microsoft.com/office/adding-people-to-your-contacts-list-in-lync-2b703d7f-cb20-4c9c-a7f3-0126e5316301)
    - [What to try if you can't IM Lync or Skype external contacts](https://support.microsoft.com/office/what-to-try-if-you-can-t-im-lync-or-skype-external-contacts-87f6d5d7-3b8c-4196-9c8c-1dabb75f54b8)
    - [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users)

Can you now communicate with external Skype for Business or Skype contacts?

- If yes, congratulations, you're now set up for Skype for Business Online external communications.
- If no, see [What to do if external communications still doesn't work](#what-to-do-if-external-communications-still-doesnt-work).

### What to do if external communications still doesn't work

We're sorry you're having trouble setting up external communications.

If you've completed all the tasks in this guide, are able to sign in to Microsoft 365 using your custom domain name, and still can't communicate with outside users, here are some additional resources:

- [Search the Microsoft 365 Community forums](https://answers.microsoft.com/msoffice).
- [Contact support](https://support.office.com/article/Contact-Office-365-for-business-support-Admin-Help-32a17ca7-6fa0-4870-8a8d-e25ba4ccfd4b).

## If the version is Midsize Business

### Custom domain

Microsoft 365 creates a domain for you when you sign up (the domain name includes `.onmicrosoft.com`). But most companies prefer to use their own domain, like `fabrikam.com`, for their business email addresses and website.

If your current domain name ends in `.onmicrosoft.com`, you don't have a custom domain. For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

Are you using a custom domain with Microsoft 365?

- If yes, see [Custom domain status](#custom-domain-status).
- If no, see [Turn on external communications (Midsize Business and Enterprise)](#turn-on-external-communications-midsize-business-and-enterprise).

### Turn on external communications (Midsize Business and Enterprise)

First, if you haven't already done so, turn on external communications for everyone in your organization and configure any domain exceptions you may want to implement. If you want to communicate with other Lync or Skype for Business organizations, it's recommended that you add your partner's organizations domain to the list of Allowed domains.

Sign in to Microsoft 365, and go to **Admin Center** > **Settings** > **Services & add-ins** > **Skype for Business** > **External communications**. For more information, see [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users).

:::image type="content" source="media/set-up-external-communication/all-domains-are-blocked-except.png" alt-text="the screenshot of the All domains are blocked except option" border="false":::

> [!IMPORTANT]
> It may take up to 24 hours for your changes to take effect. You can save your current progress and return if you need to.

#### Communicate with Skype for Business users in other organizations

If you want to communicate with other Skype for Business organization, you'll need to make sure the admin in the other organization has set up external communications as well.

#### Communicate with Skype users

If you want to allow your Skype for Business Online users to communicate with Skype consumer users? If so, make sure the following switch is enabled:

:::image type="content" source="media/set-up-external-communication/enable-online-users-communicate-with-skype.png" alt-text="enable the communication with Skype users":::

Have you allowed your users to communicate with Skype for Business users in other organizations?

- If yes, see [Contact the Skype for Business admin in the other organization](#contact-the-skype-for-business-admin-in-the-other-organization).
- If no, see [Inform your user](#inform-your-user).

## If the version is Enterprise

### Custom domain (Enterprise)

Microsoft 365 creates a domain for you when you sign up (the domain name includes `.onmicrosoft.com`). But most companies prefer to use their own domain, like `fabrikam.com`, for their business email addresses and website.

If your current domain name ends in `.onmicrosoft.com`, you don't have a custom domain. For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

Are you using a custom domain with Microsoft 365?

- If yes, see [Custom domain status](#custom-domain-status).
- If no, see [Turn on external communications (Midsize Business and Enterprise)](#turn-on-external-communications-midsize-business-and-enterprise).

### Custom domain status

To set up your custom domain, sign in and go to **Admin** > **Setup**. For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

:::image type="content" source="media/set-up-external-communication/set-up-your-custom-domain.png" alt-text="setup custom domain" border="false":::

Have you already set up your custom domain?

- If yes, see [Turn on external communications (Midsize Business and Enterprise)](#turn-on-external-communications-midsize-business-and-enterprise).
- If no, see [Setup and test your custom domain](#setup-and-test-your-custom-domain).

### Setup and test your custom domain

It's best to take the time and set up your custom domain now. The rest of this process will make much more sense once you're done adding your own domain. Our goal: to help you get set up right the first time, so you can focus on your work, and not on your software.

To set up your custom domain, sign in and go to **Admin** > **Setup**. For more information, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

#### Test your custom domain

Run the domain troubleshooter:

1. Go to the Microsoft 365 admin center and select **Domains**.
2. Select your custom domain name, and then select **Fix Issues**.

    :::image type="content" source="media/set-up-external-communication/run-the-domain-troubleshooter.png" alt-text="Run the domain troubleshooter" border="false":::

Now make sure everything works as expected by running the domain troubleshooter in the Microsoft 365 admin center.

When you see a message that says everything is set up correctly, you can continue the next step.

If you have a firewall or proxy setup in your environment, make sure to configure it to exclude the [Office 365 URLs and IP address ranges](/office365/enterprise/urls-and-ip-address-ranges). If you need help with this step, contact Microsoft 365 Support.

#### Turn on external communications

##### Details

Sign in to Microsoft 365, and go to **Admin Center** > **Settings** > **Services & add-ins** > **Skype for Business** > **External communications**. For more information, see [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users).

:::image type="content" source="media/set-up-external-communication/all-domains-are-blocked-except.png" alt-text="the screenshot of the All domains are blocked except option" border="false":::

First, if you haven't already done so, turn on external communications for everyone in your organization. If you want to communicate with other Lync or Skype for Business organizations, it's recommended that you add your partner's organizations domain to the list of Allowed domains.

> [!IMPORTANT]
> It may take up to 24 hours for your changes to take effect. You can save your current progress and return if you need to.

#### Communicate with Skype for Business users in other organizations

##### Details

If you want to communicate with external Skype for Business users, you'll need to make sure the admin in the other organization has set up external communications as well.

Do you want your users to communicate with Skype for Business users in other organizations?

- If yes, see [Turn on external communications (Midsize Business and Enterprise)](#turn-on-external-communications-midsize-business-and-enterprise).
- If no, see [Custom domain](#custom-domain).

### Inform your user

The last step:

- Use this [email template](https://download.microsoft.com/download/C/B/D/CBD06981-8F2F-4229-A478-04B1531B560A/O365_LECSA_end_user_email_template.doc) to let your users know how adding external contacts works in your organization. The template includes links to these important end-user topics:
  - [Adding people to your contacts list in Lync](https://support.microsoft.com/office/adding-people-to-your-contacts-list-in-lync-2b703d7f-cb20-4c9c-a7f3-0126e5316301)
  - [What to try if you can't IM Lync or Skype external contacts](https://support.microsoft.com/office/what-to-try-if-you-can-t-im-lync-or-skype-external-contacts-87f6d5d7-3b8c-4196-9c8c-1dabb75f54b8)
  - [Allow users to contact external Skype for Business users](/SkypeForBusiness/set-up-skype-for-business-online/allow-users-to-contact-external-skype-for-business-users)

Can you now communicate with external Skype for Business or Skype contacts?

- If yes, congratulations, you're now set up for Skype for Business Online external communications.
- If no, see [What to do if external communications still doesn't work](#what-to-do-if-external-communications-still-doesnt-work).
