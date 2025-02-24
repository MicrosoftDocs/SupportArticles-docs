---
title: Remote Desktop Licensing Mode Is Not Configured Warning
description: Helps you troubleshoot a licensing warning message when you connect to a Remote Desktop (RD) Session Host.
ms.date: 02/19/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, pedromatos, timnewton, v-lianna
ms.custom:
- sap:remote desktop services and terminal services\licensing for remote desktop services (terminal services)
- pcy:WinComm User Experience
---
# Remote Desktop licensing mode is not configured warning when you connect to an RD Session Host

This article helps you troubleshoot a licensing warning message when you connect to a Remote Desktop (RD) Session Host.

When you use the Remote Desktop Web portal (RD Web portal) or a direct remote desktop protocol (RDP) connection to access a Remote Desktop Services (RDS) deployment, you receive one of the following Windows RDS Balloon Reminder messages:

- When the RD Session Host is still under the grace period:

    > Remote Desktop licensing mode is not configured.  
    Remote Desktop Services will stop working in *x* days. On the RD Connection Broker server, use Server Manager to specify the Remote Desktop licensing mode.

- When the RD Session Host is past its grace period:

    > Remote Desktop licensing mode is not configured.  
    Remote Desktop Services will stop working because this computer is past its licensing grace period. On the RD Connection Broker server, use Server Manager to specify the Remote Desktop licensing mode.

## The licensing mode isn't properly configured or the RD Session Host can't communicate with the RD license server

By default, a newly created RD Session Host has a grace period of 120 days. If the licensing mode isn't properly configured in the RDS deployment, or if the RD Session Host can't communicate with the RD license server, you receive one of the preceding pop-up messages each time you sign in.

> [!NOTE]
> The pop-up message doesn't always indicate a problem. In the following scenarios, you receive the message even if all the settings are as expected:
>
> - Connecting with a local account and the licensing mode is set to **Per User**
> - Connecting with an administrative session

## Check the RD Licensing configuration

> [!NOTE]
> Before you start troubleshooting, ensure the following points:
>
> - The RD license server is properly activated.
> - The client access licenses (CALs) versions that you're using are compatible with both your RD Session Host versions and your RD licensing server versions. For more information, see [License your RDS deployment with client access licenses (CALs): RDS CAL version compatibility](/windows-server/remote/remote-desktop-services/rds-client-access-license#rds-cal-version-compatibility).

You can use any of the following methods to check the RD Licensing configuration, depending on how you manage your servers.

- [Use the Remote Desktop Services console in Server Manager](#use-the-remote-desktop-services-console-in-server-manager)
- [Use domain or local Group Policy](#use-domain-or-local-group-policy)

    > [!NOTE]
    > Settings configured through Group Policy override those configured using the Remote Desktop Services console in Server Manager.

- [Use Registry Editor](#use-registry-editor)

### Use the Remote Desktop Services console in Server Manager

To check the licensing configuration by using Server Manager, follow these steps:

1. On the RD Connection Broker server or the RD Session Host server, open Server Manager.
2. Select **Remote Desktop Services** > **Overview**, locate the **DEPLOYMENT OVERVIEW** section, and then select **TASKS** > **Edit Deployment Properties**.
3. Select **RD Licensing**, and then check the licensing mode and the list of licensing servers.
4. If needed, fix the configuration and then select **OK**.

### Use domain or local Group Policy

To check the licensing configuration by using Group Policy, follow these steps:

1. Depending on whether you want to configure Group Policy centrally from your domain or locally on each session host, perform one of the following operations:

    - If you manage Group Policy at the domain level, open the Group Policy Management Console (GPMC), right-click the Group Policy Object (GPO) that targets your RD Session Hosts, and then select **Edit**. This operation opens the Group Policy Editor.
    - If you manage Group Policy at the server level, open the Local Group Policy Editor on the RD Session Host.

2. Select **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.
3. Check the licensing mode and the list of licensing servers.
4. If needed, fix the configuration and then select **OK**.

For more information about licensing configurations, see [License Remote Desktop session hosts](/windows-server/remote/remote-desktop-services/rds-license-session-hosts#configure-licensing-for-an-rds-deployment-that-includes-only-the-rd-session-host-role-and-the-rd-licensing-role).

### Use Registry Editor

To check the licensing configuration by using Registry Editor, open Registry Editor (or connect to the registry) on the RD Session Host. The subkeys that hold this information vary depending on how you manage your servers.

If you use Group Policy to manage RDS, check the following subkey and entries:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`

  - `LicenseServers` (string value)
  - `LicensingMode` (DWORD value)
    - `2`: **Per Device**
    - `4`: **Per User**

If you use the Remote Desktop Services console in Server Manager, check the following subkeys and entries:

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\Licensing Core`
  - `LicensingMode` (DWORD value)
    - `2`: **Per Device**
    - `4`: **Per User**
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService\Parameters\LicenseServers\SpecifiedLicenseServers`
  - `SpecifiedLicenseServers` (multi-string value)

    > [!NOTE]
    > This entry exists only if you used the Remote Desktop Services console to configure licensing.

For more information about `LicensingMode`, see [LicensingMode](/windows-hardware/customize/desktop/unattend/microsoft-windows-terminalservices-remoteconnectionmanager-licensingmode#values).

## Check for blocked ports between the Remote Desktop Services servers

Make sure that the required ports are open on the firewalls between the RD Session Host and the RD licensing server.
For more information on the ports that need to be open between the different RDS components, see:

- [RDS 2012: Which ports are used during deployment?](/archive/technet-wiki/16164.rds-2012-which-ports-are-used-during-deployment)
- [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

## Check the workgroup or domain configuration

If you deploy RDS across multiple domains, review the best practices and supportability for setting up RD Licensing across domains, forests, or workgroups. For more information, see [Best practices for setting up RDS licensing across Active Directory domains/forests or work groups](set-up-remote-desktop-licensing-across-domains-forests-workgroups.md).

## Contact Microsoft Support

If the preceding steps don't resolve the issue, contact Microsoft Support for more help. Before you contact Microsoft Support, [gather relevant information by using TSS for user experience-related issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md).
