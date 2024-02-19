---
title: Cannot connect to RDS because no RD Licensing servers are available
description: This article describes how to troubleshoot RDS connection errors that are related to Remote Desktop licensing.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
keywords: RD Licensing server, RD CAL
---
# Cannot connect to RDS because no RD Licensing servers are available

This article help you troubleshoot the "No licenses available" error in a deployment that includes an Remote Desktop Session Host (RDSH) server and a Remote Desktop Licensing server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

## Symptoms

Clients cannot connect to Remote Desktop Services, and they display messages that resemble the following:

```output
The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license.
```

```output
Access was denied because of a security error.
```

Sign in to the RD Session Host as a domain administrator and open the RD License Diagnoser. Look for messages like the following:

```output
The grace period for the Remote Desktop Session Host server has expired, but the RD Session Host server hasn't been configured with any license servers. Connections to the RD Session Host server will be denied unless a license server is configured for the RD Session Host server.
```

```output
License server <computer name> is not available. This could be caused by network connectivity problems, the Remote Desktop Licensing service is stopped on the license server, or RD Licensing isn't available.
```

## Cause

These issue could be caused by the following user messages:

- The remote session was disconnected because there are no Remote Desktop client access licenses available for this computer.
- The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license.

In this case, [check the RD Licensing configuration](#check-the-rd-licensing-configuration).

If the RD License Diagnoser lists other problems, such as "The RDP protocol component X.224 detected an error in the protocol stream and has disconnected the client", there may be a problem that affects the license certificates. Such problems tend to be associated with user messages, such as the following:

Because of a security error, the client could not connect to the Terminal server. After making sure that you are signed in to the network, try connecting to the server again.

In this case, [refresh the X509 Certificate registry keys](#refresh-the-x509-certificate-registry-keys).

## Check the RD Licensing configuration

You can check the RD Licensing configuration by using Server Manager and RD Licensing Manager. Verify the following:

- The RD Licensing role is installed and the license server is activated.  

   > [!NOTE]  
   > For more information about this configuration, see [Activate the Remote Desktop Services license server](/windows-server/remote/remote-desktop-services/rds-activate-license-server).  

- The license server has a client access license (CAL) for each user and device that can connect to RDS.
  
   > [!NOTE]  
   > For more information about this configuration, see [Install RDS client access licenses on the Remote Desktop license server](/windows-server/remote/remote-desktop-services/rds-install-cals).  

   The configuration of the licenses should resemble the following screenshot. There should be a green check mark beside the license server name, and the numbers in the columns should reflect the numbers of total and available licenses.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/rd-licensing-manager-config.png" alt-text="RD Licensing Manager, showing a correctly configured license server.":::

- The RDS deployment uses the correct license server, licensing mode, and policy settings. The details of the configuration depend on the type of deployment that you have:

  - [Configure licensing for an RDS deployment that includes the Remote Desktop Connection Broker (RD Connection Broker) role](#rdcb).
  - [Configure licensing for an RDS deployment that includes only the Remote Desktop Session Host (RD Session Host) role and the RD Licensing role](#nordcb).

### <a id=rdcb></a>Configure licensing for an RDS deployment that includes the RD Connection Broker role

1. On the RD Connection Broker computer, open Server Manager.
2. In Server Manager, select **Remote Desktop Services** > **Overview** > **Edit Deployment Properties** > **RD Licensing**.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/server-manager-rd-config.png" alt-text="Select the Edit Deployment Properties option to open the Remote Desktop licensing settings in Server Manager.":::

3. Select the Remote Desktop licensing mode (either **Per User** or **Per Device**, as appropriate for your deployment).

   > [!NOTE]  
   > If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs are not permitted.
4. Specify a license server, and then select **Add**.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/rdlicensing-configure.png" alt-text="Configure the deployment of the RD Licensing.":::

### <a id=nordcb></a>Configure licensing for an RDS deployment that includes only the RD Session Host role and the RD Licensing role

1. On the RD Session Host computer, select **Start**, and then enter **gpedit.msc** to open Local Group Policy Editor.
2. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-editor-licensing-config.png" alt-text="List of policies for Remote Desktop licensing.":::

3. In the policy list, right-click **Use the specified Remote Desktop license servers**, and then select **Properties**.
4. Select **Enabled**, and then enter the name of the license server under **License servers to use**. If you have more than one license server, use commas to separate their names.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-specify-license-server.png" alt-text="Set the license servers to use in the Use the specified Remote Desktop license servers dialog box.":::

5. Select **OK**.  
6. In the policy list, right-click **Set the Remote Desktop licensing mode**, and then select **Properties**.
7. Select **Enabled**.
8. Under **Specify the licensing mode for the Remote Desktop Session Host server**, select **Per Device** or **Per User**, as appropriate for your deployment.

   :::image type="content" source="media/cannot-connect-rds-no-license-server/local-gp-specify-licensing-mode.png" alt-text="Specify the licensing mode for the Remote Desktop Session Host server in the Set the Remote Desktop licensing mode dialog box.":::

## Refresh the X509 Certificate registry keys

> [!IMPORTANT]  
> Follow this section's instructions carefully. Serious problems can occur if the registry is modified incorrectly. Before you starty modifying the registry, [back up the registry](https://support.microsoft.com/help/322756) so you can restore it in case something goes wrong.

To resolve this problem, back up and then remove the X509 Certificate registry keys, restart the computer, and then reactivate the RD Licensing server. Follow these steps.

> [!NOTE]
> Perform the following procedure on each of the RDSH servers.

Here's how to reactivate the RD Licensing server:

1. Open the Registry Editory and navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\RCM**.
2. On the Registry menu, select **Export Registry File**.
3. Enter **exported- Certificate** into the **File name** box, then select **Save**.
4. Right-click each of the following values, select **Delete**, and then select **Yes** to verify the deletion:  
   - **Certificate**
   - **X509 Certificate**
   - **X509 Certificate ID**
   - **X509 Certificate2**

## Additional troubleshooting methods

If you verify that the licensing configuration is correct, but the system still isn't correctly issuing CALs, follow these steps:

1. [Use RD Licensing Diagnoser to check for issues](#extra1)
2. [Make sure that the versions of your RDS CALs, RD Session Hosts, and RD License Servers are compatible](#extra2)
3. [Make sure that you're using the appropriate type of RDS CAL for your RDS environment](#extra3)

### <a id="extra1"></a>Step 1: Use RD Licensing Diagnoser to check for issues

To open RD Licensing Diagnoser, open Server Manager, and select **Tools** > **Terminal Services** > **RD Licensing Diagnoser**.

:::image type="content" source="media/cannot-connect-rds-no-license-server/rd-licensing-diagnoser-information.png" alt-text="Screenshot of the RD Licensing Diagnoser dialog box.":::

The top window of the RD Licensing Diagnoser lists problems that the diagnoser has detected. For example, you might see a message that resembles the following:

> Licenses are not available for this Remote Desktop Session Host server, and RD Licensing Diagnoser has identified licensing problems for the RD Session Host Server

The **RD Licensing Diagnoser Information** section shows more information about the problem, including its possible causes and the steps to follow to remediate it.

### <a id="extra2"></a>Step 2: Make sure that the versions of your RDS CALs, RD Session Hosts, and RD License Servers are compatible

The following table shows which RDS CAL and RD Session Host versions are compatible with one another.

| |RDS 2008 R2 and earlier CAL |RDS 2012 CAL |RDS 2016 CAL |RDS 2019 CAL |
| --- | --- | --- | --- | --- |
|**2008, 2008 R2 session host** |Yes |Yes |Yes |Yes |
|**2012 session host** |No |Yes |Yes |Yes |
|**2012 R2 session host** |No |Yes |Yes |Yes |
|**2016 session host** |No |No |Yes |Yes |
|**2019 session host** |No |No |No |Yes |

The following table shows which RDS CAL and license server versions are compatible with one another.

| |RDS 2008 R2 and earlier CAL |RDS 2012 CAL |RDS 2016 CAL |RDS 2019 CAL |
| --- | --- | --- | --- | --- |
|**2008, 2008 R2 license server** |Yes |No |No |No |
|**2012 license server** |Yes |Yes |No |No |
|**2012 R2 license server** |Yes |Yes |No |No |
|**2016 license server** |Yes |Yes |Yes |No |
|**2019 license server** |Yes |Yes |Yes |Yes |

For more information, see [RDS CAL version compatibility](/windows-server/remote/remote-desktop-services/rds-client-access-license#rds-cal-version-compatibility).

### <a id="extra3"></a>Step 3: Make sure that you're using the appropriate type of RDS CAL for your RDS environment

If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs aren't permitted.
