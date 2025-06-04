---
title: Disabling ADAL or WAM to Fix Microsoft 365 Sign-in or Activation Issues Not Supported
description: This article explains why disabling ADAL or WAM authentication to fix Office sign-in issues isn't supported, and it offers possible resolutions.
manager: dcscontentpm
ms.date: 06/04/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CI 117023
  - CI 5935
  - CSSTroubleshoot
ms.reviewer: jploegert
---

# Disabling ADAL or WAM isn't supported to fix Microsoft 365 sign-in or activation issues

To diagnose and automatically fix common sign-in and activation issues, run the [Microsoft 365 Sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) and [Microsoft 365 activation troubleshooter](https://aka.ms/SaRA-OfficeActivation-sarahome).

Microsoft does't support disabling Azure Active Directory Authentication Library (ADAL) or Web Account Manager (WAM) authentication as a solution to sign-in or activation issues. This method can adversely affect your environment.

> [!WARNING]
> To support compliance with the Digital Markets Act (DMA) in the European Economic Area (EEA), the manner in which users sign in to apps on Windows is managed through enforcement within WAM. Disabling WAM authentication puts the Office client into a legacy state and a Microsoft unsupported configuration.

By default, Microsoft 365 apps (for example, Office client apps) use ADAL framework-based [Modern Authentication](/microsoft-365/enterprise/modern-auth-for-office-2013-and-2016). Starting in build 16.0.7967, Microsoft 365 apps use [Web Account Manager](/azure/active-directory/devices/concept-primary-refresh-token#key-terminology-and-components) for sign-in workflows on Windows builds that are later than build 15000 (Windows 10, version 1703, build 15063.138).

ADAL enables sign-in features such as Multi-Factor Authentication (MFA), smart card  authentication, and certificate-based authentication for Office client apps across different platforms. Some security-related features on Windows devices are available exclusively through WAM. Additionally, all future innovations are implemented through WAM.

## Recommendations to resolve common sign-in issues

Authentication issues that occur during sign-in or activation typically manifest themselves as one of the following symptoms:

- You can't sign in, and you receive repeated password prompts ("Credentials Needed" or "Needs Password").
- The sign-in window doesn't appear, is blank, prematurely disappears, or stops responding.
- Specific errors are displayed in Microsoft 365 apps or the sign-in user interface.

If you experience sign-in issues, consider the following recommendations:

- [Manually sign-out](https://support.microsoft.com/office/sign-out-of-office-5a20dc11-47e9-4b6f-945d-478cb6d92071) of all accounts in the Office app. Then, restart the app and try again to sign in.
- [Reset the activation state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
- If you experience device issues, for example, the device is deleted or disabled, [follow these recommendations](./connection-issue-when-sign-in-office-2016.md#symptom-2).
- If the investigation suggests that an authentication process is experiencing network or connectivity issues, then [follow these steps](./connection-issue-when-sign-in-office-2016.md#symptom-1). Additionally, you can [reset Internet Explorer settings](https://support.microsoft.com/windows/change-or-reset-internet-explorer-settings-2d4bac50-5762-91c5-a057-a922533f77d5), and then try again to sign in.

   > [!NOTE]  
   > After you reset Internet Explorer settings, you lose any custom settings.

- In some cases, Microsoft Entra ID, or MSA WAM plugins might be missing on the device that blocks users from signing in to Office. To restore the plugins and avoid having to remove them in the future, follow the steps in [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
- For information about how to troubleshoot other common sign-in issues, see [Connection issues when signing in after updating to Office 2016 build 16.0.7967](./connection-issue-when-sign-in-office-2016.md).

For more information about sign-in related symptoms and solutions, see the following articles:

- [Microsoft Entra device management FAQ](/azure/active-directory/devices/faq)
- [Troubleshooting devices using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd)
- [How to troubleshoot non-browser apps that can't sign in-to Microsoft 365, Azure, or Intune](https://support.office.com/article/how-to-troubleshoot-non-browser-apps-that-can-t-sign-in-to-office-365-azure-or-intune-3ba1b268-66f6-462c-b0e5-070f5c2603c1)
- ["Access Denied", or user is repeatedly prompted for credentials when connecting to Microsoft 365](/microsoft-365/troubleshoot/security/access-denied-when-connect-to-office-365)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
