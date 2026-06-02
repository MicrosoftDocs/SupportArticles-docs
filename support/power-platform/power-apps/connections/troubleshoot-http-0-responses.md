---
title: Troubleshoot HTTP 0 responses and other blocked connector calls in Power Apps
description: Explains how to identify and investigate connector calls that fail with HTTP status 0 or with proxy-issued errors such as 403, and how to work with network administrators to resolve them.
ms.reviewer: jelopezf
ms.date: 05/20/2026
author: jelopezf
ms.author: jelopezf
ms.custom: sap:Connections\Connectors
---

# Troubleshoot HTTP 0 responses and other blocked connector calls in Power Apps

_Applies to:_ &nbsp; Power Apps, Power Automate, Custom Connectors

## Symptoms

When you run an app in Power Apps or a flow in Power Automate, a connector or web request is intercepted or blocked before it can produce a successful response from the Power Platform service. The failure is often intermittent, hard to reproduce on demand, and surfaces in one of the following ways:

- An HTTP status code of `0` in the Power Apps **Live Monitor** tool, in flow run history, or in browser developer tools. The response typically has no body, no headers, and no meaningful error message.
- A request shown as `(failed)` or `(canceled)` on the **Network** tab of browser developer tools.
- An HTTP status such as `403 Forbidden`, `407 Proxy Authentication Required`, `502 Bad Gateway`, or `503 Service Unavailable` whose response body is **not** from Power Platform but from an intermediary device (for example, a Zscaler, Netskope, or corporate proxy block page).
- Custom code that uses `fetch` or `XMLHttpRequest` and receives `status: 0` or a generic network error.

All of these symptoms share a common root pattern: the request is being **blocked or altered between the client device and the Power Platform service**, rather than being processed and rejected by the service itself.

## Cause

An HTTP status of `0` is not an actual response from the server. It indicates that the browser or client never received a response from the remote endpoint, usually because the request was blocked, dropped, or terminated before it could complete a round trip. Proxy-issued statuses such as `403` or `407` indicate something similar: an intermediary device intercepted the request and returned its own response instead of forwarding it to Power Platform.

Common causes include:

- Transient network outages or unstable device connectivity (for example, Wi-Fi drops, VPN disconnections, or cellular handoffs).
- Corporate proxies, firewalls, or SSL/TLS inspection devices terminating, throttling, or silently dropping the connection.
- DNS resolution failures or DNS-based filtering that prevents the client from resolving the Power Platform service endpoint.
- Security and zero-trust products such as Zscaler, Netskope, or similar SASE and secure web gateway solutions that intercept traffic and block, rewrite, or return a custom error page for connections to Power Platform endpoints.
- Browser extensions (ad blockers, privacy tools) or local antivirus software that cancel the request before it's sent.
- The user navigating away, closing the tab, or putting the device to sleep before the request completed.

> [!IMPORTANT]
> These failures originate on the client side or within the customer's network path, not on the Power Platform service. In most cases, resolution requires coordination with your network administrator to identify why the request is being blocked, redirected, or losing connectivity. Start with your network team to review HAR and proxy logs and apply required allow-list or inspection changes.

## Investigation

### Step 1: Confirm the request is reaching the network

Use your browser's developer tools to inspect the failing call:

1. In the browser, press **F12** to open developer tools, and select the **Network** tab.
2. Reproduce the issue in the app or flow.
3. Locate the failing request (status `0`, `(failed)`, `(canceled)`, or a `403`/`407`/`502` that doesn't look like a Power Platform response).
4. Select the request and examine the **Headers** section. Pay close attention to the **Remote Address** field, and review the response body for any indication that it came from a proxy or security appliance rather than the service.

The **Remote Address** field is one of the clearest signals:

- If it shows an IP address and port (for example, `192.0.2.10:443`), the request reached a remote server. The failure is then more likely a TLS, CORS, or service-side issue.
- If it shows **only a port** (such as `:443` or `:80`) with **no IP address**, the connection was blocked, intercepted, or short-circuited before it ever left the device or local network. This is a strong indicator that a proxy, firewall, DNS filter, or security agent (such as Zscaler) is handling the request locally instead of forwarding it. The same pattern often appears alongside a proxy-issued `403` or `407` response.

    :::image type="content" source="media/troubleshoot-http-0-responses/remote-address-no-ip.png" alt-text="Screenshot of a failed network request in browser developer tools where the Remote Address field shows only a port number with no IP address, indicating that the connection was blocked or intercepted before reaching the remote server.":::

Capture a [HAR file](/azure/azure-portal/capture-browser-trace) of the session so you can share it with your network team.

### Step 2: Rule out device and connectivity issues

Before engaging your network team, eliminate basic causes:

- Reproduce the issue on a different network (for example, a mobile hotspot) to confirm whether the problem follows the user, the device, or the corporate network.
- Try a different browser or an InPrivate/Incognito window with extensions disabled.
- Verify that the device has a stable connection and isn't suspending Wi-Fi for power management.
- Test from a different device on the same network to isolate device-specific problems.

If the call succeeds on an alternate network but fails on the corporate network, the issue is almost certainly in the corporate network path.

### Step 3: Work with your network administrator

If the evidence points to the corporate network (for example, missing remote IP, failures only on the corporate network, or other users affected), engage your network administrator. Share:

- The HAR file from Step 1.
- The exact URLs of the failing requests (host name and path).
- The approximate time, user, and device where the issue occurred.

Ask your network team to verify that all required Power Platform endpoints are allowed end-to-end through proxies, firewalls, and SSL inspection devices, and that DNS resolves them correctly. The authoritative list of host names and IP ranges is published here:

- [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements)

If your organization uses Zscaler, Netskope, or another secure web gateway, those endpoints must be explicitly allow-listed and, in most cases, **bypassed from SSL/TLS inspection**. SSL inspection is a frequent root cause of both HTTP 0 responses and unexpected `403`/`502` errors against Power Platform connectors, because the inspection device can break long-lived or chunked connections that the connector runtime relies on, or return its own block page when a policy match occurs.

### Step 4: Collect additional diagnostics if needed

If the issue persists after the network team has validated the configuration:

- Capture a network trace (for example, with [Wireshark](https://www.wireshark.org/) or `pktmon` on Windows) during a failing call.
- Use the Power Apps [Live Monitor](/power-apps/maker/monitor-overview) tool to confirm whether the failure is consistent across requests or limited to specific connectors.
- Note whether the failures correlate with specific times of day, specific users, specific geographic locations, or specific connectors—this often helps your network team pinpoint the device or policy responsible.

## Resolution

Because these failures are produced on the client side or by intermediary network devices, the resolution is almost always one of the following, performed by the customer's IT or network team:

- Allow the [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements) through all proxies, firewalls, and DNS filters.
- Bypass SSL/TLS inspection for Power Platform host names on Zscaler, Netskope, or similar gateways.
- Stabilize device connectivity (Wi-Fi, VPN, cellular) for affected users.
- Disable or reconfigure browser extensions or endpoint security products that cancel or rewrite requests to Power Platform endpoints.

If issues continue after your network team validates endpoint allow-listing, DNS resolution, and SSL inspection bypasses, collect updated traces and continue troubleshooting with your internal networking and security teams.

## More information

- [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements)
- [Live Monitor overview for Power Apps](/power-apps/maker/monitor-overview)
- [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace)

[!INCLUDE [Third-party information disclaimer](../../../../includes/third-party-information-disclaimer.md)]
