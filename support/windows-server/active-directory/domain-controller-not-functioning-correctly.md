---
title: Domain controller is not functioning correctly
description: Provides common resolutions to issues where you cannot open Active Directory snap-ins or connect to a domain controller from another computer. Additionally, discusses resolutions to errors in the DCDIAG tool.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, clandis
ms.custom: sap:domain-controller-scalability-or-performance-including-ldap, csstroubleshoot
---
# Domain controller is not functioning correctly

This article provides common resolutions to the issue where domain controller is not functioning correctly.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 837513

## Symptoms

When you run the Dcdiag tool on a Microsoft Windows 2000-Server based domain controller or on a Windows Server 2003-based domain controller, you may receive the following error message:
> DC Diagnosis  
Performing initial setup:  
[DC1] LDAP bind failed with error 31

When you run the `REPADMIN /SHOWREPS` utility locally on a domain controller, you may receive one of the following error messages:  
> [D:\\nt\\private\\ds\\src\\util\\repadmin\\repinfo.c, 389] LDAP error 82 (Local Error).

> Last attempt @ yyyy-mm-dd hh:mm.ss failed, result 1753: There are no more endpoints available from the endpoint mapper.

>Last attempt @ yyyy-mm-dd hh:mm.ss failed, result 5: Access is denied.

If you use Active Directory Sites and Services to trigger replication, you may receive a message that indicates that access is denied.

When you try to use network resources from the console of an affected domain controller, including Universal Naming Convention (UNC) resources or mapped network drives, you may receive the following error message:
> No logon servers available (c000005e = "STATUS_NO_LOGON_SERVERS")

If you start any Active Directory administrative tools from the console of an affected domain controller, including Active Directory Sites and Services and Active Directory Users and Computers, you may receive one of the following error messages:
> Naming information cannot be located because: No authority could be contacted for authentication. Contact your system administrator to verify that your domain is properly configured and is currently online.

> Naming information cannot be located because: Target account name is incorrect. Contact your system administrator to verify that your domain is properly configured and is currently online.

Microsoft Outlook clients that are connected to Microsoft Exchange Server computers that are using affected domain controllers for authentication may be prompted for logon credentials, even though there is successful logon authentication from other domain controllers.

The Netdiag tool may display the following error messages:
> DC list test . . . . . . . . . . . : Failed  
[WARNING] Cannot call DsBind to \<servername>.\<fqdn> (\<ip address>).   [ERROR_DOMAIN_CONTROLLER_NOT_FOUND]  
Kerberos test. . . . . . . . . . . : Failed  
[FATAL] Kerberos does not have a ticket for krbtgt/\<fqdn>.  
>
> [FATAL] Kerberos does not have a ticket for \<hostname>.  
LDAP test. . . . . . . . . . . . . : Passed  
[WARNING] Failed to query SPN registration on DC \<hostname>\<fqdn>

The following event may be logged in the system event log of the affected domain controller:

```output
Event Type: Error
Event Source: Service Control Manager
Event ID: 7023
Description: The Kerberos Key Distribution Center service terminated with the following error: The security account manager (SAM) or local security authority (LSA) server was in the wrong state to perform the security operation.
```

## Resolution

There are several resolutions for these symptoms. The following is a list of methods to try. The list is followed by steps to perform each method. Try each method until the problem is resolved. Microsoft Knowledge Base articles that describe less common fixes for these symptoms are listed later.

1. Method 1: Fix Domain Name System (DNS) errors.
2. Method 2: Synchronize the time between computers.
3. Method 3: Check the **Access this computer from the network** user rights.
4. Method 4: Verify that the domain controller's userAccountControl attribute is 532480.
5. Method 5: Fix the Kerberos realm (confirm that the PolAcDmN registry key and the PolPrDmN registry key match).
6. Method 6: Reset the machine account password, and then obtain a new Kerberos ticket.

### Method 1: Fix DNS errors

1. At a command prompt, run the `netdiag -v` command. This command creates a Netdiag.log file in the folder where the command was run.
2. Resolve any DNS errors in the Netdiag.log file before you continue. The Netdiag tool is in the Windows 2000 Server Support Tools on the Windows 2000 Server CD-ROM or as a download.
3. Make sure that DNS is configured correctly. One of the most common DNS mistakes is to point the domain controller to an Internet Service Provider (ISP) for DNS instead of pointing DNS to itself or to another DNS server that supports dynamic updates and SRV records. We recommend that you point the domain controller to itself or to another DNS server that supports dynamic updates and SRV records. We recommend that you set up forwarders to the ISP for name resolution on the Internet.

For more information about configuring DNS for Active Directory directory service, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
[254680](https://support.microsoft.com/help/254680) DNS namespace planning

### Method 2: Synchronize the time between computers

Verify that the time is correctly synchronized between domain controllers. Additionally, verify that the time is correctly synchronized between client computers and domain controllers.

### Method 3: Check the "Access this computer from the network" user rights

Modify the Gpttmpl.inf file to confirm that the appropriate users have the **Access this computer from the network** user right on the domain controller. To do this, follow these steps:

1. Modify the Gpttmpl.inf file for the Default Domain Controllers Policy. By default, the Default Domain Controllers Policy is where user rights are defined for a domain controller. By default, the Gpttmpl.inf file for the Default Domain Controllers Policy is located in the following folder.

    > [!NOTE]
    > Sysvol may be in a different location, but the path for the Gpttmpl.inf file will be the same.

    For Windows Server 2003 domain controllers:

    C:\\WINDOWS\\Sysvol\\Sysvol\\\<Domainname>\\Policies\\\{6AC1786C-016F-11D2-945F-00C04fB984F9}\\MACHINE\\Microsoft\\Windows NT\\SecEdit\\GptTmpl.inf

    For Windows 2000 Server domain controllers:

    C:\\WINNT\\Sysvol\\Sysvol\\\<Domainname>\\Policies\\\{6AC1786C-016F-11D2-945F-00C04fB984F9}\\MACHINE\\Microsoft\\Windows NT\\SecEdit\\GptTmpl.inf
2. To the right of the SeNetworkLogonRight entry, add the security identifiers for Administrators, for Authenticated Users, and for Everyone. See the following examples.

    For Windows Server 2003 domain controllers:

    SeNetworkLogonRight = \*S-1-5-32-554,\*S-1-5-9,\*S-1-5-32-544,\*S-1-1-0  

    For Windows 2000 Server domain controllers:

    SeNetworkLogonRight = \*S-1-5-11,\*S-1-5-32-544,\*S-1-1-0  

    > [!NOTE]
    > Administrators (S-1-5-32-544), Authenticated Users (S-1-5-11), Everyone (S-1-1-0), and Enterprise Controllers (S-1-5-9) use well-known security identifiers that are the same in every domain.

3. Remove any entries to the right of the SeDenyNetworkLogonRight entry (Deny access to this computer from the network) to match the following example.

    SeDenyNetworkLogonRight =

    > [!NOTE]
    > The example is the same for Windows 2000 Server and for Windows Server 2003.

    By default, Windows 2000 Server has no entries in the SeDenyNetworkLogonRight entry. By default, Windows Server 2003 has only the Support_random string account in the SeDenyNetworkLogonRight entry. (The Support_random string account is used by Remote Assistance.) Because the Support_random string account uses a different security identifier (SID) in every domain, the account is not easily distinguishable from a typical user account just by looking at the SID. You may want to copy the SID to another text file, and then remove the SID from the SeDenyNetworkLogonRight entry. That way, you can put it back when you are finished troubleshooting the problem.

    SeNetworkLogonRight and SeDenyNetworkLogonRight can be defined in any policy. If the previous steps do not resolve the issue, check the Gpttmpl.inf file in other policies in Sysvol to confirm that the user rights are not also being defined there. If a Gpttmpl.inf file contains no reference to SeNetworkLogonRight or to SeDenyNetworkLogonRight, those settings are not defined in the policy and that policy is not causing this issue. If those entries do exist, make sure that they match the settings listed earlier for the Default Domain Controller policy.

### Method 4: Verify that the domain controller's userAccountControl attribute is 532480

1. Click **Start**, click **Run**, and then type *adsiedit.msc*.
2. Expand **Domain NC**, expand **DC=domain**, and then expand **OU=Domain Controllers**.
3. Right-click the affected domain controller, and then click **Properties**.
4. In Windows Server 2003, click to select the **Show mandatory attributes** check box and the **Show optional attributes** check box on the **Attribute Editor** tab. In Windows 2000 Server, click **Both** in the **Select which properties to view** box.
5. In Windows Server 2003, click **userAccountControl** in the **Attributes** box. In Windows 2000 Server, click **userAccountControl** in the **Select a property to view** box.
6. If the value is not 532480, type *532480* in the **Edit Attribute** box, click **Set**, click **Apply**, and then click **OK**.
7. Quit ADSI Edit.

### Method 5: Fix the Kerberos realm (confirm that the PolAcDmN registry key and the PolPrDmN registry key match)

> [!NOTE]
> This method is valid only for Windows 2000 Server.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

1. Start **Registry Editor**.
2. In the left pane, expand **Security**.
3. On the **Security** menu, click **Permissions** to grant the **Administrators local group Full Control** of the **SECURITY** hive and its child containers and objects.
4. Locate the `HKEY_LOCAL_MACHINE\SECURITY\Policy\PolPrDmN` key.
5. In the right pane of **Registry Editor**, click the **\<No Name>: REG_NONE** entry one time.
6. On the **View** menu, click **Display Binary Data**. In the **Format** section of the dialog box, click **Byte**.
7. The domain name appears as a string in the right side of the **Binary Data** dialog box. The domain name is the same as the Kerberos realm.
8. Locate the `HKEY_LOCAL_MACHINE\SECURITY\Policy\PolACDmN` registry key.
9. In the right pane of **Registry Editor**, double-click the **\<No Name>: REG_NONE** entry.
10. In the **Binary Editor** dialog box, paste the value from PolPrDmN. (The value from PolPrDmN will be the NetBIOS domain name).
11. Restart the domain controller.

### Method 6: Reset the machine account password, and then obtain a new Kerberos ticket

1. Stop the **Kerberos Key Distribution Center** service, and then set the startup value to **Manual**.
2. Use the Netdom tool from the Windows 2000 Server Support Tools or from the Windows Server 2003 Support Tools to reset the domain controller's machine account password:

    ```console
    netdom resetpwd /server: <another domain controller> /userd:domain\administrator /passwordd: <administrator password>  
    ```

    Make sure that the `netdom` command is returned as completed successfully. If it is not, the command did not work. For the domain Contoso, where the affected domain controller is DC1, and a working domain controller is DC2, you run the following `netdom` command from the console of DC1:

    ```console
    netdom resetpwd /server:DC2 /userd:contoso\administrator /passwordd: <administrator password>
    ```

3. Restart the affected domain controller.
4. Start the **Kerberos Key Distribution Center** service, and then set the startup setting to **Automatic**.

For more information about this issue, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
[323542](https://support.microsoft.com/help/323542) You cannot start the Active Directory Users and Computers tool because the server is not operational
