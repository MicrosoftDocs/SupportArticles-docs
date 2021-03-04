---
title: Cannot connect to RDS because there are no RD Licensing servers available to issue licenses
description: This article describes how to troubleshoot RDS connection issues that are related to Remote Desktop licensing.
ms.date: 03/09/2021
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Remote Desktop Services (Terminal Services) licensing
ms.technology: windows-server-rds
keywords: RD Licensing server, RD CAL
---

# Cannot connect to RDS because there are no RD Licensing servers available to issue licenses

This article describes how to troubleshoot RDS connection issues that are related to Remote Desktop licensing.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

## Symptoms

Clients cannot connect to Remote Desktop Services, and they receive messages that resemble the following:

> The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license.

## Cause

This situation usually indicates a problem in the Remote Desktop licensing configuration.

## Resolution

First, [check the RD Licensing configuration](#check-the-rd-licensing-configuration). If you still have problems, check the [additional troubleshooting methods](#additional-troubleshooting-methods).

### Check the RD Licensing configuration

You can check the RD Licensing configuration by using Server Manager and RD Licensing Manager. Verify the following:

- The RD Licensing role is installed and the license server  is activated.  

   > [!NOTE]  
   > For more information about this configuration, see [Activate the Remote Desktop Services license server](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/rds-activate-license-server).  

- The license server has a client access license (CAL) for each user and device that can connect to RDS.
   > [!NOTE]  
   > For more information about this configuration, see [Install RDS client access licenses on the Remote Desktop license server](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/rds-install-cals).  

   The configuration of the licenses should resemble the following.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/rd-licensing -manager-config.png" alt-text="RD Licensing Manager, showing a correctly configured license server":::

- The RDS deployment uses the correct license server, licensing mode, and policy settings. The details of the configuration depend on the type of deployment that you have:

  - [RDS deployment that includes the Remote Desktop Connection Broker (RD Connection Broker) role](#rdcb).
  - [RDS deployment that consists of only the Remote Desktop Session Host (RD Session Host) role and the RD Licensing role](#nordcb).

#### <a id=rdcb></a>Configure licensing for an RDS deployment that includes the RD Connection Broker role

1. On the RD Connection Broker computer, open Server Manager.
2. In Server Manager, select **Remote Desktop Services** > **Overview** > **Edit Deployment Properties** > **RD Licensing**.
   :::image type="content" source="media/cannot-connect-rds-no-license-server/server-manager-rd-config.png" alt-text="Remote Desktop licensing settings in Server Manager":::
3. Select the Remote Desktop licensing mode (either **Per User** or  **Per Device**, as appropriate for your deployment).
   > [!NOTE]  
   > If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs are not permitted.
4. Specify a license server.

#### <a id=nordcb></a>Configure licensing for an RDS deployment that consists of only the RD Session Host role and the RD Licensing role

1. On the RD Session Host computer, select **Start** and then enter **gpedit.msc** to open the Local Group Policy Editor.
2. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.
   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-editor-licensing-config.png" alt-text="List of policies for Remote Desktop licensing":::
3. In the policy list, right-click **Use the specified Remote Desktop license servers** and then select **Properties**.
4. Select **Enabled**, and then under **License servers to use**, enter the name of the license server. If you have more than one license server, use commas to separate their names.
   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-specify-license-server.png" alt-text="Policy settings for Remote Desktop license servers":::
5. Select **OK**, and then in the policy list, right-click **Set the Remote Desktop licensing mode** and then select **Properties**.
6. Select **Enabled**, and then under **Specify the licensing mode for the Remote Desktop Session Host server** select **Per Device** or **Per User**, as appropriate for your deployment.
   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-specify-licensing-mode.png" alt-text="Policy settings for Remote Desktop licensing mode":::

### Additional troubleshooting methods

If you have verified that the licensing configuration is correct and the system still isn't correctly issuing CALs, follow these steps.

1. [Use RD Licensing Diagnoser to check for issues](#extra1)
2. [Make sure that the versions of your RDS CALs, RD Session Hosts, and RD License Servers are compatible](#extra2)
3. [Make sure that you're using the appropriate type of RDS CAL for your RDS environment](#extra3)

#### <a id="extra1"></a>1. Use RD Licensing Diagnoser to check for issues

To open RD Licensing Diagnoser, in Server Manager, select **Tools** > **Terminal Services** > **RD Licensing Diagnoser**.

:::image type="content" source="media/cannot-connect-rds-no-license-server/rd-licensing-diagnoser-information.png" alt-text="RD Licensing Diagnoser":::

The top window of the RD Licensing Diagnoser lists issues that the diagnoser has found. For example, you may see a message that resembles the following:

> Licenses are not available for this Remote Desktop Session Host server, and RD Licensing Diagnoser has identified licensing problems for the RD Session Host Server

The **RD Licensing Diagnoser Information** section shows more information about the issue, including its possible causes and steps to follow to remediate it.

#### <a id="extra2"></a>2. Make sure that the versions of your RDS CALs, RD Session Hosts, and RD License Servers are compatible

The following table shows which RDS CAL and RD Session Host versions are compatible with each other.

| |RDS 2008 R2 and earlier CAL |RDS 2012 CAL |RDS 2016 CAL |RDS 2019 CAL |
| --- | --- | --- | --- | --- |
|**2008, 2008 R2 session host** |Yes |Yes |Yes |Yes |
|**2012 session host** |No |Yes |Yes |Yes |
|**2012 R2 session host** |No |Yes |Yes |Yes |
|**2016 session host** |No |No |Yes |Yes |
|**2019 session host** |No |No |No |Yes |

The following table shows which RDS CAL and license server versions are compatible with each other.

| |RDS 2008 R2 and earlier CAL |RDS 2012 CAL |RDS 2016 CAL |RDS 2019 CAL |
| --- | --- | --- | --- | --- |
|**2008, 2008 R2 license server** |Yes |No |No |No |
|**2012 license server** |Yes |Yes |No |No |
|**2012 R2 license server** |Yes |Yes |No |No |
|**2016 license server** |Yes |Yes |Yes |No |
|**2019 license server** |Yes |Yes |Yes |Yes |

For more information, see [RDS CAL version compatibility](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/rds-client-access-license#rds-cal-version-compatibility).

#### <a id="extra3"></a>3. Make sure that you're using the appropriate type of RDS CAL for your RDS environment

If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs aren't permitted.
