---
title: The Monitored or Offline status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Monitored or Offline signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 12/10/2023
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI167992
  - CI185118
---
# The Monitored or Offline status is Unhealthy

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Monitored** or **Offline** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**.

- If the **Offline** signal is unhealthy, the room system is completely deactivated. If the system was powered on, the system might stop responding and generate a stop error during startup. In other cases, the console works correctly, but a message in a purple window might appear on the console and indicate that the system has no network connection.
- If the **Monitored** signal is unhealthy, the Teams Rooms functionality might still work correctly.

If a device is unmonitored or offline, the Teams Rooms Pro Management portal can't report the health of the device or notify you of unhealthy signals. Additionally, the following issues might occur:

- Scheduled updates won't be installed.
- Automatic remediation won't be scheduled to be run.
- Remote tasks, such as collecting logs and restarting the device, will fail.

## Resolve unmonitored status

### Run the Teams Rooms Pro agent test tool

If the **Monitored** signal is **Unhealthy**, you can use the Teams Rooms Pro agent test tool to diagnose common causes:

1. [Switch to Admin mode](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
2. Open the Microsoft Edge browser, enter *[https://aka.ms/mtrp/agenttesttoolv2](https://aka.ms/mtrp/agenttesttoolv2)*, and then download the Microsoft Teams Rooms Pro agent test tool *MTRProAgentCheckv2.zip* file.
 
   > [!NOTE]
   >
   > If you can't download directly from the device because of network access restrictions, use another device to download the file, and then copy the file to the affected device by using a USB drive.
3. Open the .zip file, and then double-click or tap the *MTRPro.AgentTestTool.exe* executable. When you're prompted to extract the file, select **Run** to execute it directly.
4. On the **User Account Control** dialog, select **Yes** to continue.

After the agent test tool completes, a brief summary of the tool's results is displayed in the PowerShell console. Press **ENTER** to continue, and the following information is available:

- A detailed report (in HTML format) of the tests that are performed and their results.
- A .zip file containing additional details and logs is generated in the *C:\Rigel\MTRProAgentTestTool* directory. This .zip file contains additional information that's required by Microsoft Support during investigation.

### Check whether TPM is enabled

The Teams Rooms Pro agent relies on Trusted Platform Module (TPM) to uniquely identify a device. TPM must be enabled to enroll a device into Teams Rooms Pro Management. If TPM is disabled after the device is enrolled, the device might become unmonitored at some point (usually after several days).

To check the current status of TPM, run the following command in an elevated PowerShell window on the device:

```powershell
 Get-Tpm | Select-Object TpmPresent,TpmReady,TpmEnabled,TpmActivated
```

If the command returns an error message, or if the value of the `TpmPresent` or `TpmReady` property is **false**, [enable TPM on the device](https://support.microsoft.com/windows/1fd5a332-360d-4f46-a1e7-ae6b0c90645c#bkmk_enable_tpm). Refer to the OEM documentation, as necessary.

### Check whether the Teams Rooms Pro agent is installed

The Teams Rooms Pro agent (also known as Microsoft Managed Rooms or MMR agent) includes monitoring software that has to be installed on a Teams Rooms device through an [MSI executable](https://aka.ms/serviceportalagentmsi). For more information about single or bulk installation options of the agent, see [Enroll a Teams Room device into Pro Management](/microsoftteams/rooms/enroll-a-device#installation).

After the agent is installed, go to **Settings** > **Apps** > **Apps & features**, and verify that **Microsoft Managed Rooms** is listed under **App list**.

> [!NOTE]
>
> The agent might be removed by certain maintenance processes, such as manual uninstallation, device reset, or reimage.

### Check whether the Teams Rooms Pro agent is running

To work correctly, the Teams Rooms Pro agent relies on the following scheduled tasks:

- **`ManagedRoomsLauncher`**: This task makes sure that the agent (ServicePortalAgent.exe) is started when Windows starts.
- **`ManagedRoomsUpdater`**: This task makes sure that the agent is self-updated to the latest available version.

If either of these tasks is missing or disabled, the agent won't function correctly.

Open Task Scheduler, and verify that both tasks are listed and enabled. If either task is missing, uninstall the **Microsoft Managed Rooms** app, and then [download and reinstall the agent](/microsoftteams/rooms/enroll-a-device#installation).

### Check whether the device is listed in the Teams Rooms Pro Management portal

The Teams Rooms Pro agent uses the Teams sign-in information of the Teams Rooms app to handle the initial onboarding process. To successfully onboard a device to the Teams Rooms Pro Management portal, the Teams Rooms app must be signed in to Teams successfully.

If the agent (ServicePortalAgent.exe) is running correctly, check whether Teams sign-in fails. If so, [fix Teams Rooms resource account sign-in issues](teams-rooms-resource-account-sign-in-issues.md).

### Check connection to the Teams Rooms Pro Management endpoints

- Make sure that connections to the [required IPs and URLs](/microsoftteams/rooms/security#network-security) aren't blocked.
- Make sure that [URLs required for Teams Rooms Pro Management communication](/microsoftteams/rooms/enroll-a-device#urls-required-for-communication) are allowed.
- If your network setup doesn't require a web proxy to connect to the internet, make sure that all hostnames of URLs that are used by the Teams Rooms Pro agent can be resolved by the DNS servers that are used by the Teams Rooms device. Also, make sure that remote port 443 for all hostnames is open for communication and not blocked by firewalls.

  To check DNS resolution issues and TCP port connectivity, use the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection?view=windowsserver2019-ps&preserve-view=true) PowerShell cmdlet. For example:

  ```powershell
   Test-NetConnection -ComputerName mmrprodnoamiot.azure-devices.net -Port 443
  ```

  - If the DNS server can't resolve the IP address of the remote hostname, a warning message is returned.
  - In the output, the values of `InterfaceAlias` and `SourceAddress` indicate the network interface that's used for the communication.
  - In the output, the value of `TcpTestSucceeded` indicates whether TCP port 443 is open for communication or is unreachable.

- If your organization uses a web proxy infrastructure for external network access, make sure that the proxy server is correctly configured. Also, make sure that the proxy server doesn't require authentication. This is because Teams Rooms doesn't support authenticated proxy servers.

  Proxy servers are usually configured on Teams Rooms devices by using one of the following methods:

  - Use Web Proxy Auto-Discovery (WPAD) supported by DHCP or DNS to enable automatic discovery of a Proxy auto-config (PAC) script that's hosted on a server in the corporate network. When you use this method, work together with your network team to make sure that the following conditions are met:

    - The DHCP service or DNS server that's used by the Teams Rooms device doesn't advertise the URL of the wpad file.
    - The server (including port) that hosts the PAC file must be reachable by the Teams Rooms device. For example, `http://wpad.contoso.com/wpad.dat`.
    - The PAC file that's hosted on the server, such as *wpad.dat* in the example, must include the appropriate rules (DIRECT or a specific proxy server host+port) for the URLs that are used by the Teams Rooms Pro agent.
    - The **WinHTTP Web Proxy Auto-Discovery Service** isn't disabled.
    - If any explicit proxy configuration was done previously for the [Teams Room app (Skype user)](/microsoftteams/rooms/rooms-prep#proxy) or the [Teams Rooms Pro agent (Local System)](/microsoftteams/rooms/enroll-a-device#adding-proxy-settings-optional), restore the configuration to the default settings so that the proxy settings are configured to automatically detect the proxy.
  - Use an explicit proxy server IP or hostname and port configuration. When you use this method, work together with your network team to make sure that the appropriate proxy server IP or host and port are configured for both the [Teams Room app (Skype user)](/microsoftteams/rooms/rooms-prep#proxy) and the [Teams Rooms Pro agent (Local System)](/microsoftteams/rooms/enroll-a-device#adding-proxy-settings-optional).
  - Use an explicit PAC script configuration that's hosted on a server in your corporate network. When you use this approach, work together with your network team to make sure that the following conditions are met:

    - The server (including port) that hosts the PAC file must be reachable by the Teams Rooms device. For example, `http://proxypacserver.contoso.com/MyProxyFile.pac`.
    - The PAC file that's hosted on the server must include the appropriate rules (DIRECT or a specific Proxy server host+port) for the URLs that are used by the Teams Rooms Pro agent.
    - The appropriate proxy PAC is configured for both the [Teams Room app (Skype user)](/microsoftteams/rooms/rooms-prep#proxy) (AutoConfigURL) and [Teams Rooms Pro agent (Local System)](/microsoftteams/rooms/enroll-a-device#adding-proxy-settings-optional) (autoscript setting).
  - Use transparent proxy deployment in the corporate network. Unlike traditional web proxies, this method doesn't require configurations on Windows (explicit or default auto-discovery). This is because the network infrastructure makes sure that all HTTP traffic is forced to go through the proxy. In this case, work together with your network team to make sure that the following conditions are met:

    - If any [URLs that are used by the Teams Rooms Pro agent](/microsoftteams/rooms/enroll-a-device#urls-required-for-communication) are subject to SSL Inspection or SSL forward proxy (SSL termination in the proxy), make sure that the certificate chain that's used to issue SSL certificates is trusted on the Teams Rooms device. That is, make sure that the root CAs and intermediate CAs that are used by the SSL termination are added as part of the Local Computer certificate store.
    - In case of intermittent Teams Rooms Pro agent disconnections, consider reviewing whether the egress path to the [agent's endpoints](/microsoftteams/rooms/enroll-a-device#urls-required-for-communication) is bouncing frequently between egress IP and routes.

- The Teams Rooms Pro agent relies on the HTTP protocol for all communication through SSL (port 443). Although some communications are simple HTTP requests to retrieve payloads (such as downloading files), the core monitoring functionality is supported by using WebSockets. Work together with your network team to make sure that any proxies or application-level firewalls provide support and are configured to allow communication through WebSockets.

> [!TIP]
>
> For troubleshooting only, and to help identify and fix monitoring issues that are caused by network or proxy configuration issues, consider temporarily rolling back any proxy configurations that are made for the [Teams Room app (Skype user)](/microsoftteams/rooms/rooms-prep#proxy) and the [Teams Rooms Pro agent (Local System)](/microsoftteams/rooms/enroll-a-device#adding-proxy-settings-optional). Also consider using an alternative network that allows connecting Teams Rooms devices directly to the internet. For example, connect the Teams Rooms device to a Wi-Fi hotspot while also temporarily disconnecting from wired connections.

### Further troubleshooting and assistance

The following log files provide additional information about monitoring issues:

- The Windows event log named **Microsoft Managed Rooms**
- The application runtime log file, *C:\Windows\ServiceProfiles\LocalService\AppData\Local\ServicePortalAgent\Logs\ServicePortalAgent*.log*

For additional help, follow these steps:

1. [Run the Teams Rooms Pro agent test tool](#run-the-teams-rooms-pro-agent-test-tool).
2. [Create a support request](get-support-teams-rooms-pro-management.md#create-a-support-request), and make sure that you attach the .zip file that's collected in step 1.

## Resolve offline status

### Check whether the device is powered off

The device may be intentionally powered off because of scheduled maintenance or operations tasks on the room or Teams Rooms hardware. In these situations, you can [use the Suppress ticket functionality](/microsoftteams/rooms/managed-meeting-rooms-portal#room-detail-status-and-changes) to silence any notification about the **Offline** signal.

If you observe a large increase in the number of offline devices that are located on a single floor, building, or area, a common reason is an unexpected power outage. In this situation, work together with your facilities team to assess whether a power outage will occur at the location where the affected devices are located.

If a specific device is powered off unexpectedly, and if it experiences such issues frequently, use the **System** event log on Windows to identify potential causes:

1. Filter by Event ID 41 (Source: `Kernel-Power`) to detect when the system starts after an unexpected shutdown. Also, filter for error 1001 (Source: `BugCheck`). This indicates an unexpected Windows stop error (also known as a bluescreen), and try to correlate these two event types on the timeline.
2. If there are no `BugCheck` events that are associated with `Kernel-Power` events, check the power outlet or strip for problems, and also check for power cable issues.

### Check for failures during Windows startup

If a Teams Rooms device gets stuck during startup (for example, it keeps stopping at a specific BIOS or UEFI error message or gets stuck in a startup loop), consider reimaging the device, as described in the OEM documentation.

### Check network connectivity

- Make sure that the [network requirements](/microsoftteams/rooms/rooms-prep#check-network-availability) are met.
- If you observe a large increase in the number of offline devices located on a single floor, building, or area, a common reason is an unexpected network outage. In this case, work with your network team to assess whether a network outage will occur at the location where the affected devices are located or the network devices in their egress traffic.
- Review your network adapter settings, such as IP/DHCP settings, DNS servers, default gateway and routing. As a best practice, you should define standards for network configurations to be used on all your Teams Rooms devices.
- Check the Network Connectivity Status Indicator (NCSI) status.

  NCSI is an OS feature that determines whether access to the internet is available. To check whether NCSI is registering your internet connection, follow these steps:

  1. Run the following PowerShell command:

     ```powershell
      Get-NetConnectionProfile
     ```

     If the value of `IPv4Connectivity` is **Internet**, this means that internet access is available. If the value is **`NoTraffic`** or **`LocalNetwork`**, this means that internet access isn't available.
  2. If you aren't behind a proxy, run the following command at a command prompt:

     `nslookup dns.msftncsi.com`

     If the address resolves, it means that internet access is available.
  3. Enter the following URLs in your web browser:

     - `http://www.msftconnecttest.com/connecttest.txt`
     - `http://ipv6.msftconnecttest.com/connecttest.txt`

     If these URLs return **Microsoft Connect Test**, it means that internet access is available.

  If NCSI isn't registering your internet connection, consider setting it to use global DNS:

   1. Open Registry Editor.
   2. Locate the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator` registry subkey.
   3. Right-click the subkey, and then select **New** > **DWORD (32-bit) Value**.
   4. Enter **`UseGlobalDNS`** as the name, and set the value to **1**.
   5. Restart the device.

- If your organization uses 802.1_x_ authentication to connect to the network, review whether all client configurations are set up, such as CA certificates.
- [Check the connection to the Teams Rooms Pro Management endpoints](#check-connection-to-the-teams-rooms-pro-management-endpoints).

## More information

Communication between the Teams Rooms Pro Management portal and the Teams Rooms Pro agent running on a Teams Rooms device is done through Azure IoT Hub by using [a set of predefined endpoints](/microsoftteams/rooms/enroll-a-device#urls-required-for-communication) with HTTP protocol through SSL (port 443). Whenever Azure IoT Hub triggers a disconnection event, the Teams Rooms Pro Management portal waits for one hour to determine whether the device's **Monitored** signal is unhealthy.

The Teams Rooms Pro Management portal also monitors the status of the connection that's tracked by the Microsoft Teams service. Whenever both connection statuses (Teams service and Teams Rooms Pro Management portal) report that the system has not connected recently, the device is reported as **Offline**. In this situation, the device is unmonitored, and it might not be available for calls and meetings.
