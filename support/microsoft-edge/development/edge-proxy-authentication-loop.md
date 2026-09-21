---
title: Troubleshoot Repeated Proxy Authentication Prompts
description: Troubleshoot repeated proxy credential prompts, HTTP 407 responses, and Kerberos or NTLM single sign-on failures in Microsoft Edge.
ms.date: 09/18/2026
ms.custom: 'sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads'
ms.reviewer: yejxu,luden,wshao
ai-usage: ai-assisted
---

# Microsoft Edge repeatedly prompts for proxy credentials

## Summary

This article helps you troubleshoot issues in which Microsoft Edge repeatedly requests [proxy](/deployedge/configure-microsoft-edge-proxy-support) credentials. Either the credential dialog reappears after you enter valid credentials, or requests fail with an "HTTP 407 Proxy Authentication Required" response. These issues usually indicate that Microsoft Edge routes traffic to an unexpected proxy, that the proxy auto-configuration (PAC) file returns the wrong route, or that single sign-on through Kerberos or NTLM doesn't complete. Follow the methods in this article in the order given to identify and resolve the issue, and retest the failing request after each corrective change.

## Symptoms

You experience one or more of the following issues:

- Microsoft Edge repeatedly requests proxy credentials, and the prompt reappears even after you enter valid credentials.
- Requests fail with an "HTTP 407 Proxy Authentication Required" response.
- Pages load partially, and some subresources such as images, scripts, or stylesheets fail to load.
- Proxy single sign-on works for some users, devices, or sites, but not for others.
- The prompt appears intermittently, or only on certain networks.

## Cause

A proxy returns an "HTTP 407 Proxy Authentication Required" response whenever Microsoft Edge and the proxy don't complete an authentication exchange. Microsoft Edge then prompts you for credentials. The exchange commonly fails for one of the following reasons:

- Microsoft Edge routes the request to an unexpected proxy that your single sign-on configuration doesn't cover.
- The proxy offers no authentication scheme that the [AuthSchemes](/deployedge/microsoft-edge-policies/authschemes) policy enables.
- Microsoft Edge can't obtain credentials automatically. For example, no Kerberos ticket exists for the proxy's service principal name (SPN).
- A multistep Negotiate or NTLM exchange is interrupted before it completes.
- The proxy refuses the credentials, or an authorization rule denies the account.

Negotiate and NTLM authenticate over several request and response rounds. During those rounds, the proxy returns HTTP 407 together with another authentication token, which is expected behavior. Treat a 407 as a failure only when the exchange stops making progress or repeats the same challenge.

## Check the effective proxy configuration

1. Review **Settings** > **Network & internet** > **Proxy** in Windows, and note whether **Automatically detect settings**, a setup script, or a manual proxy is configured.
1. Open `edge://policy` and review [ProxySettings](/deployedge/microsoft-edge-policies/proxysettings). This policy is a dictionary that contains the proxy mode, server, PAC URL, and bypass rules. Inspect the `ProxyBypassList` field within the effective `ProxySettings` value to verify that the failing host isn't unintentionally bypassing or using the proxy.
1. Check whether the deprecated `ProxyMode`, `ProxyServer`, `ProxyPacUrl`, and `ProxyBypassList` policies are also set. These policies are deprecated and should only be considered when they already exist in an older deployment.
1. If a PAC file is configured, verify that it can be retrieved and that `FindProxyForURL` returns the expected route for both the main URL and failing subresources.

## Check the authentication scheme

1. Capture a reproduction at `edge://net-export`.
1. Ask the proxy administrator to confirm the advertised schemes and whether the 407 response repeats after Edge sends credentials.
1. For Kerberos or NTLM, review [AuthServerAllowlist](/deployedge/microsoft-edge-policies/authserverallowlist), [AuthSchemes](/deployedge/microsoft-edge-policies/authschemes), and any delegation requirements with the identity administrator.

For Kerberos, run `klist` in the affected user's session and inspect tickets and errors. Don't run `klist purge` as a routine fix because it removes unrelated Kerberos tickets; use it only under administrator direction.

## Avoid insecure authentication workarounds

Basic authentication to an HTTP proxy exposes credentials to an unprotected connection. Secure the proxy channel instead of enabling [BasicAuthOverHttpEnabled](/deployedge/microsoft-edge-policies/basicauthoverhttpenabled) as a production workaround.

## Determine whether the issue is specific to a user, device, or network

Isolating the scope tells you whether to investigate the user profile, the device, or the network path.

1. Compare an affected and unaffected user on the same device. If the unaffected user succeeds, the problem is specific to the original user or profile.
1. Test the affected user on a network path that doesn't use the proxy, when organizational policy permits. If the request succeeds, the problem is specific to the proxy or the network path.
1. Confirm that the proxy's service principal name, DNS name, and allow list entry refer to the same host identity.

## Collect data before contacting Microsoft Support

If you have to contact Microsoft Support for more help, collect the following information and include it with your support request:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Proxy configuration**: The redacted PAC file, and the expected proxy result for an affected URL.
- **Network log**: Go to `edge://net-export`, start logging, reproduce one failed request, and then save the log file.
- **Kerberos tickets**: The redacted `klist` output from the affected user's session.
- **Proxy logs**: Ask the proxy administrator for the 407 and authentication log entries that correspond to the failed request.

Network logs and exported policy data can contain internal URLs, host names, and other organizational details. Capture only the reproduction window, and remove any sensitive or personal information from the data before you share it.

## Related content

- [Proxy support in Microsoft Edge](/deployedge/configure-microsoft-edge-proxy-support)
- [Microsoft Edge HTTP authentication policies](/deployedge/microsoft-edge-policies#http-authentication)
- [Microsoft Edge policy reference](/deployedge/microsoft-edge-policies)