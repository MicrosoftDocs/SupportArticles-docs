---
title: Recover a gateway deployed through VMM
description: Describes how to recover gateways that are running Windows Server 2012 R2 and were deployed through Virtual Machine Manager.
ms.date: 03/12/2024
ms.reviewer: scottnap
---
# How to recover a gateway that was deployed through VMM and is running Windows Server 2012 R2

This article describes how to recover gateways that are running Windows Server 2012 R2 and were deployed through Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 R2  
_Original KB number:_ &nbsp; 3012571

## Summary

This article contains information about gateways that are running Windows Server 2012 R2 and were deployed through Virtual Machine Manager (VMM). The VMM server must be running Microsoft System Center 2012 R2. For background information about these gateways, see the following topics on the Microsoft website:

- [Windows Server Gateway](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn313101(v=ws.11)?redirectedfrom=MSDN)
- [How to Add a Windows Server Gateway in VMM in System Center 2012 R2](/previous-versions/system-center/system-center-2012-R2/dn249417(v=sc.12)?redirectedfrom=MSDN)

> [!IMPORTANT]
> Before you can follow the steps that are described in this article, you must apply [Update Rollup 4](https://support.microsoft.com/help/2992024) for System Center 2012 R2 VMM to your VMM management server.

This article describes two ways of recovering a gateway that is running Windows Server 2012 R2:

- [How to recover a gateway after failure of both virtual machines that support the gateway](#how-to-recover-a-gateway-after-failure-of-both-virtual-machines-that-support-the-gateway)
- [How to recover a gateway after failure of one virtual machine that supports the gateway](#how-to-recover-a-gateway-after-failure-of-one-virtual-machine-that-supports-the-gateway)

## How to recover a gateway after failure of both virtual machines that support the gateway

When you originally deployed the gateway that is running Windows Server 2012 R2 with VMM in System Center 2012 R2, you probably deployed it by using a VMM service template, as described in the following topic on the Microsoft website:

[How to Add a Windows Server Gateway in VMM in System Center 2012 R2](/previous-versions/system-center/system-center-2012-R2/dn249417(v=sc.12)?redirectedfrom=MSDN)

> [!NOTE]
> This service template helps you create a pair of virtual machines on a host cluster, and together the virtual machines and the cluster help provide high availability for the gateway that runs on them.

If both of the virtual machines that make up the gateway fail, and if you have [Update Rollup 4](https://support.microsoft.com/help/2992024) for Microsoft System Center 2012 R2 VMM installed, you can re-create the failed gateway by deploying a service template again. When you re-create the gateway, the names of the virtual machines can differ from before, and you can deploy them to a different host cluster. Other settings, such as the subnets that are specified in the network sites, must remain the same as when you originally deployed the gateway. The following procedures provide details.

### How to recover after failure of both virtual machines that support the gateway

1. In VMM, delete the service listing for the two virtual machines that supported the failed gateway. To do this, click **Show** on the **Home** tab in the **VMs and Services** workspace, and then click **Services**. Locate the host on which the virtual machines are deployed. In the details pane, right-click the service (not the individual virtual machines), and then click **Delete**. When you are prompted, confirm the deletion.

2. Optionally, if you are using the same virtual machine names as you used before, and you expect that the existing DNS entries will cause problems when you redeploy, arrange to have these DNS entries removed.

3. If you are using a new host cluster instead of recovering the gateway on the existing host cluster, make sure that the new hosts are configured as dedicated network virtualization gateways. To do this, follow these steps:

   1. In the **Fabric** workspace in VMM, make sure that **Fabric Resources** is selected in **Show** on the **Home** tab.
   2. In the **Fabric** pane, click **Servers**, expand the host group that contains the new host cluster, and then click the host cluster.
   3. In the **Hosts** pane, right-click one of the hosts (not the host cluster), and then click **Properties**.
   4. Click the **Host Access** tab, and then click to select the **This host is a dedicated network virtualization gateway, as a result it is not available for placement of virtual machines requiring network virtualization** check box. Then click **OK**.
   5. Repeat the process on the other host.

4. As you did for the original deployment, choose the appropriate service template (2-NIC or 3-NIC) for your environment. Review the settings in the service template to make sure that they are what you want for this deployment of the gateway.

   > [!IMPORTANT]
   > When you re-create the gateway, you must specify the same subnets in the network sites that you specified for the gateway that failed. However, the names of the virtual machines can be different, and you can deploy them to a different host cluster.

5. As you did for the original deployment, use the service template to deploy the virtual machines that will support the new gateway. Make sure that you deploy them on the intended hosts.

6. Do the following verification tasks to make sure that the service deployment was successful:

   1. Confirm that the back-end virtual network adapter on the gateway is not connected. (It should not be connected yet.) To do this, follow these steps:

      1. In the **VMs and Services** workspace in VMM, click **Services** in the **Show** group on the **Home** tab.
      2. Expand **All Hosts**, and then click the host group that the host cluster is in.
      3. In the **Services** pane, expand the service until you can see the gateway virtual machines.
      4. Right-click a gateway virtual machine, click **Properties**, and then click the **Hardware Configuration** tab in the properties sheet.
      5. Under **Network Adapters**, confirm that there are three network adapters and that one of them is labeled **Not connected**. Record the name of the adapter that is not connected.

   2. Start the new service, and then confirm that the virtual machines enter the **Running** state.
   3. With the virtual machines still running, on the VMM server, open a command prompt as an administrator, and then type `ping`, followed by the name or IP address of the gateway itself. Press Enter, and then confirm that a response is received from the gateway. If a response is not received, review possible causes, such as DNS settings, firewall settings, and the state of the gateway cluster.

7. Choose one of the new virtual machines as **primary**. Run the following Windows PowerShell  commands, substituting the name of the chosen virtual machine for _VMNAME_:

   ```PowerShell
   $vm = Get-SCVirtualMachine -Name "VMNAME"
   $vm.VirtualNetworkAdapters | ft Name,VMNetwork,VirtualNetwork
   ```

8. In the resulting display, look for the adapter that is not connected. For that adapter, `VMNetwork` and `VirtualNetwork` will be blank. Identify the number of that adapter as follows:

   |Adapter|Number|
   |---|---|
   |First adapter that is shown in the list:|0|
   |Second adapter that is show in the list:|1|
   |Third adapter that is shown in the list:|2|

9. Grant the MAC address that you identified in the earlier procedure to the network adapter that is not connected. To do this, run the following Windows PowerShell command. For _MACADDRESS_, substitute the MAC address, and for _NUMBER_, substitute the number (0, 1, or 2) that you identified in the previous step:

   ```powershell
   $mac = Grant-SCMACAddress -MACAddress MACADDRESS -MACAddressPool
   (Get-SCMACAddressPool -Name "Default MAC address pool") -VirtualNetworkAdapter
   $vm.VirtualNetworkAdapters[NUMBER]
   ```

10. Make sure that the virtual machine is stopped, and then apply the MAC address to the network adapter that is not connected. To do this, run the following Windows PowerShell commands. For _NUMBER_, substitute the same number (0, 1, or 2) that you used in the previous step:

    ```powershell
    Stop-SCVirtualMachine -vm $vm
    Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter
    $vm.VirtualNetworkAdapters[NUMBER] -EthernetAddress $mac.Address
    ```

11. Delete the old gateway configuration information so that it will not interfere with the new gateway. To do this, you will have to know the names of the hosts in the cluster that the gateway was on before it failed. (This might be the same cluster that it is currently on.) To do this, follow these steps:

    1. In any workspace in VMM, click **Window** on the **Home** tab, and then click **PowerShell**.
    2. Run the following commands. For _GATEWAY-NAME_, substitute the gateway name. For _HOST1_ and _HOST2_, substitute the computer names of the physical hosts that were in the host cluster when the gateway failed. Run these commands even if you are using the same cluster you were using before the gateway failed.

       ```powershell
       $svcName = "GATEWAY-NAME"
       $hostCredential = Get-Credential
       $gwHosts = @("HOST1", "HOST2")
       CleanupGatewaysBeforeMigration $svcName $gwHosts $hostCredential
       ```

12. Restart the virtual machine by running the following command:

    ```powershell
    Start-SCVirtualMachine -vm $vm
    ```

13. Update the connection string for the gateway as follows. Do this even if you are using the same host cluster and the same computer names for the virtual machines.

    1. Look up the existing connection string by running the following commands:

       ```powershell
       $ns = Get-SCNetworkService -Name $svcName
       $ns.ConnectionString
       ```

       For example, the connection string might resemble the following:

       > VMHost=GW-HV-CL01.contoso.com;GatewayVM=GW-VM-CL01.contoso.com;BackendSwitch=DatacenterSwitch

    2. Construct an updated version of the connection string by pasting the old string into a text editor such as Notepad and then updating it as follows. (Make sure that you leave the semicolons as-is.)

       - If the cluster name of the host cluster differs from what it was before, change the `VMHost=` setting.
       - If the computer name of the **primary** virtual machine differs from what it was before, change the `GatewayVM=` setting to the new name.

    3. Update the connection string by running the following command. When you run the command, substitute the correct connection string for _CONNECTIONSTRING_. Make sure that you include **;Migrate=true** at the end of the string inside the quotation marks, and `-Force` at the end after the last quotation mark.

       ```powershell
       Set-SCNetworkService -NetworkService $ns -ConnectionString "CONNECTIONSTRING;Migrate=true" -Force
       ```

    4. If the `Set-SCNetworkService` command reports any errors, fix them and run the command again.
14. From a tenant virtual machine that uses the gateway, test the gateway. For example, use a network command such as `ping`.

## How to recover a gateway after failure of one virtual machine that supports the gateway

If one of the virtual machines that support the gateway is functioning correctly but the other is not, you can use capabilities that are built into VMM services to **scale out** the gateway so that it again provides redundancy. To do this, follow these steps:

1. In your VMM environment, make sure that you have [Update Rollup 4](https://support.microsoft.com/help/2992024) for System Center 2012 R2 VMM installed.

   > [!NOTE]
   > You must install [Update Rollup 4](https://support.microsoft.com/help/2992024) before you can perform the recovery process that is described in these steps.

2. In VMM, remove the virtual machine that no longer functions. To do this, follow these steps:

   1. In the **VMs and Services** workspace, select the host group where you deployed the service that runs the gateway.
   2. In the **Show** group on the **Home** tab, click **Services**.
   3. In the **Services** pane, expand the service.
   4. Right-click the virtual machine that has failed, and then click **Delete**.
   5. When you are prompted, confirm the deletion.

3. In Failover Cluster Manager, evict the failed node from the guest cluster that supports the gateway. To do this, follow these steps:

   1. Open Failover Cluster Manager, expand the cluster in the console tree, expand **Nodes**, and then look at the status for each node. One node will be **Up**, and one node will be **Down**.
   2. Right-click the node that has a status of **Down**, click **More Actions**, and then click **Evict**.

4. In the **Services** pane, right-click the gateway service itself (not a virtual machine), and then click **Scale Out**.
5. On the **Select Tier** page in the Scale Out Tier wizard, click **Next**.
6. On the **Identity** page, enter a name for the new virtual machine, and then click **Next**.
7. On the **Select Host** page, make sure that you select the host that held the virtual machine that failed, and then click **Next**.
8. If the **Configure Settings** page appears, enter the computer name for the new virtual machine under **Operating System Settings**. Make sure that this computer name is not already being used by a computer in your environment.
9. Click **Next**.
10. On the **Add Properties** page, click **Next**.
11. On the **Summary** page, review your settings, and then click **Scale Out**.

    > [!NOTE]
    > You can track the progress of the scale out operation in the Jobs window. The operation can take 15 minutes or longer. You can perform other tasks in the VMM console while you monitor the job.

12. After the **Create Virtual Machine** job is completed successfully, verify that the new virtual machine was added and that it is started in the **VMs and Services** workspace. The new node will probably start to function within about five minutes.
13. To verify that the gateway is functioning, connect to the new virtual machine, and then run `Get-NetCompartment` at a Windows PowerShell prompt. If multiple compartments are listed, the new virtual machine is functioning and will help provide high availability for the gateway.
