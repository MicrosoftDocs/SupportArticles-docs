---
title: Lync Server Central Management Store replication failures
description: Resolves the issues in which Lync Server 2010 Central Management Store (CMS) file replication process cannot work after adding, moving or updating Lync Server 2010 Server roles .
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Lync Server 2010 Enterprise Edition 
- Lync Server 2010 Standard Edition 
- Lync Server 2013
---

# Lync Server Central Management Store replication failures

## Symptoms

Adding, moving or updating Lync Server server roles may cause the Central Management Store (CMS) file replication process to fail. The following scenarios describe some different types of CMS file replication failures that may occur under different circumstances.

### Scenario 1

When, CMS file replication between the Lync Server front end server that hosts the Lync Server File Transfer Agent Service and the internal interface(s) of the Lync Server Edge pool fails because network routing issues, the following Lync Server Error event is logged:

```AsciiDoc
Log Name:   Lync Server
Source:        LS File Transfer Agent Service
Date:          dd/mm/yyyy hh:mm:ss AM|PM
Event ID:      1017
Task Category: (1121)
Level:         Error
Keywords:  Classic
User:          N/A
Computer:      server01.contoso.net
Description:
File transfer failed for some replica machines. Microsoft Lync Server, File Transfer Agent will continuously attempt to replicate to these machines.
While this condition persists, configuration changes will not be delivered to these replica machines.

Replica file transfer failures: sever05.contoso.com: Https destination unavailable.

Cause: Possible issues with transferring files to the replicas listed above.

Resolution: Check the accessibility of file shares or https web services listed above.
```

### Scenario 2

When CMS file replication between the Lync Server front end server that hosts the Lync Server File Transfer Agent Service and the internal interface(s) of the Lync Server Edge pool fails because certificate configuration issues, the following Lync Server Error event is logged:

```AsciiDoc
Log Name:      Lync Server
Source:        LS File Transfer Agent Service
Date:          dd/mm/yyyy hh:mm:ss
Event ID:      1015
Task Category: (1121)
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      server01.contoso.com
Description:
File transfer failed. Microsoft Lync Server, File Transfer Agent will continuously attempt to transfer the files.

Reason: Unable to match host/cluster against certificate, host=server05.contoso.com, cluster=server05.contoso.com, CNn=server05.contoso.com, OU=Certificates, OU=Server, O=<Organization name>.

Cause: Microsoft Lync Server, Replica Replicator Agent presented an invalid certificate.

Resolution: Ensure that the certificate configured for Microsoft Lync Server, Replica Replicator Agent is valid.
```

### Scenario 3

The following Lync Server Error event is logged when the Lync Server 2010 FE server that hosts the Lync Server File Transfer Agent service does not have the permissions needed to access the xds-replica share located on a Lync Server role server. 

```AsciiDoc
Log Name:      Lync Server
Source:        LS File Transfer Agent Service
Date:          dd/mm/yyyy hh:mm:ss AM|PM
Event ID:      1034
Task Category: (1121)
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      server01.contoso.com
Description:
Microsoft Lync Server, File Transfer Agent service encountered an error while accessing a file share and will continuously attempt to access this file share until this issue is resolved. While this condition persists, replication to replica machines might not occur.

Access denied. (\\server02.contoso.com\xds-replica\from-master\data.zip)

Cause: Possible issues with file share permissions. This can occur if the computer hosting the file share has outdated cached credentials for the computer that is trying to access the file share.

Resolution: For details about how to resolve file share permission issues, see the product documentation
```

## Cause

### Scenario 1

The Lync Server Master File Transfer service located on the Lync Server front end server push a copy of the CMS replica information to the Lync Server Replica Replicator Agent service by using TCP port 4443 on the internal interface of a Lync Server Edge server in the Lync Server Edge server pool. This file transfer process can fail if:

- The internal firewall for the perimeter network that hosts the Lync Server Edge server pool is not configured to allow for file transfers by using outgoing TCP port 4443.   
- Network routing between the Lync Server front end server and the internal interface of a Lync Server Edge server in the Lync Server Edge  server pool is configured incorrectly.   

### Scenario 2

The Lync Server Replica Replicator Agent service located on the Lync Server front end server cannot establish a trust relationship with the Lync Server Replica Replicator Agent service located on the Lync Server Edge Server(s) because of an invalid certificate configuration.

### Scenario 3

The Lync Server File Transfer Agent Service located on the Lync Server front end server cannot complete the Kerberos authentication process that is required to securely transfer a copy of the CMS replica information to one or more the Lync Server role servers. This issue can occur when the xds-replica folder that is located on the remote Lync Server server is missing the default Access Control Entries (ACE) from its Access Control List (ACL). 

## Resolution

Before you use to any of the steps that are listed in the Scenario 1, Scenario 2, and Scenario 3, follow these steps:

1. Open the **Lync Server Management Shell**.   
2. Type the following Lync Server PowerShell cmdlet:

    ```powershell
    Get-CsManagementStoreReplicationStatus -CentralManagementStoreStatus
    ```
3. Review the results of the Get-CsManagementStoreReplicationStatusPowerShell cmdlet.   
4. Type the following Lync Server PowerShell cmdlet:

    ```powershell
    Invoke-CsManagementStoreReplication
    ```
5. Type the following Lync Server PowerShell cmdlet again:

    ```powershell
    Get-CsManagementStoreReplicationStatus -CentralManagementStoreStatus
    ```
6. Review the results of the `Get-CsManagementStoreReplicationStatus`  PowerShell cmdlet.   

These steps identify which Lync Server server roles cannot participate in the CSM replication process.

> [!NOTE]
> The ActiveReplicas list that is returned by the `Get-CsManagementStoreReplicationStatus -CentralManagementStore` Lync Server PowerShell command display is truncated to 128 bytes and may not display the full list of ActiveReplicas.

### Scenario 1

To troubleshoot the TCP port 4443 routing issue that is described in the Symptoms section, follow these steps to locate the origin of the issue.

Make sure that the Lync Server Replica Replicator Agent service on the Lync Server Edge server is running:

**Using Server 2008 or Server 2008 R2**

1. From the console of the Lync Server Edge Server, click Start, click Run, and type services.msc, then click OK.   

**Using Server 2012**

1. Press the Windows function key to access the Start page   
2. Click on the Administrative Tools tile to locate services.msc   
3. Double click on the services.msc node   
User the steps listed below to review the status of the Lync Server Replica Replicator Agent service

1. Locate the Lync Server Replica Replicator Agent service in the list of services.   
2. If the Lync Server Replica Replicator Agent service is stopped, right-click it, and then click **Start**.   
Make sure that the perimeter network's internal firewall is configured to allow for outgoing TCP port 4443 traffic to each of the internal edge interfaces for the Lync Server Edge server pool.

For more information about port configurations for the Lync Server perimeter network configuration, go to the following Microsoft website:

[Port Summary for Single Consolidated Edge](/previous-versions/office/lync-server-2013/lync-server-2013-port-summary-single-consolidated-edge-with-private-ip-addresses-using-nat)

Use The Windows Telnet client to test the route from the Lync Server front end server to the internal interface of each of the Lync Server Edge server(s) in the Lync Server Edge Server pool by using TCP 4443.

**Using Server 2008 or Server 2008 R2**

1. On a Microsoft Windows Server-based computer that hosts the Lync Server front end services, click Start, click Run and type cmd.exe, and then click OK.   

**Using Server 2012**

1. Press the Windows function key to access the Start page   
2. Right click on the Start page and then click on the All Apps tile   
3. Click on the Windows command prompt tile   

Use the steps listed below to test routing between the Lync Server front end server(s) and the internal interface of the internal interface of the Lync Server Edge server pool:

1. Enter the following command line at the command prompt to test routing between the Lync Server front end server and each internal interface of the Lync Server Edge Server(s) in the Lync Server Edge server pool:
    
    ```powershell
    telnet <ip address of the Lync Server Edge server internal interface> 4443
    ```
2. A flashing cursor in the upper-left corner of the command prompt windows indicates a successful connection to the remote Lync Server Replica Replicator Agent service by using TCP port 4443.

    > [!NOTE]
    > Microsoft Windows Vista, Windows Server 2008 and later versions of the Windows Server operating systems require the installation of the Telnet client. For more information about how to install Telnet client, go to the following Microsoft web site:
    
    [Install Telnet Client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771275(v=ws.10))

3. Perform steps 1 through 6 that are previously listed at the beginning of the Resolution section.   

> [!NOTE]
> Some hardware load balancer vendors have specific configurations for TCP port 4443 for the Lync Server Replicator Agent service on the Lync  Edge pool internal interface. For more details please review the following Microsoft TechNet documentation:

[Infrastructure qualified for Microsoft Lync](/SkypeForBusiness/lync-cert/qualified-ip-pbx-gateway)

### Scenario 2

To troubleshoot the certificate related issue described in the Symptoms section, Windows Server certificate snap-in can be used to analyze the issue. Use the following TechNet information to add the Certificates Snap-in to an MMC and review the certificate's information:

[Add the Certificates Snap-in to an MMC](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754431(v=ws.11))

> [!NOTE]
> Make sure that you use the instructions labeled - To add the Certificates snap-in to an MMC for a computer account

The Lync Server front end server pool and the Lync Server Edge server pool must share the same PKI solution. The issuing Certificate Authority server that provides the server certificate(s) and the matching Certificate Authority root certificate solution for the Lync Server front end server pool must provide the server certificate(s) and the matching Certificate Authority root certificate solution for each of the Lync Server Edge server(s) internal interfaces that belong to the Lync Server Edge server pool.

Use the following steps to ensure that each of the Lync Server Edge server(s) that are part of a Lync Server Edge server pool host a server certificate that contains the private key for the certificate:

1. Add the Certificate Snap-in.   
2. Use the following TechNet information to view the General information for the Server certificate that is used to authenticate the Lync Server Edge server(s) internal interfaces that belong to the Lync Server Edge server pool:

    [General Tab](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753240(v=ws.11))

3. The Certificate Information on the General tab of the Certificate dialog box should say "You have a private key assigned to this certificate". If this line is missing from the Certificate Information, read the "To export the certificate with the private key for Edge Servers in a pool" section of the following TechNet article for more information on how to troubleshoot this issue:

    [Details Tab](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771722(v=ws.11))

4. Use steps 1 through 6 that are previously listed at the beginning of the Resolution section.   

### Scenario 3

To troubleshoot why the Lync Server File Transfer Agent Service cannot access the folder(s) listed under the RTCReplicaRoot folder on the remote Lync Server role server that is mentioned in the Symptoms section:

**Using Server 2008 or Server 2008 R2**

1. On a Microsoft Windows Server-based computer that hosts the Lync Server front end services, click Start, click Run and type explore.exe, and then click OK.

**Using Server 2012**

1. Press the Windows function key to access the Start page   
2. Click on the Windows Explorer tile   
Use the steps listed below to evaluate the Access Control List (ACL) of the xds-replica share on the remote Lync Server role server:

1. Use Windows Explorer to locate the \<local drive>:\RTCReplicaRoot\xds-replica share on the Lync Server role server that is described as Access Denied in the LS File Transfer Agent Service Event ID 1034 that is displayed as Scenario 3 of the Symptoms section.   
2. Initial access to the xds-replica shared folder requires local administrator ownership NTFS permissions. 
3. Right-click the xds-replica folder and then select **Properties**.   
4. On the **Security** tab, and then click **Continue**.   
5. Click the **Owner** tab, click **Edit**.   
6. Select the local Administrator role, and then click the **Replace owner on sub containers and objects** option.   
7. Click **OK** after the xds-replica Properties dialog box is closed.   
8. Right-click the xds-replica folder and then select **Share**.   
9. Click the **Change sharing permissions** choice on the **File sharing** dialog box.   
10. Make sure that the RTC Local Config Replicator local security account is added to the File sharing dialog's ACL with co-owner or read/write permissions. Click **Share**, click **Done**.   
11. Use the **Active Directory Users and Computers** snap-in to make sure that the Windows Active directory computer account for the Lync front end server that hosts the CMS role is a member of the RTCUniversalConfigReplicator Windows security group.   
12. From the console of a Windows Server based computer that hosts the Active Directory Domain Services role, open the **Active Directory Users and Computers** tool   
13. Locate the**RTCUniversalConfigReplicator** Windows security group and right-click it, and then click Properties.   
14. Click the **Member** tab.   
15. Make sure that the Windows Active Directory computer account for the Lync Server front end server that hosts the CMS role is added to the members list. Click **OK**.   
16. Use steps 1 through 6 that are previously listed at the beginning of the Resolution section   

## More Information

For detailed information on the how the Lync Server manages the replications services review the following list of TechNet articles on the topic:

- [What is Central Management Store (CMS)](/archive/blogs/jenstr/what-is-central-management-store-cms)
- [Confirm Local Configuration Store Replication Status](/previous-versions/office/skype-server-2010/gg195701(v=ocs.14))
- [Get-CsManagementStoreReplicationStatus](/powershell/module/skype/Get-CsManagementStoreReplicationStatus)
- [Invoke-CsManagementStoreReplication](/powershell/module/skype/Invoke-CsManagementStoreReplication)
- [Ports and Protocols for Internal Servers](/skypeforbusiness/plan-your-deployment/network-requirements/ports-and-protocols)
- [Move the Configuration Management Server to another SQL Server](/previous-versions/office/skype-server-2010/gg195644(v=ocs.14))
- [Move Lync File Store Data to New File Store](/previous-versions/office/communications/gg195742(v=ocs.16))

The Lync Server CMS file replication process uses TCP 445 as the destination port for its client / server requests for shared replica folder access. The Server Message Block (SMB) protocol is used to make sure that secure communications for each client / server connection that is used for file replica replication.

[Server Message Block overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831795(v=ws.11))

Here's a summary of how permissions are applied and then used to secure access to the xds-master folder and subfolders for Lync Server Enterprise Edition:

- The initial publishing of a Lync Server topology will create the 1-CentralMgmt-1\CMSFileStore folders under the Lync Server front end pool's FileStore share.   
- The CMSFileStore folder will have the RTCUniversalConfigReplicator security group added to its share ACL with the equivalent of contributor permissions.   
- The xds-master folder and the subfolders that are used in the CMS replication process will be added to the CMSFileStore folder when the first Lync server front end server is added to the pool.   
- These folders will inherit the permissions for the RTCUniversalConfigReplicator Windows security group as they are created.   
- The CMSFileStore folder will have the RTCUniversalConfigReplicator security group added to its NTFS ACL with Modify, Read & execute, List folder contents, Read, Write permissions.   
- The Windows Active directory computer account for the Lync front end server that hosts the CMS role will be made a member RTCUniversalConfigReplicator Windows security group.   
- Also, the first Lync Server front end server is added to the pool will manage the CMS replication process by using the Lync Server Master Replicator Agent, Lync Server File Transfer Agent, and Lync Server Replica Replicator Agent services.   
Here's a brief summary of how permissions are applied and then used to secure access to the xds-master folder and subfolders for Lync Server Standard Edition:

- The initial publishing of a Lync Server topology will create the 1-CentralMgmt-1\CMSFileStore folders under the Lync Server front end pool's FileStore share.   
- The CMSFileStore folder will have the RTCUniversalConfigReplicator security group added to its share ACL with the equivalent of contributor permissions.   
- The CMSFileStore folder will have the RTCUniversalConfigReplicator security group added to its NTFS ACL with Modify, Read & execute, List folder contents, Read, Write permissions.   
- The CMSFileStore folder will have RTC Local Config Replicator local security group added to its share ACL with Contributor permissions.   
- The CMSFileStore folder will have RTC Local Config Replicator local security group added to its NTFS ACL with Modify, Read & execute, List folder contents, Read, Write permissions.   
- The xds-master folder and the subfolders that are used in the CMS replication process will be added to the CMSFileStore folder when the first Lync front end server is added to the pool.   
- The xds-master folder and the subfolders that are used in the CMS replication process will inherit the permissions for the RTCUniversalConfigReplicator Windows security group and the RTC Local Config Replicator local security group as they are created.   
- The Windows Active directory computer account for the Lync front end server that hosts the CMS role will be made a member RTCUniversalConfigReplicator Windows security group.   
- The RTCUniversalConfigReplicator Windows security group, NT SERVICE\FTA, NT SERVICE\MASTER, and NT SERVICE\REPLICA local services will be made a members of the RTC Local Config Replicator local security group. This guarantees secure access to the local CMSFileStore folder.  
- Also, the first Lync front end server is added to the pool will manage the CMS replication process by using the Lync Server Master Replicator Agent, Lync Server File Transfer Agent, and Lync Server Replica Replicator Agent services.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).