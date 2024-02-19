---
title: Install RDS role service without Connection Broker
description: Guidelines for installing the RDSH  and RD license server role services on a computer running Windows Server (DC or workgroup) without the RD Connection Broker role service.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
---
# Install Remote Desktop Session Host role service in Windows Server without Connection Broker role service

This article provides guidelines to install and configure the Remote Desktop Session Host role service on a computer that is running Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 without the Remote Desktop Connection Broker role service installed.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2833839

## Summary

When you create a standard deployment of Remote Desktop Services, the Remote Desktop Connection Broker role service provides access to the complete functionality of Remote Desktop Services. A configuration that does not use the RD Connection Broker role service provides desktop sessions to users based on the number of Remote Desktop Services client access licenses (RDS CALs) that are installed on the server. Such a configuration does not provide access to RemoteApp programs or the RDWeb website. Because a configuration without the RD Connection Broker role service does not provide access to all RDS functionality, you should use such a configuration only if there is no other option.

You can use the instructions in this article to configure RDS service by using a single server (either a member of a workgroup or a domain controller (DC)). If you have a separate DC, we recommend that you use the Standard Remote Desktop Services deployment wizard.

> [!IMPORTANT]
> Configuring RDS on a workgroup server creates the following additional restrictions:
>
> - You must use per-device licensing instead of per-user licensing. For more information, see [License your RDS deployment with client access licenses (CALs)](/windows-server/remote/remote-desktop-services/rds-client-access-license).
> - You must use Windows PowerShell to manage the RDS role services. This is because the Server Manager tools for RDS do not work. For more about using PowerShell cmdlets together with RDS, see [Using Powershell to Install, Configure and Maintain RDS in Windows Server 2012](https://social.technet.microsoft.com/wiki/contents/articles/12835.using-powershell-to-install-configure-and-maintain-rds-in-windows-server-2012.aspx).

For more information about the RDS roles, see [Remote Desktop Services roles](/windows-server/remote/remote-desktop-services/rds-roles).

## Process of deploying RDS service roles

The process of deploying RDS service roles on a single workgroup server or DC differs from that of deploying a standard RDS configuration on multiple computers.

Unless otherwise noted, these steps apply to both workgroup computer and DC cases.

> [!IMPORTANT]
> If you are using a single computer as both the RDS server and as a DC, configure the computer as a DC before you begin installing the RDS roles. For more information about how to install Active Directory Domain Services (AD DS) and configure the computer as a DC in Windows Server 2016 or Windows Server 2012, see [Install Active Directory Domain Services (Level 100)](/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-).

1. On the workgroup computer or DC, install the Remote Desktop Licensing role service and the Remote Desktop Session Host role service. To do this, follow these steps:

    1. Open Server Manager.
    2. Click **Manage** and select **Add Roles and Features**.
    3. Select **Role-based or Feature-based installation**.
    4. Select the computer as the destination server.
    5. On the **Select server roles** page, select **Remote Desktop Services**.
    6. On the **Select role services** page, select the **Remote Desktop Licensing** and **Remote Desktop Session Host** role services.
    7. Continue the installation. Select default values for the remaining settings.

1. **DC step:** Open Remote Desktop Licensing Manager, right-click the server, and then select **Review Configuration**.

1. Select **Add to group**.

    > [!NOTE]
    > If you have to manage group memberships manually, the **Terminal Server License Servers** group is located in the **Built-in** container in Active Directory Users and Computers.

1. Restart the Remote Desktop Services service.

1. Use one of the following methods to activate the RDS license server:

   - To activate a Windows Server 2012 RDS license server, see [Test Lab Guide: Remote Desktop Licensing](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134160%28v=ws.11%29#step-3-activate-the-remote-desktop-license-server).
   - To activate a Windows Server 2016 RDS license server, see [Activate the Remote Desktop Services license server](/windows-server/remote/remote-desktop-services/rds-activate-license-server).

1. Install the appropriate RDS CALs.

    > [!IMPORTANT]
    > If you are using a workgroup server, you must use per-device CALs. For more information, see [License your RDS deployment with client access licenses (CALs)](/windows-server/remote/remote-desktop-services/rds-client-access-license). For more information about how to install RDS CALs, see [Install Remote Desktop Services Client Access Licenses](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725890%28v=ws.11%29).

1. Add the users that you want to allow to connect to the Remote Desktop Users group. To do this, use the following tools:

   - To find the Remote Desktop Users group on a DC, open Active Directory Users and Computers and navigate to the **Builtin** container.
   - To find the Remote Desktop Users group on a workgroup server, open Computer Management and then navigate to **Local Users and Groups\\Groups**.

1. Change the local policy of the computer to add your remote desktop users to the **Allow logon through Remote Desktop Services** local policy object. To do this, follow these steps:

    1. Open Local Group Policy.
    2. Navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**.
    3. Double-click **Allow log on through Remote Desktop Services**, and then select **Add User or Group**.
    4. Type **Remote Desktop Users** (or the user names of each user account that you want to add, separated by semicolons), and then select **OK** two times.

1. Configure the Remote Desktop Session Host role service to use the local RDS license server.

    > [!IMPORTANT]
    > Before you begin this procedure, make sure that the RDS license server is activated.

    To do this, follow these steps:

    1. Open an elevated Windows PowerShell Command Prompt window.
    2. Run the following command:

        ```powershell
        $obj = gwmi -namespace "Root/CIMV2/TerminalServices" Win32_TerminalServiceSetting
        ```

    3. To set the licensing mode, run the following command:

        ```powershell
        $obj.ChangeMode("<value>")
        ```

        > [!NOTE]
        > In this command, \<value> represents the licensing mode and is either **2** (if you are using per-device licensing) or **4** (if you are using per-user licensing). If you are using a workgroup server, you must use **2**.

    4. Run the following command:

        ```powershell
        $obj.SetSpecifiedLicenseServerList("<licenseservername>")
        ```

    5. To verify the settings, run the following command:

        ```powershell
        $obj.GetSpecifiedLicenseServerList()
        ```

        You should see the RDS licensing server name in the output. After you finish this step, users can start remote desktop sessions by using any supported RDS client.

1. **DC step:** To enable printer redirection to function correctly on a DC that is acting as the RDSH host, follow these additional steps.
  
    1. Open an elevated Command Prompt window.
    2. Run the following commands:

        ```console
        C:\
        CD \Windows\system32\Spool
        Cacls.exe PRINTERS /e /g users:C
        ```

    3. Restart the computer.
