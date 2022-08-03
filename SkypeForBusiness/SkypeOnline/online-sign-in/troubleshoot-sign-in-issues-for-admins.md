---
title: Troubleshoot sign-in issues for admins
description: Helps Microsoft 365 administrators troubleshoot and solve sign-in issues with Skype for Business Online.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 150322
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---
# Troubleshoot Skype for Business Online sign-in issues for admins

_Original KB number:_ &nbsp; 10133

This article will begin by asking you questions about your installation and the symptoms you're experiencing. Then we'll take you through a series of troubleshooting steps and configuration checks that are specific to your situation.

The amount of time you spend will depend on the type of Microsoft 365 installation you have, and the root causes of your sign-in issues.

## One user, or a few users here and there affected

### Access to Microsoft 365 on the web

If the affected users can sign in to Microsoft 365 portal at [here](https://login.microsoftonline.com), go to [Valid Skype for Business user](#valid-skype-for-business-user).

If the users can't sign in to Microsoft 365, see the [Can't sign in to Microsoft 365](#cant-sign-in-to-microsoft-365) section.

### Can't sign in to Microsoft 365

If the users can't sign in to Microsoft 365, ask them to try the troubleshooting steps suggested in [You can't sign in to Microsoft 365, Azure, or Intune](/microsoft-365/troubleshoot/sign-In/sign-in-to-office-365-azure-intune).

If the issue still exists, [contact support](#contact-support).

### Valid Skype for Business user

Check that the affected users have a valid Skype for Business license with the following steps:

1. Sign in at <a href="https://go.microsoft.com/fwlink/p/?linkid=2024339" target="_blank">admin.microsoft.com</a> with your admin account.
2. Go to **Users** > **Active users**, select the user that you want to check the license status.
3. In the right pane, select **Licenses and Apps**.
4. Verify that the user is licensed for Skype for Business Online.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/verify-user-licensed.png" alt-text="Screenshot that shows the user's license information with a license for Skype for Business Online assigned.":::

    Your user license screen may be different from this example.
5. Wait 30 minutes, and then ask the user to try signing in again.

If this method doesn't resolve your issue, [sign in on another device](#sign-in-on-another-device).

#### Sign in on another device

If you are able to sign in to Skype for Business Online on another computer, or on a tablet or smartphone, go to the [Type of device](#type-of-device) section.

If you aren't able to sign in to Skype for Business Online on another device, go to the [Sign in on to another network](#sign-in-on-to-another-network) section.

If you don't have another device available right now, go to the [Type of device](#type-of-device) section.

##### Type of device

Choose the type of device that is having difficulty signing in:

- [Windows computer, laptop, or tablet](#synchronize-your-system-clock-with-the-network-windows-computer-or-laptop)
- [Mac computer or laptop](#synchronize-your-system-clock-with-the-network-mac-computer-or-laptop)
- [Smartphone or tablet](#update-skype-for-business-on-the-smartphone-or-tablet)
- [iPad or Android tablet](#update-skype-for-business-on-the-smartphone-or-tablet)

###### Synchronize your system clock with the network (Windows computer or laptop)

Make sure the system clock shows the correct time, and then try signing in again. To update your computer's system time, follow these steps:

- Windows 8

    1. Go to a web site that shows Coordinated Universal Time (UTC).
    1. Go to **Setting** > **PC Settings** > **Time and Language**.
    1. Note your UTC offset, and compare your device's time to that shown on the website.

        :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/store.png" alt-text="Screenshot that shows the Store icon.":::

    If you need to update your device's time:

    1. Turn off **Set time automatically** and tap **Change**.
    1. Update the time and tap **Change**.
    1. Try signing in again.

- Windows 7

    1. Go to a web site that shows Coordinated Universal Time (UTC).
    1. Go to **Control Panel** > **Date and Time**, and note the UTC offset for your location.

        :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/utc-offset.png" alt-text="Screenshot that shows the where to check the U T C information in the Date and Time tab.":::
    1. If you need to, choose **Change date and time** and update your computer's clock.
    1. Try signing in again.

If the problem isn't solved, go to the [Determine Lync client version (Windows)](#determine-lync-client-version-windows) section.

###### Determine Lync client version (Windows)

If you're using the desktop version of Skype for Business, find out if it's Skype for Business 2010 or Skype for Business 2013. To do this, click the arrow next to the **Options** button:::image type="icon" source="./media/troubleshoot-sign-in-issues-for-admins/option-button.png" alt-text="Screenshot that shows the icon of the Options button.":::, and then go to **Help** > **About Microsoft Skype for Business**.

Choose your version of Skype for Business:

- [Skype for Business 2015](#update-skype-for-business-2015)
- [Skype for Business Windows Store app](#update-skype-for-business-windows-store-app)

###### Microsoft 365 Desktop Setup (Lync 2010)

Make sure that **Microsoft Online Services Sign-in Assistant** is running on Windows Services by following these steps:  
(These steps are for Windows 10)

1. Right-click the **Start** button and select **Run**.
2. Type `services.msc` and select **OK**.
3. In the **Services** window, check whether the **Status** of **Microsoft Online Services Sign-in Assistant** is listed as **Running**.

###### Delete Lync 2010 sign-in information

Make sure that previously saved sign-in information isn't blocking your current sign-in attempt.

If the issue still exists, clear the [Clear the DNS cache (Lync 2010)](#clear-the-dns-cache-lync-2010) section.

###### Clear the DNS cache (Lync 2010)

Make sure that previously save network information is not blocking your sign-in attempt, and then try signing in again. To do this, follow these steps:

- Windows 8

  - Clear the DNS cache (summary): run the Command prompt app as an administrator, and enter `ipconfig /flushdns`.

  - Clear the DNS cache (details):

    1. Swipe in from the right or point to the upper right of the screen.
    1. Choose **Search**, and then type *command*.
    1. Select the Command prompt app, and then swipe up from the bottom or right click for options.
    1. Choose **Run as administrator**, and then choose **Yes**.
    1. Enter `ipconfig /flushdns`.

- Windows 7, Windows Vista, Windows XP, Windows Server 2008, or Windows Server 2003

    1. Click **Start**, and in the **Search programs and files** box, enter *cmd.exe*.
    1. Right-click cmd.exe in the search list, and then click **Run as administrator**.
    1. Enter `ipconfig /flushdns`.

If the issue still exists, go to the [Configure connection settings manually (Lync 2010 and Skype for Business 2015)](#configure-connection-settings-manually-lync-2010-and-skype-for-business-2015) section.

###### Configure connection settings manually (Lync 2010 and Skype for Business 2015)

Ask the user to manually add Skype for Business server settings and try signing in again.

Manually add Skype for Business server settings:

1. Go to **Lync options**:::image type="icon" source="./media/troubleshoot-sign-in-issues-for-admins/option-button.png" alt-text="Screenshot that shows the icon of the Options button."::: > **Personal**.
1. Under **My account**, click **Advanced**, and then click **Manual configuration**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/manual-configuration.png" alt-text="Screenshot that shows the Manual configuration option selected in the Advanced Connection Settings window.":::

1. Enter *sipdir.online.lync.com:443* in both boxes, and then click **OK** > **OK**.
1. Sign out, and then try signing back in.

If the issue still exists, [contact support](#contact-support).

###### Update Skype for Business 2015

Make sure the user has the most current version of Skype for Business 2015. If this method doesn't solve the issue, go to the [Delete Skype for Business 2015 sign-in information](#delete-skype-for-business-2015-sign-in-information) section.

###### Delete Skype for Business 2015 sign-in information

Make sure that previously saved sign-in information isn't blocking the sign-in attempt. Ask the user to follow these steps:

1. Sign out and delete sign-in information.

    1. Click the status menu below your name, and then click **Sign Out**.
    1. On the sign-in screen, click **Delete my sign-in info**.

         :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/delete-my-sign-in-info.png" alt-text="Screenshot that shows the Delete my sign-in info option in the Lync Sign-out window.":::

1. Delete cached sign-in credentials.

    Find your local AppData folder and delete it: `%LOCALAPPDATA%\Microsoft\Communicator\<sip_address@contoso.com>`.
1. Try signing in again.

If the issue still exists, go to the [Configure connection settings manually (Lync 2010 and Skype for Business 2015)](#configure-connection-settings-manually-lync-2010-and-skype-for-business-2015) section.

###### Update Skype for Business Windows Store app

Make sure you have the most current version of Skype for Business Windows Store app:

1. On the Start screen, tap **Store**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/store.png" alt-text="Screenshot that shows the sign of Store.":::

1. Search for Skype for Business, and install the update if one is available.
1. Try signing in again.

If the issue still exists, go to the [Delete your sign-in information (Skype for Business Windows Store app)](#delete-your-sign-in-information-skype-for-business-windows-store-app) section.

###### Delete your sign-in information (Skype for Business Windows Store app)

Make sure that previously saved sign-in information isn't blocking your sign-in attempt. To do this, follow these steps:

1. On the Skype for Business Windows Store app sign-in screen, tap **Delete my sign-in info**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/delete-sign-in-info-windows-store-app.png" alt-text="Screenshot that shows the sign-in screen with the Delete my sign-in info option.":::
1. Try signing in again.

If the issue still exists, [contact support](#contact-support).

###### Synchronize your system clock with the network (Mac computer or laptop)

Make sure the system clock shows the correct time, and then try signing in again. Ask the user to follow these steps:

1. Go to a web site that shows Coordinated Universal Time (UTC).
1. Go to **Apple** :::image type="icon" source="./media/troubleshoot-sign-in-issues-for-admins/apple-icon.png" alt-text="Screenshot that shows the Apple icon.":::> **System Preferences**.
1. In the **Date & Time** pane, click the **Date & Time** tab.
1. Note the UTC offset for your location.
1. If you need to, update your computer's clock, and then try signing in again.

If the issue isn't solved, go to the [Update Lync for Mac 2011](#update-lync-for-mac-2011) section.

###### Update Lync for Mac 2011

Make sure the user's computer has the [most recent version](https://go.microsoft.com/fwlink/p/?linkid=328618) of Lync for Mac 2011.

If this method doesn't solve this issue, go to the [Delete Lync for Mac 2011 sign-in information](#delete-lync-for-mac-2011-sign-in-information) section.

###### Delete Lync for Mac 2011 sign-in information

Make sure that previously saved sign-in information isn't blocking the current sign-in attempt.

1. Delete the following data:

    - `Users/Home Folder/Library/Caches/com.microsoft.Lync`
    - `Users/Home Folder/Documents/Microsoft User Data/Microsoft Lync History`

1. delete any corrupted or cached certificates.

   1. Open the **Keychain Access** certificate management utility. To do this, in **Finder**, click **Applications**, click **Utilities**, and then click **Keychain Access**. Or, search for **Keychain Access** by using **Spotlight**.
   1. In the left pane, click **login**, and then click **Certificates**.
   1. In the right pane, find any certificate named Unknown or Communications Server, select it, and then delete it. You may have to unlock your keychain by using your password.
   1. Close **Keychain Access**.
   1. Restart Lync for Mac.

If the issue still exists, go to the [Configure connection settings manually (Lync for Mac 2011)](#configure-connection-settings-manually-lync-for-mac-2011) section.

###### Configure connection settings manually (Lync for Mac 2011)

Ask the user to manually add Lync server settings and try signing in again.

1. Click **Advanced**.
1. Under **Authentication**, clear the **Use Kerberos** check box.
1. Under **Connection Settings**, click **Manual configuration**.
1. In both the **Internal Server Name** box and the **External Server Name** box, type or paste `sipdir.online.lync.com:443`.
1. Click **OK**.

If the issue still exists, [contact support](#contact-support).

###### Update Skype for Business on the smartphone or tablet

Ask the user to go to the app store for their device and check for updates to the currently installed version of Skype for Business.

If the issue isn't solved, go to the [Configure connection settings manually (Skype for Business for mobile devices)](#configure-connection-settings-manually-skype-for-business-for-mobile-devices) section.

###### Configure connection settings manually (Skype for Business for mobile devices)

Ask the user to manually add Lync server settings and try signing in again.

1. On the sign-in screen, tap **More Details** (Windows) or **Show Advanced Options** (iPhone, iPad, or Android).
1. Turn off **Auto-Detect Server**.
1. In both the **Internal Discovery Name** and **External Discovery Name** boxes, enter `https://webdir.online.lync.com/Autodiscover/autodiscoverservice.svc/Root`.
1. Click **Sign In**.

If the issue still exists, [contact support](#contact-support).

#### Sign in on to another network

If users can sign in on to a different network, for example, at home, or at a public wireless access point, [verify internal network server setup](#verify-internal-network-server-setup). If users can't, go to the [Directory synchronization](#directory-synchronization) section.

If users don't have access to a different network right now, [verify internal network server setup](#verify-internal-network-server-setup).

##### verify internal network server setup

Make sure your organization's firewall isn't blocking Lync traffic. To do to this, run the Lync Online Transport Reliability IP Probe (TRIPP) tool.

Check for blocked ports or URLs:

1. On the affected network, go to the TRIPP tool address that is nearest to the users physical location:
    1. Amsterdam, NL: `http://trippams.online.lync.com`
    1. Blue Ridge, VA: `http://trippbl2.online.lync.com`
    1. Dublin, IE: `http://trippdb3.online.lync.com`
    1. Hong Kong Special Administrative Region: `http://tripphkn.online.lync.com`
    1. San Antonio, TX: `http://trippsn2.online.lync.com`
    1. Singapore: `http://trippsg1.online.lync.com`
1. Click **Start Test**.
1. If any of the tests fail, correct your internal server settings, and then rerun the TRIPP tool to verify your changes.
1. Try signing in again.

For more information about the TRIPP tool, see [You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection](https://support.microsoft.com/help/2409256).

If the issue isn't solved, does your organization have an internal firewall, proxy server, or DNS server? If yes, [verify internal DNS autodiscover settings](#verify-internal-dns-autodiscover-settings). If no, go to the [Directory synchronization](#directory-synchronization) section.

##### Verify internal DNS autodiscover settings

Make sure your internal DNS server has the CNAME and SRV records required for internal user sign-in

The following tables list Internal Lync autodiscover settings.

| Type  |Host name  |Destination  |TTL  |
|---------|---------|---------|---------|
|CNAME     |   `sip.yourDomainName.com`     |     `sipdir.online.lync.com`    |   1 hour      |
|CNAME     |  `lyncdiscoverinternal.yourDomainName.com`       |    `webdir.online.lync.com`     |  1 hour       |

|Type |Service  |Protocol  |Port  |Weight  |Priority  |TTL  |Name  |Target  |
|---------|---------|---------|---------|---------|---------|---------|---------|---------|
|SRV   |_sip       |_tls         |443     |1       |100       |1 hour       |@       |`sipdir.online.lync.com`        |

If the issue still exists, see the [Directory synchronization](#directory-synchronization) section below.

###### Directory synchronization

Find out if you've set up directory synchronization:

1. In the Microsoft 365 admin center, go to **User and groups**.
1. Check the status of Active Directory synchronization.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/check-status-of-ad-synchronization.png" alt-text="Screenshot that shows the Active Directory synchronization status in the User and groups tab.":::

If your organization synchronizing Active Directory with Microsoft 365 is using the Windows Azure Directory Synchronization Tool, go to [Single sign-on](#single-sign-on) section. If not, [contact support](#contact-support).

###### Single sign-on

Is your organization using single sign-on with Microsoft 365? If yes, go to the [Active Directory Federation Services (AD FS) configuration](#active-directory-federation-services-ad-fs-configuration) section.

If your organization isn't using single sign-on with Microsoft 365, see the [Duplicate or conflicting Active Directory entries](#duplicate-or-conflicting-active-directory-entries) section.

###### Duplicate or conflicting Active Directory entries

If you had a previous version of Skype for Business Server, or a current Skype for Business installation that's not configured for hybrid, then existing user attributes carried over from your on-premises Active Directory can conflict with the online values and cause sign-in issues.

To make sure that obsolete or duplicate Active Directory entries are not causing your sign-in issues, use the Active Directory Service Interfaces Editor (ADSI Edit) to:

- Check for duplicate SIP addresses.
- Make sure the `msRTCSIP-UserEnabled` attribute for affected users is set to **TRUE**.

If the issue still exists, [contact support](#contact-support).

###### Active Directory Federation Services (AD FS) configuration

Check for known Active Directory Federation Services (AD FS) issues that might prevent single sign-on from working as expected. For details, see [Enterprise single sign-on users in Microsoft 365 can't sign in to Lync Online from inside their corporate network](https://support.microsoft.com/help/2839539).

If this method doesn't solve this issue, go to the [Hybrid Deployment with on-premises Skype for Business Server](#hybrid-deployment-with-on-premises-skype-for-business-server) section.

###### Hybrid Deployment with on-premises Skype for Business Server

You have a hybrid deployment if you've set up a [shared SIP address space](/skypeforbusiness/deploy/integrate-with-exchange-server/outlook-web-app) with Skype for Business Online, and your on-premises Lync server shares a domain with your Microsoft 365 organization.

If you have a Skype for Business Server 2015 and Skype for Business Online hybrid deployment, go to the [Skype for Business users enabled on-premises and moved to the cloud](#skype-for-business-users-enabled-on-premises-and-moved-to-the-cloud) section. If you don't have, go to [Duplicate or conflicting Active Directory entries](#duplicate-or-conflicting-active-directory-entries).

###### Skype for Business users enabled on-premises and moved to the cloud

Make sure the users have been:

1. Enabled for Skype for Business on the on-premises Skype for Business Server.
1. Licensed for Skype for Business in Microsoft 365.
1. [Moved to Skype for Business Online](/SkypeForBusiness/hybrid/move-users-between-on-premises-and-cloud?toc=/SkypeForBusiness/toc.json).

If the issue still exists, [contact support](#contact-support).

## Everybody in a specific group or at a single location affected

### Custom domain

Microsoft 365 creates a domain for you when you sign up (the domain name includes .onmicrosoft.com). But most companies prefer to use their own domain, like fabrikam.com, for their business email addresses and website.

If your current domain name ends in .onmicrosoft.com, you don't have a custom domain.

Are you using a custom domain with Microsoft 365? If yes, go to the [Office version](#office-version) section. If no, go to the [Access to Microsoft 365 on the web](#access-to-microsoft-365-on-the-web) section.

### Office version

To check your Microsoft 365 subscription, sign in and go to **Admin** > **Licensing**.

What type of Microsoft 365 subscription do you have?

- [Small Business](#custom-domain-status-small-business)
- [Academic](#skype-for-business-server-and-skype-for-business-online-hybrid-deployment)
- [Midsize Business](#skype-for-business-server-and-skype-for-business-online-hybrid-deployment)
- [Enterprise](#skype-for-business-server-and-skype-for-business-online-hybrid-deployment)

### Custom domain status (Small Business)

To set up your custom domain, sign in and click **Email address** in the Getting Started pane. (If you don't see the Getting Started pane, click **Setup** > **Open the Getting Started pane**.) [Learn more](/microsoft-365/admin/setup/add-domain).

:::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/click-email-address.png" alt-text="Screenshot that shows the Email address option in the Getting Started pane.":::

Have you already set up your custom domain? If yes, go to [Test your custom domain (Small Business)](#test-your-custom-domain-small-business) section. If no, go to the [Set up your custom domain (Small Business)](#set-up-your-custom-domain-small-business) section.

#### Test your custom domain (Small Business)

Now make sure everything works as expected by running the domain troubleshooter in the Microsoft 365 admin center.

If you discovered any network setup issues, resolve them, and then try signing in again.

Run the domain troubleshooter:

1. Go to the Microsoft 365 admin center and click **Domains**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/click-domains.png" alt-text="Screenshot that shows the Domains option in the Microsoft 365 admin center.":::

1. Select your custom domain name, and then click **Troubleshooting**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/click-troubleshoot.png" alt-text="Screenshot that shows the troubleshoot option selected.":::
1. If you discovered any network setup issues, resolve them, and then try signing in again.

If this method doesn't solve the issue, go to the [Access to Microsoft 365 on the web](#access-to-microsoft-365-on-the-web) section.

### Set up your custom domain (Small Business)

It's best to take the time and set up your custom domain now. That way we can check for additional issues that might cause sign-in errors in the future.

To set up your custom domain, sign in and click **Email address** in the Getting Started pane. (Go to **Setup** > **Open the Getting Started pane** if you don't see it.) [Learn more](/microsoft-365/admin/setup/add-domain).

Don't worry, we'll save your place, and you can start where you left off. Just click **Save current progress** at the bottom. Then, [test your custom domain (Small Business)](#test-your-custom-domain-small-business) section.

### Skype for Business Server and Skype for Business Online hybrid deployment

You have a hybrid deployment if your on-premises Skype for Business server shares a domain with your Microsoft 365 organization, and you've set up a [shared SIP address space](/skypeforbusiness/deploy/integrate-with-exchange-server/outlook-web-app) with Skype for Business Online.

Do you have a Skype for Business Server 2015 and Skype for Business Online hybrid deployment? If yes, go to the [Verify your Skype for Business Server hybrid deployment setup](#verify-your-skype-for-business-server-hybrid-deployment-setup) section. If no, go to the [Custom domain status](#custom-domain-status) section.

### Verify your Skype for Business Server hybrid deployment setup

Make sure your Skype for Business Server deployment is set up to work with Skype for Business Online and Microsoft 365. For details, see Planning for Skype for Business Server 2015 Hybrid Deployments and Determine DNS Requirements.

Test your Lync Server hybrid deployment setup:

- Test your setup with the Lync Server Remote Connectivity Test.
- If necessary, correct any reported issues, and then try signing in again.

If the issue still exists, go to the [Access to Microsoft 365 on the web](#access-to-microsoft-365-on-the-web) section.

### Custom domain status

To set up your custom domain, sign in and go to **Admin** > **Setup**.

:::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/click-setup.png" alt-text="Screenshot that shows the setup tab in the Microsoft 365 admin center.":::

Have you already set up your custom domain? If yes, go to [Test your custom domain](#test-your-custom-domain). If no, go to the [Set up your custom domain](#set-up-your-custom-domain) section.

### Test your custom domain

Now make sure everything works as expected by running the domain troubleshooter in the Microsoft 365 admin center.

Run the domain troubleshooter:

1. Go to the Microsoft 365 admin center and click **Domains**.
1. Select your custom domain name, and then click **Troubleshooting**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/troubleshoot-option.png" alt-text="Screenshot that shows the Troubleshoot option selected in the domains tab.":::
1. If you discovered any network setup issues, resolve them, and then try signing in again.

If you discovered any network setup issues, resolve them, and then try signing in again.

If the issue still isn't solved, go to the [Access to Microsoft 365 on the web](#access-to-microsoft-365-on-the-web) section.

### Set up your custom domain

It's best to take the time and set up your custom domain now. That way we can check for additional issues that might cause sign-in errors in the future.

To set up your custom domain, sign in and go to **Admin** > **Setup**.

Don't worry, we'll save your place, and you can start where you left off.

Now make sure everything works as expected by running the domain troubleshooter in the Microsoft 365 admin center.

Run the domain troubleshooter:

1. Go to the Microsoft 365 admin center and click **Domains**.
1. Select your custom domain name, and then click **Troubleshooting**.

    :::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/troubleshoot-option.png" alt-text="Screenshot that shows the Troubleshoot option selected in the domains tab.":::
1. If you discovered any network setup issues, resolve them, and then try signing in again.

If you discovered any network setup issues, resolve them, and then try signing in again.

If the issue still isn't solved, go to the [Access to Microsoft 365 on the web](#access-to-microsoft-365-on-the-web) section.

## Everybody in my organization affected

### Check for a service interruption

In the Microsoft 365 admin center, click **Service health**. A green check mark next to Skype for Business Online indicates no service interruptions.

:::image type="content" source="./media/troubleshoot-sign-in-issues-for-admins/service-health.png" alt-text="Screenshot that shows the Lync Online service tab and service status on the service health page.":::

Is a service interruption preventing you from signing in? If yes, go to the [Service interruption](#service-interruption) section. If no, go to the [Custom domain](#custom-domain) section.

### Service interruption

What to do if there's a service interruption:

1. Save your place in this guide by clicking **Save current progress** at the bottom of the page.
1. In the O365 admin center, click the service interruption indicator :::image type="icon" source="./media/troubleshoot-sign-in-issues-for-admins/click-service-interruption-indicator.png" alt-text="Screenshot that shows the icon of the service interruption indicator.":::
1. Note the time of the next scheduled status update, and check back periodically until service is restored.
1. If you still cannot sign in to Skype for Business after the interruption has been resolved, return to this guide and click **No** to continue.

We're sorry for the inconvenience. Wait until the service interruption is resolved, and then try signing in again.

If the issue still exists, go to the [Custom domain](#custom-domain) section.

### Contact support

We're sorry, but we couldn't resolve your sign-in issue. Contact support for further assistance.
