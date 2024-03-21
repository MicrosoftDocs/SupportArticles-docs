---
title: How to reset the Directory Services Restore Mode administrator account password
description: Describes how to reset the DSRM administrator password for any server in your domain without restarting the server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jamirc, kaushika
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# How to reset the Directory Services Restore Mode administrator account password in Windows Server

This article describes how to reset the Directory Services Restore Mode (DSRM) administrator password for any server in your domain without restarting the server in DSRM.

_Applies to:_ &nbsp; Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 322672

## Summary

Microsoft Windows 2000 uses the Setpwd utility to reset the DSRM password. In newer versions of Microsoft Windows Server, that functionality has been integrated into the NTDSUTIL tool. Note that you can't use the procedure that is described in this article if the target server is running in DSRM. A member of the Domain Administrators group sets the DSRM administrator password during the promotion process for the domain controller. You can use Ntdsutil.exe to reset this password for the server on which you're working, or for another domain controller in the domain.

## Reset the DSRM administrator password

1. Click **Start** > **Run**, type *ntdsutil*, and then click **OK**.
2. At the Ntdsutil command prompt, type *set dsrm password*.
3. At the DSRM command prompt, type one of the following lines:

    - To reset the password on the server on which you're working, type *reset password on server null*. The null variable assumes that the DSRM password is being reset on the local computer. Type the new password when you're prompted. Note that no characters appear while you type the password.

    -or-
    - To reset the password for another server, type *reset password on server **servername***, where **servername** is the DNS name for the server on which you're resetting the DSRM password. Type the new password when you're prompted. Note that no characters appear while you type the password.

4. At the DSRM command prompt, type *q*.
5. At the Ntdsutil command prompt, type *q* to exit.
