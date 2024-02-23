---
title: Some Android devices do not redirect to Exchange Online
description: Resolves an issue that prevents Android devices from setting up an Exchange account after you've installed Exchange Server 2010 SP3 RU9, Exchange Server 2013 CU8, or Exchange Server 2016 on the server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, jmartin, genli, jamesmi, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Some Android devices do not redirect to Exchange Online

_Original KB number:_ &nbsp; 3035227

## Symptoms

Some Android devices stop receiving new messages after the user's mailbox is moved to Exchange Online.

## Cause

This occurs if the Android device doesn't support the MobileSyncRedirectBypass feature.

Beginning with Exchange Server 2010 SP3 RU9, Exchange Server 2013 CU8, and Exchange Server 2016, a new MobileSyncRedirectBypass feature was introduced in the Autodiscover service for Android devices.

By default, this feature is enabled for devices that have the following prefixes:

> Acer,ADR9,Ally,Amazon,Android,ASUS,EasClient,FUJITSU,HTC,HUAWEI,LG,LS,Moto,Mozilla,NEC,Nokia,Palm,PANASONIC,PANTECH,Remoba,Samsung,SEMC,SHARP,SONY-,TOSHIBA,Vortex,VS,ZTE

The most recent list of known Android devices that understand this feature can be found in the **MobileSyncRedirectBypassClientPrefixes** setting in the Autodiscover web.config file. This file is located in the *%ExchangeInstallPath%\ClientAccess\Autodiscover* folder.

> [!NOTE]
> The MobileSyncRedirectBypass feature is generally known as **451 redirect**. For more information, see [3.1.5.2.2 HTTP Error 451](/openspecs/exchange_server_protocols/ms-ashttp/a907164a-907c-48b4-b2ef-44a06867f03f).

## Workaround

If the device isn't in the **MobileSyncRedirectBypassClientPrefixes** setting in the Autodiscover web.config file, do one of the following:

- Manually edit the server value for the Exchange ActiveSync (EAS) profile after the mailbox is moved to Microsoft 365.
- Test to determine whether the device supports the MobileSyncRedirectBypass feature. If the device supports the feature, edit the **MobileSyncRedirectBypassClientPrefixes** setting across all Exchange servers in the environment.

For more information, see [Exchange ActiveSync on-boarding to Microsoft 365](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-activesync-on-boarding-to-office-365/ba-p/610980).
