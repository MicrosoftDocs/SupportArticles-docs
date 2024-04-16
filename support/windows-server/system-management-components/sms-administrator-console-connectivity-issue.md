---
title: Troubleshoot SMS Administrator console connectivity
description: Discusses how to troubleshoot a new or an existing SMS Administrator console to determine why it cannot connect to the site server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jarrettr
ms.custom: sap:System Management Components\Microsoft Management Console (MMC), csstroubleshoot
---
# How to troubleshoot SMS Administrator console connectivity

This article describes how to troubleshoot a new or an existing SMS Administrator console to determine why it cannot connect to the site server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 317872

## Summary

If you are using SMS and you try to connect to the site server, you may receive a "Connection Failed" message. Or, the nodes may not be displayed after you are connected. Additionally, errors that are similar to the following may be logged in the AdminUI.log file on the server:
> Error: Possible UI connection error code is -2147023174 [0x800706ba]

> Error: Possible UI connection error code is -2146959355 [0x80080005]

> Error: Possible UI connection error code is -2147217394

> Error: Possible UI connection error code is -2147217389[0x80041013] Failed to execute method GetProviderVersion! Function GetProviderVersion returns empty string of ProviderVersion. Wbem call failed: T_WbemSyncEnumToContainer_Core, return code: -2147217389 We fail to get the ProviderVersion. SiteCode - SiteServerName, Provider Version: Failed to set the connection. error code: -2147217389

> Error(ConnectServer): Possible UI connection error code is -2147024891

> Error: Possible UI connection error code is -2147024891 [0x80070005]

> [994][\<date> \<time>]: Error(CheckForDisconnect2): Invalid service pointer. WMI connection has been dropped. : -2147024891 [0x80070005]

## More information

### How to grant access to the SMS Administrator console

In order to access a local or remote SMS Administrator console, users must be members of the SMS Admins local group. The SMS Admins group is explicitly granted Enable Account and Remote Enable on the Root\SMS namespace. The SMS Admins group provides its members with access to the SMS Provider, through WMI. Add Users to the SMS Admins group when they need to access the SMS Administrator console, but do not have to be Local Administrators. If you want to use a different local group to grant,  access to the SMS Administrator console, you must also grant that local or domain local group the same WMI permission as the SMS Admins group. To grant access to the SMS Administrator console, follow these steps:

1. Create a global group for the domain that contains users who require specific access to the SMS Administrator console.
2. Add this global group or the explicit domain user account to the local SMS Admins group.
3. Configure the SMS permissions for the global group that you created.

      > [!NOTE]
      >  
      > - To complete this step, you must be an administrator and have full permissions on the site.
      > - If you can connect to the database but if the nodes are not enumerated, examine the SMS permissions that are granted to the global group or to a specific user in the Security node of the SMS Administrator console. For example, determine whether the collections node, the packages node, or other nodes display any content.

    The permissions that you grant depend on the functionality that you want the members of this global group to perform. To grant permissions, right-click the Security rights node in the SMS Administrator console, point to All tasks , and then click Manage SMS Users to start the Security Wizard.

4. Use the wizard to add, remove, or modify the security settings of users and of groups.

### How to troubleshoot SMS Administrator console connectivity

If you are testing a remote SMS Administrator console, make sure that the latest SMS service pack has been applied to this console. If the service pack has not been applied, an error that is similar to the following may be logged in the AdminUI.log file:
> CLASS_SMS_ContextMethods, METHOD_GetContextHandle! Failed to set the connection. error code: -2147217407 Run the Setup program from the service pack source to determine whether the SMS Administrator console is the only component that must be upgraded.

To troubleshoot SMS Administrator console connectivity, consider the following issues:

- Is the SMS site server running Microsoft Windows Server 2003 with Service Pack 1 (SP1)?

    In Windows Server 2003 with SP1, a new local group is created that is named Distributed COM Users. To resolve the connectivity issue in Windows Server 2003 Service Pack 1, add the users who are trying to make remote connections to the SMS Administrator console to the Distributed COM Users local group.

- Is the user a member of a global group that is a member in the SMS Admins group, or is the user explicitly defined in the SMS Admins Group?

    The SMS Admins group is created during the SMS site installation. If a site was installed on a member server, the SMS Admins group is a local group in the local Security Accounts Manager (SAM). If a site server is a domain controller, the SMS Admins group is a local group in the domain. The user must belong to the SMS Admins group because this group is granted the necessary permissions to the SMS and SMS_site code namespace in the Windows Management Instrumentation (WMI) repository when the SMS site is built.
- Has this server had a previous installation of SMS?

    If the server has had a previous installation of SMS, there may be multiple site codes in the SMS_ProviderLocation class that is located in the site server's SMS namespace. Delete any site code that no longer exists on the site server. You can use the WBEMtest tool to view the SMS_ProverLocation class.
- On the site server, confirm property settings that are defined in the Dcomcnfg.exe utility.

    To view the properties that are defined in the Dcomcnfg.exe utility, click the Default properties tab, and then confirm the following settings:

  1. The **Enable Distributed COM on this computer** check box is selected.
  2. The Default Authentication level is set to Connect.
  3. The Default Impersonation level is set to Identify.

- If you are testing a remote SMS Administrator console, make sure that the latest SMS service pack has been applied to this console.

    Run the Setup program from the service pack source to determine whether the SMS Administrator console is the only component that must be upgraded.

After you consider these issues, complete the troubleshooting procedures that are described in the following sections.

#### Troubleshooting SMS namespace connectivity

Make sure that the user can connect to the SMS namespace and the SMS_'sitecode' namespaces. To do this, follow these steps:

1. Click **Start**, click **Run**, and then type *wbemtest*.
2. Click **Connect**, type *\\\\siteserver\\root\\sms*, and then click **Login**.
3. Click **Enum Classes**, click **Recursive**, and then click **OK**.
4. In the **Query Result** list, double-click **SMS_ProviderLocation**.
5. Click **Instances**, and then double-click the line that contains the target site code. For example, SMS_ProviderLocation.SiteCode="**xxx**."
6. In the **Properties** section, locate the NamespacePath line. You may have to double-click this line to see the whole line.
7. Copy the NamespacePath value to the clipboard. For example, copy the following value:\\\\ **server_name**\\root\\sms\\site_**xxx**.  

If you successfully complete this procedure, you can connect to the site server and enumerate the SMS namespace.

#### How to troubleshoot server connectivity

Determine whether you can connect to the server that the provider is located on. The server is defined in the NamespacePath value that you determined in the "How to troubleshoot SMS namespace connectivity" section. Typically, this server is the same server.

1. Close all WBEMtest windows that may be open.
2. Click **Connect**, paste the NamespacePath that you copied in step 7, and then click **Login**.
3. Click **Enum Classes**, click **Recursive**, and then click **OK**.
4. In the **Query Result** list, double-click **SMS_Site**.

If you receive an "access denied" error message when you perform this procedure, this may be because of one of the following causes:

1. The Security Configuration Wizard has been run on the server that hosts the SMS Provider. However, the Security Configuration Wizard is unable to recognize the SMS Provider. If you run the wizard on the server that has the SMS Provider installed, you must enable the **Remote WMI** service in the wizard. Unless you enable **Remote WMI**, the SMS Administrator console on the site server and any other remote consoles cannot connect to the SMS namespace in WMI. To enable Remote WMI in the wizard, do the following:

    Select **Remote WMI** on the **Select Administration and Other Options** page of the Security Configuration Wizard.

    > [!NOTE]
    > For more information about how to secure SMS site systems, visit the following Microsoft Web site: [https://technet.microsoft.com/library/cc179764.aspx](https://technet.microsoft.com/library/cc179764.aspx)

2. The account that is used does not have the appropriate permissions to the namespace of the provider. To modify or to verify the permissions, follow these steps:
   1. On the server on which you enumerated the SMS site, click **Start**, click **Run**, type *wmimgmt.msc*, and then click **OK**.
   2. Right-click **WMI Control**, and then click **Properties**.
   3. On the **Security** tab, expand **Root**, and then click **SMS**.
   4. Click **Security** in the results pane to see the permissions.
   5. Click **Advanced**, click **SMS Admins**, and then click **View-edit**.

      For the SMS namespace, the SMS Admins group must have the following permissions:
      - Enable account
      - Remote enable
   6. Repeat steps a through e to examine the SMS Admins group for the SMS_ **xxx** namespace. (**xxx** is a placeholder for the site code.) Then, grant **Remote Enable** permission to the user or to the group. If the user or the group does not have appropriate WMI permissions in Security for the SMS namespace, the following event may be logged in the AdminUI.log file:

### Other security issues

Use the troubleshooting procedures that are described in this section if any one of the following conditions is true:

- Users are still denied access when they try to connect to the console after you have granted the appropriate accounts the "Remote Enable" right in WMI security.
- The console is only partially available.

#### Verify the Windows Firewall configuration

Windows XP SP2 and Windows Server 2003 SP1 include the Windows Firewall feature. If you run the **SMS Administrator Console** on a Windows XP SP2-based or a Windows Server 2003 SP1-based computer that has the firewall enabled, you must enable the Unsecapp.exe program and TCP port 135 to pass through the Windows Firewall. To do this, follow these steps:

1. Click **Start**, click **Run**, type *firewall.cpl*, and then click **OK**.
2. On the **General** tab, click **On** to turn on the firewall. Click to clear the **Don't allow exceptions** check box.

3. On the **Exceptions** tab, click **Add Program**.

4. Click **Browse**, type *%windir%\\System32\\Wbem\\Unsecapp.exe* in the **File name** box, and then click **Open**. If you have to define the scope, click **Change scope**, and then click **OK**. Click **OK** to close the **Add a Program** dialog box.
5. In the **Programs and Services** list, click to select the **Unsecapp.exe** check box.

6. Click **Add Port**.

7. In the **Port number** box, type *135*. Select **TCP**, and then type a name for the exception in the **Name** box. If you have to define the scope, click **Change scope**, and then click **OK**. Click **OK** to close the **Add Port** dialog box.
8. In the **Programs and Services** list, click to select the check box for the exception that you added in step 7.

9. Click **OK**.

#### Check DCOM security settings

> [!WARNING]
> Do not make these changes unless you cannot resolve this issue by adding the Unsecapp.exe program and TCP port 135 to the exceptions list.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

You may not resolve this issue by adding these exceptions to Windows Firewall. You may have to set anonymous remote permissions in DCOM for the client computer. To do this on the Windows XP SP2-based computer that is running the SMS Administrator console, follow these steps:

1. Click **Start**, click **Run**, type *dcomcnfg.exe*, and then click **OK**.
2. Locate the Console root node, expand **Component Services**, expand **Computers**, and then click **My Computer**.

3. Right-click **My Computer**, and then click **Properties**.

4. In **My Computer Properties**, click the **COM Security** tab.

5. In **Access Permissions**, click **Edit Limits**.

6. Click **ANONYMOUS LOGON**.

7. In **Permissions for ANONYMOUS LOGON**, click **Allow setting for Remote Access**.

8. Click **OK** two times.

9. Restart your computer.

##### Determine whether the default DCOM permissions have been changed

Check for the DefaultAccessPermission value under the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole`.

This indicates the default DCOM permissions have been changed. If this value does not exist, the default DCOM permissions are in effect. To resolve this problem, delete the DefaultAccessPermission value. This will reset all default DCOM permissions. This is a measure of last resort and is not guaranteed to correct the problem.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
> [!IMPORTANT]
> Before you delete this value, make sure that you have tried to resolve the issue by following the DCOM troubleshooting steps in in this article. Also, back up the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole` registry subkey.

To delete the DefaultAccessPermission value, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole`.

3. In the right pane, right-click **DefaultAccessPermission**, and then click **Delete**.
4. In the **Confirm Value Delete** dialog box, click **Yes**.
5. Exit Registry Editor.
6. Log off from the computer, and then log back on to the computer.  

#### Include the Anonymous Logon security group in the Everyone security group

If the procedures that are previously described do not resolve the permissions issue for the SMS Administrator console, it may be difficult to do the following:

- Determine which resource requires anonymous access on the computer that is running Windows XP.
- Modify the permissions on all the necessary resourcesIn these situations, you may have to force the computer that is running Windows XP to include the Anonymous Logon security group in the Everyone security group. To support this functionality, Windows XP includes the EveryoneIncludesAnonymous registry entry.

If the EveryoneIncludesAnonymous registry entry is set to REG_DWORD 0x1, the Local Security Authority (LSA) includes the security identifier (SID) of the Everyone security group in the anonymous user's access token. To set the value of the EveryoneIncludesAnonymous registry entry, use either of the following methods.

### Method 1: Set the EveryoneIncludesAnonymous registry entry by using local security settings

1. Click **Start**, click **Run**, type *Control admintools*, and then click **OK**.
2. Double-click either **Local Security Policy** or **Domain Security Policy (on domain controllers only)**.

3. Double-click **Local Policies**, and then click **Security Options**.

4. Right-click **Network access: Let Everyone permissions apply to anonymous users**, and then click **Properties**.

5. To enable anonymous users to be members of the Everyone security group, click **Enabled**. To prevent the inclusion of the Everyone security group SID in the anonymous user's access token, click **Disabled**. This is the default setting in Windows XP.

### Method 2: Set the EveryoneIncludesAnonymous registry value by using Registry Editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.

2. Locate and then click the following registry key:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`.  

3. Right-click **EveryoneIncludesAnonymous**, and then click **Modify**.

4. To enable anonymous users to be members of the Everyone security group, type *1* in the **Value data** box. To prevent the inclusion of the Everyone security group SID in the anonymous user's access token, type *0* in the **Value data** box. By default, the EveryoneIncludesAnonymous value is set to 0 in Windows XP.
5. Exit Registry Editor.

6. Restart the computer.

> [!NOTE]
> This change can affect the following Windows-based technologies:
>
> - Com
> - Dcom
> - IIS
> - Message Queuing
> - Any other technology where anonymous authentication is frequently employed.

### Additional connectivity tests

Start the WMI Control on the site server. Do not start the WMI control on the provider server if this server is different. Click the Logging tab, and then set the logging level to Verbose to increase the logging to the **Windows_folder**\\System32\\Wbem\\Logs\\Wbemcore.log file.

Analyze this log on the site server. You see all the WMI traffic that is generated. Look for the query for SMS_Providerlocation that occurred when an SMS Administrator console tried to connect. If this query is present, you can confirm that there is communication between the console and the site server. Test connectivity from the site server back to the requesting SMS Administrator console. Connectivity may not exist in the following scenarios:

- The remote procedure call (RPC) server is unavailable.

- There is a DNS name resolution issue.
The "Connection Failed "error message may also occur if name resolution is not completed correctly. To determine whether you are experiencing a name resolution issue, use the WBEMtest tool and try to connect to the site server by using the IP address. For example, use \\111.222.333.444\\root\\default as the address. If you can connect when you use the IP address, but you cannot connect when you use the netBIOS name of the site server, you are experiencing a name resolution issue. To resolve this issue, confirm either the WINS or the DNS configurations.

When you expand nodes in a remote SMS Administrator Console, the SMS site server makes a DCOM connection to the computer on which the console is installed. If an invalid DNS record exists for the computer on which the console is installed, the SMS site server may try to connect to the wrong IP address. When this occurs, the console node will fail to expand, and the console computer will log the "WMI connection has been dropped" error in the AdminUI.log. To troubleshoot this, run the `nslookup <console_computer_name>` command to make sure that the name resolves to the correct IP address. If an invalid DNS registration exists for the console computer, remove the invalid DNS registration. Additionally, determine how the invalid DNS registration was created to prevent it from happening again. For example, the console computer may have registered a VPN address, but the VPN address was not removed from DNS when the VPN was disconnected. After you resolve the DNS issue, run the following command at a command prompt on the SMS 2003 site server: `ipconfig /flushdns`.

If you cannot resolve the fully qualified domain name of the Windows XP SP2-based computer by using DNS, create an entry in the hosts file on the SMS 2003 site server to map the Windows XP SP2-based computer's fully qualified domain name to its IP address.

#### Known issues with Microsoft ISA server or Checkpoint VPN software

If you cannot expand some nodes on a remote console over a remote connection from a Windows 2003 SP1 computer, Remote Procedure Call-based operations may fail if certain firewall and VPN products deny network requests. These network requests may fail on computers where you apply Windows Server 2003 Service Pack 1 (SP1) to a Windows Server 2003-based computer or your OEM or retail installation media includes SP1 updates. The following products may deny these network requests:

- Firewall or virtual private network (VPN) products from Checkpoint Software Technologies
- Microsoft Internet Security and Acceleration (ISA) Server

This issue may also occur when the following conditions are true:

- The RPC connection from the client is over TCP port 135 and is enabled.
- The response from the Central site server is over ephemeral ports that are above port 1024, and the firewall is blocking that port range.
To resolve this issue, configure the client and the server to restrict the range of ports that are used by RPC connection, and then enable that range on the firewall. To do this, use the method that is described in the following article in the Microsoft Knowledge Base: [154596](https://support.microsoft.com/help/154596) How to configure RPC dynamic port allocation to work with firewalls  

## References

For more information about how to help secure remote WMI connections, visit the following Microsoft Web site: [Maintaining WMI Security](/windows/win32/wmisdk/maintaining-wmi-security).
