---
title: Troubleshoot single sign-on and Conditional Access for Azure Virtual Desktop
description: Resolve frequent sign-in prompts, multifactor authentication loops, and Conditional Access errors when using single sign-on with Azure Virtual Desktop.
ms.topic: troubleshooting
ms.date: 06/25/2026
ms.reviewer: kaushika, azarj
ms.custom: 
- sap: Authenticating to Azure Virtual Desktop\Using Single Sign-On with Azure virtual Desktop
- pcy: wincomm-user-experience
---

# Troubleshoot single sign-on and Conditional Access for Azure Virtual Desktop

## Summary

This article helps you resolve common single sign-on (SSO) and Conditional Access issues in Azure Virtual Desktop, including frequent sign-in prompts, multifactor authentication loops, and authentication failures.


## Before you begin

Confirm the following items before troubleshooting:

- SSO is enabled on the host pool. See [Configure single sign-on](/azure/virtual-desktop/configure-single-sign-on?context=/azure/virtual-desktop/context/context).
- The Azure Virtual Desktop app (`9cdead84-a844-4324-93f2-b2e6bb768d07`) and Windows Cloud Login app (`270efc09-cd0d-444b-a71f-39af4910ec45`) exist in your tenant.
- Per-user multifactor authentication is **disabled** for Azure Virtual Desktop users. Use Conditional Access policies exclusively. See [Microsoft Entra joined session host VMs](/azure/virtual-desktop/set-up-mfa?context=/azure/virtual-desktop/context/context#microsoft-entra-joined-session-host-vms).

## Symptom: Frequent or repeated sign-in prompts

> [!NOTE]
> Users are prompted to sign in multiple times during a single connection, or are reprompted shortly after connecting.

### Cause 1: Sign-in frequency mismatch during Windows App user experience

The Azure Virtual Desktop app and Windows Cloud Login app each have their own Conditional Access policies and sign-in frequency. If the frequencies differ, one app's session expires before the other and triggers a reauthentication prompt during the Windows App user experience.

### Resolution

1. In the Microsoft Entra admin center, open each Conditional Access policy that targets the Azure Virtual Desktop or Windows Cloud Login app.
1. Set sign-in frequency to the same value on both, or set the Windows Cloud Login policy to match or exceed the Azure Virtual Desktop policy.
1. The **Every time** sign-in frequency option is supported only on the Windows Cloud Login app. Don't apply it to the Azure Virtual Desktop app. Doing so causes constant prompts on feed refresh and diagnostics upload.

### Cause 2: Per-user multifactor authentication enabled alongside Conditional Access

When legacy per-user multifactor authentication is enabled on an Entra-joined session host alongside Conditional Access, users see "The sign-in method you're trying to use isn't allowed" or repeated prompts.

### Resolution

1. In the Microsoft Entra admin center, go to **Identity** > **Users** > **All users**, and then select **Per-user MFA** from the toolbar.
1. For each Azure Virtual Desktop user, set the multifactor authentication state to **Disabled**.
1. Enforce multifactor authentication through Conditional Access policies instead.

### Cause 3: Conditional Access policy missing for the Windows Cloud Login app

If only the Azure Virtual Desktop app has a Conditional Access policy, the user is prompted for multifactor authentication at the Azure Virtual Desktop service layer and again at the session host SSO layer.

### Resolution

Add a separate Conditional Access policy that targets the Windows Cloud Login app. See [Recommended Conditional Access policy structure](/azure/virtual-desktop/set-up-mfa?context=/azure/virtual-desktop/context/context#recommended-conditional-access-policy-structure).

### Cause 4: Consent prompt not hidden

If the per-user consent prompt isn't hidden, users see an interactive consent dialog on first connection to each session host, which appears similar to a sign-in prompt.

### Resolution

See [Hide the consent prompt dialog](/azure/virtual-desktop/configure-single-sign-on?context=/azure/virtual-desktop/context/context#hide-the-consent-prompt-dialog).


## Authentication errors at connection time

### Symptom: User strong authentication registration required

The user isn't registered for multifactor authentication.

### Resolution

Have the user register at [https://aka.ms/mfasetup](https://aka.ms/mfasetup), or enroll them through Conditional Access [registration campaigns](/entra/identity/authentication/how-to-mfa-registration-campaign).

### Symptom: AADSTS50058: SSO session not found or invalid

The client doesn't have an active Microsoft Entra session, or the existing session can't be used to satisfy the request.

### Resolution

1. Have the user sign out of the Windows App and sign in again.
1. If the issue persists, clear the Web Account Manager cache on the client device.

### Symptom: AADSTS50076: Multifactor authentication required by Conditional Access or per-user enforcement

Multifactor authentication is required (by Conditional Access policy or per-user enforcement) but wasn't satisfied for this request.

### Resolution

1. Confirm the user has a registered multifactor authentication method.
1. Check whether the connection is coming from a network or device that satisfies the Conditional Access conditions (named locations, compliant device, and so on).
1. If per-user multifactor authentication is enabled, disable it and rely on Conditional Access. See **Cause 2** in the preceding section.

### Symptom: AADSTS530002: Device not compliant

A Conditional Access policy requires a compliant device, and the device you used to satisfy the policy isn't compliant. The fix depends on **which** Conditional Access policy is failing and which device the requirement applies to.

### Resolution

1. In the Microsoft Entra admin center, open the sign-in log entry for the failed sign-in and select the **Conditional Access** tab. Identify which policy reported **Failure** and which app it targets (Azure Virtual Desktop or a downstream Microsoft 365 / data app).
1. **If the failing policy targets the Azure Virtual Desktop or Windows Cloud Login app** (the connection-time policy): the compliance requirement applies to the **client device** you connect from, not the session host. Either onboard the client device into Microsoft Intune and make it compliant, or exclude that device population from the policy.
1. **If the failing policy targets a Microsoft 365 or other data app accessed from inside the session** (an in-session policy): the compliance requirement applies to the **session host**. Either onboard the session host into Microsoft Intune and enroll it in the relevant compliance policy, or exclude session hosts from that policy by device filter.
1. Most Azure Virtual Desktop deployments shouldn't apply user-device compliance policies to session hosts at connection time. Scope connection-time compliance to client endpoints.

### Symptom: AADSTS530032: Blocked by tenant security policy

A tenant-level security control is blocking the sign-in. This control can be Security Defaults, a Conditional Access policy that blocks access, or another tenant-level restriction. It's not exclusively Security Defaults.

### Resolution

1. In the Microsoft Entra admin center, go to **Identity** > **Overview** > **Properties** and confirm whether Security Defaults are enabled. If they're enabled and you need Conditional Access, [disable Security Defaults](/entra/fundamentals/security-defaults#disabling-security-defaults).
1. Review all Conditional Access policies that apply to the Azure Virtual Desktop and Windows Cloud Login apps. Identify any policies with **Grant** set to **Block access** that you fall within scope of.
1. Use the **Conditional Access** tab in the sign-in log entry to see exactly which policy blocked the request.

### Symptom: AADSTS65001: Consent required

The user or admin didn't consent to the application.

### Resolution

Hide the consent prompt as described in [Hide the consent prompt dialog](/azure/virtual-desktop/configure-single-sign-on?context=/azure/virtual-desktop/context/context#hide-the-consent-prompt-dialog), or grant admin consent for the Windows Cloud Login app.

### Symptom: Sign-in works but session lock causes reprompts

After the session locks (manually or by idle timeout), the user must reauthenticate with full credentials instead of just unlocking.

> [!NOTE]
> The session lock behavior isn't configured to disconnect on lock.

### Resolution 

See [Configure session lock behavior](/azure/virtual-desktop/configure-session-lock-behavior?context=/azure/virtual-desktop/context/context). Configure the host pool so that locking the session disconnects it. The user can then reconnect using SSO without reentering credentials.


## Diagnose using the sign-in logs

For any sign-in issue:

1. In the Microsoft Entra admin center, go to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Filter by the affected user.
1. Look for entries for the **Azure Virtual Desktop** app and the **Windows Cloud Login** app within the failure timeframe.
1. For each failed entry:
   - Note the **Sign-in error code** (AADSTS*).
   - On the **Conditional Access** tab, see which policies evaluated and which (if any) blocked.
   - On the **Authentication Details** tab, see which authentication method was used or required.

## Related content

- [Configure single sign-on for Azure Virtual Desktop using Microsoft Entra ID](/azure/virtual-desktop/configure-single-sign-on?context=/azure/virtual-desktop/context/context)
- [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa?context=/azure/virtual-desktop/context/context)
- [Configure session lock behavior](/azure/virtual-desktop/configure-session-lock-behavior?context=/azure/virtual-desktop/context/context)
- [Microsoft Entra authentication error codes](/entra/identity-platform/reference-error-codes)
