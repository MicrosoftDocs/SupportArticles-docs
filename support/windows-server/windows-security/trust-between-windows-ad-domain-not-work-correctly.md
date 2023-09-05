---
title: Trust between a Windows NT domain and an Active Directory domain can't be established or it doesn't work as expected
description: Describes trust configuration issues between a Windows NT 4.0-based domain and an Active Directory-based domain.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: slight, kaushika
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
ms.technology: windows-server-security
---
# Trust between a Windows NT domain and an Active Directory domain can't be established or it doesn't work as expected

This article describes the trust configuration issues between a Windows NT 4.0-based domain and an Active Directory-based domain.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 889030

## Symptoms

If you try to set up a trust between a Microsoft Windows NT 4.0-based domain and an Active Directory-based domain, you may experience either of the following symptoms:

- The trust isn't established.
- The trust is established, but the trust doesn't work as expected.

Additionally, you may receive any of the following error messages:

> The following error occurred attempting to join the domain "**Domain_Name**": The account is not authorized to log in from this station.

> Access is denied.

> No domain controller could be contacted.

> Logon failure: unknown username or bad password.

When you use the object picker in Active Directory Users and Computers to add users from the NT 4.0 domain to the Active Directory domain, you may receive the following error message:
> No items match the current search. Check your search parameters, and try again.

## Cause

This issue occurs because of a configuration issue in any one of the following areas:

- Name resolution
- Security settings
- User rights
- Group membership for Microsoft Windows 2000 or Microsoft Windows Server 2003

To correctly identify the cause of the issue, you must troubleshoot the trust configuration.

## Resolution

If you receive the "No items match the current search" error message when you use the object picker in Active Directory Users and Computers, make sure that the domain controllers in the NT 4.0 domain include Everyone in the Access this computer from the network user right. In this scenario, the object picker tries to connect anonymously across the trust. To verify these settings, follow the steps in the "Method three: Verify the user rights" section.

To troubleshoot trust configuration issues between a Windows NT 4.0-based domain and Active Directory, you must verify the correct configuration of the following areas:

- Name resolution
- Security settings
- User rights
- Group membership for Microsoft Windows 2000 or Microsoft Windows Server 2003

To do this, use the following methods.

### Method one: Verify the correct configuration of name resolution

#### Step 1: Create an LMHOSTS file

Create an LMHOSTS file on the primary domain controllers to provide cross-domain name resolution capability. The LMHOSTS file is a text file that you can edit with any text editor, such as Notepad. The LMHOSTS file on each domain controller must contain the TCP/IP address, the domain name, and the \0x1b entry of the other domain controller.

After you create the LMHOSTS file, follow these steps:

1. Modify the file so that it contains text that is similar to the following text:

    1.1.1.1 \<NT_4_PDC_Name> #DOM:\<NT_4_Domain_Name>#PRE  
    1.1.1.1 "\<NT_4_Domain> \\0x1b"#PRE  
    2.2.2.2 \<Windows_2000_PDC_Name> #DOM:\<Windows_2000_Domain_Name>#PRE  
    2.2.2.2 "<2000_Domain> \\0x1b"#PRE  

    > [!NOTE]
    > There must be a total of 20 characters and spaces between the quotation marks (" ") for the \\0x1b entry. Add spaces after the domain name so that it uses 15 characters. The 16th character is the backslash that is followed by the "0x1b" value, and this makes a total of 20 characters.

2. When you finish the changes to the LMHOSTS file, save the file to the **%SystemRoot%** \\System32\\Drivers\\Etc folder on the domain controllers. For more information about the LMHOSTS file, view the Lmhosts.sam sample file that is located in the **%SystemRoot%** \\System32\\Drivers\\Etc folder.

#### Step 2: Load the LMHOSTS file into the cache

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type `NBTSTAT -R`, and then press ENTER. This command loads the LMHOSTS file into the cache.
3. At the command prompt, type `NBTSTAT -c`, and then press ENTER. This command displays the cache. If the file is written correctly, the cache is similar to the following:

    NT4PDCName <03> UNIQUE 1.1.1.1 -1  
    NT4PDCName <00> UNIQUE 1.1.1.1 -1  
    NT4PDCName <20> UNIQUE 1.1.1.1 -1  
    NT4DomainName <1C> GROUP 1.1.1.1 -1  
    NT4DomainName <1B> UNIQUE 1.1.1.1 -1  
    W2KPDCName <03> UNIQUE 2.2.2.2 -1  
    W2KPDCName <00> UNIQUE 2.2.2.2 -1  
    W2KPDCName <20> UNIQUE 2.2.2.2 -1  
    W2KDomainName <1C> GROUP 2.2.2.2 -1  
    W2KDomainName <1B> UNIQUE 2.2.2.2 -1  

    If the file doesn't populate the cache correctly, continue with the next step.

#### Step 3: Make sure that the LMHOSTS lookup is enabled on the Windows NT 4.0-based computer

If the file doesn't populate the cache correctly, make sure that LMHOSTS lookup is enabled on the Windows NT 4.0-based computer. To do this, follow these steps:

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Networks**, click the **Protocols** tab, and then double-click **TCP/IP Protocol**.
3. Click the **WINS Address** tab, and then click to select the **Enable LMHOSTS Lookup** check box.
4. Restart the computer.
5. Repeat the steps in the "Load the LMHOSTS file into the cache" section.
6. If the file doesn't populate the cache correctly, make sure that the LMHOSTS file is in the **%SystemRoot%**\\System32\\Drivers\\Etc folder and that the file is formatted correctly.

For example, the file must be formatted similar to the following example formatting:

1.1.1.1 NT4PDCName #DOM:NT4DomainName#PRE  
1.1.1.1 "NT4DomainName \\0x1b"#PRE  
2.2.2.2 W2KPDCName #DOM:W2KDomainName#PRE  
2.2.2.2 "W2KDomainName \\0x1b"#PRE  

> [!NOTE]
> There must be a total of 20 characters and spaces inside the quotations marks (" ") for the Domain name and \\0x1b entry.

#### Step 4: Use the Ping command to test connectivity

When the file populates the cache correctly on each server, use the `Ping` command on each server to test connectivity between the servers. To do this, follow these steps:

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type `Ping <Name_Of_Domain_Controller_You_Want_To_Connect_To>`, and then press ENTER. If the `Ping` command doesn't work, make sure that the correct IP addresses are listed in the LMHOSTS file.
3. At the command prompt, type `net view <Name_Of_Domain_Controller_You_Want_To_Connect_To>`, and then press ENTER. It's expected that you receive the following error message:

    > System error 5 has occurred. Access is denied

    If the net view command returns the following error message or any other related error message, make sure that the correct IP addresses are listed in the LMHOSTS file:

    > System error 53 has occurred. The network path was not found

Alternatively, Windows Internet Name Service (WINS) can be configured to enable name resolution functionality without using an LMHOSTS file.  

### Method two: View security settings

Typically, the Active Directory side of the trust configuration has security settings that cause connectivity problems. However, the security settings must be inspected on both sides of the trust.

#### Step 1: View security settings on Windows 2000 Server and Windows Server 2003

In Windows 2000 Server and Windows Server 2003, the security settings may be applied or configured by Group Policy, a local policy, or an applied security template.

You must use the correct tools to determine the current values of the security settings to avoid inaccurate readings.

To obtain an accurate reading of the current security settings, use the following methods:

- In Windows 2000 Server, use the Security Configuration and Analysis snap-in.

- In Windows Server 2003, use either the Security Configuration and Analysis snap-in, or the Resultant Set of Policy (RSoP) snap-in.

After you determine the current settings, you must identify the policy that is applying the settings. For example, you must determine the Group Policy in the Active Directory, or the local settings that set the security policy.

In Windows Server 2003, the policy that sets the security values is identified by the RSoP tool. However, in Windows 2000 you must view the Group Policy and the local policy to determine the policy that contains the security settings:

- To view the Group Policy settings, you must enable logging output for the Microsoft Windows 2000 Security Configuration Client during Group Policy processing.

- View the Application login Event Viewer and find Event ID 1000 and event ID 1202.

The following three sections identify the operating system and list the security settings that you must verify for the operating system in the information that you've collected:

##### Windows 2000

Make sure that the following settings are configured as shown.

RestrictAnonymous:

|Additional restrictions for anonymous connections<br/>|"None. Rely on default permissions"|
|---|---|

LM Compatibility:

|LAN Manager authentication level|"Send NTLM response only"|
|---|---|

SMB Signing, SMB Encrypting, or both:

|Digitally sign client communications (always)|DISABLED|
|---|---|
|Digitally sign client communications (when it is possible)|ENABLED|
|Digitally sign server communications (always)|DISABLED|
|Digitally sign server communications (when it is possible)|ENABLED|
|Secure channel: Digitally encrypt or sign secure channel data (always)|DISABLED|
|Secure channel: Digitally encrypt secure channel data (when it is possible)|DISABLED|
|Secure channel: Digitally sign secure channel data (when it is possible)|DISABLED|
|Secure channel: Require strong (Windows 2000 or later) session key|DISABLED|

##### Windows Server 2003

Make sure that the following settings are configured as shown.

RestrictAnonymous and RestrictAnonymousSam:

|Network access: Allow anonymous SID/Name translation|ENABLED|
|---|---|
|Network access: Do not allow anonymous enumeration of SAM accounts|DISABLED|
|Network access: Do not allow anonymous enumeration of SAM accounts and shares|DISABLED|
|Network access: Let Everyone permissions apply to anonymous users|ENABLED|
|Network access: Named pipes can be accessed anonymously|ENABLED|
|Network access: Restrict anonymous access to Named Pipes and shares|DISABLED|

> [!NOTE]
> By default, the value of the Network access: Allow anonymous SID/Name translation setting is DISABLED in Windows Server 2008.

LM Compatibility:

|Network security: LAN Manager authentication level|"Send NTLM response only"|
|---|---|

SMB Signing, SMB Encrypting, or both:

|Microsoft network client: Digitally sign communications (always)|DISABLED|
|---|---|
|Microsoft network client: Digitally sign communications (if server agrees)|ENABLED|
|Microsoft network server: Digitally sign communications (always)|DISABLED|
|Microsoft network server: Digitally sign communications (if client agrees)|ENABLED|
|Domain member: Digitally encrypt or sign secure channel data (always)|DISABLED|
|Domain member: Digitally encrypt secure channel data (when it is possible)|ENABLED|
|Domain member: Digitally sign secure channel data (when it is possible)|ENABLED|
|Domain member: Require strong (Windows 2000 or later) session key|DISABLED|

After the settings are configured correctly, you must restart your computer. The security settings are not enforced until the computer is restarted.

After the computer restarts, wait 10 minutes to make sure that all security policies are applied and the effective settings are configured. We recommend that you wait 10 minutes because Active Directory policy updates occur every 5 minutes on a domain controller, and the update may change the security setting values. After 10 minutes, use Security Configuration and Analysis or another tool to examine the security settings in Windows 2000 and Windows Server 2003.

#### Windows NT 4.0

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows
  
In Windows NT 4.0, the current security settings must be verified by using the Regedt32 tool to view the registry. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedt32*, and then click **OK**.
2. Expand the following registry subkeys, and then view the value that is assigned to the RestrictAnonymous entry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters`  

3. Expand the following registry subkeys, and then view the value that is assigned to the LM Compatibility entry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\LMCompatibilityLevel`

4. Expand the following registry subkeys, and then view the value that is assigned to the EnableSecuritySignature (server) entry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters\EnableSecuritySignature`

5. Expand the following registry subkeys, and then view the value that is assigned to the RequireSecuritySignature (server) entry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters\RequireSecuritySignature`

6. Expand the following registry subkeys, and then view the value that is assigned to the RequireSignOrSeal entry:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

7. Expand the following registry subkeys, and then view the value that is assigned to the SealSecureChannel entry:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

8. Expand the following registry subkeys, and then view the value that is assigned to the SignSecureChannel entry:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

9. Expand the following registry subkeys, and then view the value that is assigned to the RequireStrongKey entry:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

### Method three: Verify the user rights

To verify the required user rights on a Windows 2000-based computer, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Local Security Policy**.
2. Expand **Local Policies**, and then click **User Rights Assignment**.
3. In the right-pane, double-click **Access this computer from the network**.
4. Click to select the **Local Policy Setting** check box next to the **Everyone** group in the **Assigned to** list, and then click **OK**.
5. Double-click **Deny access to this computer from the network**.
6. Verify that there are no principle groups in the **Assigned to** list, and then click **OK**. For example, make sure that Everyone, Authenticated Users, and other groups aren't listed.
7. Click **OK**, and then quit Local Security Policy.

To verify the required user rights on a Windows Server 2003-based computer, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Domain Controller Security Policy**.
2. Expand **Local Policies**, and then click **User Rights Assignment**.
3. In the right-pane, double-click **Access this computer from the network**.
4. Make sure that the Everyone group is in the **Access this computer from the network** list. 

    If the Everyone group isn't listed, follow these steps:

    1. Click **Add User or Group**.
    2. In the **User and group names** box, type *Everyone*, and then click **OK**.
5. Double-click **Deny access to this computer from the network**.
6. Verify that there are no principle groups in the **Deny access to this computer from the network** list, and then click **OK**. For example, make sure that Everyone, Authenticated Users, and other groups, aren't listed.
7. Click **OK**, and then close the Domain Controller Security Policy.

To verify the required user rights on a Windows NT Server 4.0-based computer, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **User Manager for Domains**.
2. On the **Policies** menu, click **User Rights**.
3. In the **Right** list, click **Access this computer from the network**.
4. In the **Grant to** box, make sure that the Everyone group is added.

    If the Everyone group isn't added, follow these steps:

    1. Click **Add**.
    2. In the **Names** list, click **Everyone**, click **Add**, and then click **OK**.
5. Click **OK**, and then quit User Manager.

### Method four: Verify group membership

If a trust is set up between the domains, but you can't add principle user groups from one domain to the other because the dialog box doesn't locate the other domain objects, the "Pre-Windows 2000 compatible access" group may not have the correct membership.

On the Windows 2000-based domain controllers and the Windows Server 2003-based domain controllers, make sure that the required group memberships are configured.

To do this on the Windows 2000-based domain controllers, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Click **Built in**, and then double-click **Pre-Windows 2000 compatible access group**.
3. Click the **Members** tab, and then make sure that the Everyone group is in the **Members** list.
4. If the Everyone group isn't in the **Members** list, follow these steps:

    1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `net localgroup "Pre-Windows 2000 Compatible Access" everyone /add`, and then press ENTER.

To make sure that the required group memberships are configured on the Windows Server 2003-based domain controllers, you must know if the "Network access: Let Everyone permissions apply to anonymous users" policy setting is disabled. If you don't know, use the Group Policy Object Editor to determine the state of the "Network access: Let Everyone permissions apply to anonymous users" policy setting. To do this, follow these steps:

1. Click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.
2. Expand the following folders:

    **Local Computer Policy**  
     **Computer Configuration**  
     **Windows Settings**  
     **Security Settings**  
     **Local Policies**  

3. Click **Security Options**, and then click **Network access: Let Everyone permissions apply to anonymous users** in the right pane.
4. Note if the value in the **Security Setting** column is **Disabled** or **Enabled**.

To make sure that the required group memberships are configured on the Windows Server 2003-based domain controllers, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Click **Built in**, and then double-click **Pre-Windows 2000 compatible access group**.
3. Click the **Members** tab.
4. If the **Network access: Let Everyone permissions apply to anonymous users** policy setting is disabled, make sure that the Everyone, Anonymous Logon group is in the **Members** list. If the "Network access: Let Everyone permissions apply to anonymous users" policy setting is enabled, make sure that the Everyone group is in the **Members** list.
5. If the Everyone group isn't in the **Members** list, follow these steps:

    1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `net localgroup "Pre-Windows 2000 Compatible Access" everyone /add`, and then press ENTER.

### Method five: Verify connectivity through network devices, such as firewalls, switches, or routers

If you've received error messages that are similar to the following error message and you've verified that the LMHOST files are correct, the issue may be caused by a firewall, router, or switch that has blocked ports between the domain controllers:
> No domain controller could be contacted

To troubleshoot network devices, use PortQry Command Line Port Scanner version 2.0 to test the ports between your domain controllers.

For more information about PortQry version 2, click the following article number to view the article in the Microsoft Knowledge Base:

[832919](https://support.microsoft.com/help/832919) New features and functionality in PortQry version 2.0  

For more information about how the ports must be configured, click the following article number to view the article in the Microsoft Knowledge Base:

[179442](https://support.microsoft.com/help/179442) How to configure a firewall for domains and trusts  

### Method six: Gather additional information to help troubleshoot the issue

If the previous methods did not help you resolve the issue, collect the following additional information to help you troubleshoot the cause of the issue:

- Enable Netlogon logging on both domain controllers.
     For more information about how to complete Netlogon logging, click the following article number to view the article in the Microsoft Knowledge Base: [109626](https://support.microsoft.com/help/109626) Enabling debug logging for the Net Logon service  

- Capture a trace on both domain controllers at the same time that the issue occurs.

## More information

The following list of Group Policy objects (GPOs) provides the location of the corresponding registry entry and the Group Policy in the applicable operating systems:

- The RestrictAnonymous GPO:

  - Windows NT registry location:
         `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters`
  - Windows 2000 and Windows Server 2003 registry location:
         `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA`
  - Windows 2000 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\ Security Options Additional restrictions for anonymous connections**  
  - Windows Server 2003 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\Security Options Network access: Do not allow anonymous enumeration of SAM accounts and shares**

- The RestrictAnonymousSAM GPO:

  - Windows Server 2003 registry location:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA`
  - Windows Server 2003 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings  Security Options Network access: Do not allow anonymous enumeration of SAM accounts and shares**  

- The EveryoneIncludesAnonymous GPO:

  - Windows Server 2003 registry location:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA`
  - Windows Server 2003 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\Security Options Network access: Let Everyone permissions apply to anonymous users**
- The LM Compatibility GPO:

  - Windows NT, Windows 2000, and Windows Server 2003 registry location: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\LMCompatibilityLevel`  

  - Windows 2000 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\Security Options: LAN Manager authentication level**  
  - Windows Server 2003 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\Security Options\\Network security: LAN Manager authentication level**
- The EnableSecuritySignature (client) GPO:

  - Windows 2000 and Windows Server 2003 registry location: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters\EnableSecuritySignature`
  - Windows 2000 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings \\Security Options: Digitally sign client communication (when possible)**  
  - Windows Server 2003 Group Policy: **Computer Configuration\\Windows Settings\\Security Settings\\Security Options\\Microsoft network client: Digitally sign communications (if server agrees)**
- The RequireSecuritySignature (client) GPO:

  - Windows 2000 and Windows Server 2003 registry location:
    `HKey_Local_Machine\System\CurrentControlSet\Services\LanManWorkstation\Parameters\RequireSecuritySignature`  
  - Windows 2000 Group Policy: **Computer Configuration\Windows Settings\Security Settings\Security Options: Digitally sign client communication (always)**  
  - Windows Server 2003: **Computer Configuration\Windows Settings\Security Settings\Security Options\Microsoft network client: Digitally sign communications (always)**
- The EnableSecuritySignature (server) GPO:

  - Windows NT registry location:
         `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters\EnableSecuritySignature`
  - Windows 2000 and Windows Server 2003 registry location:
         `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableSecuritySignature`  
  - Windows 2000 Group Policy: **Digitally sign server communication (when possible)**  
  - Windows Server 2003 Group Policy: **Microsoft network server: Digitally sign communications (if client agrees)**  

- The RequireSecuritySignature (server) GPO:

  - Windows NT registry location:
        `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rdr\Parameters\RequireSecurityS ignature`
  - Windows 2000 and Windows Server 2003 registry location:
         `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\Require SecuritySignature`
  - Windows 2000 Group Policy: **Digitally sign server communication (always)**  
  - Windows Server 2003 Group Policy: **Microsoft network server: Digitally sign communications (always)**
- The RequireSignOrSeal GPO:

  - Windows NT, Windows 2000, and Windows Server2003 registry location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
  - Windows 2000 Group Policy: **Digitally encrypt or sign secure channel data (always)**  
  - Windows Server2003 Group Policy: **Domain member: Digitally encrypt or sign secure channel data (always)**
- The SealSecureChannel GPO:

  - Windows NT, Windows 2000, and Windows Server2003 registry location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
  - Windows 2000 Group Policy: **Secure channel: Digitally encrypt secure channel data (when possible)**  
  - Windows Server 2003 Group Policy: **Domain member: Digitally encrypt secure channel data (when possible)**  

- The SignSecureChannel GPO:

  - Windows NT, Windows 2000, and Windows Server 2003 registry location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
  - Windows 2000 Group Policy: **Secure channel: Digitally sign secure channel data (when possible)**  
  - Windows Server 2003 Group Policy: **Domain member: Digitally sign secure channel data (when possible)**
- The RequireStrongKey GPO:

  - Windows NT, Windows 2000, and Windows Server 2003 registry location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
  - Windows 2000 Group Policy: **Secure channel: Require strong (Windows 2000 or later) session key**  
  - Windows Server 2003 Group Policy: **Domain member: Require strong (Windows 2000 or later) session key**

### Windows Server 2008

On a domain controller that is running Windows Server 2008, the default behavior of the Allow cryptography algorithms compatible with Windows NT 4.0 policy setting may cause a problem. This setting prevents both Windows operating systems and third-party clients from using weak cryptography algorithms to establish NETLOGON security channels to Windows Server 2008-based domain controllers.

## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[823659](https://support.microsoft.com/help/823659) Client, service, and program incompatibilities that may occur when you modify security settings and user rights assignments  
