---
title: Find the current Schema Version
description: Describes how to find the current Schema Version.
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Schema update - known issues, best practices, workflow review
ms.technology: windows-server-active-directory
---
# How to find the current Schema Version

This article describes how to find the current Schema Version.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 558112

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Summary

The following articles will help you to find the current Schema Version.

## Tips

To find the current Active Directory Schema Version, you can use one of the following methods:  

>[!Note]
>The internal root domain that we use in this demo is: "**domain.local**".

1. Using "**ADSIEdit.msc**" or/and "**LDP.exe**" tools:

    Navigate to:

    "**CN=Schema,CN=Configuration,DC=domain,DC=local**"

    and review the current "**objectVersion**" attribute.

2. Using "**DSQuery**" command line:

    "**dsquery * cn=schema,cn=configuration,dc=domainname,dc=local -scope base -attr objectVersion**"

    The following information provides a mapping between the "**objectVersion**" attribute value, to

    the Active Directory Schema commutability:

    13 -> Windows 2000 Server  
    30 -> Windows Server 2003 RTM, Windows 2003 With Service Pack 1, Windows 2003 With Service Pack 2  
    31 -> Windows Server 2003 R2  
    44 -> Windows Server 2008 RTM

To find the current Exchange Schema Version, you can use one of the following methods:  

>[!Note]
>The internal root domain that we use in this demo is: "**domain.local**".

1. Using "**ADSIEdit.msc**" or/and "**LDP.exe**" tools:

    Navigate to:

    "**CN=ms-Exch-Schema-Version-Pt,** **CN=Schema,CN=Configuration,DC=domain,DC=local**"

    and review the current "**rangeUpper**" attribute.

2. Using "**DSQuery**" command line:

    "**dsquery * CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,dc=domain,dc=local -scope base -attr  
    rangeUpper**"

    The following information provides a mapping between the "**rangeUpper**" attribute value, to

    the Exchange Schema commutability:

    4397 -> Exchange Server 2000 RTM  
    4406 -> Exchange Server 2000 With Service Pack 3  
    6870 -> Exchange Server 2003 RTM  
    6936 -> Exchange Server 2003 With Service Pack 2  
    10628 -> Exchange Server 2007  
    11116 -> Exchange 2007 With Service Pack 1  

    Schema Changes Between Exchange 2000 Server and Exchange Server 2003

    Exchange 2007 Schema Changes (SP1)

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
