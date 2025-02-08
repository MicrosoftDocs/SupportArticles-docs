---
title: Cannot connect with RDP to a Windows VM in Azure
description: Troubleshoot issues when you cannot connect to your Windows virtual machine in Azure using Remote Desktop
keywords: Remote desktop error,remote desktop connection error,cannot connect to VM,remote desktop troubleshooting
services: virtual-machines
author: genlin
manager: dcscontentpm
tags: top-support-issue,azure-service-management,azure-resource-manager
ms.custom: sap:Cannot connect to my VM, devx-track-azurepowershell
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 07/22/2024
ms.author: genli
---
# Troubleshoot Remote Desktop connections to an Azure virtual machine

**Applies to:** :heavy_check_mark: Windows VMs

The Remote Desktop Protocol (RDP) connection to your Windows-based Azure virtual machine (VM) can fail for various reasons, leaving you unable to access your VM. The issue can be with the Remote Desktop service on the VM, the network connection, or the Remote Desktop client on your host computer. This article guides you through some of the most common methods to resolve RDP connection issues.

<a id="quickfixrdp"></a>

> [!IMPORTANT]
> **Before you begin**, take advantage of resource-specific diagnostics, with interactive step-by-step workflows, and detailed troubleshooting guides tailored to your Azure Windows VM connectivity issue. 
> Go to the <a href="https://portal.azure.com" target="_blank">Azure portal</a>, click the **Help(?)** icon, and provide your problem and resource details.

## Troubleshooting steps

After each troubleshooting step, try reconnecting to the VM:

1. Reset Remote Desktop configuration.
2. Check Network Security Group rules / Cloud Services endpoints.
3. Review VM console logs.
4. Reset the NIC for the VM.
5. Check the VM Resource Health.
6. Reset your VM password.
7. Restart your VM.
8. Redeploy your VM.

Continue reading if you need more detailed steps and explanations. Verify that local network equipment such as routers and firewalls are not blocking outbound TCP port 3389, as noted in [detailed RDP troubleshooting scenarios](detailed-troubleshoot-rdp.md).

> [!TIP]
> If the **Connect** button for your VM is grayed out in the portal and you are not connected to Azure via an [Express Route](/azure/expressroute/expressroute-introduction) or [Site-to-Site VPN](/azure/vpn-gateway/tutorial-site-to-site-portal) connection, you need to create and assign your VM a public IP address before you can use RDP. You can read more about [public IP addresses in Azure](/azure/virtual-network/public-ip-addresses).

## Ways to troubleshoot RDP issues

You can troubleshoot VMs created using the Resource Manager deployment model by using one of the following methods:

* Azure portal - great if you need to quickly reset the RDP configuration or user credentials and you don't have the Azure tools installed.
* Azure PowerShell - if you are comfortable with a PowerShell prompt, quickly reset the RDP configuration or user credentials using the Azure PowerShell cmdlets.

<a id="fix-common-remote-desktop-errors"></a>

## Troubleshoot using the Azure portal

After each troubleshooting step, try connecting to your VM again. If you still cannot connect, try the next step.

1. **Reset your RDP connection**. This troubleshooting step resets the RDP configuration when Remote Connections are disabled or Windows Firewall rules are blocking RDP, for example.

    Select your VM in the Azure portal. Scroll down the settings pane to the **Help** section near bottom of the list. Click the **Reset password** button. Set the **Mode** to **Reset configuration only** and then click the **Update** button:

    :::image type="content" source="media/troubleshoot-rdp-connection/reset-rdp.png" alt-text="Screenshot of the Mode setting window of the Reset password tab, in which the Reset configuration only option is selected." border="true":::
2. **Verify Network Security Group rules**. Use [IP flow verify](/azure/network-watcher/diagnose-vm-network-traffic-filtering-problem) to confirm if a rule in a Network Security Group is blocking traffic to or from a virtual machine. You can also review effective security group rules to ensure inbound "Allow" NSG rule exists and is prioritized for RDP port(default 3389). For more information, see [Using Effective Security Rules to troubleshoot VM traffic flow](/azure/virtual-network/diagnose-network-traffic-filter-problem).

3. **Review VM boot diagnostics**. This troubleshooting step reviews the VM console logs to determine if the VM is reporting an issue. Not all VMs have boot diagnostics enabled, so this troubleshooting step may be optional.

    Specific troubleshooting steps are beyond the scope of this article, but may indicate a wider problem that is affecting RDP connectivity. For more information on reviewing the console logs and VM screenshot, see [Boot Diagnostics for VMs](boot-diagnostics.md).

4. **Reset the NIC for the VM**. For more information, see [how to reset NIC for Azure Windows VM](./reset-network-interface.md).
5. **Check the VM Resource Health**. This troubleshooting step verifies there are no known issues with the Azure platform that may impact connectivity to the VM.

    Select your VM in the Azure portal. Scroll down the settings pane to the **Help** section near bottom of the list. Click the **Resource health** button. A healthy VM reports as being **Available**:

    :::image type="content" source="media/troubleshoot-rdp-connection/check-resource-health.png" alt-text="Screenshot of a healthy V M report, which shows There aren't any known Azure platform problems affecting this virtual machine." border="true":::
6. **Reset user credentials**. This troubleshooting step resets the password on a local administrator account when you are unsure or have forgotten the credentials.  Once you have logged into the VM, you should reset the password for that user.

    Select your VM in the Azure portal. Scroll down the settings pane to the **Help** section near bottom of the list. Click the **Reset password** button. Make sure the **Mode** is set to **Reset password** and then enter your username and a new password. Finally, click the **Update** button:

    :::image type="content" source="media/troubleshoot-rdp-connection/reset-password.png" alt-text="Screenshot of the setting window of Reset Password when the Mode is set to Reset password." border="true":::
7. **Restart your VM**. This troubleshooting step can correct any underlying issues the VM itself is having. Select your VM in the Azure portal and click the **Overview** tab. Click the **Restart** button.

8. **Redeploy your VM**. This troubleshooting step redeploys your VM to another host within Azure to correct any underlying platform or networking issues.

    Select your VM in the Azure portal. Scroll down the settings pane to the **Help** section near bottom of the list. Click the **Redeploy** button, and then click **Redeploy**:

    :::image type="content" source="media/troubleshoot-rdp-connection/redeploy-vm.png" alt-text="Screenshot of the Redeploy button in the setting window of the Redeploy tab." border="true":::

    After this operation finishes, ephemeral disk data is lost and dynamic IP addresses that are associated with the VM are updated.

9. **Verify routing**. Use Network Watcher's [Next hop](/azure/network-watcher/diagnose-vm-network-routing-problem) capability to confirm that a route isn't preventing traffic from being routed to or from a virtual machine. You can also review effective routes to see all effective routes for a network interface. For more information, see [Using effective routes to troubleshoot VM traffic flow](/azure/virtual-network/diagnose-network-routing-problem).

10. Ensure that any on-premises firewall, or firewall on your computer, allows outbound TCP 3389 traffic to Azure.

If you are still encountering RDP issues, you can [open a support request](https://azure.microsoft.com/support/options/) or read [more detailed RDP troubleshooting concepts and steps](detailed-troubleshoot-rdp.md).

## Troubleshoot using Azure PowerShell

If you haven't already, [install and configure the latest Azure PowerShell](/powershell/azure/).

The following examples use variables such as `myResourceGroup`, `myVM`, and `myVMAccessExtension`. Replace these variable names and locations with your own values.

> [!NOTE]
> You reset the user credentials and the RDP configuration by using the [Set-AzVMAccessExtension](/powershell/module/az.compute/set-azvmaccessextension) PowerShell cmdlet. In the following examples, `myVMAccessExtension` is a name that you specify as part of the process. If you have previously worked with the VMAccessAgent, you can get the name of the existing extension by using `Get-AzVM -ResourceGroupName "myResourceGroup" -Name "myVM"` to check the properties of the VM. To view the name, look under the 'Extensions' section of the output.

After each troubleshooting step, try connecting to your VM again. If you still cannot connect, try the next step.

1. **Reset your RDP connection**. This troubleshooting step resets the RDP configuration when Remote Connections are disabled or Windows Firewall rules are blocking RDP, for example.

    The follow example resets the RDP connection on a VM named `myVM` in the `WestUS` location and in the resource group named `myResourceGroup`:

    ```powershell
    Set-AzVMAccessExtension -ResourceGroupName "myResourceGroup" `
        -VMName "myVM" -Location Westus -Name "myVMAccessExtension"
    ```

2. **Verify Network Security Group rules**. This troubleshooting step verifies that you have a rule in your Network Security Group to permit RDP traffic. The default port for RDP is TCP port 3389. A rule to permit RDP traffic may not be created automatically when you create your VM.

    First, assign all the configuration data for your Network Security Group to the `$rules` variable. The following example obtains information about the Network Security Group named `myNetworkSecurityGroup` in the resource group named `myResourceGroup`:

    ```powershell
    $rules = Get-AzNetworkSecurityGroup -ResourceGroupName "myResourceGroup" `
        -Name "myNetworkSecurityGroup"
    ```

    Now, view the rules that are configured for this Network Security Group. Verify that a rule exists to allow TCP port 3389 for inbound connections as follows:

    ```powershell
    $rules.SecurityRules
    ```

    The following example shows a valid security rule that permits RDP traffic. You can see `Protocol`, `DestinationPortRange`, `Access`, and `Direction` are configured correctly:

    ```powershell
    Name                     : default-allow-rdp
    Id                       : /subscriptions/guid/resourceGroups/myResourceGroup/providers/Microsoft.Network/networkSecurityGroups/myNetworkSecurityGroup/securityRules/default-allow-rdp
    Etag                     : 
    ProvisioningState        : Succeeded
    Description              : 
    Protocol                 : TCP
    SourcePortRange          : *
    DestinationPortRange     : 3389
    SourceAddressPrefix      : *
    DestinationAddressPrefix : *
    Access                   : Allow
    Priority                 : 1000
    Direction                : Inbound
    ```

    If you do not have a rule that allows RDP traffic, [create a Network Security Group rule](/azure/virtual-machines/windows/nsg-quickstart-powershell). Allow TCP port 3389.
3. **Reset user credentials**. This troubleshooting step resets the password on the local administrator account that you specify when you are unsure of, or have forgotten, the credentials.

    First, specify the username and a new password by assigning credentials to the `$cred` variable as follows:

    ```powershell
    $cred=Get-Credential
    ```

    Now, update the credentials on your VM. The following example updates the credentials on a VM named `myVM` in the `WestUS` location and in the resource group named `myResourceGroup`:

    ```powershell
    Set-AzVMAccessExtension -ResourceGroupName "myResourceGroup" `
        -VMName "myVM" -Location WestUS -Name "myVMAccessExtension" `
        -UserName $cred.GetNetworkCredential().Username `
        -Password $cred.GetNetworkCredential().Password
    ```

4. **Restart your VM**. This troubleshooting step can correct any underlying issues the VM itself is having.

    The following example restarts the VM named `myVM` in the resource group named `myResourceGroup`:

    ```powershell
    Restart-AzVM -ResourceGroup "myResourceGroup" -Name "myVM"
    ```

5. **Redeploy your VM**. This troubleshooting step redeploys your VM to another host within Azure to correct any underlying platform or networking issues.

    The following example redeploys the VM named `myVM` in the `WestUS` location and in the resource group named `myResourceGroup`:

    ```powershell
    Set-AzVM -Redeploy -ResourceGroupName "myResourceGroup" -Name "myVM"
    ```

6. **Verify routing**. Use Network Watcher's [Next hop](/azure/network-watcher/diagnose-vm-network-routing-problem) capability to confirm that a route isn't preventing traffic from being routed to or from a virtual machine. You can also review effective routes to see all effective routes for a network interface. For more information, see [Using effective routes to troubleshoot VM traffic flow](/azure/virtual-network/diagnose-network-routing-problem).

7. Ensure that any on-premises firewall, or firewall on your computer, allows outbound TCP 3389 traffic to Azure.

If you are still encountering RDP issues, you can [open a support request](https://azure.microsoft.com/support/options/) or read [more detailed RDP troubleshooting concepts and steps](detailed-troubleshoot-rdp.md).

## Troubleshoot specific RDP errors

You may encounter a specific error message when trying to connect to your VM via RDP. The following are the most common error messages:

* [The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license](troubleshoot-specific-rdp-errors.md#rdplicense).
* [Remote Desktop can't find the computer "name"](troubleshoot-specific-rdp-errors.md#rdpname).
* [An authentication error has occurred. The Local Security Authority cannot be contacted](troubleshoot-specific-rdp-errors.md#rdpauth).
* [Windows Security error: Your credentials did not work](troubleshoot-specific-rdp-errors.md#wincred).
* [This computer can't connect to the remote computer](troubleshoot-specific-rdp-errors.md#rdpconnect).

<a name='troubleshoot-sign-in-issues-when-users-rdp-with-azure-ad-credentials'></a>

## Troubleshoot sign-in issues when users RDP with Microsoft Entra credentials

You may receive the following common errors when you try to RDP with Microsoft Entra credentials: "no Azure roles assigned", "unauthorized client", or "two-factor authentication sign-in method required". Refer to the following articles to fix these issues:

* [Your account is configured to prevent you from using this device. For more info, contact your system administrator](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows#azure-role-not-assigned).
* [Windows Security error: Your credentials did not work. Unauthorized client](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows#unauthorized-client-or-password-change-required).
* [Windows Security error: Your credentials did not work. Password change required](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows#unauthorized-client-or-password-change-required).
* [The sign-in method you're trying to use isn't allowed. Try a different sign-in method or contact your system administrator](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows#mfa-sign-in-method-required).

## Additional resources

If none of these errors occurred and you still can't connect to the VM via Remote Desktop, read the detailed [troubleshooting guide for Remote Desktop](detailed-troubleshoot-rdp.md).

* For troubleshooting steps in accessing applications running on a VM, see [Troubleshoot access to an application running on an Azure VM](./troubleshoot-app-connection.md?toc=/azure/virtual-machines/linux/toc.json).
* If you are having issues using Secure Shell (SSH) to connect to a Linux VM in Azure, see [Troubleshoot SSH connections to a Linux VM in Azure](../linux/troubleshoot-ssh-connection.md?toc=/azure/virtual-machines/linux/toc.json).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
