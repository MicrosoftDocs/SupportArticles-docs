---
title: Net Commands for Operating Systems
description: Provides some information about Net Commands on Operating Systems.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Net Commands On Operating Systems

This article provides some information about Net Commands on Operating Systems.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 556003

This article was written by [Nirmal Sharma](https://mvp.microsoft.com/en-US/PublicProfile/33635?fullName=Nirmal%20K%20Sharma%20%28Ratawa%29), Microsoft MVP.

## Summary

*The following knowledgebase will explain the uses of Net commands in Windows Operating Systems.*  

## More information

Net Commands On Windows Operating Systems

The following Net Commands can be used to perform operations on Groups, users, account policies, shares, and so on.

### NET  

ACCOUNTS  
COMPUTER  
CONFIG  
CONTINUE  
FILE  
GROUP  
HELP  
HELPMSG  
LOCALGROUP  
NAME  
PAUSE  
PRINT  
SEND  
SESSION  
SHARE  
START  
STATISTICS  
STOP  
TIME  
USE  
USER  
VIEW  

The "Net Accounts" command is used to set the policy settings on local computer, such as Account policies and password policies. This command can't be used on domain controller. This command is only used on local computer.

When you type Net Accounts, you will see the default settings of the Account Lockout policy and Password Policy in local computer show as:

```output
Force user logoff how long after time expires?: Never  
Minimum password age (days): 1  
Maximum password age (days): 90  
Minimum password length: 8  
Length of password history maintained: 5  
Lockout threshold: 4  
Lockout duration (minutes): 4  
Lockout observation window (minutes): 4  
Computer role: WORKSTATION
```

The above settings displayed as per the role of the computer. If computer is joined to a domain, the domain settings will take effect and only the settings coming from domain will be displayed. The rest settings will be the local settings if it's not coming from the Domain GPO.

You can change the following use the following options in Net Accounts option:

```console
NET ACCOUNTS  
[/FORCELOGOFF:{minutes | NO}]  
[/MINPWLEN:length]  
[/MAXPWAGE:{days | UNLIMITED}]  
[/MINPWAGE:days]  
[/UNIQUEPW:number] [/DOMAIN]
```

Two conditions are required in order for options used with NET ACCOUNTS to take effect:

`/FORCELOGOFF:{minutes | NO}` Sets the number of minutes a user has before being forced to log off when the account expires or valid logon hours expire. NO, the default, prevents forced logoff.

`/MINPWLEN:length` Sets the minimum number of characters for a password. The range is 0-14 characters; the default is six characters.

`/MAXPWAGE:{days | UNLIMITED}` Sets the maximum number of days that a
password is valid. No limit is specified by using UNLIMITED. /MAXPWAGE can't be less than /MINPWAGE. The range is 1-999; the default is 90 days.

`/MINPWAGE:days` Sets the minimum number of days that must pass before a user can change a password. A value of zero sets no minimum time. The range is 0-999; the default is zero days. /MINPWAGE can't be more than /MAXPWAGE.\

`/UNIQUEPW:number` Requires that a user's passwords be unique through the specified number of password changes. The maximum value is 24.

`/DOMAIN` Performs the operation on a domain controller of the current domain. Otherwise, the operation is performed on the local computer.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
