---
title: Troubleshoot Netlogon service startup failures
description: Describes the symptoms, causes, and solutions for the scenarios that lead to Netlogon service startup failures.
ms.date: 05/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: davfish, wincicadsec
ms.custom:
- sap:windows security\netlogon,secure channel,dc locator
- pcy:WinComm Directory Services
---
# Troubleshoot Netlogon service startup failures

This article describes the symptoms, causes, and solutions for the scenarios that lead to Netlogon service startup failures.

## Service dependencies

The Netlogon service provides support for New Technology LAN Manager (NTLM) sign-in requests, Kerberos Privilege Attribute Certificate (PAC) verifications, domain controller discovery, Domain Name System (DNS) registration of SRV records, managing the system's computer account password, and maintaining trust passwords on domain controllers. To accomplish these operations, Netlogon requires facilities of other components and services within the operating system. Known as Service Dependencies, Netlogon depends on the services noted in the following diagram:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/diagram-of-the-netlogon-service-dependencies.png" alt-text="A diagram of the Netlogon service dependencies.":::

The Netlogon service depends on the Workstation service. The Workstation service depends on the Browser, MrxSMB20, and NSI services, and so on. On domain controllers, the Netlogon service has additional dependencies on the Server service, and the Server service depends on the SAMSS and SRV2 services, with the SRV2 service depending on the SRVNET service, and so on.

These dependency relationships are detailed by the Services MMC snap-in (Services.msc) within the properties of the service's **Dependencies** tab. This dependency configuration is stored within the registry for each services' key under the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services` registry key. Contained within each service key is a value **DependsOnService** that defines the specific, direct dependencies of that service. For example, the Netlogon service registry key of a domain controller defines the DependOnService value containing the data **LanmanWorkstation LanmanServer**.

To view the dependencies of the Netlogon service, use the Services MMC and inspect the service properties:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-netlogon-service-properties.png" alt-text="A screenshot of the Netlogon service properties.":::

Another method of querying dependencies is to use the Service Control Manager Configuration Tool (sc.exe) command line utility. The following is the output of the `QC` command to query the configuration for the Netlogon service dependencies of a domain controller:

```console
C:\Windows\System32>sc qc netlogon

[SC] QueryServiceConfig SUCCESS

SERVICE_NAME: netlogon
   TYPE               : 20 WIN32_SHARE_PROCESS
   START_TYPE         : 2 AUTO_START
   ERROR_CONTROL      : 1 NORMAL
   BINARY_PATH_NAME   : C:\Windows\system32\lsass.exe
   LOAD_ORDER_GROUP   : MS_WindowsRemoteValidation
   TAG                : 0
   DISPLAY_NAME       : Netlogon
   DEPENDENCIES       : LanmanWorkstation
                      : LanmanServer
   SERVICE_START_NAME : LocalSystem
```

Or, you may navigate to the Netlogon service registry key to inspect the service configuration:

1. Open the registry editor.
2. Browse to the desired service key. In this example, the path is `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon`:

   :::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-registry-editor.png" alt-text="A screenshot of the Registry Editor.":::

3. Confirm the settings are proper. For example, dependencies are configured (**DependOnService** value), start type is defined (**Start** value), and the service binary (**ImagePath** value).

### Troubleshoot

If a dependent service fails to start, both that service and any services relying on the service don't start. When investigating a Netlogon service startup failure, it's important to identify which service was responsible for the failures in all other dependent services. For example, the following event logs are the System event log errors reported when the Netlogon service failed to start. The failure is caused because one the Workstation (LanmanWorkstation) service dependencies (bowser) failed to start:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7001  
> Level: Error  
> Description: The Netlogon service depends on the LanmanWorkstation service which failed to start because of the following error:  
> The dependency service or group failed to start.  

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7001  
> Level: Error  
> Description: The LanmanWorkstation service depends on the bowser service which failed to start because of the following error:  
> The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.

## Netlogon startup failures issues

Netlogon startup failures (or any dependent service start failures) might require one or more actions to correct the problem. This can include (but isn't limited to):

- Correct disabled dependent services.
- Correct invalid or missing service configuration registry values.
- Restore missing or corrupted executable or DLL files.
- Correct restrictive registry permissions.

The following sections are some of the event log errors that indicate that Netlogon failed to start.

### Symptom 1

A dependent service doesn't start:
  
> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7001  
> Level: Error  
> Description: The Netlogon service depends on the \<SERVICE NAME\> service which failed to start because of the following error:  
> The dependency service or group failed to start.

#### Resolution

Inspect the dependent services to determine which services failed to start. Verify the services have a proper service start configuration using the Services MMC snap-in to view and modify the service configuration.

In the following example, the Workstation service is configured with a **Disabled** startup type and therefore is in a **Stopped** state:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-servicesmsc.png" alt-text="A screenshot of the services.msc.":::

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-workstation-service-properties.png" alt-text="A screenshot of the Workstation service properties.":::

Setting the **Startup type** to **Automatic** and starting the service restores the Workstation service operation.

### Symptom 2

A nonexistent or invalid service defined for the Netlogon service or a dependent service:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7003  
> Level: Error  
> Description: The Netlogon service depends on the following service: \<MISSING OR INVALID SERVICE\>. This service might not be installed.

#### Resolution

An invalid service might be configured in the **DependOnService** registry value of the Netlogon service or the service referenced in this value is missing as an installed service. In the following example, the Netlogon service on a member server failed to start because it can't validate a dependent service.

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7003  
> Level: Error  
> Description: The Netlogon service depends on the following service: Contoso\_Service. This service might not be installed.

Remove the offending entry found within the **DependOnService** registry value:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/edit-the-depend-on-service-registry-value.png" alt-text="Edit the DependOnService registry value.":::

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/remove-an-entry-from-the-depend-on-service-registry-value.png" alt-text="Remove an entry from the DependOnService registry value.":::

### Symptom 3

An invalid or missing service Dynamic Linked Library (DLL) specified causes a dependent service to not start:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7001  
> Level: Error  
> Description: The Netlogon service depends on the \<SERVICE NAME\> service which failed to start because of the following error:  
> The specified module could not be found.

When you try to start the Netlogon service by using Services MMC, the following error message is displayed:

> Windows could not start the Netlogon service on Local Computer. Error 126: The specified module could not be found.

#### Resolution

Each service application must initialize DLLs successfully in order to function. Perform a system file scan by using the System File Checker (SFC.exe) tool, restore missing DLLs from backup, or perform a repair installation or a reinstallation of the operating system.

For more information, see [Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e)

### Symptom 4

An invalid or missing service executable specified causes a dependent service to not start:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7000  
> Level: Error  
> Description: The Netlogon service failed to start due to the following error:  
> The system cannot find the file specified.

When you try to start the Netlogon service by using Services MMC, the following error message is displayed:

> Windows could not start the Netlogon service on Local Computer. Error 2: The system cannot find the file specified.

#### Resolution

Validate that the services that fail to start have a valid value configured in the **Path to executable** field when viewing service properties via the Services MMC. Or, validate that the **ImagePath** value is proper in the registry for the affected services.

### Symptom 5

The Netlogon service reports that the service entered the stopped state during system boot. When you try to manually start the service, the following error message is displayed:

> The Netlogon service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.

#### Resolution

Validate the service permissions within the registry are set to appropriate values. Permissions vary based on the role of the system. For example, domain controllers as compared to workstations or member servers. Ensure that no entries are specifying a **Deny** permission for **SYSTEM** or **Administrators**. By default, the registry permissions are inherited from the parent registry key and the owner is configured as **SYSTEM**.

## Additional symptoms

Other services, such as the Windows Time Service or the Group Policy Service might report failed operations due to the Netlogon service not being started:

> Log Name: System  
> Source: Microsoft-Windows-Time-Service  
> Event ID: 159  
> Level: Warning  
> Description: W32time is unable to communicate with Netlogon Service. This failure prevents NTPClient from discovering and using domain peers, besides causing problems with correct W32time service state being advertised by Netlogon. This could be a temporary condition that resolves itself shortly. If this warning repeats over a considerable period of time, ensure the Netlogon service is running and is responsive and restart W32time service to reintiaize the overall state. The error was 0x80070700: An attempt was made to logon, but the network logon service was not started.

> Log Name: System  
> Source: Microsoft-Windows-Time-Service  
> Event ID: 130  
> Level: Warning  
> Description: NtpClient was unable to set a domain peer to use as a time source because of failure in establishing a trust relationship between this computer and the 'litware.com' domain in order to securely synchronize time. NtpClient will try again in 15 minutes and double the reattempt interval thereafter. The error was: The RPC server is unavailable. (0x800706BA)

> Log Name: System  
> Source: Microsoft-Windows-GroupPolicy  
> Event ID: 1110  
> Level: Error  
> Description: The processing of Group Policy failed. Windows could not determine if the user and computer accounts are in the same forest. Ensure the user domain name matches the name of a trusted domain that resides in the same forest as the computer account.

Management or other operations relying on the Netlogon service also fail:

```console
nltest /sc_query:litware.com

I_NetLogonControl failed: Status = 1722 0x6ba RPC_S_SERVER_UNAVAILABLE
```

```console
net use \\192.168.1.11 /user:litware\administrator

System error 1792 has occurred.

An attempt was made to logon, but the network logon service was not started.
```

Domain controller locator fails to locate a domain controller with error 1355 or "The specified domain either doesn't exist or couldn't be contacted".

Domain trust relationships might fail if all reachable domain controllers have their Netlogon services stopped:

> Log Name: System  
> Source: NETLOGON  
> Event ID: 5719  
> Level: Error  
> Description: This computer was not able to set up a secure session with a domain controller in domain \<DOMAIN\> due to the following:  
> We can't sign you in with this credential because your domain isn't available. Make sure your device is connected to your organization's network and try again. If you previously signed in on this device with another credential, you can sign in with that credential.  
> This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.

## More information

If this computer is a domain controller for the specified domain, it sets up the secure session to the primary domain controller emulator in the specified domain. Otherwise, this computer sets up the secure session to any domain controller in the specified domain.
