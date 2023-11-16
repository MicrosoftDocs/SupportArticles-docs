---
title: How to create an Active Directory server in Windows Server 2003
description: Describes how to install and configure a new Active Directory installation in a laboratory environment that includes Windows Server 2003 and Active Directory.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, JOHNF
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to create an Active Directory server in Windows Server 2003  

This article describes how to install and configure a new Active Directory installation in a laboratory environment that includes Windows Server 2003 and Active Directory.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324753

> [!NOTE]
> You will need two networked servers that are running Windows Server 2003 for this purpose in a laboratory environment.

## Create the Active Directory

After you have installed Windows Server 2003 on a stand-alone server, run the Active Directory Wizard to create the new Active Directory forest or domain, and then convert the Windows Server 2003 computer into the first domain controller in the forest. To convert a Windows Server 2003 computer into the first domain controller in the forest, follow these steps:

1. Insert the Windows Server 2003 CD-ROM into your computer's CD-ROM or DVD-ROM drive.
2. Click **Start**, click **Run**, and then type *dcpromo*.
3. Click **OK** to start the **Active Directory Installation Wizard**, and then click **Next**.
4. Click **Domain controller for a new domain**, and then click **Next**.
5. Click **Domain in a new forest**, and then click **Next**.
6. Specify the full DNS name for the new domain. Note that because this procedure is for a laboratory environment and you are not integrating this environment into your existing DNS infrastructure, you can use something generic, such as mycompany.local, for this setting. Click **Next**.
7. Accept the default domain NetBIOS name (this is "mycompany" if you used the suggestion in step 6). Click **Next**.
8. Set the database and log file location to the default setting of the c:\\winnt\\ntds folder, and then click **Next**.
9. Set the Sysvol folder location to the default setting of the c:\\winnt\\sysvol folder, and then click **Next**.
10. Click **Install and configure the DNS server on this computer**, and then click **Next**.
11. Click **Permissions compatible only with Windows 2000 or Windows Server 2003 servers or operating systems**, and then click **Next**.
12. Because this is a laboratory environment, leave the password for the Directory Services Restore Mode Administrator blank. Note that in a full production environment, this password is set by using a secure password format. Click **Next**.
13. Review and confirm the options that you selected, and then click **Next**.
14. The installation of Active Directory proceeds. Note that this operation may take several minutes.
15. When you are prompted, restart the computer. After the computer restarts, confirm that the Domain Name System (DNS) service location records for the new domain controller have been created. To confirm that the DNS service location records have been created, follow these steps:

    1. Click **Start**, point to Administrative Tools, and then click **DNS** to start the DNS Administrator Console.
    2. Expand the server name, expand **Forward Lookup Zones**, and then expand the domain.
    3. Verify that the _msdcs, _sites, _tcp, and _udp folders are present. These folders and the service location records they contain are critical to Active Directory and Windows Server 2003 operations.

## Add Users and Computers to the Active Directory domain

After the new Active Directory domain is established, create a user account in that domain to use as an administrative account. When that user is added to the appropriate security groups, use that account to add computers to the domain.

1. To create a new user, follow these steps:

    1. Click **Start**, point to Administrative Tools, and then click **Active Directory Users and Computers** to start the Active Directory Users and Computers console.
    2. Click the domain name that you created, and then expand the contents.
    3. Right-click **Users**, point to **New**, and then click **User**.
    4. Type the first name, last name, and user logon name of the new user, and then click **Next**.
    5. Type a new password, confirm the password, and then click to select one of the following check boxes:

        - Users must change password at next logon (recommended for most users)
        - User cannot change password
        - Password never expires
        - Account is disabled

        Click **Next**.
    6. Review the information that you provided, and if everything is correct, click **Finish**.

2. After you create the new user, give this user account membership in a group that permits that user to perform administrative tasks. Because this is a laboratory environment that you are in control of, you can give this user account full administrative access by making it a member of the Schema, Enterprise, and Domain administrators groups. To add the account to the Schema, Enterprise, and Domain administrators groups, follow these steps:

    1. On the Active Directory Users and Computers console, right-click the new account that you created, and then click **Properties**.
    2. Click the **Member Of** tab, and then click **Add**.
    3. In the **Select Groups** dialog box, specify a group, and then click **OK** to add the groups that you want to the list.
    4. Repeat the selection process for each group in which the user needs account membership.
    5. Click **OK** to finish.

3. The final step in this process is to add a member server to the domain. This process also applies to workstations. To add a computer to the domain, follow these steps:

    1. Log on to the computer that you want to add to the domain.
    2. Right-click **My Computer**, and then click **Properties**.
    3. Click the **Computer Name** tab, and then click **Change**.
    4. In the **Computer Name Changes** dialog box, click **Domain** under **Member Of**, and then type the domain name. Click **OK**.
    5. When you are prompted, type the user name and password of the account that you previously created, and then click **OK**.

        A message that welcomes you to the domain is generated.
    6. Click **OK** to return to the Computer Name tab, and then click **OK** to finish.
    7. Restart the computer if you are prompted to do so.

## Troubleshooting: You cannot open the Active Directory snap-ins

After you have completed the installation of Active Directory, you may not be able to start the Active Directory Users and Computers snap-in, and you may receive an error message that indicates that no authority can be contacted for authentication. This can occur if DNS is not correctly configured. To resolve this issue, verify that the zones on your DNS server are configured correctly and that your DNS server has authority for the zone that contains the Active Directory domain name. If the zones appear to be correct and the server has authority for the domain, try to start the Active Directory Users and Computers snap-in again. If you receive the same error message, use the DCPROMO utility to remove Active Directory, restart the computer, and then reinstall Active Directory.

For more information about configuring DNS on Windows Server 2003, see [How to configure DNS for Internet access in Windows Server 2003](https://support.microsoft.com/help/323380).
