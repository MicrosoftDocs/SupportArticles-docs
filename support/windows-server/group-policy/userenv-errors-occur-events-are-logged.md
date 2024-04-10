---
title: Userenv errors occur and events are logged
description: Describes how to troubleshoot issues where computers on your network can't connect to the Group Policy objects in the Sysvol folders on your network domain controllers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, msadoff
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# Userenv errors occur and events are logged after you apply Group Policy to computers that are running Windows Server 2003, Windows XP, or Windows 2000

This article provides a solution to issues where computers on your network can't connect to the Group Policy objects (GPO) in the Sysvol folders on your network domain controllers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 887303

## Summary

You may experience one or many errors and events if Group Policy is applied to the computers on your network. To determine the cause of the issue, you must troubleshoot the configuration of the computers on your network. Follow these steps to troubleshoot the cause of the issue:

1. Examine the DNS settings and network properties on the servers and client computers.
2. Examine the Server Message Block signing settings on the client computers.
3. Make sure that the TCP/IP NetBIOS Helper service, the Net Logon service, and the Remote Procedure Call (RPC) service are started on all computers.
4. Make sure that Distributed File System (DFS) is enabled on all computers.
5. Examine the contents and the permissions of the Sysvol folder.
6. Make sure that the Bypass traverse checking right is granted to the required groups.
7. Make sure that the domain controllers aren't in a journal wrap state.
8. Run the `dfsutil /purgemupcache` command.

## Symptoms

You experience one or more of the following symptoms on a computer that is running Microsoft Windows Server 2003, Microsoft Windows XP, or Microsoft Windows 2000:

- Group Policy settings aren't applied to the computers.
- Group Policy replication isn't completed between the domain controllers on the network.
- You can't open Group Policy snap-ins. For example, you can't open the Domain Controller Security Policy snap-in, or the Domain Security Policy snap-in.
- If you try to open a Group Policy snap-in, you receive one of the following error messages:
    > Failed to open the Group Policy Object. You may not have the appropriate rights.  
      Details: The account is not authorized to log in from this station.

    > You do not have permission to perform this operation.  
      Details: Access is denied.

    > Failed to open the Group Policy Object. You may not have the appropriate rights.  
      Details: The system cannot find the path specified.

- If you try to access shared files on any domain controller, you receive an error message. This symptom occurs even if you are logged on to the server, and you try to access a local share. Specifically, this symptom may affect access to a domain controller's Sysvol share.
- If you try to access a file share, you're repeatedly prompted for a password.
- If you try to access a file share, you receive an error message that is similar to one of the following error messages:
    > \\\\**Server_Name**\\**Share_Name** is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.  
      The account is not authorized to log in from this station.

    > \\\\**Server_Name**\\**Share_Name** is not accessible.  
      The account is not authorized to log in from this station.

    > The network path was not found.

If you view the Application log in Event Viewer on Windows XP or Windows Server 2003, you see events that are similar to the following events:

> Event Type: Error
>
> Event Source: Userenv  
Event Category: None  
Event ID: 1058  
>
> Date: **Date**  
Time:  
**Time**  
User:  
**User_Name**  
Computer:  
**Computer_Name**  
Description: Windows cannot access the file gpt.ini for GPO CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC= **domainname**,DC=com . The file must be present at the location <\\\\**domainname**.com\sysvol\\**domainname**.com\Policies\\{31B2F340-016D-11D2-945F-00C04FB984 F9}\gpt.ini>. (**Error_Message**). Group Policy processing aborted. For more information, see Help and Support Center at https://support.microsoft.com.

The error message that appears in the **Error_Message** placeholder in Event ID 1058 may be any of the following error messages:

- > The network path was not found.

- > Access is denied.

- > Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied.

> Event Type: Error  
Event Source: Userenv  
Event Category: None  
Event ID: 1030  
Date:  
**Date**  
Time:  
**Time**  
User:  
**User_Name**  
Computer:  
**Computer_Name**  
Description: Windows cannot query for the list of Group Policy objects. A message that describes the reason for this was previously logged by the policy engine. For more information, see Help and Support Center at https://support.microsoft.com.

Typically, if Event ID 1058 and Event ID 1030 occur, they are logged by client computers and member servers when the computer starts. Domain controllers log these events every five minutes.

If you view the Application log in Event Viewer on a Windows 2000-based computer, you see events that are similar to the following events:

> Event Type: Error  
Event Source: Userenv  
>
> Event Category: None  
Event ID: 1000  
Date:  
**Date**  
Time:  
**Time**  
User: NT AUTHORITY\SYSTEM  
Computer:  
**Computer_Name**  
Description: Windows cannot access the registry information at \\\\ **domainname**.com\sysvol\\**domainname**.com\Policies\\{31B2F340-016D-11D2-945F-00C04FB984F 9}\Machine\registry.pol with (**Error_Code**).

The error code that appears in the **Error_Code** placeholder in Event ID 1000 may be any of the following error codes:

- 5
- 51
- 53
- 1231
- 1240
- 1722

## Cause

These issues occur if the computers that are on your network can't connect to certain Group Policy objects. Specifically, these objects are in the Sysvol folders on your network's domain controllers.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. So make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, you must troubleshoot the configuration of your network to narrow the cause of the issue, and then correct the configuration. To troubleshoot the possible cause of this issue, follow these steps:

### Step 1: Examine the DNS settings and network properties on the servers and client computers

In the local area connection properties, Client for Microsoft Networks must be enabled on all servers and client computers. The File and Printer Sharing for Microsoft Networks component must be enabled on all domain controllers.

Additionally, every computer on the network must use DNS servers that can resolve SRV records and host names for the Active Directory forest where the computer is a member. Typically, a common configuration error is for the client computers to use the DNS servers that belong to your Internet service provider (ISP).

On all the computers that have logged the Userenv errors, examine the DNS settings and network properties. Additionally, check these settings on all domain controllers, whether or not they log Userenv errors.

To verify DNS settings and network properties on Windows XP-based computers in your network, follow these steps:

1. Select **Start**, and then select **Control Panel**.
2. If Control Panel is set to Category View, select **Switch to Classic View**.
3. Double-click **Network Connections**, right-click **Local Area Connection**, and then select **Properties**.
4. On the **General** tab, click to select the **Client for Microsoft Networks** check box.
5. Select **Internet Protocol (TCP/IP)**, and then select **Properties**.
6. If **Use the following DNS server addresses** is selected, make sure that the IP addresses for the preferred and alternate DNS servers are the IP addresses of DNS servers that can resolve SRV records and host names in Active Directory. Specifically, the computer mustn't use the DNS servers that belong to your ISP. If the DNS server addresses aren't correct, type the IP addresses of the correct DNS servers in the **Preferred DNS server** and **Alternate DNS server** boxes.
7. Select **Advanced**, and then select the **DNS** tab.
8. Click to select the **Register this connection's addresses in DNS** check box, and then select **OK** three times.
9. Start a command prompt. To do it, select **Start**, select **Run**, type cmd, and then select **OK**.
10. Type **ipconfig /flushdns**, and then press **ENTER**. Type **ipconfig /registerdns**, and then press **ENTER**.
11. Restart the computer for your changes to take effect.

To verify DNS settings and network properties on Windows 2000-based computers in your network, follow these steps:

1. Select **Start**, point to **Settings**, and then select **Control Panel**.
2. Double-click **Network and Dial-up Connections**.
3. Right-click **Local area connection**, and then select **Properties**.
4. On the **General** tab, click to select the **Client for Microsoft Networks** check box.
5. If the computer is a domain controller, click to select the
 **File and Printer Sharing for Microsoft Networks** check box.

    > [!NOTE]
    > On multi-homed Remote Access servers and Microsoft Internet Security and Acceleration (ISA) Server-based servers, you can disable the File and Printer Sharing for Microsoft Networks component for the network adaptor that is connected to the Internet. However, the Client for Microsoft Networks component must be enabled for all the server's network adaptors.
6. Select **Internet Protocol (TCP/IP)**, and then click **Properties**.
7. If **Use the following DNS server addresses** is selected, make sure that the IP addresses for the preferred and alternate DNS servers are the IP addresses of DNS servers that can resolve SRV records and host names in Active Directory. Specifically, the computer must not use the DNS servers that belong to your ISP. If the DNS server addresses aren't correct, type the IP addresses of the correct DNS servers in the **Preferred DNS server** and **Alternate DNS server** boxes.
8. Select **Advanced**, and then select the **DNS** tab.
9. Click to select the **Register this connection's addresses in DNS** check box, and then select **OK** three times.
10. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
11. Type **ipconfig /flushdns**, and then press **ENTER**. Type **ipconfig /registerdns**, and then press **ENTER**.
12. Restart the computer.

To verify DNS settings and network properties on Windows Server 2003-based computers in your network, follow these steps:

1. Select **Start**, point to **Control Panel**, and then double-click **Network Connections**.
2. Right-click the local area connection, and then select **Properties**.
3. On the **General** tab, click to select the **Client for Microsoft Networks** check box.
4. If the computer is a domain controller, click to select the **File and Printer Sharing for Microsoft Networks** check box.

    > [!NOTE]
    > On multi-homed Remote Access servers and ISA Server-based servers, you can disable the File and Printer Sharing for Microsoft Networks component for the network adaptor that is connected to the Internet. However, the Client for Microsoft Networks component must be enabled for all the server's network adaptors.
5. Select **Internet Protocol (TCP/IP)**, and then select **Properties**.
6. If **Use the following DNS server addresses** is selected, make sure that the IP addresses for the preferred and alternate DNS servers are the IP addresses of DNS servers that can resolve SRV records and host names in Active Directory. Specifically, the computer mustn't use the DNS servers that belong to your ISP. If the DNS server addresses aren't correct, type the IP addresses of the correct DNS servers in the **Preferred DNS server** and **Alternate DNS server** boxes.
7. Select **Advanced**, and then select the **DNS** tab.
8. Click to select the **Register this connection's addresses in DNS** check box, and then select **OK** three times.
9. Start a command prompt. To do it, select **Start**, select **Run**, type cmd, and then select **OK**.
10. Type **ipconfig /flushdns**, and then press **ENTER**. Type **ipconfig /registerdns**, and then press **ENTER**.
11. Restart the computer for your changes to take effect.

If the client computers in your network are configured to obtain their IP addresses automatically, make sure that the computer that is running the DHCP service assigns the IP addresses of DNS servers that can resolve SRV records and host names in the Active Directory.

To determine what IP addresses a computer is using for DNS, follow these steps:

1. Start a command prompt. To do this, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
2. Type **ipconfig /all**, and then press **ENTER**.
3. Note the DNS entries that are listed on the screen.

If computers that are configured to obtain IP addresses automatically aren't using the correct DNS servers, view the documentation for your DHCP server for information about how to configure the DNS servers option. Additionally, make sure that each computer can resolve the IP address of the domain. To do it, type ping **Your_Domain_Name**.**Your_Domain_Root** at a command prompt, and then press **ENTER**. Instead, type nslookup **Your_Domain_Name**.**Your_Domain_Root**, and then press **ENTER**.

> [!NOTE]
> It's expected that this host name will resolve to the IP address of one of the domain controllers on the network. If the computer can't resolve this name, or if the name resolves to the wrong IP address, make sure that the forward lookup zone for the domain contains valid **(same as parent folder)** Host (A) records.

To make sure that the forward lookup zone for the domain contains valid **(same as parent folder)** Host (A) records on a Windows 2000-based computer, follow these steps:

1. On a domain controller that is running DNS, select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **DNS**.
2. Expand **Your_Server_Name**, expand **Forward Lookup Zones**, and then select the forward lookup zone for your domain.
3. Look for **(same as parent folder)** Host (A) records.
4. If a **(same as parent folder)** Host (A) record doesn't exist, follow these steps to create one:
    1. On the **Action** menu, select **New Host**.
    2. In the **IP address** box, type the IP address of the domain controller's local network adaptor.
    3. Click to select the **Create associated pointer (PTR) record** check box, and then select **Add Host**.
    4. When you receive the following message, select
    **Yes**:
        > **(same as parent folder)** is not a valid host name. Are you sure you want to add this record?

5. Double-click the **(same as parent folder)** Host (A) record.
6. Verify that the correct IP address is listed in the **IP address** box.
7. If the IP address in the **IP address** box isn't valid, type the correct IP address in the **IP address** box, and then select **OK**.
8. Instead, you can delete the **(same as parent folder)** Host (A) record that contains an IP address that isn't valid. To delete the **(same as parent folder)** Host (A) record, right-click it, and then select **Delete**.
9. If the DNS server is a domain controller that is also a Routing and Remote Access server, see [Name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS](https://support.microsoft.com/help/292822).
10. On all computers where you add, delete, or modify DNS records, type **ipconfig /flushdns** at a command prompt, and then press **ENTER**.

To make sure that the forward lookup zone for the domain contains valid **(same as parent folder)** Host (A) records on a Windows Server 2003-based computer, follow these steps:

1. On a domain controller that is running DNS, select **Start**, point to **Administrative Tools**, and then select **DNS**.
2. Expand **Your_Server_Name**, expand **Forward Lookup Zones**, and then select the forward lookup zone for your domain.
3. Look for the **(same as parent folder)** Host (A) record.
4. If the **(same as parent folder)** Host (A) record doesn't exist, follow these steps to create one:
    1. On the **Action** menu, select **New Host (A)**.
    2. In the **IP address** box, type the IP address of the domain controller's local network adaptor.
    3. Click to select the **Create associated pointer (PTR) record** check box, and then select **Add Host**.
    4. When you receive the following message, select
    **Yes**:
        > **(same as parent folder)** is not a valid host name. Are you sure you want to add this record?

5. Double-click the **(same as parent folder)** Host (A) record.
6. Verify that the correct IP address is listed in the **IP address** box.
7. If the IP address is in the **IP address** box isn't valid, type the correct IP address in the **IP address** box, and then select **OK**.
8. Instead, you can delete the **(same as parent folder)** Host (A) record that contains the IP address that isn't valid. To delete the Host (A) record, right-click **(same as parent folder)**, and then select **Delete**.
9. If the DNS server is a domain controller that is also a Routing and Remote Access server, see [Name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS](https://support.microsoft.com/help/292822).
10. On all computers where you add, delete, or modify DNS records, type **ipconfig /flushdns** at a command prompt, and then press **ENTER**.

### Step 2: Examine the Server Message Block signing settings on the client computers and member servers

The Server Message Block (SMB) signing settings define whether the computers on the network digitally sign communications. If the SMB signing settings aren't configured correctly, the client computers, or the member servers, may not be able to connect to the domain controllers.

For example, SMB signing may be required by the domain controllers, but SMB signing may be disabled on the client computers. If this issue occurs, Group Policy can't be applied correctly. So the client computers log user environment (Userenv) errors in the Application log.
Sometimes, the SMB signing settings for the Server service and the Workstation service on a domain controller may conflict with each other.

For example, SMB signing may be disabled for the domain controller's Workstation service, but SMB signing is required for the domain controller's Server service. In this scenario, you can't open one or more of the domain controller's local file shares if you're logged on to the server. Additionally, you can't open Group Policy snap-ins if you're logged on to the server.  
For more information about how to troubleshoot this problem on a domain controller, see [You cannot open file shares or Group Policy snap-ins on a domain controller](../networking/cannot-open-file-shares-group-policy-snap-ins.md).

If Group Policy errors only occur on client computers and member servers, or if you determine that [You cannot open file shares or Group Policy snap-ins on a domain controller](../networking/cannot-open-file-shares-group-policy-snap-ins.md) doesn't apply to your situation, continue to troubleshoot the issue.

By default, SMB signing is enabled but isn't required for client communication on client computers and member servers that are running Windows XP, Windows 2000, or Windows Server 2003. We recommend that you use the default configuration because the client computers can use SMB signing when it's possible, but will still communicate with servers that have SMB signing disabled.

To configure the client computers and member servers so that SMB signing is enabled but not required, you must change the values for some registry entries. To make the registry changes on the client computers, follow these steps:

1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
2. Expand the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters`
3. In the right pane, right-click **enablesecuritysignature**, and then select **Modify**.
4. In the **Value data** box, type 0, and then select **OK**.
5. Right-click **requiresecuritysignature**, and then select **Modify**.
6. In the **Value data** box, type 0, and then select **OK**.
7. Expand the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanworkstation\parameters`
8. In the right pane, right-click **enablesecuritysignature**, and then select **Modify**.
9. In the **Value data** box, type 1, and then select **OK**.
10. Right-click **requiresecuritysignature**, and then select **Modify**.
11. In the **Value data** box, type 0, and then select **OK**.

After you change the registry values, restart the Server and Workstation services. Don't restart the computers because it may cause group policies to be applied, and the Group Policy settings may configure conflicting values again.

After you change the registry values and restart the Server and Workstation services on the affected computers, follow these steps:

1. View the Group Policy settings for the GPO or GPOs that apply to the affected computer accounts.
2. Make sure that the group policies don't conflict with the required registry settings.
3. Use the Group Policy Object Editor to view the policy settings in the following folder:
    `Computer Configuration/Windows Settings/Security Settings/Local Policies/Security Options`

On a computer that is running Windows Server 2003, the SMB signing Group Policy settings have the following names:

- Microsoft network server: Digitally sign communications (always)
- Microsoft network server: Digitally sign communications (if client agrees)
- Microsoft network client: Digitally sign communications (always)
- Microsoft network client: Digitally sign communications (if server agrees)

On a computer that is running Windows 2000 Server, the SMB signing Group Policy settings have the following names:

- Digitally sign server communication (always)
- Digitally sign server communication (when possible)
- Digitally sign client communications (always)
- Digitally sign client communications (when possible)

Typically, the SMB signing Group Policy settings are configured as "Not Defined". If you define the SMB signing Group Policy settings, make sure that you understand how the settings may affect network connectivity.  
For more information about the SMB signing settings, see [Client, service, and program issues can occur if you change security settings and user rights assignments](https://support.microsoft.com/help/823659).

If you change the GPO settings on a domain controller that is running Windows 2000 Server, follow these steps:

1. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
2. Type **secedit /refreshpolicy machine_policy /enforce**, and then press **ENTER**.
3. Restart the affected client computers.
4. Recheck the SMB signing values in the registry on the client computers to make sure that they didn't change unexpectedly.

If you change the GPO settings on a domain controller that is running Windows Server 2003, follow these steps:

1. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select
 **OK**.
2. Type **gpupdate /force**, and then press **ENTER**.
3. Restart the affected client computers.
4. Recheck the SMB signing values in the registry on the client computers to make sure that they did not change unexpectedly.

If the SMB signing values in the registry change unexpectedly after you restart the client computers, use one of the following methods to view the applied policy settings that are applied to a client computer:

- On a Windows XP-based computer, use the Resultant Set of Policy MMC snap-in (Rsop.msc). For more information about Resultant Set of Policy, see [Resultant Set of Policy](/previous-versions/windows/it-pro/windows-server-2003/cc775741(v=ws.10)).

- On Windows 2000, use the Gpresult.exe command-line tool to examine the Group Policy results. To do it, follow these steps:
    1. Install Gpresult.exe from the Windows 2000 Resource Kit.

    2. At a command prompt, type **gpresult /scope computer**, and then press **ENTER**.
    3. In the Applied Group Policy Objects section of the output, note the Group Policy objects that are applied to the computer account.
    4. Compare the Group Policy objects that are applied to the computer account that has the SMB signing policy settings on the domain controller for these Group Policy objects.

### Step 3: Make sure that the TCP/IP NetBIOS Helper service is started on all computers

All computers on the network must run the TCP/IP NetBIOS Helper service.

To verify that the TCP/IP NetBIOS Helper service is running on a Windows XP-based computer, follow these steps:

1. Select **Start**, and then select **Control Panel**.
2. If Control Panel is in Category View, select **Switch to Classic View**.
3. Double-click **Administrative Tools**.
4. Double-click **Services**.
5. In the **Services** list, select **TCP/IP NetBIOS Helper**. Verify that the value under the **Status** column is **Started**. Verify that the value under the **Startup Type** column is **Automatic**. If the **Status** or the **Startup Type** values aren't correct, follow these steps:
    1. Right-click **TCP/IP NetBIOS Helper**, and then select **Properties**.
    2. In the **Startup type** list, select **Automatic**.
    3. In the **Service status** area, if the service isn't started, select **Start**.
    4. Select **OK**.

To verify that the TCP/IP NetBIOS Helper service is running on a Windows Server 2003-based computer, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Services**.
2. In the **Services** list, select **TCP/IP NetBIOS Helper**. Verify that the value under the **Status** column is **Started**. Verify that the value under the **Startup Type** column is **Automatic**. If the **Status** or the **Startup Type** values aren't correct, follow these steps:
    1. Right-click **TCP/IP NetBIOS Helper**, and then select **Properties**.
    2. In the **Startup type** list, select **Automatic**.
    3. In the **Service status** area, if the service isn't started, select **Start**.
    4. Select **OK**.

To verify that the TCP/IP NetBIOS Helper service is running on a Windows 2000-based computer, follow these steps:

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Services**.
2. In the **Services** list, select **TCP/IP NetBIOS Helper Service**. Verify that the value under the **Status** column is **Started**. Verify that the value under the **Startup Type** column is **Automatic**. If the **Status** or the **Startup Type** values aren't correct, follow these steps:
    1. Right-click **TCP/IP NetBIOS Helper Service**, and then select **Properties**.
    2. In the **Startup type** list, select **Automatic**.
    3. In the **Service status** area, if the service isn't started, select **Start**.
    4. Select **OK**.

Additionally, make sure that you haven't disabled one or more of the required system services by using Group Policy objects. View these policy settings by using the Group Policy Object Editor in the `Computer Configuration/Windows Settings/Security Settings/System Services` folder.

On Windows Server 2003 and Windows XP, you can use the Resultant Set of Policy MMC snap-in (Rsop.msc) to check all applied policy settings that are applied to a computer. To do it, select **Start**, select **Run**, type rsop.msc in the **Open** box, and then select **OK**.

On Windows 2000, use the Gpresult.exe command-line tool to examine the Group Policy results. To do it, follow these steps:

1. Install Gpresult.exe from the Windows 2000 Resource Kit.
2. At a command prompt, type **gpresult /scope computer**, and then press **ENTER**.
3. In the Applied Group Policy Objects section of the output, note the Group Policy objects that are applied to the computer account.
4. Compare the Group Policy objects that are applied to the computer account with the SMB signing policy settings on the domain controller for these Group Policy objects.

> [!NOTE]
> If the TCP/IP NetBIOS Helper service is disabled on many desktops, you can use the following sample Microsoft Visual Basic script to start the TCP/IP NetBIOS Helper service on all computers in an organizational unit (OU) at the same time.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

```vb
Set objDictionary = CreateObject("Scripting.Dictionary") 
i = 0
Set objOU = GetObject("LDAP://OU=Computers, OU=OUName, OU=OUName, DC=OUName,
DC=OUName,DC=CompanyName,
DC=com")
objOU.Filter = Array("Computer")
For Each objComputer In objOU
        objDictionary.Add i, objComputer.CN
        i = i + 1
Next
For Each objItem In objDictionary
        strComputer = objDictionary.Item(objItem)
        Set objWMIService =
GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer &
"\root\cimv2")

        Set colServices = objWMIService.ExecQuery _
                ("Select * from Win32_Service where Name = 'LmHosts'")
        For Each objService In colServices
                If objService.StartMode = "Disabled" Then
                        objService.Change( , , , , "Automatic")
                End If
        Next
Next
```

### Step 4: Make sure that Distributed File System (DFS) is enabled on all computers

All domain controllers must run the Distributed File System service because the Sysvol share is a DFS volume. Additionally, the DFS client must be enabled in the registry on all computers.

To make sure that the Distributed File System service is running on Windows Server 2003-based domain controllers, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Services**.
2. In the **Services** list, select **Distributed File System** service. Verify that the value under the **Status** column is **Started**. Verify that the value under the **Startup Type** column is **Automatic**. If the **Status** or the **Startup Type** values aren't correct, follow these steps:
    1. Right-click **Distributed File System**, and then select **Properties**.
    2. In the **Startup type** list, select **Automatic**.
    3. In the **Service status** area, if the service isn't started, select **Start**.
    4. Select **OK**.

To make sure that the **Distributed File System** service is running on Windows 2000 Server-based domain controllers, follow these steps:

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Services**.
2. In the **Services** list, select **Distributed File System** service. Verify that the value under the **Status** column is **Started**. Verify that the value under the **Startup Type** column is **Automatic**. If the **Status** or the **Startup Type** values aren't correct, follow these steps:
    1. Right-click **Distributed File System**, and then select **Properties**.
    2. In the **Startup type** list, select **Automatic**.
    3. In the **Service status** area, if the service isn't started, select **Start**.
    4. Select **OK**.

To make sure that the Distributed File System client is enabled on all client computers, follow these steps:

1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
2. Expand the following subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Mup`
3. Select **Mup**, and then in the right pane, search for a DWORD value entry that is named **DisableDFS**.
4. If the **DisableDFS** entry exists and the value data is **1**, double-click **DisableDFS**. In the **Value data** box, type 0, and then select **OK**. If the DisableDFS value data is already **0**, or if the **DisableDFS** entry doesn't exist, don't make any change.
5. Quit Registry Editor.
6. If you changed the **DisableDFS** value data, restart the computer.

### Step 5: Examine the contents and the permissions of the Sysvol folder

By default, the Sysvol folder is located in the `%systemroot%` folder. The Sysvol folder contains the domain's Group Policy objects, the Sysvol and Netlogon shares, and the File Replication service (FRS) staging folder.

If the permissions on the Sysvol folder or the Sysvol share are too restrictive, group policies can't be applied correctly, and cause user environment (Userenv) errors. Additionally, Userenv errors may occur if the Sysvol share or Group Policy objects are missing.  
To make sure that the Sysvol share is available, run the net share command at a command prompt on each domain controller. To do it, follow these steps:

1. Select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
2. Type **net share**, and then press **ENTER**.
3. Locate **SYSVOL** and **NETLOGON** in the list of folders.

If the Sysvol or Netlogon shares are missing from one or more domain controllers, you must troubleshoot the cause of the problem.  
For more information about how to troubleshoot the missing Sysvol and Netlogon shares in Windows 2000 Server, see [Troubleshooting missing SYSVOL and NETLOGON shares on Windows domain controllers](https://support.microsoft.com/help/257338).

For more information about how to rebuild the Sysvol share in Windows Server 2003, see [How to rebuild the SYSVOL tree and its content in a domain](https://support.microsoft.com/help/315457).

After you make sure that the Sysvol share is available, make sure that the Sysvol folder, the Sysvol share, and the root folder of the volume that contains the Sysvol folder are configured with the correct permissions.

Additionally, on Windows 2000 Server, the Everyone group must be granted Full Control permission on the root folder of the volume that contains the Sysvol folder. On Windows Server 2003, the Everyone group must be granted the Read & Execute special permission to "This folder only," and the domain\Users group must be granted the following standard permissions:

- Read & Execute
- List Folder Contents
- Read

Additionally, on Windows Server 2003, the domain\Users group must have the following special permissions:

- Read & Execute permission to "This folder, subfolders and files."
- Create Folder / Append Data permission to "This folder and subfolders."
- Create Files / Write Data permission to "Subfolders only."

After you verify the Sysvol permissions, make sure that the Sysvol folder contains the required Group Policy objects. To look for the required Group Policy objects, use the Gpotool.exe program from the Windows 2000 or the Windows Server 2003 Resource Kit.

If you run the Gpotool.exe program without any options, it scans for all the Group Policy objects on all domain controllers in the domain. If you include the `/checkacl` switch, the tool also scans the Sysvol access control list (ACL). For detailed output when you run the Gpotool.exe program, use the `/verbose` switch.

Instead, you can manually verify the individual GPO in the SYSVOL folder. For example, if the description in the Userenv 1058 event lists the name of a GPO, you can manually verify the individual GPO in the SYSVOL folder. You can do this to make sure that it contains a USER folder, a MACHINE folder, and a Gpt.ini file. To manually verify the individual GPO in the SYSVOL folder, follow these steps:

1. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
2. Type at **Time**/interactive/next: cmd.exe, and then press **ENTER**, where **Time** is 1 or 2 minutes later than the present time, and is written in 24-hour time format. For example, 3 minutes after 1:00 p.m. would be 13:03 in 24-hour time format.
3. At the time that you specify in the previous command, a new Command Prompt window opens. Type net use j:\\\\domainname.com\sysvol\domainname.com\Policies\\{**GUID**}, and then press **ENTER**, where **GUID** is the GUID of the GPO that is in the Userenv event description. For example, if the Userenv 1058 event description says, "The file must be present at the location <\\\\**Domain_Name**.com\sysvol\\**Domain_Name**.com\Policies\\{31B2F340-016D-11D2-945F-00C04FB984 F9}\gpt.ini>," the GUID that you would use in the command is 31B2F340-016D-11D2-945F-00C04FB984F9.
4. Type dir j:\\\*.*, and then press **ENTER**.
5. Verify that a USER folder, a MACHINE folder, and a Gpt.ini file are listed in the folder listing for the I drive. If any one of these folders and files are missing, the computers on the network are likely to log Userenv errors in the Application log.

If one or more Group Policy objects are missing from the Sysvol folder, run the Windows Server 2003 Default Group Policy Restore Utility (Dcgpofix.exe), or the Windows 2000 Default Group Policy Restore Tool (Recreatedefpol.exe), to re-create the default Group Policy objects.

The Dcgpofix.exe program is included with Windows Server 2003. For additional information about the Dcgpofix.exe program, run the `dcgpofix /?` command at a command prompt.

Make sure to set the recommended exclusions when you're scanning the Sysvol drive with antivirus software. Scanning with antivirus software can block access to the required files, such as the Gpt.ini file. You must configure these exclusions for all real-time, scheduled, and manual antivirus scans.

### Step 6: Make sure that the Bypass traverse checking right is granted to the required groups

The Bypass traverse checking right must be granted to the following groups on the domain controllers:

- Administrators
- Authenticated Users
- Everyone
- Pre-Windows 2000 Compatible Access

To verify that the Bypass traverse checking right has been granted on a Windows Server 2003-based domain controller, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Domain Controller Security Policy**.
2. Expand **Local Policies**, and then select **User Rights Assignment**.
3. Double-click **Bypass traverse checking**.
4. Click to select the **Define these policy settings** check box.
5. Verify that the Administrators, Authenticated Users, Everyone, and Pre-Windows 2000 Compatible Access groups are listed for this policy setting. If any of these groups are missing, follow these steps:
    1. Select **Add User or Group**.
    2. In the **User and group names** box, type the name of the missing group, and then select **OK**.
6. Select **OK** to close the policy setting.
7. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
8. Type **gpupdate /force**, and then press **ENTER**.

To verify that the Bypass traverse checking right has been granted on a Windows 2000 Server-based domain controller, follow these steps:

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Domain Controller Security Policy**.
2. Expand **Security Settings**, expand **Local Policies**, and then select **User Rights Assignment**.
3. Double-click **Bypass traverse checking**.
4. Click to select the **Define these policy settings** check box.
5. Verify that the Administrators, Authenticated Users, Everyone, and Pre-Windows 2000 Compatible Access groups are listed for this policy setting. If any one of these groups are missing, follow these steps:
    1. Select **Add**.
    2. In the **User and group names** box, type the name of the missing group, and then select **OK**.
6. Select **OK** to close the policy setting.
7. Start a command prompt. To do it, select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK**.
8. Type **secedit /refreshpolicy machine_policy /enforce**, and then press select.

### Step 7: Make sure that the domain controllers aren't in a journal wrap state

To see if a domain controller is in a journal wrap state, view the File Replication service log in Event Viewer, and search for NTFRS event ID 13568. Event ID 13568 is similar to the following Event ID:  
If NTFRS event ID 13568 is logged on a domain controller, for more information about how to troubleshoot journal wrap errors, see [How to troubleshoot journal_wrap errors on Sysvol and DFS replica sets](../networking/how-frs-uses-usn-change-journal-ntfs-file-system.md).

### Step 8: Run the Dfsutil /PurgeMupCache command

Run the Dfsutil.exe program with the `/PurgeMupCache` switch to flush the local DFS/MUP cached information. The Dfsutil.exe program is included in the Windows 2000 Server Support Tools and the Windows Server 2003 Support Tools.
