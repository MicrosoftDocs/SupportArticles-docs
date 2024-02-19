---
title: Disable User Account Control (UAC)
description: Describes disabling User Account Control (UAC) on Windows Server can be an acceptable and recommended practice in certain constrained circumstances.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# How to disable User Account Control (UAC) on Windows Server

This article introduces how to disable User Account Control (UAC) on Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2526083

## Summary

Under certain constrained circumstances, disabling UAC on Windows Server can be an acceptable and recommended practice. These circumstances occur only when both the following conditions are true:

- Only administrators are allowed to sign in to the Windows server interactively at the console, or by using Remote Desktop Services.
- Administrators sign in to the Windows-based server only to do legitimate system administrative functions on the server.

If either of these conditions isn't true, UAC should remain enabled. For example, the server enables the Remote Desktop Services role so that nonadministrative users can sign in to the server to run applications. UAC should remain enabled in this situation. Similarly, UAC should remain enabled in the following situations:

- Administrators run risky applications on the server. For example, web browsers, email clients, or instant messaging clients.
- Administrators do other operations that should be done from a client operating system, such as Windows 7.

> [!NOTE]
>
> - This guidance applies only to Windows Server operating systems.
> - UAC is always disabled on the Server Core editions of Windows Server 2008 R2 and later versions.

## More information

UAC was designed to help Windows users move toward using standard user rights by default. UAC includes several technologies to achieve this goal. These technologies include:

- File and Registry Virtualization: When a legacy application tries to write to protected areas of the file system or the registry, Windows silently and transparently redirects the access to a part of the file system or the registry that the user is allowed to change. It enables many applications that required administrative rights on earlier versions of Windows to run successfully with only standard user rights on Windows Server 2008 and later versions.
- Same-desktop Elevation: When an authorized user runs and elevates a program, the resulting process is granted more powerful rights than those rights of the interactive desktop user. By combining elevation with UAC's Filtered Token feature (see the next bullet point), administrators can run programs with standard user rights. And they can elevate only those programs that require administrative rights with the same user account. This same-user elevation feature is also known as Admin Approval Mode. Programs can also be started with elevated rights by using a different user account so that an administrator can perform administrative tasks on a standard user's desktop.
- Filtered Token: When a user with administrative or other powerful privileges or group memberships logs on, Windows creates two access tokens to represent the user account. The unfiltered token has all the user's group memberships and privileges. The filtered token represents the user with the equivalent of standard user rights. By default, this filtered token is used to run the user's programs. The unfiltered token is associated only with elevated programs. An account is called a *Protected Administrator* account under the following conditions:

  - It's a member of the Administrators group
  - It receives a filtered token when the user logs on
  
- User Interface Privilege Isolation (UIPI): UIPI prevents a lower-privileged program from controlling the higher-privileged process through the following way:  
  &nbsp;&nbsp;&nbsp;Sending window messages, such as synthetic mouse or keyboard events, to a window that belongs to a higher-privileged process
- Protected Mode Internet Explorer (PMIE): PMIE is a defense-in-depth feature. Windows Internet Explorer operates in low-privileged Protected Mode,  and can't write to most areas of the file system or the registry. By default, Protected Mode is enabled when a user browses sites in the Internet or Restricted Sites zones. PMIE makes it more difficult for malware that infects a running instance of Internet Explorer to change the user's settings. For example, it configures itself to start every time the user logs on. PMIE isn't actually part of UAC. But it depends on UAC features, such as UIPI.
- Installer Detection: When a new process is about to be started without administrative rights, Windows applies heuristics to determine whether the new process is likely to be a legacy installation program. Windows assumes that legacy installation programs are likely to fail without administrative rights. So, Windows proactively prompts the interactive user for elevation. If the user doesn't have administrative credentials, the user can't run the program.

If you disable the User Account Control: Run all administrators in Admin Approval Mode policy setting. It disables all the UAC features described in this section. This policy setting is available through the computer's Local Security Policy, Security Settings, Local Policies, and then Security Options. Legacy applications that have standard user rights that expect to write to protected folders or registry keys will fail. Filtered tokens aren't created. And all programs run with the full rights of the user who is logged on to the computer. It includes Internet Explorer, because Protected Mode is disabled for all security zones.

One of the common misconceptions about UAC and Same-desktop Elevation in particular is: it prevents malware from being installed, or from gaining administrative rights. First, malware can be written not to require administrative rights. And malware can be written to write just to areas in the user's profile. More important, Same-desktop Elevation in UAC isn't a security boundary. It can be hijacked by unprivileged software that runs on the same desktop. Same-desktop Elevation should be considered a convenience feature. From a security perspective, Protected Administrator should be considered the equivalent of Administrator. By contrast, using Fast User Switching to sign in to a different session by using an administrator account involves a security boundary between the administrator account and the standard user session.

For a Windows-based server on which the sole reason for interactive logon is to administer the system, the goal of fewer elevation prompts isn't feasible or desirable. System administrative tools legitimately require administrative rights. When all the administrative user's tasks require administrative rights, and each task could trigger an elevation prompt, the prompts are only a hindrance to productivity. In this context, such prompts don't/can't promote the goal of encouraging development of applications that require standard user rights. Such prompts don't improve the security posture. These prompts just encourage users to click through dialog boxes without reading them.

This guidance applies only to well-managed servers. It means only administrative users can log on interactively or through Remote Desktop services. And they can perform only legitimate administrative functions. The server should be considered equivalent to a client system in the following situations:

- Administrators run risky applications, such as web browsers, email clients, or instant messaging clients.
- Administrators perform other operations that should be performed from a client operating system.

In this case, UAC should remain enabled as a defense-in-depth measure.

Also, if standard users sign in to the server at the console or through Remote Desktop services to run applications, especially web browsers, UAC should remain enabled to support file and registry virtualization and also Protected Mode Internet Explorer.

Another option to avoid elevation prompts without disabling UAC is to set the User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode security policy to Elevate without prompting. By using this setting, elevation requests are silently approved if the user is a member of the Administrators group. This option also leaves PMIE and other UAC features enabled. However, not all operations that require administrative rights request elevation. Using this setting can result in some of the user's programs being elevated and some not, without any way to distinguish between them. For example, most console utilities that require administrative rights expect to be started at a command prompt or other program that's already elevated. Such utilities merely fail when they're started at a command prompt that isn't elevated.

## Additional effects of disabling UAC

- If you try to use Windows Explorer to browse to a directory in which you don't have Read permissions, Explorer will offer to change the directory's permissions to grant your user account access to it permanently. The results depend on whether UAC is enabled. For more information, see [When you click Continue for folder access in Windows Explorer, your user account is added to the ACL for the folder](https://support.microsoft.com/help/950934).
- If UAC is disabled, Windows Explorer continues to display UAC shield icons for items that require elevation. And Windows Explorer continues to include Run as administrator in the context menus of applications and application shortcuts. Because the UAC elevation mechanism is disabled, these commands have no effect. And applications run in the same security context as the user who is signed in to.
- If UAC is enabled, when the console utility Runas.exe is used to start a program by using a user account that is subject to token filtering, the program runs with the user's filtered token. If UAC is disabled, the program that is started runs with the user's full token.
- If UAC is enabled, local accounts that are subject to token filtering can't be used for remote administration over network interfaces other than Remote Desktop. For example, through NET USE or WinRM. A local account that authenticates over such an interface obtains only the privileges that are granted to the account's filtered token. If UAC is disabled, this restriction is removed. The restriction can also be removed by using the `LocalAccountTokenFilterPolicy` setting that's described in [KB951016](https://support.microsoft.com/help/951016). Removing this restriction can increase the risk of system compromise in an environment where many systems have an administrative local account with the same user name and password. We recommend that you make sure that other mitigations are employed against this risk. For more information about recommended mitigations, see [Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft, Version 1 and 2](https://www.microsoft.com/download/details.aspx?id=36036).
- [PsExec, User Account Control, and Security Boundaries](https://techcommunity.microsoft.com/t5/windows-blog-archive/psexec-user-account-control-and-security-boundaries/ba-p/723551)
- [When you select Continue for folder access in Windows Explorer, your user account is added to the ACL for the folder (KB 950934)](https://support.microsoft.com/help/950934)
