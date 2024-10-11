---
title: Error 80070520 when deploying Operations Manager agents
description: Fixes an issue in which you get error 0x80070520 (ERROR_NO_SUCH_LOGON_SESSION) when you deploy Operations Manager agents by using the Install-SCOMAgent cmdlet.
ms.date: 04/15/2024
ms.reviewer: timhe, adoyle, cwallen
---
# Deploying Operations Manager agents using the Install-SCOMAgent cmdlet fails with error 80070520

This article helps you fix an issue in which you get error 0x80070520 (ERROR_NO_SUCH_LOGON_SESSION) when you deploy Operations Manager agents by using the `Install-SCOMAgent` cmdlet.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2627700

## Symptoms

Deploying agents from the Operations Manager shell using the `Install-SCOMAgent` cmdlet results in error 0x80070520 (ERROR_NO_SUCH_LOGON_SESSION), with the description **A specified logon session does not exist. It may already have been terminated**. Event ID 10612 in the Operations Manager event log is also logged:

> Event Type: Error  
> Event Source: Health Service Modules  
> Event Category: None  
> Event ID: 10612  
> Description:  
> The Operations Manager Server failed to perform specified operation on computer MANAGEMENTSERVER.FQDN.
>
> Operation: Agent Install  
> Install account: DOMAIN\ACCOUNT  
> Error Code: 80070520  
> Error Description: A specified logon session does not exist. It may already have been terminated.

## Cause

The error is returned when an attempt is made to store the credentials used to deploy the agent in a context that is not permitted. This can be a result of a policy setting, or the inability to store the credentials under the LocalSystem account.

## Resolution

To check if this issue is policy-related, on the management server specified when calling the `Install-SCOMAgent` cmdlet, open **Local Security Policy** from **Administrative Tools**. Navigate to **Local Polices** > **Security Options**. Make sure that the policy **Network access: Do not allow storage of passwords and credentials for network authentication** is **disabled**.

This policy controls the following registry value:

- Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa`
- Value: `disabledomaincreds`
- Setting: **0** - disabled, **1** - enabled

The other possibility is that the credentials are attempting to be stored under the LocalSystem account that is not possible. Check the default action account profile for the management server specified when calling the `Install-SCOMAgent` cmdlet. If the management server's default action account is set to LocalSystem, change it to a domain account with the appropriate permissions. This also applies to gateway servers being used to deploy agents as well.

## More information

- [Network access: Do not allow storage of credentials or .NET Passports for network authentication](/previous-versions/windows/it-pro/windows-server-2003/cc779377(v=ws.10))
- [Account Information for Operations Manager 2007](/previous-versions/system-center/operations-manager-2007-r2/bb735419(v=technet.10))
