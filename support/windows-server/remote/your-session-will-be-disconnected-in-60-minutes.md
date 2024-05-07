---
title: Your session will be disconnected in 60 minutes message when you connect to RDS
description: Helps you troubleshoot Remote Desktop Service (RDS) licensing errors that occur when you use soft enforcement of RDS licensing.
ms.date: 04/16/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# "Your session will be disconnected in 60 minutes" message when you connect to RDS

This article helps you troubleshoot Remote Desktop Service (RDS) licensing errors that occur when you're using soft enforcement of RDS licensing.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016

## Symptoms

When you use the Remote Desktop Web portal (RD Web portal) or a direct remote desktop protocol (RDP) connection to connect to a Remote Desktop Services (RDS) farm, you receive a message that resembles the following:

> There is a problem with your Remote Desktop license, and your session will be disconnected in 60 minutes. Contact your system administrator to fix this problem.

## Cause

This message is caused by the soft enforcement licensing feature that was introduced in Windows Server 2016 for per-device licensing, and in Windows Server 2019 for per-user licensing. It indicates that there's a problem in the RD Licensing server, or a problem that's preventing communication between the RD Licensing server and the Remote Desktop Session Host (RD Session Host) server.

In cases in which normal licensing enforcement prevents a user from connecting to RD Session Host, soft enforcement allows the user to connect for 60 minutes at a time. The user receives the message when they connect. After 60 minutes, the user is disconnected. However, the user can reconnect to the same session.

This article discusses the per-user and per-device licensing scenarios separately.

### Soft enforcement of per-user licensing (Windows Server 2019)

In a per-user licensing scenario (Windows Server 2019 only), the licensing soft enforcement behavior differs from that in per-device scenarios. If users see this message in a per-user scenario, make sure that all the remote desktop servers have the latest updates installed. If the issue persists, contact Microsoft Technical Support.

> [!IMPORTANT]  
> The Remote Desktop Licensing (RD Licensing) soft-enforcement feature was removed in Windows Server 2022.

### Soft enforcement of per-device licensing

In a per-device licensing scenario, the most common causes of this message include the following:

- Remote Desktop Licensing service isn't running.
- Licensing properties aren't configured correctly.
- The RD Session Host servers can't connect to the RD Licensing server.
- The RD Session Host servers, RD Licensing server, and users aren't in a single domain, and the trust between the domains isn't configured correctly for RDS.

## Resolution

Before you start troubleshooting, check the following points:

- Make sure that the versions of the client access licenses (CALs) that you're using are compatible with both your RD Session Host versions and your RD Licensing server versions. For more information, see [License your RDS deployment with client access licenses (CALs): RDS CAL version compatibility](/windows-server/remote/remote-desktop-services/rds-client-access-license#rds-cal-version-compatibility).
- If you have an RDS farm that uses an RD Connection Broker server, try to reproduce the issue by using the RD Web connection app to connect to the RD Session Host server.
- If you have an RDS farm that doesn't use an RD Connection Broker server, try to reproduce the issue by using Microsoft Terminal Services Client (MSTSC) to connect to the RD Session Host server.

The following sections provide information about how to check for and remedy common licensing issues.

### Check the RD Licensing service

If the Remote Desktop Licensing service isn't running, the RD Licensing server can't retrieve the client license.  

You can use the Services MMC snap-in (Services.msc, also available on the **Tools** menu in Server Manager) to manage the services locally or remotely. You can also use PowerShell to manage the services locally or remotely (if the remote computer is configured to accept remote PowerShell cmdlets).

Check the status of the Remote Desktop Licensing service. If the service isn't running, start it.

### Check the RD Licensing role

Use Server Manager to check that the server roles have been assigned correctly.

In Server Manager, select **Remote Desktop Services**, locate the **Overview** pane, and then check the **Deployment Servers** list. Make sure that all the server roles are associated with the correct servers.

### Check the RD Licensing configuration

You can use any of the following methods to check the RD Licensing configuration, depending on how you manage your servers.

- [Use the Remote Desktop Services console in Server Manager](#servermgr).
- [Use domain or local Group Policy](#gpo).

> [!IMPORTANT]  
> Any settings that you configure by using Group Policy override settings that you configure by using the Remote Desktop Services console in Server Manager.

You can also use [Registry Editor](#registry) to check the licensing configuration.

<a name="servermgr" ></a>To use Server Manager to check the licensing configuration, follow these steps:

1. On the RD Connection Broker server or the RD Session Host server, open Server Manager.
1. Select **Remote Desktop Services** > **Overview**, locate the **Deployment Overview** section, and then select **Tasks** > **Edit Deployment Properties**.
1. Select **RD Licensing**, and then check the licensing mode and the list of licensing servers.
1. If it's necessary, fix the configuration and then select **OK**.

<a name="gpo" ></a>To use Group Policy to check the licensing configuration, follow these steps:

1. Depending on whether you want to configure Group Policy centrally from your domain or locally on each session host, do one of the following:
   - If you are managing Group Policy at the domain level, open the Group Policy Management Console (GPMC), right-click the Group Policy Object (GPO) that targets your RD Session Hosts, and then select **Edit**. This operation opens the Group Policy Editor.
   - If you are managing Group Policy at the server level, open the Local Group Policy Editor on the RD Session Host.
1. Select **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.
1. Check the licensing mode and the list of licensing servers.
1. If it's necessary, fix the configuration.

For more information about licensing configurations, see [License Remote Desktop session hosts](/windows-server/remote/remote-desktop-services/rds-license-session-hosts#configure-licensing-for-an-rds-deployment-that-includes-only-the-rd-session-host-role-and-the-rd-licensing-role).

<a name="registry" ></a>You can use Registry Editor to check the licensing configuration. Open Registry Editor (or connect to the registry) on the RD Session Host. The subkeys that hold this information vary depending on how you manage your servers.

If you use Group Policy to manage RDS, check the following subkey and entries:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`
  - `LicenseServers` (string value)
  - `LicensingMode` (DWORD value)

If you use the Remote Desktop Services console in Server Manager, check the following subkeys and entries:

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\Licensing Core`
  - `LicensingMode` (DWORD value)

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService\Parameters\LicenseServers\SpecifiedLicenseServers`
  - `SpecifiedLicenseServers` (Multi-string value)
   > [!NOTE]  
   > This entry exists only if you used the Remote Desktop Services console to configure licensing.  

For more information about `LicensingMode`, see [LicensingMode](/windows-hardware/customize/desktop/unattend/microsoft-windows-terminalservices-remoteconnectionmanager-licensingmode#values).

### Check for blocked ports between the Remote Desktop Services servers

Make sure that the required ports are open on the firewalls between the RD Session Host and the RD Licensing server.

For lists of the ports that have to be open between the different RDS components, see the following articles:

- [RDS 2012: Which ports are used during deployment?](/archive/technet-wiki/16164.rds-2012-which-ports-are-used-during-deployment)
- [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

### Check the workgroup or domain configuration

If you deploy RDS across multiple domains, review the best practices and supportability for how to set up RD Licensing across domains, forests, or workgroups. For more information, see [Best practices for setting up RDS licensing across Active Directory domains/forests or work groups](set-up-remote-desktop-licensing-across-domains-forests-workgroups.md).

## Contact Microsoft Support

If the preceding steps don't resolve the issue, contact Microsoft Support for more help. Before you contact Microsoft Support, [gather relevant information by using TSS for user experience-related issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md).
