---
title: Finding the current Active Directory Schema Version
description: Describes how to find the current Schema Version.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:schema-update-known-issues-best-practices-workflow-review, csstroubleshoot
---
# Finding the current Schema Version

This article describes how to find the current Schema Version. The original author of the article was [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 558112

## Find the current Active Directory Schema Version

To find the current Active Directory Schema Version, you can use one of the following methods:  

> [!Note]
> The internal root domain that we use in this demo is **contoso.local**.

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

### "objectVersion" attribute to Operating System

The following information provides a mapping between the **objectVersion** attribute value and the Active Directory Schema commutability:

| Version | Operating System |
|---|---|
|13|Windows 2000 Server|
|30|Windows Server 2003 RTM, Windows 2003 Service Pack 1, Windows 2003 Service Pack 2|
|31|Windows Server 2003 R2|
|44|Windows Server 2008 RTM|
|47|Windows Server 2008 R2|
|56|Windows Server 2012|
|69|Windows Server 2012 R2|
|87|Windows Server 2016|
|88|Windows Server 2019|
|88|Windows Server 2022|

## Find the current Exchange Schema Version

To find the current Exchange Schema Version, you can use one of the following methods:  

>[!Note]
>The internal root domain that we use in this demo is **contoso.local**.

### Method 1

1. Use *ADSIEdit.msc* or *LDP.exe* to navigate to:  
   **CN=ms-Exch-Schema-Version-Pt, CN=Schema,CN=Configuration,DC=contoso,DC=local**

2. Review the current **rangeUpper** attribute.

### Method 2

Use the `DSQuery` command line:

```console
dsquery * "CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr rangeUpper
```

### Method 3

Run the `Get-ItemProperty` PowerShell cmdlet:

```powershell
Get-ItemProperty "AD:\CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,$((get-addomain).DistinguishedName)" -Name rangeUpper
```

### Some "rangeUpper" attribute map

The following articles provide a mapping between the **rangeUpper** attribute value and the Exchange Schema commutability:

- [Exchange 2016 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2016&preserve-view=true#exchange-2016-active-directory-versions)
- [Exchange 2019 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2019&preserve-view=true#exchange-2019-active-directory-versions)

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
