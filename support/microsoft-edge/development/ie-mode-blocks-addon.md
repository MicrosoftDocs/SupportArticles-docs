---
title: Fix IE mode add-on installation blocked by unverified publisher
description: Resolve add-on installation failures in IE mode on Microsoft Edge caused by unverified publishers. Follow our guide to fix the issue quickly.
ms.date: 03/11/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: sap:Web Platform and Development\Internet Explorer mode
---

# IE mode blocks add-on installation because of unverified publisher

## Summary

This article helps you troubleshoot an issue in which a page that's opened in [Internet Explorer (IE) mode](/deployedge/edge-ie-mode) in Microsoft Edge triggers an add-on installation prompt, but Windows blocks the installation. When this issue occurs, you receive the message, "Windows has blocked this software because it can't verify the publisher." Work through the checklist in this article to identify and fix the issue.

## Symptoms

When you open a webpage in IE mode in Microsoft Edge, the following actions occur:

- The page tries to install an ActiveX control or Internet Explorer add-on.
- An **Internet Explorer add-on installer** dialog box displays the following error message:

   > "Windows has blocked this software because it can't verify the publisher."

In this scenario, you can't install the add-on, and the page might not function correctly.

## Solution

Work through the following checks in the given order. After each section, try again to load the page in IE mode before you proceed to the next section.

### Check the add-on's digital signature

Windows and Internet Explorer require ActiveX controls and add-ons to have a valid digital signature from a trusted publisher. By default, if the add-on is unsigned, has an expired certificate, or is signed by using an untrusted certificate, Windows blocks the installation.

1. If you have the `.cab` or `.exe` file of the add-on, check its signature:
   1. Right-click the file, and select **Properties**.
   1. Select the **Digital Signatures** tab. If no signatures are listed, the file is unsigned. If a signature is listed but shows a warning, the certificate might be expired or untrusted.
1. Contact the add-on vendor or your internal development team to request a version of the add-on that's signed by using a valid, trusted code-signing certificate.
1. If the add-on worked previously, the certificate might be expired. Ask the vendor to re-sign the add-on by using a renewed certificate.

### Trust the publisher's certificate on the client computer

Even if the add-on has a valid digital signature, the client computer might not trust the certificate authority (CA) that issued the certificate. This situation is common for internally developed add-ons that are signed by using a private or organizational CA. In this situation, follow these steps:

1. Get the publisher's certificate file (`.cer` or `.crt`) from your admin or the add-on vendor.
1. Install the certificate in the **Trusted Publishers** certificate store:
   1. Open `certmgr.msc`.
   1. In the left pane, expand **Trusted Publishers**, and then select **Certificates**.
   1. Right-click **Certificates**, and then select **All Tasks** > **Import...**.
   1. Follow the wizard to import the publisher's certificate.
1. If the certificate is issued by an internal CA, also make sure that the root CA certificate is in the **Trusted Root Certification Authorities** store:
   1. In `certmgr.msc`, expand **Trusted Root Certification Authorities** > **Certificates**.
   1. Import the root CA certificate if it's not already present. Follow the same import steps as for **Trusted Publishers**.
1. Restart Microsoft Edge, and try again to load the page in IE mode.

For enterprise-wide deployment, your admin can distribute certificates through Group Policy:

1. Open _Group Policy Editor_ (`gpedit.msc`).
1. Go to **Computer Configuration** > **Windows Settings** > **Security Settings** > **Public Key Policies** > **Trusted Publishers**.
1. Import the certificate.

### Adjust Internet Explorer security zone settings

You might have to adjust the security settings for the Internet zone or the specific zone where the website resides if the settings are blocking add-on installations. IE mode in Microsoft Edge uses Internet Explorer's security zone settings. Follow these steps:

1. Open _Internet Properties_ (`inetcpl.cpl`).
1. Select the **Security** tab.
1. Select the zone where the website resides (for example, **Local intranet**, **Trusted sites**, or **Internet**).
1. If the website is an internal site, add it to the **Trusted sites** zone:
   1. Select **Trusted sites**, and select **Sites**.
   1. Enter the website URL, and select **Add**.
   1. Clear the **Require server verification (https:) for all sites in this zone** checkbox if the site uses HTTP.
   1. Select **Close**.
1. Make sure that the appropriate zone is selected. Then, select **Custom level...**, and check the following settings:
   - **Download signed ActiveX controls**: Set to **Enable** or **Prompt**.
   - **Download unsigned ActiveX controls**: Set to **Prompt** if you need unsigned controls.
   - **Initialize and script ActiveX controls not marked as safe for scripting**: Set to **Prompt** if it's required.
   - **Run ActiveX controls and plug-ins**: Set to **Enable**.
1. Select **OK** to apply the changes.
1. Restart Microsoft Edge, and try again to load the page in IE mode.

> [!CAUTION]
> If you lower security settings, especially by enabling unsigned ActiveX controls, you increase the risk of malicious software installation. Adjust these settings for only trusted internal websites. We recommend that you add the site to the **Trusted sites** zone instead of changing the **Internet** zone settings.

### Check Group Policy for ActiveX restrictions

Your organization's administrator might configure Group Policy to block ActiveX control installations.

1. Open _Group Policy Editor_ (`gpedit.msc`).
1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Internet Explorer** > **Security Features** > **Add-on Management**.
1. Review the active policies that are related to ActiveX control installation, including:
   - **Turn off blocking of outdated ActiveX controls for Internet Explorer**
   - **Approved Installation Sites for ActiveX Controls**
   - **Software Restriction Policies**
   - **AppLocker rules**
1. If the organization requires specific add-ons to be allowed, use the **Approved Installation Sites for ActiveX Controls** policy:
   1. Open the **Approved Installation Sites for ActiveX Controls** policy.
   1. Add the URL of the site that hosts the add-on.
1. Alternatively, configure the specific ActiveX control as explicitly approved:
   - Use the **Add-on List** policy to explicitly allow the add-on by its CLSID.
1. After you change policies, run `gpupdate /force` at a command prompt, and then restart Microsoft Edge.

> [!TIP]
> To find the CLSID of the ActiveX control, go to `edge://compat/enterprise` in Microsoft Edge, or ask the add-on vendor.

### Check UAC and Windows Defender SmartScreen settings

Windows security features such as [User Account Control (UAC)](/windows/security/application-security/application-control/user-account-control) and [Microsoft Defender SmartScreen](/windows/security/operating-system-security/virus-and-threat-protection/microsoft-defender-smartscreen) might block the add-on installation because the publisher isn't recognized. To check these settings, follow these steps:

1. If a SmartScreen warning appears:
   1. In the warning dialog box, select **More info**.
   1. Select **Run anyway** (if available and you trust the add-on source).
1. If UAC blocks the installation, you might need administrator privileges:
   - Contact your admin to approve the installation or run the installer by using elevated permissions.
1. For enterprise environments, manage SmartScreen settings through Group Policy:
   1. Open _Group Policy Editor_ (`gpedit.msc`).
   1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Defender SmartScreen** > **Explorer**.
   1. Adjust the **Configure Windows Defender SmartScreen** policy as needed.

> [!CAUTION]
> If you disable SmartScreen or UAC, you reduce system security. Adjust these settings only if necessary and by having proper authorization from your organization's IT security team.

## Data collection

If you have to contact [Microsoft Support](https://support.microsoft.com/contactus) for more help, collect the following diagnostic information to include with your support request:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **IE mode configuration**: Go to `edge://compat/enterprise`, and take a screenshot of the site list and mode settings.
- **Error message**: Take a screenshot of the exact error dialog box that's shown during the add-on installation attempt.
- **Add-on details**: Note the name, version, and publisher of the add-on (if available).
- **Security zone settings**: Open `inetcpl.cpl`, select the **Security** tab, and note which zone the site belongs to and the current security level.
- **Active policies**: Go to `edge://policy`, and export the policy list. Also, run `gpresult /h gpresult.html` at a command prompt, and save the output.
- **Operating system version**: In Windows, go to **Settings** > **System** > **About**, and note the OS version.

## Related content

- [Configure IE mode policies](/deployedge/edge-ie-mode-policies)
- [Internet Explorer security zones registry entries for advanced users](/previous-versions/troubleshoot/browsers/security-privacy/ie-security-zones-registry-entries)
- [Microsoft Edge browser policies](/deployedge/microsoft-edge-policies)
