---
title: Using the PortQry command-line tool
description: Discusses the features and functionality available in PortQry Command Line Port Scanner version 2.0.
ms.date: 08/01/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Using the PortQry command-line tool

PortQry is a command-line tool that you can use to help troubleshoot TCP/IP connectivity issues. This tool reports the status of target TCP and User Datagram Protocol (UDP) ports on a local computer or on a remote computer. It also provides detailed information about the local computer's port usage.

Because PortQry is intended to be used as a troubleshooting tool, users who use it to troubleshoot a particular problem should have sufficient knowledge of their computing environment.

You can use PortQry from a command prompt in one of several modes:

- [Command-line mode](#commandline). You can use this mode to troubleshoot local or remote computers.
- [Local mode](#localmode). In this mode, you can use several parameters that are intended for troubleshooting the local computer.
- [Interactive mode](#interactive). Similar to command-line mode, but you can use shortcut commands and parameters.

> [!NOTE]  
> You can download a separate tool, called PortQryUI, that includes a graphical UI for PortQry. PortQryUI has several features that can make using PortQry easier. To get the PortQryUI tool, see [PortQryUI - User Interface for the PortQry Command Line Port Scanner](https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/portqryui.exe).

_Applies to:_ &nbsp; Supported versions of Windows

## PortQry tests and results

Typical port scanning tools report that the port has a **LISTENING** status if the target UDP port doesn't return an Internet Control Message Protocol (ICMP) "Destination unreachable" message. This result may not be accurate for one or both of the following reasons:

- If there's no response to a directed datagram, the target port might be **FILTERED**.
- Most services don't respond to an unformatted user datagram that's sent to them. Typically, the service or program that listens to a port responds only to a message that uses a specific session layer or application layer protocol.

To produce more accurate and useful results, PortQry uses a two-step testing process.

### Step 1: Port status test

PortQry reports the status of a port as one of three values:

- **LISTENING**: This response indicates that a process is listening on the target port. PortQry received a response from the target port.
- **NOT LISTENING**: This response indicates that no process is listening on the target port. PortQry received one of the following ICMP messages from the target port:  
   > Destination unreachable
   > Port unreachable
- **FILTERED**: This response indicates that the target port is being filtered. PortQry didn't receive a response from the target port. A process may or may not be listening on the target port. By default, PortQry queries a TCP port three times before it returns a response of **FILTERED**, and queries a UDP port one time before it returns a response of **FILTERED**.

### Step 2: Specialized tests

If there's no response from a target UDP port, PortQry reports that the port is **LISTENING or FILTERED**. However, when you troubleshoot a connectivity problem, it's useful to know whether a port is being filtered or is listening. This is especially true in an environment that contains one or more firewalls.

PortQry refines its port status report by using a second set of tests that can interact with the service or program that's listening on the target port. For this test, PortQry does the following:

- PortQry uses the Services file that's located in the *%SYSTEMROOT%\System32\Drivers\Etc* folder to determine which service listens on each port.
- PortQry creates a message that is specifically constructed for the expected service or program, and then sends that message to the target port. Depending on the service or program, the message may request information that's useful for troubleshooting, such as the following:
  - Domain and domain controller information (LDAP queries)
  - Registered client services and ports (RPC queries)
  - Whether anonymous access is allowed (FTP queries)
  - MAC address (NetBIOS queries)
  - Mspclnt.ini file information (ISA Server queries)
- PortQry parses, formats, and then returns the response from the service or program as part of its test report.

### Additional tests to troubleshoot the local computer

When you have to troubleshoot ports on the computer where you installed PortQry, use PortQry in local mode. When you use the local-mode parameters at the command line, you can do tasks such as the following on the local computer:

- Enumerate port mappings
- Monitor a specific port for changes
- Monitor a specific process for changes

For more information, see [Using PortQry in local (command-line) mode](#localmode).

## <a id="commandline"></a>Using PortQry in command-line mode

You can run PortQry at a command prompt in the same manner as any other command-line tool. Most of the examples in this article show command-line PortQry commands. In command-line mode, you can add multiple options to the command string to specify what query to run and how to run it. To run PortQry in command-line mode, run a command that uses the following syntax:

```console
portqry.exe -n <name_to_query> [options]
```

> [!NOTE]  
> In this command, \<*name_to_query*> is the IP address, computer name, or domain to query. This parameter is required. \[*options*] are the optional parameters.

### PortQry parameters for command-line mode

The following parameters are available in regular command-line mode:

|Parameter |Description |Comments |
| - | - | - |
|`-n <name>` |Query the specific destination |<ul><li>This is the only required parameter for command-line mode.</li><li>The \<*name*> value represents the name or IP address of the computer to query. This value cannot include spaces.</li></ul> |
|`-p <protocol>` |Use the specified protocol |<ul><li>The \<*protocol*> value represents the type of port to query (possible values are `tcp`, `udp`, or `both`).</li><li>The default value is `tcp`.</li></ul> |
|`-e <port_number>` |Specify the target port (also known as "endpoint")|<ul><li>The \<*port_number*> value represents the port to query on the destination computer.</li><li>The default value is `80`.</li></ul> |
|`-o <port_number>,<port_number>` |Specify multiple target ports in a sequence |The \<*port_number*>,\<*port_number*> values represent comma-delimited list of port numbers to query in a sequence. Do not use spaces around the commas. |
|`-r <port_number>:<port_number>` |Specify a range of target ports |<ul><li>The \<*port_number*>:\<*port_number*> values represent the starting and ending port numbers, separated by a colon. Do not use spaces around the colon.</li><li>The starting port number must be smaller than the ending port number.</li></ul> |
|`-l <filename.txt>` |Generate a log file |<ul><li>The \<*filename.txt*> value represents the name and extension of the log file. This value cannot include spaces.</li><li>When the command runs, PortQry creates the log file in the directory where it's installed.</li><li>If the file already exists, PortQry asks you to confirm that you want to overwrite it (unless you also use the `-y` parameter).</li></ul> |
|`-y` |Overwrite previous log file |<ul><li>When you use `-y` together with `-l`, PortQry overwrites the existing log file without prompting you to confirm the action.</li><li>If the PortQry command string does not include `-l`, PortQry ignores `-y`.</li></ul> |
|`-sl` |Wait extra time for response (also known as slow link delay) |Use this parameter to double the time that PortQry waits for a response from a UDP port before PortQry determines that the port is NOT LISTENING or that it's FILTERED. When you query over slow or unreliable network links, the normal wait time may be too short to receive a response. |
|`-nr` |Skip reverse name lookup |<ul><li>By default, when you use `-n` to specify an IP address for the target computer, PortQry does a reverse name lookup to resolve the IP address to a name. This process may be time-consuming, especially if PortQry can't resolve the IP address. Use `-nr` to skip this step of the query.</li><li>If you use `-n` to specify a computer or domain name, PortQry ignores `-nr`. |
|`-sp <port_number>` |Query from a specific source port |<ul><li>The \<*port_number*> value represents the port that PortQry uses to send the query.</li><li>PortQry can't use a port that another process is already using. If the port that you specify is already in use, PortQry returns the following error message:<br/>Cannot use specified source port.<br/>Port is already in use.<br/>Specify a port that is not in use and run the command again.</li><li>In the following cases, PortQry uses the specified port for the first test of the query, but not the second test: <ul><li>RPC (TCP and UDP ports 135)</li><li>LDAP (UDP port 389)</li><li>NetBIOS Adapter status query (UDP port 137)</li></ul>In these cases, PortQry uses an ephemeral port for the second test. When this occurs, PortQry records "Using ephemeral source port" in its output.</li><li>If the computer where PortQry is installed also runs the IPSec policy agent, UDP port 500 may not be available to use as a source port. To temporarily turn off the IPSec policy agent so that you can use port 500, run `net stop PolicyAgent`. When you have finished testing, run `net start PolicyAgent`.</li></ul> |
|`-cn !<community_name>!` |Query an SNMP community |<ul><li>The \<*community_name*> value represents the name of the SNMP community to query. You must delimit this value by using exclamation points, as shown in the left column.</li><li>If the SNMP service is not listening on the target port, PortQry ignores `-cn`.</li><li>The default community name is `public`.</li></ul>  |
|`-q` |Run PortQry in quiet mode |<ul><li>When you use `-q`, PortQry suppresses all screen output except for error messages.</li><li>To see output other than error messages, use `-q` together with `-l`. PortQry records the normal output in the log file.</li><li>If a log file already exists and you use `-q` together with `-l`, PortQry overwrites the existing log file without prompting you.</li><li>You cannot use `-q` together with `-o`, `-r`, or `-p both`.</li><li>This parameter is especially helpful when you use a batch file to run a PortQry command string.</li></ul> |

### Remarks for parameters in command-line mode

- Any port number value must be a valid port number between 1 and 65535, inclusive.
- The `-e`, `-o`, and `-r` parameters are mutually exclusive. A single PortQry command can use only one of these parameters.
- A query to UDP port 389 (LDAP) might not work against domain controllers that are running Windows Server 2008. To check the availability of the service that's running on UDP port 389, you can use Nltest instead of PortQry. For more information, see [Nltest](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731935(v=ws.11)).
- When you query port 135 (RPC) by using `-e` or `-o`, PortQry returns all the endpoints that are currently registered with the RPC endpoint mapper.
  > [!IMPORTANT]  
  > When you use the `-r`, PortQry doesn't query the RPC endpoint mapper.
- When you query port 53 (DNS), PortQry sends a DNS query for `portqry.microsoft.com` by using both TCP and UDP. If the server returns a response, PortQry determines that the port is LISTENING.
  > [!NOTE]  
  > It's not important whether the DNS server returns a positive or negative response. Any response indicates that the port is listening.

## <a id="localmode"></a>Using PortQry in local (command-line) mode

Instead of querying a port on a remote target computer, you can use PortQry in local mode to get detailed information about the TCP ports and the UDP ports on the local computer where PortQry runs. Use the following syntax to run PortQry in local mode:

```console
portqry -local | -wpid <pid> | -wport <port_number> [-wt <seconds>] [-l <filename.txt>] [-v]
```

The placeholders in this syntax are explained in the following table of local mode parameters:

|Parameter |Description |Comments |
| - | - | - |
|`-local` |Retrieve local information |<ul><li>Enumerate all the TCP and UDP port mappings that are currently active on the local computer. This output is similar to the output that the `netstat.exe -an` command generates.</li><li>On computers that support PID-to-port mappings, the output includes the PID of the process that's using the port on the local computer. If you use the verbose option (`-v`), the output also includes the names of the services that the PID belongs to and lists all the modules that the process has loaded. You can use this information to determine which ports are associated with a particular program or service that's running on the computer.</li></ul> |
|`-wport <port_number>` |Watch port |<ul><li>Monitor a specific port for changes. The \<*port_number*> value represents the port to monitor.</li><li>In the case of a TCP port, PortQry reports changes between the following states:<ul><li>**CLOSE_WAIT**</li><li>**CLOSED**</li><li>**ESTABLISHED**</li><li>**FIN_WAIT_1**</li><li>**LAST_ACK**</li><li>**LISTEN**</li><li>**SYN_RECEIVED**</li><li>**SYN_SEND**</li><li>**TIMED_WAIT**</li></ul></li></li><li>For UDP ports, PortQry reports if a program is bound to the port, but it doesn't report whether the UDP port receives datagrams.</li><li>To stop monitoring, press Esc.</li></ul> |
|`-wpid <pid>` |Watch process ID (PID) |<ul><li>Monitor a specific PID for changes in the number and state of connections. The \<*process_number*> value represents the PID to monitor.</li><li>To stop monitoring, press Esc.</li></ul> |
|`-wt <seconds>` |Check at specific interval |<ul><li>Check the status of the target that's identified by `-wport` or `"-wpid` at the interval that's represented by the /<*seconds*> value.</li><li>The \<*seconds*> value must be between one and 1,200 (inclusive).</li><li>The default value is `60`.</li><li>You cannot use `-wt` by itself or together with `-local`.</li></ul> |
|`-l <filename.txt>` |Generate a log file |<ul><li>The \<*filename.txt*> value represents the name and extension of the log file. This value cannot include spaces.</li><li>When the command runs, PortQry creates the log file in the directory where it's installed.</li><li>If the file already exists, PortQry asks you to confirm that you want to overwrite it (unless you also use the `-y` parameter).</li></ul> |
|`-y` |Overwrite previous log file |<ul><li>When you use `-y` together with `-l`, PortQry overwrites the existing log file without prompting you to confirm the action.</li><li>If the PortQry command string does not include `-l`, PortQry ignores `-y`.</li></ul> |
|`-v` |Produce verbose output |PortQry provides additional details to the screen output (and to the log file, if used). |

### Remarks for parameters in local mode

- The `-local`, `-wport`, and `-wpid` parameters are mutually exclusive. You can use only one of these parameters in a single PortQry command string.
- The `-q` parameter does not function in local mode.
- In some cases, PortQry may report that the System Idle process (PID 0) is using some TCP ports. This behavior may occur if a local program connects to a TCP port and then stops. Even though the program is no longer running, the program's TCP connection to the port may be left in a "Timed Wait" state for several minutes. In such a case, PortQry may detect that the port is in use, but it can't identify the program that's using the port because the PID has been released. By default, the port remains in a "Timed Wait" state for twice as long as the maximum segment lifetime.
- For each process, PortQry reports as much information as it can access. Access to some information is restricted. For example, access to module information for the Idle and CSRSS processes is prohibited because their access restrictions prevent user-level code from opening them. For best results, run the local mode command in the context of the local Administrator or of an account that has similar credentials.
- When you use either `-wport` or `-wpid` together with `-l`, use the Esc key to interrupt and exit PortQry instead of CTRL+C. You must press Esc to make sure that PortQry correctly closes the log file and exits. If you press CTRL+C instead of Esc to stop PortQry, the log file might become empty or corrupted.

## <a id="interactive"></a>Using PortQry in interactive mode

When you troubleshoot connectivity issues between computers, you might have to type many repetitive commands. Such actions might be done more easily by using PortQry in interactive mode.

Interactive mode is similar to the interactive functionality in the [Nslookup](/windows-server/administration/windows-commands/nslookup) DNS utility or in the Nblookup WINS utility.

To start PortQry in interactive mode, use the `-i` parameter. For example, run the following command:

```console
portqry -i
```

The output of this command resembles the following excerpt:
```output
Portqry Interactive Mode

Type 'help' for a list of commands

Default Node: 127.0.0.1

Current option values:  
   end port= 80  
   protocol= TCP  
   source port= 0 (ephemeral)
>
```

### Interactive mode commands

You can use the following commands in interactive mode:

|Command |Description |Comments |
| - | - | - |
|`node <name>` or `n <name>` |Set the destination to query |<ul><li>The \<*name*> value represents the name or IP address of the computer to query.This value cannot include spaces.</li><li>The default value is `127.0.0.1` (the local computer).</li></ul> |
|`query` or `q` |Send query |<ul><li>Queries the current destination, using the current settings.</li><li>The default protocol is `tcp`.</li><li>The default destination port is TCP port 80.</li><li>The default source port is port 0 (an ephemeral port).</li><li>You can use one of several shortcuts with the `query` command in order to run any of several common queries. For a list of the available shortcuts, see [Interactive mode query shortcuts](#interactive-mode-query-shortcuts).</li></ul> |
|`set <option>=<value>` |Set the value of a query option |<ul><li>In this command, \<*option*> represents the name of the option to set and \<*value*> represents the new value of the option.</li><li>To see a list of the current values of the available options, enter `set all`.</li><li>For a list of the available options, see [Interactive mode options](#interactive-mode-options).</li></ul> |
|`exit` |Leave interactive mode | |

### Interactive mode query shortcuts

You can use the following shortcuts together with the `query` command to run common queries without having to set port and protocol options. Use the following syntax:

```console
q <shortcut>
```

> [!NOTE]  
> In this command, \<*shortcut*> represents one of the shortcuts from the following table. If you omit the shortcut, the `q` command queries TCP port 80.

|Shortcut |Ports to query |
| - | - |
|`dns` |TCP port 53, UDP port 53. |
|`ftp` |TCP port 21 |
|`imap`  |TCP port 143 |
|`ipsec` |UDP port 500 |
|`isa` |TCP port 1745, UDP port 1745 |
|`ldap` |TCP port 389, UDP port 389 |
|`l2tp` |UDP port 1701 |
|`mail` |TCP ports 25, 110, and 143 |
|`pop3` |TCP port 110 |
|`rpc` |TCP port 135, UDP port 135 |
|`smtp` |TCP port 25 |
|`snmp` |UDP port 161 |
|`sql` |TCP port 1433, UDP port 1434 |
|`tftp` |UDP port 69 |

For example, entering `q dns` in interactive mode is equivalent to running `portqry -n 127.0.0.1 -p both -e 135` in regular command-line mode.

### Interactive mode options

You can use the `set` command to set options such as the source port or slow link delay. Use the following syntax:

```console
set <option>=<value>
```

> [!NOTE]  
> In this command, \<*option*> represents the name of the option to set, and \<*value*> represents the new value of the option.

|Option |Description |Comments |
| - | - | - |
|`set all` |Display the current values of options | |
|`set port=<port_number>`<br />`set e=<port_number>` |Specify the target port |The \<*port_number*> value represents the port to query on the destination computer. |
|`set sport=<port_number>`<br />`set sp=<port_number>` |Specify the source port |<ul><li>The \<*port_number*> value represents the port that PortQry uses to send the query.</li><li>PortQry can't use a port that another process is already using.</li><li>If you specify a port number of zero, PortQry uses an ephemeral port.</li></ul> |
|`set protocol=<protocol>`<br />`set p=<protocol>` |Specify the protocol to use |The \<*protocol*> value represents the type of port to query (`tcp`, `udp`, or `both`). |
|`set cn=<community_name>` |Specify an SNMP community |<ul><li>The \<*community_name*> value represents the name of the SNMP community to query.</li><li>If the SNMP service is not listening on the target port, PortQry ignores `-cn`.</li><li>The default community name is `public`.</li></ul> |
|`set nr` |Turn reverse name lookup off or on |<ul><li>By default, if you have set an IP address as the query destination, PortQry resolves the IP address to a name. If you change this option, PortQry skips the name resolution step.</li><li>To turn reverse name lookup on again, run `set nr` a second time.</li></ul> |
|`set sl` |Turn slow link delay on or off |<ul><li>If you change this option, PortQry doubles the length of time that it waits for a response from a UDP port before PortQry determines that the port is NOT LISTENING or that it's FILTERED. When you query over slow or unreliable network links, the normal wait time may be too short to receive a response.</li><li>To turn slow link delay off again, run `set sl` a second time.</li></ul> |

Suppose you want to query a computer that has the IP address 10.0.1.10. At the interactive mode command prompt, enter `n 10.0.1.10`. This command produces output that resembles the following excerpt:

```output
Default Node: 10.0.1.10

>
```

To send a DNS query, enter `q dns` at the interactive mode command prompt. This command produces output that resembles the following excerpt:

```output
resolving service name using local services file...
UDP port resolved to the 'domain' service

IP address resolved to myserver.contoso.com

querying...

UDP port 53 (domain service): LISTENING

>
```

## Customizing the association between ports and services

By default, every Windows-based computer has a Services file that's located in the *%SYSTEMROOT%\System32\Drivers\Etc* folder. PortQry uses this file to resolve port numbers to their corresponding service names. PortQry uses this information to select the format for its queries. You can edit this file to direct PortQry to send formatted messages to an alternative port. For example, the following entry appears in a typical Services file:

```output
ldap              389/tcp                           #Lightweight Directory Access Protocol
```

You can edit this port entry or add an additional entry. To force PortQry to send LDAP queries to port 1025, modify the entry as follows:

```output
ldap              1025/tcp                           #Lightweight Directory Access Protocol
```

## Examples

The following examples demonstrate how to use PortQry and its parameters:

**Local mode**

- [Query the local computer](#exlocal)
- [Query the local computer when access may be restricted](#exlocalrestrict)
- [Monitor a process ID by using a specific interval](#exwatchpid)
- [Query over a slow link](#ex-sl)

**Command-line mode**

- [Specify a target and protocol](#ex-n-p)
- [Specify one or more target ports](#ex-e-o-r)
- [Specify a log file for PortQry output](#ex-l-y)
- [Use a batch file to run PortQry in quiet mode](#exbat-q)
- [Query port 135 (RPC service)](#exrcp)

### <a id="exlocal"></a>Query the local computer

The output of `portqry -local` resembles the following excerpt:

```output
TCP/UDP Port Usage

96 active ports found

Port Local IPState Remote IP:Port  
TCP 80 0.0.0.0 LISTENING 0.0.0.0:18510  
TCP 80 169.254.149.9 TIME WAIT 169.254.74.55:3716  
TCP 80 169.254.149.9 TIME WAIT 169.254.200.222:3885  
TCP 135 0.0.0.0 LISTENING 0.0.0.0:10280  
UDP 135 0.0.0.0 :  
UDP 137 169.254.149.9 :  
UDP 138 169.254.149.9 :  
TCP 139 169.254.149.9 LISTENING 0.0.0.0:43065  
TCP 139 169.254.149.9 ESTABLISHED 169.254.4.253:4310  
TCP 139 169.254.149.9 ESTABLISHED 169.254.74.55:3714  
```

### <a id="exlocalrestrict"></a>Query the local computer when access might be restricted

When you run PortQry in local mode, as in the previous example, you might see output that resembles the following excerpt. Such output indicates that the security context that PortQry is using doesn't have sufficient permissions to access all of the information that it requested.

```output
Port and Module Information by Process

Note: restrictions applied to some processes may
prevent Portqry from accessing more information

For best results run Portqry in the context of
the local administrator

======================================================  
Process ID: 0 (System Idle Process)

PIDPortLocal IPState Remote IP:Port  
0TCP 4442 169.254.113.96 TIME WAIT 169.254.5.136:80  
0TCP 4456 169.254.113.96 TIME WAIT 169.254.5.44:445  

Port Statistics

TCP mappings: 2  
UDP mappings: 0

TCP ports in a TIME WAIT state: 2 = 100.00%

Could not access module information for this process

======================================================
```

### <a id="exwatchpid"></a>Monitor a process ID by using a specific interval

The following command monitors a specific process:  

```console
portqry.exe -wpid 1276 -wt 2 -v -l pid.txt
```

As a result, PortQry takes the following actions:

- Identifies the process that has the 1276 PID, and checks the status of the ports that it's using every two seconds until you press Esc.
- Creates the log file *pid.txt*. If a file that has that name already exists, PortQry prompts you to confirm that you want to overwrite the file.
- Records any output in the log file, including the extra verbose output.

The content of the log file resembles the following excerpt:

```output
PortQry Version 2.0 Log File
  
System Date: <DateTime>
  
Command run:  
portqry -wpid 1276 -wt 2 -v -l pid.txt
  
Local computer name:
  
host123
  
Watching PID: 1276
  
Checking for changes every 2 seconds
  
verbose output requested
  
Service Name: DNS  
Display Name: DNS Server  
Service Type: runs in its own process

============
System Date: <DateTime>

======================================================

Process ID: 1276 (dns.exe)

Service Name: DNS
Display Name: DNS Server
Service Type: runs in its own process

PIDPortLocal IPState Remote IP:Port
1276TCP 53 0.0.0.0 LISTENING 0.0.0.0:2160
1276TCP 1087 0.0.0.0 LISTENING 0.0.0.0:37074
1276UDP 1086 0.0.0.0 :
1276UDP 2126 0.0.0.0 :
1276UDP 53 127.0.0.1 :
1276UDP 1085 127.0.0.1 :
1276UDP 53 169.254.11.96 :

Port Statistics

TCP mappings: 2
UDP mappings: 5

TCP ports in a LISTENING state: 2 = 100.00%

Loaded modules:
C:\WINDOWS\System32\dns.exe (0x01000000)
C:\WINDOWS\system32\ntdll.dll (0x77F40000)
C:\WINDOWS\system32\kernel32.dll (0x77E40000)
C:\WINDOWS\system32\msvcrt.dll (0x77BA0000)
C:\WINDOWS\system32\ADVAPI32.dll (0x77DA0000)
C:\WINDOWS\system32\RPCRT4.dll (0x77C50000)
C:\WINDOWS\System32\WS2_32.dll (0x71C00000)
C:\WINDOWS\System32\WS2HELP.dll (0x71BF0000)
C:\WINDOWS\system32\USER32.dll (0x77D00000)
C:\WINDOWS\system32\GDI32.dll (0x77C00000)
C:\WINDOWS\System32\NETAPI32.dll (0x71C40000)
```

### <a id="ex-n-p"></a>Specify a target and protocol

> [!NOTE]  
> Each of the examples in this section queries port 80, the default port.

The following command queries the default TCP port on a computer that's specified by using its fully qualified domain name (FQDN):

```console
portqry -n myDomainController.example.com -p tcp
```

The following command queries the default UDP port on a computer that's specified by using its computer name:

```console
portqry -n myServer -p udp
```

The following command queries the default TCP and UDP ports of a computer that's specified by using its IP address:

```console
portqry -n 192.168.1.20 -p both
```

The following command runs the same query as the previous command but skips the name resolution step:

```console
portqry -n 192.168.1.20 -p both -nr
```

The following command queries the default TCP port of a web server:

```console
portqry -n www.widgets.microsoft.com
```

### <a id="ex-e-o-r"></a>Specify one or more target ports

The following command tests the SMTP service of a mail server by querying TCP port 25:

```console
portqry -n mail.example.com -p tcp -e 25
```

The following command queries TCP port 60897 and UDP port 60897 of a computer that has the IP address 192.168.1.20:

```console
portqry -n 192.168.1.20 -p both -e 60897
```

The following command queries UDP ports 139, 1025, and 135 (in that sequence) on the computer "myServer":

```console
portqry -n myServer -p udp -o 139,1025,135
```

The following command queries the range of ports from port 135 to port 139 (inclusive) on the computer "myServer":

```console
portqry -n myServer -p udp -r 135:139
```

### <a id="ex-l-y"></a> Specify a log file for PortQry output

The following command queries TCP port 143 on mail.widgets.microsoft.com, and records the output in the *portqry.txt* file. If the file already exists, PortQry overwrites it without prompting for confirmation.

```console
portqry -n mail.widgets.microsoft.com -p tcp -e 143 -l portqry.txt -y
```

### <a id="ex-sl"></a> Query over a slow link

The following command queries TCP ports 143, 110, and 25 on mail.widgets.microsoft.com. For each target port, PortQry waits twice as long as usual for a response.

```console
  portqry -n mail.widgets.microsoft.com -p tcp -o 143,110,25 -sl
```

### <a id="ex-sp"></a>Specify a source port

The following command uses UDP port 3001 (if it's available) on the local computer to send a query to UDP port 53 on 192.168.1.20. If a service is listening on that port and responds to the query, it sends the response to UDP port 3001 on the local computer.

```console
portqry -p udp -e 53 -sp 3001 -n 192.168.1.20
```

The following command uses UDP port 3000 (if it's available) on the local computer to send a query to UDP port 389 on myDomainController.contoso.com. By default, the LDAP service should be listening on this port. If the LDAP service responds to the first query, PortQry uses an ephemeral source port to send the formatted query and receive any responses.

```console
portqry -n myDomainController.contoso.com -e 389 -sp 3000
```

### <a id="exbat-q"></a>Use a batch file to run PortQry in quiet mode

The following text is an example of a batch file that runs PortQry in quiet mode:

```console
:Top
portqry -n 169.254.18.22 -e 443 -nr -l pqlog.txt -q
:end
```

When this batch file runs, PortQry produces a log file that is named *pqlog.txt*. The content of this file resembles the following:

```output
PortQry Version 2.0 Log File

System Date: Thu Sep 16 10:35:03 2021

Command run:
 portqry -n 169.254.18.22 -e 443 -nr -l pqlog.txt -q

Local computer name:

 SOURCESERVER

Querying target system called:

 169.254.18.22

TCP port 443 (https service): LISTENING


========= end of log file ========= 
```

### <a id="exrcp"></a>Query port 135 (RPC service)

The following command queries UDP port 135 on the myServer computer. By default, the RPC service should be listening on this port.

```console
portqry -n myServer -p udp -e 135
```

As a result, PortQry takes the following actions:

- PortQry uses the Services file in the *%SYSTEMROOT%\System32\Drivers\Etc* folder to resolve UDP port 135 to a service. Using the default configuration, PortQry resolves the port to the RPC endpoint mapper service (Epmap).
- PortQry sends an unformatted user datagram to UDP port 135 on the destination computer.  
  PortQry doesn't receive a response from the target port. This is because the RPC endpoint mapper service responds only to a correctly formatted RPC query. PortQry reports that the port is **LISTENING or FILTERED**.
- PortQry creates a correctly formatted RPC query that requests all the endpoints that are currently registered with the RPC endpoint mapper. PortQry sends this query to to UDP port 135 on the destination computer.  
- Depending on the response, PortQry takes one of the following actions:
  - If PortQry receives a response to this query, PortQry returns the whole response to the user and reports that the port is **LISTENING**.
  - If PortQry doesn't receive a response to this query, it reports that the port is **FILTERED**.

```output
UDP port 135 (epmap service): LISTENING or FILTERED  
Querying Endpoint Mapper Database...  
Server's response:  

UUID: 50abc2a4-574d-40b3-9d66-ee4fd5fba076
ncacn_ip_tcp:169.254.12.191[4144]

UUID: ecec0d70-a603-11d0-96b1-00a0c91ece30 NTDS Backup Interface
ncacn_np:\\MYSERVER[\PIPE\lsass]

UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_ip_tcp:169.254.12.191[1030]

UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncadg_ip_udp:169.254.12.191[1032]

UUID: 12345678-1234-abcd-ef00-01234567cffb
ncacn_np:\\MYSERVER[\PIPE\lsass]

UUID: 12345678-1234-abcd-ef00-01234567cffb
ncacn_np:\\MYSERVER[\PIPE\POLICYAGENT]

Total endpoints found: 6

==== End of RPC Endpoint Mapper query response ====

UDP port 135 is LISTENING
```

From this output, you can determine not only whether the service is listening on the port, but also which services or programs are registered with the RPC endpoint mapper database on the destination computer. The output includes the universal unique identifier (UUID) for each program, the annotated name (if one exists), the protocol that each program uses, the network address that the program is bound to, and the program's endpoint in square brackets.

> [!NOTE]  
> When you specify the `-r` option in the PortQry command to scan a range of ports, PortQry doesn't query the RPC endpoint mapper for endpoint information. This parameter accelerates scanning a range of ports.
