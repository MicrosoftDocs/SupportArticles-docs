---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title: Error AADSTS530004 –cross Tenant Access Policy(XTAP) Configurations
description: "AADSTS530004: AcceptCompliantDevice setting isn't configured for this organization"
author:      Laks1 # GitHub alias
ms.author:   laks # Microsoft alias
ms.service: identity-platform
ms.topic: troubleshooting-problem-resolution
ms.date:     12/05/2024
ms.subservice: external
---
# Error AADSTS530004 – Cross Tenant Access Policy(XTAP) Configurations

This article provides troubleshooting guidance for resolving error message   "Error AADSTS530004  - AcceptCompliantDevice setting isn't configured for this organization. The administrator needs to configure this setting to allow external user access to protected resources." 

## Symptoms

When a guest user tries to access an application or resource in the resource tenant, the sign-in process fails, and the following error message appears "AADSTS530004: AcceptCompliantDevice setting isn't configured for this organization. The administrator needs to configure this setting to allow external user access to protected resources"

Additionally, when an administrator reviews the sign-in logs in the home tenant, they may see the same error code. 

## Cause 1: Conditional Access Policy for Compliant Devices 

This error occurs when a conditional access policy in the resource tenant is configured to "Require device to be marked as compliant" and the policy applies to guest users.

## Solution

1.	Create an XTAP policy to [Trust Compliant Devices](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims) from the user’s home tenant.

2.	Ensure that device is authenticated.
>[!Note]
>Device authentication may fail under the following conditions:
>•	When accessed in a browser operating in private mode
>•	When using unsupported browsers or devices, particularly on mobile
>•	If cookies are disabled
>For more information on supported devices for mobile devices, please refer to the 
>[Microsoft Entra Conditional Access documentation](/entra/identity/conditional-access/concept-conditional-access-conditions#device-platforms).
>To verify whether the device claim is sent, review the sign-in logs for the failed or successful user in the resource tenant.
>•	Navigate to the sign-in logs for the user and locate the relevant failure or success event.
>•	Under the "Device Info" section, check the "Join type" field. This will indicate the device claim that was passed

3.	Ensure guest user's device is joined to Intune or supported MDM in the home tenant and in a compliant state

>[!Note]
>•	Several third-party device compliance partners have been evaluated and are supported for integration with Microsoft Intune. For more information, please refer to the article:[Device compliance partners in Microsoft Intune](/mem/intune/protect/device-compliance-partners )
>•	For more information on configuring Intune device compliance, refer to the [Create a compliance policy article](/mem/intune/protect/compliance-policy-monitor)

## Cause 2: Conditional Access Policy for Hybrid-Joined Devices

The error can also occur when a conditional access policy in the resource tenant is configured to "Require Microsoft Entra hybrid joined device" and the policy applies to guest users. 

## Solution

1.	Create an XTAP policy to ["Trust Microsoft Entra hybrid joined devices"](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims) from the user’s home tenant.


 2.	Ensure that device is authenticated.

>[!Note]
>Device authentication may fail under the following conditions:
>•	When accessed in a browser operating in private mode
>•	When using unsupported browsers or devices, particularly on mobile
>•	If cookies are disabled
>For more information on supported devices for mobile devices, please refer to the article [Microsoft Entra Conditional Access documentation](/entra/identity/conditional-access/concept-conditional-access-conditions#device-platforms)
>To verify whether the device claim is sent, review the sign-in logs for the failed or successful user in the resource tenant.
>•	Navigate to the sign-in logs for the user and locate the relevant failure or success event
>•	Under the "Device Info" section, check the "Join type" field. This will indicate the device claim that was passed.

3.	Ensure guest user's device is [Microsoft Entra hybrid joined](/entra/identity/devices/how-to-hybrid-join) in the home tenant.


## Cause 3: Conditional Access Policy for Require approved client app 

The error can also occur when a conditional access policy in the resource tenant is configured to " Require approved client app" and the policy applies to guest users. 


## Solution

The **Require approved client app** control is not supported for guest users and such control should not be applied to them. 


## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

To investigate individual errors, go to https://login.microsoftonline.com/error.

