---
title: Troubleshoot the Azure Linux Agent
description: Resolve issues with the Azure Linux Agent.
services: virtual-machines
ms.collection: linux
ms.service: virtual-machines
author: axelg
manager: dcscontentpm
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure
ms.date: 11/17/2020
ms.author: axelg
---
# Troubleshoot the Azure Linux Agent

The [Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux) enables a virtual machine (VM) to communicate with the Fabric Controller (the underlying physical server on which the VM is hosted) on IP address 168.63.129.16.

>[!NOTE]
>This IP address is a virtual public IP address that facilitates communication and should not be blocked. For more information, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16).

## Before you begin

Check the agent status and version to make sure it is still supported. See [Minimum version support for virtual machine agents in Azure](/troubleshoot/azure/virtual-machines/support-extensions-agent-version) to check version support, or see [WALinuxAgent FAQ](https://github.com/Azure/WALinuxAgent/wiki/FAQ#what-does-goal-state-agent-mean-in-waagent---version-output) for steps to find the status and version.

## Troubleshoot a Not Ready status

1. Check the service status of the Azure Linux Agent to make sure it's running. The service name might be **walinuxagent** or **waagent**.

   ```
   root@nam-u18:/home/nam# service walinuxagent status
   ● walinuxagent.service - Azure Linux Agent
      Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enabled)
      Active: active (running) since Thu 2020-10-08 17:10:29 UTC; 3min 9s ago
    Main PID: 1036 (python3)
       Tasks: 4 (limit: 4915)
      CGroup: /system.slice/walinuxagent.service
              ├─1036 /usr/bin/python3 -u /usr/sbin/waagent -daemon
              └─1156 python3 -u bin/WALinuxAgent-2.2.51-py2.7.egg -run-exthandlers
   Oct 08 17:10:33 nam-u18 python3[1036]: 2020-10-08T17:10:33.129375Z INFO ExtHandler ExtHandler Started tracking cgroup: Microsoft.OSTCExtensions.VMAccessForLinux-1.5.10, path: /sys/fs/cgroup/memory/sys
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.189020Z INFO ExtHandler [Microsoft.CPlat.Core.RunCommandLinux-1.0.1] Target handler state: enabled [incarnation 2]
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.197932Z INFO ExtHandler [Microsoft.CPlat.Core.RunCommandLinux-1.0.1] [Enable] current handler state is: enabled
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.212316Z INFO ExtHandler [Microsoft.CPlat.Core.RunCommandLinux-1.0.1] Update settings file: 0.settings
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.224062Z INFO ExtHandler [Microsoft.CPlat.Core.RunCommandLinux-1.0.1] Enable extension [bin/run-command-shim enable]
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.236993Z INFO ExtHandler ExtHandler Started extension in unit 'Microsoft.CPlat.Core.RunCommandLinux_1.0.1_db014406-294a-49ed-b112-c7912a86ae9e
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.263572Z INFO ExtHandler ExtHandler Started tracking cgroup: Microsoft.CPlat.Core.RunCommandLinux-1.0.1, path: /sys/fs/cgroup/cpu,cpuacct/syst
   Oct 08 17:10:35 nam-u18 python3[1036]: 2020-10-08T17:10:35.280691Z INFO ExtHandler ExtHandler Started tracking cgroup: Microsoft.CPlat.Core.RunCommandLinux-1.0.1, path: /sys/fs/cgroup/memory/system.sl
   Oct 08 17:10:37 nam-u18 python3[1036]: 2020-10-08T17:10:37.349090Z INFO ExtHandler ExtHandler ProcessGoalState completed [incarnation 2; 4496 ms]
   Oct 08 17:10:37 nam-u18 python3[1036]: 2020-10-08T17:10:37.365590Z INFO ExtHandler ExtHandler [HEARTBEAT] Agent WALinuxAgent-2.2.51 is running as the goal state agent [DEBUG HeartbeatCounter: 1;Heartb
   root@nam-u18:/home/nam#
   ```

   If the service is running, restart it to resolve the issue. If the service is stopped, start it, wait a few minutes, and then check the status again.

1. Make sure auto-update is enabled. Check the auto-update setting in **/etc/waagent.conf**.

   ```
   AutoUpdate.Enabled=y
   ```

   For more information on how to update the Azure Linux Agent, see [How to update the Azure Linux Agent on a VM](/azure/virtual-machines/extensions/update-linux-agent).

1. Make sure the VM can connect to the Fabric Controller. Use a tool such as curl to test whether the VM can connect to 168.63.129.16 on ports 80, 443, and 32526. If the VM doesn't connect as expected, check whether outbound communication over ports 80, 443, and 32526 is open in your local firewall on the VM. If this IP address is blocked, the VM agent might display unexpected behavior.

## Advanced troubleshooting

Events for troubleshooting the Azure Linux Agent are recorded in the **/var/log/waagent.log** file.

### Unable to connect to WireServer IP (Host IP)

The following error appears in the **/var/log/waagent.log** file when the VM can't reach the WireServer IP on the host server.

```
2020-10-02T18:11:13.148998Z WARNING ExtHandler ExtHandler An error occurred while retrieving the goal state:
```

To resolve this issue:

* Connect to the VM by using SSH, and then try to access the following URL from curl: <http://168.63.129.16/?comp=versions>.
* Check for any issues that might be caused by a firewall, a proxy, or another source that might be blocking access to the IP address 168.63.129.16.
* Check whether Linux IPTables or a third-party firewall is blocking access to ports 80, and 32526.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
