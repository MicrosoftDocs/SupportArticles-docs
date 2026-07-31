---
title: Diagnose issues with the "Paste to browsers" activity in Endpoint DLP
description: Describes the process to identify why the Paste to supported browsers activity in Endpoint DLP doesn't audit or block sensitive data as expected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:EndPoint DLP
  - Microsoft Purview
  - CSSTroubleshoot
ms.reviewer: sathyana
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 07/27/2026
ai usage: ai-assisted
---

# Diagnose issues with the "Paste to supported browsers" activity in Endpoint DLP

## Summary

This article describes how to determine why the Paste to supported browsers activity in Microsoft Purview Endpoint Data Loss Prevention (DLP) doesn't behave as expected. For example, when sensitive data isn't blocked when it's pasted into Google Chrome or when paste actions into Microsoft Edge aren't audited.

The Paste to supported browsers activity evaluates the content in the clipboard at the moment it's pasted into a supported browser. The activity evaluates the pasted content independently of the source file's classification, and applies an action, such as **Audit**, **Block with override**, or **Block**, based on the destination website.

## Prerequisites

Before you troubleshoot policy logic, make sure that your environment meets the following requirements.

| Requirement | Details |
|---|---|
| Licensing | Microsoft 365 E5 or A5, Microsoft 365 E5 Compliance, or Microsoft 365 E5 Information Protection and Governance. |
| Operating system | Windows 10 version 1809 or a later version, Windows 11, or one of the three latest released versions of macOS. |
| Device onboarding | The device is onboarded to Microsoft Defender for Endpoint and Endpoint DLP and shows healthy onboarding and policy sync status in the Microsoft Purview portal. |
| Supported browser | The browser is supported for the operating system. For more information, see [Supported browsers](#supported-browsers). |
| Policy scope | The signed-in user or device is in scope of the DLP policy's **Devices** location. |

For more information, see [Get started with Endpoint data loss prevention](/purview/endpoint-dlp-getting-started#before-you-begin).

## Requirements for the Paste to supported browser activity to work

Two design points might cause many Paste to supported browser misconfigurations. Review them before you troubleshoot a policy.

### Sensitive service domain groups

The Paste to browser activity requires rules that are configured to work with Sensitive service domain groups. The activity isn't supported with the flat Service domains Endpoint DLP setting. The standalone Service domains list governs other activities, such as upload to cloud, and doesn't affect the Paste to supported browser activity.

> [!IMPORTANT]
> Add your target websites to a Sensitive service domain group by going to **Settings** > **Data Loss Prevention** > **Endpoint settings** > **Browser and domain restrictions to sensitive data** > **Sensitive service domain groups**. Then, reference that group in the rule's **Paste to supported browsers** action. Adding websites only to the flat **Service domains** list doesn't work for the Paste to supported browser activity.

### Advanced classification is not supported

Content that is evaluated for a paste action is classified locally. Sensitive information types (SITs) that depend on advanced classification, Exact Data Match (EDM), named entities, trainable classifiers, and credential classifiers don't trigger on a paste action even when they're configured correctly.

> [!NOTE]
> For Paste to browser rules, use standard SIT patterns, such as regular expressions, keywords, functions, credit card numbers, Social Security numbers, or custom keyword dictionaries. If your rule relies on EDM or a trainable classifier, the paste action isn't blocked. This behavior is by design.

### Supported browsers

| Browser | Windows | macOS |
|---|---|---|
| Microsoft Edge | Supported natively. No extension is required. | Supported natively. No extension is required. |
| Google Chrome | Supported with the [Microsoft Purview extension](/purview/dlp-chrome-get-started). | Supported natively. No extension is required. |
| Mozilla Firefox | Supported with the [Microsoft Purview extension](/purview/dlp-firefox-extension-get-started). | Supported natively. No extension is required. |
| Safari | Not applicable. | Supported natively. |

> [!NOTE]
> The Microsoft Purview browser extension for Chrome and Firefox is Windows-only. On macOS, Edge, Chrome, Firefox, and Safari are supported natively without an extension. If you want to stop users from pasting in unsupported browsers, use the **Unallowed browsers** setting.

## Test and validate

1. Paste known sensitive test content into a supported browser on an in-scope device, and then observe whether the expected action occurs, such as block, override prompt, or audit.
2. Confirm that the event appears in Activity Explorer with the expected policy and rule.
3. Repeat the test across each supported browser that you intend to protect. Retest after any browser or operating system update.

If all the prerequisites and requirements for the Paste to supported browser activity are met but you're still seeing issues, use the information in one of the following scenarios that best corresponds to your issue.

## Scenario A: Sensitive data isn't blocked or audited

Symptoms include the following behavior:

- Pasting sensitive content into Edge or Chrome doesn't produce a block or override prompt.
- No paste event appears in Activity Explorer.

Work through the following checks in order.

### Verify the DLP rule and action

1. In the Microsoft Purview portal, go to **Solutions** > **Data Loss Prevention** > **Policies**, and then open the relevant policy.
2. Confirm that the **Devices** location is selected and scoped to the affected user or device.
3. Under **Actions** > **Audit or restrict activities on devices**, confirm that **Paste to supported browsers** is enabled with the intended action, such as **Audit**, **Block with override**, or **Block**.
4. Confirm that the rule conditions, such as **Content contains** > **Sensitive info types**, match the data that you're testing.

### Review the Sensitive Information Types

- Confirm that the SIT actually matches your test content, including occurrence count and confidence level. To test a SIT, go to **Solutions** > **Data Loss Prevention** > **Classifiers** > **Sensitive info types**, select the SIT, and then select **Test**.
- Confirm that the DLP rule uses the **Content contains** > **Sensitive Information Types** condition. Paste to browser is supported only when the rule uses this condition. If the rule uses a different condition, the Paste to browser action doesn't trigger.
- Confirm that the SIT doesn't rely on advanced classification, such as EDM, named entities, trainable classifiers, or credential classifiers. These classifiers don't trigger on paste actions. For more information, see the [Advanced classification is not supported](#advanced-classification-is-not-supported) section of this article.
### Use a Sensitive service domain group

This configuration is the most common cause of Paste to browser issues.

- Confirm that the destination website is added to a Sensitive service domain group and that the group is referenced in the rule's **Paste to supported browsers** action.
- Confirm that the website isn't relying on the flat **Service domains** list. That list doesn't affect the Paste to supported browsers activity. For more information, see the [Sensitive service domain groups](#sensitive-service-domain-groups) section of this article.
- URLs in a Sensitive service domain group support wildcards, such as asterisks (`*`). Confirm that the pattern matches the destination URL.

### Check the global Service domains action

> [!IMPORTANT]
> Even when enforcement is driven through Sensitive service domain groups, leave the global **Service domains** action in **Endpoint settings** > **Browser and domain restrictions to sensitive data** set to **Block**. Setting it to **Allow** can cause the policy to behave erratically.

### Confirm the supported browser and extension

- Confirm that the test browser is supported for the operating system. For more information, see the [Supported browsers](#supported-browsers) section of this article.
- On Windows, confirm that the Microsoft Purview extension is installed, enabled, and up to date for Chrome and Firefox. If the extension is missing, deploy or update it by using Microsoft Intune or Group Policy.
- On macOS, no extension is required. If the issue still occurs, retest in another supported browser to isolate a browser-specific failure.

### Allow for policy sync latency

- A newly created or edited policy can take up to approximately 60 minutes to sync to onboarded devices.
- Changes to user or group membership can take approximately 24 hours to come into policy scope.
- An offline device receives updated policy only after it reconnects to the internet.

### Verify device and endpoint integration

- Confirm that the device is onboarded to Microsoft Defender for Endpoint and syncing Microsoft Purview DLP policy.
- Run the MDE Client Analyzer and check event logs for sync or agent errors. For more information, see [Diagnostics to collect](#diagnostics-to-collect).

## Scenario B: The policy is configured correctly but behaves unexpectedly

Use this scenario when the policy fires, but the user experience or evidence doesn't look right.

### Block with override or policy tip doesn't appear

- Confirm that **User notifications** are enabled in the rule, and that the policy tip text and override options, such as business justification, are configured.
- Confirm that the action is **Block with override**, not **Block**, if you expect users to be able to override.
- Allow for policy sync latency before you conclude that the notification is broken.

### Source file shows random or garbled characters in alert evidence

> [!IMPORTANT]
> If evidence collection for file activities is enabled and the device's Antimalware Client Version is earlier than 4.18.23110, the source file in alert details can display random characters. Update the antimalware client. In the meantime, download the file to view the actual text.

If **Document could not be scanned** is the action for the matched rule, the evidence file isn't captured.

### macOS enforcement fails silently

- Browser-level DLP on macOS can stop working after an operating system update if the system extension breaks, even when the Microsoft Purview portal still shows the device as healthy.
- After every macOS update, revalidate paste enforcement in each supported browser.
- Confirm that the Microsoft Defender system extension is approved and running on the device.

If the issue isn't resolved after you perform all the checks, collect diagnostics and other required evidence, and then contact Microsoft Support.

## Diagnostics to collect

Gathering the right data first resolves most cases and speeds up the cases that require escalation. On Windows, the recommended path is Always-on diagnostics because it removes the need to reproduce the issue.

### Always-on diagnostics

[Always-on diagnostics for endpoint DLP](/purview/dlp-always-on-diagnostics) continuously collects Endpoint DLP trace logs in the background, such as policy-evaluation logs, classification results, enforcement actions, and error states. It stores the logs locally on the device in a secure, compressed format for up to 90 days. Because the data is already captured, you usually don't have to reproduce the paste failure or involve the end user.

> [!NOTE]
> As of mid-April 2026, Always-on diagnostics (AOD) is enabled by default on onboarded Windows devices. Admins can opt out. Before you troubleshoot, confirm that AOD is still enabled for your tenant.

To enable or confirm AOD, go to the Microsoft Purview portal > **Settings** > **Data Loss Prevention** > **Always-on diagnostics**.

- **Always-on diagnostics for endpoint DLP** turns on background local log collection on devices.
- **Collect and upload diagnostics from an endpoint device** lets you remotely request logs from a specific device and have them uploaded directly to Microsoft for a support case.

To request logs for a support case, use the Always-on diagnostics settings page to request collection for the affected device. You can track upload status on the same page.

The upload typically completes within an approximately 24-hour polling window, and the device must remain online. Only one active collection request is supported per device at a time.

To use AOD, you need one of the following permissions:

- An Entra ID role, such as Compliance Administrator, Security Administrator, or Global Administrator. Use the least-privileged role that meets your need.
- A tenant-level Microsoft Purview role, such as InformationProtectionAdmin, InformationProtectionAnalyst, or InformationProtectionInvestigator. Scoped admins aren't supported.

> [!IMPORTANT]
> AOD is supported only on Windows 10, Windows 11, and Windows Server. For servers, enable Endpoint DLP for onboarded servers first. Logs are stored in a proprietary format that admins can't download directly. The logs are decoded only by Microsoft. Uploaded data stays within the tenant's data-residency region and is retained for 180 days unless it's manually deleted earlier. For macOS, use the MDE Client Analyzer.

### MDE Client Analyzer

Use the Microsoft Defender for Endpoint (MDE) [Client Analyzer](/defender-endpoint/overview-client-analyzer) when AOD is disabled, when you want an on-demand capture, or on macOS where AOD isn't supported.

1. Download and extract the MDE Client Analyzer on the affected device.
2. From an elevated command prompt, run the following command:

   ```cmd
   MDEClientAnalyzer.cmd -t
   ```

   The `-t` switch enables DLP tracing.

3. Reproduce the paste action.
4. Press `q` to stop collection and then provide the file path when you're prompted.
5. Share the resulting MDEClientAnalyzerResult.zip file with Microsoft Support.

### Other evidence to gather

- **Activity Explorer**: Go to **Solutions** > **Data Loss Prevention** > **Activity explorer**. Confirm whether the paste event was detected and which policy or rule matched.
- **Antimalware client version**: Confirm that the version is 4.18.23110 or a later version. This check is relevant to evidence collection.
- **Simulation mode**: Run the policy in simulation mode first, and then review Activity Explorer to confirm expected matches before enforcing.
- **Environment details**: Collect the operating system and version, browser and version, extension status for Windows Chrome or Firefox, policy name, rule name, and exact SIT that's used.
