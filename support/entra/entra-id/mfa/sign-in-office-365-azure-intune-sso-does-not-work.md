---
title: Single sign-on doesn't work from some devices in Office 365, Azure, or Intune
description: Follow these troubleshooting steps to fix single sign-on issues when users can't sign in to Office 365, Azure, or Intune from some devices.
ms.date: 04/21/2026
ms.author: jarrettr
ms.service: entra-id
ms.custom: sap:AD domain-joined Seamless SSO with PTA or PHS
---
# Single sign-on doesn't work from some devices in Office 365, Azure, or Intune

## Summary

This article helps you resolve a problem in which signing in to Office 365, Azure, or Microsoft Intune by using single sign-on (SSO) doesn't work from some devices. This problem typically occurs in environments where Azure Seamless Single Sign-On is configured to use either Pass-through Authentication (PTA) or Password Hash Synchronization (PHS) for Active Directory domain-joined devices.

## Symptoms

When you try to access a Microsoft cloud service like Office 365, Azure, or Intune through a web-based client or a rich client application by using a federated account, authentication fails from a specific client computer.

When you use a web browser to access the cloud service portal from the same computer by using a federated account, you experience one of the following symptoms:

- You connect to the portal endpoint and receive one of the following error messages:
    - **Internet Explorer cannot display the webpage.**
    - **403 Page Not Found**

- You connect to the Active Directory Federation Services (AD FS) endpoint and receive one of the following error messages:
    - **Internet Explorer cannot display the webpage.**
    - **403 Page Not Found**

- You receive a certificate warning when you connect to the AD FS endpoint.

- You connect to the AD FS endpoint while you're signed in to the corporate domain and receive a single credential prompt. This prompt doesn't use forms-based authentication.

- You connect to the AD FS endpoint by using a third-party web browser and receive looping authentication prompts. These prompts don't use forms-based authentication.

- You connect to the `login.microsoftonline.com` endpoint and receive the following error message:
    - **Access Denied**

## Cause

This problem usually occurs on a client computer or on a group of client devices. This problem might occur for all users and client computers if SSO isn't fully functional. SSO might not be fully functional if the client settings weren't correctly set up. The following client device situations can cause this issue:

- Network connectivity is limited.

- The client device is receiving incorrect name resolution for the AD FS service from the internal split-brain DNS implementation.

- If an internet proxy server is configured on the computer, the AD FS name isn't added to the proxy bypass list.

- The AD FS name isn't added to the local intranet security zone in the **Internet Options** settings.

- The client computer isn't authenticated to Active Directory Domain Services (AD DS).

- The third-party web browser doesn't support **Extended Protection for Authentication** to the AD FS service.

- The federation metadata endpoint is hardcoded in the registry because of an earlier Office 365 Beta installation of the SSO Management tool.

- The AD FS service endpoint that's required for a specific client application is disabled.

Before you continue, make sure that the following conditions are true:

- Access problems aren't limited to rich client applications on the client computer. If only rich client authentication (as opposed to browser-based authentication) isn't working, this condition likely indicates a rich client authentication issue. For example, it might be an issue that's related to the prerequisites or configuration of the rich-client application. For more information, see [How to troubleshoot non-browser apps that can't sign in to Office 365, Azure, or Intune](https://support.microsoft.com/office/how-to-troubleshoot-non-browser-apps-that-can-t-sign-in-to-microsoft-365-azure-or-intune-3ba1b268-66f6-462c-b0e5-070f5c2603c1).

- SSO authentication doesn't fail for all SSO-enabled user accounts. If all SSO-enabled users experience the same symptoms, this condition likely indicates a federation issue. For more information, see [Troubleshoot single sign-on setup issues in Office 365, Intune, or Azure](https://support.microsoft.com/topic/troubleshoot-single-sign-on-setup-issues-in-office-365-intune-or-azure-bfe00060-32cc-53bc-926f-4d3bcaefa8d0).

- SSO authentication for the user account succeeds on other client computers. If the user account can't log on to any cloud services client, see the resolutions in this article that involve the client computer. There might also be some problem that affects the user account and not the client computer. For more information, see [Troubleshoot account issues for federated users in Microsoft 365, Azure, or Intune](/troubleshoot/microsoft-365/admin/authentication/account-issues-for-federated-users).

- The keyboard on the client computer is working correctly, and the user name and password are entered correctly.

## Solution

To troubleshoot this problem, use one or more of the following methods, depending on the cause of the problem.

### Resolution 1: Can't connect to cloud service portal or AD FS 

Try to browse to `http://www.msn.com`. If this doesn't work, troubleshoot network connectivity issues. To do this, follow these steps:

1. At a command prompt, use the ipconfig and ping tools to troubleshoot IP connectivity. For more information, see [How to troubleshoot basic TCP/IP problems](https://support.microsoft.com/help/169790).

1. At a command prompt, enter `nslookup www.msn.com` to determine whether DNS is resolving internet server names.

1. Make sure that **Internet Options** proxy settings reflect the appropriate proxy server if a proxy server is used in the local network.

1. If a Forefront Threat Management Gateway (TMG) firewall is installed on the boundary of the network, and the firewall requires client authentication, you might have to install a Forefront TMG Client program on the client device for internet access. Contact your cloud service administrator if you need help.

### Resolution 2: Can't connect to AD FS

To resolve this problem, follow these steps:

1. Eliminate IP connectivity issues by using [Resolution 1](#resolution-1-cant-connect-to-cloud-service-portal-or-to-ad-fs).

1. At the command prompt, enter `nslookup <AD FS 2.0 FQDN>`, and then press Enter to determine whether DNS is resolving the AD FS service name correctly.

> [!NOTE]
> In this command, `<AD FS FQDN>` represents the fully qualified domain name (FQDN) of the AD FS service name. It doesn't represent the Windows host name of the AD FS server.

If the client is attached to the corporate network, make sure that the IP address that's resolved is a private IP address. The IP address should match one of the following patterns:

- `10.x.x.x`

- `172.16.x.x`

- `192.168.x.x`

If the client is outside the corporate network, make sure that the IP address that's resolved is a public IP address. Make sure that it doesn't match one of the following patterns:

- `10.x.x.x`

- `172.16.x.x`

- `192.168.x.x`

If the IP address that's resolved is incorrect based on the previous steps, and other client computers don't experience the same behavior, do the following:

1. At the command prompt, enter `ipconfig /all`, and then check whether the Primary DNS Server entry is appropriate for the network to which the client is attached.

1. Open the `%windir%\system32\drivers\etc\hosts` file in Notepad, and then remove any entries for the AD FS FQDN. Save the file.

1. At the command prompt, enter `ipconfig /flushdns` to clear the DNS cache.

> [!NOTE]
> If client devices are attached to only the corporate network, go to the next step.

4. Add the AD FS FQDN to the proxy bypass list. For more information, see [Internet Explorer Uses Proxy Server for Local IP Address Even if the Bypass Proxy Server for Local Addresses Option Is Turned On](/previous-versions/troubleshoot/browsers/connectivity-navigation/internet-explorer-uses-proxy-server-local-ip-address).

### Resolution 3: Certificate warning when you connect to the AD FS endpoint

To resolve this problem, troubleshoot Secure Sockets Layer (SSL) certificate issues. For more information, see [You receive a certificate warning from AD FS when you try to sign in to Office 365, Azure, or Intune](/previous-versions/troubleshoot/microsoft-365/admin/certificate-warning-from-ad-fs).

### Resolution 4: You receive a single, unexpected credential prompt when you sign in from a client computer that's connected to the corporate network

To resolve this problem, follow these steps:

1. Make sure that the client computer is successfully signed in to the domain.

1. Select **Start** > **Run**, enter `%logonserver%\sysvol`, and then select **OK**. If a credential prompt appears, log off, and then log back on by using corporate credentials.

1. Add the AD FS FQDN to the local intranet zone.

1. On the **Security** tab, select **Local Intranet** > **Sites** > **Advanced**.

1. Examine the **Websites** listing for the fully qualified DNS name of the AD FS service endpoint (for example, **sts.contoso.com**).

   > [!NOTE]
   > A wildcard value (for example, "*.consoto.com") also works in this configuration.

1. Add the AD FS FQDN to the proxy bypass list. For more information, see [Internet Explorer Uses Proxy Server for Local IP Address Even if the Bypass Proxy Server for Local Addresses Option Is Turned On](/previous-versions/troubleshoot/browsers/connectivity-navigation/internet-explorer-uses-proxy-server-local-ip-address).

### Resolution 5: Third-party web browser doesn't support Extended Protection for Authentication, and you receive looping authentication prompts

To resolve this problem, do the following:

- Use Internet Explorer instead of a third-party web browser that doesn't support Extended Protection for Authentication.

If Internet Explorer isn't an option, see [A federated user is repeatedly prompted for credentials during sign-in to Office 365, Azure, or Intune](/troubleshoot/microsoft-365/admin/sign-in/federated-user-repeatedly-prompted-for-credentials).


### Resolution 6: "Access Denied" error message when you try to connect to login.microsoftonline.com

> [!IMPORTANT]
> This resolution contains steps that tell you how to modify the registry. Serious problems can occur if you modify the registry incorrectly. Be sure to back up the registry before you modify it. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, use Registry Editor to delete the following registry subkey:

`HKEY_LOCAL_MACHINE\Software\Microsoft\MOCHA\IdentityFederation`

AD FS then falls back to the correct endpoint, based on the SSO Relying Party Trust.

### Resolution 7: Reset disabled AD FS service endpoint setting to default configuration

For more information about how to do this reset, see [Sign in to Office 365, Azure, or Intune fails after you change the federation service endpoint](/troubleshoot/microsoft-365/admin/active-directory/sign-in-fails-if-federation-endpoint-changes).
