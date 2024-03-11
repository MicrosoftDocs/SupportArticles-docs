---
title: Troubleshoot UNIX/Linux agent discovery
description: This article helps troubleshoot common errors that may be encountered during the discovery process of UNIX or Linux computers.
ms.date: 10/06/2022
ms.custom: linux-related-content
---
# Troubleshoot UNIX/Linux agent discovery in Operations Manager

This article helps you troubleshoot common errors that may be encountered during the discovery process of UNIX or Linux computers.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 4490426

To monitor UNIX or Linux computers in System Center Operations Manager (OpsMgr), the computers must first be discovered, and the OpsMgr agent must be installed. The [Computer and Device Management Wizard](/system-center/scom/manage-deploy-crossplat-agent-console) is used to discover and install agents on UNIX and Linux computers. However, the discovery process may fail due to configuration issues, credential or privilege problems, or network and name resolution problems.

## Certificate errors or certificate signing errors  

### Signed certificate verification operation was not successful

When certificate verification fails, you typically receive an error that resembles the following:

> Agent verification failed. Error detail: The server certificate on the destination computer (lx1.contoso.com:1270) has the following errors:  
> The SSL certificate could not be checked for revocation. The server used to check for revocation might be unreachable.  
> The SSL certificate contains a common name (CN) that does not match the hostname.  
> It is possible that:
>
> 1. The destination certificate is signed by another certificate authority not trusted by the management server.
> 2. The destination has an invalid certificate, e.g., its common name (CN) does not match the fully qualified domain name (FQDN) used for the connection. The FQDN used for the connection is: lx1.contoso.com.
> 3. The servers in the resource pool have not been configured to trust certificates signed by other servers in the pool.

- One common cause is that the agent certificate's common name (CN) value doesn't match the provided or resolved fully qualified domain name (FQDN).

  To verify this, confirm that the agent host's host name and domain name match the FQDN resolved through DNS.

  You can view the basic details of the certificate on the UNIX or Linux computer by running the following command:

  ```console
  openssl x509 -noout -in /etc/opt/microsoft/scx/ssl/scx.pem -subject -issuer -dates
  ```

  When you do this, you will see output that's similar to the following:

  > subject= /DC=name/DC=newdomain/CN=newhostname/CN=newhostname.newdomain.name  
  > issuer= /DC=name/DC=newdomain/CN=newhostname/CN=newhostname.newdomain.name  
  > notBefore=Mar 25 05:21:18 2008 GMT  
  > notAfter=Mar 20 05:21:18 2029 GMT

  Use this information to validate the host names and dates, make sure that they match the name being resolved by the Operations Manager management server.

  If the host names don't match, use one of the following actions to resolve the issue:

  - If the UNIX or Linux host name is correct but the Operations Manager management server is resolving it incorrectly, either modify the DNS entry to match the correct FQDN or add an entry to the hosts file on the Operations Manager server.
  - If the UNIX or Linux host name is incorrect, do one of the following:
    - Change the host name on the UNIX or Linux host to the correct one and create a new certificate.
    - Create a new certificate with the desired host name.

  **To change the name on the certificate:**

  If the certificate was created with an incorrect name, you can change the host name and re-create the certificate and private key. To do this, run the following command on the UNIX or Linux computer:

  ```console
  /opt/microsoft/scx/bin/tools/scxsslconfig -f -v
  ```

  The `-f` option forces the files in /etc/opt/microsoft/scx/ssl to be overwritten.

  You can also change the host name and domain name on the certificate by using the `-h` and `-d` switches, as in the following example:

  ```console
  /opt/microsoft/scx/bin/tools/scxsslconfig -f -h <hostname> -d <domain.name>
  ```

  Restart the agent by running the following command:

  ```console
  /opt/microsoft/scx/bin/tools/scxadmin -restart
  ```

  **To add an entry to the hosts file:**

  If the FQDN is not in Reverse DNS, you can add an entry to the hosts file located on the management server to provide name resolution. The hosts file is located in the `\Windows\System32\Drivers\etc` folder. An entry in the hosts file is a combination of the IP address and the FQDN.

  For example, to add an entry for the host named *newhostname.newdomain.name* with an IP address of 192.168.1.1, add the following to the end of the hosts file:

  `192.168.1.1 newhostname.newdomain.name`

- Another common cause of this error is that the certificate has been signed by untrusted authority, such as when multiple management servers are members of the resource pool used for discovery but certificate trust has not been configured between the management servers.

  To verify this, confirm that all management servers in the resource pool used for discovery trust each other server's certificate.

  For more information about how to manage resource pools for UNIX and Linux computers, see [Managing Resource Pools for UNIX and Linux Computers](/previous-versions/system-center/system-center-2012-R2/hh287152(v=sc.12)).
  
### The user name or password is incorrect

You may see the error when trying to discover UNIX/Linux agents. The failure may occur during the certificate verification step while discovering a UNIX/Linux machine.

**Possible causes**

- Basic authentication is set to `false` on one or more management servers in the UNIX/Linux resource pool when the UNIX/Linux agent is not domain joined and cannot utilize Kerberos authentication. You can verify the current [WinRM](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management) settings by running the following command: `winrm get winrm/config/client`.
- The username or password is incorrect.

**Resolution**

You can update the WinRM configuration on the management servers in the UNIX/Linux resource pool to allow Basic authentication by running the following command, or you can set the configuration via Group Policy:

```cmd
winrm set winrm/config/client/auth @{Basic="true"}
```

> [!NOTE]
> The above command sets a DWORD (32-bit) registry value (**AllowBasic**) in the following registry key:
>
> `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WinRM\Client`
>
> **AllowBasic** allows either `1` (Enabled) or `0` (Disabled) decimal values.

### Certificate signing operation was not successful

**Possible causes**

- The user account specified for discovery has insufficient privileges to perform file operations involved in signing.
- Sudo elevation privileges for the user account specified for discovery wasn't correctly configured.

**Resolution**

To fix the issue, verify the user account by inspecting the StdErr output in the error details to identify the cause of the failure. Also verify the sudo privilege configuration for the account used for certificate signing.

## Network name resolution errors

### The target address is not resolvable

These issues typically fall into one of the following categories:

- **Error description**  

  > Failed to resolve IP address \<IP address> to name

  **Cause**

  This error occurs when an IP address for the host was entered for discovery but the IP address isn't resolvable to a name in DNS (reverse lookup).

  **Resolution**

  To fix this issue, correct name resolution (DNS) configuration for the reverse lookup zone, make sure that an IP address to name mapping exists for the affected host.

- **Error description**

  > Failed to resolve name *server.contoso.com* to IP address

  **Cause**

  This error occurs if an FQDN for the host was entered for discovery but the name isn't resolvable to IP address in DNS (forward lookup).

  **Resolution**

  To fix this issue, correct name resolution (DNS) configuration for forward lookup, make sure that a host name to IP address mapping exists for the host.  

### DNS configuration: Forward DNS resolution does not match reverse DNS resolution

**Error description**

In this situation, you typically receive an error that resembles the following:

> The provided hostname ServerName resolved to the IP address of 10.137.216.x. The hostname ServerName.contoso.com returned by reverse lookup of the IP address 192.168.x.x did not match the provided hostname. Verify the DNS configuration and try the request again.

**Cause**

The most common cause is that the records for the host in the forward and reverse DNS lookup zones don't match.

**Resolution**

To fix this issue, correct the records in the forward and reverse lookup zones in DNS so that the host names and IP address match.  

### The target address is unreachable

**Error description**

In this situation, you typically receive an error that resembles the following:

> The WinRM client cannot complete the operation within the time specified. Check if the machine name is valid and is reachable over the network and firewall exception for Windows Remote Management service is enabled.

**Possible causes**

- The host is unreachable due to incorrect name resolution, network outage or host outage.
- A network or host-based firewall is blocking TCP port 1270 connectivity to the target host.

**Resolution**

To fix this issue, verify that the management server can ping the agent host using its FQDN. Also verify that no network firewalls or host firewall is blocking TCP port 1270.

### Unexpected discoveryResult.ErrorData type. Please file bug report - Parameter name: s

**Error description**

> Unexpected DiscoveryResult.ErrorData type. Please file bug report.  
> ErrorData: System.ArgumentNullException  
> Value cannot be null.  
> Parameter name: s  
> at System.Activities.WorkflowApplication.Invoke(Activity activity, IDictionary\`2 inputs, WorkflowInstanceExtensionManager extensions, TimeSpan timeout)  
> at System.Activities.WorkflowInvoker.Invoke(Activity workflow, IDictionary\`2 inputs, TimeSpan timeout, WorkflowInstanceExtensionManager extensions)  
> at Microsoft.SystemCenter.CrossPlatform.ClientActions.DefaultDiscovery.InvokeWorkflow(IManagedObject managementActionPoint, DiscoveryTargetEndpoint criteria, IInstallableAgents installableAgents)

**Cause**

This error occurs because WinHTTP proxy settings have been configured on the management servers in the UNIX or Linux resource pool, and the FQDN of the UNIX or Linux agent that you're trying to discover isn't included in the WinHTTP proxy bypass list.

**Resolution**

To fix this issue, add the UNIX or Linux FQDN to the WinHTTP proxy bypass list.

On the management servers in the UNIX or Linux resource pool, run the following command at an elevated command prompt to verify the current proxy configuration:

```console
netsh winhttp show proxy
```

If a WinHTTP proxy server is configured, add the FQDN of the server that you're trying to discover to the bypass list by running the following command:

```console
netsh winhttp set proxy proxy-server="<proxyserver:port>" bypass-list="*.ourdomain.com;*.yourdomain.com*;<serverFQDN>"
```

Once the bypass list is configured, check if the agent discovery is successful.

> [!NOTE]
> You can run the `netsh winhttp reset proxy` command to disable the WinHTTP proxy. This command will remove the proxy server and configure direct access.

### Unexpected discoveryResult.ErrorData type. Please file bug report - Parameter name: lhs

**Error description**

> Discovery not successful  
> Message: Unspecified failure  
> Details: Unexpected DiscoveryResult.ErrorData type. Please file bug report.  
> ErrorData: System.ArgumentNullException  
> Value cannot be null.  
> Parameter name: lhs  
> at System.Activities.WorkflowApplication.Invoke(Activity activity, IDictionary\`2 inputs, WorkflowInstanceExtensionManager extensions, TimeSpan timeout)  
> at System.Activities.WorkflowInvoker.Invoke(Activity workflow, IDictionary\`2 inputs, TimeSpan timeout, WorkflowInstanceExtensionManager extensions)  
> at Microsoft.SystemCenter.CrossPlatform.ClientActions.DefaultDiscovery.InvokeWorkflow(IManagedObject managementActionPoint, DiscoveryTargetEndpoint criteria, IInstallableAgents installableAgents)

**Cause**

This error occurs because of omsagent shell files in the installed kits folder.

**Resolution**

Navigate to the following directory in File Explorer:

*C:\Program Files\Microsoft System Center\Operations Manager\Server\AgentManagement\UnixAgents\DownloadedKits*

If there are omsagent files listed, move them to a temporary directory outside the System Center Operations Manager (SCOM) files.

See the following screenshot for an example:

:::image type="content" source="media/troubleshoot-unix-linux-agent-discovery/unix-linux-discovery-example-fix.png" alt-text="Screenshot that shows omsagent files in the DownloadedKits folder.":::

After they're moved from the *DownloadedKits* folder, retry the discovery. The discovery should succeed now.

> [!NOTE]
> The discovery may fail with a different error. The error indicates that more troubleshooting is needed, such as sudoers, connectivity, and so on.

## SSH connectivity errors  

### Failed during SSH discovery. Exit code: -1073479162

**Error description**

> Standard Output:  
> Standard Error:  
> Exception Message:An exception (-1073479162) caused the SSH command to fail - No connection could be made because the target machine actively refused it.

**Possible causes**

- The SSH daemon isn't running on the target system.
- A network or host-based firewall is preventing SSH connections on TCP port 22.

**Resolutions**

- Verify that the SSH daemon is running.
- Verify that no network firewalls or host firewall is blocking TCP port 22.

### Failed during SSH discovery. Exit code: -1073479118

**Error description**

> Failed during SSH discovery. Exit code: -1073479118  
> Standard Output:  
> Standard Error:  
> Exception Message:An exception (-1073479118) caused the SSH command to fail - Server sent disconnect message: type 2 (protocol error : Too many authentication failures for root)

**Possible causes**

- The user account specified for discovery isn't permitted to sign in through SSH.
- The user account specified for discovery was input with an invalid username or password

**Resolutions**

- Verify that the user is permitted to sign in through SSH.
- Verify the input credentials and that the user is defined on the target host.  

### Failed during SSH discovery. Exit code: 1

**Error description**

> Failed during SSH discovery. Exit code: 1  
> Standard Output: Sudo path: /usr/bin/  
> Standard Error: sudo: sorry, you must have a tty to run sudo  
> Exception Message:

**Cause**

Sudo elevation was selected in the user credential input, however the `requiretty` option wasn't disabled for the user in **sudoers**.

**Resolution**

Edit the **sudoers** file on the target host by using the `visudo` command, and add the following line:

**Defaults: \<username>!requiretty**

For more information, see [How to Configure sudo Elevation and SSH Keys](/previous-versions/system-center/system-center-2012-R2/hh230690(v=sc.12)).  

### Invalid SU password

**Error description**

> .[?1034hopsuser@lx1:~> su - root -c 'sh /tmp/scx-opsuser/GetOSVersion.sh; EC=$?; rm -rf
/tmp/scx-opsuser;exit $EC'  
> Password:  
> exit  
> su: incorrect password  
> opsuser@lx1:~> exit  
> logout

**Possible cause**

Su elevation was selected in the user credential input, however an invalid root password was provided for su elevation.

**Resolution**

Verify the password input for root in the Elevation configuration dialog.  

### Failed during SSH discovery. Exit code: -2147221248

- **Error description**

  > Failed during SSH discovery. Exit code: -2147221248  
  > Standard Output:  
  > Standard Error: Could not chdir to home directory /home/username: No such file or directory

  **Cause**

  The user account specified for discovery doesn't have a home directory.

  **Resolution**

  Verify that the user has a home directory at: /home/ and that the user is able to write to this directory.

- **Error description**

  > Failed during SSH discovery. Exit code: -2147221248  
  > Standard Output:  
  > Standard Error: root's password:  
  > Exception Message:Operation timed out

  **Cause**

  Sudo elevation was selected in the user credential input. However, the user account specified for discovery isn't correctly configured to use passwordless sudo elevation, or the required sudo elevation privileges weren't granted for the user account used in discovery.

  **Resolution**  

  Review sudo elevation configuration documentation and verify user configuration for sudo. Note that passwordless sudo must be configured.

## WSMan connectivity errors  

### The agent responded to the request but the WSMan connection failed due to: Access is Denied

**Possible causes**

- The agent is installed and the agent certificate has been signed. However, the user credential provided for agent verification is invalid.
- The user account specified for discovery was configured to authenticate with an SSH key, but the user credential provided for agent verification is invalid.
- There is a permission problem or incorrect PAM configuration on the UNIX side.

**Resolution**

To fix the issue, follow these steps:

1. Verify that the username and password for agent verification were input correctly and that the user is a valid user on the target host.
2. If the issue persists, verify that sudo elevation has been configured correctly.
3. Also check the messages log on the UNIX/Linux computer. For example, in AIX, you can find the log under `/var/adm/messages`. In other operating systems, the location may vary.

   Look for lines such as the following:

   > Sep 3 14:49:07 server auth|security:debug /opt/microsoft/scx/bin/omiserver PAM: pam_authenticate: error Authentication failed.

   If you see similar lines in the messages log, it means that the PAM configuration file is missing information about OMIServer. The PAM configuration file can be found in the `/etc/pam.d/` directory or the `/etc/pam.conf` file.

   The easiest way to add the information about OMIServer back to the PAM configuration file is to reinstall the SCX agent from scratch on that computer. If that is not easily possible, you can copy the lines pertaining to OMI from a working computer to the non-working computer.

### WSMan only discovery failed for 192.168.x.x

**Possible causes**

- The **Discovery Type** option was set to **Only computers with an installed agent and signed certificate** and the target host has the agent installed. However, the target host certificate hasn't been signed. In order to use the WSMan-only discovery option, the agent must be installed and the certificate must be manually signed.
- The **Discovery Type** option was set to **Only computers with an installed agent and signed certificate**, but the target host doesn't have the UNIX/Linux agent currently installed.
- The **Discovery Type** option was set to **Only computers with an installed agent and signed certificate**, but the UNIX/Linux agent isn't currently running.
- The **Discovery Type** option was set to **Only computers with an installed agent and signed certificate**, but the target host is unreachable, a network or host-based firewall is preventing connectivity or the UNIX/Linux agent is currently down.

**Resolutions**

- Manually sign the certificate.
- Verify that the UNIX/Linux agent has been installed.
- Change the option to **Discover all computers** to allow the Discovery Wizard to perform the certificate signing.
- Verify that the UNIX/Linux agent is running and that the target host is reachable.
- Verify that no network firewalls or host firewall is preventing access on TCP port 1270.

## Other errors  

### The task cannot be executed against the object(s) because the target of the task does not match any of the classes of the object

**Cause**

In a System Center 2012 Operations Manager management group, this can occur if the UNIX/Linux management packs imported are Operations Manager 2007 R2 versions.

**Resolution**

Import the System Center 2012 versions of the UNIX/Linux operating system management packs.  

### The agent is installed and the computer is already being monitored by Operations Manager

**Cause**

The target host has already been discovered in this management group.

**Resolution**

No action is required. Agent upgrade or migration to an alternate resource pool can be performed from the UNIX/Linux Servers view in the Administration pane of the Operations console.

### Failed to find a matching supported agent instance in the imported management packs

**Error description**

> Failed to find a matching supported agent instance in the imported management packs.
Import the Management Pack(s) for this platform in order to discover this computer.

**Possible causes**

- The target host is running an unsupported operating system.
- The correct management pack for the target host's operating system hasn't been imported.
- The correct management pack for the operating system has recently been imported but hasn't yet fully loaded.

**Resolutions**

- Confirm that the target host is running a supported operating system.
- Import the management pack for the target host's operating system and version.
- If the management pack was imported, it may still be loading. Wait a few minutes and rerun discovery.  

### Unable to enumerate Installable agent types. The associated resource pool may still be initializing

**Error description**

> Unable to enumerate Installable agent types. The associated resource pool may still be initializing. If you had selected a newly created resource pool, please wait a few minutes before using it.

**Possible causes**

- The resource pool used in discovery isn't healthy, for example, a majority of member servers are offline.
- The resource pool used in discovery was recently created, but it hasn't fully initialized.

**Resolution**

If the resource pool used in discovery was recently created, retry the discovery after several minutes to allow the pool to initialize. Otherwise, check the Operations Manager Event Log on the servers that are members of the Resource Pool used for discovery for indications of the source of the problem.  

### Unable to copy new agent to this computer

**Error description**

> Message: Unable to copy new agent to this computer  
> Details:  
> Failed to copy kit. Exit code: -1073479144  
> Standard Output:  
> Standard Error:  
> Exception Message: An exception (-1073479144) caused the SSH command to fail  

**Cause**

File agent versions mismatch between database and agent repository.

**Resolutions**

- Verify that the failed agents are all failing because of version mismatch. Otherwise, apply other troubleshooting steps.
- Try to update the failed agents again. Usually the list of failed agents gets shorter and shorter during every update iteration.
- Restart the Health Service on all members of your Linux resource pool or other pool for managing Unix or Linux machines. Check the `%ProgramFiles%\Microsoft System Center 2012 R2\Operations Manager\Server\AgentManagement\UnixAgents\DownloadedKits` folder if file names are correct. Remember to close and reopen the Discovery Wizard.

## More information

For more help, see our [TechNet support forum](https://social.technet.microsoft.com/Forums/systemcenter/home?forum=operationsmanagerunixandlinux) or contact [Microsoft Support](https://support.microsoft.com/).
