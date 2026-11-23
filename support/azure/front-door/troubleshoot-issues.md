---
title: Troubleshoot common issues
titleSuffix: Azure Front Door
description: In this article, you learn how to troubleshoot some of the common problems that you might face for your Azure Front Door instance.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: halkazwini
ms.service: azure-frontdoor
ms.topic: troubleshooting
ms.date: 08/27/2026
ms.custom: sap:Connectivity
#customer intent: As an Azure Front Door operator, I want to quickly diagnose and resolve common routing and timeout issues so that my applications remain available.
---

# Troubleshoot Azure Front Door common issues

## Summary

This article describes how to troubleshoot common issues that you might encounter when using your Azure Front Door.

> [!NOTE]
> You can request Azure Front Door to return extra debugging HTTP response headers. For more information, see [optional response headers](/azure/frontdoor/front-door-http-headers-protocol#optional-debug-response-headers).

## 504 response from Azure Front Door after a few seconds

### Symptom

- Regular requests sent to your backend without going through Azure Front Door are succeeding. Going through the Azure Front Door results in 504 error responses.
- The failure from Azure Front Door typically appears after about 30 seconds.
- 504 errors appear with "ErrorInfo: OriginTimeout."

### Cause

The cause of this issue can be one of two things:

- Your origin is taking longer than the timeout configured to receive the request from Azure Front Door. The default timeout is 30 seconds.
- The time it takes to send a response to the request from Azure Front Door is taking longer than the timeout value.

### Troubleshooting steps

- Send the request to your origin directly without going through Azure Front Door. Check how long your origin normally takes to respond.
- Send the request through Azure Front Door and check if you're getting any 504 responses. If not, the problem might not be a timeout issue. Create a support request to troubleshoot the issue further.
- If requests going through Azure Front Door result in a 504 error response code, configure the **Origin response timeout** for Azure Front Door. You can increase the default timeout to up to 4 minutes (240 seconds). To configure the setting, go to the overview page of the Front Door profile. Select **Origin response timeout** and enter a value between *16* and *240* seconds.
    > [!NOTE]
    > The ability to configure origin response timeout is only available in Azure Front Door Standard/Premium.

    :::image type="content" source="media/troubleshoot-issues/origin-timeout.png" alt-text="Screenshot of the origin timeout settings on the overview page of the Azure Front Door profile." lightbox="media/troubleshoot-issues/origin-timeout.png":::

## 502 responses from Azure Front Door only for HTTPS

### Symptom

- Azure Front Door returns 502 responses only for HTTPS-enabled endpoints.
- Regular requests sent to your backend without going through Azure Front Door succeed. Going via Azure Front Door results in 502 error responses.

### Cause

The cause of this problem can be one of three things:

- The origin hostname is an IP address.
- The origin server returns a certificate that doesn't match the fully qualified domain name (FQDN) of the Azure Front Door backend.
- The origin server returns a certificate without a complete chain.

### Troubleshooting steps

- The backend is an IP address.

   You must disable `EnforceCertificateNameCheck`.
    
    Azure Front Door has a switch called `EnforceCertificateNameCheck`. By default, this setting is enabled. When enabled, Azure Front Door checks that the backend host name FQDN matches the backend server certificate's certificate name or one of the entries in the subject alternative names extension.

    - How to disable `EnforceCertificateNameCheck` from the Azure portal:
    
      In the portal, use a toggle button to turn this setting on or off in the Azure Front Door (classic) **Design** pane.
    
      :::image type="content" source="./media/troubleshoot-issues/toggle-button-front-door-classic.png" alt-text="Screenshot that shows the toggle button in Azure Front Door (classic).":::

      For Azure Front Door Standard and Premium tier, you can find this setting in the origin settings when you add an origin to an origin group or configure a route.

      :::image type="content" source="./media/troubleshoot-issues/validation-checkbox.png" alt-text="Screenshot of the certificate subject name validation checkbox.":::

<br>

- The backend server returns a certificate that doesn't match the FQDN of the Azure Front Door backend. To resolve this issue, you have two options:

    - The returned certificate must match the FQDN.
    - Disable `EnforceCertificateNameCheck`.
  
- The origin server returns a certificate without a complete chain:

    - The origin server must return a certificate with a complete certificate chain, with at least leaf and intermediate certificates. If the origin server returns only a leaf certificate, Azure Front Door returns a 502 error.
    - Testing the origin server certificate in the browser by connecting to the origin server directly from a client machine doesn't show the error. The browser rebuilds the certificate chain of trust to be what it thinks it should be instead of showing exactly what the origin server returned.

    - Use OPENSSL to verify the certificate chain that's being returned. To do this check, connect to the origin hostname by using `-connect`. Send the origin hostname by using `-servername`. If the origin hostname is an IP, use `-noservername`. The command returns the entire certificate chain, which needs to match the FQDN of the origin and contain the full certificate chain of trust:

    Origin hostname is an FQDN:

    `openssl s_client -connect backendvm.contoso.com:443  -servername backendvm.contoso.com -showcerts`

    Origin hostname is an IP address:

    `openssl s_client -connect 0.0.0.0:443  -noservername  -showcerts`

## Requests sent to the custom domain return a 404 status code

### Symptom

- You created an Azure Front Door instance. A request to the domain or frontend host returns an HTTP 404 status code.
- You created a DNS (domain name server) mapping for a custom domain to the frontend host that you configured. Sending a request to the custom domain host name returns an HTTP 404 status code. It doesn't appear to route to the origin that you configured.

### Cause

The problem occurs if you didn't configure a routing rule for the custom domain that you added as the frontend host. You need to explicitly add a routing rule for that frontend host. You need to create the rule even if you already configured a routing rule for the frontend host under the Azure Front Door subdomain, which is **.azurefd.net**.

### Troubleshooting step

Add a routing rule for the custom domain to direct traffic to the selected origin group.

## Azure Front Door doesn't redirect HTTP to HTTPS

### Symptom

Azure Front Door has a routing rule for both HTTP and HTTPS, but accessing the domain with HTTP keeps HTTP as the protocol.

### Cause

This behavior can happen if you didn't configure the routing rules correctly for Azure Front Door. Your current configuration isn't specific and might have conflicting rules.

### Troubleshooting steps

Ensure the **Redirect all traffic to use HTTPS** option is selected in the route.

:::image type="content" source="media/troubleshoot-issues/redirect-https-route.png" alt-text="Screenshot of the redirect to HTTPS option in a Front Door route." lightbox="media/troubleshoot-issues/redirect-https-route.png":::

## My origin is configured as an IP address

### Symptom

You configured the origin as an IP address. The origin is healthy, but it rejects requests from Azure Front Door.

### Cause

Azure Front Door uses the origin host name as the SNI header during the SSL handshake. If you configure the origin as an IP address and disable the certificate name check, the origin certificate logic might reject requests that don't have a valid SNI matching the certificate.

### Troubleshooting steps

Change the origin from an IP address to a fully qualified domain name (FQDN) that has a valid certificate matching the origin certificate.

## 429 responses from Azure Front Door

### Symptom

A percentage of requests start showing errors with the response 429: Too many requests.

### Cause

Azure Front Door has default platform rate limits. If your traffic exceeds the limit, Front Door starts rate limiting the traffic and returns 429 responses.

### Troubleshooting steps

If you start seeing 429 responses for your legitimate traffic and need a higher quota limit, create an [Azure support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest).

## Related content

- Learn how to [configure an origin for Azure Front Door](/azure/frontdoor/how-to-configure-origin).
- Learn about [end-to-end TLS encryption with Azure Front Door](/azure/frontdoor/end-to-end-tls).
- Learn how Azure Front Door supports [URL redirects](/azure/frontdoor/front-door-url-redirect).
- Learn how to [add a custom domain to Azure Front Door](/azure/frontdoor/front-door-custom-domain).
