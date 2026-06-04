---
title: Troubleshoot HTTP 0 Responses and Blocked Calls
description: Diagnose and fix Power Apps and Power Automate calls that fail and return HTTP 0, proxy errors such as 403 or 502, or canceled requests.
ms.reviewer: jelopezf, v-shaywood
ms.date: 06/04/2026
ms.custom: sap:Connections\Connection errors
---

# Troubleshoot HTTP 0 responses and other blocked calls in Power Apps

_Applies to:_ &nbsp; Power Apps, Power Automate

## Summary

This article helps you investigate Power Apps and Power Automate calls that don't reach the service or that return an error from an intermediary device. Typical failures include an HTTP status of `0`, a proxy-issued status such as `403`, `407`, `502`, or `503`, and a request that's marked as `(failed)` or `(canceled)`. Learn how to tell whether the failure originates on the client side or in the network path, capture the right diagnostics, and work with your network team on a fix.

## Symptoms

A connector or web request fails before the Power Platform service can return a successful response. The failure is often intermittent and creates one of the following conditions:

- An HTTP status code of `0` in the Power Apps [Live Monitor](/power-apps/maker/monitor-overview) tool, in flow run history, or in browser developer tools. The response typically contains no body, no headers, and no meaningful error message.
- A request that has a displayed status of `(failed)` or `(canceled)` on the **Network** tab of browser developer tools.
- An HTTP status that's returned by an intermediary device (for example, a Zscaler, Netskope, or corporate proxy block page) instead of by Power Platform. For example:

  - `403 Forbidden`
  - `407 Proxy Authentication Required`
  - `502 Bad Gateway`
  - `503 Service Unavailable`

- Custom code that uses `fetch` or `XMLHttpRequest` and receives `status: 0` or a generic network error.

All these symptoms share a common root pattern: The request is blocked or altered between the client device and the Power Platform service instead of being processed and rejected by the service itself.

## Cause

An HTTP status of `0` isn't an actual response from the server. It means that the browser or client never received a response from the remote endpoint. This condition usually occurs because the request was blocked, dropped, or terminated before it could complete a round trip. Proxy-issued statuses such as `403` or `407` mean something similar: An intermediary device intercepted the request and returned its own response instead of forwarding the request to Power Platform.

Common causes include:

- Transient network outages or unstable device connectivity (for example, Wi-Fi drops, VPN disconnections, or cellular handoffs)
- Corporate proxies, firewalls, or SSL/TLS inspection devices that terminate, throttle, or silently drop the connection
- Network appliances that rewrite or strip [CORS](https://developer.mozilla.org/docs/Web/HTTP/CORS) headers (for example, changing `Access-Control-Allow-Origin` to a restrictive value) and cause browser-side failures before the network call finishes
- DNS resolution failures or DNS-based filtering that blocks the Power Platform service endpoint
- Secure web gateway or zero-trust products (such as Zscaler or Netskope) that intercept Power Platform traffic and block it, rewrite it, or return a custom error page
- Browser extensions (ad blockers, privacy tools) or local antivirus software that cancel the request before it's sent
- Browser local-network protections that treat proxied traffic as local-resource access and block the request
- The user navigating away, closing the tab, or putting the device to sleep before the request finishes

> [!NOTE]
> These failures originate on the client side or within your network path, not on the Power Platform service. Resolution usually requires coordination with your network administrator to identify why the request is blocked, redirected, or losing connectivity.

## Determine the source of the problem

### Verify that the request reaches the network

Use your browser's developer tools to inspect the failing call:

1. In the browser, press <kbd>F12</kbd> to open developer tools, and select the **Network** tab.
1. Reproduce the issue in the app or flow.
1. Locate the failing request. Look for responses that match one or more of the following indicators:

   - Status `0`, `(failed)`, or `(canceled)`
   - A `403`, `407`, or `502` response that doesn't resemble a Power Platform response

1. Select the request, and examine the **Headers** section. Closely examine the **Remote Address** field. Also, review the response body for any indication that the request came from a proxy or security appliance instead of the service.

For "4*xx*" and "5*xx*" responses, inspect response headers for Power Platform service markers such as `x-ms-correlation-id` or `x-ms-request-id` (with GUID values):

- If at least one valid `x-ms-*` request/correlation header is present, the request likely reached the service and was rejected there.
- If these headers are missing, and the response resembles a proxy or gateway page, an intermediary network device likely generated the response.

If you engage Microsoft Support, include any `x-ms-correlation-id` or `x-ms-request-id` values that you captured. These identifiers help correlate the request with service telemetry.

The **Remote Address** field is one of the clearest signals:

- If the field shows an IP address and port (for example, `192.0.2.10:443`), the request reached a remote server. The failure is then more likely a TLS, CORS, or service-side issue.
- If the field shows **only a port** (such as `:443` or `:80`) together with **no IP address**, the connection was blocked, intercepted, or short-circuited before it left the device or local network. That strongly suggests that a proxy, firewall, DNS filter, or security agent (such as Zscaler) is handling the request locally instead of forwarding it. The same pattern often appears alongside a proxy-issued `403` or `407` response.

    :::image type="content" source="media/troubleshoot-http-0-responses/remote-address-no-ip.png" alt-text="Screenshot of a failed network request in browser developer tools showing the Remote Address field that includes only a port and no IP address.":::

Capture an [HAR file](/azure/azure-portal/capture-browser-trace) of the session so that you can share it with your network team.

### Rule out device and connectivity problems

Before you engage your network team, rule out basic device and connectivity problems:

- Reproduce the problem on a different network (for example, a mobile hotspot) to check whether the problem follows the user, the device, or the corporate network.
- Try a different browser, or use an InPrivate or Incognito window by having extensions disabled.
- Verify that the device has a stable connection and isn't suspending Wi-Fi for power management.
- Test from a different device on the same network to isolate device-specific problems.

If the call succeeds on an alternative network but fails on the corporate network, the problem is almost certainly in the corporate network path.

If failures affect users in only specific regions, also consider DNS response-size filtering by intermediary devices. Some Power Platform host name chains produce larger DNS answers (for example, because of CNAME expansion and geographic routing). Devices that enforce older DNS size assumptions from [RFC 1035](https://www.rfc-editor.org/rfc/rfc1035.txt) can block responses that are valid under [RFC 6891](https://www.rfc-editor.org/rfc/rfc6891.txt). The result is region-specific app load or connector failures.

### Work with your network administrator

The evidence might point to the corporate network. For example, you might notice missing remote IP, or that failures occur only on the corporate network, or that other users are affected. In these cases, engage your network administrator. Share the following information:

- The HAR file that you captured earlier
- The exact URLs of the failing requests (host name and path)
- The approximate time, user, and device where the issue occurred

Ask your network team to verify the following conditions:

- All required Power Platform endpoints are allowed end-to-end through proxies, firewalls, and SSL inspection devices. The authoritative list of host names and IP ranges is at [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements).
- DNS resolves Power Platform endpoints correctly.
- Allowlist rules cover dynamic host names and subdomains. Power Platform requests can use long, environment-specific host names under service domains instead of a single fixed host. A rule that allows only a previously observed subdomain can fail at the next routing change, even though no app logic changed.
- CORS headers returned by Power Platform are preserved end-to-end. Header rewrite or removal can cause browser-level failures (including HTTP status `0`), even if endpoint allow-listing is otherwise correct.
- Inspection devices support larger DNS responses and EDNS behavior. This condition is especially important if failures are concentrated by region or office location.
- Secure all allowlist Power Platform host names in web gateways (Zscaler, Netskope, or similar), and protect them from SSL/TLS inspection. SSL inspection is a frequent root cause of HTTP `0` responses and unexpected `403` or `502` errors. The inspection device can break long-lived or chunked connections that the connector runtime relies on. It can also return its own block page if a policy match occurs.

If you suspect browser local-network protections, review the relevant browser guidance. For Chromium, see [Private Network Access: introducing preflights](https://developer.chrome.com/blog/private-network-access-preflight).

### Collect additional diagnostics

If the issue persists after the network team verifies the configuration:

- Capture a network trace (for example, with [Wireshark](https://www.wireshark.org/) or `pktmon` on Windows) during a failing call.
- Use the Power Apps Live Monitor tool to verify whether the failure is consistent across requests or limited to specific connectors.
- Review HAR entries for proxy-identifying headers such as `Via`.
- Look for protocol downgrade patterns, such as `HTTP/1.1` responses where you expect modern `HTTP/2`. Connector traffic should use modern HTTP. Therefore, repeated downgrades often indicate intermediary inspection or proxy fallback, and they can affect reliability and performance.
- If a browser local-network access prompt appears, or if it appears that access was denied, collect that detail for the network team. Some proxy designs that use nonroutable or private address ranges can trigger local-network protections and block requests.
- Note whether the failures correlate with specific times of day, specific users, specific geographic locations, or specific connectors. This information often helps your network team pinpoint the device or policy that's responsible.

## Solution

Your IT or network team usually makes most fixes. Share the HAR file and proxy logs that you captured, and then apply one or more of the following changes:

- Allow the [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements) through all proxies, firewalls, and DNS filters.
- Bypass SSL/TLS inspection for Power Platform host names on Zscaler, Netskope, or similar gateways.
- Stabilize device connectivity (Wi-Fi, VPN, cellular) for affected users.
- Review and reconfigure browser extensions or endpoint security products that cancel or rewrite requests to Power Platform endpoints.

If the problems continue after you make these changes, collect updated traces, and continue to troubleshoot together with your networking and security teams.

## Related content

- [Troubleshoot broken connections in Microsoft Power Platform](../../power-automate/connections/troubleshoot-broken-connections.md)
- [Managed connectors outbound IP addresses](/connectors/common/outbound-ip-addresses)

[!INCLUDE [Third-party information disclaimer](../../../../includes/third-party-information-disclaimer.md)]
