---
title: Identify and remediate MaxConcurrentApi issues that affect user authentication
description: Summarizes a set of articles that discuss how to work around or resolve authentication failures and slowdowns when Windows servers are overloaded by authentication requests.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
keywords: MaxConcurrentApi, MCA, authentication slowdown, authentication performance
---

# Overview: Identify and remediate MaxConcurrentApi issues that affect user authentication

This article summarizes a set of articles that discuss how to work around (and, in some cases, resolve) authentication failures and slowdowns that occur when Windows servers are overloaded by authentication requests. The process to identify and remediate these issues is complex. Review this summary and parts 1, 2, and 3 before you try to change `MaxConcurrentApi`.

> [!IMPORTANT]  
> In most cases, the methods that these articles discuss are workarounds. They relieve the symptoms but don't resolve the underlying issues. The details of these issues depend on the details of your infrastructure.

_Applies to:_ &nbsp; Windows Server 2012 and newer versions, Windows 8 and newer versions

## Symptoms

Users have trouble authenticating, and might encounter many other issues that don't immediately appear to be related to authentication. For example:

- When users try to sign in to applications or services, they might experience behaviors that include the following:
  - Users are repeatedly prompted for credentials even if they use the correct credentials.
  - The authentication process is slower than usual or fails altogether.
- Users have trouble saving files because mapped drives are incorrectly marked as unavailable.
- Users have trouble printing or scanning because mapped printers or other devices are incorrectly marked as unavailable.

The scope and severity of these issues might remain consistent or might fluctuate over time. For example:

- Authentication might slow down or fail completely for all users, or for some users but not others.
- Issue might persist or appear and then disappear.
- Issues might appear only during certain times of day, such as between 8 AM and 9 AM.

In some cases, if you restart the Netlogon service on an application server or a domain controller, the problem might disappear. However, this technique isn't reliable and, at best, provides only temporary relief.

## Cause: Netlogon authentication time-outs

These patterns of symptoms can occur if a significant number of authentication requests fail because they time out.

Under typical conditions, a request for authentication should finish in less than one second. However, the following characteristics of the Netlogon service can cause delays or failures in the authentication process:

- A Windows server or workstation can handle only a certain number of simultaneous authentication requests. This number is known as the `MaxConcurrentApi` value for the computer.
- If an authentication request doesn't receive a response within 45 seconds, it times out.

Consider a simple example: A typical authentication request passes from an application server to a domain controller. Depending on the domain topology, that domain controller might not be able to respond to the request. Instead, it passes the request to a different domain controller. This process repeats until the request reaches a domain controller that can respond. The response follows the same path in reverse until it reaches the application server.

Now consider circumstances where one of the servers in this chain begins receiving more authentication requests than `MaxConcurrentApi` allows it to process. This could be caused by the number of requests increasing, or each request taking longer to resolve. Either way, authentication requests begin to time out. The server now has what's known as a MaxConcurrentApi (MCA) issue (also known as an MCA bottleneck).

## Possible quick solutions

Before you invest time and energy in tracking down and resolving MCA bottlenecks, review the following potential resolutions:

- Make sure that your servers run Windows Server 2012 or a later version of Windows. These versions of Windows have greater `MaxConcurrentApi` values by default, and are less likely to experience MCA bottlenecks than earlier versions are.
- Check your domain name services (DNS) infrastructure and your network connections for errors or inefficient configurations.  
- Use Kerberos authentication wherever possible. As the following diagram shows, the Netlogon service provides functionality to all the authentication methods that Windows supports.  

  :::image type="content" source="./media/maxconcurrentapi-overview-identify-and-remediate-mca-issues/netlogon-service-usage-in-authentication.png" alt-text="Diagram that shows the components that provide the primary Windows authentication functions, and how Netlogon provides underlying functionality for different authentication methods." border="false":::

  However, Kerberos uses Netlogon much more efficiently than other authentication methods do (one time for each ticket that's constructed instead of one time per authentication attempt). You're less likely to encounter MCA bottlenecks when you use Kerberos.
  > [!NOTE]  
  > For more information about this diagram, see [Logon and Authentication Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc780455(v=ws.10)).

## Next steps

- [Remediating MCA issues, part 1: Identify computers that have MCA issues](maxconcurrentapi-1-identify-computers-that-have-mca-issues.md)
