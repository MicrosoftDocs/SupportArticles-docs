---
title: Guidance for Troubleshooting Zero Trust DNS
description: Learn how to troubleshoot Zero Trust DNS (ZTDNS) issues. Get step-by-step guidance for troubleshooting connectivity and configuration issues, and for finding log data.
ms.service: windows-client
ms.reviewer: kaushika, adpatang, v-appelgatet
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.date: 02/12/2026
ms.custom:
- sap:network connectivity and file sharing\dns
- pcy:WinComm Networking
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Zero Trust DNS troubleshooting guidance

This article shows you how to diagnose common connectivity and configuration issues that affect Zero Trust Domain Name System (ZTDNS) services, and how to use ZTDNS logs. The troubleshooting steps in this article help you maintain network security while making sure that legitimate applications and services continue to work correctly.

After you deploy Zero Trust Domain Name System (ZTDNS) services, use this guidance if you experience any of the following symptoms:

- Application connectivity failures
- DNS resolution errors or timeouts
- Unexpected network blocks or service disruptions
- Network access and ZTDNS configuration issues

## Best practices to avoid ZTDNS issues

- **Before you deploy and enforce ZTDNS organization-wide**
  - Test the configuration in audit mode.
  - Deploy and test ZTDNS on pilot devices.

- **Maintaining the ZTDNS deployment**
  - When you add an IP exception, document what exception was made and why.
  - To understand traffic patterns and identify issues early, monitor the Event Viewer logs.
  - To optimize ZTDNS deployment, conduct periodical reviews of the cofiguration and logs.

## Troubleshooting checklist

If you experience connectivity issues after you deploy and enforce ZTDNS, follow these steps.

### Step 1: Verify that the trusted DNS servers are configured correctly

Make sure that at least one trusted DNS server is configured for ZTDNS. Open a Windows Command Prompt window, and then run the following command:

```console
netsh ztdns show server
```

This command displays all the trusted DNS servers that are configured for Zero Trust DNS, including their protocol (DoH or DoT), IP address, and priority settings.

### Step 2: Test the connectivity to the trusted DNS servers

Make sure that client computers can connect to your trusted DNS server. Open a Windows PowerShell window, and then run the following commands:

```powershell
# Test basic connectivity to the DNS server
ping <dns-server-ip>
```

```powershell
# Test DNS resolution using the trusted server
Resolve-DnsName -Name <domain-name> -Server <dns-server-ip>
```

If these commands don't succeed, see [DNS troubleshooting guidance](../../windows-server/networking/troubleshoot-dns-guidance.md).

After these commands run successfully, check the end-to-end connectivity by pinging the resolved IP address.

### Step 3: Test domain name resolution

To use the Windows DNS client to test DNS resolution, go to a client computer, and run the following command at a Windows command prompt:

```console
ping <allowed-domain-name>
```

This command uses the Windows DNS client and trusted DNS server for name resolution, testing both DNS server connectivity and endpoint reachability. Resolve any DNS issues that you find, and then check whether these changes resolve your primary issue. If the issue remains, continue to the more advanced troubleshooting steps.

### Step 4 (Advanced): Review the ZTDNS configuration

To verify your current configuration, run the following commands at a Windows command prompt:

```console
# Check ZTDNS service state
netsh ztdns show state
```

```console
# View all ZTDNS settings in JSON format
netsh ztdns show settings
```

```console
# List configured IP exceptions
netsh ztdns show exception
```

```console
# Display client certificate configuration
netsh ztdns show clientcert
```

```console
# Show trusted certificate authorities
netsh ztdns show trustedca
```

Resolve any issues that you find.

### Step 5 (Advanced): Test connectivity in audit mode

If you suspect configuration issues, temporarily enable audit mode, and then test connectivity when ZTDNS isn't enforced. In audit mode, Windows logs instances in which ZTDNS is expected to block connections if it's fully enforced. To enable audit mode for ZTDNS, run the following command:

```console
netsh ztdns set state enable=yes audit=yes
```

To identify services that need exceptions, review the BlockedConnections log. For more information about how to use this log, see [How to find ZTDNS logs](#how-to-find-ztdns-logs) later in this article.

### Step 6 (Advanced): Disable ZTDNS

If you still can't resolve your primary issue, disable ZTDNS. To disable ZTDNS enforcement and restore normal network connectivity, run the following command:

```console
netsh ztdns set state enable=no audit=no
```

## Common issues and solutions

### Applications can't connect

After you enforce ZTDNS, users experience the following symptoms:

- Applications can't reach external services.
- Network connections time out or destinations refuse connections.
- Normal web browsing works but specific applications fail.

To troubleshoot these issues, follow these steps:

1. Check the BlockedConnections log for recent blocked attempts. For more information about this log, see [How to find ZTDNS logs](#how-to-find-ztdns-logs).
1. Identify the blocked IP addresses that the application and destination use.
1. Check whether the application requires IP exceptions (for example, WebRTC applications require exceptions).
1. To add an exception (if it's necessary), run `netsh ztdns add exception`.

### DNS resolution failures

After you enforce ZTDNS, users experience the following symptoms:

- Applications can't resolve domain names.
- DNS lookup operations time out.
- Applications report DNS errors.

To troubleshoot these issues, follow these steps:

1. To review the trusted DNS server configuration, run `netsh ztdns show server`.
1. To test connectivity to the trusted DNS server, run `ping <dns-server-ip>`.
1. Make sure that the trusted DNS server responds to encrypted queries.

## How to find ZTDNS logs

On Windows devices that're configured to use ZTDNS, you can use Event Viewer to monitor all attempted connections and configuration changes. To locate the ZTDNS logs in Event Viewer, follow these steps:

1. In the Search bar, enter **Event Viewer**, and then select it from the search results.
1. In the left panel of Event Viewer, navigate to **Applications and Service Logs** > **Microsoft** > **Windows** > **ZTDNS**.

The ZTDNS folder lists three log categories. The following table describes the three categories, and how you can use the log information.

| Category | Purpose | Information included | Usage |
| - | - | - | - |
| BlockedConnections | Contains entries that document the connections that ZTDNS blocks. | <ul><li>Time of the blocked connection</li><li>Source IP address and port</li><li>Destination IP address and port</li><li>Name of the initiating process</li></ul> | Review this log to identify applications or services that might need exceptions. |
| Operational | Contains entries that document changes in the ZTDNS configuration and service state. | <ul><li>ZTDNS service status changes</li><li>Configuration changes</li><li>System events that relate to ZTDNS operations</li></ul> | Review this log to monitor the health and configuration of ZTDNS. |
| PermittedConnections | Contains entries that document any connections that ZTDNS allows. | <ul><li>Time of the allowed connection</li><li>Source IP address and port</li><li>Destination IP address and port</li><li>Name of the initiating process</li></ul> | Review this log to verify that ZTDNS allows the expected connections.<br/><br/>**Note:** By default, this category is disabled. To use it, go to the left panel, right-click **PermittedConnections**, and then select **Enable Log**. |
