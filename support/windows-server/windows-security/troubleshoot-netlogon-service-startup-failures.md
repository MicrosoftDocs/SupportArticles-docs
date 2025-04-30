---
title: Troubleshoot Netlogon service startup failures
description: Describes the symptoms, causes, and solutions for the scenarios that lead to Netlogon service startup failures.
ms.date: 04/30/2025
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

The Netlogon service provides support for New Technology LAN Manager (NTLM) logon requests, Kerberos Privilege Attribute Certificate (PAC) verifications, domain controller discovery, DNS registration of SRV records, managing the system's computer account password, and maintaining trust passwords on domain controllers. To accomplish these operations, Netlogon requires facilities of other components and services within the operating system. Generally known as Service Dependencies, Netlogon depends on the services noted in the picture below:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/diagram-of-the-netlogon-service-dependencies.png" alt-text="A diagram of the Netlogon service dependencies.":::

Notice that Netlogon depends on the Workstation service, the Workstation service depends on the Browser, MrxSMB20, and NSI services, and so on. On servers operating as domain controllers, Netlogon has additional dependencies on the Server service, the Server service depends on SAMSS and SRV2, SRV2 depends on SRVNET, and so on. These dependency relationships are detailed by the Services MMC snap-in within the properties of the service's "Dependencies" tab. This dependency configuration is stored within the registry for each services' key under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`. Contained within each service key is a value "DependsOnService" that defines the specific, direct dependencies of that service. For example, the Netlogon service registry key of a domain controller defines the DependOnService value containing the data "LanmanWorkstation LanmanServer".

To view the dependencies of the Netlogon service, leverage the Services MMC and inspect the service properties:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-netlogon-service-properties.png" alt-text="A screenshot of the Netlogon service properties.":::

Another method of querying dependencies is via the Service Control Manager Configuration Tool (sc.exe) command line utility. Below is the output of the `QC` command to query the configuration for Netlogon service dependencies of a domain controller:

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
2. Browse to the desired service key (in this example, the path is `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon`):

   :::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-registry-editor.png" alt-text="A screenshot of the Registry Editor.":::

3. Confirm the proper settings. For example, dependencies are configured (**DependOnService** value), start type is defined (**Start** value), and the service binary (**ImagePath** value).

### Troubleshoot

If a dependent service fails to start, both that service and any services with dependencies on it will likewise not start. When investigating a Netlogon service startup failure, it is important to identify which service was responsible for the failures in all other dependent services. For example, below are the System event log errors reported when the Netlogon service failed to start because the Workstation (LanmanWorkstation) service depends on another service (bowser) that failed to start:

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

Netlogon startup failures (or any dependent service start failures) may require one or more actions to correct the problem. This can include (but is not limited to):

- Correcting disabled dependent services
- Correcting invalid or missing service configuration registry values
- Restoring missing or corrupted executable or DLL files
- Correcting restrictive registry permissions

Below are some of the event log errors that indicate that Netlogon has failed to start.

### Symptom 1

A dependent service did not start:
  
> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7001  
> Level: Error  
> Description: The Netlogon service depends on the \<SERVICE NAME\> service which failed to start because of the following error:  
> The dependency service or group failed to start.

#### Resolution

Inspect the dependent services to determine which service(s) failed to start. Verify the services have a proper service start configuration using the Services MMC snap-in (Services.msc) to view and modify the service configuration.

In the example below, the Workstation service has been configured with a 'disabled' startup type and therefore is in a 'stopped' state:

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-servicesmsc.png" alt-text="A screenshot of the services.msc.":::

:::image type="content" source="media/troubleshoot-netlogon-service-startup-failures/screenshot-of-the-workstation-service-properties.png" alt-text="A screenshot of the Workstation service properties.":::

Setting the **Startup type** to **Automatic** and starting the service will restore Workstation service operation.

### Symptom 2

A nonexistent or invalid service defined for the Netlogon service or a dependent service:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7003  
> Level: Error  
> Description: The Netlogon service depends on the following service: \<MISSING OR INVALID SERVICE\>. This service might not be installed.

#### Resolution

An invalid service may be configured in the 'DependOnService' registry value of the Netlogon service or the service referenced in this value is missing as an installed service. In the example below, the Netlogon service on a member server failed to start because it was unable to validate a dependent service.

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7003  
> Level: Error  
> Description: The Netlogon service depends on the following service: Contoso\_Service. This service might not be installed.

Remove the offending entry found within the DependOnService registry value:

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

Attempting to start Netlogon via Services MMC returns the error "Windows could not start the Netlogon service on Local Computer. Error 126: The specified module could not be found."

#### Resolution

Each service application must initialize dynamic linked libraries (DLLs) successfully in order to function. Perform a system file scan via the System File Checker (SFC.exe) tool (see <https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e>), restore missing DLLs from backup, or perform a repair or reinstallation of the operating system.

### Symptom 4

An invalid or missing service executable specified causes a dependent service to not start:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7000  
> Level: Error  
> Description: The Netlogon service failed to start due to the following error:  
> The system cannot find the file specified.

Attempting to start Netlogon via Services MMC returns the error "Windows could not start the Netlogon service on Local Computer. Error 2: The system cannot find the file specified."

#### Resolution

Validate that the service(s) failing to start have a valid value configured in the "Path to executable" field when viewing service properties via the Services MMC, or validate the proper 'ImagePath' value in the registry for the affected service(s).

### Symptom 5

Netlogon reports that the service entered the stopped state during system boot. Attempting to manually start the service results in the following error:
The Netlogon service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.

#### Resolution

Validate the service permissions within the registry are set to appropriate values. Permissions will vary based on the role of the system (for example domain controllers as compared to workstations or member servers). Ensure that no entries are specifying a 'deny' permission for 'SYSTEM' or 'Administrators'. By default, the registry permissions are inherited from the parent registry key and the owner is configured as 'SYSTEM'.

## Additional symptoms

Other services, such as the Windows Time Service or the Group Policy Service may report failed operations due to Netlogon not being started:

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

Management or other operations relying on the Netlogon service will also fail:

```console
nltest /sc_query:litware.com

I_NetLogonControl failed: Status = 1722 0x6ba RPC_S_SERVER_UNAVAILABLE
```

```console
net use \\192.168.1.11 /user:litware\administrator

System error 1792 has occurred.

An attempt was made to logon, but the network logon service was not started.
```

Domain controller locator will fail to locate a domain controller with error 1355 or "The specified domain either does not exist or could not be contacted".

Domain trust relationships may fail if all reachable domain controllers have their Netlogon service stopped:

> Log Name: System  
> Source: NETLOGON  
> Event ID: 5719  
> Level: Error  
> Description: This computer was not able to set up a secure session with a domain controller in domain <DOMAIN> due to the following:  
> We can't sign you in with this credential because your domain isn't available. Make sure your device is connected to your organization's network and try again. If you previously signed in on this device with another credential, you can sign in with that credential.  
> This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.

## More information

If this computer is a domain controller for the specified domain, it sets up the secure session to the primary domain controller emulator in the specified domain. Otherwise, this computer sets up the secure session to any domain controller in the specified domain.
