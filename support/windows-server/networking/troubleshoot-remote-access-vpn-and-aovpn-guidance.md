---
title: Guidance for troubleshooting Remote Access (VPN and AOVPN)
description: Introduces general guidance for troubleshooting scenarios related to Remote Access (VPN and AOVPN).
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:vpn, csstroubleshoot
---
# Remote Access (VPN and AOVPN) troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806376" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common VPN and AlwaysOn VPN issues.

The listed resources in this article can help you resolve issues that you experience when you use Remote Access.

## Recommended troubleshooting steps

- VPN deployment typically requires a minimum of manual configurations on a server or client computer. Your main considerations are that the correct ports are open on the firewall and are forwarded to the server, and that VPN is enabled. The VPN should work right out of the box. Also make sure that the VPN settings on the client have the appropriate protocols selected.
- The first step in troubleshooting and testing your VPN connection is to understand the core components of the **Always On VPN** (AOVPN) infrastructure.
- If the AOVPN setup doesn't connect clients to your internal network, the cause is likely an invalid VPN certificate, incorrect NPS policies, issues that affect the client deployment scripts, or issues that occur in Routing and Remote Access.

## Troubleshoot Remote Access VPN issues

- [Microsoft Edge ignores PAC setting](../../mem/intune/device-enrollment/edge-ignore-pac-android-vpn-profile.md) - Microsoft Edge in Android 13 ignores a Proxy Auto-Configuration (PAC) setting configured in a per-app VPN profile in Microsoft Intune.

- [Event ID: 20227 with error code 720](troubleshoot-error-720-when-establishing-a-vpn-connection.md) - VPN clients don't complete a VPN connection because the WAN Miniport (IP) adapter is not bound correctly.

- [L2TP VPN fails with error 787](l2tp-vpn-fails-with-error-787.md) - Occurs when an L2TP VPN connection to a Remote Access server fails. The Internet Protocol Security (IPSec) security association (SA) establishment for the Layer Two Tunneling Protocol (L2TP) connection fails because the server uses the wildcard certificate or a certificate from a different Certificate Authority as the computer certificate that's configured on the clients. Routing and Remote Access (RRAS) is choosing the first certificate it can find in the computer certificate store. L2TP behaves differently in this regard from Secure Socket Tunneling Protocol (SSTP) or IP-HTTPS or any other manually configured IPsec rule. For L2TP, you rely on the RRAS built-in mechanism for choosing a certificate. You can't change this condition.
  
- [LT2P/IPsec RAS VPN connections fail when using MS-CHAPv2](rras-vpn-connections-fail-ms-chapv2-authentication.md) - You experience a broken L2TP/IPsec VPN connections to a Windows Remote Access Service (RAS) Server when the MS-CHAPv2 authentication is used. This issue can occur if the **LmCompatibilityLevel** settings on the authenticating domain controller (DC) were modified from the defaults.

- [Can't connect to the Internet after connecting to a VPN server](cannot-connect-to-internet-vpn-server.md) - This issue prevents you from connecting to the internet after you log on to a server that's running Routing and Remote Access by using VPN. This issue might occur if you configure the VPN connection to use the default gateway on the remote network. That setting overrides the default gateway settings that you specify in the Transmission Control Protocol/Internet Protocol (TCP/IP) settings.

- [Can't establish a remote access VPN connection](install-configure-virtual-private-network-server.md#cant-establish-a-remote-access-vpn-connection) - Information to help you troubleshoot typical problems the prevent clients from connecting to the VPN server.

- [Can't send and receive data](install-configure-virtual-private-network-server.md#cant-send-and-receive-data) - Information about common causes and solutions for two-way Remote Access VPN connection failures (legacy OS).

## Troubleshoot AOVPN issues

- [Error code: 800](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-800) - The remote connection was not made because the attempted VPN tunnels failed. The VPN server might be unreachable. If this connection is trying to use an L2TP/IPsec tunnel, the security parameters required for IPsec negotiation might not be configured correctly.

- [Error code: 809](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-809) - The network connection between your computer and the VPN server could not be established because the remote server is not responding. This could occur because one of the network devices (such as a firewall, NAT, or router) between your computer and the remote server is not configured to allow VPN connections. Contact your administrator or your service provider to determine which device is causing the problem.

- [Error code: 812](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-812) - Can't connect to AOVPN. The connection was prevented because of a policy that's configured on your RAS or VPN server. Specifically, the authentication method that the server used to verify your user name and password don't match the authentication method that's configured in your connection profile. Notify the administrator of the RAS server about this error.

- [Error code: 13806](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-13806) - IKE didn't find a valid machine certificate. Contact your network security administrator about how to install a valid certificate in the appropriate certificate store.

- [Error code: 13801](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-13801) - IKE authentication credentials are unacceptable.

- [Error code: 0x80070040](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-0x80070040) - The server certificate does not have Server Authentication as one of its certificate usage entries.

- [Error code: 0x800B0109](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#error-code-0x800B0109) - The VPN client is joined to a Active Directory domain that publishes trusted root certificates, such as from an enterprise CA. On all domain members, the certificate is automatically installed in the Trusted Root Certification Authorities store. However, if the computer is not joined to the domain, or if you use an alternative certificate chain, you may experience this issue.

- [Always On VPN client connection issues](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#always-on-vpn-client-connection-issues) - A small misconfiguration can cause the client connection to fail. Finding the cause can be challenging. An AOVPN client goes through several steps before it establishes a connection.

- [Unable to delete the certificate from the VPN connectivity blade](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-troubleshooting#unable-to-delete-the-certificate-from-the-vpn-connectivity-blade) - Certificates on the VPN connectivity blade cannot be deleted. (Microsoft Entra Conditional Access connection issues.)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:

    - Client:  

        ```powershell
        TSS.ps1 -Scenario NET_VPN
        ```

    - Server:  

        ```powershell
        TSS.ps1 -Scenario NET_RAS
        ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Always On VPN Deployment for Windows Server 2016 and Windows 10](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy) - Provides instructions about how to deploy Remote Access as a single tenant VPN RAS gateway for point-to-site VPN connections that let your remote employees to connect to your organization network by using AOVPN connections. We recommend that you review the design and deployment guides for each of the technologies that are used in this deployment.

- [How to Create VPN profiles in Configuration Manager](/mem/configmgr/protect/deploy-use/create-vpn-profiles) - This topic explains how to create VPN profiles in Configuration Manager.

- [Always On VPN features and functionality](/windows-server/remote/remote-access/vpn/vpn-map-da) - This topic discusses the features and functionality of AOVPN.
