---
title: SBC connectivity issues
description: Describes how to diagnose SIP options or TLS certificate issues with SBC. 
ms.date: 2/5/2021
author: meerak
ms.author: mikebis
manager: dcscontentpm
audience: Admin
ms.topic: article
ms.prod: microsoft-teams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 124780
- CSSTroubleshoot 
ms.reviewer: mikebis
---

# SBC connectivity issues

When using Microsoft Teams, you might experience Session Border Controller (SBC) connectivity issues, which could including the following situations:

- Session Initiation Protocol (SIP) options are not received  
- Problems with Transport Layer Security (TLS) connections
- The SBC doesn’t respond
- The SBC is marked as inactive in the Admin portal

Such issues are most likely caused by either or both of the following conditions:

- A TLS certificate issue
- An SBC is not configured correctly for Direct Routing

This article lists some common issues related to SIP options and TLS certificates, and provides resolutions that you can try.  

## Overview of the SIP options process

1. The SBC sends a TLS connection request with a TLS certificate to the SIP Proxy fully qualified domain name (FQDN) (for example, sip.pstnhub.microsoft.com).

2. The SIP Proxy checks the connection request.

   - If the request is not valid, the TLS connection is closed and the SIP Proxy does not receive SIP options from the SBC.
   - If the request is valid, then the TLS connection is established, and the SBC uses it to send SIP options to the SIP Proxy.

3. After it receives SIP options, the SIP Proxy checks the Record-Route to determine whether the SBC FQDN belongs to a known tenant. If the FQDN information is not found there, it checks the Contact header.

4. If the SBC FQDN is found and recognized, the SIP Proxy sends a “200 OK” message using the same TLS connection.

5. Also, the SIP Proxy sends SIP options to the SBC FQDN, which is listed in the Contact header of the SBC’s SIP options.

6. After receiving SIP options from the SIP Proxy, the SBC responds with a “200 OK” message. This step confirms that the SBC is healthy.

7. As the final step, the SBC is marked as Active in the Teams Admin portal.

> [!NOTE]
> In a [hosted model](https://docs.microsoft.com/microsoftteams/direct-routing-sbc-multiple-tenants), SIP options should be sent from only the hosted SBC. The status of SBCs in a derived trunk model are based on the main SBC.

### SIP options issues

After the TLS connection is successfully established, and SBC is able to send and receive messages both to and from the Teams SIP proxy, there might still be problems that affect the format or content of the SIP options messages.

<details>
<summary><b>Not receiving a “200 OK” response from SBC</b></summary>

If you’re not receiving a “200 OK” response from SBC, here are a few things you can try.

- This situation might occur if you’re using an older version of TLS. To enforce stricter security, [enable TLS 1.2](https://docs.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2).
- Make sure that either your SBC certificate is self-signed or a certificate was obtained from a trusted Certificate Authority (CA).
- If you’re using the minimum required TLS, and no problem is affecting your SBC certificate, your issue most likely occurs because the FQDN is misconfigured in your SIP profile, and it isn’t recognized as belonging to the tenant. To resolve this issue, narrow down which configuration is causing the issue. The most likely culprits are the following conditions:
  - The FQDN name that’s provided by SBC in the Record Route or Contact Header differs from what was configured in the Microsoft system.
  - The FQDN Contact Header contains an IP address instead of the expected FQDN value.
  - The domain isn’t yet [fully validated](https://docs.microsoft.com/microsoft-365/admin/setup/add-domain). If you add an FQDN that wasn’t previously validated, you must validate it now.
  - After you register an SBC domain name, you must activate it by [adding at least one E3- or E5-licensed user](https://docs.microsoft.com/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).

</details>

<details>

<summary><b>“200 OK” response received, but not SIP options</b></summary>

SBC received the “200 OK” response and the FQDN name that’s provided by SBC in the Record Route or Contact Header, but it didn't receive the SIP options you were expecting. If this error occurs, make sure that the domain name was entered correctly and that the FQDN DNS record resolves to the correct SBC IP address.

Another possible cause is that firewall rules aren’t allowing incoming traffic. Make sure that firewall rules are configured to allow incoming connections.

</details>

<details>
<summary><b>SBC status is intermittently inactive</b></summary>

During maintenance or outages, an IP address that the domain points to sometimes changes to a different datacenter while the SBC continues to send SIP options to the inactive or unresponsive datacenter. SBC must be both discoverable and configured to send SIP options to FQDNs. Otherwise, you might experience issues.

- Check the FQDN status of SBC. If the FQDNs are configured to send SIP options to the specific IP address that the FQDNs resolve to, update it to send SIP options to FQDNs (for example, sip.pstnhub.microsoft.com).
- Make sure that all devices on the path, such as SBCs and firewalls, are configured to allow communication both to and from all Microsoft-signaling FQDNs.
- To provide a failover when the connection from an SBC is made to a datacenter that's experiencing an issue, SBC must be configured to use all three SIP proxy FQDNs:

  - sip.pstnhub.microsoft.com
  - sip2.pstnhub.microsoft.com
  - sip3.pstnhub.microsoft.com

  > [!NOTE]
  > Devices that support DNS names can use sip-all.pstnhub.microsoft.com to resolve to all possible IP addresses.

For more information, see [SIP Signaling: FQDNS](https://docs.microsoft.com/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

</details>

<details>
<summary><b>SIP proxy doesn’t respond to SIP messages from SBC</b></summary>

Multilevel domains can’t be represented by a wildcard character. For example, the wildcard *.contoso.com would match sbc1.contoso.com, but not customer10.sbc1.contoso.com.

If you notice that the FQDN doesn’t match the contents of the Common Name (CN) certificate or Subject Alternate Name (SAN) certificate, request a certificate that matches the selected domains.  

For more information about certificates, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
</details>

<details>
<summary><b>After successful domain name activation, no valid users are displayed</b></summary>

After you successfully register an SBC domain name and add at least one E3- or E5-licensed user, the name can take up to 24-hours to activate.

For a list of the licenses that are required for Direct Routing, see the ”Licensing and other requirements” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#licensing-and-other-requirements).

For more information about this process, see the ”Connect the SBC to the tenant” section of [Connect your Session Border Controller (SBC) to Direct Routing](https://docs.microsoft.com/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
</details>

### TLS connection issues

If the TLS connection is closed right away and SIP Options are not sent, or 200 OK is not received from the SIP Proxy, then the problem might be with the TLS certificate. The certificate should be version 1.2 or higher.

After the TLS connection is successfully established and SBC is able to send and receive messages to and from the Teams SIP proxy, there might still be problems that affect the format or content of the SIP messages. The following section provides resolutions that you can try.

<details>

<summary><b>SBC certificate is not from a trusted CA</b></summary>

Make sure that your SBC certificate is either self-signed or obtained from a trusted Certificate Authority (CA). The certificate must contain at least one FQDN that belongs to a Microsoft 365 tenant.

For a list of supported CAs, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>SBC doesn’t trust Teams SIP proxy certificate</b></summary>

Download and install the Baltimore CyberTrust Root Certificate in the SBC Trusted Root Store of the Teams TLS context.

For a list of supported CAs, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>SBC certificate is invalid</b></summary>

You find that the SBC certificate is invalid, expired, or revoked.

Request or renew the certificate from a trusted Certificate Authority (CA). Install it on the SBC according to the vendor’s SBC configuration guide.

For a list of supported CAs, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>SBC or all required intermediary certificates are missing in SBC’s TLS “Hello” message</b></summary>

Check that a valid certificate and all intermediate Certificate Authority certificates are installed correctly, and that the TLS connection settings are correct on SBC.

Sometimes, everything might look correct. However, a closer examination of the packet capture might reveal that the TLS certificate of the Intermediate Certificate Authority isn’t provided to the Teams infrastructure.

</details>

<details>
<summary><b>SBC connection is interrupted</b></summary>

The connection is interrupted or does not finish, even though there are no issues caused by certificates or settings on the SBC.

In some cases, the connection may be closed by one of the intermediary devices (for example, the firewall or a router) on the path between the SBC and the Microsoft network. To resolve this issue, verify that there are no connection issues within your managed network.

</details>

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
