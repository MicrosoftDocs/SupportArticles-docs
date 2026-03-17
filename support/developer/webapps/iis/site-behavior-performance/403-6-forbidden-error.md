---
title: HTTP error 403.6 when you open a webpage
description: This article helps to fix the HTTP error 403.6 when you visit a web site that is hosted on Microsoft Internet Information Services (IIS).
ms.date: 07/17/2020
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: clinth
---
# HTTP error 403.6 when you open an IIS Webpage

This article helps to fix the HTTP error 403.6 that occurs when you visit a web site that is hosted on Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services (IIS)  
_Original KB number:_ &nbsp; 248043

> [!NOTE]
> The target audience for this article is Website administrator. If you are an end-user, you have to contact the Website administrators in order to let them know that this error has occurred for this URL address.

## Symptoms

You have a web site that is hosted on Internet Information Services (IIS). When you visit the Web site in a Web browser, you may receive an error message that resembles the follow:

> HTTP 403.6 - Forbidden: IP address rejected

## Cause

IIS provides the **IP Address and Domain Restrictions** feature that allows administrators to control which clients can access a website or application.

If a client IP address is:

- Explicitly listed in the **deny rules**, or  
- Not included in the allow list when the server is configured to deny unspecified clients  

IIS returns the **HTTP 403.6** response.

Restrictions can be configured at multiple levels in IIS:

- Server level  
- Website level  
- Application level  
- Directory or file level  

If a restriction exists at any level in the configuration hierarchy, the request may be rejected.


## Resolution

### Method 1: Review IP address restrictions in IIS Manager

1. Open **Internet Information Services (IIS) Manager**.
2. In the **Connections** pane, select the server, site, or application where the issue occurs.
3. In **Features View**, double-click **IP Address and Domain Restrictions**.
4. Review the configured rules.

#### To allow the client IP address

1. Select **Add Allow Entry** in the **Actions** pane.
2. Enter the IP address or subnet mask.
3. Select **OK**.

#### To remove a blocking rule

1. Locate the rule that blocks the IP address.
2. Select the rule.
3. Choose **Remove** from the **Actions** pane.

---

### Method 2: Verify the default restriction policy

In **IP Address and Domain Restrictions**, select **Edit Feature Settings**.

Two policies are available:

| Policy | Behavior |
|------|------|
| Allow unspecified clients | All clients are allowed except those explicitly denied |
| Deny unspecified clients | Only explicitly allowed IPs can access |

If **Deny unspecified clients** is configured, the client IP address must be explicitly added as an **allow rule**.

---

### Method 3: Check configuration files

IP restrictions can also be configured in **web.config** or **applicationHost.config**.

Example configuration:

```xml
<ipSecurity allowUnlisted="false">
    <add ipAddress="127.0.0.1" allowed="true" />
</ipSecurity>
```

If allowUnlisted="false" is specified, only IP addresses that are explicitly listed as allowed can access the application.

### Method 4: Check for proxy or load balancer scenarios

If the website is behind a proxy, gateway, or load balancer, IIS might receive requests from the intermediate device instead of the original client.

In this case:

1. Review IIS logs to determine the IP address recorded for the request.

2. Verify whether the proxy or load balancer IP address needs to be allowed.

3. Check whether headers such as X-Forwarded-For are used to pass the original client IP.

## Additional Considerations

Additional considerations
### Domain name restrictions

Restricting access by domain name requires reverse DNS lookups, which can introduce latency and may cause unexpected access issues if DNS resolution fails.

### Proxy servers

If a client connects through a proxy server, IIS will see the proxy server’s IP address instead of the original client IP address.

### Localhost-only configurations

Some sites are configured to allow access only from 127.0.0.1, which restricts access to requests originating from the server itself.

## References

[Microsoft TCP/IP host name resolution order](https://support.microsoft.com/help/172218)
