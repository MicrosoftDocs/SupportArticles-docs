---
title: Appointments, contacts, and tasks for the mailbox couldn't be synchronized error
description: Works around an email server error code 383 that occurs when appointments aren't synchronized from Microsoft Dynamics 365 to Exchange for some users.
ms.reviewer: 
ms.date: 12/09/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "Appointments, contacts, and tasks for the mailbox couldn't be synchronized" error occurs in Dynamics 365

This article provides a workaround for the issue that appointments aren't synchronized from Microsoft Dynamics 365 to Microsoft Exchange for some users.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4494491

## Symptoms

Appointments aren't synchronized from Dynamics 365 to Exchange for some users. If you [view the Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) for a corresponding mailbox in Dynamics 365, you see the following alert message:

> Appointments, contacts, and tasks for the mailbox \<Mailbox Name> couldn't be synchronized. The owner of the associated email server profile \<Profile Name> has been notified. The system will try again later.  
> **Email Server Error Code:** Exchange.server returned 383 error.

## Cause

Microsoft is aware of an [issue with the Exchange Web Services API](https://github.com/OfficeDev/ews-managed-api/issues/161) that can cause this error if one of the following time zones are used:

- (GMT-05:00) Chetumal - Eastern Standard Time (Mexico)
- (GMT-03:00) Montevideo - Montevideo Standard Time
- (GMT+01:00) Casablanca - Morocco Standard Time
- (GMT+02:00) Cairo - Egypt Standard Time
- (GMT+02:00) Kaliningrad - Kaliningrad Standard Time
- (GMT+02:00) Windhoek - Namibia Standard Time
- (UTC+02:00) Khartoum - Sudan Standard Time
- (GMT+03:00) Baghdad - Arabic Standard Time
- (UTC+03:00) Istanbul - Türkiye Standard Time
- (GMT+03:00) Minsk - Belarus Standard Time
- (GMT+04:00) Astrakhan, Ulyanovsk - Astrakhan Standard Time
- (GMT+04:00) Baku - Azerbaijan Standard Time
- (GMT+04:00) Izhevsk, Samara - Russia Time Zone 3
- (GMT+04:00) Moscow, St. Petersburg, Volgograd - Russian Standard Time
- (GMT+04:00) Yerevan - Caucasus Standard Time
- (GMT+05:00) Ekaterinburg - Ekaterinburg Standard Time
- (GMT+07:00) Barnaul, Gorno-Altaysk - Altai Standard Time
- (GMT+07:00) Hovd - W. Mongolia Standard Time
- (GMT+07:00) Krasnoyarsk - North Asia Standard Time
- (GMT+07:00) Novosibirsk - N. Central Asia Standard Time
- (GMT+07:00) Tomsk - Omsk Standard Time
- (GMT+07:00) Tomsk - Tomsk Standard Time
- (GMT+08:00) Irkutsk - North Asia East Standard Time
- (GMT+09:00) Chita - Transbaikal Standard Time
- (GMT+09:00) Yakutsk - Yakutsk Standard Time
- (GMT+10:00) Vladivostok - Vladivostok Standard Time
- (GMT+11:00) Bougainville Island - Bougainville Standard Time
- (GMT+11:00) Chokurdakh - Russia Time Zone 10
- (GMT+11:00) Magadan - Magadan Standard Time
- (GMT+11:00) Norfolk Island - Norfolk Standard Time
- (GMT+11:00) Sakhalin - Sakhalin Standard Time
- (GMT+12:00) Anadyr, Petropavlovsk-Kamchatsky - Russia Time Zone 11

## Workaround

If you're in one of the impacted time zones, you can work around the issue by changing the user's time zone setting in Dynamics 365:

1. A Dynamics 365 user can access their personal options by selecting the gear icon in the upper-right corner of Dynamics 365 and then selecting **Options**.

2. If the **Time Zone** value is one of the time zones listed in the **Cause** section of this article, update the value to another time zone that has the same time offset but isn't in the list.

   For example, if you're using **(GMT-05:00)** Chetumal, you could try switching to **(GMT-05:00)** Havana.

3. Select **OK**.

4. The appointments should synchronize on the next synchronization cycle for the mailbox, which might take 15 to 30 minutes.

## More information

[Synchronization logic for appointments, contacts, and tasks](/power-platform/admin/sync-logic)
