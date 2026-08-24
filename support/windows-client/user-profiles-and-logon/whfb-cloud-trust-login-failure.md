---
title: Troubleshoot Windows Hello for Business sign-in on captive-portal Wi-Fi
description: Troubleshoot Windows Hello for Business sign-in failures on captive-portal Wi-Fi networks. Learn steps and workarounds for hotel, airport, and conference networks.
ms.date: 08/21/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: jushua
ai-usage: ai-assisted
ms.custom:
- sap:user logon and profiles\user profiles
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Troubleshoot Windows Hello for Business sign-in on captive-portal Wi-Fi

## Summary

Windows Hello for Business (WHfB) with cloud trust sign-in can fail on captive-portal Wi-Fi networks, such as hotel, airport, or conference networks that require browser-based authentication before granting internet access. In affected scenarios, the sign-in process can appear to hang for approximately two minutes before failing with authentication errors.

This article helps you identify whether your sign-in issues are related to captive-portal network behavior and provides workarounds while a permanent solution is being developed.

## Troubleshooting checklist

Use the following steps to determine if your Windows Hello for Business sign-in failures are related to captive-portal Wi-Fi networks:

1. Attempt to sign in with Windows Hello for Business on the captive-portal Wi-Fi network and note the behavior. Does the sign-in screen remain active for approximately 2 minutes before failing?

1. Check Event Viewer for relevant error events. Open Event Viewer and go to **Windows Logs** > **Security** and **Applications and Services Logs** > **Microsoft-Windows-HelloForBusiness** > **Operational**. Look for the events described in the Symptoms section.

1. Try signing in again on the same network. Do sign-in attempts succeed intermittently, or do they consistently fail?

1. Switch to a different network connection (such as mobile hotspot or wired connection) and attempt sign-in with Windows Hello for Business. Does sign-in succeed on the alternative network?

1. If sign-in succeeds on an alternative network but fails on the captive-portal network, and you observe the symptoms described in the following section, the issue is likely related to captive-portal network behavior.

## Symptoms: Event ID 4625 and Event ID 7001

When you use Windows Hello for Business on a captive-portal Wi-Fi network, you might experience one or more of the following symptoms:

* After you sign in successfully by using WHfB with Cloud Trust, the sign-in screen stays active for about two minutes and then fails.

* Sign-in attempts on the same network might succeed intermittently, depending on timing and network behavior.

* The following events appear in Event Viewer:

  **Security Event ID 4625**

  | Field | Value |
  |-------|-------|
  | Log Name | Security |
  | Source | Microsoft-Windows-Security-Auditing |
  | Event ID | 4625 |
  | Task Category | Logon |
  | Level | Information |
  | Keywords | Audit Failure |
  | Failure Reason | Unknown user name or bad password |
  | Status | 0xC000005E |
  | Sub Status | 0x0 |
  | Authentication Package | Negotiate |

   **Windows Hello for Business Event ID 7001**

  | Field | Value |
  |-------|-------|
  | Log Name | Microsoft-Windows-HelloForBusiness/Operational |
  | Source | Microsoft-Windows-HelloForBusiness |
  | Event ID | 7001 |
  | Task Category | Logon |
  | Level | Error |
  | Credential Type | Software Key |
  | Deployment Type | Cloud |

* Internal failure codes might include:
  * 0xC0070022
  * 0xC000005E

These failures occur when captive-portal network behavior delays Microsoft Entra ID authentication traffic.

## Cause: timeout mismatch between CloudAP and Windows Hello for Business

This issue occurs because of a timing mismatch between two Windows authentication components operating independently during sign-in.

### Cloud Authentication Provider behavior on captive-portal networks

On captive-portal Wi-Fi networks, you might block or silently delay outbound HTTPS traffic to Microsoft Entra ID sign-in endpoints, such as `login.microsoftonline.com`, until the user completes the captive portal authentication page. For some captive-portal Wi-Fi networks, DNS queries receive replies that Windows treats as indicating the endpoints are reachable.

In affected cases, TCP connections don't immediately fail. Instead, connection attempts time out and retry. During this period, the Cloud Authentication Provider (CloudAP) continues retry operations related to pre-logon token exchange. Each attempt to one endpoint typically consumes around 21 seconds before proceeding further. If you must try more than six endpoints, CloudAP spends approximately 126 seconds before authentication traffic finally fails on the captive-portal network.

### Windows Hello for Business ticket timeout

After Windows Hello for Business validates the token locally, the Key Storage Provider service (`kspsvc`) caches the authentication ticket and starts a fixed 120-second timeout window. The cached ticket remains valid only until the operating system signals that the interactive sign-in process is complete through the `WTS_SESSION_LOGON` notification. If Windows doesn't receive this notification before the timeout expires, Windows Hello for Business clears the cached token and the sign-in operation fails.

### Why the sign-in fails

On affected captive-portal networks, the following sequence causes sign-in to fail:

* CloudAP authentication recovery can take longer than 120 seconds.
* Windows Hello for Business expires the cached PIN ticket at exactly 120 seconds.
* The interactive logon completion notification isn't delivered until CloudAP finishes authentication processing.

As a result, the WHfB token expires before the sign-in process completes, causing the logon failure.

## Potential quick workarounds

### Workaround 1: Switch to Airplane mode before signing in

If the target captive-portal Wi-Fi network is known to reproduce the timeout symptom, switch to airplane mode before attempting a Windows Hello for Business sign-in.

### Workaround 2: Retry sign-in using other authentication methods

If sign-in fails, wait briefly and try again. You can use your password as an alternative authentication method.

### Workaround 3: Use a targeted hosts file workaround

In some validated scenarios, adding static `hosts` file entries for `login.microsoftonline.com` and related Microsoft Entra ID sign-in endpoints reduced captive-portal DNS interception delays enough for sign-in to complete successfully.

> [!IMPORTANT]
> **Considerations:**
>
> * This workaround is intended only for specific, documented network environments.
> * Microsoft doesn't recommend this approach as a general deployment policy.
> * Static IP mappings can stop working if Microsoft updates or rotates endpoint IP addresses.
> * This approach can complicate troubleshooting and support for roaming or traveling users.

Use this workaround only after evaluating operational and support impacts.

## More information

This issue is currently tracked internally as a timeout-budget mismatch between:

* CloudAP recovery behavior on degraded or captive-portal networks.
* The fixed 120-second Windows Hello for Business PIN ticket timeout.

At the time of publication:

* No supported client-side registry modification or configuration change is available to resolve the issue.
* No confirmed product fix or design change has been released.
* The issue primarily affects fresh interactive sign-ins on captive-portal Wi-Fi networks.

Windows Hello for Business and Microsoft Entra ID connectivity depend on reliable access to Microsoft authentication endpoints during sign-in. Networks that delay or intercept outbound authentication traffic can affect the Windows sign-in experience.
