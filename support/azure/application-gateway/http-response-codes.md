---
title: HTTP response codes - Azure Application Gateway
description: 'Troubleshoot Application Gateway HTTP response codes, identify client and server error causes, and apply fixes to keep apps available. Start now.'
services: application-gateway
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 03/27/2026
ms.custom: sap:Connectivity
# Customer intent: "As an IT administrator managing Azure Application Gateway, I want to understand HTTP response codes and their causes, so that I can effectively troubleshoot client and server errors to ensure high availability and optimal performance of my applications."
---

# HTTP response codes in Application Gateway

## Summary

This article explains why Azure Application Gateway returns specific HTTP response codes. It provides common causes and troubleshooting steps to help you determine the root cause of an error HTTP response code. Application Gateway can return HTTP response codes to a client request whether or not it initiates a connection to a backend target.

> [!NOTE]
> If a client connection fails before Application Gateway returns any HTTP response, the failure is likely a Transport Layer Security (TLS) handshake failure. Common causes include TLS version mismatches (for example, the client uses TLS 1.0 or 1.1 while the gateway requires TLS 1.2 or higher) and unsupported cipher suites. Starting August 31, 2025, Azure Application Gateway discontinues support for TLS 1.0 and 1.1. For more information, see [Application Gateway TLS policy overview](/azure/application-gateway/application-gateway-ssl-policy-overview) and [Configure TLS policy versions and cipher suites](/azure/application-gateway/application-gateway-configure-ssl-policy-powershell).

## 3XX response codes (redirection)

Application Gateway returns 300-399 responses when a client request matches an application gateway rule that has redirects configured. You can configure redirects on a rule as-is or via a path map rule. For more information about redirects, see [Application Gateway redirect overview](/azure/application-gateway/redirect-overview).

#### 301 Permanent redirect

Application Gateway returns HTTP 301 responses when you specify a redirection rule with the **Permanent** value.

#### 302 Found

Application Gateway returns HTTP 302 responses when you specify a redirection rule with the **Found** value.

#### 303 See other

Application Gateway returns HTTP 303 responses when you specify a redirection rule with the **See Other** value.

#### 307 Temporary redirect

Application Gateway returns HTTP 307 responses when you specify a redirection rule with the **Temporary** value.


## 4XX response codes (client error)

400-499 response codes indicate an issue that the client initiates. These issues can range from the client initiating requests to an unmatched hostname, request time-out, unauthenticated request, malicious request, and more.

Application Gateway collects metrics that capture the distribution of 4xx/5xx status codes and has a logging mechanism that captures information such as the URI client IP address with the response code. Metrics and logging enable further troubleshooting.  Clients can also receive 4xx responses from other proxies between the client device and Application Gateway. For example, CDN (Content Delivery Network) and other authentication providers. See the following articles for more information.

- [Metrics supported by Application Gateway V2 SKU](/azure/application-gateway/application-gateway-metrics#metrics-supported-by-application-gateway-v2-sku)
- [Diagnostic logs](/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging)

#### 400 – Bad request

You commonly see HTTP 400 response codes when:
- You initiate non-HTTP or HTTPS traffic to an application gateway with an HTTP or HTTPS listener.
- You initiate HTTP traffic to a listener with HTTPS, with no redirection configured.
- You configure mutual authentication but Application Gateway can't properly negotiate.
- The request isn't compliant with RFC. 

Some common reasons for the request to be non-compliant with RFC are: 

| Category | Examples |
| ---------- | ---------- |
| Invalid Host in request line | Host containing two colons (example.com:**8090:8080**) |
| Missing Host Header | Request doesn't have Host Header |
| Presence of malformed or illegal character | Reserved characters are **&,!.** The workaround is to code it as a percentage. For example: %& |
| Invalid HTTP version | Get /content.css HTTP/**0.3** |
| Header field name and URI contain non-ASCII Character | GET /**«úü¡»¿**.doc HTTP/1.1 |
| Missing Content Length header for POST request | Self Explanatory |
| Invalid HTTP Method | **GET123** /index.html HTTP/1.1 |
| Duplicate Headers | Authorization:\<base64 encoded content\>, Authorization: \<base64 encoded content\> |
| Invalid value in Content-Length | Content-Length: **abc**,Content-Length: **-10** |

When you configure mutual authentication, several scenarios can lead to an HTTP 400 response being returned the client, including:

- You enable mutual authentication but the client certificate wasn't presented. 
- You enable Distinguished Name (DN) validation and the DN of the client certificate doesn't match the DN of the specified certificate chain.
- Client certificate chain doesn't match certificate chain configured in the defined SSL Policy.
- Client certificate is expired.
- You enable Online Certificate Status Protocol (OCSP) Client Revocation check and the certificate is revoked.
- You enable OCSP Client Revocation check but Application Gateway can't contact OCSP responder.
- You enable OCSP Client Revocation check but the OCSP responder isn't provided in the certificate.

For more information about troubleshooting mutual authentication, see [Error code troubleshooting](mutual-authentication-troubleshooting.md#solution-2).

#### 401 – Unauthorized

Application Gateway returns an HTTP 401 unauthorized response to the client if the client isn't authorized to access the resource. Several reasons exist for 401 to be returned. The following list provides a few reasons with potential fixes.
 - If the client has access, it might have an outdated browser cache. Clear the browser cache and try accessing the application again.

Application Gateway can return an HTTP 401 unauthorized response to AppGW probe request if you configure the backend pool with [NTLM](/windows/win32/secauthn/microsoft-ntlm?redirectedfrom=MSDN) authentication. In this scenario, Application Gateway marks the backend as healthy. Resolve this issue by using one of the following methods:
- Allow anonymous access on backend pool.
- Configure the probe to send the request to another "fake" site that doesn't require NTLM.
- Not recommended, as this solution doesn't tell us if the actual site behind the application gateway is active or not.
- Configure application gateway to allow 401 responses as valid for the probes: [Probe matching conditions](/azure/application-gateway/application-gateway-probe-overview).

#### 403 – Forbidden

Application Gateway presents HTTP 403 Forbidden when you use WAF (Web Application Firewall) skus and have WAF configured in Prevention mode.  If enabled WAF rulesets or custom deny WAF rules match the characteristics of an inbound request, Application Gateway presents a 403 forbidden response to the client.

To troubleshoot WAF false positives (legitimate requests blocked by WAF rules):

1. Enable [WAF diagnostic logs](/azure/application-gateway/application-gateway-diagnostics#firewall-log) and review the `ruleId_s` field to identify which rule is blocking the request.
2. Temporarily switch the WAF to **Detection mode** to log matching rules without blocking traffic. This approach helps you confirm false positives before making rule changes. For more information, see [WAF policy settings](/azure/web-application-firewall/ag/create-waf-policy-ag#configure-waf-rules-optional).
3. Create [WAF exclusions](/azure/web-application-firewall/ag/application-gateway-waf-configuration) for specific request attributes (headers, cookies, or arguments) that trigger false positives.
4. If a managed rule consistently causes false positives and exclusions aren't sufficient, [disable the individual rule](/azure/web-application-firewall/ag/application-gateway-customize-waf-rules-portal) in the WAF policy.

For detailed guidance, see [Troubleshoot WAF for Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot) and [WAF best practices](/azure/web-application-firewall/ag/best-practices).

Other reasons for clients receiving 403 responses include:

- **h2c protocol upgrade attempts**: Application Gateway returns 403 errors when clients attempt to upgrade from HTTP/1.1 to HTTP/2.0 by using the h2c protocol (HTTP/2 Cleartext). Application Gateway only supports HTTP/2 over TLS (HTTPS listeners). It doesn't support h2c protocol upgrades over HTTP listeners. This behavior occurs regardless of WAF mode. Clients should use native HTTP/2 connections over HTTPS or remain on HTTP/1.1 without upgrade attempts.
- You're using App Service as backend and you configured it to allow access only from Application Gateway. This configuration can return a 403 error by App Services. This error typically happens due to redirects or href links that point directly to App Services instead of pointing at the Application Gateway's IP address. 
- If you're accessing a storage blob and the Application Gateway and storage endpoint are in different regions, then a 403 error is returned if the Application Gateway's public IP address isn't allow-listed. See [Grant access from an internet IP range](/azure/storage/common/storage-network-security?tabs=azure-portal#grant-access-from-an-internet-ip-range).

#### 404 – Page not found

An HTTP 404 response is generated when you make a request to Application Gateway (V2 SKUs) with a hostname that doesn't correspond to any of the configured Multi-site listeners, and there's no Basic listener present. To learn more, see [types of listeners](/azure/application-gateway/application-gateway-components#types-of-listeners).

#### 408 – Request time-out

You can observe an HTTP 408 response when client requests to the frontend listener of Application Gateway don't respond back within 60 seconds.  You might observe this error due to traffic congestion between on-premises networks and Azure, when virtual appliance inspects the traffic, or the client itself becomes overwhelmed.

#### 413 – Request entity too large

You can observe an HTTP 413 response when using [Azure Web Application Firewall on Application Gateway](/azure/web-application-firewall/ag/ag-overview) and the client request size exceeds the maximum request body size limit. The maximum request body size field controls overall request size limit excluding any file uploads. The default value for request body size is 128 KB. For more information, see [Web Application Firewall request size limits](/azure/web-application-firewall/ag/application-gateway-waf-request-size-limits).

#### 499 – Client closed the connection

An HTTP 499 response is presented if a client request that you sent to application gateways using v2 sku is closed before the server finished responding. You can observe this error in two scenarios. The first scenario is when a large response is returned to the client and the client might have closed or refreshed the application before the server finished sending a large response. The second scenario is when the time-out on the client side is low and doesn't wait long enough to receive the response from server. In this case, it's better to increase the time-out on the client. In application gateways using v1 sku, an HTTP 0 response code might be raised for the client closing the connection before the server finishes responding as well.


## 5XX response codes (server error)

500-599 response codes indicate a problem with application gateway or the backend server while performing the request.

#### 500 – Internal server error

Azure Application Gateway shouldn't return 500 response codes. Open a support request if you see this code, because this issue is an internal error to the service. For information on how to open a support case, see [Create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

#### 502 – Bad gateway

HTTP 502 errors can have several root causes, including:

- NSG (Network security group), UDR (user-defined route), or custom DNS is blocking access to backend pool members.
- Backend VMs or instances of [virtual machine scale sets](/azure/virtual-machine-scale-sets/overview) aren't responding to the default health probe.
- Invalid or improper configuration of custom health probes.
- Azure Application Gateway's [backend pool isn't configured or empty](/azure/application-gateway/application-gateway-troubleshooting-502#empty-backendaddresspool).
- None of the VMs or instances in [virtual machine scale set are healthy](/azure/application-gateway/application-gateway-troubleshooting-502#unhealthy-instances-in-backendaddresspool).
- [Request time-out or connectivity issues](/azure/application-gateway/application-gateway-troubleshooting-502#request-time-out) with user requests-Azure application Gateway V1 SKU sent HTTP 502 errors if the backend response time exceeds the time-out value that is configured in the Backend Setting.

For information about scenarios where 502 errors occur, and how to troubleshoot them, see [Troubleshoot Bad Gateway errors](/azure/application-gateway/application-gateway-troubleshooting-502).

#### 503 – Service unavailable

HTTP 503 responses indicate that Application Gateway or a backend server is temporarily unable to handle the request. Common causes include:

- All backend pool members are unhealthy as determined by health probes and no healthy server is available to process requests.
- The backend server is overloaded or undergoing maintenance and returning 503 directly to Application Gateway.
- Application Gateway V2 autoscaling is in progress and new instances aren't yet ready to serve traffic.
- Connection limits are reached on Application Gateway or the backend server.

To troubleshoot 503 errors:

1. Check the **Backend health** pane in the Azure portal to verify the backend pool member status.
2. Review health probe configuration to ensure probes aren't incorrectly marking healthy backends as unhealthy. For more information, see [Health probe overview](/azure/application-gateway/application-gateway-probe-overview).
3. Verify that the backend application is operational by accessing it directly, bypassing Application Gateway.
4. Check Application Gateway metrics for connection count and capacity unit utilization in Azure Monitor.
5. For V2 SKUs, review autoscale settings to ensure sufficient minimum instance counts during traffic spikes.

For more information, see [Troubleshoot backend health issues](application-gateway-backend-health-troubleshooting.md).

#### 504 – Gateway time-out

Azure Application Gateway V2 SKU sends HTTP 504 errors if the backend response time exceeds the time-out value that you configure in the Backend Setting.

IIS (Internet Information Services web server)

If your backend server is IIS, see [Default Limits for Web Sites](/iis/configuration/system.applicationhost/sites/sitedefaults/limits#configuration) to set the time-out value. Refer to the `connectionTimeout` attribute for details. Ensure the connection time-out in IIS matches or doesn't exceed the timeout set in the backend setting.

Nginx

If the backend server is Nginx or Nginx Ingress Controller, and if it has upstream servers, ensure the value of `nginx:proxy_read_timeout` matches or doesn't exceed the time-out set in the backend setting.

## Troubleshooting scenarios

### "ERRORINFO_INVALID_HEADER" error in access logs

**Problem**: The [Access log](/azure/application-gateway/monitor-application-gateway-reference#access-log-category) shows an "ERRORINFO_INVALID_HEADER" error for a request, even though the backend response code (serverStatus) is 200. In other cases, the backend server returns 500.

**Cause**: The client sends a header that contains CR LF characters.

**Solution**: Replace the CR LF characters with SP (whitespace) and resend the request to Application Gateway.

