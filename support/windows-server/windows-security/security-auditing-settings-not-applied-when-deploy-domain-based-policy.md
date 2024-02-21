---
title: Security auditing settings are not applied to Windows Vista-based and Window Server 2008-based computers when you deploy a domain-based policy
description: Describes a scenario where security auditing settings are not applied to Windows Vista client computers in an Active Directory domain when you deploy a domain-based policy.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Security auditing settings are not applied to Windows Vista-based and Window Server 2008-based computers when you deploy a domain-based policy

This article provides help to solve an issue where security auditing settings are not applied to client computers in an Active Directory domain when you deploy a domain-based policy.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 921468

## Symptoms

Consider the following scenario. You deploy a domain-based policy to configure security auditing settings on Windows Vista-based or Windows Server 2008-based computers in an Active Directory directory service domain. You run the Resultant Set of Policy (RSoP) tool on one of the Windows Vista-based or Windows Server 2008-based computers. When you do this, the RSoP tool indicates that the policy is being applied. However, the policy is not actually applied to one or more Windows Vista-based or Windows Server 2008-based computers.

## Cause

This issue occurs if the "Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" policy setting is enabled in Windows Vista or in Windows Server 2008. The policy setting can be enabled by using Group Policy or it can be enabled manually by modifying the registry.

To resolve this issue, use one of the following methods, as appropriate for your situation.

## Resolution 1: Disable the policy setting by using Group Policy Object Editor

Verify that the policy setting was enabled by using Group Policy, and then disable the policy setting by using Group Policy Object Editor. To do this, follow these steps:

1. Verify that the "Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" policy setting was enabled by using Group Policy. To do this, follow these steps:

    1. On the computer, click **Start**, point to **All Programs**, click **Accessories**, click **Run**, type *rsop.msc* in the **Open** box, and then click **OK**.
    2. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
    3. Double-click **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings**.
    4. Verify that the policy setting is set to **Enabled**, and then note the Group Policy object (GPO).

2. Disable the "Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" policy setting in the GPO. To do this, follow these steps:

    1. In Group Policy Object Editor, open the GPO.
    2. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
    3. Double-click **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings**.
    4. Click **Disabled**, and then click **OK**.

3. Restart the computer or computers.

## Resolution 2: Disable the policy setting by using Registry Editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To manually disable the policy setting by using Registry Editor, follow these steps:

1. Log on to Windows Vista or Windows Server 2008 as a user who is a member of the Administrators group.
2. Click **Start**, point to **All Programs**, click **Accessories**, click **Run**, type *regedit* in the **Open** box, and then click **OK**. If the **User Account Control** dialog box is displayed on the screen and prompts you to elevate your administrator token, click **Continue**.
3. Locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA`.
4. Right-click **SCENoApplyLegacyAuditPolicy**, and then click **Modify**.
5. Type *0* in the **Value data** box, and then click **OK**.
6. Exit Registry Editor.
7. Restart the computer.

> [!NOTE]
> If the policy is a domain-based policy, and it is not a locally-based policy, you may have to wait for Active Directory replication and SYSVOL replication to complete before the policy settings take effect on the computers.

## More information

Windows Vista and later versions of Windows enable you to manage audit policies in a more precise manner by using audit policy subcategories. If you configure audit policies at the category level, you override audit policy subcategories.

If you want to manage audit policies by using audit policy subcategories, and you do not want to use Group Policy, you can configure the SCENoApplyLegacyAuditPolicy registry entry. When you configure the SCENoApplyLegacyAuditPolicy registry entry, you prevent category-level audit policies that were configured by using either Group Policy or the Local Security Policy tool from being applied.

However, be aware that the policy setting may not be enforced if a different policy is configured to override the category-level audit policy.
