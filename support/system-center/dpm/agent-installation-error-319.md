---
title: Error 319 when installing DPM agent
description: Fixes an issue in which your receive error 319 when installing the Data Protection Manager agent.
ms.date: 07/24/2020
ms.reviewer: slight, cbutch, anjanik, delhan
---
# System Center Data Protection Manager agent installation fails with error 319

This article helps you fix an issue where you receive **The agent operation failed because of a communication error with the DPM Agent Coordinator service** error when you install the Data Protection Manager (DPM) agent.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 2981833

## Symptoms

When you install the Microsoft System Center 2012 Data Protection Manager or later version agent on a destination computer, the installation fails and you receive the following error message:

> Install protection agent on _name.contoso.com_ failed:  
> Error 319: The agent operation failed because of a communication error with the DPM Agent Coordinator service on _name.contoso.com_.  
> Error details: The RPC server is unavailable (0x800706BA)  
> Recommended action:
>
> 1) Verify that _name.contoso.com_ is remotely accessible from the DPM server.
> 2) If a firewall is enabled on _name.contoso.com_, make sure that it is not blocking requests from the DPM server. Refer to the DPM Deployment Guide for more information on configuring the firewall for DPM.

## Cause

This issue occurs because the Windows Firewall on the destination computer blocks Dpmac.exe from accepting incoming network connections.

## Resolution 1

Temporarily disable the Windows Firewall on the destination computer when you deploy the agent. After the installation is complete, you can re-enable the Windows Firewall.

## Resolution 2

If you cannot disable the firewall, or if you have many servers and do not want to edit each server individually, you can add firewall rules that will enable the incoming network connections that are required for the DPM agent installation process. The main benefit of this method is that you can automate the process by using the following commands. You can script the solution and then deploy it by using Group Policy Object (GPO) or another method.

These commands must be run from an elevated command prompt (**Run as administrator**) and should be run on all target computers that have the firewall enabled.

> [!NOTE]
> DPM version information has to reflect your current DPM installation version. A sample path follows. (Replace \<_DPMVersion_> with the correct DPM major version number in the form x.x.xxxx.x. DPM 2016 paths may be different.)
>
> - DPM 2010: version 3.0.7696.0
> - DPM 2012: version 4.0.1908.0
> - DPM 2012 SP1: version 4.1.3313.0
> - DPM 2012 R2: version 4.2.1205.0
 > - DPM 2016: version 5.0.158.0

The following initial command should enable the agent to be installed:

```console
Netsh advfirewall firewall add rule name = "dpmac" dir=in program="C:\Program Files\Microsoft Data Protection Manager\DPM\ProtectionAgents\AC\<DPMVersion>\dpmac.exe" action=allow
```

If this command doesn't enable the agent installation to succeed, add the following additional rules:

```console
Netsh advfirewall firewall add rule name="Microsoft System Center 2012 R2 Data Protection Manager Replication Agent" dir=in program="C:\Program files\Microsoft Data Protection Manager\DPM\bin\dpmra.exe" profile=Any action=allow

Netsh advfirewall firewall add rule name="Microsoft System Center 2012 R2 Data Protection Manager DCOM setting" dir=in action=allow protocol=TCP localport=135 profile=Any

Netsh advfirewall firewall set rule group="@FirewallAPI.dll,-28502" new enable=yes

Netsh advfirewall firewall add rule name="DPMAM_WCF_SERVICE" dir=in program="C:\Microsoft Data Protection Manager\DPM\bin\AMSvcHost.exe" profile=Any action=allow

Netsh advfirewall firewall add rule name="DPMAM_WCF_PORT" dir=in action=allow protocol=TCP localport=6075 profile=Any
```

## More information

The following ports are required for the DPM agent installation. Again, be aware that the version may change.

|Protocol|Local port|Program path|
|---|---|---|
|TCP|5719|%ProgramFiles%\Microsoft Data Protection Manager\DPMAC\bin\dpmac.exe|
|TCP|RPC Dynamic|%ProgramFiles%\Microsoft Data Protection Manager\DPMAC\bin\dpmac.exe|
|TCP|5719|%ProgramFiles%\Microsoft Data Protection Manager\DPM\ProtectionAgents\AC\3.0.7696.0\dpmac.exe|
|TCP|RPC Dynamic|%ProgramFiles%\Microsoft Data Protection Manager\DPM\ProtectionAgents\AC\3.0.7696.0\dpmac.exe|
|TCP|5718|%ProgramFiles%\Microsoft Data Protection Manager\DPM\bin\DPMRA.exe|
|TCP|RPC Dynamic|%ProgramFiles%\Microsoft Data Protection Manager\DPM\bin\DPMRA.exe|
  
For a list of all required ports that are used for DPM, see [Configure firewall settings for DPM](/previous-versions/system-center/system-center-2012-R2/hh757794(v=sc.12)?redirectedfrom=MSDN).  

Enabling Windows Firewall logging (default location: `%windir%\System32\LogFiles\Firewall`) may list no blocked packets.

In some instances, the initial attempt to push the agent to the protected server will fail with the following error, and successive installations will fail with the 319 error:

> Install protection agent on _name.contoso.com_ failed:  
> Error 347: An error occurred when the agent operation attempted to create the DPM Agent Coordinator service on _name.contoso.com_.  
> Error details: Security must be initialized before any interfaces are marshalled or unmarshalled. It cannot be changed one initialized.  
> Recommended action: Verify that the Agent Coordinator service on _name.contoso.com_ is responding, if it is present. Review the error details, take the appropriate action, and then retry the agent operation.
