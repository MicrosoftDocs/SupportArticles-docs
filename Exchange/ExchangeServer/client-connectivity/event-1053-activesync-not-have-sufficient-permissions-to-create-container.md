---
title: Event ID 1053 Exchange ActiveSync doesn't have sufficient permissions to create container
description: Describes an issue that occurs when an Exchange Server user tries to synchronize an Exchange ActiveSync device for the first time. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mhendric, exchblt, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange ActiveSync users can't synchronize an EAS device for the first time in an Exchange Server environment

_Original KB number:_ &nbsp;2579075

## Symptoms

A user can't synchronize a Microsoft Exchange ActiveSync (EAS) device for the first time.

When this issue occurs, the following event is logged in the Application log in Event Viewer:

```console
Source: MSExchange ActiveSync
Event ID: 1053
Task Category: Configuration
Description:

Exchange ActiveSync doesn't have sufficient permissions to create the "CN=MailboxName,OU=OrganizationalUnitName,DC=domain,DC=suffix" container under Active Directory user "Active Directory operation failed on DOMAINCONTROLLER.domain.suffix. This error is not retriable. Additional information: Access is denied.

Active directory response: 00000005: SecErr: DSID-031521D0, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0".

Make sure the user has inherited permission granted to domain\Exchange Servers to allow List, Create child, Delete child of object type "msExchangeActiveSyncDevices" and doesn't have any deny permissions that block such operations.
```

## Cause

This issue can occur if the Owner Rights security principal doesn't have Full control permissions on the user account that's trying to synchronize the EAS device.

## Resolution

To work around this issue, assign the Exchange Servers group the right to change permissions against `msExchActiveSyncDevices` objects. To do this, follow these steps:

1. Start Active Directory Users and Computers.
1. Click **View**, and then click to enable **Advanced Features**.
1. Right-click the object where you want to change the Exchange Server permissions, and then click **Properties**.
    > [!NOTE]
    > You can change permissions against a user, an organizational unit, or a domain.
1. On the **Security** tab, click **Advanced**.
1. Click **Add**, type *Exchange Servers*, and then click **OK**.
1. In the **Apply to** box, click **Descendant msExchActiveSyncDevices objects**.
1. Under **Permissions**, click to enable **Modify Permissions**.
1. Click **OK** three times.

## More information

The first time that a user tries to synchronize an EAS device, the Exchange Server tries to create a container of the type `msExchActiveSyncDevices` under the user object in Active Directory Domain Services (AD DS). The Exchange Server then tries to change permissions on the container.

By default, the Exchange Server group has rights to create and delete `msExchActiveSyncDevices` objects. However, the Exchange Server group doesn't have rights to change permissions on `msExchActiveSyncDevices`. Instead, the rights are inherited from the Owner Rights security principal. By default, the Owner Rights security principal has Full control permissions.

If the permissions for the Owner Rights security principal are changed, the issue that's described in the "Symptoms" section can occur. For example, this issue can occur if the Owner Rights security principal has read permissions on `msExchActiveSyncDevices` objects.

The [Troubleshoot ActiveSync with Exchange Server guided walkthrough](https://support.microsoft.com/help/10047/troubleshoot-activesync-with-exchange-server) helps troubleshoot the following issues:

- Unable to create a profile on the device
- Unable to connect to the server
- Mail issues
- Calendaring issues
- Delays on device/CAS performance

For more information about the Owner Rights security principal in AD DS, see [AD DS: Owner Rights](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd125370(v=ws.10)).