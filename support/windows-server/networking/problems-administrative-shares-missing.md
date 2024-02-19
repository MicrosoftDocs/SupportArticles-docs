---
title: administrative shares are missing
description: Provides an explanation of various symptoms that can occur when the IPC$, ADMIN$, or C$ shares are missing on your computer, and provides steps to resolve the issue.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, msadoff
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Overview of problems that may occur when administrative shares are missing

This article provides a resolution for the problems that may occur when administrative shares are missing.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 842715

## Summary

This article describes the symptoms that may occur when one or more of the hidden administrative shares are missing on your computer. The article also provides information about how to resolve this problem.

If you have already determined that your computer is missing one or more of the hidden administrative shares, see the "Cause" and "Resolution" sections. Realize that missing administrative shares typically indicate that the computer in question has been compromised by malicious software. We recommend that users format and reinstall Windows on compromised servers.  

## Symptoms

You may experience a variety of issues when administrative shares are removed or are otherwise missing from your computer.

If you use the net share command or MPSReports, the output may show that your computer is missing the IPC$, ADMIN$, or C$ share. If you re-create a missing share, it may be missing again after the next startup or logon. This issue may occur even if you set the AutoShareServer and AutoShareWks registry DWORD values to 1.

You may find unknown processes that start from the Startup folder or from the **Run** key in the registry. Antivirus software may detect viruses, worms, Trojans, or backdoors. Or the FTP root on a Web server may be filled with unknown files.

The following list is a comprehensive list of the problematic behavior that may be associated with this issue.  

- If the affected computer is a domain controller, you may receive error messages on client computers during network logon or during the times when they try to join the domain. Sometimes, you can log on with client computers, but you may receive an error message that is similar to either of the following ones:  

  - > The domain password you supplied is not correct, or access to your logon server has been denied.

  - > The logon server did not recognize your domain password, or access to the server has been denied.
      
   - > No logon server is available to service the logon request.  

     When you try to join the domain, you may receive an error message that is similar to:  
     > The following error occurred attempting to join the domain '**Domain_Name**': The network name cannot be found.

- When you try to access or view the affected computer remotely by using a UNC path, a mapped drive, the net use command, the net view command, or by browsing the network in Network Neighborhood or My Network Places, you may receive an error message that is similar to one of the followings:

  - > The server is not configured for transactions.

  - > System error 53 has occurred. The network path was not found.

  - > **Domain_Name** is not accessible.

- You may receive errors when you try to perform administrative tasks on a domain controller. For example, MMC snap-ins such as Active Directory Users and Computers or Active Directory Sites and Services may not start, and you may receive an error message that is similar to the following one:  

     > Naming Information cannot be located because: Login attempt failed.

- When you try to add a user to a security group, you may receive an error message that is similar to:  

     > Object Picker cannot open because no locations from which to choose objects can be found.

- When you try to run Netdom.exe to find the FSMO roles, you may receive an error message that is similar to the following one:  

     > Unable to update the password. The value provided as the current password is incorrect.

- When you try to run Dcdiag.exe, you may receive an error message that is similar to the following one:  
     > Failed with 67: The network name cannot be found  

     The results from Dcdiag.exe may also list LDAP bind errors that are similar to the following one:  
     > LDAP bind failed with error 1323.

- When you try to run Netdiag.exe, you may receive an error message that is similar to:  

     > DC list test . . . . . . . . . . . : Failed  
     Failed to enumerate DCs by using the browser. [NERR_BadTransactConfig]

- If you run a network trace when you try to connect to the affected computer, you may see results that are similar to the following one:

     ```console
     C session setup & X, Username = username, and C tree connect & X, Share = \\<Server_Name>\IPC$  
     R session setup & X - DOS Error, (67) BAD_NET_NAME
     ```

- On the server, the WINS service may not start or the WINS console may display a red X, or both.

- NetBT 4311 events that are similar to the following ones may be logged in Event Viewer:

     > Event ID: 4311  
     Event Source: NetBT  
     Event Type: Error  
     Description: Initialization failed because the driver device could not be created

- The Terminal Services Licensing console may not start, and you may receive an error message that is similar to:

  - > No Terminal Services license server is available in the current domain or workgroup. To connect to another license server, click license, click connect and click the server name.

  - > The network address is invalid

## Cause

These issues may occur after a malicious program removes the administrative shares on a computer that is running Windows Server.

Frequently, malicious users connect to these administrative shares by taking advantage of weak passwords, missing security updates, direct exposure of the computer to the Internet, or a combination of these factors. The malicious users then install malicious programs to expand their influence over the computer and over the rest of the computer network. In many cases, these malicious programs remove the administrative shares as a defensive move to prevent other competing malicious users from taking control of the infected systems.

Infection by one of these malicious programs can come directly from the Internet or from another computer on the local network that is infected. It generally indicates that security on the network is weak. Therefore, if you see these symptoms, we recommend that you examine all other computers on the network for malicious programs by using antivirus software and spyware detection tools. We also recommend that you perform a security analysis to identify vulnerabilities on the network. See the "Resolution" section for information about how to detect malicious programs and how to analyze network security.

An example of a malicious program that targets administrative shares is the `Win32.Agobot` program.  
  
Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  
> [!NOTE]
> The `Win32.Agobot` program is only an example. Malicious programs become obsolete as antivirus vendors discover them and add them to their virus definitions. However, malicious users frequently develop new programs and variants to avoid detection by antivirus software.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To verify whether a computer is affected by this issue, follow these steps:  

1. Examine the AutoShareServer and AutoShareWks registry values to make sure that they are not set to 0:

    1. Click **Start**, click **Run**, type regedit, and then press ENTER.
    2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters`  
    3. If the AutoShareServer and AutoShareWks DWORD values in the **LanmanServer\Parameters** subkey are configured with a value data of 0, change that value to 1.
        > [!NOTE]
        > If these values do not exist, you do not have to create them because the default behavior is to automatically create the administrative shares.
    4. Quit Registry Editor.

2. Restart the computer. Typically, computers that are running Windows Server automatically create the administrative shares during startup.

3. After the computer restarts, verify that the administrative shares are active. To examine the shares, use the net share command. To do it, follow these steps:

    1. Click **Start**, click **Run**, type cmd, and then press ENTER.

    2. At the command prompt, type net share, and then press ENTER.

    3. Look for the Admin$, C$, and IPC$ administrative shares in the list of shares.  

If the administrative shares are not listed, the computer may be running a malicious program that removes the shares during startup. To look for malicious programs, follow these steps:

1. Use the latest virus definitions to run a complete antivirus scan on the computer. You can use your antivirus software or use one of several free virus-scanning services that are available on the Internet. See the "More Information" section for links to virus definition updates and to free online scans from antivirus software vendors.

    > [!IMPORTANT]
    > If you suspect that a computer is infected with malicious code, we recommend that you remove it from the network as soon as possible. We recommend this because a malicious user may be using the infected computer to start Distributed Denial of Service (DDoS) attacks, to send unsolicited commercial e-mail, or to share illegal copies of software, music, and movies.

2. If the antivirus scan identifies a malicious program on the system, use the antivirus vendor's removal instructions. Additionally, review the threat assessment and the technical details about the program on your antivirus vendor's Web site. In particular, check to see if the program includes backdoor capability. Backdoor capability means that the program provides a way for the malicious user to regain control of the system if the program is discovered and removed.

    If the technical details about the program indicate that it has backdoor capability, we recommend that you format the computer's hard disk and reinstall Windows securely. For information about improving security of Windows-based computers and servers, visit the following [Microsoft Security Guidance Center](/previous-versions/tn-archive/cc184906%28v=technet.10%29)

3. If the antivirus scan does not identify a malicious program on the system, it does not mean that the computer is not infected by a malicious program. More likely, it may mean that the malicious program is a new program or variant, and that the latest virus definitions do not detect it. In this case, contact the antivirus vendor to report the problem, or open a support incident with Microsoft Product Support Services (PSS) to investigate.

4. After you complete the antivirus scan, examine the computer for other malicious programs, such as spyware or malicious user tools. See the "More Information" section for links to spyware and to malicious user detection tools.

5. Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
