---
title: Troubleshoot sign-in issues
description: Helps you resolve issues that you can't sign in to Skype for Business.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: skype-for-business
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Skype for Business
search.appverid: MET150
---
# Troubleshooting Skype for Business sign-in for users

_Original KB number:_ &nbsp; 10054

## Summary

> [!NOTE]
>
> - To use this guide, you must have a Skype for Business sign-in name and password from an organization that uses [Microsoft 365 Apps for business](https://www.microsoft.com/microsoft-365/business/microsoft-365-apps-for-business?activetab=pivot%3aoverviewtab).
> - If you're an Office 365 admin, see [Troubleshooting Skype for Business Online sign-in issues for admins](https://support.microsoft.com/help/10133).

We'll begin by asking you questions about your installation and the symptoms you're experiencing. Then we'll take you through a series of troubleshooting steps and configuration checks that are specific to your situation.

> [!IMPORTANT]
> Some troubleshooting steps are different depending on the type of installation you have. Please complete each troubleshooting step, even if it doesn't seem to apply to you.

The amount of time you spend will depend on the type of installation you have, and the causes of your sign-in issues.

## Test your sign-in credentials

The first step is to try to sign in with your credentials in another location: Microsoft 365 Web Scheduler.

In most cases, both your sign-in address and user name look like one of these examples:

- `someone@example.com`
- `someone@example.onmicrosoft.com`

Can you sign in to Microsoft 365 Web Scheduler at [https://sched.lync.com](https://sched.lync.com/)?

- If yes, see [Sign in with your corrected sign-in address](#sign-in-with-your-corrected-sign-in-address).
- If no, see [Can't sign in to Microsoft 365 Web Scheduler](#cant-sign-in-to-microsoft-365-web-scheduler).
- If you forgot your password, see [Contact your workplace technical support for a new password](#contact-your-workplace-technical-support-for-a-new-password).

### Sign in with your corrected sign-in address

If you're able to successfully sign in to Microsoft 365 Web Scheduler, try signing in again with the same type of credentials:

`someone@example.com` or `someone@example.onmicrosoft.com`

Were you able to sign in?

- If yes, congratulations, you've resolved your sign-in issue!
- If no and you need both a sign-in address and user ID, see [Enter your user ID](#enter-your-user-id).
- If no, and you got some other error, see [Contact your workplace technical support for a new password](#contact-your-workplace-technical-support-for-a-new-password).

### Contact your workplace technical support for a new password

If you've forgotten your password or it's no longer working, use the [Microsoft Online Password Reset](https://passwordreset.microsoftonline.com/) site to request a new password from your workplace technical support team- typically the people who set up your account for you.

> [!IMPORTANT]
> If the password reset site doesn't work for you, contact your workplace tech support team directly.

Once you have a new password, try signing in again.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Sign in on another device](#sign-in-on-another-device).

### Sign in on another device

Are you able to sign in on another computer, or on a tablet or smartphone?

- If yes, see [Type of device](#type-of-device).
- If no, see [Sign in on another network](#sign-in-on-another-network).
- If you don't have access to another device right now, [Type of device](#type-of-device).

### Sign in on another network

Can you sign in on a different network-for example, at home, or at a public wireless access point?

- If yes, see [Contact your workplace technical support](#contact-your-workplace-technical-support)
- If no, see [Type of device that you use to sign in](#type-of-device-that-you-use-to-sign-in).
- If you don't have access to a different network right now, see [Contact your workplace technical support](#contact-your-workplace-technical-support)

### Type of device

What type of devices are you using to sign in?

- For Windows computer, laptop, or tablet, see [Synchronize your system clock with the network (Windows computer or laptop)](#synchronize-your-system-clock-with-the-network-windows-computer-or-laptop).
- For Mac computer or laptop, see [Synchronize your system clock with the network (Mac computer or laptop)](#synchronize-your-system-clock-with-the-network-mac-computer-or-laptop).
- For Smartphone, see [Update Skype for Business on the smartphone or tablet](#update-skype-for-business-on-the-smartphone-or-tablet).
- For iPad or Android tablet, see [Update Skype for Business on the smartphone or tablet](#update-skype-for-business-on-the-smartphone-or-tablet).

### Type of device that you use to sign in

If you can't sign in on another network, the issue might be with the client you're using.

What type of devices are you using to sign in?

- For Windows computer, laptop, or tablet, see [- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).
- For Mac computer or laptop, see [Delete Skype for Business for Mac sign-in information](#delete-skype-for-business-for-mac-sign-in-information).
- For Smartphone, see [Configure Skype for Business Online connection settings manually (Skype for Business for mobile devices)](#configure-skype-for-business-online-connection-settings-manually-skype-for-business-for-mobile-devices).
- For iPad or Android tablet, see [Configure Skype for Business Online connection settings manually (Skype for Business for mobile devices)](#configure-skype-for-business-online-connection-settings-manually-skype-for-business-for-mobile-devices).

### Synchronize your system clock with the network (Windows computer or laptop)

Make sure your system clock shows the correct time, and then try signing in again.

#### Details

Update your computer's system time:

**Windows 8**

1. Go to a web site that shows Coordinated Universal Time (UTC).
2. Go to **Setting** > **PC Settings** > **Time and Language**.
3. Note your UTC offset, and compare your device's time to that shown on the website.

    :::image type="content" source="media/troubleshoot-sign-in-issues-for-users/device-date-time.png" alt-text="Time and Language setting" border="false":::

If you need to update your device's time:

1. Turn off **Set time automatically** and tap **Change**.
2. Update the time and tap **Change**.
3. Try signing in again.

 **Windows 7**

1. Go to a web site that shows Coordinated Universal Time (UTC).
2. Go to **Control Panel** > **Date and Time**, and note the UTC offset for your location.

    :::image type="content" source="media/troubleshoot-sign-in-issues-for-users/date-time.png" alt-text="Date and Time" border="false":::

3. If you need to, choose **Change date and time** and update your computer's clock.
4. Try signing in again.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).

### Desktop Setup

Make sure you have the most current version of the [Microsoft Online Services Sign-in Assistant](https://www.microsoft.com/download/details.aspx?id=28177).

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).

### Update Skype for Business

Make sure the user has the [most current version of Skype for Business](/SkypeForBusiness/software-updates).

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).

### Delete Skype for Business sign-in information

For more information, see [How to troubleshoot being unable to sign in to Skype for Business](../../SkypeServer/server-sign-in/unable-to-sign-in-to-sfb.md).

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Configure connection settings manually](#configure-skype-for-business-connection-settings-manually).

### Synchronize your system clock with the network (Mac computer or laptop)

Make sure your system clock shows the correct time, and then try signing in again.

#### Details

Follow these steps:

1. Go to a web site that shows [Coordinated Universal Time (UTC).
2. Go to **Apple** ![The Apple icon](./media/troubleshoot-sign-in-issues-for-users/the-apple-icon.png) > **System Preferences**.
3. In the **Date & Time** pane, select the **Date & Time tab**.
4. Note the UTC offset for your location.
5. If you need to, update your computer's clock, and then try signing in again.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Update Skype for Business](#update-skype-for-business).

### Update Skype for Business

Make sure your computer has the [most recent version](https://www.microsoft.com/download/details.aspx?id=36517) of Skype for Business.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).

### Delete Skype for Business for Mac sign-in information

Make sure that previously saved sign-in information isn't blocking your current sign-in attempt.

#### Details

First, delete the following:

- Users/Home Folder/Library/Caches/com.microsoft.Skype for Business
- Users/Home Folder/Documents/Microsoft User Data/Microsoft Skype for Business History

Then delete any corrupted or cached certificates:

1. Open the **Keychain Access** certificate management utility. To do this, in **Finder**, select **Applications**, select **Utilities**, and then select **Keychain Access**. Or, search for **Keychain Access** by using **Spotlight**.
2. In the left pane, select **login**, and then select **Certificates**.
3. In the right pane, find any certificate named Unknown or Communications Server, select it, and then delete it. Note that you may have to unlock your keychain by using your password.
4. Close **Keychain Access**.
5. Restart Skype for Business for Mac.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Configure connection settings manually](#configure-skype-for-business-connection-settings-manually).

### Update Skype for Business on the smartphone or tablet

Go to the app store for your device and check for updates to the currently installed version of Skype for Business.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Configure Skype for Business Online connection settings manually (Skype for Business for mobile devices)](#configure-skype-for-business-online-connection-settings-manually-skype-for-business-for-mobile-devices).

### Configure Skype for Business connection settings manually

Manually add Skype for Business server settings and try signing in again.

#### Details

Manually add Skype for Business server settings:

1. Go to **Skype for Business options** ![Skype for Business options](./media/troubleshoot-sign-in-issues-for-users/the-arrow-next-to-options-button.png) > **Personal**.
2. Under My account, select **Advanced**, and then select **Manual configuration**.

    :::image type="content" source="media/troubleshoot-sign-in-issues-for-users/advanced-connection-settings.png" alt-text="the Advanced Connection Settings page" border="false":::

3. Enter `sipdir.online.lync.com:443` in both boxes, and then select **OK** > **OK**.
4. Sign out, and then try signing back in.

Did this solve your problem?

- If yes, see [Issue temporarily resolved (Clients and devices)](#issue-temporarily-resolved-clients-and-devices).
- If no, see [Contact your workplace technical support](#contact-your-workplace-technical-support).

### Configure Skype for Business connection settings manually

Manually add Skype for Business server settings, and then try signing in again.

#### Details

Ask the user to follow these steps:

1. Select **Advanced**.
2. Under **Authentication**, clear the **Use Kerberos** check box.
3. Under **Connection Settings**, select **Manual configuration**.
4. In both the **Internal Server Name** box and the **External Server Name** box, type or paste `sipdir.online.lync.com:443`.
5. Select **OK**.

Did this solve your problem?

- If yes, see [Issue temporarily resolved (Clients and devices)](#issue-temporarily-resolved-clients-and-devices).
- If no, see [Contact your workplace technical support](#contact-your-workplace-technical-support).

### Issue temporarily resolved (Clients and devices)

We're glad to hear you're back in service.

To help your organization find out why Skype for Business can't automatically sign in, contact your workplace technical support-typically the person who sent you email about how to get set up with Office 365.

### Configure Skype for Business Online connection settings manually (Skype for Business for mobile devices)

Manually add Skype for Business Online server settings, and then try signing in again.

#### Details

Manually add Skype for Business server settings:

1. On the Skype for Business sign-in screen, tap **More Details** (Windows) or **Show Advanced Options** (iPhone, iPad, or Android).
2. Turn off **Auto-Detect Server**.
3. In both the **Internal Discovery Name** and **External Discovery Name** boxes, enter `https://webdir.online.lync.com/Autodiscover/autodiscoverservice.svc/Root`
4. Select **Sign In**.

Did this solve your problem?

- If yes, see [Issue temporarily resolved (Clients and devices)](#issue-temporarily-resolved-clients-and-devices).
- If no, see [Configure Skype for Business Server connection settings manually (Skype for Business for mobile devices)](#configure-skype-for-business-server-connection-settings-manually-skype-for-business-for-mobile-devices).

### Contact your workplace technical support

We're sorry, but we couldn't resolve your sign-in issue. For more troubleshooting, contact your workplace technical support-typically the person who sent you email about how to get set up with Office 365.

### Enter your user ID

If Skype for Business asks you for your user ID, in most cases it is the same as your sign-in address-for example, `bobk@contoso.com`.

If that doesn't work, try the same credentials you use when signing in to your organization's network-for example, `CONTOSO\bobk`.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Sign in on another device](#sign-in-on-another-device).

### Update Skype for Business Windows Store app

Make sure you have the most current version of Skype for Business Windows Store app:

1. On the Start screen, tap **Store**

    :::image type="content" source="media/troubleshoot-sign-in-issues-for-users/windows-store-app.png" alt-text="Windows Store App" border="false":::

2. Search for Skype for Business, and install the update if one is available.
3. Try signing in again.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Delete Skype for Business sign-in information](#delete-skype-for-business-sign-in-information).

### Clear the DNS cache

Make sure that previously save network information is not blocking your sign-in attempt, and then try signing in again.

#### Windows 8

##### Clear the DNS cache (summary)

- Run the Command prompt app as an administrator, and enter **ipconfig /flushdns**.

##### Clear the DNS cache (details)

1. Swipe in from the right or point to the upper right of the screen.
2. Choose **Search**, and then type *command*.
3. Select the **Command prompt** app, and then swipe up from the bottom or right click for options.
4. Choose **Run as administrator**, and then choose **Yes**.
5. Enter *ipconfig /flushdns*.

#### Windows 7, Windows Vista, Windows XP, Windows Server 2008, or Windows Server 2003

##### Clear the DNS cache

1. Select **Start**, and in the **Search programs and files box**, enter *cmd.exe*.
2. Right-click cmd.exe in the search list, and then select **Run as administrator**.
3. Enter *ipconfig /flushdns*.

Did this solve your problem?

- If yes, congratulations, you've resolved your sign-in issue!
- If no, see [Configure connection settings manually](#configure-skype-for-business-connection-settings-manually).

### Can't sign in to Microsoft 365 Web Scheduler

What kind of error did you get when you tried to sign in to [https://sched.lync.com](https://sched.lync.com/)?

- [The error message said "The account you used to sign in is not provisioned for Skype for Business services"](#sign-in-on-another-device)
- [I got some other error message](#contact-your-workplace-technical-support-for-a-new-password)

### Configure Skype for Business Server connection settings manually (Skype for Business for mobile devices)

If the Skype for Business Online manual configuration didn't work, your organization may be using Skype for Business Server.

- First try signing in with this Skype for Business Server setting: `https://webdir.example.com/Autodiscover/ autodiscoverservice.svc/Root` where `example.com` is your domain name.
- Then try signing in with this Skype for Business Server setting: `https://webext.example.com/Autodiscover/ autodiscoverservice.svc/Root` where `example.com` is your domain name.

#### Details

Manually add Skype for Business server settings:

1. On the Skype for Business sign-in screen, tap **More Details** (Windows) or **Show Advanced Options** (iPhone, iPad, or Android).
2. Turn off **Auto-Detect Server**.
3. In both the **Internal Discovery Name** and **External Discovery Name** boxes, enter the **webdir** server address on the left. For example, if your domain name is `contoso.com`, enter `https://webdir.contoso.com/Autodiscover/autodiscoverservice.svc/Root`.
4. Select **Sign In**.
5. If you are not able to sign in, enter the **webext** server address on the left in both boxes. For example: `https://webext.contoso.com/Autodiscover/autodiscoverservice.svc/Root`.
6. Select **Sign In**.

Did this solve your problem?

- If yes, see [Issue temporarily resolved (Clients and devices)](#issue-temporarily-resolved-clients-and-devices).
- If no, see [Contact your workplace technical support](#contact-your-workplace-technical-support).