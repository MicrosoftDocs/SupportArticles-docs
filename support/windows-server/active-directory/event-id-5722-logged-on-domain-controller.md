---
title: Event ID 5722 is logged
description: Describes how to diagnose and resolve a problem where event 5722 appears in the system log of your domain controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jarrettr
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Event ID 5722 is logged on your domain controller

This article describes how to diagnose and resolve a problem where event 5722 appears in the system log of your domain controller.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 810977

>[!NOTE]
This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Summary

When you use Event Viewer to view the system log in a Windows domain controller, you may find event 5722 logged. This problem may occur in either of two scenarios:  

- When a computer updates its computer account password with a domain controller  
- When a computer is joined to a domain with a name that already exists  

This article describes how to differentiate the two scenarios and how to resolve the problem.  

## Symptoms

On a Microsoft Windows domain controller, the following event is logged in the system log:  
>Event Type: Error  
Event Source: NETLOGON  
Event Category: None  
Event ID: 5722  
Date: **Date**  
Time: **Time**  
User: N/A  
Computer: **ComputerName**  
Description: The session setup from the computer **ComputerName** failed to authenticate. The name of the account referenced in the security database is **AccountName** $.  
The following error occurred:  
Access is denied.  

## Cause

In a Microsoft Windows domain, starting with Windows 2000, a discrete communication channel helps provide a more secure communication path between the domain controller and the member servers or workstations. This channel is known as a *secure channel*. When you join a computer to a domain, a computer account is created, and a password is shared between the computer and the domain. By default, this password is changed every 30 days. The secure channel's password is stored together with the computer account on the primary domain controller (PDC). The password is replicated to all replica domain controllers.

Event 5722 is logged in the following scenarios:  

- When a computer updates its computer account password with a domain controller, the event is logged in the system log of the authenticating domain controller.

    In this scenario, the computer's secure channel with the authenticating domain controller is still valid.  

- When you join a computer to a domain by using a name that is already in use by another computer, or when an existing computer account is reset. An existing computer account may be reset by using Active Directory Users and Computers or by using the Netdom.exe utility.  

    In this scenario, the computer's account password does not match the password on the domain controller, and you cannot set a secure channel from the original computer to the domain controller.

## Resolution

> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Windows Server 2003, Microsoft Exchange 2000 Server, Microsoft Exchange Server 2003, or both Windows and Exchange. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.  

To resolve this problem, first determine which scenario is the cause of the problem. You can follow these steps:  

1. Note the date and the time that the event was logged in the system log.
2. Click **Start**, point to **Programs**, point to **Resource Kit**, and then click **Tools Management Console**.
3. In the console tree, click **Tools A to Z**.
4. In the details pane, click **ADSI Editor**.

    > [!NOTE]
    > ADSI Edit is included with the Windows Support Tools. You can install the Windows Support Tools from the Support\Tools folder of the Windows 2000 Server CD-ROM.

     To install ADSI Edit on computers running Windows Server® 2003 or Windows® XP operating systems, install Windows Server 2003 Support Tools from the Windows Server 2003 product CD. For more information about how to install Windows Support Tools from the product CD, see [Install Windows Support Tools](https://go.microsoft.com/fwlink/?linkid=62270).
  
    On servers running Windows Server 2008 or Windows Server 2008 R2, ADSI Edit is installed when you install the Active Directory Domain Services (AD DS) role to make a server a domain controller. You can also install Windows Server 2008 Remote Server Administration Tools (RSAT) on domain member servers or stand-alone servers. For specific instructions, see [Installing or Removing the Remote Server Administration Tools Pack](https://go.microsoft.com/fwlink/?linkid=143345).

    To install ADSI Edit on computers running Windows Vista® with Service Pack 1 (SP1) or Windows 7, you must install RSAT.  
5. In ADSI Edit, locate and then right-click the computer that is causing the problem.
6. Click **Properties**.
7. In **Select which properties to view**, click **Both**.
8. In **Select a property to view**, click **PwdLastSet**.

    If the `ntte` value is not converted in the UI to a readable date and timestamp, run the following command or proceed to step 9 for an alternate method:  

    ```console
    w32tm /ntte pwdlastsetvalue  
    ```

9. Copy the value that appears in the **Value(s)** box to the clipboard.
10. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Calculator**.
11. On the **View** menu, click **Scientific**.
12. Click **Dec** to set the numbering system to decimal.
13. Paste the value from the clipboard into Calculator.
14. To change the value from decimal to hexadecimal decimal numbering system, click **Hex**.
15. On the **Edit** menu, click **Copy**.
16. Paste the hexadecimal number from the clipboard to a file in Notepad.
17. Count eight characters from the rightmost character of the hexadecimal string, and then press SPACEBAR.

    > [!NOTE]
    > This action splits the hexadecimal string into two hexadecimal strings.
18. If the hexadecimal string on the left side contains only seven characters, add a zero to the beginning of the string.
19. At a command prompt, type  

    ```console
    Nltest /time: RightSideHexadecimalstringLeftSideHexadecimalString  
    ```  

    You will receive output that is similar to:  

    ```console  
     C:\>nltest /time:a25cc370 01c294bc  
     a25cc370 01c294bc = 11/25/2002 13:55:41  
     The command completed successfully.
    ```

20. Note the decoded date and time.
21. Check whether the date and time that you noted in step 1 and the decoded date and time that you noted in step 20 match.
22. If the date and time that event 5722 was logged and the decoded date and time match, check whether the computer that is causing the problem has a secure channel established with a domain controller by typing the following command at a command prompt:  

    ```console
    Nltest /server: **ComputerName** /sc_query: **DomainName**  
    ```  

    If the problem computer has a valid secure channel established with a domain controller, you receive output that is similar to:  

    ```console

     C:\>Nltest /server:computer1 /sc_query: DomainName Flags: 30  
    HAS_IP HAS_TIMESERV  
    Trusted DC Name \\homenode1.myhouse.com Trusted DC Connection Status Status = 0 0x0 NERR_Success The command completed successfully.  

    ```

    If the problem computer does not have a valid secure channel established with a domain controller, you receive output that is similar to:  

    ```console

     C:\>nltest /server:machine1 /sc_query: DomainName Flags: 0  
    Trusted DC Name  
    Trusted DC Connection Status Status = 5 0x5 ERROR_ACCESS_DENIED The command completed successfully.  

    ```

If the date and time of event 5722 and the decoded date and time do not match, the problem computer's account password may not match the password that is on the domain controller. This issue can occur under either of the following circumstances:  

- An administrator resets a computer account by using Active Directory Users and Computers or another tool such as Netdom.exe.  
- A new computer is joined to the domain by using a name that already exists in the domain.  

> [!NOTE]
> If Netlogon service logging is turned on for the domain controller, you confirm this scenario by checking for a Netlogon.log entry that is similar to the following:  
>
>05/06 13:35:25 [MISC] NlMainLoop: Notification that trust account added (or changed) TRUSTING_DOMAIN$ 0x#### 4  

This message is not logged if a computer updates its own computer account password.

To resolve problems that are related to duplicate computer names, rejoin the original computer to the domain.

You can ignore event 5722 if both of the following conditions are true:  

- If the date and time of event 5722 and the decoded date and time match.  
- A valid secure channel is established between the problem computer and a domain controller.  

> [!NOTE]
> When both of these conditions are true, event 5722 is logged on the domain controller when the computer tries to authenticate with a domain controller during the computer account update process.

Administrators can also query Active Directory information from any computer in the domain by using Ldp.exe. The version of Ldp.exe that is included in the Windows XP Service Pack 2 Support Tools can also be used to decode the PwdLastSet value.

## References

For additional information about enabling debug logging, click the following article number to view the article in the Microsoft Knowledge Base:

[109626](https://support.microsoft.com/help/109626) enabling debug logging for the Net Logon service
