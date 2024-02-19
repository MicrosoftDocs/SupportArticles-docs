---
title: Change the default permissions on GPOs
description: Describes how to change the default permissions on Group Policy objects (GPOs).
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sashalon
ms.custom: sap:sysvol-access-or-replication-issues, csstroubleshoot
---
# How to change the default permissions on GPOs in Windows Server

This article discusses how to change the default permissions on Group Policy objects (GPOs).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 321476

## Summary

You may want to strengthen security on GPOs to prevent all but a trusted group of administrators from changing group policy. You can do so by modifying the DefaultSecurityDescriptor attribute on the Group Policy container classScema object. However, the change only affects newly created GPOs. For existing GPOs, you can modify permissions directly on the Group Policy container (CN={GPO_GUID},CN=System,DC=domain...) and Group Policy template (\\\\domain\\SYSVOL\\Policies\\{GPO_GUID}). This procedure can also help prevent administrative templates (ADM files) in the Group Policy templates from being inadvertently updated by the ADM files on unmanaged workstations.

## More information

When a new Active Directory object is created, the permissions that are specified in the DefaultSecurityDescriptor attribute of its classSchema object in the schema are applied to it. Because of this, when a GPO is created, its groupPolicyContainer object receives its ACL from the DefaultSecurityDescriptor attribute in the CN=Group-Policy-Container,CN=Schema,CN=Configuration,DC=forestroot... object. The Group Policy editor also applies these permissions to the folder, subfolders, and files in the Group Policy's template (SYSVOL\\Policies\\{GPO_GUID}).

You can use the following process to modify the DefaultSecurityDescriptor attribute for the Group Policy Container classSchema object. Because this is a schema change, it starts a full replication for all GCs across the forest. Schema permissions are written by using the Security Descriptor Definition Language (SDDL). For more information about SDDL, visit the following Microsoft Web site:
  
[Security Descriptor Definition Language](/windows/win32/secauthz/security-descriptor-definition-language)

To modify the DefaultSecurityDescriptor attribute for the Group Policy Container classSchema object:

1. Log on to the forest schema master domain controller with an account that is a member of the Schema Administrators group.
2. Start Mmc.exe, and then add the Schema snap-in.
3. Right-click **Active Directory Schema**, and then click **Operations Master**.
4. Click **The Schema may be modified on this domain controller**, and then click **OK**.
5. Use ADSI Editor to open the schema-naming context, and then locate the CN=Group-Policy-Container object with the classSchema type.
6. View the properties of the object, and then find the defaultSecurityDescriptor attribute.
7. Paste the following string into the value to remove write permissions for domain administrators so that only enterprise administrators would have write permissions:

    `D:P(A;CI;RPLCLOLORC;;;DA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;EA)(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;;CO)(A;CI;RPWPCCDCLCLORCWOWDSDDTSW;;;SY)(A;CI;RPLCLORC;;;AU)(OA;CI;CR;edacfd8f-ffb3-11d1-b41d-00a0c968f939;;AU)`

    To give an additional group write permissions, append the following text to the end of the previous text:

    `(A;CI;RPWPCCDCLCLOLORCWOWDSDDTSW;;; <Group_SID>)`

    \<Group_SID> is the SID of the group to which you're granting permissions.

    > [!NOTE]
    > Changing the defaultSecurityDescriptor attribute does not modify the security descriptors for any pre-existing GPOs. You may, however, use the above complete string to replace the ACL on pre-existing GPOs in conjunction with a tool such as sdutil.exe.
8. Paste the new string into the **edit attribute** box, click Set, click Apply, and then click OK.

    > [!NOTE]
    > If you are trying to restrict access to domain administrators or enterprise administrators you must place a deny in the Default Schema permissions for the Grouppolicycontainer object. These groups will add an addional ACL to the group policy object when it is created. For domain administrators you must add Domain Admins and for enterprise administrators add Administrator. Adding a Deny is the only way to restirict these groups.  

### Technical support for x64-based versions of Windows

Your hardware manufacturer provides technical support and assistance for x64-based versions of Windows. Your hardware manufacturer provides support because an x64-based version of Windows was included with your hardware. Your hardware manufacturer might have customized the installation of Windows with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your x64-based version of Windows. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
