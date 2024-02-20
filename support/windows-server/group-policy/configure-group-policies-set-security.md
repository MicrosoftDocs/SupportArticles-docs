---
title: Configure Group Policies to Set Security
description: Describes how to configure Group Policies to Set Security for System Services.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:security-filtering-and-item-level-targeting, csstroubleshoot
---
# How To Configure Group Policies to Set Security for System Services

This article describes how to configure Group Policies to Set Security for System Services.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324802

## Summary

This article describes how to use Group Policy to set security for system services for an organizational unit in Windows Server 2003.

When you implement security on system services, you can control who can manage services on a workstation, member server, or domain controller. Currently, the only way to change a system service is through a Group Policy computer setting.

If you implement Group Policy as the Default Domain Policy, the policy is applied to all computers in the domain. If you implement Group Policy as the Default Domain Controllers policy, the policy applies only to the servers in the domain controller's organizational unit. You can create organizational units that contain workstation computers to which policies can be applied. This article describes the steps to implementing a Group Policy on an organizational unit to change permissions on system services.

### How to Assign System Service Permissions

1. Click Start, point to Administrative Tools, and then click **Active Directory Users and Computers**.
2. Right-click the domain to which you want to add the organizational unit, point to New, and then click Organizational Unit.
3. Type a name for the organizational unit in the Name box, and then click OK.

    The new organizational unit is listed in the console tree.
4. Right-click the new organizational unit that you created, and then click Properties.
5. Click the Group Policy tab, and then click New. Type a name for the new Group Policy object (for example, use the name of the organizational unit for which it is implemented), and then press ENTER.
6. Click the new Group Policy object in the **Group Policy Objects Links** list (if it is not already selected), and then click Edit.
7. Expand Computer Configuration, expand Windows Settings, expand Security Settings, and then click System Services.
8. In the right pane, double-click the service to which you want to apply permissions.

    The security policy setting for that specific service is displayed.
9. Click to select the **Define this policy setting** check box.
10. Click Edit Security.
11. Grant the appropriate permissions to the user accounts and groups that you want, and then click OK.
12. Under **Select service startup mode**, click the startup mode option that you want, and then click OK.
13. Close the **Group Policy Object Editor**, click OK, and then close the Active Directory Users and Computers tool.  

> [!NOTE]
> You must move the computer accounts that you want to manage into the organizational unit. After the computer accounts are contained in the organizational unit, the authorized user or groups can manage the service.
