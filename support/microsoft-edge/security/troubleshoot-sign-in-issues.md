---
title: Troubleshoot Microsoft Edge sign-in problems
description: Resolve common Microsoft Edge sign-in problems, including repeated prompts, authentication errors, and sync failures for personal, work, or school accounts.
ms.date: 03/11/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Security and Privacy\Authentication and Sign In'
---

# Troubleshoot common sign-in problems

## Summary

This article helps you troubleshoot common sign-in problems that occur in Microsoft Edge. You might not be able to sign in to your Microsoft account (personal, work, or school). You also might experience repeated sign-in prompts, encounter authentication errors, or find that your profile doesn't sync after you sign in. Cached credentials, expired passwords, MFA failures, Group Policy restrictions, network or firewall configurations, conflicting browser profiles, outdated browser versions, or Windows account issues can cause these problems. This article provides a step-by-step troubleshooting checklist that covers each of these common causes.

## Symptoms

You experience one or more of the following symptoms:

- You can't sign in to Microsoft Edge by using your Microsoft account (personal, work, or school).
- Microsoft Edge repeatedly prompts you to sign in, even after you enter your credentials.
- You're signed out of Microsoft Edge unexpectedly after you restart the browser.
- Your profile appears as signed in, but favorites, passwords, and other data don't sync across devices.
- The sign-in button is dimmed or unavailable.
- You see one of the following error messages when you try to sign in:

  > Something went wrong

  > We can't sign you in

  > Sign-in failed

## Solution

Work through the following checks in the given order. After each step, try to sign in again before you continue to the next step.

### Clear cached credentials and cookies

Stale or corrupted cached credentials, cookies, or authentication tokens can prevent successful sign-in or cause repeated sign-in prompts. Follow these steps:

1. Open Microsoft Edge, and go to `edge://settings/privacy`.
1. Under **Clear browsing data**, select **Choose what to clear**.
1. Select the following items:
   - **Cookies and other site data**
   - **Cached images and files**
1. Set the time range to **All time**.
1. Select **Clear now**.
1. Restart Microsoft Edge.
1. Go to `edge://settings/profiles`, and try again to sign in.

> [!NOTE]
> If you clear cookies, you're signed out of all websites.

### Check your account credentials and MFA

The sign-in failure might be caused by an expired password, a locked account, or a [multi-factor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) problem. Follow these steps:

1. Try to sign in to your Microsoft account in a web browser:
   - For personal accounts: Go to [https://account.microsoft.com](https://account.microsoft.com).
   - For work or school accounts: Go to [https://myaccount.microsoft.com](https://myaccount.microsoft.com).
1. If you can sign in on the web but not in Microsoft Edge, go to the next step.
1. If you can't sign in on the web either, the problem occurs in your account, not Microsoft Edge. Follow these steps:
   - For personal accounts: Reset your password at [https://account.live.com/password/reset](https://account.live.com/password/reset).
   - For work or school accounts: Ask your IT administrator to reset your password or unlock your account.
   - Make sure that MFA is set up correctly. If you changed your phone number or authentication device, update it at [https://mysignins.microsoft.com](https://mysignins.microsoft.com).
   - Check with your IT administrator if the account is locked or disabled.

### Check Group Policy sign-in settings

Your organization's IT administrator might have set up policies that restrict or disable browser sign-in.

1. Open Microsoft Edge, and go to `edge://policy`.
1. Search for [BrowserSignin](/deployedge/microsoft-edge-policies#browsersignin), and check its value:
   - **0**: Browser sign-in is disabled.
   - **1**: Browser sign-in is enabled (default).
   - **2**: Users are forced to sign in to use the browser.
1. If **BrowserSignin** is set to **0**, contact your organization's IT administrator to update this policy.

After any policy changes, restart Microsoft Edge for the changes to take effect.

> [!TIP]
> You can export all applied policies from `edge://policy` to share with your IT administrator for review.

### Check network connectivity to authentication endpoints

Network problems, proxy configurations, or firewall rules might prevent Microsoft Edge from reaching Microsoft authentication endpoints. Follow these steps:

1. Make sure that you can access the following URLs from your network:
   - `https://login.microsoftonline.com`
   - `https://login.live.com`
   - `https://account.live.com`
   - `https://graph.microsoft.com`
1. If your organization uses a proxy server, make sure that the proxy is set up correctly:
   - Go to `edge://settings/system`, and check the proxy settings.
   - Make sure that the proxy doesn't block the authentication endpoints that are listed in step 1.
1. If your organization uses a firewall, contact your network IT administrator to verify that the authentication endpoints are allowed.
1. Try to sign in from a different network (for example, a mobile hotspot) to check whether the problem is network-specific.

> [!NOTE]
> For a complete list of Microsoft 365 endpoints that have to be accessible, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

### Remove conflicting profiles or stored credentials

Multiple Microsoft accounts or conflicting profile configurations can cause sign-in problems. This problem commonly occurs when you use both a personal Microsoft account and a work or school account.

1. Open Microsoft Edge, and go to `edge://settings/profiles`.
1. Review the listed profiles. If you see multiple profiles that have conflicting accounts, try the following steps:
   - Select the profile that has the sign-in problem.
   - Select **Sign out**.
   - After you sign out, select **Sign in**, and enter your credentials.
1. If the problem continues, remove the problematic profile:
   - Go to `edge://settings/profiles`.
   - Select the profile to remove, and select **Remove**.
   - Restart Microsoft Edge, and create a new profile by using your account to sign in.
1. On Windows, you can also clear stored credentials:
   - Open **Credential Manager** from the Windows Control Panel.
   - Under **Windows Credentials** and **Generic Credentials**, look for entries that are related to `MicrosoftAccount` or `login.microsoftonline.com`.
   - Remove the outdated or conflicting entries.
   - Restart Microsoft Edge, and try again to sign in.

> [!CAUTION]
> If you remove a profile, you also delete the local browsing data that's associated with that profile, including favorites, history, and passwords that aren't synced. Make sure that your data is synced before you remove a profile.

### Update Microsoft Edge to the latest version

An outdated version of Microsoft Edge might have known sign-in bugs or lack support for the latest authentication protocols.

1. Open Microsoft Edge, and go to `edge://settings/help`. Microsoft Edge automatically checks for updates and installs the latest version.
1. After the update finishes, restart Microsoft Edge.

### Check Windows account and OS-level integration

On Windows, Microsoft Edge relies on the operating system's account infrastructure, including Web Account Manager (WAM), for authentication. Problems in your Windows account, token broker service, or OS-level settings can affect Edge sign-in. To troubleshoot, follow these steps:

1. Make sure that your Windows account is connected:
   - Go to **Settings** > **Accounts** > **Your info**, and vefify that your account is connected.
   - For work or school accounts, go to **Settings** > **Accounts** > **Access work or school**, and make sure that your organization account is connected.
1. Try re-registering the device by using your work or school account:
   - Go to **Settings** > **Accounts** > **Access work or school**.
   - Select your work or school account, and then select **Disconnect**.
   - Reconnect by selecting **Connect** and signing in again.
1. Reset the Token Broker service:
   - Open a Command Prompt window as an administrator.
   - Run the following commands:

     ```cmd
     net stop TokenBroker
     net start TokenBroker
     ```

   - Restart Microsoft Edge, and try again to sign in.
1. If the issue persists, run the Windows Account troubleshooter:
   - Go to **Settings** > **System** > **Troubleshoot** > **Other troubleshooters**.
   - Run the **Microsoft Account** troubleshooter, if it's available.

## Data collection

If you have to contact [Microsoft Support](https://support.microsoft.com/contactus) for more help, collect the following diagnostic information:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Sidebar settings**: Go to `edge://settings/sidebar`, and take a screenshot of the current settings.
- **Account type**: Note whether you're using a personal, work, or school account.
- **Operating system version**: In Windows, go to **Settings** > **System** > **About**, and note the OS version.
- **Edge diagnostic data**: Go to `edge://identity-internals/`, and capture the identity status information.

## Related content

- [Microsoft Edge sign-in and identity](/deployedge/microsoft-edge-security-identity)
- [How to troubleshoot Microsoft Entra sign-in errors](/entra/identity/monitoring-health/howto-troubleshoot-sign-in-errors)
- [Diagnose and fix Microsoft Edge sync issues](/deployedge/microsoft-edge-troubleshoot-enterprise-sync)
