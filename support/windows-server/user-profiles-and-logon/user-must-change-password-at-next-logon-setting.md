---
title: Not Able to Change Password
description: Provides some information about the issue that user may not be able to change their password, if you configure the 'User Must Change Password at Next Logon' setting.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:User Logon and Profiles\User profiles, csstroubleshoot
---
# User may not be able to change their password if you configure the 'User must change password at next logon' setting

This article provides some information about the issue that user may not be able to change their password, if you configure the 'User must change password at next logon' setting.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 320325

## Summary

If you are an administrator, you can configure the **User must change password at next logon** setting on a user account if you reset a password. If you do so, the user is required to change their password the next time they log on. However, if you configure this setting and the user is prompted to change their password, replication latency may cause the user to receive a message that states that their old password is incorrect after they type their old password. This article describes a scenario in which this issue occurs.

## More information

If you reset a user's password, you can configure the
 **User must change password at next logon** setting. Typically, you perform this operation on the primary domain controller (PDC) operations master, which may be located in a site that is different from the site that the user is logging on to. Therefore, replication latency may occur, which may cause the symptoms that are described in the preceding section. The following scenario describes this issue:

1. The user forgets their password (for example,
 **password1**), and then you reset the password to
 **password2**.
2. The user in the remote site uses the newly reset password (**password2**) to log on to their local domain controller (the remote domain controller).
3. The remote domain controller does not recognize
 **password2** as the password (it knows only
 **password1**). The domain controller forwards (chains) the logon request to the PDC operations master.
4. The PDC operations master satisfies the logon request, and then passes a message to the remote domain controller that states that the user must change their password.
5. This message is passed back to the client computer, which prompts the user to change their password.
6. When a user is prompted to change their password, they are asked for the old password and a new password. In this case, the user types the newly reset password (**password2**) as the old password, and then types a new password.
7. The client contacts the remote domain controller again (because this domain controller is in the same site as the client) to change the password. However, the remote domain controller has the password that the user was using at the time that they asked you to reset the password (**password1**), and does not recognize
 **password2** as the old password.
8. Because **password2** is not the correct old password (according to the remote domain controller), the password change operation fails. However, after the newly reset password (**password2**) is replicated to the remote domain controller, if the user enters **password2** when they are prompted to enter the old password, the password change operation is successful.

>[!NOTE]
>You can reduce network latency by changing the password for the user on a domain controller in the site that the user is logging on to. To change the focus of the Active Directory Users & Computers snap-in to a domain controller in the site, right-click the top of the left pane of the Active Directory Users & Computers snap-in, and then click **Connect to Domain Controller**. You can now locate a domain controller in the site that the user is in and change the password.
