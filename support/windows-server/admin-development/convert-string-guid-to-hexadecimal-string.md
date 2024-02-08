---
title: Convert string formatted GUID to hexadecimal string form
description: Describes how to convert a string formatted GUID (for example, {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}) to its hexdecimal string form for use in a GUID bind string in the Active Directory.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-services-interface-adsi, csstroubleshoot
---
# Convert a String Formatted GUID to a Hexadecimal String Form For Use When Querying the Active Directory

This article describes how to convert a string formatted GUID (for example, {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}) to its hexdecimal string form for use in a GUID bind string in the Active Directory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 325648

To convert a string formatted GUID to its hexadecimal string form, follow these steps:

1. Paste the following code into a .vbs file.

    ```vbscript
    '================================================================
    ' Replace the value of strGUID with an actual GUID
    '================================================================
    strGUID = "{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}"  
    Set obj = GetObject("LDAP://<GUID=" & ConvertStringGUIDToHexStringGUID(strGUID) & ">")
    MsgBox "The octet guid for " & obj.Get("displayname") & " is " & obj.GUID

    '================================================================
    ' ConvertGUIDtoOCTET function
    '================================================================
    Function ConvertStringGUIDToHexStringGUID(strGUID)
     Dim octetStr, tmpGUID

    For i = 0 To Len(strGUID)
     t = Mid(strGUID, i + 1, 1)
     Select Case t
     Case "{"
     Case "}"
     Case "-"
     Case Else
     tmpGUID = tmpGUID + t
     End Select
     Next

    octetStr = Mid(tmpGUID, 7, 2)' 0
     octetStr = octetStr + Mid(tmpGUID, 5, 2)' 1
     octetStr = octetStr + Mid(tmpGUID, 3, 2)' 2
     octetStr = octetStr + Mid(tmpGUID, 1, 2)' 3
     octetStr = octetStr + Mid(tmpGUID, 11, 2)' 4
     octetStr = octetStr + Mid(tmpGUID, 9, 2)' 5
     octetStr = octetStr + Mid(tmpGUID, 15, 2)' 6
     octetStr = octetStr + Mid(tmpGUID, 13, 2)' 7
     octetStr = octetStr + Mid(tmpGUID, 17, Len(tmpGUID))

    ConvertGUIDtoOCTET = octetStr
    End Function
    ```

2. Run the script.
