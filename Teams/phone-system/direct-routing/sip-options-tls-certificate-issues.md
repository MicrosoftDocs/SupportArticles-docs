---
title: SBC connectivity issues
description: Describes how to diagnose SIP options or TLS certificate issues with SBC.
ms.date: 10/30/2023
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI-124780
  - CSSTroubleshoot
  - scenario:Direct-Routing-1
ms.reviewer: mikebis
---

# SBC connectivity issues

[!INCLUDE [Teams Direct Routing note](../../../includes/teams-direct-routing-note.md)]

## Summary

When you set up Direct Routing, you might experience the following Session Border Controller (SBC) connectivity issues:

- Session Initiation Protocol (SIP) options are not received.
- Transport Layer Security (TLS) connection problems occur.
- The SBC doesn't respond.
- The SBC is marked as Inactive in the Microsoft Teams admin center.

These issues are most commonly caused by either or both of the following conditions:

- A TLS certificate experiences problems.
- An SBC is not configured correctly for Direct Routing.

This article lists some common issues that are related to SIP OPTIONS and TLS certificates, and provides resolutions that you can try.  

## Issues related to SIP OPTIONS

After the TLS connection is successfully established, and the SBC is able to send and receive messages to and from the Teams SIP proxy, there might still be problems that affect the format or content of SIP OPTIONS requests.
<br><br>
<details>
<summary><b>The SBC doesn't receive a SIP 200 OK response from the SIP proxy</b></summary>

This situation might occur if you're using an older version of TLS. To enforce stricter security, enable TLS 1.2.

Make sure that your SBC certificate is not self-signed and that you got it from a [trusted Certificate Authority (CA)](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc?preserve-view=true#resolution).

If you're using the minimum required version of TLS or higher, and your SBC certificate is valid, then the issue might occur because the FQDN is misconfigured in your SIP profile and not recognized as belonging to any tenant. Check for the following conditions, and fix any errors that you find:

- The FQDN provided by the SBC in the Record-Route or Contact header is different from what is configured in Teams.
- The Contact header contains an IP address instead of the FQDN.
- The domain isn't [fully validated](/microsoft-365/admin/setup/add-domain). If you added an FQDN that wasn't validated previously, you must validate it now.
- After you register a domain name for an SBC, you must activate it by [adding at least one E3- or E5-licensed user](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant?preserve-view=true#resolution).

</details>

<details>

<summary><b>The SBC receives a SIP 200 OK response but not a SIP OPTIONS request</b></summary>

The SBC receives the SIP 200 OK response from the SIP proxy but doesn't receive the SIP OPTIONS request that the SIP proxy sends. If this error occurs, make sure that the FQDN that's listed in the Record-Route or Contact header is correct and resolves to the correct IP address.

Another possible cause for this issue might be firewall rules that are preventing incoming traffic. Make sure that firewall rules are configured to allow incoming connections from all [SIP proxy signalling IP addresses](/microsoftteams/direct-routing-plan#sip-signaling-fqdns?preserve-view=true#resolution).

</details>

<details>
<summary><b>Calls work successfully, but the SBC is shown as Inactive or displays SIP OPTIONS warnings in the Microsoft Teams admin center</b></summary>

The health status shown in the Microsoft Teams admin center is based solely on the SIP OPTIONS exchange between the SBC and Microsoft SIP proxies and doesn't reflect actual call traffic. Because of this behavior, inbound and outbound calls might continue to work even when the SBC is shown as Inactive or displays SIP OPTIONS warnings.

Check the following conditions:

- Verify that the SBC is sending SIP OPTIONS requests to Microsoft.
- Verify that the Contact and Record-Route (if present) headers contain the correct SBC FQDN.
- Verify that the SBC FQDN configured in the Microsoft Teams admin center and/or by using Teams PowerShell matches the FQDN presented by the SBC in the Contact or Record-Route header.
- Verify that the SBC FQDN resolves to a public IP address when using public DNS servers.
- Verify that the Microsoft SIP OPTIONS requests reach the SBC and that the SBC returns SIP 200 OK responses.
- Verify that firewalls, load balancers, or SBC rate-limiting policies aren't affecting the SIP OPTIONS traffic.

</details>

<details>
<summary><b>The SBC status displays intermittently as Inactive</b></summary>

This issue might occur in the following situations:
  
- The SBC is configured to send SIP OPTIONS requests not to FQDNs but to the specific IP addresses that they resolve to. During maintenance or outages, these IP addresses might change to a different datacenter. Therefore, the SBC will be sending SIP OPTIONS requests to an inactive or unresponsive datacenter. Do the following:

   - Make sure that the SBC is discoverable and configured to send SIP OPTIONS requests only to FQDNs.
   - Make sure that all devices in the route, such as SBCs and firewalls, are configured to allow communication to and from all Microsoft-signaling FQDNs.
   - To provide a failover option when the connection from an SBC is made to a datacenter that's experiencing an issue, the SBC must be configured to use all three SIP proxy FQDNs:

     - sip.pstnhub.microsoft.com
     - sip2.pstnhub.microsoft.com
     - sip3.pstnhub.microsoft.com

     > [!NOTE]
     > Devices that support DNS names can use sip-all.pstnhub.microsoft.com to resolve to all possible IP addresses.

   For more information, see [SIP Signaling: FQDNs](/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

- The installed root or intermediate certificate isn't a part of the SBC certificate chain issuer. When the SBC starts the three-way handshake during the authentication process, the Teams service won't be able to validate the certificate chain on the SBC and will reset the connection. The SBC may be able to authenticate again after the public root certificate is refreshed in the service cache or the certificate chain is fixed on the SBC. Make sure that the intermediate and root certificates installed on the SBC are correct.

  For more information about certificates, see [Public trusted certificate for the SBC](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
</details>

<details>
<summary><b>The FQDN doesn't match the contents of CN or SAN in the provided certificate</b></summary>

This issue occurs if a wildcard doesn't match a lower-level subdomain. For example, the wildcard `\*\.contoso.com` would match sbc1.contoso.com, but not customer10.sbc1.contoso.com. You can't have multiple levels of subdomains under a wildcard. If the FQDN doesn't match the Common Name (CN) or Subject Alternative Name (SAN) in the provided certificate, then request a new certificate that matches your domain names.

For more information about certificates, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
</details>

<details>
<summary><b>Domain activation is not registered in the Microsoft 365 environment</b></summary>

To fully activate a domain for a tenant and distribute it over the Microsoft 365 environment, you must assign at least one licensed user to the subdomain that's used by the SBC. When all the requirements are met, it may take up to 24 hours for the domain to be activated.

For a list of the licenses that are required for Direct Routing, see the "Licensing and other requirements" section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#licensing-and-other-requirements).

For more information about connecting the SBC to the tenant, see [Connect your Session Border Controller (SBC) to Direct Routing](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
</details>

## Issues related to the TLS connection

If the TLS connection is closed right away and a SIP OPTIONS request is not received from the SBC, or if a SIP 200 OK response is not received from the SBC, then the problem might be with the TLS version. The TLS version configured on the SBC should be 1.2 or higher.
<br><br>
<details>

<summary><b>The SBC certificate is self-signed or not from a trusted CA</b></summary>

If the SBC certificate is self-signed, it is not valid. Make sure that the SBC certificate is obtained from a trusted Certificate Authority (CA). The certificate must contain at least one FQDN that belongs to a Microsoft 365 tenant.

For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>The SBC doesn't trust the SIP proxy certificate</b></summary>

If the SBC doesn't trust the SIP proxy certificate, download and install the Microsoft Trusted Root certificate on the SBC. To download the certificate, see [Microsoft 365 encryption chains](/microsoft-365/compliance/encryption-office-365-certificate-chains).

For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>The SBC certificate is invalid</b></summary>

If the [Health Dashboard for Direct Routing](/microsoftteams/direct-routing-health-dashboard) in the Microsoft Teams admin center indicates that the SBC certificate is expired or revoked, request or renew the certificate from a trusted Certificate Authority (CA). Then, install it on the SBC. For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
When you renew the SBC certificate, you must remove the TLS connections that were established from the SBC to Microsoft with the old certificate and re-establish them with the new certificate. Doing so will ensure that certificate expiration warnings aren't triggered in the Microsoft Teams admin center. 
To remove the old TLS connections, restart the SBC during a time frame that has low traffic such as a maintenance window. If you can't restart the SBC, contact the SBC vendor for instructions to force the closure of all old TLS connections.

</details>

<details>
<summary><b>The SBC certificate or intermediate certificates are missing in the SBC TLS hello message</b></summary>

Check that a valid SBC certificate and all required intermediate certificates are installed correctly, and that the TLS connection settings on the SBC are correct.

Sometimes, even if everything looks correct, a closer examination of the packet capture might reveal that the TLS certificate is not provided to the Teams infrastructure.

</details>

<details>
<summary><b>The TLS connection is interrupted</b></summary>

The TLS connection is interrupted or isn't established even though the certificates and SBC settings are configured correctly.

The TLS connection may have been closed by one of the intermediary devices (such as a firewall or a router) on the path between the SBC and the Microsoft network. Check for any connection issues within your managed network, and fix them.

</details>
