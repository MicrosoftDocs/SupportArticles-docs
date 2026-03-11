---
title: Troubleshoot Microsoft Edge Sign-In Issues
description: Resolve common Microsoft Edge sign-in issues, including repeated prompts, authentication errors, and sync failures for personal, work, or school accounts.
ms.date: 03/11/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Security and Privacy\Authentication and Sign In'
---

# Troubleshoot common sign-in problems

## Summary

This article helps you troubleshoot common sign-in problems in Microsoft Edge. You might not be able to sign in to your Microsoft account (personal, work, or school), experience repeated sign-in prompts, encounter authentication errors, or find that your profile doesn't sync after signing in. Cached credentials, expired passwords, MFA failures, Group Policy restrictions, network or firewall configurations, conflicting browser profiles, outdated browser versions, or Windows account problems can cause these problems. This article walks through a step-by-step troubleshooting checklist that covers each of these common causes.

## Symptoms

You experience one or more of the following symptoms:

- You can't sign in to Microsoft Edge by using your Microsoft account (personal, work, or school).
- Microsoft Edge repeatedly prompts you to sign in, even after you enter your credentials.
- You're signed out of Microsoft Edge unexpectedly after restarting the browser.
- Your profile appears as signed in, but favorites, passwords, and other data don't sync across devices.
- The sign-in button is dimmed or unavailable.
- You see one of the following error messages when you try to sign in:

  > Something went wrong

  > We can't sign you in

  > Sign-in failed

## Solution

Work through the following checks in order. After each step, try signing in again before you continue to the next step.

### Clear cached credentials and cookies

Stale or corrupted cached credentials, cookies, or authentication tokens can prevent successful sign-in or cause repeated sign-in prompts.

1. Open Microsoft Edge and go to `edge://settings/privacy`.
1. Under **Clear browsing data**, select **Choose what to clear**.
1. Select the following items:
   - **Cookies and other site data**
   - **Cached images and files**
1. Set the time range to **All time**.
1. Select **Clear now**.
1. Restart Microsoft Edge.
1. Go to `edge://settings/profiles` and try signing in again.

> [!NOTE]
> Clearing cookies signs you out of all websites.

### Check your account credentials and MFA

The sign-in failure might be caused by an expired password, a locked account, or a [multi-factor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) problem.

1. Try signing in to your Microsoft account from a web browser:
   - For personal accounts, go to [https://account.microsoft.com](https://account.microsoft.com).
   - For work or school accounts, go to [https://myaccount.microsoft.com](https://myaccount.microsoft.com).
1. If you can sign in on the web but not in Microsoft Edge, continue to the next steps.
1. If you can't sign in on the web either, the problem is with your account, not Microsoft Edge. Try the following steps:
   - _Personal accounts_: Reset your password at [https://account.live.com/password/reset](https://account.live.com/password/reset).
   - _Work or school accounts_: Contact your IT admin to reset your password or unlock your account.
   - Make sure MFA is set up correctly. If you changed your phone number or authentication device, update it at [https://mysignins.microsoft.com](https://mysignins.microsoft.com).
   - Check with your IT admin if the account is locked or disabled.

### Check Group Policy sign-in settings

Your organization's admin might have set up policies that restrict or disable browser sign-in.

1. Open Microsoft Edge and go to `edge://policy`.
1. Search for [BrowserSignin](/deployedge/microsoft-edge-policies#browsersignin) and check its value:
   - **0**: Browser sign-in is disabled.
   - **1**: Browser sign-in is enabled (default).
   - **2**: Users are forced to sign in to use the browser.
1. If **BrowserSignin** is set to **0**, contact your organization's IT admin to update this policy.

After any policy changes, restart Microsoft Edge for the changes to take effect.

> [!TIP]
> You can export all applied policies from `edge://policy` to share with your IT admin for review.

### Check network connectivity to authentication endpoints

Network problems, proxy configurations, or firewall rules might prevent Microsoft Edge from reaching Microsoft authentication endpoints.

1. Make sure you can access the following URLs from your network:
   - `https://login.microsoftonline.com`
   - `https://login.live.com`
   - `https://account.live.com`
   - `https://graph.microsoft.com`
1. If your organization uses a proxy server, make sure the proxy is correctly set up:
   - Go to `edge://settings/system` and check the proxy settings.
   - Make sure the proxy doesn't block the authentication endpoints listed previously.
1. If your organization uses a firewall, contact your network admin to confirm that the authentication endpoints are allowed.
1. Try signing in from a different network (for example, a mobile hotspot) to check whether the problem is network-specific.

> [!NOTE]
> For a complete list of Microsoft 365 endpoints that need to be accessible, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

### Remove conflicting profiles or stored credentials

Multiple Microsoft accounts or conflicting profile configurations can cause sign-in problems. This issue commonly occurs when you use both a personal Microsoft account and a work or school account.

1. Open Microsoft Edge and go to `edge://settings/profiles`.
1. Review the listed profiles. If you see multiple profiles with conflicting accounts, try the following steps:
   - Select the profile that has the sign-in problem.
   - Select **Sign out**.
   - After signing out, select **Sign in** and enter your credentials.
1. If the problem continues, remove the problematic profile:
   - Go to `edge://settings/profiles`.
   - Select the profile to remove, and then select **Remove**.
   - Restart Microsoft Edge and create a new profile by signing in with your account.
1. On Windows, you can also clear stored credentials:
   - Open **Credential Manager** from the Windows Control Panel.
   - Under **Windows Credentials** and **Generic Credentials**, look for entries related to `MicrosoftAccount` or `login.microsoftonline.com`.
   - Remove the outdated or conflicting entries.
   - Restart Microsoft Edge and try signing in.

> [!CAUTION]
> Removing a profile deletes the local browsing data associated with that profile, including favorites, history, and passwords that haven't been synced. Make sure your data is synced before you remove a profile.

### Update Microsoft Edge to the latest version

An outdated version of Microsoft Edge might have known sign-in bugs or lack support for the latest authentication protocols.

1. Open Microsoft Edge and go to `edge://settings/help`.
1. Microsoft Edge automatically checks for updates and installs the latest version.
1. Restart Microsoft Edge after the update finishes.

### Check Windows account and OS-level integration

On Windows, Microsoft Edge relies on the operating system's account infrastructure, including Web Account Manager (WAM), for authentication. Issues with your Windows account, token broker service, or OS-level settings can affect Edge sign-in.

1. Make sure your Windows account is connected:
   - Go to **Settings** > **Accounts** > **Your info** and confirm that your account is connected.
   - For work or school accounts, go to **Settings** > **Accounts** > **Access work or school** and make sure your organization account is connected.
1. Try re-registering the device with your work or school account:
   - Go to **Settings** > **Accounts** > **Access work or school**.
   - Select your work or school account, and then select **Disconnect**.
   - Reconnect by selecting **Connect** and signing in again.
1. Reset the Token Broker service:
   - Open a Command Prompt as administrator.
   - Run the following commands:

     ```cmd
     net stop TokenBroker
     net start TokenBroker
     ```

   - Restart Microsoft Edge and try signing in.
1. If the issue persists, run the Windows Account troubleshooter:
   - Go to **Settings** > **System** > **Troubleshoot** > **Other troubleshooters**.
   - Run the **Microsoft Account** troubleshooter if available.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Sidebar settings**: Go to `edge://settings/sidebar`, and take a screenshot of the current settings.
- **Account type**: Note whether you're using a personal, work, or school account.
- **Operating system version**: In Windows, go to **Settings** > **System** > **About**, and note the OS version.
- **Edge diagnostic data**: Go to `edge://identity-internals/` and capture the identity status information.

## Related content

- [Microsoft Edge sign-in and identity](/deployedge/microsoft-edge-security-identity)
- [How to troubleshoot Microsoft Entra sign-in errors](/entra/identity/monitoring-health/howto-troubleshoot-sign-in-errors)
- [Diagnose and fix Microsoft Edge sync issues](/deployedge/microsoft-edge-troubleshoot-enterprise-sync)
