---
title: SeImpersonatePrivilege and SeCreateGlobalPrivilege
description: Describes the Impersonate a Client After Authentication and the Create Global Objects security settings.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Overview of the impersonate a client after authentication and the create global objects security settings

This article discusses the **Impersonate a client after authentication** and **Create global objects** user rights.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 821546

## Summary

This article discusses the "Impersonate a client after authentication" and "Create global objects" user rights. These new security settings were first introduced in Windows 2000 Service Pack 4 (SP4) and help to increase security in Windows 2000. This article describes the new security settings and also contains information about some known issues that may occur and how to troubleshoot them.

> [!IMPORTANT]
> Consider the following issues when you apply the "Impersonate a client after authentication" and "Create global objects" user rights by using the Default Domain Policy or Group Policy:

- The "Impersonate a client after authentication" and "Create global objects" user rights only apply to computers that are running Windows 2000 SP4 or later.
- You can use the Default Domain Policy or Group Policy to apply the "Impersonate a client after authentication" and "Create global objects" security settings to computers in your environment if the computers are running Windows 2000 Service Pack 2 (SP2) or later. Note that although you can deploy the security settings in an environment that contains Windows 2000 SP2 and Windows 2000 Service Pack 3 (SP3)-based computers, the security settings *only* apply to Windows 2000 SP4-based computers. The settings do not apply to computers that are running either Windows 2000 SP2 or Windows 2000 SP3.
- Do not use the Default Domain Policy or another Group Policy to apply either or both of these new user rights to computers that are running Windows 2000 or Windows 2000 Service Pack 1 (SP1). Note that if you use the Default Domain Policy or a different Group Policy to apply these user rights to computers that are running Windows 2000 or Windows 2000 Service Pack 1 (SP1), the propagation of the policy's security settings fails. That is, the policy is not propagated to the Windows 2000 or Windows 2000 SP1 computers and user rights are not displayed in the Local Security Settings snap-in. The following scenarios may occur if you use the Default Domain Policy or another Group Policy to apply either or both of these new user rights to computers that are running Windows 2000 or Windows 2000 Service Pack 1 (SP1):
  - Additional security policy settings that are located in the same Group Policy Object and that target Windows 2000 or Windows 2000 Service Pack 1 (SP1) devices are not propagated to the destination devices.

  - Additional security policy settings that are applied by using other Group Policies along the SDOU (Site, Domain, Organizational Unit) path to the Windows 2000 or the Windows 2000 Service Pack 1 (SP1) devices that will be propagated.

  - If either or both of these new security settings are targeted at Windows 2000 or Windows 2000 Service Pack 1 (SP1) devices, the local MMC security snap-in on those devices cannot correctly display any security settings. However, all security settings that are applied to the targeted devices from other domain-side Group Policy Objects (that do not contain the new settings) will still apply to those targeted devices.

- Similarly, you can use the Default Domain Controller security policy to apply the "Impersonate a client after authentication" and "Create global objects" security settings to domain controllers in your environment if the domain controllers are running Windows 2000 SP2 or later. Note that although you can deploy the security settings in an environment that contains Windows 2000 SP2 and Windows 2000 SP3-based domain controllers, the security settings *only* apply to Windows 2000 SP4-based domain controllers. The settings do not apply to domain controllers that are running either Windows 2000 SP2 or Windows 2000 SP3.

### Issue 1: the "Impersonate a Client AfterAuthentication" User Right (SeImpersonatePrivilege)

The "Impersonate a client after authentication" user right (SeImpersonatePrivilege) is a Windows 2000 security setting that was first introduced in Windows 2000 SP4. By default, members of the device's local Administrators group and the device's local Service account are assigned the "Impersonate a client after authentication" user right. The following components also have this user right:

- Services that are started by the Service Control Manager
- Component Object Model (COM) servers that are started by the COM infrastructure and that are configured to run under a specific account

When you assign the "Impersonate a client after authentication" user right to a user, you permit programs that run on behalf of that user to impersonate a client. This security setting helps to prevent unauthorized servers from impersonating clients that connect to it through methods such as remote procedure calls (RPC) or named pipes. For more information about the SeImpersonatePrivilege function, visit the following Microsoft Web site:  
[Impersonate a client after authentication](/windows/security/threat-protection/security-policy-settings/impersonate-a-client-after-authentication)
  
For more information about Impersonate functions (such as ImpersonateClient, ImpersonateLoggedOnUser, and ImpersonateNamedPipeClient), search for SeImpersonatePrivilege in the Microsoft Platform SDK documentation. To view this documentation, visit the following Microsoft Web site:  
[Impersonate a client after authentication](/windows/security/threat-protection/security-policy-settings/impersonate-a-client-after-authentication)  

#### Troubleshooting for issue 1

- Some programs that use impersonation may not work correctly after you install Windows 2000 SP4.  

    After you install Windows 2000 Service Pack 4 (SP4) on your computer, some programs that use impersonation may not work correctly.

    This issue may occur in situations when the user account that is used to run the program does not have the "Impersonate a client after authentication" user right.

    On computers that are running Windows 2000 Service Pack 3 (SP3) and earlier, a user right is not required to impersonate a client. Therefore, some programs that use impersonation may not work correctly after you install Windows 2000 SP4.

    To resolve this issue, identify the user account that is used to run the program, and then assign the "Impersonate a client after authentication" user right to that user account. To do this, follow these steps:  

    1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Local Security Policy**.
    2. Expand **Local Policies**, and then click **User Rights Assignment**.
    3. In the right pane, double-click **Impersonate a client after authentication**.
    4. In the **Local Security Policy Setting** dialog box, click **Add**.
    5. In the **Select Users or Group** dialog box, click the user account that you want to add, click **Add**, and then click **OK**.
    6. Click **OK**.

    > [!NOTE]
    > To troubleshoot situations where you cannot determine the user account that is used to run the program, and where you want to verify that the symptoms that you are experiencing are caused by the user right, assign the "Impersonate a client after authentication" user right to the Everyone group, and then start the program. If the program works correctly, the issue that you are experiencing may be caused by the new security setting.

- You receive an "Error while trying to run project" error message when you debug a web application in Visual Studio .NET.

### Issue 2: the "Create Global Objects" User Right (SeCreateGlobalPrivilege)

The "Create global objects" user right (SeCreateGlobalPrivilege) is a Windows 2000 security setting that was first introduced in Windows 2000 SP4. The user right is required for a user account to create global file mapping and symbolic link objects. Note that users can still create session-specific objects without being assigned this user right. By default, members of the Administrators group, the System account, and Services that are started by the Service Control Manager are assigned the "Create global objects" user right.

#### Troubleshooting for issue 2

- Some programs may not work correctly after you install Windows 2000 SP4.  

  After you install Windows 2000 Service Pack 4 (SP4) on your computer, some programs may not work correctly. This issue may occur in situations when the user account that is used to run the program does not have the "Create global objects" user right.

  To resolve this issue, identify the user account that is used to run the program, and then assign the "Create global objects" user right to that user account. To do this, follow these steps:
  1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Local Security Policy**.
  2. Expand **Local Policies**, and then click **User Rights Assignment**.
  3. In the right pane, double-click **Create global objects**.
  4. In the **Local Security Policy Setting** dialog box, click **Add**.
  5. In the **Select Users or Group** dialog box, click the user account that you want to add, click **Add**, and then click **OK**.
  6. Click **OK**.

    > [!NOTE]
    > To troubleshoot situations where you cannot determine the user account that is used to run the program and where you want to verify that the symptoms that you are experiencing are caused by the user right, assign the "Create global objects" user right to the Everyone group, and then start the program. If the program works correctly, the issue that you are experiencing may be caused by the new security setting.
- You receive a "Not enough memory" error message when you search for clips in an Office XP document in a Terminal Services session.  

- Computer stops responding (hangs) when you restart a Windows 2000 Server-based computer after you install McAfee Parental Control.  
