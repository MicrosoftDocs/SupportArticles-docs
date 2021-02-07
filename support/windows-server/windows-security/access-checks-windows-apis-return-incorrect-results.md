---
title: Access checks using APIs return incorrect results
description: Provides resolutions for an issue where access checks using Windows APIs return incorrect results.
ms.date: 2/7/2021
author: xl989
ms.author: v-lianna
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.prod-support-area-path: Permissions, access control, and auditing
ms.technology: windows-server-security
---
# Access checks using Windows APIs return incorrect results

_Original product version:_ &nbsp; Windows Server 2019, all editions

## Symptoms

Assume that you're using an application to determine the effective access to a resource for a user. The application uses Windows application programming interface (API)s by calling these functions:

- [**AuthzInitializeContextFromSid**](/windows/win32/api/authz/nf-authz-authzinitializecontextfromsid)
- [**AuthzInitializeRemoteResourceManager**](/windows/win32/api/authz/nf-authz-authzinitializeremoteresourcemanager)
- [**AuthzAccessCheck**](/windows/win32/api/authz/nf-authz-authzaccesscheck)
- [**AuthzCachedAccessCheck**](/windows/win32/api/authz/nf-authz-authzcachedaccesscheck)

The results are inconsistent with the actual permissions to the resource. Specifically, some **Allow** permissions may be missing or some **Deny** permissions may appear as **GrantedAccessMask**.

This problem occurs when one of the following conditions is met:

- The application makes the calls remotely from the resource server.
- The user account running the application isn't in the same domain as the resource.

For a sample scenario, see the [More information](#more-information) section.

## Cause

The Authorization Manager Runtime (AuthZ.dll) engine driving the access checks with APIs uses a Kerberos Service for User (Kerberos S4U) transaction to obtain a token of the user. However, this token is relative to the administrative station or to the station where the server application executes, and not relative to the resource server. Therefore, the token doesn't include the domain local groups of the computer that hosts the resource when one of the following conditions is met:

- The resource is in a different domain than the administrative station or than the administrative user.
- The resource has permissions that are assigned to built-in groups, which may be misused.

## Resolution

Use one of these methods:

- Call the **AuthzInitializeContextFromSid** function with a handle to a remote resource using the **AuthzInitializeRemoteResourceManager** function.
- When using a local Authz context:
  - If your configuration enables Kerberos S4U, make sure the administrative user and the resource are in the same domain.
  - If you check the effective permissions for an Active Directory object, run the administrative tools on a domain controller that has a full copy of the object (configuration NC, domain NC, or application NC).
  - If you check the effective permissions for a clustered resource, you can run the administrative tools from any cluster node. Alternatively, use the resource server.
- Switch the Authz engine to avoid the Kerberos S4U approach and revert to Active Directory (AD) Lightweight Directory Access Protocol (LDAP) and standalone server Security Account Manager (SAM) queries to collect the users group list with the **UseGroupRecursion** registry entry. Here's how to proceed:

    1. [Open **Registry Editor**](https://support.microsoft.com/windows/how-to-open-registry-editor-in-windows-10-deab38e6-91d6-e0aa-4b7c-8878d9e07b11).
    2. Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Authz`.
    3. On the **Edit** menu, select **New** > **DWORD Value**.
    4. Type *UseGroupRecursion* and press ENTER.
    5. Press and hold (or right-click) **UseGroupRecursion** and then select **Modify**.
    6. In the **Value data** box, type *1* and then select **OK**.

        > [!NOTE]
        > By default, the Authorization Manager Runtime engine uses the Kerberos method when the value is set to 0. When the value is set to 1, the engine uses AD LDAP and standalone server SAM queries.
    7. Close **Registry Editor**.

    > [!NOTE]
    >
    > - **UseGroupRecursion** won't be effective if you create the Authz context using the flag AUTHZ_REQUIRE_S4U_LOGON.
    > - The application user needs to have sufficient read permissions for the TokenGroups attribute and for the domain local groups of the resource domain.
    > - Calling the APIs needs to be allowed to use the SAM RPC protocol because server-local groups are retrieved using SAM APIs. You can set an access control list (ACL) on the SAM RPC interface with the [RestrictRemoteSAM](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls) security policy.

## More information

Here's a sample scenario:

- There's a global group in domain A and a domain local group in domain B where the resource is located.
- The local group has full access to the resource. This access includes **Delete** permissions.
- The global group is a member of the local group but doesn't have direct access to the resource.
- You remotely retrieve the resource permissions of a user in the global group by using an administrative user account from a computer in domain A.

The user has **Delete** permissions, but appears not to have **Delete** permissions for the resource.
