---
title: Grant users rights to manage services
description: Describes how to grant users rights to manage services.
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
# How to grant users rights to manage services  

This article describes how to grant users the authority to manage system services in Windows Server.

By default, only members of the Administrators group can start, stop, pause, resume, or restart a service. This article describes methods that you can use to grant the appropriate rights to users to manage services.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 325349

## Method 1: Use Group Policy

You can use Group Policy to change permissions on system services. See [How To Configure Group Policies to Set Security for System Services](../group-policy/configure-group-policies-set-security.md) for more information.

## Method 2: Use Security Templates

To use security templates to change permissions on system services, create a security template following these steps:

1. Select **Start**, search *mmc* and select it.
2. On the **File** menu, click **Add/Remove Snap-in**.
3. Select **Security Configuration and Analysis**, select **Add**, and then select **OK**.
4. In the console tree, right-click **Security Configuration and Analysis**, and then select **Open Database**.
5. Specify a name and location for the database, and then click **Open**.
6. In the **Import Template** dialog box that appears, click the security template that you want to import, and then click **Open**.
7. In the console tree, right-click **Security Configuration and Analysis**, and then click **Analyze Computer Now**.
8. In the **Perform Analysis** dialog box that appears, accept the default path for the log file that is displayed in the **Error log file path** box or specify the location that you want, and then click **OK**.

After the analysis is complete, configure the service permissions as follows:

1. In the console tree, select **System Services**.
2. In the right pane, double-click the service whose permissions you want to change.
3. Select the **Define this policy in the database** check box, and then select **Edit Security**.
4. To configure permissions for a new user or group, select **Add**. In the **Select Users, Computers, or Groups** dialog box, type the name of the user or group that you want to set permissions for, and then select **OK**.
5. In the **Permissions for User or Group** list, configure the permissions that you want for the user or group. When you add a new user or group, the **Allow** check box next to the **Start, stop and pause** permission is selected by default. This setting permits the user or group to start, stop, and pause the service.
6. Select **OK** two times.

To apply the new security settings to the local computer, right-click **Security Configuration and Analysis**, and then click **Configure Computer Now**.

>[!NOTE]
> You can use also the Secedit command-line tool to configure and analyze system security. For more information about Secedit, see [secedit commands](/windows-server/administration/windows-commands/secedit). Note that when you use this method to apply settings, all the settings in the template are reapplied, and this may override other previously configured file, registry, or service permissions.
