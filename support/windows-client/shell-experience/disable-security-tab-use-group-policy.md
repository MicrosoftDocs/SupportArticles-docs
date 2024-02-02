---
title: How to remove the Security tab by using a group policy
description: Describes how an administrator can disable the Security tab from Windows 2000 Professional-based workstations that are members of a Windows 2000 domain.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: timtho, kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
ms.subservice: shell-experience
---
# How to remove the Security tab by using a group policy  

This article describes how an administrator can disable the **Security** tab from Windows 2000 Professional-based workstations that are members of a Windows 2000 domain.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 303153

## Summary

Administrators can adjust registry permissions by using the security settings in a group policy. These settings are then applied to Windows 2000 Professional-based workstations during startup.

Remember that the assignment of registry permissions by using a group policy has similar results as using system policies because the results are permanent. To reverse these settings, you need to reverse the same policy and apply the new settings to the computer. Deleting the policy without reversing the settings results in the settings staying on the computer until a policy is created to reverse them or they are manually changed by using the Registry Editor tool.

## Disable the Security tab

To disable the Security tab from Windows 2000 Professional-based workstations that are members of a Windows 2000 domain:

1. Start Active Directory Users and Computers.
2. Right-click the domain, and then click **Properties**.
3. Click the **Group Policy** tab on the domain properties dialog box to view the default domain policy.
4. Click **New**. **New Group Policy Object** should appear in the list of objects. Rename this Policy to Remove Security Tab. Make sure this policy is positioned directly under the default domain policy.
5. Click **Remove Security Tab**, and then click **Edit** to start the Group Policy Editor.
6. Expand **Computer Configuration** > **Windows Settings** > **Security Settings**, and then click **Registry**.
7. Right-click in the left pane, and then click **Add Key**.
8. Paste the following key in the text box, and then click **OK**:

    CLASSES_ROOT\\CLSID\\{1F2E5C40-9550-11CE-99D2-00AA006E086C}

    > [!NOTE]
    > There may be a delay before you can proceed to the next step, and this is normal.
9. The **Database Security Editor** appears. You need to add the user or group that you want the **Security** tab to be removed from.
10. Change the permission on this key for the users and/or groups that you added in the previous step to "Deny Read." This prevents the user from being able to instantiate the needed components to display the Security and Sharing tabs. Click OK twice to complete the settings and exit the Group Policy Editor.

This policy will apply to computers upon the next policy refresh or when they're restarted. You can further control which computers will receive this policy by adding the computers to a group and use security filtering to either allow or deny this policy to be applied based on your environment.
