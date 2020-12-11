---
title: How to block specific network protocols and ports by using IPSec
description: Describes how to block specific network protocols and ports by using Internet Protocol security (IPSec).
ms.date: 12/03/2020
uthor: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, rhensing
ms.prod-support-area-path: Internet Protocol security (IPSec)
ms.technology: WindowsSecurity
---
# How to block specific network protocols and ports by using IPSec

This article describes how to block specific network protocols and ports by using Internet Protocol security (IPSec).

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 813878

## Summary

IPSec filtering rules can be used to help protect Windows 2000-based, Windows XP-based, and Windows Server 2003-based computers from network-based attacks from threats such as viruses and worms. This article describes how to filter a particular protocol and port combination for both inbound and outbound network traffic. It includes steps to whether there are any IPSec policies currently assigned to a Windows 2000-based, Windows XP-based, or Windows Server 2003-based computer, steps to create and assign a new IPSec policy, and steps to unassign and delete an IPSec policy.

IPSec policies can be applied locally or be applied to a member of a domain as part of that domain's group policies. Local IPSec policies can be *static* (persistent after restarts) or *dynamic* (volatile). Static IPSec policies are written to the local registry and persist after the operating system is restarted. Dynamic IPSec policies are not permanently written to the registry and are removed if the operating system or the IPSec Policy Agent service is restarted.

> [!IMPORTANT]
> This article contains information about editing the registry by using Ipsecpol.exe. Before editing the registry, make sure you understand how to restore it if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](/troubleshoot/windows-server/performance/windows-registry-advanced-users).

> [!NOTE]
> IPSec filter rules can cause network programs to lose data and to stop responding to network requests, including failure to authenticate users. Use IPSec filter rules as a defensive measure of last resort and only after you have a clear understanding of the impact that blocking specific ports will have in your environment. If an IPSec policy that you create by using the steps that are listed in this article has unwanted effects on your network programs, see the "Unassign and Delete an IPSec Policy" section later in this article for instructions about how to immediately disable and delete the policy.

## Determine whether an IPSec policy is assigned

- Windows Server 2003-based computers

    Before you create or assign any new IPSec policies to a Windows Server 2003-based computer, determine whether any IPSec policies are being applied from the local registry or through a Group Policy object (GPO). To do this, follow these steps:

    1. Install Netdiag.exe from the Windows Server 2003 CD by running Suptools.msi from the Support\\Tools folder.
    2. Open a command prompt, and then set the working folder to C:\\Program Files\\Support Tools.
    3. Run the following command to verify that there is not an existing IPSec policy already assigned to the computer:

        ```console
        netdiag /test:ipsec
        ```

        If no policy is assigned, you receive the following message:

        > IP Security test . . . . . . . . . : Passed IPSec policy service is active, but no policy is assigned.

- Windows XP-based computers

    Before you create or assign any new IPSec policies to a Windows XP-based computer, determine whether any IPSec policies are being applied from the local registry or through a GPO. To do this, follow these steps:

    1. Install Netdiag.exe from the Windows XP CD by running Setup.exe from the Support\\Tools folder.
    2. Open a command prompt, and then set the working folder to C:\\Program Files\\Support Tools.
    3. Run the following command to verify that there is not an existing IPSec policy already assigned to the computer:

        ```console
        netdiag /test:ipsec
        ```

        If no policy is assigned, you receive the following message:

        > IP Security test . . . . . . . . . : Passed IPSec policy service is active, but no policy is assigned.

- Windows 2000-based computers

    Before you create or assign any new IPSec policies to a Windows 2000-based computer, determine whether any IPSec policies are being applied from the local registry or through a GPO. To do this, follow these steps:

    1. Install Netdiag.exe from the Windows 2000 CD by running Setup.exe from the Support\\Tools folder.
    2. Open a command prompt, and then set the working folder to C:\\Program Files\\Support Tools.
    3. Run the following command to verify that there is not an existing IPSec policy already assigned to the computer:

        ```console
        netdiag /test:ipsec
        ```

        If no policy is assigned, you receive the following message:

        > IP Security test . . . . . . . . . : Passed IPSec policy service is active, but no policy is assigned.

## Create a static policy to block traffic on Windows Server 2003-based and Windows XP-based computers

For systems that do not have a locally defined IPSec policy enabled, create a new local static policy to block traffic that is directed to a specific protocol and a specific port on Windows Server 2003-based and Windows XP-based computers. To do this, follow these steps:

1. Verify that the IPSec Policy Agent service is enabled and started in the Services MMC snap-in.
2. Install IPSeccmd.exe. IPSeccmd.exe is part of Windows XP Service Pack 2 (SP2) Support Tools.

    > [!NOTE]
    > IPSeccmd.exe will run on Windows XP and Windows Server 2003 operating systems, but the tool is only available from the Windows XP SP2 Support Tools package.

3. Open a command prompt, and then set the working folder to the folder where you installed the Windows XP Service Pack 2 Support Tools.

    > [!NOTE]
    > The default folder for Windows XP SP2 Support Tools is C:\\Program Files\\Support Tools.

4. To create a new local IPSec policy and filtering rule that applies to network traffic from any IP address to the IP address of the Windows Server 2003-based or Windows XP-based computer that you are configuring, use the following command.

    > [!NOTE]
    > In the following command, **Protocol** and **PortNumber** are variables.

    ```console
    IPSeccmd.exe -w REG -p "Block Protocol PortNumber Filter" -r "Block Inbound Protocol PortNumber Rule" -f *=0: PortNumber: Protocol -n BLOCK -x
    ```

    For example, to block network traffic from any IP address and any source port to destination port UDP 1434 on a Windows Server 2003-based or Windows XP-based computer, type the following commands. This policy is sufficient to help protect computers that run Microsoft SQL Server 2000 from the "Slammer" worm.

    ```console
    IPSeccmd.exe -w REG -p "Block UDP 1434 Filter" -r "Block Inbound UDP 1434 Rule" -f *=0:1434:UDP -n BLOCK -x
    ```

    The following example blocks inbound access to TCP port 80 but still allows outbound TCP 80 access. This policy is sufficient to help protect computers that run Microsoft Internet Information Services (IIS) 5.0 from the "Code Red" worm and the "Nimda" worm.

    ```console
    IPSeccmd.exe -w REG -p "Block TCP 80 Filter" -r "Block Inbound TCP 80 Rule" -f *=0:80:TCP -n BLOCK -x
    ```

    > [!NOTE]
    > The `-x` switch assigns the policy immediately. If you enter this command, the "Block UDP 1434 Filter" policy is unassigned and the "Block TCP 80 Filter" is assigned. To add the policy but not assign the policy, type the command without the `-x` switch at the end.

5. To add an additional filtering rule to the existing "Block UDP 1434 Filter" policy that blocks network traffic that originates from your Windows Server 2003-based or Windows XP-based computer to any IP address, use the following command.

    > [!NOTE]
    > In this command, **Protocol** and **PortNumber** are variables.

    ```console
    IPSeccmd.exe -w REG -p "Block Protocol PortNumber Filter" -r "Block Outbound Protocol PortNumber Rule" -f *0=: PortNumber: Protocol -n BLOCK
    ```

    For example, to block any network traffic that originates from your Windows Server 2003-based or Windows XP-based computer that is directed to UDP 1434 on any other host, type the following. This policy is sufficient to help prevent computers that run SQL Server 2000 from spreading the "Slammer" worm.

    ```console
    IPSeccmd.exe -w REG -p "Block UDP 1434 Filter" -r "Block Outbound UDP 1434 Rule" -f 0=*:1434:UDP -n BLOCK
    ```

    > [!NOTE]
    > You can add as many filtering rules to a policy as you want by using this command. For example, you can use this command to block multiple ports by using the same policy.

6. The policy in step 5 will now be in effect and will persist every time that the computer is restarted. However, if a domain-based IPSec policy is assigned to the computer later, this local policy will be overridden and will no longer apply.

    To verify the successful assignment of your filtering rule, set the working folder to C:\\Program Files\\Support Tools at the command prompt, and then type the command: `netdiag /test:ipsec /debug`.

    If policies for both inbound and outbound traffic are assigned as in these examples, you will receive the following message:

    > IP Security test . . . . . . . . . :  
    Passed Local IPSec Policy Active: 'Block UDP 1434 Filter' IP Security Policy Path:   SOFTWARE\\Policies\\Microsoft\\Windows\\IPSec\\Policy\\Local\\ipsecPolicy{D239C599-F945-47A3-A4E3-B37BC12826B9}
    >
    > There are 2 filters  
    No Name  
    Filter Id: {5EC1FD53-EA98-4C1B-A99F-6D2A0FF94592}  
    Policy Id: {509492EA-1214-4F50-BF43-9CAC2B538518}  
    Src Addr : 0.0.0.0 Src Mask : 0.0.0.0  
    Dest Addr : 192.168.1.1 Dest Mask : 255.255.255.255  
    Tunnel Addr : 0.0.0.0 Src Port : 0 Dest Port : 1434  
    Protocol : 17 TunnelFilter: No  
    Flags : Inbound Block  
    No Name  
    Filter Id: {9B4144A6-774F-4AE5-B23A-51331E67BAB2}  
    Policy Id: {2DEB01BD-9830-4067-B58A-AADFC8659BE5}  
    Src Addr : 192.168.1.1 Src Mask : 255.255.255.255  
    Dest Addr : 0.0.0.0 Dest Mask : 0.0.0.0  
    Tunnel Addr : 0.0.0.0 Src Port : 0 Dest Port : 1434  
    Protocol : 17 TunnelFilter: No
    >
    > Flags : Outbound Block

> [!NOTE]
> The IP addresses and graphical user interface (GUID) numbers will be different based on your Windows Server 2003-based or Windows XP-based computer.

## Create a static policy to block traffic on Windows 2000-based computers

For systems without a locally defined IPSec policy enabled, follow these steps to create a new local static policy to block traffic that is directed to a specific protocol and port on a Windows 2000-based computer without an existing IPSec Policy assigned:

1. Verify that the IPSec Policy Agent service is enabled and started in the Services MMC snap-in.
2. Open a command prompt and set the working folder to the folder where you installed Ipsecpol.exe.

    > [!NOTE]
    > The default folder for Ipsecpol.exe is C:\\Program Files\\Resource Kit.
3. To create a new local IPSec policy and filtering rule that applies to network traffic from any IP address to the IP address of the Windows 2000-based computer that you are configuring, use the following command, where **Protocol** and **PortNumber** are variables:

    ```console
    ipsecpol -w REG -p "Block Protocol PortNumber Filter" -r "Block Inbound Protocol PortNumber Rule" -f *=0: PortNumber: Protocol -n BLOCK -x
    ```

    For example, to block network traffic from any IP address and any source port to destination port UDP 1434 on a Windows 2000-based computer, type the following. This policy is sufficient to help protect computers that run Microsoft SQL Server 2000 from the "Slammer" worm.

    ```console
    ipsecpol -w REG -p "Block UDP 1434 Filter" -r "Block Inbound UDP 1434 Rule" -f *=0:1434:UDP -n BLOCK -x
    ```

    The following example blocks inbound access to TCP port 80 but still allows outbound TCP 80 access. This policy is sufficient to help protect computers that run Microsoft Internet Information Services (IIS) 5.0 from the "Code Red" and "Nimda" worms.

    ```console
    ipsecpol -w REG -p "Block TCP 80 Filter" -r "Block Inbound TCP 80 Rule" -f *=0:80:TCP -n BLOCK -x
    ```

    > [!NOTE]
    > The `-x` switch assigns the policy immediately. If you enter this command, the "Block UDP 1434 Filter" policy is unassigned, and the "Block TCP 80 Filter" is assigned. To add but not assign the policy, type the command without the `-x` switch at the end .

4. To add an additional filtering rule to the existing "Block UDP 1434 Filter" policy that blocks network traffic that originates *from* your Windows 2000-based computer to any IP address, use the following command, where **Protocol** and **PortNumber** are variables:

    ```console
    ipsecpol -w REG -p "Block Protocol PortNumber Filter" -r "Block Outbound Protocol PortNumber Rule" -f *0=: PortNumber: Protocol -n BLOCK
    ```

    For example, to block any network traffic that originates from your Windows 2000-based computer that is directed to UDP 1434 on any other host, type the following command. This policy is sufficient to prevent computers that run SQL Server 2000 from spreading the "Slammer" worm.

    ```console
    ipsecpol -w REG -p "Block UDP 1434 Filter" -r "Block Outbound UDP 1434 Rule" -f 0=*:1434:UDP -n BLOCK
    ```

    > [!NOTE]
    > You can add as many filtering rules to a policy as you want by using this command (for example, to block multiple ports by using the same policy).

5. The policy in step 5 will now be in effect and will persist every time that the computer is restarted. However, if a domain-based IPSec policy is assigned to the computer later, this local policy will be overridden and will no longer apply. To verify the successful assignment of your filtering rule, at the command prompt, set the working folder to C:\\Program Files\\Support Tools, and then type the command: `netdiag /test:ipsec /debug`.

    If, as in these examples, policies for both inbound and outbound traffic are assigned, you will receive the following message:

    > IP Security test . . . . . . . . . :  
    Passed Local IPSec Policy Active: 'Block UDP 1434 Filter' IP Security Policy Path:  SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local\ipsecPolicy{D239C599-F945-47A3-A4E3-B37BC12826B9}
    >
    > There are 2 filters  
    No Name  
    Filter Id: {5EC1FD53-EA98-4C1B-A99F-6D2A0FF94592}  
    Policy Id: {509492EA-1214-4F50-BF43-9CAC2B538518}  
    Src Addr : 0.0.0.0 Src Mask : 0.0.0.0  
    Dest Addr : 192.168.1.1 Dest Mask : 255.255.255.255  
    Tunnel Addr : 0.0.0.0 Src Port : 0 Dest Port : 1434  
    Protocol : 17 TunnelFilter: No  
    Flags : Inbound Block  
    No Name  
    Filter Id: {9B4144A6-774F-4AE5-B23A-51331E67BAB2}  
    Policy Id: {2DEB01BD-9830-4067-B58A-AADFC8659BE5}  
    Src Addr : 192.168.1.1 Src Mask : 255.255.255.255  
    Dest Addr : 0.0.0.0 Dest Mask : 0.0.0.0  
    Tunnel Addr : 0.0.0.0 Src Port : 0 Dest Port : 1434  
    Protocol : 17 TunnelFilter: No
    >
    > Flags : Outbound Block

    > [!NOTE]
    > The IP addresses and graphical user interface (GUID) numbers will be different. They will reflect those of your Windows 2000-based computer.

## Add a block rule for a specific protocol and port on Windows Server 2003-based and Windows XP-based computers

To add a block rule for a specific protocol and port on a Windows Server 2003-based or Windows XP-based computer that has an existing locally assigned static IPSec policy, follow these steps:

1. Install IPSeccmd.exe. IPSeccmd.exe is part of Windows XP SP2 Support Tools.

2. Identify the name of the currently assigned IPSec policy. To do this, type the `netdiag /test:ipsec` command at a command prompt.

    If a policy is assigned, you will receive a message that is similar to the following:

    > IP Security test . . . . . . . . . : Passed  
    Local IPSec Policy Active: 'Block UDP 1434 Filter'

3. If there is an IPSec policy already assigned to the computer (local or domain), use the following command to add an additional BLOCK Filter Rule to the existing IPSec policy.

    > [!NOTE]
    > In this command, **Existing_IPSec_Policy_Name**,
     **Protocol**, and **PortNumber** are variables.

    ```console
    IPSeccmd.exe -p "Existing_IPSec_Policy_Name" -w REG -r "Block Protocol PortNumber Rule" -f *=0: PortNumber: Protocol -n BLOCK
    ```

    For example, to add a Filter Rule to block inbound access to TCP port 80 to the existing Block UDP 1434 Filter, use the following command:

    ```console
    IPSeccmd.exe -p "Block UDP 1434 Filter" -w REG -r "Block Inbound TCP 80 Rule" -f *=0:80:TCP -n BLOCK
    ```

## Add a block rule for a specific protocol and port on Windows 2000-based computers

To add a block rule for a specific protocol and port on a Windows 2000-based computer with an existing locally assigned static IPSec policy, follow these steps:

1. Download and install Ipsecpol.exe.
2. Identify the name of the currently assigned IPSec policy. To do this, type the `netdiag /test:ipsec` command at a command prompt.

    If a policy is assigned, you will receive a message that is similar to the following:

    > IP Security test . . . . . . . . . : Passed  
    Local IPSec Policy Active: 'Block UDP 1434 Filter'

3. If there is an IPSec policy already assigned to the computer (local or domain), use the following command to add an additional BLOCK filtering rule to the existing IPSec policy, where **Existing_IPSec_Policy_Name**, **Protocol**, and **PortNumber** are variables:

    ```console
    ipsecpol -p "Existing_IPSec_Policy_Name" -w REG -r "Block Protocol PortNumber Rule" -f *=0: PortNumber: Protocol -n BLOCK
    ```

    For example, to add a Filter Rule to block inbound access to TCP port 80 to the existing Block UDP 1434 Filter, use the following command:
  
    ```console
    ipsecpol -p "Block UDP 1434 Filter" -w REG -r "Block Inbound TCP 80 Rule" -f *=0:80:TCP -n BLOCK
    ```

## Add a dynamic block policy for a specific protocol and port on Windows Server 2003 and Windows XP-based computers

You may want to temporarily block access to a specific port. For example, you may want to block a specific port until you can install a hotfix or if a domain-based IPSec policy is already assigned to the computer. To temporarily block access to a port on a Windows Server 2003-based or Windows XP-based computer by using IPSec policy, follow these steps:

1. Install IPSeccmd.exe. IPSeccmd.exe is part of Windows XP Service Pack 2 Support Tools.

    > [!NOTE]
    > IPSeccmd.exe will run on Windows XP and Windows Server 2003 operating systems, but the tool is only available from the Windows XP SP2 Support Tools package.

2. To add a dynamic BLOCK filter that blocks all packets from any IP address to your system's IP address and targeted port, type the following at a command prompt.

    > [!NOTE]
    > In the following command, **Protocol** and
     **PortNumber** are variables.

    ```console
    IPSeccmd.exe -f [*=0: PortNumber: Protocol]
    ```

> [!NOTE]
> This command creates the block filter dynamically. The policy remains assigned as long as the IPSec Policy Agent service is running. If the IPSec Policy Agent service is restarted or the computer is restarted, this policy is lost. If you want to dynamically reassign the IPSec Filtering Rule every time that the system is restarted, create a startup script to reapply the Filter Rule. If you want to permanently apply this filter, configure the filter as a static IPSec policy. The IPSec Policy Management MMC snap-in provides a graphical user interface for managing IPSec policy configuration. If a domain-based IPSec policy is already applied, the `netdiag /test:ipsec /debug` command may only show the filter details if the command is executed by a user who has domain administrator credentials.

## Add a dynamic block policy for a specific protocol and port on Windows 2000-based computers

You may want to block a specific port temporarily (for example, until a hotfix can be installed, or if a domain-based IPSec policy is already assigned to the computer). To temporarily block access to a port on a Windows 2000-based computer by using IPSec policy, follow these steps:

1. Download and install Ipsecpol.exe.

2. To add a dynamic BLOCK filter that blocks all packets from any IP address to your system's IP address and targeted port, type the following at a command prompt, where **Protocol** and
 **PortNumber** are variables:

    ```console
    ipsecpol -f [*=0: PortNumber: Protocol] 
    ```

> [!NOTE]
> This command creates the block filter dynamically, and the policy will remain assigned as long as the IPSec Policy Agent service is running. If the IPSec service is restarted or the computer is rebooted, this setting will be lost. If you want to dynamically reassign the IPSec Filtering Rule every time the system is restarted, create a startup script to reapply the Filter Rule. If you want to permanently apply this filter, configure the filter as a static IPSec policy. The IPSec Policy Management MMC snap-in provides a graphical user interface for managing IPSec policy configuration. If a domain-based IPSec policy is already applied, the `netdiag /test:ipsec /debug` command may only show the filter details if the command is executed by a user with domain administrator credentials. An updated version of Netdiag.exe will be available in Windows 2000 Service Pack 4 that will allow local administrators to view domain-based IPSec policy.

## IPSec filtering rules and Group Policy

For environments where IPSec policies are assigned by a Group Policy setting, you have to update the whole domain's policy to block the particular protocol and port. After you successfully configure the Group Policy IPSec settings, you must enforce a refresh of the Group Policy settings on all the Windows Server 2003-based, Windows XP-based, and Windows 2000-based computers in the domain. To do this, use the `secedit /refreshpolicy machine_policy` command.

The IPSec policy change will be detected within one of two different polling intervals. For a newly assigned IPSec policy being applied to a GPO, the IPSec policy will be applied to the clients within the time set for the Group Policy polling interval or when the `secedit /refreshpolicy machine_policy` command is run on the client computers. If IPSec policy is already assigned to a GPO and new IPSec filters or rules are being added to an existing policy, the secedit command will not make IPSec recognize changes. In this scenario, modifications to an existing GPO-based IPSec policy will be detected within that IPSec policy's own polling interval. This interval is specified on the General tab for that IPSec policy. You can also force a refresh of the IPSec Policy settings by restarting the IPSec Policy Agent service. If the IPSec service is stopped or restarted, IPSec-secured communications will be interrupted and will take several seconds to resume. This may cause program connections to disconnect, particularly for connections that are actively transferring large volumes of data. In situations where the IPSec policy is applied only on the local computer, you do not have to restart the service.

## Unassign and delete an IPSec policy on Windows Server 2003-based and Windows XP-based computers

- Computers that have a locally defined static policy

  1. Open a command prompt, and then set the working folder to the folder where you installed Ipsecpol.exe.
  2. To unassign the filter that you created earlier, use the following command:

        ```console
        IPSeccmd.exe -w REG -p "Block **Protocol** **PortNumber** Filter" -y
        ```

        For example, to unassign the Block UDP 1434 Filter that you created earlier, use the following command:

        ```console
        IPSeccmd.exe -w REG -p "Block UDP 1434 Filter" -y
        ```

  3. To delete the filter that you created, use the following command:

        ```console
        IPSeccmd.exe -w REG -p "Block Protocol PortNumber Filter" -r "Block Protocol PortNumber Rule" -o
        ```

        For example, to delete the "Block UDP 1434 Filter" filter and both of the rules that you created, use the following command:

        ```console
        IPSeccmd.exe -w REG -p "Block UDP 1434 Filter" -r "Block Inbound UDP 1434 Rule" -r "Block Outbound UDP 1434 Rule" -o
        ```

- Computers that have a locally defined dynamic policy

    Dynamic IPSec policy is unapplied if the IPSec Policy Agent service is stopped by using the `net stop policyagent` command. To delete the specific commands that were used without stopping the IPSec Policy Agent service, following these steps:

    1. Open a command prompt, and then set the working folder to the folder where you installed Windows XP Service Pack 2 Support Tools.
  
    2. Type the `IPSeccmd.exe -u` command.

        > [!NOTE]
        > You can also restart the IPSec Policy Agent service to clear all dynamically-assigned policies.

## Unassign and delete an IPSec policy on Windows 2000-based computers

- Computers with a locally defined static policy

  1. Open a command prompt, and then set the working folder to the folder where you installed Ipsecpol.exe.
  2. To unassign the filter that you created earlier, use the following command:

        ```console
        ipsecpol -w REG -p "Block Protocol PortNumber Filter" -y
        ```

        For example, to unassign the Block UDP 1434 Filter that you created earlier, use the following command:

        ```console
        ipsecpol -w REG -p "Block UDP 1434 Filter" -y
        ```

  3. To delete the filter that you created, use the following command:

        ```console
        ipsecpol -w REG -p "Block Protocol PortNumber Filter" -r "Block Protocol PortNumber Rule" -o
        ```

        For example, to delete the "Block UDP 1434 Filter" filter and both rules that you created earlier, use the following command:

        ```console
        ipsecpol -w REG -p "Block UDP 1434 Filter" -r "Block Inbound UDP 1434 Rule" -r "Block Outbound UDP 1434 Rule" -o
        ```

- Computers with a locally defined dynamic policy

    Dynamic IPSec policy will be unapplied if the IPSec Policy Agent service is stopped (by using the `net stop policyagent` command). However, to delete the specific commands that were used earlier without stopping the IPSec Policy Agent service, following these steps:

    1. Open a command prompt, and then set the working folder to the folder where you installed Ipsecpol.exe.
    2. Type the `Ipsecpol -u` command.

    > [!NOTE]
    > You may also restart the IPSec Policy Agent service to clear all dynamically-assigned policies.

## Apply your new filter rule to all protocols and ports

By default in Microsoft Windows 2000 and Microsoft Windows XP, IPSec exempts Broadcast, Multicast, RSVP, IKE, and Kerberos traffic from all Filter and Authentication restrictions.

Where IPSec is used only to permit and block traffic, remove the exemptions for Kerberos and RSVP protocols by changing a registry value.

By following these instructions, you can help protect UDP 1434 even in cases where attackers may set their source port to the Kerberos ports of TCP/UDP 88. By removing the Kerberos exemptions, Kerberos packets will now be matched against all filters in the IPSec policy. Therefore, Kerberos can be secured inside IPSec, blocked or permitted. Therefore, if IPSec filters match Kerberos traffic that is going to the domain controller IP addresses, you may have to change the IPSec policy design to add new filters to permit Kerberos traffic to each domain controller IP address (if you are not using IPSec to help secure all traffic between the domain controllers as Knowledge Base article 254728 describes).

## Application of IPSec filter rules upon computer restart

All IPSec policies rely on the IPSec Policy Agent service to be assigned. When a Windows 2000-based computer is in the process of starting up, the IPSec Policy Agent service is not necessarily the first service to start. Therefore, there may be a brief moment when the computer's network connection is vulnerable to virus or worm attacks. This situation only applies in the case where a potentially vulnerable service has successfully started and is accepting connection before the IPSec Policy Agent service has completely started and assigned all policies.
