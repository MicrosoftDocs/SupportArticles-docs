---
title: DPM protection agent service can't start
description: Describes a problem that occurs when event ID 7024 is logged in the System log on protected servers. You also receive The DPMRA service terminated with service-specific error 10048 (0x2740) error.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# The DPM protection agent service can't start

This article helps you fix an issue where you receive **The DPMRA service terminated with service-specific error 10048 (0x2740)** error when you start the Data Protection Manager (DPM) protection agent service.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 947682

## Symptoms

After you deploy the DPM protection agent in Microsoft System Center Data Protection Manager, the DPM protection agent service cannot start on the protected servers. (A protected server is a server that contains data sources that are protection group members.)

## Cause

This problem may occur for one of the following reasons:

- Another process is using TCP port 5718 and TCP port 5719. These two ports are required by the DPM protection agent service.
- TCP port 5718 and TCP port 5719 are not open for firewall applications or for firewall devices on the computer.

## Resolution 1

To resolve this problem, find the process that is using the required TCP ports. To do this, follow these steps:

1. Open a Command Prompt window. Run the following commands at the command prompt:

    ```console
    netstat -ano > netstat.txt
    tasklist > tasklist.txt
    tasklist /svc >svclist.txt
    ```

    > [!NOTE]
    > In this step, the command outputs of the `netstat` command and the `tasklist` command are written to text files so that you can check the outputs more easily. Run the `tasklist` command together with the `/svc` switch because the process that's using the required ports may be running as a service.

1. Open the text files that were generated in step 1. To do this, run the following commands at the command prompt:

    ```console
    notepad netstat.txt
    notepad tasklist.txt
    notepad svclist.txt
    ```

1. In the Netstat.txt file, find any entries that correspond to TCP port 5718 and to TCP port 5719. Note the process identifier (PID) for each entry.
1. In the Tasklist.txt file, locate the PIDs that you found in step 3 to determine which processes are using the required ports. If you don't find the PIDs in the Tasklist.txt file, try to find the PIDs in the Svclist.txt file.
1. After you find out which process is using the required ports, configure the corresponding program to use other available ports. If you cannot change the program's ports, or if the program uses ports dynamically, you must stop the program.

> [!NOTE]
> If another application is using the port or ports (5718 and 5719), the ports cannot be changed. In this case, you can, instead, use the SetAgentcfg.exe tool. This tool provides the ability to change the default ports that the DPM agent uses.

To change the ports that are used by the DPM agent, follow these steps on the protected computer that is experiencing the problem. Make sure that the ports that you reassign will not be used by any other applications.

> [!NOTE]
> To list the DPM installation path, run the following command:
> 
> `Reg query "HKLM\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Setup" /v installpath`

1. Locate the SetAgentcfg.exe file from the DPM server. By default, the file is located at `%PROGRAMFILES%\Microsoft DPM\DPM\Setup\SetAgentCfg.exe`.

2. Copy the file to the protected computer that is experiencing the problem. Copy the file to the agent DPM\Bin directory. By default, the file is located at `%PROGRAMFILES%\Microsoft Data Protection Manager\DPM\bin`.

3. On the protected computer that's experiencing the problem, open an administrative Command Prompt window.
4. In the Command Prompt window, change to the directory to which the SetAgentCfg.exe file was copied. For example, change to the directory `%PROGRAMFILES%\Microsoft Data Protection Manager\DPM\bin`.

5. Run the following command to change the ports that are used by the DPM agent:

   ```console
   SetAgentCfg e dpmra <port number> <alternate port number>
   ```

6. Restart the DPMRA service.

If these steps don't resolve this problem, determine whether the firewall applications require that you verify these ports. Then, manually open the ports.

## Resolution 2

To reserve TCP ports 5718 and 5719, follow the steps that are documented in [How to reserve a range of ephemeral ports on a computer that is running Windows Server 2003 or Windows 2000 Server](https://support.microsoft.com/help/812873).  

## More information

Data Protection Manager and protected servers open connections over TCP port 5718 and over TCP port 5719 to enable Data Protection Manager operations, such as synchronization and recovery. The current problem may occur on protected servers that are running the **Microsoft Exchange System Attendant** service. This service uses TCP ports dynamically. This service may take one or both of the required ports.

Data Protection Manager also uses the following ports:

- TCP 135 dynamic
- User Datagram Protocol (UDP) 53
- UDP 88
- TCP 88
- UDP 137
- UDP 138
- TCP 139
- TCP 389
- UDP 389
