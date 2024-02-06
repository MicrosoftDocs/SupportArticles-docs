---
title: How to evaluate effective permissions for resources on remote computers
description: Resolves an issue in which access checks for remote resources return incorrect results.
ms.date: 05/24/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-tappelgate
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---

# How to evaluate effective permissions for resources on remote computers

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

## Symptoms and causes

When you check a user's effective permissions on a remote resource, you sometimes see incorrect results or errors.

The details of this behavior and its resolution depend on how you obtain the effective permissions, as follows:

- If you're using an existing Windows application, you can use the **Effective Access** tab of the **Advanced Security** dialog box for the resource.
- If you're using the Authorization Manager Runtime engine (Authz.dll) application programming interface (API), you can call the following functions:

  - **AuthzInitializeContextFromSid**
  - **AuthzInitializeRemoteResourceManager**
  - **AuthzAccessCheck**
  - **AuthzCachedAccessCheck**

Windows Server 2012 R2 introduced changes to the way in which Windows evaluates effective permissions, especially for remote resources.

### Using the Effective Access tab

If you're using the **Effective Access** tab, the tab may display errors or warnings.

:::image type="content" source="./media/access-checks-windows-apis-return-incorrect-results/error-insufficient-permissions.png" alt-text="Effective permissions error: You do not have permission to evaluate effective access rights for the remote resource.":::

 :::image type="content" source="./media/access-checks-windows-apis-return-incorrect-results/error-information-unavailable.png" alt-text="Effective permissions error: The share security information is unavailable and was not evaluated for effective access.":::

For more information about how to resolve these issues, see [Remote resources including SMB](#get-effective-permissions-on-remote-resources-including-smb-shares).

### Using Authz API calls

You might observe this issue when you use the API calls if either of the following conditions is true:

- The application makes the calls remotely from the resource server.
- The user account that's running the application isn't in the same domain as the resource.

In this case, some **Allow** permissions might be missing, or some **Deny** permissions might appear as **GrantedAccessMask** permissions.

Here's a sample scenario:

- There's a global group in domain A and a domain-local group in domain B. The resource is located in domain B.
- The domain-local group has full access to the resource. This access includes **Delete** permissions.
- The global group is a member of the domain-local group. The global group doesn't have direct access to the resource.
- Using an Administrator-level user account and computer in domain A, you remotely retrieve the resource permissions of a user who is a member of the global group.

In the results that you retrieve, the user doesn't appear to have **Delete** permissions for the resource. However, the user actually does have **Delete** permissions.

Authz.dll uses a Kerberos Service for a User (Kerberos S4U) transaction to obtain a token for the user. However, this token is relative to the administrative station or to the station where the server application runs. The token isn't relative to the resource server. Therefore, the token doesn't include the domain-local groups of the computer that hosts the resource if the resource meets one of the following conditions:

- The resource is in a different domain than the administrative station or the administrative user.
- The resource has permissions that are assigned to built-in groups. Built-in groups can be misused.

## Get effective permissions by using Authz API calls

To resolve this issue, use one of the following methods:

- Use the **AuthzInitializeRemoteResourceManager** function to include a handle to the remote resource when you  call the **AuthzInitializeContextFromSid** function.
- **Local Authz context:**

  - If your configuration enables Kerberos S4U, make sure that the administrative user account is in the same domain as the resource.
  - If you check the effective permissions for an Active Directory object, run the administrative tools on a domain controller that has a full copy of the object (configuration naming context (NC), domain NC, or application NC).
  - If you check the effective permissions for a clustered resource, you can run the administrative tools from any cluster node. Alternatively, run the administrative tools from the resource server.

- **Turn off Kerberos S4U:** Switch the Authz engine from the Kerberos S4U approach to Active Directory (AD) Lightweight Directory Access Protocol (LDAP) and standalone server Security Account Manager (SAM) queries to collect the user's group list.

  > [!IMPORTANT]  
  > Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

  To do this, follow these steps to configure the **UseGroupRecursion** registry entry:

  1. Open Registry Editor, and then navigate to the *HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Authz* subkey.
  1. Select **Edit** > **New** > **DWORD Value**.
  1. Enter *UseGroupRecursion*.
  1. Right-click **UseGroupRecursion**, and then select **Modify**.
  1. Enter *1*, and then select **OK**.  
     > [!NOTE]  
     > If the value is **0** (default value), Authz uses the Kerberos method. If the value is **1**, Authz uses AD LDAP and standalone server SAM queries.
  1. Close Registry Editor.

  > [!NOTE]  
  >- **UseGroupRecursion** isn't effective if you use the AUTHZ_REQUIRE_S4U_LOGON flag when you create the Authz context.
  >- The application user has to have **Read** permissions for the **TokenGroups** attribute and for the domain-local groups of the resource domain.
  >- The application has to be able to use SAM RPC protocol when it calls the APIs. This is because server-local groups are retrieved by using SAM APIs. You can set an access control list (ACL) on the SAM RPC interface by using the **RestrictRemoteSAM** security policy.

## Get effective permissions on remote resources including SMB shares

Windows Server 2012 R2 added an Authz RPC interface to the LSASS process. This interface is managed by the Netlogon service. With the help of this RPC interface, you can evaluate effective permissions relative to the actual resource server.

This update also added the ability to evaluate permissions set at both file system and the share level. When you use this capability, you see what part of the access check is limiting access.

 :::image type="content" source="./media/access-checks-windows-apis-return-incorrect-results/effective-access-limits.png" alt-text="Information that provides details about what factors limit a users access to a resource.":::

When you evaluate effective access to resources, consider the following factors:

- **Authorization on the remote server**  
  - To evaluate effective permissions for a resource on a remote server, a user has to belong to the **Access Control Assistance Operators** group. This built-in group makes it easier to delegate access to people who don't have administrative access to resource servers. Otherwise, users have to have administrative access to both the remote server and the share or other resource.
- **Access to SMB share information**
  - **Permissions to retrieve the security descriptor for the share**  
  The user might also have to have administrative access to the SMB share security descriptors. By default, many in-market operating system versions don't grant such access. To receive an update that provides this capability, contact Microsoft Support. The solution for in-market operating system versions isn't publicly available.
  - **How the server is accessed (if the resource uses share-level access control)**  
  To evaluate the effective permissions for a resource on a remote server that uses share-level access control, you have to use a UNC share path to access the resource. Don't try to use a mapped drive letter to access the resource. For example, don't use a path that resembles the following path:

    ```console
    f:\year2022\quarter2\
    ```

    **Note:** In this example, `f:` maps to `\\fileserver01.contoso.com\finance-data`.

    Instead, use a path that resembles the following path:

    ```console
    \\fileserver01.contoso.com\finance-data\year2022\quarter2\
    ```

If you aren't using share permissions to restrict users, you can safely ignore the share permissions warning.
