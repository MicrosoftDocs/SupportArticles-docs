---
title: Advanced troubleshooting for PXE boot issues
description: Advance troubleshooting techniques to help administrators diagnose and resolve PXE boot failures in Configuration Manager.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\PXE
ms.reviewer: kaushika, frankroj
---
# Advanced troubleshooting for PXE boot issues in Configuration Manager

This article provides advance troubleshooting techniques to help administrators diagnose and resolve PXE boot failures in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4491871

## Introduction

For essential information about how PXE works, see the companion article [Understand PXE boot in ConfigMgr](understand-pxe-boot.md).

The solutions that are provided in [Troubleshooting PXE boot issues in Configuration Manager section](troubleshoot-pxe-boot-issues.md) can resolve most issues that affect PXE boot.

If you can't resolve your PXE boot issue by using IP Helpers or reinstalling PXE, try the following troubleshooting steps.

## Special consideration when co-hosting DHCP and WDS on the same server

When Dynamic Host Configuration Protocol (DHCP) and WDS are co-hosted on the same computer, WDS requires a special configuration to listen on a specific port. This configuration is outlined in [Windows Deployment Service and Dynamic Host Configuration Protocol (DHCP)](/previous-versions/system-center/system-center-2012-R2/hh397405(v=technet.10)#windows-deployment-service-and-dynamic-host-configuration-protocol-dhcp). According to this article, you must complete the following actions if WDS and DHCP are co-hosted on the same server:

1. Set the `UseDHCPPorts` value to **0** in the following registry location:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSPXE`

2. Run the following WDS command:

   ```console
   WDSUTIL /Set-Server /UseDHCPPorts:No /DHCPOption60:Yes
   ```

This recommendation requires that you configure WDS to run the `WDSUTIL` command. This recommendation conflicts with the best practice not to configure WDS when you install a ConfigMgr PXE-enabled DP. However, you can configure the two settings that are specified in the `WDSUTIL` command (`UseDHCPPorts` and `DHCPOption60`) by using alternative methods that don't require the `WDSUTIL` command. This way you don't have to configure WDS.

To configure these settings without having WDS enabled, follow these guidelines:

- The `UseDHCPPorts` switch for `WDSUTIL` is actually the equivalent of setting the `UseDHCPPorts` registry key to a value of **0** in the following location:

  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSPXE`

  Using the `UseDHCPPorts` switch isn't necessary if the registry key is manually set. If WDS wasn't installed, this registry key may not exist.

- The `DHCPOption60` switch configures an option for the DHCP service, not for the WDS service. Instead of using `WDSUTIL` to set this DHCP option, you can use an equivalent DHCP command to set the same option. To do it, use the `netsh` command, as described in [Configuring DHCP for Remote Boot Services](/previous-versions/windows/embedded/dd128762%28v=winembedded.51%29).

  To configure the WDS options according to these guidelines, close any DHCP consoles that are open, and then run the following commands at an elevated command prompt:
  
  ```console
  netsh dhcp server \\<DHCP_server_machine_name> add optiondef 60 PXEClient String 0 comment=PXE support
  ```

  ```console
  netsh dhcp server \\<DHCP_server_machine_name> set optionvalue 60 STRING PXEClient
  ```
  
  These commands set up and enable DHCP Option 60 on a DHCP server. After you run these commands, if an option that is named `Unknown` is displayed instead of `060 PXE Client` in the DHCP console, restart the server so that these settings can take effect. After the restart, the option should be displayed correctly. This issue usually occurs only if a DHCP console was left open when the two commands were run.

If DHCP is ever moved to another server and removed from the server that's hosting WDS, these steps should be reversed. Follow these steps on the WDS server:

1. Run the following command at an elevated command prompt:

   ```console
   REG ADD HKLM\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSPXE /v UseDHCPPorts /t REG_DWORD /d 1 /f
   ```

2. Run the following commands at an elevated command prompt:

   ```console
   netsh dhcp server \\<DHCP_server_machine_name> delete optionvalue 60
   ```

   ```console
   netsh dhcp server \\<DHCP_server_machine_name> delete optiondef 60 PXEClient
   ```

   > [!NOTE]
   > The first of these commands disables DHCP option 60. The second command removes DHCP option 60 completely.

## Troubleshooting DHCP Discovery

Before you start to troubleshoot the initial DHCP discovery stage of the PXE booting process, consider the following points:

- In SMSPXE.log, you should see the MAC address or the **DHCPREQUEST** of the device that you're trying to start. If you don't see that, a router configuration issue might exist between the client and the DP.
- Don't use DHCP options 60, 66, or 67. **It isn't supported**.
- Test whether the device can start when it's plugged into a switch on the same subnet as the PXE-enabled DP. If it can, the issue likely involves the router configuration.
- Make sure that the DHCP (67 and 68), TFTP (69), and BINL (4011) ports are open between the client computer, the DHCP server, and the PXE DP.

At this stage, there are no logs to refer to. A PXE error code is usually displayed if the PXE boot process fails before WinPE starts. Here are examples of the error messages that you might see:

- PXE-E51: No DHCP or proxyDHCP offers were received.
- PXE-E52: proxyDHCP offers were received. No DHCP offers were received.
- PXE-E53: No boot filename received.
- PXE-E55: proxyDHCP service did not reply to request on port 4011.
- PXE-E77 bad or missing discovery server list.
- PXE-E78: Could not locate boot server.

Although it helps narrow the focus of troubleshooting, you might still have to capture a network trace of the issue by using a network monitoring tool, such as Netmon or [WireShark](https://www.wireshark.org/download.html). The network monitoring tool must be installed on both the PXE-enabled DP and a computer that's connected to a mirrored port on the switch. For more information about how to configure mirrored ports, refer to the manual provided by the manufacturer of the specific switch or routing device.

The typical procedure is to start the network traces on both the DP and the computer that's connected to the mirrored port. Try to start the device through PXE. Then, stop the trace, and save it for further analysis.

Here is a sample trace of a DHCP conversation that was captured from the PXE-enabled DP:

:::image type="content" source="media/advanced-troubleshooting-pxe-boot/dhcp-conversation-trace.png" alt-text="Screenshot of the trace of a DHCP conversation.":::

You can see that the initial **DHCPDISCOVER** by the PXE client is followed by a **DHCPOFFER** from the DHCP server and the PXE DP. The request from the client (0.0.0.0) is made and then acknowledged by the DHCP server (10.238.0.14). After the PXE client has an IP address (10.238.0.3), it sends a request to the PXE DP (10.238.0.2). That DP then acknowledges the request by returning the network boot program details.

Capture a simultaneous network trace on the client and the DP to determine whether the conversation is occurring as expected. Follow these guidelines:

- Make sure that the DHCP services are running and available.
- Verify that the WDS service is running on the DP.
- Make sure that no firewalls are blocking the DHCP ports between the server and the client.
- Verify that the client computer can start when it is on the same subnet as the DP.
- Make sure that IP Helpers are configured correctly if the client computer is starting from a different subnet than the one that the DP is in.

## Troubleshooting TFTP Transfer

If the error on PXE boot refers to TFTP, you may be unable to transfer the boot files. The following are examples of the error messages that you may receive:

- PXE-E32: TFTP open timeout
- PXE-E35: TFTP read timeout
- PXE-E36: Error received from TFTP server
- PXE-E3F: TFTP packet size is invalid
- PXE-E3B: TFTP Error - File not Found
- PXE-T04: Access Violation

A good way to troubleshoot these errors is to monitor the network by using Netmon or Wireshark. Below is an example of the data captured from a PXE client when a TFTP Open time-out occurs.

:::image type="content" source="media/advanced-troubleshooting-pxe-boot/pxe-client-data.png" alt-text="Screenshot shows the data when a TFTP Open time-out occurs.":::

Here the client is sending read requests for the Wdsnbp.com file, but it isn't receiving a response. It indicates that something is preventing the acknowledgment from being received by the client. Here's what the data should look like.

:::image type="content" source="media/advanced-troubleshooting-pxe-boot/send-read-request-data.png" alt-text="Screenshot shows the data for sending read requests without receiving a response.":::

In this situation, you can try the following troubleshooting methods:

- Reduce the block size on the PXE-enabled DP, see KB [975710](https://support.microsoft.com/help/975710/operating-system-deployment-over-a-network-by-using-wds-fails-in-windo).
- Verify that the WDS service is started on the DP.
- Make sure that the TFTP port is open between the client computer and the DP.
- Verify that the permissions on the REMINST share and folder are correct.
- Check the WDS logs for other TFTP errors.
- Verify that the `RemoteInstall\SMSBoot\x86` and `RemoteInstall\SMSBoot\x64` folders contain the following files:

    :::image type="content" source="media/advanced-troubleshooting-pxe-boot/files.png" alt-text="Screenshot of the files in the RemoteInstall\SMSBoot folder.":::

- Make sure that the fonts exist in `SMSBoot\Fonts` folder:

    :::image type="content" source="media/advanced-troubleshooting-pxe-boot/fonts.png" alt-text="Screenshot of the SMSBoot\Fonts folder.":::

- Make sure that the Boot.sdi file exists in the `RemoteInstall\SMSBoot` folder:

    :::image type="content" source="media/advanced-troubleshooting-pxe-boot/boot-sdi-file.png" alt-text="Screenshot of the RemoteInstall\SMSBoot folder.":::

## Windows PE startup issues - drivers

The most common issues that occur during this phase are driver-related. Overall, the latest version of Windows PE (WinPE) contains most network and mass storage drivers. Sometimes a required driver isn't included. So it must be imported into the boot WIM. The following guidelines apply to this process:

- Import only the drivers that you need for the boot image.
- Consider adding only NIC or mass storage drivers. Other drivers aren't required.

The SMSTS.log file (located in \<_SystemDrive_>:\Windows\temp\SMSTS) is the most useful resource to troubleshoot these issues. (Remember to enable the command prompt during startup so that you can examine this file.) If you don't see a log entry that has a valid IP address and resembles the following entry, you're probably experiencing a driver issue:

```output
SMSTS.log  
Found network adapter "Intel 21140-Based PCI Fast Ethernet Adapter (Emulated)" with IP Address <IP address>
```

To verify this situation, press F8, and then run `IPCONFIG` at the command prompt to determine whether the NIC is recognized and has a valid IP address.

### WIM Files

Also make sure that both x86 and x64 boot images exist on the DP. You can see the WIMs in the following directory, they'll also be in the content library:

`C:\RemoteInstall\SMSImages\<PackageID>`

Make sure that **Deploy this boot image from the PXE-enabled distribution point** is set in the properties of the boot images.

## Configuration Manager Policy issues

Another common issue that affects PXE boot involves Task Sequence deployments. In the following example, the Task Sequence is deployed to an unknown computer, but it's already in the database. The first symptom is that the PXE boot is aborted.

:::image type="content" source="media/advanced-troubleshooting-pxe-boot/task-sequence-deployment.png" alt-text="Screenshot shows the Task Sequence is deployed to an unknown computer.":::

Upon further investigation, you notice the following entry in the SMSPXE log:

```output
SMSPXE.log  
Client lookup reply: <ClientIDReply><Identification Unknown="0" ItemKey="16777299" ServerName=""><Machine><ClientID/><NetbiosName/></Machine></Identification></ClientIDReply>  
MP_LookupDevice succeeded: 16777299 1 16777299 1 0  
00:15:5D:00:19:CA, 32E5B71A-B626-4A4B-902E-7F94AD38B5B3: device is in the database.  
Client boot action reply: <ClientIDReply><Identification Unknown="0" ItemKey="16777299" ServerName=""><Machine><ClientID/><NetbiosName/></Machine></Identification><PXEBootAction LastPXEAdvertisementID="" LastPXEAdvertisementTime="" OfferID="" OfferIDTime="" PkgID="" PackageVersion="" packagePath="" BootImageID="" Mandatory=""/></ClientIDReply>  
Client Identity:  
00:15:5D:00:19:CA, 32E5B71A-B626-4A4B-902E-7F94AD38B5B3: SMSID= OfferID=, PackageID=, PackageVersion=, BootImageID=, PackagePath=, Mandatory=0  
00:15:5D:00:19:CA, 32E5B71A-B626-4A4B-902E-7F94AD38B5B3: no advertisements found  
00:15:5D:00:19:CA, 32E5B71A-B626-4A4B-902E-7F94AD38B5B3: No boot action. Aborted.  
00:15:5D:00:19:CA, 32E5B71A-B626-4A4B-902E-7F94AD38B5B3: Not serviced.
```

You can see in this entry that when the NBS stored procedures ran, they found no available policy. So the boot action was aborted. The reverse can also be true. That is, when a computer is unknown but the Task Sequence is deployed to a collection of known computers.

You can try the following troubleshooting steps:

- Verify that the computer that you try to restart exists in a collection that's targeted for a Task Sequence deployment.
- Make sure that you've checked the **Enable unknown computer support PXE** setting on the DP.
- If you are deploying the Task Sequence to unknown computers, verify that the computers don't already exist in the database.

## Need more help

For more help to resolve this issue, see our [TechNet support forum](https://social.technet.microsoft.com/Forums/home?forum=configmanagerosd&filter=alltypes&sort=lastpostdesc) or [contact Microsoft Support](https://support.microsoft.com/).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
