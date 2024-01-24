---
title: Define Security Templates By Using the Security Templates Snap-In
description: Provides some steps to define Security Templates by using the Security Templates Snap-In
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lanac
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# Define Security Templates By Using the Security Templates Snap-In

This article provides some steps to define Security Templates by using the Security Templates Snap-In.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816297

## Summary

This step-by-step article describes how to create and define a new security template by using the Security Templates snap-in in Microsoft Windows Server 2003.

With the Security Templates snap-in, you can create a security policy for your network or computer by using security templates. A security template is a text file that represents a security configuration. You can apply a security template to the local computer, import a security template to Group Policy, or use a security template to analyze security. You can use a predefined security template that is included in Windows Server 2003, modify a predefined security template, or create a custom security template that contains the security settings that you want. Security templates can be used to define the following components:

- Account Policies

  - Password policy
  - Account lockout policy
  - Kerberos policy
- Local policies

  - Audit policy
  - User rights assignment
  - Security Options
- Event log: Application, System, and Security Event log settings
- Restricted groups: Membership of security-sensitive groups
- System Services: Startup modes and permissions for system services
- Registry: Registry key permissions
- File system: File and folder permissions  

### Add the Security Templates Snap-In to a Microsoft Management Console (MMC) Console

To add the Security Templates snap-in to an MMC console, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *mmc*, and then click **OK**.
3. On the **File** menu, click **Add/Remove Snap-in**.
4. In the **Add/Remove Snap-in** dialog box, click the **Standalone** tab, and then click **Add**.
5. In the **Add Standalone Snap-in** dialog box, click **Security Templates**, click **Add**, click **Close**, and then click **OK**.
6. In the console tree, expand **Security Templates**, and then expand
 **%SystemRoot%\Security\Templates**.

   A list of predefined security templates and their descriptions appears in the right pane.  

### Create and Define a New Security Template

To define a new security template, follow these steps:

1. In the console tree, expand **Security Templates**.
2. Right-click **%SystemRoot%\Security\Templates**, and then click **New Template**.
3. In the **Template name** box, type a name for the new template.

   If you want, you can type a description in the **Description** box, and then click **OK**.

   The new security template appears in the list of security templates. Note that the security settings for this template are not yet defined. When you expand the new security template in the console tree, expand each component of the template, and then double-click each security setting that is contained in that component, a status of **Not Defined** appears in the **Computer Setting** column.
4. To define Account Policies, Local Policies, or Event Log policies, follow these steps:  
   1. In the console tree, expand the component that contains the security setting that you want to configure.  
    For example, to set a maximum password age policy, expand **Account Policies**.
   2. In the right-pane, double-click the security setting that you want to configure.
    For example, to set the maximum password age policy, double-click **Password Policy**, and then double-click **Maximum password age**.
   3. Click to select the **Define this policy setting in the template** check box, specify the option or setting that you want as appropriate to the security setting, and then click **OK**.
5. To define a Restricted Groups policy, follow these steps:
   1. Right-click **Restricted Groups**, and then click **Add Group**.
   2. Click **Browse**.
   3. In the **Select Groups** dialog box, type the name of the group that you want to restrict access, click **OK**, and then click **OK**.
   4. In the **GroupName Properties** dialog box, under **Members of this group**, click **Add Members** to add the members that you want to the group.  
   To add this group as a member of another group, under **This group is a member of**, click **Add Groups**.
   5. Click **OK**.
6. To define a System Services policy, follow these steps:
   1. Expand **System Services**.
   2. In the right pane, double-click the service that you want to configure.
   3. Specify the options that you want, and then click **OK**.
7. To define security for registry keys, follow these steps:
   1. Right-click **Registry**, and then click **Add Key**.
   2. In the **Select Registry Key** dialog box, click the registry key that you want to define security for, and then click **OK**.
   3. In the **Database Security for RegistryKey** dialog box, specify the permissions that you want for the registry key, and then click **OK**.
   4. In the **Add Object** dialog box, specify how you want permissions on this key inherited, click **OK**, and then click **OK**.
8. To define security for files or folders, follow these steps:
   1. Right-click **File System**, and then click **Add File**.
   2. In the **Add a file or folder** dialog box, click a file or folder that you want to add security to, and then click **OK**.
   3. In the **Database Security for FileName or FolderName** dialog box, specify the permissions that you want, click **OK**, and then click **OK**.  

### Copy Security Settings from a Predefined Template to Another Template

To copy security settings from a predefined template to your custom template, follow these steps:

1. In the console tree, expand a predefined template that contains the settings that you want to copy, right-click the component that you want to copy, and then click **Copy**.
2. In the console tree, expand your custom template, right-click the appropriate component, and then click **Paste**.

    For example, to use the Account Policies settings from the Hisecdc template in your custom template, expand **Hisecdc**, right-click **Account Policies**, and then click **Copy**. Expand your custom template, right-click **Account Policies**, and then click **Paste**.  

### Create a New Security Template Based on a Predefined Template

To create a new security template based on settings from a predefined template, save the predefined template by using another file name. To do so, follow these steps:

1. Right-click the template that you want to copy, and then click **Save As**.
2. In the **Save As** dialog box, type a name for the security template in the **File name** box, and then click **Save**.

   The new security template appears in the list of security templates. Configure the template with the settings that you want.  

## References

For more information about security templates in Windows Server 2003, see the "Security Configuration Manager" topic in the Security section of the Windows 2003 Server documentation.
