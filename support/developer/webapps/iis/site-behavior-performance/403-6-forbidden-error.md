---
title: Troubleshoot HTTP 403.6 Forbidden in IIS
description: Learn how to fix the HTTP 403.6 Forbidden error in IIS by managing IP address rules, verifying policies, and addressing proxy scenarios.
ms.date: 03/17/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: clinth, jaws, v-shaywood
---
# HTTP error 403.6 when you open an IIS webpage

_Original product version:_ &nbsp; Internet Information Services (IIS)  
_Original KB number:_ &nbsp; 248043

> [!NOTE]
> This article is intended for website administrators. If you're an end user, contact your website administrator to report this error.

## Summary

This article helps you troubleshoot the `HTTP 403.6` error in Internet Information Services (IIS). This error occurs when IIS IP address and domain restrictions block a client from accessing a website or application. The article covers how to review and update IP address restriction rules, verify the default restriction policy, check configuration files, and resolve proxy or load balancer scenarios.

## Symptoms

When you visit a website that's hosted on IIS in a web browser, you might receive an `HTTP 403.6` error message that resembles the following example:

> HTTP 403.6 - Forbidden: IP address rejected

## Cause

IIS provides the **IP Address and Domain Restrictions** feature that administrators can use to control which clients can access a website or application.

IIS returns the `HTTP 403.6` response if a client IP address is:

- Explicitly listed in the **deny rules**
- Not included in the allow list when the server is configured to deny unspecified clients

You can configure restrictions at multiple levels in IIS, as follows:

- Server level
- Website level
- Application level
- Directory or file level

If a restriction exists at any level in the configuration hierarchy, IIS might reject the request.

## Solution

### Review IP address restrictions in IIS Manager

1. Open **Internet Information Services (IIS) Manager**.
1. In the **Connections** pane, select the server, site, or application where the issue occurs.
1. In **Features View**, double-click **IP Address and Domain Restrictions**.
1. Review the configured rules.

#### To allow a client IP address

1. On the **Actions** pane, select **Add Allow Entry**.
1. Enter the IP address or subnet mask.
1. Select **OK**.

#### To remove a blocking rule

1. Locate the rule that blocks the IP address.
1. Select the rule.
1. On the **Actions** pane, select **Remove**.

### Verify the default restriction policy

1. Open **Internet Information Services (IIS) Manager**.
1. On the **Connections** pane, select the server, site, or application where the issue occurs.
1. In **Features View**, double-click **IP Address and Domain Restrictions**.
1. On the **Actions** pane, select **Edit Feature Settings**.
1. Review the configured policy. Two policies are available:
   - **Allow unspecified clients**: All clients are allowed except clients that are explicitly denied.
   - **Deny unspecified clients**: Only explicitly allowed IPs have access.
1. If **Deny unspecified clients** is configured, add the client IP address as an _allow rule_.

### Check configuration files

You can also configure IP restrictions in `Web.config` or `ApplicationHost.config`.

Example configuration:

```xml
<ipSecurity allowUnlisted="false">
    <add ipAddress="127.0.0.1" allowed="true" />
</ipSecurity>
```

If `allowUnlisted="false"` is set, add the client IP address as an allowed entry to grant access.

### Check for proxy or load balancer scenarios

If the website is behind a proxy, gateway, or load balancer, IIS might receive requests from the intermediate device instead of from the original client.

In this case:

1. Review IIS logs to determine the IP address that's recorded for the request.
1. Determine whether you have to allow the proxy or load balancer IP address.

## Additional considerations

### Domain name restrictions

If you restrict access by domain name, IIS performs reverse DNS lookups. This process can introduce latency and might cause unexpected access problems if DNS resolution fails.

### Proxy servers

If a client connects through a proxy server, IIS sees the proxy server's IP address instead of the original client IP address. Check whether headers like `X-Forwarded-For` are used to pass the original client IP.

### Localhost-only configurations

You can configure some sites to allow access from only the localhost (127.0.0.1). This configuration restricts access to requests that originate from the server itself.

## Related content

- [Microsoft TCP/IP host name resolution order](https://support.microsoft.com/help/172218)
- [Troubleshoot 4xx and 5xx HTTP errors](troubleshoot-http-error-code.md)
- [HTTP error 403.7 when you open an IIS webpage](http-403-forbidden-open-webpage.md)
