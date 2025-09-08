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

When you set up Direct Routing, you might experience the following Session Border Controller (SBC) connectivity issues:

- Session Initiation Protocol (SIP) options are not received.
- Transport Layer Security (TLS) connections problems occur.
- The SBC doesn't respond.
- The SBC is marked as inactive in the Microsoft Teams admin center.

Such issues are most likely caused by either or both of the following conditions:

- A TLS certificate experiences problems.
- An SBC is not configured correctly for Direct Routing.

This article lists some common issues that are related to SIP options and TLS certificates, and provides resolutions that you can try.  

## Overview of the SIP options process

- The SBC sends a TLS connection request that includes a TLS certificate to the SIP proxy server Fully Qualified Domain Name (FQDN) (for example, **sip.pstnhub.microsoft.com**).

- The SIP proxy checks the connection request.

  - If the request is not valid, the TLS connection is closed and the SIP proxy does not receive SIP options from the SBC.
  - If the request is valid, the TLS connection is established, and the SBC uses it to send SIP options to the SIP proxy.

- After it receives SIP options, the SIP proxy checks the Record-Route to determine whether the SBC FQDN belongs to a known tenant. If the FQDN information is not detected there, the SIP proxy checks the Contact header.

- If the SBC FQDN is detected and recognized, the SIP proxy sends a **200 OK** message by using the same TLS connection.

- The SIP proxy sends SIP options to the SBC FQDN that is listed in the Contact header of the SIP options received from the SBC.

- After receiving SIP options from the SIP proxy, the SBC responds by sending a **200 OK** message. This step confirms that the SBC is healthy.

- As the final step, the SBC is marked as **Active** in the Microsoft Teams admin center.

> [!NOTE]
> In a [hosted model](/microsoftteams/direct-routing-sbc-multiple-tenants), SIP options should be sent from only the hosted SBC. The status of SBCs that are in a derived trunk model are based on the main SBC.

### SIP options issues

After the TLS connection is successfully established, and the SBC is able to send and receive messages to and from the Teams SIP proxy, there might still be problems that affect the format or content of SIP options.
<br><br>
<details>
<summary><b>SBC doesn't receive a "200 OK" response from SIP proxy</b></summary>

This situation might occur if you're using an older version of TLS. To enforce stricter security, enable TLS 1.2.

Make sure that your SBC certificate is not self-signed and that you got it from a [trusted Certificate Authority (CA)](/microsoftteams/direct-routing-plan#public-trusted-certificate-for-the-sbc?preserve-view=true#resolution).

If you're using the minimum required version of TLS or higher, and your SBC certificate is valid, then the issue might occur because the FQDN is misconfigured in your SIP profile and not recognized as belonging to any tenant. Check for the following conditions, and fix any errors that you find:

- The FQDN provided by the SBC in the Record-Route or Contact header is different from what is configured in Teams.
- The Contact header contains an IP address instead of the FQDN.
- The domain isn't [fully validated](/microsoft-365/admin/setup/add-domain). If you add an FQDN that wasn't validated previously, you must validate it now.
- After you register an SBC domain name, you must activate it by [adding at least one E3- or E5-licensed user](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant?preserve-view=true#resolution).

</details>

<details>

<summary><b>SBC receives "200 OK" response but not SIP options</b></summary>

The SBC receives the **200 OK** response from the SIP proxy but not the SIP options that were sent from the SIP proxy. If this error occurs, make sure that the FQDN that's listed in the Record-Route or Contact header is correct and resolves to the correct IP address.

Another possible cause for this issue might be firewall rules that are preventing incoming traffic. Make sure that firewall rules are configured to allow incoming connections from all [SIP proxy signalling IP addresses](/microsoftteams/direct-routing-plan#sip-signaling-fqdns?preserve-view=true#resolution).

</details>

<details>
<summary><b>SBC status is intermittently inactive</b></summary>

This issue might occur in the following situations:
  
- The SBC is configured to send SIP options not to FQDNs but to the specific IP addresses that they resolve to. During maintenance or outages, these IP addresses might change to a different datacenter. Therefore, the SBC will be sending SIP options to an inactive or unresponsive datacenter. Do the following:

   - Make sure that the SBC is discoverable and configured to send SIP options to only FQDNs.
   - Make sure that all devices in the route, such as SBCs and firewalls, are configured to allow communication to and from all Microsoft-signaling FQDNs.
   - To provide a failover option when the connection from an SBC is made to a datacenter that's experiencing an issue, the SBC must be configured to use all three SIP proxy FQDNs:

     - sip.pstnhub.microsoft.com
     - sip2.pstnhub.microsoft.com
     - sip3.pstnhub.microsoft.com

     > [!NOTE]
     > Devices that support DNS names can use sip-all.pstnhub.microsoft.com to resolve to all possible IP addresses.

   For more information, see [SIP Signaling: FQDNS](/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

- The installed root or intermediate certificate isn't part of the SBC certificate chain issuer. When the SBC starts the three-way handshake during the authentication process, the Teams service won't be able to validate the certificate chain on the SBC and will reset the connection. The SBC may be able to authenticate again as soon as the public Root certificate is loaded again on the service cache or the certificate chain is fixed on the SBC. Make sure that the intermediate and root certificate installed on the SBC are correct.
  
  For more information about certificates, see [Public trusted certificate for the SBC](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
</details>

<details>
<summary><b>FQDN doesn't match the contents of CN or SAN in the provided certificate</b></summary>

This issue occurs if a wildcard doesn't match a lower-level subdomain. For example, the wildcard `\*\.contoso.com` would match sbc1.contoso.com, but not customer10.sbc1.contoso.com. You can't have multiple levels of subdomains under a wildcard. If the FQDN doesn't match the Common Name (CN) or Subject Alternate Name (SAN) in the provided certificate, then request a new certificate that matches your domain names.

For more information about certificates, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
</details>

<details>
<summary><b>Domain activation is not registered in the Microsoft 365 environment</b></summary>

To fully activate a domain for a tenant and distribute it over the Microsoft 365 environment, you must assign at least one licensed user to the subdomain that's used by the SBC. When all the requirements are met, it may take up to 24 hours for the domain to be activated.

For a list of the licenses that are required for Direct Routing, see the "Licensing and other requirements" section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#licensing-and-other-requirements).

For more information about this process, see the **Connect the SBC to the tenant** section of [Connect your Session Border Controller (SBC) to Direct Routing](/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
</details>

### TLS connection issues

If the TLS connection is closed right away and SIP options are not received from the SBC, or if **200 OK** is not received from the SBC, then the problem might be with the TLS version. The TLS version configured on the SBC should be 1.2 or higher.
<br><br>
<details>

<summary><b>SBC certificate is self-signed or not from a trusted CA</b></summary>

If the SBC certificate is self-signed, it is not valid. Make sure that the SBC certificate is obtained from a trusted Certificate Authority (CA). The certificate must contain at least one FQDN that belongs to a Microsoft 365 tenant.

For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>SBC doesn't trust SIP proxy certificate</b></summary>

If the SBC doesn't trust the SIP proxy certificate, download and install the Baltimore CyberTrust root certificate on the SBC. To download the certificate, see [Microsoft 365 encryption chains](/microsoft-365/compliance/encryption-office-365-certificate-chains).

For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).

</details>

<details>
<summary><b>SBC certificate is invalid</b></summary>

If the [Health Dashboard for Direct Routing](/microsoftteams/direct-routing-health-dashboard) in the Microsoft Teams admin center indicates that the SBC certificate is expired or revoked, request or renew the certificate from a trusted Certificate Authority (CA). Then, install it on the SBC. For a list of supported CAs, see the **Public trusted certificate for the SBC** section of [Plan Direct Routing](/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
  
When you renew the SBC certificate, you must remove the TLS connections that were established from the SBC to Microsoft with the old certificate and re-establish them with the new certificate. Doing so will ensure that certificate expiration warnings aren't triggered in the Microsoft Teams admin center. 
To remove the old TLS connections, restart the SBC during a time frame that has low traffic such as a maintenance window. If you can't restart the SBC, contact the vendor for instructions to force the closure of all old TLS connections.

</details>

<details>
<summary><b>SBC certificate or intermediary certificates are missing in the SBC TLS "Hello" message</b></summary>

Check that a valid SBC certificate and all required intermediate certificates are installed correctly, and that the TLS connection settings on the SBC are correct.

Sometimes, even if everything looks correct, a closer examination of the packet capture might reveal that the TLS certificate is not provided to the Teams infrastructure.

</details>

<details>
<summary><b>SBC connection is interrupted</b></summary>

The TLS connection is interrupted or not set up even though the certificates and SBC settings experience no issues.

The TLS connection may have been closed by one of the intermediary devices (such as a firewall or a router) on the path between the SBC and the Microsoft network. Check for any connection issues within your managed network, and fix them.

</details>

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
