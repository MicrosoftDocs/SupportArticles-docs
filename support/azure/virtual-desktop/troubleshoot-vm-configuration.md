---
title: Troubleshoot Azure Virtual Desktop session host
description: Helps resolve issues when you're configuring Azure Virtual Desktop session host virtual machines.
author: dknappettmsft
ms.topic: troubleshooting
ms.date: 05/11/2020
ms.author: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot session host virtual machine configuration

This article helps troubleshoot issues you're having when configuring the Azure Virtual Desktop session host virtual machines (VMs).

## Provide feedback

Visit the [Azure Virtual Desktop Tech Community](https://techcommunity.microsoft.com/t5/azure-virtual-desktop/bd-p/AzureVirtualDesktopForum) to discuss the Azure Virtual Desktop service with the product team and active community members.

## VMs aren't joined to the domain

Follow these instructions if you're having issues joining virtual machines (VMs) to the domain.

- Join the VM manually using the process in [Join a Windows Server virtual machine to a managed domain](/azure/virtual-desktop/../active-directory-domain-services/join-windows-vm) or using the [domain join template](https://azure.microsoft.com/resources/templates/vm-domain-join-existing/).
- Try pinging the domain name from a command line on the VM.
- Review the list of domain join error messages in [Troubleshooting Domain Join Error Messages](https://social.technet.microsoft.com/wiki/contents/articles/1935.troubleshooting-domain-join-error-messages.aspx).

### Error: Incorrect credentials

#### Cause

There was a typo made when the credentials were entered in the Azure Resource Manager template interface fixes.

#### Resolution

Take one of the following actions to resolve the issue:

- Manually add the VMs to a domain.
- Redeploy the template once credentials have been confirmed. See [Create a host pool with PowerShell](/azure/virtual-desktop/create-host-pools-powershell).
- Join VMs to a domain using a template with [Joins an existing Windows VM to AD Domain](https://azure.microsoft.com/resources/templates/vm-domain-join-existing/).

### Error: Timeout waiting for user input

#### Cause

The account used to complete the domain join might have multifactor authentication (MFA).

#### Resolution

Take one of the following actions to resolve the issue:

- Temporarily remove MFA for the account.
- Use a service account.

### Error: The account used during provisioning doesn't have permissions to complete the operation

#### Cause

The account being used doesn't have permissions to join VMs to the domain due to compliance and regulations.

#### Resolution

Take one of the following actions to resolve.

- Use an account that is a member of the Administrator group.
- Grant the necessary permissions to the account being used.

### Error: Domain name doesn't resolve

#### Cause 1

VMs are on a virtual network that's not associated with the virtual network where the domain is located.

#### Resolution 1

Create virtual network peering between the virtual network where VMs were provisioned and the virtual network where the domain controller (DC) is running. See [Create a virtual network peering - Resource Manager, different subscriptions](/azure/virtual-desktop/../virtual-network/create-peering-different-subscriptions).

#### Cause 2

When using Microsoft Entra Domain Services, the virtual network doesn't have its Domain Name System (DNS) server settings updated to point to the managed domain controllers.

#### Resolution 2

To update the DNS settings for the virtual network containing Microsoft Entra Domain Services, see [Update DNS settings for the Azure virtual network](/azure/active-directory-domain-services/tutorial-create-instance#update-dns-settings-for-the-azure-virtual-network).

#### Cause 3

The network interface's DNS server settings don't point to the appropriate DNS server on the virtual network.

#### Resolution 3

Take one of the following actions to resolve the issue by following the steps in [Change DNS servers](/azure/virtual-network/virtual-network-network-interface#change-dns-servers):

- Change the network interface's DNS server settings to **Custom** with the steps from [Change DNS servers](/azure/virtual-network/virtual-network-network-interface#change-dns-servers) and specify the private IP addresses of the DNS servers on the virtual network.
- Change the network interface's DNS server settings to **Inherit from virtual network** with the steps from [Change DNS servers](/azure/virtual-network/virtual-network-network-interface#change-dns-servers), and then change the virtual network's DNS server settings with the steps from [Change DNS servers](/azure/virtual-network/manage-virtual-network#change-dns-servers).

### Error: Computer account reuse is blocked in an Active Directory domain

#### Cause

You attempt to reuse a computer account (hostname), have applied Windows updates released on and after October 11, 2022, and the user account provided for the domain doesn't have sufficient permissions to reuse computer accounts.

#### Resolution

Take one of the following actions to resolve the issue:

- Use the same user account that was used to create the existing computer account object.
- Use a user account that is a member of the **Domain Administrators** security group.
- Use a user account that has the Group Policy setting **Domain controller: Allow computer account re-use during domain join** applied. This setting requires the installation of Windows updates released on or after March 14, 2023, on all member computers and domain controllers in the Active Directory domain.

For more information on the permissions changes for computer account reuse, see [KB5020276 - Netjoin: Domain join hardening changes](https://support.microsoft.com/en-us/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

## Azure Virtual Desktop Agent and Azure Virtual Desktop Boot Loader aren't installed

The recommended way to provision VMs is using the Azure portal creation template. The template automatically installs the Azure Virtual Desktop Agent and Azure Virtual Desktop Agent Boot Loader.

Follow these instructions to confirm the components are installed and to check for error messages.

1. Confirm that the two components are installed by checking in **Control Panel** > **Programs** > **Programs and Features**. If **Azure Virtual Desktop Agent** and **Azure Virtual Desktop Agent Boot Loader** aren't visible, they aren't installed on the VM.
2. Open **File Explorer** and navigate to **C:\\Windows\\Temp\\ScriptLog.log**. If the file is missing, it indicates that the PowerShell Desired State Configuration (DSC) that installed the two components wasn't able to run in the security context provided.
3. If the file **C:\\Windows\\Temp\\ScriptLog.log** exists, open it and check for error messages.

### Error: Azure Virtual Desktop Agent and Azure Virtual Desktop Agent Boot Loader are missing. C:\\Windows\\Temp\\ScriptLog.log is also missing

#### Cause 1

Credentials provided during input for the Azure Resource Manager template were incorrect or permissions were insufficient.

#### Resolution 1

Manually add the missing components to the VMs using [Create a host pool with PowerShell](/azure/virtual-desktop/create-host-pools-powershell).

#### Cause 2

PowerShell DSC was able to start and execute but failed to complete as it can't sign in to Azure Virtual Desktop and obtain needed information.

#### Resolution 2

Confirm the items in the following list.

- Make sure the account doesn't have MFA.
- Confirm the host pool's name is accurate and the host pool exists in Azure Virtual Desktop.
- Confirm the account has at least Contributor permissions on the Azure subscription or resource group.

### Error: Authentication failed, error in C:\\Windows\\Temp\\ScriptLog.log

#### Cause

PowerShell DSC was able to execute but couldn't connect to Azure Virtual Desktop.

#### Resolution

Confirm the items in the following list.

- Manually register the VMs with the Azure Virtual Desktop service.
- Confirm the account used for connecting to Azure Virtual Desktop has permissions on the Azure subscription or resource group to create host pools.
- Confirm the account doesn't have MFA.

## Azure Virtual Desktop Agent isn't registering with the Azure Virtual Desktop service

When the Azure Virtual Desktop Agent is first installed on session host VMs (either manually or through the Azure Resource Manager template and PowerShell DSC), it provides a registration token. The following section covers troubleshooting issues that apply to the Azure Virtual Desktop Agent and the token.

### Error: The status filed in Get-AzWvdSessionHost cmdlet shows status as Unavailable

#### Cause

The agent isn't able to update itself to a new version.

#### Resolution

Follow these instructions to manually update the agent:

1. Download a new version of the agent on the session host VM.
2. Launch Task Manager. In the **Service** tab, stop the **RDAgentBootLoader** service.
3. Run the installer for the new version of the Azure Virtual Desktop Agent.
4. When prompted for the registration token, remove the entry **INVALID_TOKEN** and press next (a new token isn't required).
5. Complete the installation Wizard.
6. Open Task Manager and start the **RDAgentBootLoader** service.

## Error: Azure Virtual Desktop Agent registry entry IsRegistered shows a value of zero

#### Cause

Registration token has expired.

#### Resolution

Follow these instructions to fix the agent registry error:

1. If there's already a registration token, remove it with `Remove-AzWvdRegistrationInfo`.
2. Run the `New-AzWvdRegistrationInfo` cmdlet to generate a new token.
3. Confirm that the `-ExpirationTime` parameter is set to three days.

### Error: Azure Virtual Desktop agent isn't reporting a heartbeat when running Get-AzWvdSessionHost

#### Cause 1

RDAgentBootLoader service has been stopped.

#### Resolution 1

Launch Task Manager. If the **Service** tab reports a stopped status for **RDAgentBootLoader** service, start the service.

#### Cause 2

Port 443 might be closed.

#### Resolution 2

Follow these instructions to open port 443:

1. Confirm port 443 is open by downloading the PSPing tool from [Sysinternal tools](/sysinternals/downloads/psping/).
2. Install PSPing on the session host VM where the agent is running.
3. Open the command prompt as an administrator and run the following command:

    ```console
    psping rdbroker.wvdselfhost.microsoft.com:443
    ```

4. Confirm that PSPing received information back from the `RDBroker`:

    ```output
    PsPing v2.10 - PsPing - ping, latency, bandwidth measurement utility
    Copyright (C) 2012-2016 Mark Russinovich
    Sysinternals - www.sysinternals.com
    TCP connect to <IP Address>:443:
    5 iterations (warmup 1) ping test:
    Connecting to <IP Address>:443 (warmup): from 172.20.17.140:60649: 2.00ms
    Connecting to <IP Address>:443: from 172.20.17.140:60650: 3.83ms
    Connecting to <IP Address>:443: from 172.20.17.140:60652: 2.21ms
    Connecting to <IP Address>:443: from 172.20.17.140:60653: 2.14ms
    Connecting to <IP Address>:443: from 172.20.17.140:60654: 2.12ms
    TCP connect statistics for <IP Address>:443:
    Sent = 4, Received = 4, Lost = 0 (0% loss),
    Minimum = 2.12ms, Maximum = 3.83ms, Average = 2.58ms
    ```

## Troubleshoot issues with the Azure Virtual Desktop side-by-side stack

There are three main ways to install or enable the side-by-side stack on session host pool VMs:

- With the Azure portal creation template
- By being included and enabled on the master image
- Installed or enabled manually on each VM (or with extensions/PowerShell)

If you're having issues with the Azure Virtual Desktop side-by-side stack, type the `qwinsta` command from the command prompt to confirm that the side-by-side stack is installed or enabled.

The output of `qwinsta` will list `rdp-sxs` in the output if the side-by-side stack is installed and enabled.

:::image type="content" source="media/troubleshoot-vm-configuration/administrator-command-prompt.png" alt-text="Screenshot of the side-by-side stack installed or enabled with qwinsta listed as rdp-sxs in the output.":::

Examine the registry entries listed and confirm that their values match. If registry keys are missing or values are mismatched, make sure you're running [a supported operating system](troubleshoot-agent.md#error-operating-a-pro-vm-or-other-unsupported-os). If you are, follow the instructions in [Register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool#register-session-hosts-to-a-host-pool) for how to reinstall the side-by-side stack.

- Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\rds-sxs`  
  Value name: `fEnableWinstation`  
  Value type: `DWORD`  
  Value data: `1`  
- Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\ClusterSettings`  
  Value name: `SessionDirectoryListener`  
  Value data: `rdp-sxs`

### Error: O_REVERSE_CONNECT_STACK_FAILURE

#### Cause

The side-by-side stack isn't installed on the session host VM.

#### Resolution

Follow these instructions to install the side-by-side stack on the session host VM:

1. Use Remote Desktop Protocol (RDP) to get directly into the session host VM as local administrator.
2. Install the side-by-side stack by following the steps to [Register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool#register-session-hosts-to-a-host-pool).

## How to fix an Azure Virtual Desktop side-by-side stack that malfunctions

There are known circumstances that can cause the side-by-side stack to malfunction:

- Not following the correct order of the steps to enable the side-by-side stack
- Auto update to Windows 10 Enhanced Versatile Disc (EVD)
- Missing the Remote Desktop Session Host (RDSH) role

The instructions in this section can help you uninstall the Azure Virtual Desktop side-by-side stack. Once you uninstall the side-by-side stack, follow the steps to [register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool#register-session-hosts-to-a-host-pool) to reinstall the side-by-side stack.

The VM used to run remediation must be on the same subnet and domain as the VM with the malfunctioning side-by-side stack.

Follow these instructions to run remediation from the same subnet and domain:

1. Connect with standard Remote Desktop Protocol (RDP) to the VM from where fix will be applied.
2. [Download and install PsExec](/sysinternals/downloads/psexec).
3. Start a command prompt as local administrator, and then navigate to folder where PsExec was unzipped.
4. From the command prompt, use the following command where `<VMname>` is the hostname name of the VM with the malfunctioning side-by-side stack. If this is the first time you have run PsExec, you'll also need to accept the PsExec License Agreement to continue by selecting **Agree**.

    ```console
    psexec.exe \\<VMname> cmd
    ```

5. After the command prompt session opens on the VM with the malfunctioning side-by-side stack, run the following command and confirm that an entry named `rdp-sxs` is available. If not, a side-by-side stack doesn't exist on the VM so the issue isn't tied to the side-by-side stack.

   ```console
   qwinsta
   ```

    :::image type="content" source="media/troubleshoot-vm-configuration/administrator-command-prompt.png" alt-text="Screenshot of the Administrator Command Prompt showing the output the qwinsta command.":::

6. Run the following command, which will list Microsoft components installed on the VM with the malfunctioning side-by-side stack.

    ```console
    wmic product get name
    ```

7. Run the following command with product names from the preceding step, for example:

    ```console
    wmic product where name="<Remote Desktop Services Infrastructure Agent>" call uninstall
    ```

8. Uninstall all products that start with **Remote Desktop**.
9. After all Azure Virtual Desktop components have been uninstalled, restart the VM that had the malfunctioning side-by-side stack (either with Azure portal or from the PsExec tool). You can then reinstall the side-by-side stack by following the steps to [register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool#register-session-hosts-to-a-host-pool).

## Remote Desktop licensing mode isn't configured

If you sign in to Windows 10 Enterprise multi-session using an administrative account, you might receive a notification that says, "Remote Desktop licensing mode isn't configured, Remote Desktop Services will stop working in *X* days. On the Connection Broker server, use Server Manager to specify the Remote Desktop licensing mode."

If the time limit expires, the following error message will appear:

> The remote session was disconnected because there are no Remote Desktop client access licenses available for this computer.

If you see either of these messages, it means the image doesn't have the latest Windows updates installed or you're setting the Remote Desktop licensing mode through group policy. Follow the steps in the next sections to check the group policy setting, identify the version of Windows 10 Enterprise multi-session, and install the corresponding update.

> [!NOTE]
> Azure Virtual Desktop only requires a Remote Desktop Services (RDS) client access license (CAL) when your host pool contains Windows Server session hosts. For more information on configuring an RDS CAL, see [License your RDS deployment with client access licenses](/windows-server/remote/remote-desktop-services/rds-client-access-license/).

### Disable the Remote Desktop licensing mode group policy setting

Check the group policy setting by opening the Group Policy Editor in the VM and navigating to **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing** > **Set the Remote Desktop licensing mode**. If the group policy setting is **Enabled**, change it to **Disabled**. If it's already disabled, then leave it as-is.

> [!NOTE]
> If you set group policy through your domain, disable this setting on policies that target these Windows 10 Enterprise multi-session VMs.

### Identify which version of Windows 10 Enterprise multi-session you're using

To check which version of Windows 10 Enterprise multi-session you have:

1. Sign in with your admin account.
2. Enter **About** into the search bar next to the Start menu.
3. Select **About your PC**.
4. Check the number next to **Version**. The number should be either **1809** or **1903**, as shown in the following image.

    :::image type="content" source="media/troubleshoot-vm-configuration/windows-specifications.png" alt-text="Screenshot of the Windows specifications window with the version number highlighted.":::

Now that you know your version number, skip ahead to the relevant section.

### Version 1809

If your version number says **1809**, install [the KB4516077 update](https://support.microsoft.com/help/4516077).

### Version 1903

Redeploy the host operating system with the latest version of the Windows 10, version 1903 image from the Azure Gallery.

## We couldn't connect to the remote PC because of a security error

If your users see the following error:

> We couldn't connect to the remote PC because of a security error. If this keeps happening, ask your admin or tech support for help.

Validate any existing policies that change default RDP permissions. One policy that might cause this error to appear is the **Allow log on through Remote Desktop Services** security policy.

For more information about this policy, see [Allow log on through Remote Desktop Services](/windows/security/threat-protection/security-policy-settings/allow-log-on-through-remote-desktop-services).

## I can't deploy the golden image

Golden images must not include the Azure Virtual Desktop agent. You can install the agent only after you deploy the golden image.

## Next steps

- For an overview on troubleshooting Azure Virtual Desktop and the escalation tracks, see [Troubleshooting overview, feedback, and support](/azure/virtual-desktop/troubleshoot-set-up-overview).
- To troubleshoot issues while creating a host pool in an Azure Virtual Desktop environment, see [Environment and host pool creation](/azure/virtual-desktop/troubleshoot-set-up-issues).
- To troubleshoot issues while configuring a virtual machine (VM) in Azure Virtual Desktop, see [Session host virtual machine configuration](/azure/virtual-desktop/troubleshoot-vm-configuration).
- To troubleshoot issues related to the Azure Virtual Desktop agent or session connectivity, see [Troubleshoot common Azure Virtual Desktop Agent issues](/azure/virtual-desktop/troubleshoot-agent).
- To troubleshoot issues with Azure Virtual Desktop client connections, see [Azure Virtual Desktop service connections](/azure/virtual-desktop/troubleshoot-service-connection).
- To troubleshoot issues with Remote Desktop clients, see [Troubleshoot the Remote Desktop client](/azure/virtual-desktop/troubleshoot-client-windows)
- To troubleshoot issues when using PowerShell with Azure Virtual Desktop, see [Azure Virtual Desktop PowerShell](/azure/virtual-desktop/troubleshoot-powershell).
- For more information about the service, see [Azure Virtual Desktop environment](/azure/virtual-desktop/environment-setup).
- To go through a troubleshoot tutorial, see [Tutorial: Troubleshoot Resource Manager template deployments](/azure/virtual-desktop/../azure-resource-manager/templates/template-tutorial-troubleshoot).
- For more information about auditing actions, see [Audit operations with Resource Manager](/azure/azure-monitor/essentials/activity-log).
- For more information about actions to determine the errors during deployment, see [View deployment operations](/azure/virtual-desktop/../azure-resource-manager/templates/deployment-history).
