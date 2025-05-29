---
title: Disabling ADAL or WAM to fix Microsoft 365 sign-in or activation issues not recommended
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 05/28/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365
ms.custom: 
  - CI 117023
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
description: Explains why disabling ADAL or WAM authentication to fix Microsoft 365 sign-in issues isn't recommended and offers possible resolutions.
---

# Disabling ADAL or WAM isn't recommended for fixing Microsoft 365 sign-in or activation issues

## Summary

> [!TIP]
> To diagnose and automatically fix common Microsoft 365 sign-in issues, run the [Microsoft 365 Sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome).

Disabling ADAL or WAM authentication as a solution to fix sign-in or activation issues can have adverse effects in your environment and **isn't recommended**.

## More information

Microsoft 365 apps use Azure Active Directory Authentication Library (ADAL) framework-based [Modern Authentication](/microsoft-365/enterprise/modern-auth-for-office-2013-and-2016) by default. Starting with build 16.0.7967, Microsoft 365 apps use [Web Account Manager](/azure/active-directory/devices/concept-primary-refresh-token#key-terminology-and-components) (WAM) for sign-in workflows on Windows builds that are later than 15000 (Windows 10, version 1703, build 15063.138).

ADAL enables sign-in features such as Multi-Factor Authentication (MFA), smart card, and certificate-based authentication for Microsoft 365 client apps across different platforms. Furthermore, on Windows devices, some of the security-related features are available exclusively via WAM and are otherwise not possible. Additionally, all future innovations will be implemented on WAM.

### Recommendations on resolving common sign-in issues

Authentication issues during sign-in or activation typically manifest as one of the following symptoms:

- Unable to sign in: Repeated password prompts, "Credentials Needed", or "Needs Password" statuses.
- Sign-in window doesn't show up, is blank, prematurely disappears, or gets stops working.
- Specific errors are displayed in Microsoft 365 apps or the sign-in user interface.

If you experience sign-in issues, consider the following recommendations:

1. [Manually sign-out](https://support.office.com/article/sign-out-of-office-5a20dc11-47e9-4b6f-945d-478cb6d92071) of all accounts in the Microsoft 365 app, then restart the app and sign-in again.
2. [Reset activation state for Microsoft 365 Apps for enterprise](/microsoft-365/troubleshoot/activation/reset-office-365-proplus-activation-state).
3. If you experience device issues, for example, the device is deleted or disabled, [follow these recommendations](./connection-issue-when-sign-in-office-2016.md#symptom-2).
4. If the investigation suggests that an authentication process is experiencing network or connectivity issues, then [these steps](./connection-issue-when-sign-in-office-2016.md#symptom-1) are helpful. Additionally, you can reset Internet Explorer Options, and then try signing into Microsoft 365 again (go to **Tools** > **Internet Options** > **Advanced** > **Reset Internet Explorer Settings**). After resetting Internet Explorer Settings, you'll lose any custom settings.
5. In some cases, Microsoft Entra ID, or MSA WAM plugins may be missing on the device that blocks user from signing into Microsoft 365. Follow the steps in [Fix authentication issues in Microsoft 365 applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails) to restore the plugins and avoid removing them in the future.
6. See [Connection issues in sign-in after update to Office 2016 build 16.0.7967](./connection-issue-when-sign-in-office-2016.md) on Windows 10 for information about troubleshooting other commonly occurring sign-in issues.

For more information about sign-in related symptoms and solutions, see the following articles:

- [Microsoft Entra device management FAQ](/azure/active-directory/devices/faq)
- [Troubleshooting devices using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd)
- [How to troubleshoot non-browser apps that can't sign in-to Microsoft 365, Azure, or Intune](https://support.office.com/article/how-to-troubleshoot-non-browser-apps-that-can-t-sign-in-to-office-365-azure-or-intune-3ba1b268-66f6-462c-b0e5-070f5c2603c1)
- ["Access Denied", or user is repeatedly prompted for credentials when connecting to Microsoft 365](/microsoft-365/troubleshoot/security/access-denied-when-connect-to-office-365)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
