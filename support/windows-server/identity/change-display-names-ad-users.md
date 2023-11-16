---
title: Change display names of AD users
description: Describes how to change display names of Active Directory users.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, MARCOSA
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to change display names of Active Directory users

This article describes how to change display names of Active Directory (AD) users.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 250455

## Summary

When a new user is created in Active Directory, the Full name field is always generated in FirstName LastName format. In turn, this field sets the Display Name field on creation, so you end up with a FirstName LastName formatted global address list.

You can make this change by using the Adsiedit utility. Adsiedit not only changes the default way the Display Name field is built, but also the Full Name (that is, the "cn") field, that's why users appear in the chosen format when you look in the Users and Computers snap-in.

## ADSIEdit Instructions

> [!WARNING]
> If you use the ADSI (Active Directory Service Interfaces) Edit snap-in, the LDP utility, or any other LDAP (Lightweight Directory Access Protocol) version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Windows Server 2003, Microsoft Exchange 2000 Server, Microsoft Exchange Server 2003, or both Windows and Exchange. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.  

1. Insert your Windows 2000 Server CD.
2. Navigate to the `\support\tools` directory.
3. Double-click on the Support.cab file.
4. Locate the files adsiedit.msc and adsiedit.dll. Extract them to your `%systemroot%\system32` directory.
5. Run regsvr32 adsiedit.dll.
6. Start Microsoft Management Console (MMC), and then add the ADSI Edit snap-in.
7. Right-click the top node, and then select **Connect to**.
8. Change the Naming Context to **Configuration Container**, and then select **OK** to bind and authenticate.
9. Expand the Configuration Container node, and then expand the Configuration node.
10. Expand the cn=DisplaySpecifiers node, and then double-click **CN=409**.
    > [!NOTE]
    > 409 is the Locale ID for U.S. English. If you are in a multi-lingual environment, you may need to make changes to the other codes. Most of the Asian codes are already set.

    The International Telecommunication Union (ITU) and International Organization for Standardization (ISO) define the code pages. For more information, visit the [ITU Web pages](http://www.itu.int)

11. In the right-hand pane, open the properties for **CN=user-Display**.
12. Scroll to the createDialog optional property.
13. Set the attribute to **%<*sn*>.%<*givenName*>**. Make sure that you select **Set**.

    > [!NOTE]
    > The only tokens that can be formatted in the dislayName are %\<sn>, %\<givenName>, and %\<initials>.
14. Select **OK** to close the dialog box.
15. In Active Directory Users and Computers, create a new User; the Full Name (and thus, the Display Name) are built in accordance with your rule.

Making these changes can have adverse effects.

## Notes

- The instructions show you how to modify user objects. There's a separate setting for Contacts--change step 11 to "contact-Display".
- You don't need to close the Users and Computers snap-in; changes are picked up automatically.
- In multi-domain controller environments, you may need to wait for replication to complete before the user interface picks up the changes.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
