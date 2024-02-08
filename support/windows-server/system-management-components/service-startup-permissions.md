---
title: Troubleshoot service startup permissions
description: Describes how to troubleshoot Service Startup permissions in a Windows Server 2003 environment.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, BOBQIN
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
---
# Troubleshoot service startup permissions in Windows Server 2003  

This article describes how to troubleshoot Service Startup permissions in a Microsoft Windows Server 2003 environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 327545

## Summary

> [!NOTE]
> The following procedures were documented by a member of the administrators group on a system running Windows Server 2003, Enterprise Edition.

If a service does not start because of a logon failure, an error message similar to one of the following may be generated and displayed in the system event log:

- Error message 1

    > Source: Service Control Manager  
    Event ID: 7000  
    Description:  
    The %service% service failed to start due to the following error:  
    The service did not start due to a logon failure.  
    >
    > No Data will be available.

- Error message 2

    > Source: Service Control Manager  
    Event ID: 7013  
    Description:  
    Logon attempt with current password failed with the following error:  
    Logon failure: unknown user name or bad password.  
    >
    > No Data will be available.

This behavior may occur if one or more of the following conditions are true:

- The password is changed on the account with which the service is configured to log on.
- The password data in the registry is damaged.
- The right to log on as a service is revoked for the specified user account.

To resolve these issues, configure the service to use the built-in system account, change the password for the specified user account to match the current password for that user, or restore the user's right to log on as a service. These methods are described in the following sections of this article.

## Resolution 1: Configure user rights

If the right to log on as a service is revoked for the specified user account, restore that right on either a domain controller or a stand-alone member server, as appropriate to your circumstances.

### Domain Controller

If the user is in an Active Directory domain, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the console tree, right-click the organizational unit in which the user right to log on as a service was granted. By default, this is in the Domain Controllers organizational unit.
3. Right-click the container that you want, and then click **Properties**.
4. On the **Group Policy** tab, click **Default Domain Controllers Policy**, and then click **Edit**.

    This starts Group Policy Manager.
5. Expand **Computer Configuration**, expand **Windows Settings**, and then expand **Security Settings**.
6. Expand **Local Policies**, and then click **User Rights Assignment**.
7. In the right pane, right-click **Log on as a service**, and then click **Add User or Group**.
8. In the **User and Group Names** box, type the name that you want to add to the policy, and then click **OK**.
9. Quit **Group Policy Manager**, close **Group Policy** properties, and then quit the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in.

### Member server

If the user is a member of a stand-alone member server, follow these steps:

1. Start the Local Security Settings MMC snap-in.
2. Expand **Local Policies**, and then click **User Rights Assignment**.
3. In the right pane, right-click **Log on as a service**, and then click **Add User or Group**.
4. In the **User and Group Names** box, type the name that you want to add to the policy, and then click **OK**.
5. Quit the Local Security Settings MMC snap-in.

## Resolution 2: Configure service logon information

Configure the password for the specified user account to match the current password for that user. To do this, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Services**.
2. Right-click the service that you want, and then click **Properties**.
3. Click the **Log On** tab, change the password, and then click **Apply**.
4. Click the **General** tab, and then click **Start** to restart the service.
5. Click **OK**, and then close the Services tool.

## Resolution 3: Configure the service to start up with the built-in system account

If the service still does not work with the specified user account, you can configure the service to start up with the built-in system account. To do this, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Services**.
2. Right-click the service that you want, and then click **Properties**.
3. Click the **Log On** tab, click **Local System Account**, and then click **Apply**.

    > [!NOTE]
    > You typically do not have to configure a service to interact with the desktop, and therefore you do not have to select the **Allow service to interact with desktop** check box.

4. Click the **General** tab, and then click **Start** to restart the service.
5. Close the Services tool. When you try to open the properties of a service by using the Services tool in Control Panel, the computer may stop responding, and then you may receive the following error message:

    > The RPC Server is unavailable.

This issue may occur if the remote procedure call (RPC) service is not started because of a logon failure with that service or a dependency service. Some services have dependency services that do not start until *their* dependency services start first (for example, the Workstation service).
