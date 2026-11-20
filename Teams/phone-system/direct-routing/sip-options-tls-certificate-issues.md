---
title: Resolve SBC connectivity issues
description: Provides information on how to diagnose SBC connectivity issues in Direct Routing, including SIP OPTIONS and TLS certificate problems. Also provides steps to resolve the issues.
ms.date: 11/20/2026
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
ai-usage: ai-assisted
---

# Resolve SBC connectivity issues

[!INCLUDE [Teams Direct Routing note](../../../includes/teams-direct-routing-note.md)]

## Summary

When you set up Direct Routing, you might experience the following Session Border Controller (SBC) connectivity issues:

- Either the SIP Proxy or the SBC doesn't receive Session Initiation Protocol (SIP) OPTIONS requests.
- Transport Layer Security (TLS) connection problems occur.
- The SBC doesn't respond.
- The SBC is marked as Inactive in the Microsoft Teams admin center.

These issues are most commonly caused by either or both of the following conditions:

- There are problems with an SBC TLS certificate.
- An SBC is not configured correctly for Direct Routing.

This article lists some common issues that are related to SIP OPTIONS and TLS certificates, and it provides resolutions that you can try.

## Issues related to SIP OPTIONS

After the TLS connection is successfully established and the SBC can send and receive messages to and from the Microsoft SIP proxy, there might still be problems that affect the format or content of SIP OPTIONS requests.
<br><br>
<details>
<summary><b>The SBC doesn't receive a SIP 200 OK response from the SIP proxy</b></summary>

This situation might occur if you're using an older version of TLS. To enforce stricter security, [enable TLS 1.2](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).

Ensure that your SBC certificate isn't self-signed and that you got it from a [trusted certificate authority (CA)](/microsoftteams/direct-routing-plan?preserve-view=true#public-trusted-certificate-for-the-sbc).

If you're using the minimum required version of TLS or higher, and your SBC certificate is valid, the issue might occur because the fully qualified domain name (FQDN) is misconfigured in your SIP profile and isn't recognized as belonging to any tenant. Check for the following conditions, and fix any errors that you find:

- The FQDN provided by the SBC in the Contact and/or Record-Route header is different from what is configured in Teams.
- The Contact header contains an IP address instead of the FQDN.
- The domain isn't [fully validated](/microsoft-365/admin/setup/add-domain). If you added an FQDN that wasn't validated previously, you must validate it now.
- The registered SBC domain isn't activated. After you register a domain name for an SBC, you must activate it by [adding at least one E3- or E5-licensed user](/microsoftteams/direct-routing-connect-the-sbc?preserve-view=true#connect-the-sbc-to-the-tenant).

</details>

<details>

<summary><b>The SBC receives a SIP 200 OK response but not a SIP OPTIONS request</b></summary>

The SBC receives the SIP 200 OK response from the SIP proxy but doesn't receive the SIP OPTIONS request that the SIP proxy sends. If this issue occurs, ensure that the FQDN that's listed in the Contact and/or Record-Route header is correct and resolves to the correct IP address.

Another possible cause is that firewall rules prevent incoming traffic. Ensure that firewall rules are configured to allow incoming connections from all [SIP proxy signaling IP ranges](/microsoftteams/direct-routing-plan?preserve-view=true#sip-signaling-fqdns).

</details>

<details>
<summary><b>Calls work successfully, but the SBC is shown as Inactive or displays SIP OPTIONS warnings in the Microsoft Teams admin center</b></summary>

The health status shown in the Microsoft Teams admin center is based solely on the [SIP OPTIONS exchange](/microsoftteams/direct-routing-protocols-sip?preserve-view=true#how-the-sip-options-process-works) between the SBC and Microsoft SIP proxies and doesn't reflect actual call traffic. Because of this behavior, inbound and outbound calls might continue to work even when the SBC is shown as Inactive or displays SIP OPTIONS warnings.

Check the following conditions:

- Verify that the SBC is sending SIP OPTIONS requests to Microsoft.
- Verify that the Contact header and, if present, the Record-Route header contain the correct SBC FQDN.
- Verify that the SBC FQDN configured through the Microsoft Teams admin center or Teams PowerShell matches the FQDN presented by the SBC in the Contact and/or Record-Route header.
- Verify that the SBC FQDN resolves to a public IP address when queried through public DNS servers.
- Verify that the Microsoft SIP OPTIONS requests reach the SBC and that the SBC returns SIP 200 OK responses.
- Verify that firewalls, load balancers, or SBC rate-limiting policies aren't affecting the SIP OPTIONS traffic.

</details>

<details>
<summary><b>The SBC status is intermittently shown as Inactive</b></summary>

This issue might occur in the following situations:
  
- The SBC is configured to send SIP OPTIONS requests not to FQDNs but to the specific IP addresses that they resolved to at some point. During maintenance or outages, these FQDNs might resolve to different IP addresses in another datacenter. As a result, the SBC might continue sending SIP OPTIONS requests to an inactive or unresponsive datacenter. Do the following:

   - Ensure that the SBC is discoverable and configured to send SIP OPTIONS requests only to FQDNs.
   - Ensure that all devices in the route, such as SBCs and firewalls, are configured to allow communication to and from all Microsoft [SIP proxy signaling IP ranges](/microsoftteams/direct-routing-plan?preserve-view=true#sip-signaling-fqdns).
   - To provide a failover option when the connection from an SBC is made to a datacenter that's experiencing an issue, the SBC must be configured to use all three SIP proxy FQDNs:

     - sip.pstnhub.microsoft.com
     - sip2.pstnhub.microsoft.com
     - sip3.pstnhub.microsoft.com

   For more information, see [SIP Signaling: FQDNs](/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

- The root or intermediate certificate isn't part of the SBC certificate chain. When the SBC starts the TLS handshake during the authentication process, the Teams service can't validate the certificate chain on the SBC and resets the connection. The SBC might authenticate again after the public root certificate refreshes in the service cache or the certificate chain fixes on the SBC. Ensure that the intermediate and root certificates you install on the SBC are correct.

  For more information about certificates, see [Public trusted certificate for the SBC](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
</details>

<details>
<summary><b>The FQDN doesn't match the contents of CN or SAN in the provided certificate</b></summary>

One possible cause is a wildcard that doesn't match the SBC FQDN. The wildcard matches only one subdomain level. For example, the wildcard `*.contoso.com` matches `sbc1.contoso.com`, but not `customer10.sbc1.contoso.com`. If the FQDN doesn't match the Common Name (CN) or Subject Alternative Name (SAN) in the provided certificate, request a new certificate that matches your domain names.

For more information about certificates, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
</details>

<details>
<summary><b>The SBC domain isn't activated in Microsoft 365</b></summary>

To fully activate a domain for a tenant, ensure that at least one user has the SBC's domain in their sign-in name and an assigned E3 or E5 license. When you meet all the requirements, it can take up to 24 hours for the domain to activate.

For a list of the licenses that are required for Direct Routing, see the "Licensing requirements" section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#licensing-requirements).

For more information about connecting the SBC to the tenant, see [Connect your Session Border Controller (SBC) to Direct Routing](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
</details>

## Issues related to the TLS connection

If the TLS connection closes immediately and the SBC doesn't send a SIP OPTIONS request, or if the SBC doesn't send a SIP 200 OK response, the problem might be with the TLS version. [Configure the SBC to use TLS version 1.2](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
<br><br>
<details>

<summary><b>The SBC certificate is self-signed or not from a trusted CA</b></summary>

Direct Routing doesn't support a self-signed SBC certificate. Ensure you get the SBC certificate from a trusted certificate authority (CA). The certificate must contain at least one FQDN that belongs to a Microsoft 365 tenant.

For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>The SBC doesn't trust the SIP proxy certificate</b></summary>

If the SBC doesn't trust the SIP proxy certificates, download the root CA certificates required by Microsoft and install them in the SBC's trust store. To download the certificates, see [Microsoft 365 encryption chains](/microsoft-365/compliance/encryption-office-365-certificate-chains).

For a list of supported CAs for SBC certificates, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>The SBC certificate is invalid</b></summary>

If the [Health Dashboard for Direct Routing](/microsoftteams/direct-routing-health-dashboard) in the Microsoft Teams admin center indicates that the SBC certificate is expired or revoked, request or renew the certificate from a trusted certificate authority (CA). Then, install it on the SBC. For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
When you renew the SBC certificate, you must close the TLS connections that the SBC established to Microsoft with the old certificate and re-establish them with the new certificate. Doing so ensures that certificate expiration warnings aren't triggered in the Microsoft Teams admin center.  

To close the old TLS connections, restart the SBC during a low-traffic period, such as a maintenance window. If you can't restart the SBC, contact the SBC vendor for instructions to force the closure of all old TLS connections.

</details>

<details>
<summary><b>The SBC certificate or intermediate certificates are missing from the SBC TLS Certificate message</b></summary>

Check that you correctly installed a valid SBC certificate and all required intermediate certificates, and that the TLS connection settings on the SBC are correct.

Sometimes, even if everything looks correct, a closer examination of the packet capture might reveal that the TLS certificate isn't provided to the Teams infrastructure.

</details>

<details>
<summary><b>The TLS connection is interrupted</b></summary>

The TLS connection is interrupted or isn't established even though you configured the certificates and SBC settings correctly.

One of the intermediary devices (such as a firewall or a router) on the path between the SBC and the Microsoft network might have closed the TLS connection. Check for any connection issues within your managed network, and fix them.

</details>
