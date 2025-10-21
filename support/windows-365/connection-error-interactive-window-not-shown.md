---
title: Connection Fails with an Interactive Window Could Not Be Shown Error
description: Helps resolve the connection error - an interactive window could not be shown.
manager: dcscontentpm
ms.date: 04/02/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, erikje, v-lianna
ms.custom:
- pcy:Session connectivity\Users see random or intermittent disconnects
- sap:WinComm User Experience
---
# Windows 365 Link connection fails with error "an interactive window could not be shown"

>[!NOTE]
>With the release of Windows 365 Link October Quality Update version 26100.6899, users should no longer encounter this error message for the reasons stated below.  If such an error is encountered first check that Windows 365 Link is on version 26100.6899 or greater. For more information on updating the device, see [Windows 365 Link update behavior and control](/windows-365/link/update-behavior-control). 

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

For configuration details, see [Conditional Access policies for Windows 365 Link](/windows-365/link/conditional-access-policies).

## Missing user action policy

Interactive authentication should occur during the sign-in stage. This commonly requires a new Conditional Access policy because the sign-in only triggers [User actions](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#user-actions) policies to **Register or join devices**, whereas the connection triggers **Resources** policies.

## Conditional Access policy not assigned

If the **User actions** policy exists, confirm if you're in the scope of the assignments of users.

## Mismatched access controls

The sign-in stage generates a security token that is used in the connection stage. If the Conditional Access policies in either stage have the access controls configured differently, an authentication issue might occur. Ensure the access control setting on the **User actions** policy used for the sign-in stage matches (or is stronger than) the setting on the **Resources** policy used for the connection stage.

## Unsupported access controls

A Conditional Access policy applied to resources might use controls that are unavailable for **User actions** policies. Some **Grant** controls, such as device compliance or [custom controls](/entra/identity/conditional-access/controls), can't be used with **User actions** policies. Some **Session** controls, such as **Sign-in frequency**, can't be used with **User actions** policies. If a **User actions** policy applied during the connection stage requires any of these unsupported controls, modifications are required to accommodate the use of Windows 365 Link devices.

## Confirm the problem

Conditional Access sign-in logs can be used to verify how Conditional Access policies are (or aren't) being applied to the sign-in and connection attempts.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) > **Protection** > **Conditional Access** > **Sign-in logs**.
2. Select the **User sign-ins (interactive)** tab and use filters to find entries for the sign-in. For example, try using:

    - **Resource**: **Device Registration Service**
    - **Username**: \<enter the UPN of the user>
    - **Date**: \<select a relevant interval>

3. Select an entry to review if the details are:

    - **Basic info** / **Authentication requirement**: **Single-factor**
    - **Basic info** / **Status**: **Success**
    - **Conditional Access** / **Result**: **Not Applied**

4. Select the **User sign-ins (non-interactive)** tab and use filters to find entries for the connection. For example, try using:

    - **Application**: **Windows 365 Client**
    - **Username**: \<enter the UPN of the user>
    - **Date**: \<select a relevant interval>

5. Expand the results and select an entry to review if the details are:

    - **Basic info** / **Authentication requirement**: **Multifactor**
    - **Basic info** / **Status**: **Interrupted**
    - **Conditional Access** / **Result**: \<any failures occurred>

If you encounter entries similar to the preceding ones, then a combination of those Conditional Access policies likely causes the error.

For configuration details, see [Conditional Access policies for Windows 365 Link](/windows-365/link/conditional-access-policies).
