---
title: Connection Fails With Error "an Interactive Window Could Not Be Shown"
description: Helps resolve the connection error "an interactive window could not be shown."
manager: dcscontentpm
ms.date: 04/01/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, erikje, v-lianna
ms.custom: sap:Authentication, intune-azure, get-started
ms.collection:
- M365-identity-device-management
- tier2
---
# Connection fails with error "an interactive window could not be shown"

This article helps resolve the connection error "an interactive window could not be shown."

After you authenticate on the sign-in screen, you might encounter the following error message when connecting to your Cloud PC:

> Something went wrong.  
An authentication issue occurred where an interactive window could not be shown. Please try again later.

The connection attempts via Windows 365 Link use non-interactive single sign-on and can't prompt for user authentication. If you see this error, Windows 365 resources might be protected by a Conditional Access policy that requires interactive authentication. For more information, see [Set Conditional Access policies for Windows 365](/windows-365/enterprise/set-conditional-access-policies).

The common causes of this error are:

- Missing user action policy
- Conditional Access policy not assigned
- Mismatched access controls
- Unsupported access controls

For more information about the configuration details, see [Conditional Access policies for Windows 365 Link](/windows-365/link/conditional-access-policies).

## Missing user action policy

Interactive authentication should occur during the sign-in stage. This commonly requires a new Conditional Access policy because the sign-in only triggers [User actions](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#user-actions) policies to **Register or join devices**, where the connection triggers **Resources** policies.

## Conditional Access policy not assigned

If the **User actions** policy exists, confirm if you're in the scope of the users assignments.

## Mismatched access controls

The sign-in stage generates the security token that is used in the connection stage. If the Conditional Access policies in either stage have the access controls configured differently, an authentication issue might occur. Ensure the access controls setting on the **User actions** policy used for the sign-in stage matches (or is stronger than) the setting on the **Resources** policy used for the connection stage.

## Unsupported access controls

A Conditional Access policy applied to resources might use controls unavailable for **User actions** policies. Some **Grant** controls such as device compliance or [custom controls](/entra/identity/conditional-access/controls) can't be used with **User actions** policies. Some **Session** controls such as **Sign-in frequency** can't be used with **User actions** policies. If a **User actions** policy applied during the connection stage requires any of these unsupported controls, modifications are required to accommodate the use of Windows 365 Link devices.

## Confirm the problem

Conditional Access sign-in logs can be used to verify how Conditional Access policies are (or aren't) being applied to the sign-in and connection attempts.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) > **Protection** > **Conditional Access** > **Sign-in logs**.
2. Select the **User sign-ins (interactive)** tab, and use filters to find entries for the sign-in. For example, try using:

    - **Resource**: **Device Registration Service**
    - **Username**: \<enter the UPN of the user>
    - **Date**: \<select a relevant interval>

3. Select an entry to review if the details are:

    - **Basic info** / **Authentication requirement**: **Single-factor**
    - **Basic info** / **Status**: **Success**
    - **Conditional Access** / **Result**: **Not Applied**

4. Select the **User sign-ins (non-interactive)** tab, and use filters to find entries for the connection. For example, try using:

    - **Application**: **Windows 365 Client**
    - **Username**: \<enter the UPN of the user>
    - **Date**: \<select a relevant interval>

5. Expand the results and select an entry to review if the details are:

    - **Basic info** / **Authentication requirement**: **Multifactor**
    - **Basic info** / **Status**: Interrupted
    - **Conditional Access** / **Result**: \<any failures occur>

If you encounter entries similar to the preceding ones, then it's likely the combination of those Conditional Access policies are the cause of the error.

For more information about the configuration details, see [Conditional Access policies for Windows 365 Link](/windows-365/link/conditional-access-policies).
