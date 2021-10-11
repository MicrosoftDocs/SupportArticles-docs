---
title: Find the current Active Directory Schema Version
description: Describes how to find the current Schema Version.
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:schema-update-known-issues-best-practices-workflow-review, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to find the current Schema Version

This article describes how to find the current Schema Version. The original author of the article was [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 558112

## How to find the current Active Directory Schema Version

To find the current Active Directory Schema Version, you can use one of the following methods:  

> [!Note]
> The internal root domain that we use in this demo is: **contoso.local**.

### Method 1

1. Use *ADSIEdit.msc* or *LDP.exe* to navigate to:  
    **CN=Schema,CN=Configuration,DC=contoso,DC=local**.

2. Review the **objectVersion** attribute.

### Method 2

Use the `DSQuery` command line. Run the following command:

```console
dsquery * "cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr objectVersion
```

### Method 3

Use the `Get-ItemProperty` PowerShell cmdlet. Run the following command:

```powershell
Get-ItemProperty 'AD:\CN=Schema,CN=Configuration,DC=contoso,DC=local' -Name objectVersion
```

### Some "objectVersion" attribute map

The following information provides a mapping between the **objectVersion** attribute value to the Active Directory Schema commutability:

13 -> Windows 2000 Server  
30 -> Windows Server 2003 RTM, Windows 2003 With Service Pack 1, Windows 2003 With Service Pack 2  
31 -> Windows Server 2003 R2  
44 -> Windows Server 2008 RTM
87 -> Windows Server 2016
88 -> Windows Server 2019

## How to find the current Exchange Schema Version

To find the current Exchange Schema Version, you can use one of the following methods:  

>[!Note]
>The internal root domain that we use in this demo is: **contoso.local**.

### Method 1

1. Use *ADSIEdit.msc* or *LDP.exe* tools to navigate to  
   **CN=ms-Exch-Schema-Version-Pt, CN=Schema,CN=Configuration,DC=contoso,DC=local**

2. Review the current "**rangeUpper**" attribute.

### Method 2

Ues **DSQuery** command line:

```console
dsquery * "CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr rangeUpper
```

### Some "rangeUpper" attribute map

The following information provides a mapping between the **rangeUpper** attribute value, to the Exchange Schema commutability:

4397 -> Exchange Server 2000 RTM  
4406 -> Exchange Server 2000 With Service Pack 3  
6870 -> Exchange Server 2003 RTM  
6936 -> Exchange Server 2003 With Service Pack 2  
10628 -> Exchange Server 2007  
11116 -> Exchange 2007 With Service Pack 1  

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
