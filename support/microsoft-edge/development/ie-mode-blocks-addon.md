---
title: Fix IE Mode Add-on Installation Blocked by Unverified Publisher
description: Resolve add-on installation failures in IE mode on Microsoft Edge caused by unverified publishers. Follow our guide to fix the issue quickly.
ms.date: 03/11/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: sap:Web Platform and Development\Internet Explorer mode
---

# IE mode blocks add-on installation because of unverified publisher

## Summary

This article helps you troubleshoot the issue where a page opened in [Internet Explorer (IE) mode](/deployedge/edge-ie-mode) in Microsoft Edge triggers an add-on installation prompt, but Windows blocks the installation with the message: "Windows has blocked this software because it can't verify the publisher." Work through the checklist in this article to identify and fix the issue.

## Symptoms

When you open a webpage in IE mode in Microsoft Edge:

1. The page tries to install an ActiveX control or Internet Explorer add-on.
2. An **Internet Explorer add-on installer** dialog appears with this error message:

   > "Windows has blocked this software because it can't verify the publisher."

3. You can't install the add-on, and the page might not function correctly.

## Solution

Work through the following checks in order. After each section, try loading the page in IE mode again before proceeding to the next step.

### Check the add-on's digital signature

Windows and Internet Explorer require ActiveX controls and add-ons to have a valid digital signature from a trusted publisher. If the add-on is unsigned, has an expired certificate, or is signed with an untrusted certificate, Windows blocks the installation by default.

1. If you have the `.cab` or `.exe` file of the add-on, check its signature:
   1. Right-click the file and select **Properties**.
   1. Go to the **Digital Signatures** tab.
   1. If no signatures are listed, the file is unsigned. If a signature is listed but shows a warning, the certificate might be expired or untrusted.
1. Contact the add-on vendor or your internal development team and request a version of the add-on that's signed with a valid, trusted code-signing certificate.
1. If the add-on previously worked, the certificate might have expired. Ask the vendor to re-sign the add-on with a renewed certificate.

### Trust the publisher's certificate on the client machine

Even if the add-on has a valid digital signature, the client machine might not trust the certificate authority (CA) that issued the certificate. This situation is common with internally developed add-ons signed with a private or organizational CA.

1. Get the publisher's certificate file (`.cer` or `.crt`) from your IT admin or the add-on vendor.
1. Install the certificate into the **Trusted Publishers** certificate store:
   1. Open `certmgr.msc`.
   1. In the left pane, expand **Trusted Publishers** and select **Certificates**.
   1. Right-click **Certificates**, and then select **All Tasks** > **Import...**.
   1. Follow the wizard to import the publisher's certificate.
1. If the certificate is issued by an internal CA, also make sure that the root CA certificate is in the **Trusted Root Certification Authorities** store:
   1. In `certmgr.msc`, expand **Trusted Root Certification Authorities** > **Certificates**.
   1. Import the root CA certificate if it's not already present. Follow the same import steps as for **Trusted Publishers**.
1. Restart Microsoft Edge and try loading the page in IE mode again.

For enterprise-wide deployment, your IT admin can distribute certificates through Group Policy:

1. Open _Group Policy Editor_ (`gpedit.msc`).
1. Go to **Computer Configuration** > **Windows Settings** > **Security Settings** > **Public Key Policies** > **Trusted Publishers**.
1. Import the certificate.

### Adjust Internet Explorer security zone settings

You might need to adjust the security settings for the Internet zone or the specific zone where the website resides if they're blocking add-on installations. IE mode in Microsoft Edge uses Internet Explorer's security zone settings.

1. Open _Internet Properties_ (`inetcpl.cpl`).
1. Go to the **Security** tab.
1. Select the zone where the website resides (for example, **Local intranet**, **Trusted sites**, or **Internet**).
1. If the website is an internal site, add it to the **Trusted sites** zone:
   1. Select **Trusted sites** and then select **Sites**.
   1. Enter the website URL and select **Add**.
   1. Clear **Require server verification (https:) for all sites in this zone** if the site uses HTTP.
   1. Select **Close**.
1. With the appropriate zone selected, select **Custom level...** and check the following settings:
   - **Download signed ActiveX controls**: Set to **Enable** or **Prompt**.
   - **Download unsigned ActiveX controls**: Set to **Prompt** if you need unsigned controls.
   - **Initialize and script ActiveX controls not marked as safe for scripting**: Set to **Prompt** if required.
   - **Run ActiveX controls and plug-ins**: Set to **Enable**.
1. Select **OK** to apply the changes.
1. Restart Microsoft Edge and try loading the page in IE mode again.

> [!CAUTION]
> Lowering security settings, especially enabling unsigned ActiveX controls, increases the risk of malicious software installation. Only adjust these settings for trusted internal websites, and prefer adding the site to the **Trusted sites** zone rather than changing the **Internet** zone settings.

### Check Group Policy for ActiveX restrictions

Your organization's admin might have configured Group Policy to block ActiveX control installations.

1. Open _Group Policy Editor_ (`gpedit.msc`).
1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Internet Explorer** > **Security Features** > **Add-on Management**.
1. Review the active policies related to ActiveX control installation, including:
   - **Turn off blocking of outdated ActiveX controls for Internet Explorer**
   - **Approved Installation Sites for ActiveX Controls**
   - **Software Restriction Policies**
   - **AppLocker rules**
1. If the organization requires specific add-ons to be allowed, use the **Approved Installation Sites for ActiveX Controls** policy:
   1. Open the **Approved Installation Sites for ActiveX Controls** policy.
   1. Add the URL of the site that hosts the add-on.
1. Alternatively, configure the specific ActiveX control as explicitly approved:
   - Use the **Add-on List** policy to explicitly allow the add-on by its CLSID.
1. After you change policies, run `gpupdate /force` in a Command Prompt and restart Microsoft Edge.

> [!TIP]
> To find the CLSID of the ActiveX control, go to `edge://compat/enterprise` in Microsoft Edge or check with the add-on vendor.

### Check UAC and Windows Defender SmartScreen settings

Windows security features like [User Account Control (UAC)](/windows/security/application-security/application-control/user-account-control) or [Microsoft Defender SmartScreen](/windows/security/operating-system-security/virus-and-threat-protection/microsoft-defender-smartscreen) might block the add-on installation because the publisher isn't recognized.

1. If a SmartScreen warning appears:
   1. Select **More info** in the warning dialog.
   1. Select **Run anyway** (if available and you trust the add-on source).
1. If UAC blocks the installation, you might need admin privileges:
   - Contact your IT admin to approve the installation or run the installer with elevated permissions.
1. For enterprise environments, manage SmartScreen settings through Group Policy:
   1. Open _Group Policy Editor_ (`gpedit.msc`).
   1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Defender SmartScreen** > **Explorer**.
   1. Adjust the **Configure Windows Defender SmartScreen** policy as needed.

> [!CAUTION]
> Disabling SmartScreen or UAC reduces system security. Only adjust these settings when necessary and with proper authorization from your organization's IT security team.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **IE mode configuration**: Go to `edge://compat/enterprise`, and take a screenshot of the site list and mode settings.
- **Error message**: Take a screenshot of the exact error dialog shown during the add-on installation attempt.
- **Add-on details**: Note the name, version, and publisher of the add-on (if available).
- **Security zone settings**: Open `inetcpl.cpl`, go to the **Security** tab, and note which zone the site belongs to and the current security level.
- **Active policies**: Go to `edge://policy`, and export the policy list. Also run `gpresult /h gpresult.html` in a Command Prompt and save the output.
- **Operating system version**: In Windows, go to **Settings** > **System** > **About**, and note the OS version.

## Related content

- [Configure IE mode policies](/deployedge/edge-ie-mode-policies)
- [Internet Explorer security zones registry entries for advanced users](/previous-versions/troubleshoot/browsers/security-privacy/ie-security-zones-registry-entries)
- [Microsoft Edge browser policies](/deployedge/microsoft-edge-policies)
