---
title: Troubleshoot enabling OTP
description: Provides troubleshooting information for issues related to enabling DirectAccess OTP authentication using either the Enable-DAOtpAuthentication PowerShell cmdlet or the Remote Access Management console.
ms.date: 10/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:remote-access-otp, csstroubleshoot
ms.technology: networking
ms:assetid: ca80b327-7362-4b62-9d7a-1c45ddd31de7
---
# Troubleshoot enabling OTP

This article contains troubleshooting information for issues related to enabling DirectAccess OTP authentication using either the `Enable-DAOtpAuthentication` PowerShell cmdlet or the Remote Access Management console.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2012

## Failed to enroll the OTP signing certificate

**Error received** (server event log)

> An OTP signing certificate cannot be enrolled using certificate template \<OTP\_signing\_template\_name\>

**Cause**

There are three possible causes for this error:

- The template doesn't exist.
- The permissions set on the template don't allow the DirectAccess server to enroll.
- There's no network connectivity to the issuing certification authority (CA).

**Solution**

1. Make sure that the OTP signing certificate template with the given name:

   1. Exists and has the proper permissions.
   2. Is set to be issued by at least one CA that can issue certificates to the DirectAccess server.

2. If the template doesn't exist, create it as described in [3.3 Plan the registration authority certificate](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134161(v=ws.11)#33-plan-the-registration-authority-certificate), or if another matching template exists reconfigure DirectAccess OTP with the new template name.

## Failed to enable DirectAccess OTP when WebDAV is installed

**Scenario**

While attempting to apply the DirectAccess OTP configuration in the Remote Access Management console or by using the `Enable-DAOtpAuthentication` PowerShell cmdlet, the operation fails.

**Error received** (server event log)

> DirectAccess OTP settings cannot be applied because the WebDAV IIS extension is running on the server. Remove WebDAV and apply the settings again.

**Cause**

The DirectAccess OTP service is incompatible with the WebDAV Publishing feature and can't be enabled while WebDAV is installed.

**Solution**

Uninstall the WebDAV role:

1. In the Server Manager console, in the left-pane, select **IIS**.
2. In the main pane, scroll to **ROLES AND FEATURES**.
3. Right-click **WebDAV Publishing**, and then select **Remove Role or Feature**.
4. Complete the Remove Roles and Features Wizard.
5. Apply the DirectAccess OTP configuration again.

## No templates available in the Remote Access Management console

**Scenario**

While configuring OTP or registration authority certificate templates using the Remote Access Management console, some, or all of the templates are missing from the selection windows.

**Cause**

There are two possible causes for this error:

- The template is not configured according to the DirectAccess OTP requirements and so it can't be selected.
- The selected CAs under **OTP CA Servers** are not configured to issue the required templates.

**Solution**

1. Make sure that the OTP logon template and the OTP signing certificate template are configured properly as described in [3.2 Plan the OTP certificate template](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134161(v=ws.11)?#32-plan-the-otp-certificate-template) and [3.3 Plan the registration authority certificate](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134161(v=ws.11)#33-plan-the-registration-authority-certificate).
2. Make sure that the configured CAs in the **OTP CA Servers** list are configured to issues the relevant templates:

    1. On the CA server, open the Certification Authority console.
    2. In the left pane, expand the chosen CA server.
    3. Select **Certificate Templates** and make sure the required templates are enabled. If not, right-click **Certificate Templates**, select **New** > **Certificate Template to issue**, and then select the templates you want to enable.

## Can't set renewal period of OTP template to 1 hour

**Scenario**

When configuring the DirectAccess OTP logon template using Windows 2003 CA, it is not possible to set the renewal period of the template to 1 hour.

**Cause**

The Certificate Templates MMC snap-in in Windows Server 2003 doesn't allow you to set the renewal period of a template to 1 hour.

**Solution**

Install Certificate Templates snap-in on a post-Windows Server 2003 server and use it to configure the OTP logon template, see [Install the Certificate Templates Snap-In](https://technet.microsoft.com/library/cc732445.aspx).
