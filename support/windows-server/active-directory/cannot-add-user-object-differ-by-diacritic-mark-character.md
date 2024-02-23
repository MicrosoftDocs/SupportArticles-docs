---
title: Can't add user or object to directory service
description: Describes the problem that may occur when you try to add a user or an object to Active Directory. If the user name or the object name contains certain special German characters, you may receive an error message. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# You cannot add a user name or an object name that only differs by a character with a diacritic mark

This article provides a solution to an issue where you can't add a user name or an object name that only differs by a character with a diacritic mark.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 938447

## Symptoms

You try to add a new user or a new object to the Active Directory directory service. However, the user or the object is not added. Additionally, you may receive any one of the following error messages:

- Error message 1:

    > The object **username** could not be created.  
    The problem encountered was;  
    An attempt was made to add an object to the directory with a name that is already in use.

- Error message 2:

    > Windows cannot create the new user object because the name **username** is already in use. Select another name, and try again.

- Error message 3:
    > Windows cannot create the specified object because: The specified user already exists.

- Error message 4:

    > The user logon name you have chosen is already in use in this enterprise. Choose another logon name, and then try again.

> [!NOTE]
> In these error messages, **username** is the name of the user or of the object that you tried to add.

## Cause

This problem occurs because the user name or the object name contains diacritic marks, for example, German umlauts. A German umlaut character contains a dieresis over the base character itself, such as in the following characters:

- :::no-loc text="Ä ä":::
- :::no-loc text="Ö ö":::
- :::no-loc text="Ü ü":::

The German umlaut characters are interpreted to be the same as their base characters. For example, the ü character is interpreted to be the same as the u character. When this problem occurs, a user who is named :::no-loc text="Muller"::: cannot be created if a user who is named :::no-loc text="Müller"::: already exists. Similarly, a user who is named :::no-loc text="Meissner"::: cannot be created if a user who is named :::no-loc text="Meißner"::: already exists.

## Resolution

To resolve this problem, use a different name for the user or for the object that you want to add.

## Status

This behavior is by design.

## More information

Microsoft has published rules for valid characters for various object types that further reduces the freedom of name choice. For more information, see [Naming conventions in Active Directory for computers, domains, sites, and OUs](naming-conventions-for-computer-domain-site-ou.md).
