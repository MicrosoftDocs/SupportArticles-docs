---
title: Guidance of troubleshooting RDS Licensing
description: Introduces general guidance of troubleshooting scenarios related to RDS Licensing.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
ms.technology: windows-server-rds
---
# RDS Licensing troubleshooting guidance

The listed resources in this article can help you resolve Remote Desktop Services (RDS) licensing issues.

## Troubleshooting checklist

### Grace period

The 120-day licensing grace period value is decremented to 0 (zero) as soon as a license server is configured. For more information, see the following articles:

- [License your RDS deployment with client access licenses (CALs)](/windows-server/remote/remote-desktop-services/rds-client-access-license)
- [Troubleshooting specific RDP error messages to a Windows VM in Azure](/azure/virtual-machines/troubleshooting/troubleshoot-specific-rdp-errors)

The current grace period on a computer can be read by running the following command:

```console
wmic /namespace:\\root\CIMV2\TerminalServices PATH Win32_TerminalServiceSetting WHERE (__CLASS !="") CALL GetGracePeriodDays
```

Or by running the following PowerShell command:

```powershell
$obj = gwmi -namespace "Root/CIMV2/TerminalServices" Win32_TerminalServiceSetting
$obj.GetGracePeriodDays()
```

**Reset grace period**: The grace period can be reset to 0. However, we don't recommended this approach. Instead, you must implement a license server together with a license pack.

### Verify the license servers and current licensing mode that's configured on the Remote Desktop Session Host (RDSH) server

To do so, run the following PowerShell command:

```powershell
$obj = gwmi -namespace "Root/CIMV2/TerminalServices" Win32_TerminalServiceSetting
$obj.GetSpecifiedLicenseServerList()
$obj.LicensingType
```

[LicensingMode values](/windows-hardware/customize/desktop/unattend/microsoft-windows-terminalservices-remoteconnectionmanager-licensingmode#values)

### Set the method for how the license server and the licensing mode will be applied on the RDSH server.

You can use any of the following methods to implement this configuration.

#### Using GUI

Use the RDMS GUI that's started on the active broker. This configuration is stored in the following registry values:

Registry subkey: `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\Licensing Core`  
Registry value: LicensingMode

Registry subkey: `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService\Parameters\LicenseServers`  
Registry value: SpecifiedLicenseServers

#### Using local policy

The **gpedit.msc** console can be used to configure the following policy locally on the server:  
*Computer Configuration > Policies > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Licensing*

- Use the specified Remote Desktop license servers.
- Set the Remote Desktop licensing mode.

These values are stored in the following registry values:

Registry subkey: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`  
Registry values:

- LicenseServers  
- LicensingMode

> [!Note]
> This configuration will apply before the one that's mentioned in "Using GUI". This means that the "Using GUI" configuration will have no effect when a local policy is configured because the registry values will not be taken into account. In this situation, you can't use RDSM to configure the license servers and licensing mode.

#### Using GPO

This method is similar to "Using local policy." The only difference is that this configuration is set by using a GPO that's configured in an Active Directory domain:  
*Computer Configuration > Policies > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Licensing*  
Configure the **Set the Remote Desktop licensing mode** policy.

The policy configuration are stored in the following registry entries on the session host server:  

Registry subkey: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`  
Registry values:

- LicenseServers
- LicensingMode

> [!Notes]
>
> - This configuration will apply before the one that's mentioned in "Using GUI." This means that the "Using GUI" configuration will have no effect when a local policy is configured because the registry values will not be taken into account. In this situation, you can't use RDSM to configure the license servers and licensing mode.
> - The gpedit.msc console that's started on the session host server does not appear in this configuration.

### Check the configuration on the license server

To do this, start the Remote Desktop Licensing Manager console on the licensing server, and then do the following:

- Check whether the licensing server is activated.
- Review the configuration to verify that the scope is correct.
- Make sure that the licensing server is added to the "Terminal Server License Servers" domain group.
- Set how the configuration of licensing servers and the license mode will be applied:  
  - Use the steps in bullet item 2 to check what the session host server sees. Check the registry configuration presented in bullet item 3 to determine how the configuration is set.  
  - If there is a GPO, this means that the parameters are set on the server. Even if gpedit.msc displays a configuration, the configuration will not be used.
- Check whether the Group Policy Object is applied by running the following command:  
  `gpresult /H ?:\fileName.html`

- Check the minimal TCP ports.

  Verify that the minimal TCP ports are open. For more information, see [RD Licensing Network Port Requirements](../networking/service-overview-and-network-port-requirements.md#terminal-services-licensing)

- Use the event log to determine the behavior of the licensing server.
  - On the licensing server, start Event Viewer.
  - Access *Application and Services Logs\\Windows\\TerminalServices-Licensing\\Operational*.
  - The following article contains a list of Remote Desktop Services events that can appear in the event log on a computer that has the RD Licensing role service installed.  
 [Remote Desktop Licensing](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff404145%28v=ws.10%29#remote-desktop-licensing)

## Common issues and solutions

### WVD are getting logged out after 60 minutes with error 0x80070057

Windows Virtual Desktop (WVD) users are getting logged out after 60 minutes because of an invalid license and licensing error 0x80070057.

To troubleshoot this issue, redeploy the host pools so that the grace period gets reset. This is the only supported workaround.

### RDLS stops responding on Windows Server 2016 when Windows Server 2019 CALs are requested

Remote Desktop Licensing service (RDLS) stops responding on Windows Server 2016 when Windows Server 2019 CALs are requested.

Configuring a Windows Server 2019 version RDSH to use a Windows Server 2016 version RDLS is not supported. A Windows Server 2016 version RDLS cannot issue or handle Windows Server 2019 RDS CALs. This problem was fixed in RDLS 2012 R2. It does not occur in RDLS 2019.

### Report date is displayed as "Unknown" in Remote Desktop Licensing Manager

This issue is fixed in update [KB 4457127](https://support.microsoft.com/topic/september-20-2018-kb4457127-os-build-14393-2515-87a49477-8434-8014-623a-17f003a383c0).

## Reference

- [Troubleshooting Remote Desktop Licensing Issues](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/hh553162%28v=ws.10%29)
- [Remote Desktop Licensing Demystified](https://social.technet.microsoft.com/wiki/contents/articles/21180.remote-desktop-licensing-demystified.aspx)
- [RDS and TS CAL Interoperability Matrix](https://social.technet.microsoft.com/wiki/contents/articles/14988.rds-and-ts-cal-interoperability-matrix.aspx)
