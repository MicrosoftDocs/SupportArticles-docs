---
title: Troubleshoot agent connectivity issues
description: Troubleshoot issues that Operations Manager agents have problem connecting to the management server in System Center 2012 Operations Manager and later versions.
ms.date: 04/15/2024
---
# Troubleshoot agent connectivity issues in Operations Manager

This guide helps you troubleshoot issues that Operations Manager agents have problem connecting to the management server in System Center 2012 Operations Manager (OpsMgr 2012) and later versions.

To learn more about Operations Manager agent and how they communicate with management servers, see [Agents](/previous-versions/system-center/system-center-2012-R2/hh230741(v=sc.12)#agents) and [Communication Between Agents and Management Servers](/previous-versions/system-center/system-center-2012-R2/hh230741(v=sc.12)#communication-between-agents-and-management-servers).

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 10066

## Check the Health Service

Whenever you experience connectivity problems in Operations Manager, first make sure that the Health Service is running without errors on both the client agent and the management server.
To determine whether the service is running, follow these steps:

1. Press the Windows key+R.
2. In the **Run** box, type `services.msc` and press Enter.
3. Find the **Microsoft Monitoring Agent** service, and then double-click it to open the **Properties** page.

    > [!NOTE]
    > In System Center 2012 Operations Manager, the service name is **System Center Management**.
4. Make sure that the **Startup** type is set to **Automatic**.
5. Check whether **Started** is displayed in **Service status**. Otherwise, click **Start**.

## Check antivirus exclusions

If the Health Service is up and running, the next thing is to confirm that antivirus exclusions are properly configured. For the latest information about recommended antivirus exclusions for Operations Manager, see [Recommendations for antivirus exclusions that relate to Operations Manager](antivirus-exclusions-recommendations.md)).

## Check network issues

In Operations Manager, the agent computer must be able to successfully connect to TCP port 5723 on the management server. If this is failing, you will likely receive event ID 21016 and 21006 on the client agent.

In addition to TCP port 5723, the following ports must be enabled:

- TCP and UDP port 389 for LDAP
- TCP and UDP port 88 for Kerberos authentication
- TCP and UDP port 53 for Domain Name Service (DNS)

Additionally, you must ensure that RPC communications complete successfully over the network. Problems with RPC communication usually manifest themselves when pushing an agent from the management server. RPC communication problems usually cause the client push to fail with an error similar to the following:

> The Operation Manager Server failed to perform specified operation on computer agent1.contoso.com.
>
> Operation: Agent Install  
> Install account: contoso\Agent_action  
> Error Code: 800706BA  
> Error Description: The RPC server is unavailable

This error typically occurs when either non-standard ephemeral ports are used or when the ephemeral ports are blocked by a firewall. For example, if non-standard high range RPC ports have been configured, a network trace will show a successful connection to RPC port 135 followed by a connection attempt using a non-standard RPC port such as 15595. The following is an example:

> 18748 MS Agent TCP TCP: Flags=CE....S., SrcPort=52457, DstPort=15595, PayloadLen=0, Seq=1704157139, Ack=0, Win=8192  
> 18750 MS Agent TCP TCP:[SynReTransmit #18748] Flags=CE....S., SrcPort=52457, DstPort=15595, PayloadLen=0, Seq=1704157139, Ack=0,  
> 18751 MS Agent TCP TCP:[SynReTransmit #18748] Flags=......S., SrcPort=52457, DstPort=15595, PayloadLen=0, Seq=1704157139, Ack=0, Win=8192

In this example, since the port exemption for this non-standard range wasn't configured on the firewall, the packets are dropped and the connection fails.

In Windows Vista and later versions, the RPC high range ports are 49152-65535 so that's what we want to look for. To verify whether this is your issue, run the following command to see what RPC high port range is configured:

```console
netsh int ipv4 show dynamicportrange tcp
```

According to IANA standards, the output should look like this:

> Protocol tcp Dynamic Port Range  
> \---------------------------------  
> Start Port : 49152  
> Number of Ports : 16384  

If you see a different **Start Port**, the problem may be that the firewall isn't configured correctly to allow traffic through these ports. You can change the configuration on the firewall or run the following command to set the high range ports back to their default values:

```console
netsh int ipv4 set dynamicport tcp start=49152 num=16384
```

You can also configure the RPC dynamic port range through the registry. For more information, see [How to configure RPC dynamic port allocation to work with firewalls](https://support.microsoft.com/help/154596).

If everything seems to be configured correctly and you still experience the error, it may be caused by one of the following conditions:

1. DCOM has been restricted to a certain port. To verify, run `dcomcnfg.exe`, go to **My Computer** > **Properties** > **Default Protocols**, ensure that there is no custom setting.

2. WMI is configured to use a custom endpoint. To check if you have a static endpoint configured for WMI, run `dcomcnfg.exe`, go to **My Computer** > **DCOM Config** > **Windows Management and Instrumentation** > **Properties** > **Endpoints**, ensure that there is no custom setting.

3. The agent computer is running the Exchange Server 2010 Client Access server role. The Exchange Server 2010 Client Access service changes the port range to 6005 through 65535. The range was expanded to provide sufficient scaling for large deployments. Don't change these port values without fully understanding the consequences.

For more information about port and firewall requirements, see [Firewalls](/previous-versions/system-center/system-center-2012-R2/dn249696(v=sc.12)#firewalls). You can also find the minimum required network connectivity speeds in the same article.

> [!NOTE]
> Troubleshooting network problems is an extremely large issue, so it's best to consult a networking engineer if you suspect that an underlying network problem is causing your agent connectivity issues in Operations Manager. We also have some basic, generalized network troubleshooting information available from our Windows Directory Services support team available at [Troubleshooting networks without NetMon](/archive/blogs/askds/troubleshooting-networks-without-netmon).

## Check certificate issues on the gateway server

Operations Manager requires that mutual authentication be performed between client agents and management servers prior to the exchange of information between them. To secure the authentication process, the process is encrypted. When the agent and the management server reside in the same Active Directory domain, or in Active Directory domains that have established trust relationships, they make use of the Kerberos v5 authentication mechanisms provided by Active Directory. When the agents and management servers do not lie within the same trust boundary, other mechanisms must be used to satisfy the secure mutual authentication requirement.

In Operations Manager, this is accomplished through the use of X.509 certificates issued for each computer. If there are many agent-monitored computers, this can result in high administrative overhead for managing all those certificates. In addition, if there is a firewall between the agents and management servers, multiple authorized endpoints must be defined and maintained in the firewall rules to allow communication between them.

To reduce the administrative overhead, Operations Manager has an optional server role called the Gateway Server. Gateway servers are located within the trust boundary of the client agents and can participate in the mandatory mutual authentication. Because gateways lie within the same trust boundary as the agents, the Kerberos v5 protocol for Active Directory is used between the agents and the gateway server, and each agent then communicates only with the gateway servers that it is aware of.

The gateway servers then communicate with the management servers on behalf of the clients. To support the mandatory secure mutual authentication between the gateway server and the management servers, certificates must be issued and installed but only for the gateway and management servers. This reduces the number of certificates required. In the case of an intervening firewall, it also reduces the number of authorized endpoints that need to be defined in the firewall rules.

The takeaway here is that if the client agents and management servers don't lie within the same trust boundary, or if a gateway server is used, the necessary certificates must be installed and configured correctly for agent connectivity to function properly. Here are some key things to check:

- Confirm that the gateway certificate exists in **Local Computer** > **Personal** > **Certificates** on the management server to which the gateway or agent is connecting.

- Confirm that the root certificate exists in **Local Computer** > **Trusted Root Certification Authorities** > **Certificates** on the management server to which the gateway or agent is connecting.

- Confirm that the root certificate exists in **Local Computer** > **Trusted Root Certification Authorities** > **Certificates** on the gateway server.

- Confirm that the gateway certificate exists in **Local Computer** > **Personal** > **Certificates** on the gateway server. Confirm that the gateway certificate exists in **Local Computer** > **Operations Manager** > **Certificates** on the gateway server.

- Confirm that registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings\ChannelCertificateSerialNumber` exists and has the value of the certificate (from the Local Computer/Personal/Certificates folder within the details in the **Serial number** field) reversed within it on the gateway server.

- Confirm that registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings\ChannelCertificateSerialNumber` exists and has the value of the certificate (from the Local Computer/Personal/Certificates folder within the details in the **Serial number** field) reversed within it on the management server to which the gateway or agent is connecting.

You might receive the following event IDs in the Operations Manager event log when there is an issue with certificates:

- 20050
- 20057
- 20066
- 20068
- 20069
- 20072
- 20077
- 21007
- 21021
- 21002
- 21036

For details on how certificate-based authentication functions in Operations Manager, as well as instructions on how to obtain and configure the proper certificates, see [Authentication and Data Encryption for Windows Computers](/previous-versions/system-center/system-center-2012-R2/hh212810(v=sc.12)).

## Check for a disjointed namespace on the client agent

A disjoint namespace occurs when the client computer has a primary DNS suffix that doesn't match the DNS name of the Active Directory domain that the client belongs to. For example, a client that uses a primary DNS suffix of *corp.contoso.com* in an Active Directory domain that's named *na.corp.contoso.com* is using a disjoint namespace.

When the client agent or the management server has a disjointed namespace, Kerberos authentication can fail. Though this is an Active Directory issue and not an Operations Manager issue, it does affect agent connectivity.

For more information, see [Disjoint Namespace](/previous-versions/windows/it-pro/windows-server-2003/cc731125(v=ws.10)).

To resolve the issue, use one of the following methods:

### Method 1

Manually create the appropriate Service Principal Names (SPNs) for the affected computer accounts and include the host SPN for the fully qualified domain name (FQDN) together with the disjointed name suffix (*HOST/machine.disjointed_name_suffix.local*). Also update the `DnsHostName` attribute for the computer to reflect the disjointed name (*machine.disjointed_name_suffix.local*) and enable registration for the attribute in a valid DNS zone on the DNS servers that Active Directory uses.

### Method 2

Correct the disjointed namespace. To do this, change the namespace in the affected computer's properties to reflect the FQDN of the domain to which the computer belongs. Make sure that you are fully aware of the consequences of doing this before making any changes in your environment. For more information, see [Transition from a Disjoint Namespace to a Contiguous Namespace](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731136(v=ws.10)).

## Check for a slow network connection

If the client agent is running across a slow network connection, it may encounter connectivity issues due to the fact that there is a hard-coded timeout for authentication. To resolve this issue, install System Center 2012 Operations Manager SP1 Update Rollup 8 (assuming you're not already on System Center 2012 R2 Operations Manager), and then manually change the timeout value.

The UR8 update increases the server timeout to 20 seconds and the client timeout to 5 minutes.

For more information, see [Update Rollup 8 for System Center 2012 Operations Manager Service Pack 1](https://support.microsoft.com/help/2991997/).

> [!NOTE]
> This issue can also occur when there are time synchronization issues between the client agent and the management server.

## Check for OpsMgr Connector problems

If everything else checks out, check the Operations Manager event log for any error events generated by the OpsMgr Connector. Common causes and resolutions for various OpsMgr Connector events are listed below.

### Event ID 21006 and 21016 appear on the client agent

Examples of these events:

> Source: OpsMgr Connector  
> Date: Time  
> Event ID: 21006  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description: The OpsMgr Connector could not connect to \<ManagementServer>:5723. The error code is 10060L (A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.). Please verify there is network connectivity, the server is running and has registered its listening port, and there are no firewalls blocking traffic to the destination.

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Date: Time  
> Event ID: 21016  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description: OpsMgr was unable to set up a communications channel to \<ManagementServer> and there are no failover hosts. Communication will resume when \<ManagementServer> is available and communication from this computer is allowed.

Usually these event IDs are generated because the agent hasn't received configuration. After a new agent is added and before it is configured, this event is common. Event 1210 in the agent's Operations Manager event log indicates that the agent received and applied configuration. You receive this event after communication is established.

You can use the following steps to troubleshoot this issue:

1. If auto-approval for manually installed agents isn't enabled, confirm that the agent is approved.
2. Ensure that the following ports are enabled for communication:
   - 5723 and TCP and UDP port 389 for LDAP.
   - TCP and UDP port 88 for Kerberos authentication.
   - TCP and UDP port 53 for DNS server.
3. This event can potentially indicate that Kerberos authentication is failing. Check for Kerberos errors in the Event Logs and troubleshoot.
4. Check if the DNS suffix has an incorrect domain. For example, the computer is joined to *contoso1.com* but the primary DNS suffix is set to *contoso2.com*.
5. Make sure the default domain name registry keys are correct. To verify, make sure that the following registry keys match your domain name:

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName`
   - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Domain`

6. A duplicate SPN for the Health Service can also cause event ID 21016. To find the duplicate SPN, run the following command:

    ```console
    setspn -F -Q MSOMHSvc/<fully qualified name of the management server in the event>
    ```

    If duplicate SPNs are registered, you must remove the SPN for the account that is not being used for the management server Health Service.

### Event ID 20057 appears on the management server

An example of this event:

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Date: time  
> Event ID: 20057  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:Failed to initialize security context for target MSOMHSvc/******The error returned is 0x80090311(No authority could be contacted for authentication.). This error can apply to either the Kerberos or the SChannel package.

Event IDs 21006, 21016 and 20057 are usually caused by firewalls or network problems that are preventing communication over the required ports. To troubleshoot this issue, check the firewalls between the client agent and the management server. The following ports must be open to enable correct authentication and communication:

- TCP and UDP port 389 for LDAP.
- TCP and UDP port 88 for Kerberos authentication.

### Event ID 2010 and 2003 appear on the client agent

Examples of these events:

> Log Name: Operations Manager  
> Source: HealthService  
> Date: data  
> Event ID: 2010  
> Task Category: Health Service  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description: The Health Service cannot connect to Active Directory to retrieve management group policy. The error is Unspecified error (0x80004005)  
> Event Xml:  
> \<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`">  
> \<System>  
> \<Provider Name="HealthService" />  
> \<EventID Qualifiers="49152">2010/\<EventID>  
> \<Level>2\</Level>  
> \<Task>1\</Task>  
> \<Keywords>0x80000000000000\</Keywords>  
> \<TimeCreated SystemTime="2015-02-21T21:06:04.000000000Z" />  
> \<EventRecordID>84143\</EventRecordID>  
> \<Channel>Operations Manager\</Channel>  
> \<Computer>ComputerName\</Computer>  
> \<Security />  
> \</System>  
> \<EventData>  
> \<Data>Unspecified error\</Data>  
> \<Data>0x80004005\</Data>  
> \</EventData>  
> \</Event>

> Log Name: Operations Manager  
> Source: HealthService  
> Date: time  
> Event ID: 2003  
> Task Category: Health Service  
> Level: Information  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description: No management groups were started. This may either be because no management groups are currently configured or a configured management group failed to start. The Health Service will wait for policy from Active Directory configuring a management group to run.  
> Event Xml:  
> \<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`">  
> \<System>  
> \<Provider Name="HealthService" />  
> \<EventID Qualifiers="16384">2003/\<EventID>  
> \<Level>4\</Level>  
> \<Task>1\</Task>  
> \<Keywords>0x80000000000000\</Keywords>  
> \<TimeCreated SystemTime="2015-02-21T21:06:04.000000000Z" />  
> \<EventRecordID>84156\</EventRecordID>  
> \<Channel>Operations Manager\</Channel>  
> \<Computer>ComputerName\</Computer>  
> \<Security />  
> \</System>  
> \<EventData>  
> \</EventData>  
> \</Event>

If the agent is using Active Directory assignment, the event logs will also indicate a problem communicating with Active Directory.

If you see these event logs, confirm that the client agent can access Active Directory. Check firewalls, name resolution and general network connectivity.

### Event ID 20070 combined with Event ID 21016

Examples of these events:

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Date: 6/13/2014 10:13:39 PM  
> Event ID: 21016  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr was unable to set up a communications channel to \<ComputerName> and there are no failover hosts. Communication will resume when \<ComputerName> is available and communication from this computer is allowed.

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Date: 6/13/2014 10:13:37 PM  
> Event ID: 20070  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> The OpsMgr Connector connected to \<ComputerName>, but the connection was closed immediately after authentication occurred. The most likely cause of this error is that the agent is not authorized to communicate with the server, or the server has not received configuration. Check the event log on the server for the presence of 20000 events, indicating that agents which are not approved are attempting to connect.

When you see these events, it indicates that authentication occurred but then the connection was closed. This usually occurs because the agent hasn't been configured. To verify this, check whether event ID 20000 **A device which is not part of this management group has attempted to access this health service** is received on the management server.

These event logs can also occur if client agents are stuck in a **Pending** status and not visible in the console.

To verify, run the following command to check whether the agents are listed for manual approval:

```powershell
Get-SCOMPendingManagement
```

If so, you can resolve this by running the following command to manually approve the agents:

```powershell
Get-SCOMPendingManagement| Approve-SCOMPendingManagement
```

### Event ID 21023 appears on the client agent, while Event ID 29120, 29181 and 21024 appear on the management server

Some examples of these events are included below.

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Event ID: 21023  
> Task Category: None  
> Level: Information  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr has no configuration for management group \<GroupName> and is requesting new configuration from the Configuration Service.

> Log Name: Operations Manager  
> Source: OpsMgr Management Configuration  
> Event ID: 29120  
> Task Category: None  
> Level: Warning  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr Management Configuration Service failed to process configuration request (Xml configuration file or management pack request) due to the following exception

> Log Name: Operations Manager  
> Source: OpsMgr Management Configuration  
> Event ID: 29181  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr Management Configuration Service failed to execute 'GetNextWorkItem' engine work item due to the following exception

> Log Name: Operations Manager  
> Source: OpsMgr Management Configuration  
> Event ID: 29181  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr Management Configuration Service failed to execute 'LocalHealthServiceDirtyNotification' engine work item due to the following exception

> Log Name: Operations Manager  
> Source: OpsMgr Management Configuration  
> Event ID: 21024  
> Task Category: None  
> Level: Information  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr's configuration may be out-of-date for management group \<GroupName>, and has requested updated configuration from the Configuration Service. The current(out-of-date) state cookie is "5dae4442500c9d3f8f7a883e83851994,906af60d48ed417fb1860b23ed67dd71:001662A3"

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Event ID: 29181  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> OpsMgr Management Configuration Service failed to execute 'DeltaSynchronization' engine work item due to the following exception

These events can occur when the delta synchronization process cannot build configuration within its configured timeout window of 30 seconds. This can occur when there is a large instance space.

To resolve this issue, increase the timeout on all management servers. To do this use one of the following methods:

#### Method 1

1. Make a backup copy of the following file:

   *Drive:\Program Files\System Center 2012\Operations Manager\Server\ConfigService.Config*

1. Increase the timeout values in `ConfigService.config` with the following changes:

    Locate `<OperationTimeout DefaultTimeoutSeconds="30">`, change **30** to **300**.  
    Locate `<Operation Name="GetEntityChangeDeltaList" TimeoutSeconds="180" />`, change **180** to **300**.

1. Restart the Configuration service.

In most cases, this should allow enough time for the synchronization process to complete.

#### Method 2

1. Install [Update Rollup 3](https://support.microsoft.com/help/2965445/) or later for System Center 2012 R2 Operations Manager.
2. Add the following registry value on the server that's running System Center 2012 R2 Operations Manager to configure the timeout:

    - Registry subkey: `HKEY_LOCAL_MACHINE\Software\Microsoft Operations Manager\3.0\Config Service`
    - DWORD name: `CommandTimeoutSeconds`
    - DWORD value: *nn*

    > [!NOTE]
    > The default value for the placeholder *nn* is 30 seconds. You can change this value to control the timeout for delta synchronization.

### Other OpsMgr Connector event IDs

Other OpsMgr Connector error events and the corresponding troubleshooting suggestions are listed below:

| Event| Description| More information|
|---|---|---|
| 20050|The specified certificate could not be loaded because the Enhanced Key Usage that's specified doesn't meet OpsMgr requirements. The certificate must have the following usage types: %n %n Server Authentication (1.3.6.1.5.5.7.3.1)%n Client Authentication (1.3.6.1.5.5.7.3.2)%n|Confirm the object identifier on the certificate.|
| 20057|Failed to initialize security context for target %1 The error returned is %2(%3). This error can apply to either the Kerberos package or the SChannel package.|Check for duplicate or incorrect SPNs.|
| 20066|A certificate for use with Mutual Authentication was specified. However, that certificate could not be found. The ability for this Health Service to communicate will likely be affected.|Check the certificate.|
| 20068|The certificate that is specified in the registry at `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings` cannot be used for authentication because the certificate does not contain a usable private key or because the private key is not present. The error is %1(%2).|Check for a missing or unassociated private key. Investigate the certificate. Re-import the certificate, or create a new certificate and import.|
| 20069|The specified certificate could not be loaded because the KeySpec must be AT_KEYEXCHANGE|Check the certificate. Check the object identifier on the certificate.|
| 20070|The OpsMgr Connector connected to %1. However, the connection was closed immediately after authentication occurred. The most likely cause of this error is that the agent is not authorized to communicate with the server or that the server has not received configuration. Check the event log on the server for the presence of 20000 events. These indicate that agents that are not approved are trying to connect.|Authentication occurred but the connection was closed. Confirm that ports are open and check agent pending approval.|
| 20071|The OpsMgr Connector connected to %1. However, the connection was closed immediately without authentication occurring. The most likely cause of this error is a failure to authenticate either this agent or the server. Check the event log on the server and on the agent for events that indicate a failure to authenticate.|Authentication has failed. Check firewalls and port 5723. The agent computer must be able to reach port 5723 on the Management Server. Also confirm that TCP & UDP port 389 for LDAP, port 88 for Kerberos and port 53 for DNS are available.|
| 20072|The remote certificate %1 was not trusted. The error is %2(%3).|Check whether the certificate is located in the trusted store.|
| 20077|The certificate that is specified in the registry at `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings` cannot be used for authentication because the certificate cannot be queried for property information. The specific error is %2(%3).%n %n. This typically means that no private key was included with the certificate. Please double-check to make sure that the certificate contains a private key.|There is a missing or unassociated private key. Investigate the certificate. Re-import the certificate, or create a new certificate and import.|
| 21001|The OpsMgr Connector could not connect to %1 because mutual authentication failed. Verify that the SPN is registered correctly on the server and that, if the server is in a separate domain, there is a full-trust relationship between the two domains.|Check SPN registration.|
| 21005|The OpsMgr Connector could not resolve the IP for %1. The error code is %2(%3). Please verify that DNS is working correctly in your environment.|This is usually a name resolution issue. Check DNS.|
| 21006|The OpsMgr Connector could not connect to %1:%2. The error code is %3(%4). Please verify that there is network connectivity, that the server is running and has registered its listening port, and that there are no firewalls that are blocking traffic to the destination.|This is likely a general connectivity issue. Check the firewalls and confirm that port 5723 is open.|
| 21007|The OpsMgr Connector cannot create a mutually authenticated connection to %1 because it is not in a trusted domain.|A trust is not established. Confirm that the certificate is in place and is configured correctly.|
| 21016|OpsMgr could not set up a communications channel to %1, and there are no failover hosts. Communication will resume when %1 is available and communication from this computer is enabled.|This usually indicates an authentication failure. Confirm that the agent was approved for monitoring and that all ports are open.|
| 21021|No certificate could be loaded or created. This Health Service will be unable to communicate with other health services. Look for previous events in the event log for more detail.|Check the certificate.|
| 21022|No certificate was specified. This Health Service will be unable to communicate with other health services unless those health services are in a domain that has a trust relationship with this domain. If this health service has to communicate with health services in untrusted domains, please configure a certificate.|Check the certificate.|
| 21035| Registration of an SPN for this computer with the "%1" service class failed with error "%2." This may cause Kerberos authentication to or from this Health Service to fail.|This indicates a problem with SPN registration. Investigate SPNs for Kerberos authentication.|
| 21036|The certificate that is specified in the registry at `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings` cannot be used for authentication. The error is %1(%2).|This is usually a missing or unassociated private key. Investigate the certificate. Re-import the certificate, or create a new certificate and import it.|
