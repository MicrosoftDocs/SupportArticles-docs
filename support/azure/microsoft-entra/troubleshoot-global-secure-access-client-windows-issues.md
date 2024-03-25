---
title: Troubleshoot issues in Global Secure Access client for Windows
description: Learn how to troubleshoot issues that can occur when you use the Global Secure Access client for Windows.
ms.date: 10/10/2023
author: Abizerh
ms.author: abizerh
editor: v-jsitser
ms.reviewer: tdetzner, pudwivedi, joflore, shacharrozin, azureidcic, v-leedennis
ms.service: entra-id
ms.subservice: users
---
# Troubleshoot issues in the Global Secure Access client for Windows

The [Global Secure Access client](/entra/global-secure-access/how-to-install-windows-client) is deployed on a managed Microsoft Windows device (that is, a Microsoft Entra hybrid join device or a Microsoft Entra joined device). It enables an organization to control network traffic between these devices and various websites, applications, and resources that are available on the internet or intranet (on-premises corporate network). If you use this method to route traffic, you can enforce more checks and controls, such as continuous access evaluation (CAE), device compliance, and multi-factor authentication, to be applied for resource access.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-architecture.png" alt-text="Diagram of traffic routing from the Global Secure Access client to internet or intranet access over Microsoft Entra." border="false" lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-architecture.png":::

## Installation

You can use the following methods to install the Global Secure Access client on a managed Windows device:

- Download and install on a Windows device as a local administrator.

- Deploy through Active Directory Domain Services (AD DS) Group Policy for a Microsoft Entra hybrid join device.

- Deploy through Intune or other MDM service for a Microsoft Entra hybrid join or Microsoft Entra joined device.

If you experience a failure when you try to install the Global Secure Access client, check the following items:

- [Prerequisites for the Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client#prerequisites)

- Errors in the Global Secure Access client logs (*C:\\Users\\\<username>\\AppData\\Local\\Temp\\Global_Secure_Access_Client_\<number>.log*)

- Application and system event logs for any other errors, such as a process failure

If you experience issues when you try to upgrade a client, try to first uninstall the earlier client version, and then restart the device before you try again to install.

For troubleshooting issues in the Global Secure Access client after the installation is successful, you can use the following self-service diagnostic tools:

- Client Checker
- Connection Diagnostics

To access these tools, open the system tray, right-click the icon for the Global Secure Access client, and then select one of these tools in the shortcut menu:

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-system-tray-shortcut-menu.png" alt-text="Screenshot of the shortcut menu of the Global Secure Access client icon in the Windows system tray." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-system-tray-shortcut-menu.png":::

## Troubleshooting checklist

### Step 1: Learn how to use the Client Checker tool

<details>
<summary>Client Checker tool instructions</summary>

The Client Checker tool runs a few checks to make sure that the prerequisites are met for the Global Secure Access client. It reports the status of the tasks that the client runs to accomplish the following items:

- Securely connect to the Global Secure Access network

- Route acquired traffic to the Microsoft Entra "Internet Access" or "Private Access" services

If all the tasks that this tool runs show a `YES` status, this indicates that the GSA client can connect and communicate with Global Secure Access services. This status does not necessarily mean that your application traffic is acquired and sent through the Global Secure Access network. Extra client and service configuration issues might prevent application traffic from being acquired, or they might cause Global Secure Access to block this traffic.

The following text is an example of the full console output from the Client Checker tool:

```output
Starting Client Checker tool
Is Device AAD joined: YES
Forwarding profile Registry Exists: YES
Process GlobalSecureAccessManagementService is running: YES
Process GlobalSecureAccessTunnelingService is running: YES
Process GlobalSecureAccessPolicyRetrieverService is running: YES
Process GlobalSecureAccessClient is running: YES
GlobalSecureAccessDriver is running: YES
GlobalSecureAccess Processes are healthy and not crashing in the last 24h: YES
Other-processes are healthy and not crashing in the last 24h: NO
Magic IP received for Fqdn m365.edgediagnostic.globalsecureaccess.microsoft.com: YES
Magic IP received for Fqdn private.edgediagnostic.globalsecureaccess.microsoft.com: YES
Cached token: YES
M365's edge reachable: YES
Private's edge reachable: YES
Channel M365 diagnosticUri in policy: YES
Channel Private diagnosticUri in policy: YES
Is secure DNS disabled in Chrome?: YES
Is secure DNS disabled in Edge?: YES
Manual Proxy is disabled: YES
Is M365 channel reachable: YES
Is Private channel reachable: YES
M365 tunneling success: YES
Private tunneling success: YES
Finished Client Checker tool, press any key to exit
```

The following list describes the actions that the Client Checker tool takes:

1. Checks whether services that are related to the Global Secure Access client have started.

   If any services are in a stopped or starting state, you might see the following output:

   ```output
   Process GlobalSecureAccessManagementService is running: YES
   Process GlobalSecureAccessTunnelingService is running: YES
   Process GlobalSecureAccessPolicyRetrieverService is running: NO
   Process GlobalSecureAccessClient is running: YES
   ```

   In this case, follow these steps:

   1. Select **Start**, search for *services.msc*, and then select the Services app.
   1. In the **Services** window, look for the following services in the **Name** column, and then check whether the values in the corresponding **Status** column are equal to **Running**:

      - **Global Secure Access Management Service**
      - **Global Secure Access Policy Retriever Service**
      - **Global Secure Access Tunneling Service**

1. Checks whether Global Secure Access drivers are loaded.

   The Client Checker tool might generate the following output:

   ```output
   GlobalSecureAccessDriver is running: NO
   ```

   In this case, verify whether the driver is actually operating by running the [sc query](/windows-server/administration/windows-commands/sc-query) command:

   ```cmd
   sc query GlobalSecureAccessDriver
   ```

   If the output of the `sc query` command states that the driver isn't running, search the event log for event 304 involving the Global Secure Access client. If the event confirms that the driver isn't running, reinstall the Global Secure Access client.

1. Checks whether the edge location for Global Secure Access is accessible.

   To check the accessibility of the edge location, the Client Checker tests for the following items:

   - Whether the magic IP address is received for the Microsoft 365 and private edge locations

   - Whether the Microsoft 365 and private edge locations are reachable

   The Client Checker output for these items might resemble the following text:

   ```output
   Magic IP received for Fqdn m365.edgediagnostic.globalsecureaccess.microsoft.com: YES
   Magic IP received for Fqdn private.edgediagnostic.globalsecureaccess.microsoft.com: YES
   Cached token: YES
   M365's edge reachable: YES
   Private's edge reachable: YES
   ```

   If any of the test results are `NO`, you might consider checking whether a firewall or web proxy is blocking the connections. A network trace might help identify DNS resolution issues, dropped packets, or "connections denied" errors for the following fully qualified domain names (FQDNs):

   - `m365.edgediagnostic.globalsecureaccess.microsoft.com`
   - `private.edgediagnostic.globalsecureaccess.microsoft.com`

   To reproduce the issue, run the following [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) cmdlet:

   ```powershell
   Test-NetConnection -ComputerName <edge-fqdn> -Port 443
   ```

   For example, you can run the following cmdlets:

   ```powershell
   Test-NetConnection -ComputerName <tenant-id>.m365.client.globalsecureaccess.microsoft.com -Port 443
   Test-NetConnection -ComputerName <tenant-id>.private.client.globalsecureaccess.microsoft.com -Port 443
   ```

   If the cmdlet output displays a `TcpTestSucceeded` field value of `True`, the client was able to establish a TCP connection to the edge. After the cmdlet makes a TCP connection, it establishes a Transport Layer Security (TLS) connection that should be visible in a network trace.

1. Checks whether the device is joined to Microsoft Entra ID and whether user authentication is successful.

   If either of these checks indicate failure, take one or more of the following actions:

   - Make sure that the device is Microsoft Entra joined or Microsoft Entra hybrid joined. For now, Microsoft Entra registered devices aren't supported.

   - Make sure that the device state for your managed device is `healthy`. For more information, see [Troubleshoot devices by using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd).

   - Make sure that you are signed in to the Global Secure Access client as a Microsoft Entra user in the same tenant in which Global Secure Access is configured and licensed.

   - If you want to sign in again, right-click the icon for the Global Secure Access client in the system tray, and then select **Switch user** in the shortcut menu.

     :::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-system-tray-switch-user.png" alt-text="Screenshot of the shortcut menu of the Global Secure Access client icon in the Windows system tray. The 'Switch user' menu item is highlighted." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-system-tray-switch-user.png":::

     This command should restart the user sign-in process.

   - Hover over the client's system tray icon. The tooltip text displays the status of the Global Secure Access client. If the status shows **disabled by policy**, don't expect the client to prompt for authentication.

     > [!NOTE]  
     > The **disabled by policy** message might appear if you previously disabled the traffic forwarding profile. For more information, see <a href="#traffic-profile">item 6 (*Checks whether a secure tunnel for the traffic profile can be established*)</a>.

1. Checks whether the Global Secure Access policies that are related to the different traffic profiles are applied on the device.

   The Client Checker tool looks for the existence of the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client** registry subkey, and then checks for the following registry entries.

   | Registry entry        | Value description                                                              |
   |-----------------------|--------------------------------------------------------------------------------|
   | **ForwardingProfile** | The Global Secure Access policy that's cached in the registry                  |
   | **TenantId**          | The ID of the tenants that the Client Checker tool is fetching the policy from |

1. <a name="traffic-profile"></a>Checks whether a secure tunnel for the traffic profile can be established.

   The Client Checker tool determines whether the `M365` and `Private` channels are reachable, and whether tunneling to those channels are successful. It produces output that resembles the following text:

   ```output
   Is M365 channel reachable: YES
   Is Private channel reachable: YES
   M365 tunneling success: YES
   Private tunneling success: YES
   ```

   To make sure that the necessary traffic forwarding profile is enabled, follow these steps:

   1. In the navigation pane of the [Microsoft Entra admin center][meac], expand **Global Secure Access (Preview)**, expand **Connect**, and then select **Traffic forwarding**.

   1. In the **Traffic forwarding** page, locate the **Manage traffic forwarding profiles** heading.

   1. In that heading, make sure that the **Microsoft 365 profile** and **Private access profile** options are selected, and that the word **Enabled** appears after those profile names.

1. Checks for potential configuration issues that can cause traffic acquisition problems.

   The Client Checker tool checks whether secure DNS is disabled in the Google Chrome and Microsoft Edge browsers, and it checks whether manual proxy is disabled. The output for these checks resembles the following text:

   ```output
   Is secure DNS disabled in Chrome?: YES
   Is secure DNS disabled in Edge?: YES
   Manual Proxy is disabled: YES
   ```

   > [!NOTE]  
   > Some [limitations in the current release of Global Secure Access][limitations] prevent the Global Secure Access client from acquiring the application and web traffic. These limitations include a lack of support for the following protocols. (The limitations are expected to be removed as Microsoft releases new features and support for these protocols.)
   >
   > - IPv6
   > - Secure DNS
   > - UDP traffic

   > [!IMPORTANT]  
   > Because Global Secure Access doesn't currently support UDP traffic, UDP traffic to port 443 can't be tunneled. You can disable the QUIC protocol so that Global Secure Access clients fall back to using HTTPS (TCP traffic on port 443). You must make this change if the servers that you're trying to access do support QUIC (for example, through Microsoft Exchange Online). To disable QUIC, you can take one of the following actions:
   >
   > - Disable QUIC in Windows Firewall
   >
   >   The most generic method to disable QUIC is to disable that feature in Windows Firewall. This method affects all applications, including browsers and rich client apps (such as Microsoft Office). In PowerShell, run the following [New-NetFirewallRule](/powershell/module/netsecurity/new-netfirewallrule) cmdlet to add a new firewall rule that disables QUIC for all outbound traffic from the device:
   >
   >   ```powershell
   >   $ruleParams = @{
   >       DisplayName = "Block QUIC"
   >       Direction = "Outbound"
   >       Action = "Block"
   >       RemoteAddress = "0.0.0.0/0"
   >       Protocol = "UDP"
   >       RemotePort = 443
   >   }
   >   New-NetFirewallRule @ruleParams
   >   ```
   >
   > - Disable QUIC in a web browser
   >
   >   You can disable QUIC at the web browser level. However, this method of disabling QUIC means that QUIC continues to work on non-browser applications. To disable QUIC in Microsoft Edge or Google Chrome, open the browser, locate the **Experimental QUIC protocol** setting (`#enable-quic` flag), and then change the setting to **Disabled**. The following table shows which URI to enter in the browser's address bar so that you can access that setting.
   >
   >   | Browser        | URI                           |
   >   |----------------|-------------------------------|
   >   | Microsoft Edge | `edge://flags/#enable-quic`   |
   >   | Google Chrome  | `chrome://flags/#enable-quic` |

</details>

### Step 2: Learn how to use the Connection Diagnostics tool

<details>
<summary>Connection Diagnostics tool instructions</summary>

You can use the Connection Diagnostics tool to review whether services are running or host acquisition is occurring. When you open the Connection Diagnostics tool, the Global Secure Access Client Connection Diagnostics window appears.

#### Summary tab

The Connection Diagnostics tool initially opens to the **Summary** tab. This tab displays the following information:

- When the policy was last updated
- The policy version
- The tenant ID (a GUID)
- Whether host name acquisition occurred (using a colored bullet to indicate its status)

The **Summary** tab resembles the following image:

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-summary-tab.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window. The Summary tab is initially shown." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-summary-tab.png":::

#### Services tab

The **Services** tab displays the status of the various services. In the following image, the green bullets indicate that the Tunneling Service and the Management Service are running, and the red bullet indicates that the Policy Retriever service isn't running.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-services-tab.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window's Services tab. Colored bullets indicate the status of three services." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-services-tab.png":::

#### Channels tab

The **Channels** tab shows which traffic profiles are available, and it indicates the status of the tunnel that's established for the traffic profiles. To get the status, the Connection Diagnostics tool sends a keep-alive health probe to the following FQDNs:

- `m365.edgediagnostic.globalsecureaccess.microsoft.com`
- `private.edgediagnostic.globalsecureaccess.microsoft.com`
- `<tenant-id>.edgediagnostic.globalsecureaccess.microsoft.com`

> [!NOTE]  
> The actual URL for the probe resembles the following string: `https://m365.edgediagnostic.globalsecureaccess.microsoft.com:6543/connectivitytest/ping` (for the M365 channel).

In the following image, the **Channels** tab shows green bullets next to the **M365** and **Private** tunnels to indicate that they're operating correctly.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-channels-tab.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window's Channels tab. Colored bullets indicate the status of the channels." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-channels-tab.png":::

#### HostNameAcquisition tab

The **HostNameAcquisition** tab displays the URLs and IP addresses of traffic that's acquired by the Global Secure Access client and routed through the compliant network. This information is shown in tabular format that contains the following columns of data:

- **TimeStamp**
- **FQDN**
- **Generated IP Address**
- **Original IPv4 Address**
- **Handling Time**
- **Packet ID**

The **HostNameAcquisition** tab resembles the following image.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-hostnameacquisition-tab.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window's HostNameAcquisition tab that contains network data in table format." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-hostnameacquisition-tab.png":::

If your application or resource IP address doesn't appear on the **HostNameAcquisition** tab, collect a network trace while you access the resource. Inspect the trace to determine whether the network traffic went through an alternative route.

Because of [known limitations in the Global Secure Access client][limitations], make sure that the following conditions are met:

- IPv6 traffic isn't being used
- Secure DNS is disabled in the web browser
- DNS resolution and caching are disabled in the browser

> [!NOTE]  
> To implement the first two conditions, see [Disable IPv6 and secure DNS](/entra/global-secure-access/how-to-install-windows-client#disable-ipv6-and-secure-dns).

Does your device use an alternative web proxy or [secure access service edge (SASE) solution](https://www.microsoft.com/security/business/security-101/what-is-sase)? In this case, configure the web proxy or SASE solution so that it doesn't try to acquire the same traffic that's meant to go through the Global Secure Access network. To learn how to make this configuration change on a web proxy, see [Proxy configuration example](/entra/global-secure-access/how-to-install-windows-client#proxy-configuration-example).

#### Flows tab

The **Flows** tab displays a list of all connections that were made. Some of the listed connections are routed through the Global Secure Access network, and others are routed directly. The list is shown in tabular format and has the following columns:

- **TimeStamp**
- **FQDN**
- **Source Port**
- **Destination IP**
- **Destination Port**
- **Protocol**
- **Process Name**
- **Flow Active?**
- **Sent Data[Bytes]**
- **Received Data[Bytes]**
- **Auth Time**
- **Correlation ID**

The **Flows** tab is shown in the following image.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-flows-tab.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window's Flows tab, containing connection data in table format." lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/connection-diagnostics-window-flows-tab.png":::

This tab illustrates how the Global Secure Access client processes the following items:

- Network traffic
- Connections that are acquired
- Connections that aren't bypassed

On a Global Secure Access client, "Flows" are the same as "Connections" in the Global Secure Access traffic logs. You should be able to use the correlation ID from the **Flows** tab for traffic that was acquired (that is, traffic that has a 6.6.*x*.*x*-series destination IP address) to find the corresponding entries in the [Microsoft Entra admin center][meac]. In the admin center, select **Global Secure Access** > **Monitor** > **Traffic logs**. The "Correlation ID" from the Connection Diagnostics tool is equivalent to the "connectionId" field in the traffic log activity details. For more information, see [How to use the Global Secure Access (preview) traffic logs](/entra/global-secure-access/how-to-view-traffic-logs).

You might also want to check the data that's sent and received for a connection. If you see little-to-no data being sent and received, there might be an issue. Or, the tunnel session was set up, but no data was transferred.

</details>

### Step 3: Review the event logs

The Global Secure Access client has detailed event log support. To view the logs, follow these steps:

1. Select **Start**, and search for and select **Event Viewer**.
1. In the console tree of the Event Viewer window, expand **Application and Services logs** > **Microsoft** > **Windows** > **Microsoft Global Secure Access Client**.
1. In the **Microsoft Global Secure Access Client** node, select the **Operational** log. Within this log, you can find events that belong to the following categories:

   - Connection handling and errors
   - Authentication handling and errors

1. In the **Microsoft Global Secure Access Client** node, select the **Debug** log. This log contains events that belong to the following categories:

   - Detailed traffic flow handling
   - Traffic that is acquired or isn't acquired

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[limitations]: /entra/global-secure-access/how-to-install-windows-client#known-limitations
[meac]: https://entra.microsoft.com
