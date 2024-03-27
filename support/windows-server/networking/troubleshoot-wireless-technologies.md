---
title: Guidance for troubleshooting wireless technology issues
description: Learn how to troubleshoot scenarios related to wireless technologies
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Network Connectivity and File Sharing\Network Load Balancing (NLB), csstroubleshoot
keywords: wireless connection, dropped connection, wireless authentication
---

# Wireless technology troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806441" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Wireless technology issues.

Wireless connections involve many different Windows components, as well as third-party devices and software. For example, Microsoft doesn't make access points or switches. Because wireless connectivity isn't an end-to-end Microsoft solution, you have to identify where the problem is, and in many cases another vendor has to fix it.

## Emerging and known issues

The Windows release health page is designed to inform you about known issues so you can troubleshoot known issues your users may be experiencing in your organization. See [Windows release health page](https://admin.microsoft.com/adminportal/home?#/windowsreleasehealth) in the Microsoft 365 admin center. The admin center is available to customers who have a Microsoft 365 subscription.

## Troubleshooting a WIFI connection that fails to establish

There are a wide range of causes for connection failures. Use the following sections to narrow down the cause of your particular issue.

### Step 1: Identify the type of failure

The answers to the following questions may help you to isolate the affected clients and other affected components:

1. Do all clients fail to connect, or only certain clients? If only certain clients are affected, what are the common factors? For example, do the clients use the same network interface controller (NIC) vendor or versions, operating system (OS) release, build, or installed software and drivers?

1. Is the failing connection a manual connection, or an auto-connect connection?
1. Does the connection fail to establish at all? Or does the connection establish, and then drop?
1. Do the affected clients share specific components, such as a particular wireless Service Set Identifier (SSID) or a particular access point (AP)?

### Step 2: Rule out common causes of connection failures

Components such as services, connection managers, group policy, or updates can cause connection problems. To determine if any of these causes apply, follow these steps on an affected client. After each step, try to connect again.

1. Restart the WLAN Autoconfig Service (WlanSvc).

1. Uninstall any third-party connection managers.
1. Turn off all group policy on the client.
1. Make sure the most recent update package is installed. For more information about current update rollups, see [Windows 10 update history](https://support.microsoft.com/topic/windows-10-update-history-857b8ccb-71e4-49e5-b3f6-7073197d98fb) or [Windows 11 update history](https://support.microsoft.com/topic/windows-11-update-history-a19cd327-b57f-44b9-84e0-26ced7109ba9).

For more troubleshooting instructions and information about how connections establish, see [Advanced troubleshooting wireless network connectivity: Troubleshooting](/windows/client-management/advanced-troubleshooting-wireless-network-connectivity#troubleshooting).

## Troubleshooting an 802.1X authentication failure

Follow these steps to narrow down possible causes of an 802.1X authentication failure.

1. What type of authentication is being used? Examples include PEAP-MSCHAPv2, EAP-TLS, and so on.

1. Is Credential Guard configured?  
   > [!NOTE]  
   > MSCHAP(v2) cannot work with Credential Guard enabled. For more information, see [How Credential Guard works](/windows/security/identity-protection/credential-guard/credential-guard-how-it-works).
1. Does the 802.1X policy require user or computer authentication?
1. What type of RADIUS server does your environment use? Examples include Network Policy Server (NPS) from Microsoft, Access Control Server (ACS) from Cisco, and so on.
1. How is the wireless connection deployed to clients? Examples include Group Policy, Mobile Device Management, command line (NETSH) and XML profiles, or manual distribution.
1. Are all clients affected, or only certain clients? If only certain clients are affected, what are the common factors? For example, do the affected clients use the same NIC vendor or versions, OS release, build, installed software or drivers, or Active Directory organizational unit (OU) placement?
1. Does the wireless access point use SSID suppression? For example, is the network hidden?
1. If you use certificate-based authentication, how do you deploy the certificate? Check the client's Trusted Root Certification Authorities list and make sure that it includes the correct root Certification Authority (CA) certificate.
1. Do you use Windows Certification Authority? If yes, is that an enterprise CA or a standalone CA?

For more information about the flow of authentication for wireless connections and for more detailed troubleshooting, see [Advanced troubleshooting 802.1X authentication: Troubleshooting](/windows/client-management/advanced-troubleshooting-802-authentication#troubleshooting).

## References

- [Advanced troubleshooting for wireless network connectivity](/windows/client-management/advanced-troubleshooting-wireless-network-connectivity)
- [Advanced troubleshooting 802.1X authentication](/windows/client-management/advanced-troubleshooting-802-authentication)
- [Data collection for troubleshooting 802.1X authentication](/windows/client-management/data-collection-for-802-authentication)
