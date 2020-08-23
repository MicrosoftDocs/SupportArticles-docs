---
title: Designating a host fails with error 2912
description: Fixes an issue in which you get error 2912 when trying to designate a host that's in a workgroup in System Center Essentials 2010.
ms.date: 08/18/2020
ms.prod-support-area-path: 
---
# Designating a host that's in a workgroup fails with error 2912 in System Center Essentials 2010

This article helps you fix an issue in which you get error 2912 when trying to designate a host that's in a workgroup in System Center Essentials (SCE) 2010.

_Original product version:_ &nbsp; System Center Essentials 2010  
_Original KB number:_ &nbsp; 2471159

## Symptoms

You're using System Center Essentials 2010 and you try to designate a host that is in a workgroup and not in a domain. The result is that it fails with the following error:

> Error (2912)  
> An internal error has occurred trying to contact an agent on the \<server-name> server.
>
> Recommended Action  
> Ensure the agent is installed and running. Ensure the WS-Management service is installed and running, then restart the agent.

## Cause

This issue can occur when the host isn't in the domain and instead is in a workgroup, causing the authentication between them to fail.

Also SCE from its SCE console, doesn't support or in graphical user interface (GUI) of designating a host, doesn't give an option of adding a host from perimeter network. So you have to manually add the perimeter host using Virtual Machine Manager (VMM) PowerShell available on the SCE server.

## Resolution

1. Connect to the host computer via Remote Desktop Protocol (RDP), and then uninstall the Virtual Machine Manager agent from **Control Panel** > **Add or remove programs**. (If it's already installed manually).
2. Using source media for SCE, manually install the VMM agent from CD drive *x:\setup\vmm\amd64\SetupVMM.exe*, select option to install **Local Agent**.
3. In this wizard, select the **This host is on a perimeter network** option and specify password for security file encryption key and don't select to use CA certificate.
4. Select **Use Local computer name** > **Next** > **Install**.
5. This installs the VMM agent on that host. (You have to copy that SecurityFile.txt file from the host server to the SCE server).
6. On the SCE server, start Windows PowerShell.
7. Run the following commands to add the host:

   1. ```powershell
      Get-VMMServer -ComputerName "<SCE-server-FQDN>"
      ```

      This connects to the SCE server which is also a VMM server.

   2. ```powershell
      $Key = Get-Credential
      ```

      This prompts for user name and password, specify user name as Administrator and password as same which you specified during manual agent installation and generating the security key.

   3. ```powershell
      Add-VMHost "<hostname>" -Description "Perimeter host" -RemoteConnectEnabled $False -PerimeterNetworkHost -SecurityFile "C:\temp\SecurityFile.txt" -EncryptionKey $Key
      ```

      Location of the security file is any location where you copied file from the host to the SCE server.

8. Now the host should get added.
9. You may see below event in Virtual Machine Manager event log on the SCE server:

    > Log Name: VM Manager  
    > Source: Virtual Machine Manager  
    > Date: <date, time>  
    > Event ID: 1705  
    > Task Category: None  
    > Level: Information  
    > Keywords: Classic  
    > User: N/A  
    > Computer: \<SCE-server-name>  
    > Description:  
    > Job \<ID> (Add perimeter network host) completed successfully.

10. In the SCE console, you'll see this computer as a host.
11. In the SCE console, under **All Virtual Machines**, you'll see virtual machines hosted by this host.
12. When connecting to it, you may get prompted for credentials. After supplying correct user name and password, it shows one more prompt saying certificate isn't trusted.
13. From this prompt click **View Certificate**, go to **Details** tab, select **Copy to file**, export the certificate as a .cer file.
14. From the SCE server, open MMC console > **Certificate Snap-in**, and then import this certificate under **Trusted Root Certification Authorities**.
15. Exit and reopen the SCE console.
16. Now, the SCE console should be able to see the host, all virtual machines, and connect to all virtual machines.

## More information

You can designate and configure servers as hosts for virtual machines in Essentials 2010 from the Essentials management server or from the Essentials console. You can also set up and manage the virtual machines on hosts in trusted domains, workgroups, or perimeter networks. For more information, see [About Virtualization Management in Essentials](/previous-versions/system-center/essentials-2010/ff603625(v=technet.10)).
