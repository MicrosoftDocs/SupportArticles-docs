---
title: Error AADSTS530004 - AcceptCompliantDevice Setting Isn't Configured
description: Provides solutions to the AADSTS530004 error when a guest user accesses an application or resource in a resource tenant.
ms.reviewer: laks, custorod, joaos, v-weizhu
ms.service: entra-id
ms.date: 12/16/2024
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS530004 - AcceptCompliantDevice setting isn't configured for this organization

This article discusses scenarios where the AADSTS530004 error occurs when a guest user accesses an application or resource in a resource tenant and provides solutions.

## Symptoms

When a guest user tries to access an application or resource in a resource tenant, the sign-in process fails, and the following error message is displayed:

> AADSTS530004: AcceptCompliantDevice setting isn't configured for this organization. The administrator needs to configure this setting to allow external user access to protected resources.

Additionally, when an administrator reviews the sign-in logs in the home tenant, the same error code is displayed.

## Scenario 1: Conditional Access policy for compliant devices

When a Conditional Access policy in the resource tenant is set with the **Require device to be marked as compliant** control and the policy is applied to guest users, the AADSTS530004 error can occur.

To resolve the error, follow these steps:

1. Create a Cross Tenant Access Policy (XTAP) policy with the [Trust compliant devices](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims) setting in the user's home tenant.

2. Ensure that the guest user's device is authenticated.

    Device authentication might fail under some conditions. For more information, see [Device authentication fails](#device-authentication-fails).

3. Ensure that the guest user's device is joined to Microsoft Intune or supported mobile device management (MDM) solutions in the home tenant and is compliant.

    > [!NOTE]
    > Several third-party device compliance partners are supported for integration with Microsoft Intune. For more information, see [Support third-party device compliance partners in Intune](/mem/intune/protect/device-compliance-partners). For more information about configuring Intune device compliance, see [Monitor results of your Intune Device compliance policies](/mem/intune/protect/compliance-policy-monitor).

## Scenario 2: Conditional Access policy for hybrid-joined devices

When a Conditional Access policy in the resource tenant is set with the **Require Microsoft Entra hybrid joined device** control and the policy is applied to guest users, the error can occur.

To resolve the error, follow these steps:

1. Create an XTAP policy with the [Trust Microsoft Entra hybrid joined devices](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims) setting in the user's home tenant.

2. Ensure that the guest user's device is authenticated.

    Device authentication might fail under some conditions. For more information, see [Device authentication fails](#device-authentication-fails).

3. Ensure that the guest user's device is [Microsoft Entra hybrid joined](/entra/identity/devices/how-to-hybrid-join) in the home tenant.

## Scenario 3: Conditional Access policy for approved client apps

When a Conditional Access policy in the resource tenant is configured with the **Require approved client app** control and the policy is applied to guest users, the error can occur.

This scenario isn't supported. To resolve the error, don't apply this control to guest users.

## Device authentication fails

Device authentication might fail under one of the following conditions:

- When accessing using a browser in InPrivate or Incognito mode.
- When using unsupported browsers or devices, particularly on mobiles.
- When browser cookies are disabled.
- When a desktop or native application doesn't support device authentication or doesn't use Microsoft Authentication Broker.

    For more information about Microsoft Authentication Broker on different device platforms, see the following pages:

    - [Windows](/entra/identity/devices/concept-primary-refresh-token)
    - [Android](/entra/identity-platform/msal-android-single-sign-on#sso-through-brokered-authentication)
    - [iOS](/entra/msal/objc/single-sign-on-macos-ios#sso-through-authentication-broker-on-ios)
    - [macOS, iOS and iPadOS](/entra/identity-platform/apple-sso-plugin)

For more information on supported device platforms, see [Microsoft Entra Conditional Access - Device platforms](/entra/identity/conditional-access/concept-conditional-access-conditions#device-platforms).

To verify whether the device claim is sent, review the sign-in logs for the failed or successful user in the resource tenant:

1. Navigate to the sign-in logs for the user and locate the relevant failure or success event.
2. Under the **Device Info** section, check the **Join type** field. This field indicates the device claim that was passed.

## AADSTS error code reference

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes). To investigate individual errors, search at https://login.microsoftonline.com/error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
