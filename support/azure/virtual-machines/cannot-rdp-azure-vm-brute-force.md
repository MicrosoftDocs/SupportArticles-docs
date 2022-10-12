---
title: Cannot RDP into Azure VM because of a brute force attack
description: Troubleshoot RDP failures because of brute force attack in Microsoft Azure.
ms.date: 12/14/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
---

# Cannot RDP into Azure VM because of a brute force attack

Open ports on Internet-facing virtual machines are targets for brute force attacks. This article describes general errors you may experience when your Azure virtual machine (VM) is under attack and best practices for securing your VM.

## Symptoms

1. When you make a Remote Desktop Protocol (RDP) connection to a Windows VM in Azure, you may receive the following general error messages:

    - An internal error has occurred.
    - Remote Desktop Services session has ended. Your network administrator might have ended the connection. Try connecting again, or contact technical support for assistance.

2. You're unable to RDP using the Public IP address, but you may be able to RDP using the Private IP address. This issue will depend on whether you have a performance spike because of the attack.

3. There are many failed logon attempts in the Security Event Logs:

   - Events 4625 from the logon is logged almost every second, with the failure reason **Bad Username Or Password**.

   :::image type="content" source="media/cannot-rdp-azure-vm-brute-force/events-log.png" alt-text="Screenshot of failed logon attempts Events 4625 in the Security Event Logs.":::

   :::image type="content" source="media/cannot-rdp-azure-vm-brute-force/event-properties.png" alt-text="Screenshot of the Event Properties - Event 4625 window, which shows the Failure Reason is Unknown users name or bad password." border="false":::

### Connect to the VM using Serial console

If you are unable to successfully RDP to the VM you can try using PowerShell and [Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows) to check for the log entries.

1. On the command line, launch PowerShell by running `powershell.exe`.

2. In PowerShell, execute this command:

   ```ps
   remove-module psreadline
   Get-WinEvent -FilterHashtable @{LogName='Security'; StartTime=(Get-Date).AddDays(-1); Id='4625'}
   ```

You can alternately use [Remote PowerShell](/azure/virtual-machines/troubleshooting/remote-tools-troubleshoot-azure-vm-issues#remote-powershell) to execute the Get-WinEvent command.

## Cause

If there are many recent log entries indicating failed logon attempts the VM may be experiencing a brute force attack and will need to be secured. This activity may be consuming the RDP service resources preventing you from being able to successfully connect via RDP.

## Solution

In this scenario the RDP TCP Port 3389 is exposed to the internet, please use one or more of the methods listed below to increase security for the VM:

1. Use [Just-In-Time access](/azure/security-center/just-in-time-explained) to secure the public facing ports of your VM.

2. Use [Azure Bastion](/azure/bastion/) to connect securely via the Azure portal, and [block RDP traffic from the Internet](/azure/virtual-network/network-security-groups-overview#security-rules) in your Network Security Group (NSG).

3. Use a [VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) to provide an encrypted tunnel between your computer and your VMs, and [block RDP traffic from the Internet](/azure/virtual-network/network-security-groups-overview#security-rules) in your Network Security Group (NSG).

4. Edit your Network Security Group (NSG) to be more restrictive. Only allow specific internet protocols (IPs) or a range of IPs that belong to your organization in your inbound rule for RDP:

   For your inbound RDP (TCP Port 3389) rule, if the Source is set to "Any" or " * " then the rule is considered open. To improve the security of the rule, [restrict the RDP port to a specific user's IP address](/azure/virtual-network/network-security-groups-overview#security-rules), and then test RDP access again.

5. Use [Run Command](/azure/virtual-machines/windows/run-command) to change the default RDP port from 3389 to a less common port number. This is not suggested as a long-term fix, but may help to temporarily mitigate the attack and regain access to the VM, we suggest using [Just-In-Time access](/azure/security-center/just-in-time-explained), [Azure Bastion](/azure/bastion/), or [VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways).

   :::image type="content" source="media/cannot-rdp-azure-vm-brute-force/setrdpport-command.png" alt-text="Screenshot of the description of the SetRDPPort command in the Run command page of Azure Portal.":::

> [!NOTE]
> Use [Azure Security Centre](https://azure.microsoft.com/services/security-center/) to assess the security state of your cloud resources. Visualize your security state, and improve your security posture by using [Azure Secure Score](/azure/security-center/secure-score-security-controls) recommendations.

## Next Steps

- [Azure best practices for network security](/azure/security/fundamentals/network-best-practices)
- [The virtual datacenter: A network perspective](/azure/cloud-adoption-framework/reference/networking-vdc)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
