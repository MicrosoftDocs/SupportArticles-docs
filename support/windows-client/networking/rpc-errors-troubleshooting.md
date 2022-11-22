---
title: RPC error troubleshooting guidance
description: Learn how to troubleshoot Remote Procedure Call (RPC) errors that occur during computer-to-computer communication. Such communication can involve Windows Management Instrumentation (WMI), SQL Server, Active Directory operations, or remote connections.
ms.date: 11/23/2022
ms.prod: windows-client
ms.topic: troubleshooting
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
ms.collection: highpri
ms.technology: windows-client-networking
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.reviewer: kaushika
audience: itpro
localization_priority: medium
---
# Remote Procedure Call (RPC) errors troubleshooting guidance

_Applies to:_ &nbsp; Windows Client

You might encounter an "RPC server unavailable" error when you connect to Windows Management Instrumentation (WMI), SQL Server, during a remote connection, or for some Microsoft Management Console (MMC) snap-ins. The following image is an example of a Remote Procedure Call (RPC) error.

:::image type="content" source="media/rpc-errors-troubleshooting/rpc-error.png" alt-text="Screenshot of an error message window showing the following error has occurred: the RPC server is unavailable." border="false":::

This message is a commonly encountered error message in the networking world and if one doesn't understand what is happening 'under the hood," one can lose hope fast.

Before getting in to troubleshooting the "RPC server unavailable" error, let's first understand basics about the error. There are a few important terms to understand:

- **Endpoint mapper (EPM)**. A service that listens on the server, which guides client apps to server apps by using port and UUID information.
- **Tower**. Describes the RPC protocol to allow the client and server to negotiate a connection.
- **Floors**. The layers of contents within a tower that contain specific data like ports, IP addresses, and identifiers.
- **UUID** A well-known GUID that identifies an RPC application. During troubleshooting, you can use the UUID to track the RPC conversations of a single type of application (among the many types that occur on a single computer at one time).
- **Opnum** Identifies a function that the client wants the server to perform. It's just a hexadecimal number, but a good network analyzer will translate the function for you. If neither knows, contact your application vendor.
- **Port**. The communication endpoint for client or server application. The EPM allocates dynamic ports (also known as high ports or ephemeral ports) for clients and servers to use.
  > [!NOTE]  
  > Typically the port number is the most important information that you'll use for troubleshooting.
- **Stub data**. The data exchanged between the functions on the client and the functions on the server. This data is the payload, the important part of the communication.

## How the connection works

The following diagram shows a client connecting to a server to perform a remote operation. The client initially contacts TCP port 135 on the server, then negotiates with EPM for a dynamic port number. After EPM assigns a port, the client disconnects and then uses the dynamic port to connect to the server.  

:::image type="content" source="media/rpc-errors-troubleshooting/rpc-flow.png" alt-text="Diagram that shows how a client makes an RPC connection to a remote server." border="true":::

> [!IMPORTANT]  
> When a firewall separates the client and the server, the firewall has to allow communication on port 135 and on the dynamic ports that EPM assigns. One approach to managing this issue is to specify ports or ranges of ports for EPM to use. For more information, see [Configure **how** `RPC` *allocates* dynamic ports](#configure-how-rpc-allocates-dynamic-ports).
>  
> Some firewalls also allow UUID filtering. In UUID filtering, when an RPC request uses port 135 to cross the firewall and contact EPM, the firewall notes the UUID that's associated with the request. When EPM responds and sends a dynamic port number for that UUID, the firewall notes the port number as well. Subsequently, the firewall allows RPC bind operations for that UUID and port.

### Configure **how** `RPC` *allocates* dynamic ports

By default, EPM allocates dynamic ports randomly from the range that's configured for TCP and UDP (based on the implementation of the operating system used). However, this approach might not be practical, especially when the client and server must communicate through a firewall. An alternative is to specify a port number or range of port numbers for EPM to use, and open those ports in the firewall.

Many Windows server applications that rely on RPC provide options (such as registry keys) to customize the allowed ports. Windows services use the **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Rpc\\Internet** subkey for this purpose.

When you specify a port or port range, use ports outside of the range of commonly-used ports. You can find a comprehensive list of server ports that are used in Windows and major Microsoft products in [Service overview and network port requirements for Windows](/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements). This article also lists RPC server applications and which RPC server applications can be configured to use custom server ports beyond the capabilities of the RPC runtime.

[!INCLUDE [Registry warning](../../includes/registry-important-alert.md)]

The **Internet** key doesn't exist by default. You have to create it. Under the **Internet** key, you can configure the following entries:

- **Ports REG_MULTI_SZ**. Specifies a port or inclusive range of ports. The other entries under **Internet** control whether these are the ports to use or the ports to exclude from use.
  - Value range: **0** - **65535**  
    For example, **5984** represents a single port, and **5000-5100** represents a set of ports. If any values are outside the range of **0** to **65535**, or if any value can't be interpreted, the RPC runtime treats the entire configuration as invalid.

- **PortsInternetAvailable REG_SZ**. Specifies whether the **Ports** value represents ports to include or ports to exclude.
  - Values: **Y** or **N** (not case-sensitive)  
    - **Y**. The ports listed in the **Ports** entry represent all the ports on that computer that are available to EPM.
    - **N**. The ports listed in the **Ports** entry represent all ports that aren't available to EPM.

- **UseInternetPorts REG_SZ**. Specifies the default system policy.  
  - Values: **Y** or **N** (not case-sensitive)  
    - **Y**. The processes that use the default system policy are assigned ports from the set of internet-available ports, as defined previously.
    - **N**. The processes that use the default system policy are assigned ports from the set of intranet-only ports.

You should open up a range of ports above port 5000. Port numbers below 5000 may already be in use by other applications and could cause conflicts with your DCOM application(s). Furthermore, previous experience shows that a minimum of 100 ports should be opened, because several system services rely on these RPC ports to communicate with each other.

> [!NOTE]  
> The minimum number of ports required may differ from computer to computer. Computers that support more traffic may run into a port exhaustion situation if the RPC dynamic ports are restricted. Take this into consideration when restricting the port range.

> [!WARNING]  
> If there is an error in the port configuration or there aren't enough ports in the pool, EPM can't register RPC server applications (including Windows services such as Netlogon) that use dynamic endpoints. When there is a configuration error, the error code is **87 (0x57) ERROR_INVALID_PARAMETER**. For example, if there aren't enough ports, Netlogon logs event 5820:
>
> Log Name: System  
> Source: NETLOGON  
> Event ID: 5820  
> Level: Error  
> Keywords: Classic  
> Description:  
> The Netlogon service could not add the AuthZ RPC interface. The service was terminated. The following error occurred: 'The parameter is incorrect.'  

If you would like to do a deep dive into how RPC works, see [RPC over IT/Pro](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/rpc-over-it-pro/ba-p/399898).

### Example of a custom port configuration

In this example, ports 5000 through 6000 (inclusive) have been arbitrarily selected to help illustrate how the new registry entries can be configured. This example isn't a recommendation of a minimum number of ports that any particular system needs.

Such a configuration requires adding the **Internet** key under **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Rpc**, and adding the following entries:

- **Ports MULTI_SZ**  
  - Data type: **MULTI_SZ**
  - Value: **5000-6000**
- **PortsInternetAvailable REG_SZ**
  - Data type: **REG_SZ**
  - Value: **Y**
- **UseInternetPorts REG_SZ**
  - Data type: **REG_SZ**
  - Value: **Y**

The computer has to restart for this configuration to take effect. After that, all applications that use RPC are assigned dynamic ports in the range 5000 through 6000 (inclusive).

## Troubleshooting RPC errors

### PortQry

[PortQry](https://www.microsoft.com/download/details.aspx?id=17148) provides quick insight into how RPC is functioning before you delve into network trace data. You can quickly determine if you're able to make a connection by running the following command on the client computer:

```console
Portqry.exe -n <ServerIP> -e 135
```

> [!NOTE]  
> In this command, \<_ServerIP_> represents the IP address of the server that you're contacting.


For example, consider the following command:

```console
Portqry.exe -n 169.254.0.2 -e 135
```

This command produces output that resembles the following excerpt:  

```output
Querying target system called:
169.254.0.2
Attempting to resolve IP address to a name...
IP address resolved to RPCServer.contoso.com
querying...
TCP port 135 (epmap service): LISTENING
Using ephemeral source port
Querying Endpoint Mapper Database...
Server's response:
UUID: d95afe70-a6d5-4259-822e-2c84da1ddb0d
ncacn_ip_tcp:169.254.0.2[49664]
```

You can determine the following information from this output:

- DNS is working correctly (it resolved the IP address to a fully qualified domain name (FQDN)).
- PortQry contacted the RPC port (135) on the target computer.
- EPM responded to PortQry and assigned the dynamic port 49664 (enclosed in square brackets) for subsequent communication.
- PortQry reconnected to port 49664.

If any of these steps fail, you can typically start collecting simultaneous network traces as described in the next section.

For more information about PortQry, see [Using the PortQry command-line tool](/windows-server/networking/portqry-command-line-port-scanner-v2).

### Netsh

You can use the Windows [netsh](/windows-server/administration/windows-commands/netsh) tool to collect network trace data simultaneously on the client and the server.  

To collect simultaneous network traces, open elevated Command Prompt windows on both the client and the server.

On the client, run the following command:

  ```console
  Netsh trace start scenario=netconnection capture=yes tracefile=c:\client_nettrace.etl maxsize=512 overwrite=yes report=yes
  ```

- On the server, run the following command:

  ```console
  Netsh trace start scenario=netconnection capture=yes tracefile=c:\server_nettrace.etl maxsize=512 overwrite=yes report=yes
  ```

Now try to reproduce your issue from the client computer. Afterwards, run the following command at both command prompts to stop the traces:

```console
Netsh trace stop
```

Open the trace files in [Microsoft Network Monitor 3.4](collect-data-using-network-monitor.md) or Message Analyzer, and filter the trace data for the IP address of the server or client computers and TCP port 135. For example, use filter strings such as the following:

- **Ipv4.address==\<_client-ip_> and ipv4.address==\<_server-ip_> and tcp.port==135**  
  
  In this filter string, \<_client-ip_> represents the IP address of the client, and \<_server-ip_> represents the IP address of the server.

- **tcp.port==135**

In the filtered data, look for the **EPM** in the **Protocol** column.

Look for a response from EPM (on the server) that includes a dynamic port number. If the dynamic port number is present, note it for future reference.

:::image type="content" source="media/rpc-errors-troubleshooting/dynamic-port-number.png" alt-text="Screenshot of Network Monitor with dynamic port highlighted." border="false":::

Refilter the trace data for the dynamic port number and the server IP address. For example, use a filter string such as **tcp.port==\<_dynamic-port-allocated_> and ipv4.address==\<_server-ip_>**. In this filter string, \<_dynamic-port-allocated_> represents the dynamic port number and \<_server-ip_> represents the IP address of the server.

:::image type="content" source="media/rpc-errors-troubleshooting/filtered-trace.png" alt-text="Screenshot of Network Monitor with filter applied." border="false":::

In the filtered data, look for evidence that the client connected successfully to the dynamic port, or if any network issues occurred.

### Port not reachable

The most common cause of "RPC server unavailable" errors is that the client can't connect to the dynamic port that was allocated. The client side trace would then show TCP SYN retransmits for the dynamic port.

:::image type="content" source="media/rpc-errors-troubleshooting/tcp-syn-retransmit.png" alt-text="Screenshot of Network Monitor with TCP SYN retransmits." border="false":::

This behavior indicates that one of the following is blocking communication:

- The dynamic port range is blocked on the firewall in the environment.
- A middle device is dropping the packets.
- The destination server is dropping the packets. This issue could be caused by the configurations such as [Windows Filtering Platform (WFP) packet drop](/windows/security/threat-protection/auditing/audit-filtering-platform-packet-drop), Network Interface Card (NIC) packet drop, or [filter driver](/windows-hardware/drivers/network/sending-data-from-a-filter-driver) modifications.

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSSv2 must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSSv2, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) on all nodes and unzip it in the *C:\\tss_tool* folder.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
3. Start the following traces on the problem computer by using the following cmdlet:

    ```PowerShell
    TSSv2.ps1 -Start -Scenario NET_RPC
    ```

4. Respond to the EULA prompt.
5. Repro the issue using event viewer or wbemtest tool
6. Stop the data collection immediately after the issue is reproduced.
7. Wait until the automated scripts finish collecting the required data.
