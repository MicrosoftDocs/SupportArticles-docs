---
title: CMD and PowerShell in Azure Windows VMs
description: How to use CMD and PowerShell commands within SAC in Azure Windows VMs
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure-services
ms.date: 08/14/2018
ms.author: jarrettr
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# How to use CMD and PowerShell Windows commands

**Applies to:** :heavy_check_mark: Windows VMs

This article provides example commands to perform common tasks in scenarios in which you have to use the Special Administration Console (SAC) to access your Windows virtual machine (VM). For example, you might have to use SAC to troubleshoot RDP connection failures.

SAC is included in all versions of Windows since Windows Server 2003. By default, however, it's disabled. SAC relies on the `sacdrv.sys` kernel driver, the `Special Administration Console Helper` service (`sacsvr`), and the `sacsess.exe` process. For more information, see [Emergency Management Services Tools and Settings](/previous-versions/windows/it-pro/windows-server-2003/cc787940(v%3dws.10)).

SAC enables you to connect to your running OS through a serial port. When you open a Command Prompt window in SAC, `sacsess.exe` starts `cmd.exe` within your running OS. In Task Manager, you can see that if you connect through RDP to your VM at the same time as you're connected to SAC through the serial console feature. The CMD window that you access through SAC is the same as the `cmd.exe` window that you use when you connect through RDP. All the same commands and tools are available, including the ability to start PowerShell from that CMD instance. The major difference between SAC and the Windows Recovery Environment (WinRE) is that SAC lets you manage your running OS, but WinRE starts up into a different, minimal OS. Although Azure VMs don't support the ability to access WinRE, they can be managed through SAC.

Because SAC is limited to an 80x24 pixel screen buffer that has no scroll back capability, add `| more` to commands to display the output one page at a time. Use `<spacebar>` to see the next page, or `<enter>` to see the next line.

The paste shortcut for the serial console window is `SHIFT+INSERT`.

Because of SAC's limited screen buffer, it might be easier to manage longer commands by copying them from a local text editor to SAC.

## Use CMD for Windows registry settings

To view and edit Windows registry csettings by using CMD, follow these steps:

1. Verify that RDP is enabled by running the following commands:

reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections

reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fDenyTSConnections

**Note:** The second key (under \Policies) exists only if the relevant Group Ppolicy setting is configured.

1. Enable RDP by running the following commands:

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fDenyTSConnections /t REG_DWORD /d 0

**Note:** The second key (under \Policies) is necessary only if the relevant Group Policy setting is configured. The value will be rewritten at next Group Policy refresh if it's configured in Group Policy.

## Use CMD to manage Windows services

To manage Windows services by usign CMD< follow these steps:

1. View the service state:

`sc query termservice`

1. View the service logon account:

`sc qc termservice`

1. Set the service logon account:

`sc config termservice obj= "NT Authority\NetworkService"`

**Note:** A space is required after the equal sign.

1. Set service start type:

`sc config termservice start= demand`

**Note:** A space is required after the equal sign. Possible start values include: `boot`, `system`, `auto`, `demand`, `disabled`, and `delayed-auto`.

1. Set service dependencies:

`sc config termservice depend= RPCSS`

**Note:** A space is required after the equal sign.

1. Start service by running either of the following commands:

`net start termservice`

`sc start termservice`

1. Stop the service by running either of the following commands:

`net stop termservice`

`sc stop termservice`

## Use CMD to manage networking features

Use manage networking features by using CMD, follow these steps:

1. Show the network shell (netsh) properties:

> `netsh interface show interface`

1. Show IP properties:

> `netsh interface ip show config`

1. Show IPSec configuration:

`netsh nap client show configuration`

1. Enable the network shell interface:

`netsh interface set interface name="<interface name>" admin=enabled`

1. Set the netsh interface to use DHCP:

`netsh interface ip set address name="<interface name>" source=dhcp`

For more information about `netsh`, see [Network shell (netsh)](/windows-server/networking/technologies/netsh/netsh-contexts).

Azure VMs should always be configured in the Guest OS to use DHCP to get an IP address. The Azure static IP setting still uses DHCP to give the static IP to the VM.

### Ping

`ping 8.8.8.8`

### Port ping

Install the telnet client

`dism /online /Enable-Feature /FeatureName:TelnetClient`

Test connectivity

`telnet bing.com 80`

To remove the telnet client

`dism /online /Disable-Feature /FeatureName:TelnetClient`

When limited to methods available in Windows by default, PowerShell can be a better approach for testing port connectivity. See the following PowerShell section for examples.

### Test DNS name resolution

`nslookup bing.com`

### Show Windows Firewall rule

`netsh advfirewall firewall show rule name="Remote Desktop - User Mode (TCP-In)"`

### Disable Windows Firewall

`netsh advfirewall set allprofiles state off`

You can use this command when troubleshooting to temporarily rule out the Windows Firewall. It will be enable on next restart or when you enable it using the following command. Don't stop the Windows Firewall service (MPSSVC) or Base Filtering Engine (BFE) service as a way to rule out the Windows Firewall. Stopping MPSSVC or BFE results in all connectivity being blocked.

### Enable Windows Firewall

`netsh advfirewall set allprofiles state on`

## Manage Users and Groups using CMD

### Create local user account

`net user /add <username> <password>`

### Add local user to local group

`net localgroup Administrators <username> /add`

### Verify user account is enabled

`net user <username> | find /i "active"`

Azure VMs created from generalized image will have the local administrator account renamed to the name specified during VM provisioning. It won't usually be `Administrator`.

### Enable user account

`net user <username> /active:yes`

### View user account properties

`net user <username>`

Example lines of interest from a local admin account:

`Account active Yes`

`Account expires Never`

`Password expires Never`

`Workstations allowed All`

`Logon hours allowed All`

`Local Group Memberships *Administrators`

### View local groups

`net localgroup`

## Manage the Windows Event Log using CMD

### Query event log errors

`wevtutil qe system /c:10 /f:text /q:"Event[System[Level=2]]" | more`

Change `/c:10` to the desired number of events to return, or move it to return all events matching the filter.

### Query event log by Event ID

`wevtutil qe system /c:1 /f:text /q:"Event[System[EventID=11]]" | more`

### Query event log by Event ID and Provider

`wevtutil qe system /c:1 /f:text /q:"Event[System[Provider[@Name='Microsoft-Windows-Hyper-V-Netvsc'] and EventID=11]]" | more`

### Query event log by Event ID and Provider for the last 24 hours

`wevtutil qe system /c:1 /f:text /q:"Event[System[Provider[@Name='Microsoft-Windows-Hyper-V-Netvsc'] and EventID=11 and TimeCreated[timediff(@SystemTime) <= 86400000]]]"`

Use `604800000` to look back seven days instead of 24 hours.

### Query event log by Event ID, Provider, and EventData in the last seven days

`wevtutil qe security /c:1 /f:text /q:"Event[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and EventID=4624 and TimeCreated[timediff(@SystemTime) <= 604800000]] and EventData[Data[@Name='TargetUserName']='<username>']]" | more`

## View or Remove Installed Applications using CMD

### List installed applications

`wmic product get Name,InstallDate | sort /r | more`

The `sort /r` sorts descending by install date to make it easy to see what was recently installed. Use `<spacebar>` to advance to the next page of output, or `<enter>` to advance one line.

### Uninstall an application

`wmic path win32_product where name="<name>" call uninstall`

Replace `<name>` with the name returned in the above command for the application you want to remove.

## File System Management using CMD

### Get file version

`wmic datafile where "drive='C:' and path='\\windows\\system32\\drivers\\' and filename like 'netvsc%'" get version /format:list`

This example returns the file version of the virtual NIC driver, which is netvsc.sys, netvsc63.sys, or netvsc60.sys depending on the Windows version.

### Scan for system file corruption

`sfc /scannow`

See also [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

### Scan for system file corruption

`dism /online /cleanup-image /scanhealth`

See also [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

### Export file permissions to text file

`icacls %programdata%\Microsoft\Crypto\RSA\MachineKeys /t /c > %temp%\MachineKeys_permissions_before.txt`

### Save file permissions to ACL file

`icacls %programdata%\Microsoft\Crypto\RSA\MachineKeys /save %temp%\MachineKeys_permissions_before.aclfile /t`

### Restore file permissions from ACL file

`icacls %programdata%\Microsoft\Crypto\RSA /save %temp%\MachineKeys_permissions_before.aclfile /t`

The path when using `/restore` needs to be the parent folder of the folder you specified when using `/save`. In this example, `\RSA` is the parent of the `\MachineKeys` folder specified in the `/save` example above.

### Take NTFS ownership of a folder

`takeown /f %programdata%\Microsoft\Crypto\RSA\MachineKeys /a /r`

### Grant NTFS permissions to a folder recursively

`icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "BUILTIN\Administrators:(F)"`

## Manage Devices

### Remove non-present PNP devices

`%windir%\System32\RUNDLL32.exe %windir%\System32\pnpclean.dll,RunDLL_PnpClean /Devices /Maxclean`

## Manage Group Policy

### Force group policy update

`gpupdate /force /wait:-1`

## Miscellaneous Tasks using CMD

### Show OS version

`ver`

or

`wmic os get caption,version,buildnumber /format:list`

or

`systeminfo  find /i "os name"`

`systeminfo | findstr /i /r "os.*version.*build"`

### View OS install date

`systeminfo | find /i "original"`

or

`wmic os get installdate`

### View last boot time

`systeminfo | find /i "system boot time"`

### View time zone

`systeminfo | find /i "time zone"`

or

`wmic timezone get caption,standardname /format:list`

### Restart Windows

`shutdown /r /t 0`

Adding `/f` forces running applications to close without warning users.

### Detect Safe Mode boot

`bcdedit /enum | find /i "safeboot"`

## Windows Commands - PowerShell

To run PowerShell in SAC, after you reach a CMD prompt, type:

`powershell <enter>`

> [!CAUTION]
> Remove the PSReadLine module from the PowerShell session before running any other PowerShell commands. here's a known issue where extra characters may be introduced in text pasted from the clipboard if PSReadLine is running in a PowerShell session in SAC.

First check if PSReadLine is loaded. It's loaded by default on Windows Server 2016, Windows 10, and later versions of Windows. It would only be present on earlier Windows versions if it's  manually installed.

If this command returns to a prompt with no output, then the module wasn't loaded and you can continue using the PowerShell session in SAC as normal.

`get-module psreadline`

If the above command returns the PSReadLine module version, run the following command to unload it. This command doesn't delete or uninstall the module. It only unloads it from the current PowerShell session.

`remove-module psreadline`

## View and Edit Windows Registry Settings using PowerShell

### Verify RDP is enabled

`get-itemproperty -path 'hklm:\system\curRentcontrolset\control\terminal server' -name 'fdenytsconNections'`

`get-itemproperty -path 'hklm:\software\policies\microsoft\windows nt\terminal services' -name 'fdenytsconNections'`

The second key (under \Policies)  only exists if the relevant group policy setting is configured.

### Enable RDP

`set-itemproperty -path 'hklm:\system\curRentcontrolset\control\terminal server' -name 'fdenytsconNections' 0 -type dword`

`set-itemproperty -path 'hklm:\software\policies\microsoft\windows nt\terminal services' -name 'fdenytsconNections' 0 -type dword`

The second key (under \Policies) would only be needed if the relevant group policy setting had been configured. Value will be rewritten at next group policy refresh if it's configured in group policy.

## Manage Windows Services using PowerShell

### View service details

`get-wmiobject win32_service -filter "name='termservice'" |  format-list Name,DisplayName,State,StartMode,StartName,PathName,ServiceType,Status,ExitCode,ServiceSpecificExitCode,ProcessId`

`Get-Service` can be used but doesn't include the service logon account. `Get-WmiObject win32-service` does.

### Set service logon account

`(get-wmiobject win32_service -filter "name='termservice'").Change($null,$null,$null,$null,$null,$false,'NT Authority\NetworkService')`

When using a service account other than `NT AUTHORITY\LocalService`, `NT AUTHORITY\NetworkService`, or `LocalSystem`, specify the account password as the last (eighth) argument after the account name.

### Set service startup type

`set-service termservice -startuptype Manual`

`Set-service` accepts `Automatic`, `Manual`, or `Disabled` for startup type.

### Set service dependencies

`Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\TermService' -Name DependOnService -Value @('RPCSS','TermDD')`

### Start service

`start-service termservice`

### Stop service

`stop-service termservice`

## Manage Networking Features using PowerShell

### Show NIC properties

`get-netadapter | where {$_.ifdesc.startswith('Microsoft Hyper-V Network Adapter')} |  format-list status,name,ifdesc,macadDresS,driverversion,MediaConNectState,MediaDuplexState`

or

`get-wmiobject win32_networkadapter -filter "servicename='netvsc'" |  format-list netenabled,name,macaddress`

`Get-NetAdapter` is available in 2012+, for 2008R2 use `Get-WmiObject`.

### Show IP properties

`get-wmiobject Win32_NetworkAdapterConfiguration -filter "ServiceName='netvsc'" |  format-list DNSHostName,IPAddress,DHCPEnabled,IPSubnet,DefaultIPGateway,MACAddress,DHCPServer,DNSServerSearchOrder`

### Enable NIC

`get-netadapter | where {$_.ifdesc.startswith('Microsoft Hyper-V Network Adapter')} | enable-netadapter`

or

`(get-wmiobject win32_networkadapter -filter "servicename='netvsc'").enable()`

`Get-NetAdapter` is available in 2012+, for 2008R2 use `Get-WmiObject`.

### Set NIC to use DHCP

`get-netadapter | where {$_.ifdesc.startswith('Microsoft Hyper-V Network Adapter')} | Set-NetIPInterface -DHCP Enabled`

`(get-wmiobject Win32_NetworkAdapterConfiguration -filter "ServiceName='netvsc'").EnableDHCP()`

`Get-NetAdapter` is available on 2012+. For 2008R2 use `Get-WmiObject`. Azure VMs should always be configured in the guest OS to use DHCP to obtain an IP address. The Azure static IP setting still uses DHCP to give the IP to the VM.

### Ping

`test-netconnection`

> [!NOTE]
> The Write-Progress cmdlet may not work with this command. As a mitigation, you can run `$ProgressPreference = "SilentlyContinue"` in PowerShell to disable the progress bar.

or

`get-wmiobject Win32_PingStatus -Filter 'Address="8.8.8.8"' | format-table -autosize IPV4Address,ReplySize,ResponseTime`

`Test-Netconnection` without any parameters try to ping `internetbeacon.msedge.net`. It's available on 2012+. For 2008R2 use `Get-WmiObject` as in the second example.

### Port Ping

`test-netconnection -ComputerName bing.com -Port 80`

or

`(new-object Net.Sockets.TcpClient).BeginConnect('bing.com','80',$null,$null).AsyncWaitHandle.WaitOne(300)`

`Test-NetConnection` is available on 2012+. For 2008R2 use `Net.Sockets.TcpClient`

### Test DNS name resolution

`resolve-dnsname bing.com`

or

`[System.Net.Dns]::GetHostAddresses('bing.com')`

`Resolve-DnsName` is available on 2012+. For 2008R2 use `System.Net.DNS`.

### Show Windows Firewall rule by name

`get-netfirewallrule -name RemoteDesktop-UserMode-In-TCP`

### Show Windows Firewall rule by port

`get-netfirewallportfilter | where {$_.localport -eq 3389} | foreach {Get-NetFirewallRule -Name $_.InstanceId} | format-list Name,Enabled,Profile,Direction,Action`

or

`(new-object -ComObject hnetcfg.fwpolicy2).rules | where {$_.localports -eq 3389 -and $_.direction -eq 1} | format-table Name,Enabled`

`Get-NetFirewallPortFilter` is available on 2012+. For 2008R2 use the `hnetcfg.fwpolicy2` COM object.

### Disable Windows Firewall

`Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False`

`Set-NetFirewallProfile` is available on 2012+. For 2008R2 use `netsh advfirewall` as referenced in the CMD section above.

## Manage Users and Groups using PowerShell

### Create local user account

`new-localuser <name>`

### Verify user account is enabled

`(get-localuser | where {$_.SID -like "S-1-5-21-*-500"}).Enabled`

or

`(get-wmiobject Win32_UserAccount -Namespace "root\cimv2" -Filter "SID like 'S-1-5-%-500'").Disabled`

`Get-LocalUser` is available on 2012+. For 2008R2 use `Get-WmiObject`. This example shows the built-in local administrator account, which always has SID `S-1-5-21-*-500`. Azure VMs created from generalized image will have the local administrator account renamed to the name specified during VM provisioning. So it will usually not be `Administrator`.

### Add local user to local group

`add-localgroupmember -group Administrators -member <username>`

### Enable local user account

`get-localuser | where {$_.SID -like "S-1-5-21-*-500"} | enable-localuser`

This example enables the built-in local administrator account, which always has SID `S-1-5-21-*-500`. Azure VMs created from generalized image will have the local administrator account renamed to the name specified during VM provisioning. So it will usually not be `Administrator`.

### View user account properties

`get-localuser | where {$_.SID -like "S-1-5-21-*-500"} | format-list *`

or

`get-wmiobject Win32_UserAccount -Namespace "root\cimv2" -Filter "SID like 'S-1-5-%-500'" |  format-list Name,Disabled,Status,Lockout,Description,SID`

`Get-LocalUser` is available on 2012+. For 2008R2 use `Get-WmiObject`. This example shows the built-in local administrator account, which always has SID `S-1-5-21-*-500`.

### View local groups

`(get-localgroup).name | sort` `(get-wmiobject win32_group).Name | sort`

`Get-LocalUser` is available on 2012+. For 2008R2 use `Get-WmiObject`.

## Manage the Windows Event Log using PowerShell

### Query event log errors

`get-winevent -logname system -maxevents 1 -filterxpath "*[System[Level=2]]" | more`

Change `/c:10` to the desired number of events to return, or move it to return all events matching the filter.

### Query event log by Event ID

`get-winevent -logname system -maxevents 1 -filterxpath "*[System[EventID=11]]" | more`

### Query event log by Event ID and Provider

`get-winevent -logname system -maxevents 1 -filterxpath "*[System[Provider[@Name='Microsoft-Windows-Hyper-V-Netvsc'] and EventID=11]]" | more`

### Query event log by Event ID and Provider for the last 24 hours

`get-winevent -logname system -maxevents 1 -filterxpath "*[System[Provider[@Name='Microsoft-Windows-Hyper-V-Netvsc'] and EventID=11 and TimeCreated[timediff(@SystemTime) <= 86400000]]]"`

Use `604800000` to look back seven days instead of 24 hours. |

### Query event log by Event ID, Provider, and EventData in the last seven days

`get-winevent -logname system -maxevents 1 -filterxpath "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and EventID=4624 and TimeCreated[timediff(@SystemTime) <= 604800000]] and EventData[Data[@Name='TargetUserName']='<username>']]" | more`

## View or Remove Installed Applications using PowerShell

### List installed software

`get-wmiobject win32_product | select installdate,name | sort installdate -descending | more`

### Uninstall software

`(get-wmiobject win32_product -filter "Name='<name>'").Uninstall()`

## File System Management using PowerShell

### Get file version

`(get-childitem $env:windir\system32\drivers\netvsc*.sys).VersionInfo.FileVersion`

This example returns the file version of the virtual NIC driver, which is named netvsc.sys, netvsc63.sys, or netvsc60.sys depending on the Windows version.

### Download and extract file

`$path='c:\bin';md $path;cd $path;(new-object net.webclient).downloadfile( ('htTp:/'+'/download.sysinternals.com/files/SysinternalsSuite.zip'),"$path\SysinternalsSuite.zip");(new-object -com shelL.apPlication).namespace($path).CopyHere( (new-object -com shelL.apPlication).namespace("$path\SysinternalsSuite.zip").Items(),16)`

This example creates a `c:\bin` folder, then downloads and extracts the Sysinternals suite of tools into `c:\bin`.

## Miscellaneous Tasks using PowerShell

### Show OS version

`get-wmiobject win32_operatingsystem | format-list caption,version,buildnumber`

### View OS install date

`(get-wmiobject win32_operatingsystem).converttodatetime((get-wmiobject win32_operatingsystem).installdate)`

### View last boot time

`(get-wmiobject win32_operatingsystem).lastbootuptime`

### View Windows uptime

`"{0:dd}:{0:hh}:{0:mm}:{0:ss}.{0:ff}" -f ((get-date)-(get-wmiobject win32_operatingsystem).converttodatetime((get-wmiobject win32_operatingsystem).lastbootuptime))`

Returns uptime as `<days>:<hours>:<minutes>:<seconds>:<milliseconds>`, for example `49:16:48:00.00`.

### Restart Windows

`restart-computer`

Adding `-force` forces running applications to close without warning users.

## Instance Metadata

You can query Azure instance metadata from within your Azure VM to view details such as osType, Location, vmSize, vmId, name, resourceGroupName, subscriptionId, privateIpAddress, and publicIpAddress.

Querying instance metadata requires healthy guest network connectivity, because it makes a REST call through the Azure host to the instance metadata service. So if you're able to query instance metadata that tells you the guest is able to communicate over the network to an Azure-hosted service.

For more information, see [Azure Instance Metadata service](/azure/virtual-machines/windows/instance-metadata-service).

### Instance metadata

`$im = invoke-restmethod -headers @{"metadata"="true"} -uri http://169.254.169.254/metadata/instance?api-version=2017-08-01 -method get`

`$im | convertto-json`

### OS Type (Instance Metadata)

`$im.Compute.osType`

### Location (Instance Metadata)

`$im.Compute.Location`

### Size (Instance Metadata)

`$im.Compute.vmSize`

### VM ID (Instance Metadata)

`$im.Compute.vmId`

### VM Name (Instance Metadata)

`$im.Compute.name`

### Resource Group Name (Instance Metadata)

`$im.Compute.resourceGroupName`

### Subscription ID (Instance Metadata)

`$im.Compute.subscriptionId`

### Tags (Instance Metadata)

`$im.Compute.tags`

### Placement Group ID (Instance Metadata)

`$im.Compute.placementGroupId`

### Platform Fault Domain (Instance Metadata)

`$im.Compute.platformFaultDomain`

### Platform Update Domain (Instance Metadata)

`$im.Compute.platformUpdateDomain`

### IPv4 Private IP Address (Instance Metadata)

`$im.network.interface.ipv4.ipAddress.privateIpAddress`

### IPv4 Public IP Address (Instance Metadata)

`$im.network.interface.ipv4.ipAddress.publicIpAddress`

### IPv4 Subnet Address / Prefix (Instance Metadata)

`$im.network.interface.ipv4.subnet.address`

`$im.network.interface.ipv4.subnet.prefix`

### IPv6 IP Address (Instance Metadata)

`$im.network.interface.ipv6.ipAddress`

### MAC Address (Instance Metadata)

`$im.network.interface.macAddress`

## Next steps

* The main serial console Windows documentation page is located [here](serial-console-windows.md).
* The serial console is also available for [Linux](../linux/serial-console-linux.md) VMs.
* Learn more about [boot diagnostics](boot-diagnostics.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
