---
title: RPC error troubleshooting
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
# Troubleshoot Remote Procedure Call (RPC) errors

_Applies to:_ &nbsp; Windows 11, Windows 10, Windows 8.1, Windows 7, Windows Vista, Windows XP

You might encounter an "RPC server unavailable" error when you connect to Windows Management Instrumentation (WMI), SQL Server, during a remote connection, or for some Microsoft Management Console (MMC) snap-ins. The following image is an example of a Remote Procedure Call (RPC) error.

:::image type="content" source="media/rpc-errors-troubleshooting/rpc-error.png" alt-text="Screenshot of an error message window showing the following error has occurred: the RPC server is unavailable." border="false":::

This message is a commonly encountered error message in the networking world and if one doesn't understand what is happening 'under the hood," one can lose hope fast.

Before getting in to troubleshooting the "RPC server unavailable" error, let's first understand basics about the error. There are a few important terms to understand:

- **Endpoint mapper (EPM)**. A service that listens on the server, which guides client apps to server apps by using port and UUID information.
- **Tower**. Describes the RPC protocol to allow the client and server to negotiate a connection.
- **Floors**. The layers of contents within a tower that contain specific data like ports, IP addresses, and identifiers.
- **UUID** A well-known GUID that identifies an RPC application. During troubleshooting you can use the UUID to track the RPC conversations of a single type of application (among the many types that occur on a single computer at one time).
- **Opnum** Identifies a function that the client wants the server to perform. It's just a hexadecimal number, but a good network analyzer will translate the function for you. If neither knows, contact your application vendor.
- **Port**. The communication endpoint for client or server application. The EPM allocates dynamic ports (also known as high ports or ephemeral ports) for clients and servers to use.
  > [!NOTE]  
  > Typically the port number is the most important information that you'll use for troubleshooting.
- **Stub data**. The data exchanged between the functions on the client and the functions on the server. This data is the payload, the important part of the communication.

## How the connection works

The following diagram shows a client connecting to a server to perform a remote operation. The client initially contacts TCP port 135 on the server, then negotiates with EPM for a dynamic port number. After EPM assigns a port, the client disconnects and then uses the dynamic port to connect to the server.  

:::image type="content" source="media/rpc-errors-troubleshooting/rpc-flow.png" alt-text="Diagram that shows how a client makes an RPC connection to a remote server." border="true":::

> [!IMPORTANT]  
> When a firewall separates the client and the server, the firewall has to allow communication on port 135 and on the dynamic ports that EPM assigns. One approach to managing this issue is to specify ports or ranges of ports for EPM to use. For more information, see [Configure how RPC allocates dynamic ports](#configure-how-rpc-allocates-dynamic-ports).
>  
> Some firewalls also allow UUID filtering. In UUID filtering, when an RPC request uses port 135 to cross the firewall and contact EPM, the firewall notes the UUID that's associated with the request. When EPM responds and sends a dynamic port number for that UUID, the firewall notes the port number as well. Subsequently, the firewall allows RPC bind operations for that UUID and port.

### Configure how RPC allocates dynamic ports

By default, EPM allocates dynamic ports randomly from the range that's configured for TCP and UDP (based on the implementation of the operating system used). However, this approach might not be practical, especially when the client and server must communicate through a firewall. An alternative is to specify a port number or range of port numbers for EPM to use, and open those ports in the firewall.

Many Windows server applications that rely on RPC provide options (such as registry keys) to customize the allowed ports. Windows itself uses the **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Rpc\\Internet** subkey for this purpose.

When you specify a port or port range, use ports outside of the range of commonly-used ports. You can find a comprehensive list of server ports that are used in Windows and major Microsoft products in [Service overview and network port requirements for Windows](/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements). This article also lists RPC server applications and which RPC server applications can be configured to use custom server ports beyond the capabilities of the RPC runtime.

[!INCLUDE [Registry warning](../../../../includes/registry-important-alert.md)]

The **Internet** key does not exist by default. You have to create it. Under the **Internet** key, you can configure the following entries:

- **Ports REG_MULTI_SZ**. Specifies a port or inclusive range of ports. The other entries under **Internet** control whether these are the ports to use or the ports to exclude from use.
  - Value range: **0** - **65535**  
    For example, **5984** represents a single port, and **5000-5100** represents a set of ports. If any values are outside the range of **0** to **65535**, or if any value can't be interpreted, the RPC runtime treats the entire configuration as invalid.

- **PortsInternetAvailable REG_SZ**. Specifies whether the **Ports** value represent ports to include or ports to exclude.
  - Values: **Y** or **N** (not case-sensitive)  
    - **Y**. The ports listed in the **Ports** entry represent all the ports on that computer that're available to EPM.
    - **N**. The ports listed in the **Ports** entry represent all ports that aren't available to EPM.

- **UseInternetPorts REG_SZ**. Specifies the default system policy.  
  - Values: **Y** or **N** (not case-sensitive)  
    - **Y**. The processes that use the default system policy are assigned ports from the set of internet-available ports, as defined previously.
    - **N**. The processes that use the default system policy are assigned ports from the set of intranet-only ports.

Example:

In this example, ports 5000 through 6000 (inclusive) have been arbitrarily selected to help illustrate how the new registry keys can be configured. This example isn't a recommendation of a minimum number of ports needed for any particular system.

1. Add the **Internet** key under **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Rpc**.  
1. Under the **Internet** key, add the following values:  
   - **Ports** (MULTI_SZ)
   - **PortsInternetAvailable** (REG_SZ)
   - **UseInternetPorts** (REG_SZ)

    For example, the new registry key appears as follows:  
    **Ports**: REG_MULTI_SZ: 5000-6000  
    **PortsInternetAvailable**: REG_SZ: Y  
    **UseInternetPorts**: REG_SZ: Y  
1. Restart the server. All applications that use RPC dynamic port allocation use ports 5000 through 6000 (inclusive).

You should open up a range of ports above port 5000. Port numbers below 5000 may already be in use by other applications and could cause conflicts with your DCOM application(s). Furthermore, previous experience shows that a minimum of 100 ports should be opened, because several system services rely on these RPC ports to communicate with each other.

> [!NOTE]  
> The minimum number of ports required may differ from computer to computer. Computers that support more traffic may run into a port exhaustion situation if the RPC dynamic ports are restricted. Take this into consideration when restricting the port range.

> [!WARNING]  
> If there is an error in the port configuration or there aren't enough ports in the pool, EPM can't register RPC server applications that use dynamic endpoints. When there is a configuration error, the error code is **87 (0x57) ERROR_INVALID_PARAMETER**. This can affect Windows RPC servers as well, such as Netlogon. It will log event 5820 in this case:
>
> Log Name: System  
> Source: NETLOGON  
> Event ID: 5820  
> Level: Error  
> Keywords: Classic  
> Description:  
> The Netlogon service could not add the AuthZ RPC interface. The service was terminated. The following error occurred: 'The parameter is incorrect.'

If you would like to do a deep dive as to how it works, see [RPC over IT/Pro](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/rpc-over-it-pro/ba-p/399898).

## Troubleshooting RPC error

### PortQuery

The best thing to always troubleshoot RPC issues before even getting in to traces is by making use of tools like PortQry. You can quickly determine if you're able to make a connection by running the command:

```console
Portqry.exe -n <ServerIP> -e 135
```

This command would give you much of the output to look for, but you should be looking for `*ip_tcp-` and the port number in the brackets, which tells whether you were successfully able to get a dynamic port from EPM and also make a connection to it. If the above fails, you can typically start collecting simultaneous network traces. Something like this from the output of "PortQry":  

```console
Portqry.exe -n 169.254.0.2 -e 135
```

Partial output below:  

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

Note the number that is enclosed in square brackets. It's the ephemeral port number that you successfully connected to.

### Netsh

You can run the commands below to use Windows inbuilt `netsh` captures, to collect a simultaneous trace. Remember to execute the below on an "Admin CMD", it requires elevation.

- On the client

  ```console
  Netsh trace start scenario=netconnection capture=yes tracefile=c:\client_nettrace.etl maxsize=512 overwrite=yes report=yes
  ```

- On the server

  ```console
  Netsh trace start scenario=netconnection capture=yes tracefile=c:\server_nettrace.etl maxsize=512 overwrite=yes report=yes
  ```

Now try to reproduce your issue from the client machine and as soon as you feel the issue has been reproduced, go ahead and stop the traces using the command:

```console
Netsh trace stop
```

Open the traces in [Microsoft Network Monitor 3.4](collect-data-using-network-monitor.md) or Message Analyzer and filter the trace for `Ipv4.address==<client-ip>` and `ipv4.address==<server-ip>` and `tcp.port==135` or just `tcp.port==135` should help.

- Look for the "EPM" Protocol Under the **Protocol** column.

- Now check if you're getting a response from the server. If you get a response, note the dynamic port number that you've been allocated to use.

  :::image type="content" source="media/rpc-errors-troubleshooting/dynamic-port-number.png" alt-text="Screenshot of Network Monitor with dynamic port highlighted." border="false":::

- Check if we're connecting successfully to this Dynamic port successfully.

- The filter should be something like this: `tcp.port==<dynamic-port-allocated>` and `ipv4.address==<server-ip>`  

    :::image type="content" source="media/rpc-errors-troubleshooting/filtered-trace.png" alt-text="Screenshot of Network Monitor with filter applied." border="false":::

This filter should help you verify the connectivity and isolate if any network issues are seen.

### Port not reachable

The most common reason why we would see the RPC server unavailable is when the dynamic port that the client tries to connect isn't reachable. The client side trace would then show TCP SYN retransmits for the dynamic port.

:::image type="content" source="media/rpc-errors-troubleshooting/tcp-syn-retransmit.png" alt-text="Screenshot of Network Monitor with TCP SYN retransmits." border="false":::

The port can't be reachable due to one of the following reasons:

- The dynamic port range is blocked on the firewall in the environment.
- A middle device is dropping the packets.
- The destination server is dropping the packets (WFP drop / NIC drop/ Filter driver etc.).
