---
title: Current issues with Microsoft Exchange ActiveSync and third-party devices
description: Discusses current issues that involve Microsoft Exchange ActiveSync and third-party devices.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
---

# Current issues with Microsoft Exchange ActiveSync and third-party devices

## Summary

Microsoft Exchange ActiveSync lets devices synchronize with your Inbox, your Calendar, and other items that have dedicated Microsoft Exchange Server mailboxes. This article describes common issues that affect third-party devices that synchronize with Exchange by using Exchange ActiveSync. These devices include Android and iOS devices. 

[Exchange ActiveSync Protocol Licensees](https://www.microsoft.com/en-us/legal/intellectualproperty/mtl/technologylicensing.aspx) provide the Exchange ActiveSync software that is used on the third-party devices. Microsoft does not write the Exchange ActiveSync code for the licensees’ devices or services. Microsoft licenses patents to Exchange ActiveSync licensees. These patents are Microsoft intellectual property. Additionally, Microsoft provides public access to the [Exchange ActiveSync protocol documentation](https://msdn.microsoft.com/library/cc425499%28v=exchg.80%29.aspx).

> [!NOTE]
> A protocol is a standard for communication between computers.

### What Microsoft can do, and what third parties can do

Microsoft can help in investigations of issues that involve mobile devices that are manufactured by third-party vendors. However, the implementation of the Exchange ActiveSync protocol on such devices cannot be changed or updated by Microsoft. 

Device-specific troubleshooting, updates to devices, and confirmation of causes of device-related issues can occur only through the device manufacturer. Additionally, some devices may not have a unified update strategy and may depend on carrier requests to create updates. Carriers then distribute those updates. Therefore, updates for specific device issues may not be timely. 

Microsoft may direct customers to contact their mobile device vendor or mobile carrier for help. See the "References" section for more information about third-party support engagement methods. Microsoft Support is always open to collaborative troubleshooting if a vendor must be engaged.

### How to become informed about mobile devices

When you evaluate the devices that are to be used in an Exchange Server organization that uses Exchange ActiveSync, you should make sure that you understand the features and capabilities of the devices. Not all devices support the same configuration options, and some devices may not support all features or versions of the Exchange ActiveSync protocol.

A community chart for [Comparison of Exchange ActiveSync clients](https://social.technet.microsoft.com/wiki/contents/articles/1150.exchange-activesync-client-comparison-table.aspx) is available on Wikipedia. Administrators and Helpdesk personnel should use public information and their own testing to understand device capabilities. To help address this, the Exchange team has created a new [Exchange ActiveSync Logo program](https://blogs.technet.com/b/exchange/archive/2011/04/13/announcing-the-exchange-activesync-logo-program.aspx) for devices that use Exchange ActiveSync.

We will update this document as we identify new issues that apply to third-party devices that use the Exchange ActiveSync protocol.

## More Information

The following is a list of current issues that you may encounter when you use Microsoft Exchange Server 2007 or Microsoft Exchange Server 2010 together with third-party devices. If you are using Exchange Server 2007 Service Pack 3 (SP3) or Exchange Server 2010 SP1 and are experiencing an issue that is not listed here, go to the [Microsoft Support](https://support.microsoft.com/) website.

We recommend that you update third-party devices to the latest software version. Be aware that some devices cannot be updated in some circumstances. 

Users of iOS devices can update their devices to the latest version of the iOS software. For more information, go to the [Apple iOS](https://www.apple.com/ios/) website.

The information and the solutions in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. These solutions are available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider. 

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.

The issues that are described in this article are divided into the following categories:

- Automatic meeting processing   
- Connectivity and synchronization failures   

### 1. Automatic meeting processing

#### Issue 1.17 - Meeting invites are forwarded by an attendee
 
Meeting attendees receive a forwarded meeting invite from another attendee for an existing meeting. 

[4014990](https://support.microsoft.com/help/4014990) - Meeting invites are forwarded by an attendee 

#### Issue 1.16 - Attendee receives meeting cancellation shortly before start time
 
An external attendee receives a meeting cancellation followed by a meeting update which corrects the original cancellation. Internal users may receive an additional meeting update.

[3165413](https://support.microsoft.com/help/3165413) - Attendees receive a meeting cancellation followed by a meeting update shortly before the start time  
 
#### Issue 1.15 - Meeting organizer receives multiple responses from attendee
 
The organizer of a meeting receives multiple responses from one or more attendees when they respond by using an iOS 9.**x** device.

For more information, go to the following article in the Microsoft Knowledge Base:

[3108212](https://support.microsoft.com/help/3108212) The organizer of a meeting receives multiple responses from an attendee 

#### Issue 1.14 - Attendees receive meeting update after reminder
 
Attendees receive a meeting update without any changes from the organizer after the reminder is triggered.

For more information, go to the following article in the Microsoft Knowledge Base:


[3108249](https://support.microsoft.com/help/3108249) Attendees receive a meeting update after the event is triggered 

#### Issue 1.13 - Calendar changes do not synchronize from device

Users of iOS 8.3 devices may experience issues in which changes to calendar items may not be synchronized to their mailbox. This causes the updates to be unavailable in Outlook or Outlook Web App (OWA). These issues were diagnosed as requiring changes to the iOS implementation of the Microsoft Exchange ActiveSync protocol.

For more information, go to the following article in the Microsoft Knowledge Base:
   

[3064000](https://support.microsoft.com/help/3064000) Calendar changes do not synchronize from device 

#### Issue 1.12 - Appointment in Outlook or OWA is missing on iOS device
 
When a user syncs a mailbox by using an iOS device, the calendar on the device may be missing one or more appointments. These appointments are available when you view the calendar from Outlook or OWA. There may also be duplicate instances of the appointment in the calendar if the appointment is accepted from the device.

For more information, go to the following article in the Microsoft Knowledge Base:

[3012590](https://support.microsoft.com/help/3012590) Instance of calendar appointment is missing or duplicated on ActiveSync client 
 Solution

Apply the iOS 8.2 update. Apple has documented the issue in the following article in the Apple Knowledge Base:

[https://support.apple.com/kb/DL1794](https://support.apple.com/kb/DL1794) 

#### Issue 1.11 - Known calendaring issues with iOS 8.**x** and iOS 7.**x** devices

Users of iOS 8.1, iOS 8.0.2, and iOS 8.0.1, iOS 7.1.2, iOS 7.0.4 devices (these are known collectively as 8.**x** and 7.**x** devices) may experience issues in which calendar items may be converted to plain text, may be truncated, or may generate multiple repair update messages. These issues were diagnosed as requiring changes to the iOS implementation of the Microsoft Exchange ActiveSync protocol.

Apple was made aware of this issue, and customers who experience any of the symptoms that are described here should contact Apple for help.
 
#### Details
 
Users of iOS 8.x devices may experience any of the following related symptoms: 
 
1. Meetings sent in Rich Text or HTML format have their message body converted to plain text. This is most noticeable with Lync meetings where the URLs will appear broken.

    This has been addressed in the iOS 8.2 update. For more information, see the following Apple Knowledge Base article:

    [https://support.apple.com/kb/DL1794](https://support.apple.com/kb/DL1794)     
2. Message body is truncated to 500 characters long. 

    This has been addressed in the iOS 8.2 update. For more information, see the following Apple Knowledge Base article: 

    [https://support.apple.com/kb/DL1794](https://support.apple.com/kb/DL1794)     
3. Multiple repair update messages indicating the Calendar Repair Assistant (CRA) has updated their meetings.

    This has been addressed in the iOS 8.3 update. For more information, see the following Apple Knowledge Base article:
 
    [https://support.apple.com/kb/DL1806](https://support.apple.com/kb/DL1806)     
 
Symptom 3 applies to iOS 7.x users, but not symptom 1 and symptom 2. Only iOS 8.x devices may experience all three symptoms. It may be possible to correct the formatting of the meetings by having the Meeting Organizer send an update to the meeting. No changes to the meeting item is required. The new meeting object will overwrite the existing object.

Meeting truncation may be avoided if the attendee accepts the meeting before changing the meeting properties with their iOS 8.x device. 

Meetings will be truncated if the attendee changes the meeting properties with their iOS 8.x device before accepting the item. Specifically, one of the following properties: 
 
1. Changes the Alert value    
2. Changes the Show As status    
3. Marks the appointment as Private    
4. Adds a Comment to Organizer    
 
Meeting repair update messages may appear in the attendee’s Inbox 12-48 hours after the attendee updated the meeting with their iOS 8.x or iOS 7.x device. CRA is attempting to correct a discrepancy introduced by the iOS 8.x devices on the time zone property of the attendee’s copy of the meeting. 
For more information, see the following article: 

[3019798](https://support.microsoft.com/help/3019798) Repair update messages received for TimeZoneMatchCheck failures 

#### Technical Details

Administrators can confirm truncation of the appointment body through a review of the ActiveSync mailbox log. Inside this log will be a Sync request that sends the Body element to Exchange with approximately 500 bytes. Example:

```asciidoc  
<Commands> <Change> <ServerId>1:8</ServerId> <ApplicationData> <Body=496 bytes/> <TimeZone xmlns="Calendar:">AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAACAAMAAAAAAAAAxP///w==</TimeZone> <AllDayEvent xmlns="Calendar:">0</AllDayEvent> <BusyStatus xmlns="Calendar:">1</BusyStatus> <DtStamp xmlns="Calendar:">20141029T115225Z</DtStamp> <EndTime xmlns="Calendar:">20141029T153000Z</EndTime> <Location xmlns="Calendar:" bytes="4"/> <Reminder xmlns="Calendar:">15</Reminder> <Sensitivity xmlns="Calendar:">2</Sensitivity>  
```

Administrators can confirm the client is changing the format of the body, through a Fiddler/Network trace. With the results of the trace, a request will be observed that shows the client sending the body in plain text. Example:  

```asciidoc
<airsync:Commands> <airsync:Change> <airsync:ServerId>1:13</airsync:ServerId> <airsync:ApplicationData> <airsyncbase:Body xmlns:airsyncbase="AirSyncBase:"> <airsyncbase:Type>1</airsyncbase:Type> <airsyncbase:Data>This is the link&lt;https://join.contoso.com/meeting/user2YVC3G3O&gt; for this meeting
```
  
#### More Information

These issues can be prevented by not using iOS 8.x clients to perform calendaring functions through Exchange ActiveSync. This can be done using one of the following methods: 
 
1. Use the OWA application inside of all iOS 8.x devices rather than Exchange ActiveSync.  
   - OWA for iPhone [https://itunes.apple.com/app/owa-for-iphone/id659503543?mt=8](https://itunes.apple.com/app/owa-for-iphone/id659503543?mt=8)    
   - OWA for iPad [https://itunes.apple.com/app/owa-for-ipad/id659524331?mt=8](https://itunes.apple.com/app/owa-for-ipad/id659524331?mt=8)    
     
2. Disable synchronization of the user’s calendar to all iOS 8.x devices.    
  
#### Issue 1.10 - Meetings that are scheduled for the end of the month do not appear on an iOS device

When a user syncs a mailbox by using an iOS device, and a recurring meeting is scheduled to occur on the 31st of every month, the meeting does not appear on the device for those months that do not have 31 days.

Cause

iOS does not honor the 31st-day recurrence pattern in the way that Outlook does. When a month does not have 31 days, Outlook displays the recurring meeting in the calendar on the last day of the month. However, iOS displays only those occurrences that land exactly on the 31st day. This behavior also occurs with recurring meetings for the 29th-day and 30th-day recurrence patterns. 

#### Issue 1.9 - An appointment does not update when you use Outlook in cached mode and room mailbox is an attendee

The following conditions cause an appointment not to update on an iOS device:

- The organizer is using Outlook in cached mode.    
- A room mailbox is listed as an attendee.    
- Calendar processing for the room mailbox is set to AutoAccept.    
- The organizer makes a change to an instance of a recurring meeting.
 
Cause

The client receives multiple responses for this appointment from Exchange. The first response has a later-modified time stamp than the second response that contains the new time for the meeting. The client should always apply the changes from the latest Sync response for an item. The modified time stamp is an optional element and should not be considered authoritative.

The following are examples from the ActiveSync mailbox log for a device:

First log entry
     
```asciidoc
<Exceptions xmlns="Calendar:"> <Exception> <DtStamp>20131112T184410Z</DtStamp> <StartTime>20131128T170000Z</StartTime> <EndTime>20131128T180000Z</EndTime> <ExceptionStartTime>20131128T170000Z</ExceptionStartTime> <MeetingStatus>1</MeetingStatus> </Exception> </Exceptions>
```
  
Second log entry

```asciidoc
<Exceptions xmlns="Calendar:"> <Exception> <DtStamp>20131112T184334Z</DtStamp> <StartTime>20131128T190000Z</StartTime> <EndTime>20131128T200000Z</EndTime> <ExceptionStartTime>20131128T170000Z</ExceptionStartTime> <Attendees> <Attendee> <Email bytes="30"/> <Name bytes="12"/> <AttendeeStatus>0</AttendeeStatus> <AttendeeType>1</AttendeeType> </Attendee> <Attendee> <Email bytes="30"/> <Name bytes="21"/> <AttendeeStatus>0</AttendeeStatus> <AttendeeType>3</AttendeeType> </Attendee> </Attendees> <MeetingStatus>1</MeetingStatus> </Exception> </Exceptions>  
```

Solution

Apply the iOS 8.2 update. Apple has documented this issue in the following article from the Apple Knowledge Base:

[https://support.apple.com/kb/DL1794](https://support.apple.com/kb/DL1794)

If this issue is not resolved by applying the iOS update, customers should remove the calendar from the list of folders to synchronize, wait several minutes, and then add the calendar back to the list of folders to synchronize.

#### Issue 1.8 - Rapid growth in transaction logs, CPU use, and memory consumption in Exchange Server 2010 when a user syncs a mailbox by using an iOS 6.1-based or iOS 6.1.1-based device
 
This issue has been resolved.

#### Issue 1.7 - Meetings are missing on some mobile devices, but are present in OWA and Outlook
 
This issue has been resolved.

#### Issue 1.6 - An appointment that is longer than 24 hours is changed to a multi-day All Day Event
 
This issue has been resolved.

#### Issue 1.5 - Recurring Exchange Calendar events are deleted
 
This issue has been resolved.

#### Issue 1.4 - An All Day Flag is not set correctly on mobile devices when a meeting is scheduled across multiple days
 
Mobile device clients do not treat a meeting request as an all-day event meeting request. Also, the **All Day** field is marked **No**.

Solution

This issue is resolved in Update Rollup 2 for Exchange 2007 Service Pack 3.

#### Issue 1.3 - Your meeting response to the organizer is displayed as if it was sent by someone else

This issue has been resolved.

#### Issue 1.2 - An attendee becomes the meeting organizer

When a user synchronize their iOS or Android device by using Exchange ActiveSync, they may unexpectedly become the organizer for a meeting to which they were invited. This does not change the meeting for all attendees.

This issue can occur if you change the reminder for a single occurrence of a recurring meeting on an iOS or Android device. There may be other changes to meeting items that cause the same problem.

Current issues (Exchange Online, Exchange 2016, Exchange 2013, Exchange 2010 and Exchange 2007)
Recent issues that have similar symptoms have been reported to Microsoft. These issues can affect users on all versions of Exchange Server. Currently, Microsoft cannot reduce the effect of these new issues. We encourage users to work with their device vendors to find a solution to the problem.

#### Issue 1.1 - A recurring meeting is removed from the calendar when the organizer cancels a single occurrence

Assume that you synchronize your iOS device by using Exchange ActiveSync on an Exchange Server 2007 mailbox. If the organizer cancels a single occurrence of a recurring meeting, the device may unexpectedly delete the whole recurring meeting.Solution

Follow these steps:

1. Install Update Rollup 4 for Exchange Server 2007 Service Pack 3. The problem details and the link to the update are documented in the following Microsoft Knowledge Base article:

    [2502276](https://support.microsoft.com/help/2502276) A meeting request series is deleted unexpectedly from the calendar in an Exchange Server 2007 environment   
2. Update the Apple iOS on your device to version 4.3 or a later version. For more information about the latest iOS version, go to the [Apple iOS](https://www.apple.com/ios) website.   

### 2. Connectivity and synchronization failures

#### Issue 2.18 - No search results or content displayed in public folder favorites in Outlook 2016
 
For more information, see the following article in the Microsoft Knowledge Base:

[3169741](https://support.microsoft.com/help/3169741) No search results or content displayed in public folder favorites in Outlook 2016
   
#### Issue 2.17 - Items missing on mobile device when synchronizing with Exchange ActiveSync
 
For more information, see the following article in the Microsoft Knowledge Base:

[3196954](https://support.microsoft.com/help/3196954) Items missing on mobile device when synchronizing with Exchange ActiveSync  
 
#### Issue 2.16 - Unable to create a mail profile on an iOS device by using Autodiscover
 
Mobile devices that are running iOS 7 and later are unable to automatically configure the default mail app in an Exchange Online mailbox or in on-premises Exchange Server. When a user tries to verify their account, a message is displayed that says that their identity can't be verified by Exchange. 

#### Issue 2.15 - Excessive Ping commands cause IIS log growth on Exchange 2010
 
There may be an increase in IIS log generation after users upgrade to the latest version of KitKat or Lollipop on their Samsung devices

Cause

The client sends a Ping request to Exchange for the RI (recipient information cache) folder that receives an invalid class exception. This request and response continues indefinitely.
     
```asciidoc
RequestBody : <?xml version="1.0" encoding="utf-8" ?> <Ping xmlns="Ping:"> <HeartbeatInterval>470</HeartbeatInterval> <Folders> <Folder> <Id>5</Id> <Class>Email</Class> </Folder> <Folder> <Id>11</Id> <Class>Email</Class> </Folder> <Folder> <Id>1</Id> <Class>Calendar</Class> </Folder> <Folder> <Id>RI</Id> <Class>Email</Class> </Folder> <Folder> <Id>2</Id> <Class>Contacts</Class> </Folder> </Folders> </Ping> PingCommand__ItemChangesSinceLastSync_Exception : Microsoft.Exchange.AirSync.AirSyncPermanentException: Invalid Class Type in RI sync state: at Microsoft.Exchange.AirSync.RecipientInfoCacheSyncCollection.OpenSyncState(Boolean autoLoadFilterAndSyncKey, SyncStateStorage syncStateStorage) at Microsoft.Exchange.AirSync.GetItemEstimateCommand.GetChanges(SyncCollection collection, Boolean autoLoadFilterAndSyncKey, Boolean tryNullSync, Boolean commitSyncState) at Microsoft.Exchange.AirSync.PingCommand.FolderChangedSinceLastSync(DPFolderInfo folder, GetItemEstimateCommand command, SyncCollection collection, Boolean tryNullSync)   
```

Workaround

The issue outlined in this article can be prevented by not using the native mail app for Exchange ActiveSync. This can be done by using one of the following methods:

- Use the Microsoft Outlook app for Android. For more information, go to the following Google website:

    [https://play.google.com/store/apps/details?id=com.microsoft.office.outlook](https://play.google.com/store/apps/details?id=com.microsoft.office.outlook)     

#### Issue 2.14 - Sender receives copy from Reply to All message
 
Exchange ActiveSync user receives a copy of a message when he or she clicks **Reply to All** to a message in the mailbox.

#### Issue 2.13 - Items in a folder disappear and reappear on an iOS device
 
The items on an iOS device disappear for a short time and then reload automatically. This behavior may occur for any mail folder, calendar, or contacts.

Cause

The Exchange ActiveSync client sends a Sync command to Exchange with a synchronization key of 0. This key value re-initializes the sync state for the folder.

Solution

This behavior is by design.

More information

For more information, please refer to the following article:

[iOS: How to mitigate a full sync or reload of Exchange account data](https://support.apple.com/ts4511)

#### Issue 2.12 - Android device cannot synchronize with Exchange
 
After the ActiveSync profile is configured, the device receives new items for an undetermined time and then stops updating.

Cause

The ActiveSync mailbox policy has a refresh policy defined. The device receives a response with status 143 - Error:PolicyRefresh. The device does not send a provision command as needed.

IIS log example:
     
```asciidoc
Cmd=Sync&User=contoso%5Ce15&DeviceId=android1362622918557&DeviceType=Android&Log=PrxFrom:10.0.1.151_ V141_HH:mail.contoso.com_SmtpAdrs:e15%40contoso.com_NMS1_Fet78_TmTr:TID%3a18%3e%3e%5bID%3aH%5FEPR%2c Start%3a2%3a40%3a30+PM%2cEnd%3a2%3a40%3a30+PM%2cExcl%3a0+ms%2cChild%3a%5bNONE%5d%2c%5dTID%3a50%3e%3e %5bID%3aH%5FBPR%2cStart%3a2%3a40%3a30+PM%2cEnd%3a2%3a40%3a30+PM%2cExcl%3a15+ms%2cChild%3a%5bID%3aH%5 FRMBP%2cStart%3a2%3a40%3a30+PM%2cEnd%3a2%3a40%3a30+PM%2cExcl%3a0+ms%2cChild%3a%5bNONE%5d%2c%5d%2c%5d _Pk3609689902_DevOS:Android+4.1.2_S143_Error:PolicyRefresh_As:AllowedG_Mbx:CLT-E15-MBX1.contoso.local _Throttle0   
``` 

Solution

Set the refresh interval for the ActiveSync mailbox policy to Unlimited.

#### Issue 2.11 - iOS device users cannot synchronize Exchange mailbox after the device is updated to iOS 7.0
 
A user cannot synchronize his or her iOS device with a mailbox that is hosted on Exchange Server 2010 or Exchange Server 2013 after the iOS device is upgraded to iOS 7.0.

Solution

Exchange Server 2013

To resolve this issue in Exchange Server 2013, install the update that is described in the following article in the Microsoft Knowledge Base:

[2859928](https://support.microsoft.com/help/2859928) Description of Cumulative Update 2 for Exchange Server 2013

Exchange Server 2010

To resolve this issue in Exchange Server 2010, install the update rollup that is described in the following article in the Microsoft Knowledge Base:

[2866475](https://support.microsoft.com/help/2866475) Description of Update Rollup 2 for Exchange Server 2010 Service Pack 3

Note Microsoft has documented the problem in the following article in the Microsoft Knowledge Base:

[2851708](https://support.microsoft.com/help/2851708) Cannot synchronize an Exchange mailbox after updating an Apple iOS device to iOS 7.0

#### Issue 2.10 - iOS device users are locked out of Active Directory accounts
 
This issue has been resolved.

#### Issue 2.9 - A mobile device intermittently does not connect to Exchange Online
 
When you try to synchronize a mobile device that is using Exchange ActiveSync with Microsoft Exchange Online, your device cannot connect. You may receive errors such as the following:

**Cannot Get Mail The connection to the server failed. Cannot Send Mail An error occurred while delivering the message.**     

**Unable to open server connection due to a security update**   
 
Cause

When a mobile device acts in a way that can adversely affect Exchange Online service performance, the device is put into an Access Denied state for a short time. For example, this may occur when a device sends too many identical Sync commands to the service for a particular folder in a very short period.

Exchange Online has implemented Exchange ActiveSync Throttling to manage and maintain the optimal performance of the Office 365 Exchange Online environment.

Workaround

For more information, go to the following article in the Microsoft Knowledge Base. Contact the mobile device vendor for help with the investigation.

[2748176](https://support.microsoft.com/help/2748176) A mobile device intermittently fails to connect to Exchange Online

#### Issue 2.8 - High CPU usage when you synchronize a mobile device to an Exchange Server CAS
 
This issue has been resolved.

#### Issue 2.7 - Duplicate contacts are created when you synchronize a mobile device by using Exchange ActiveSync

This issue has been resolved.

#### Issue 2.6 - ActiveSync does not work for mobile device users who are connecting to Exchange Server 2007 mailboxes after they swap URLs between Exchange Server 2010 and Exchange Server 2007
 
This issue has been resolved.

#### Issue 2.5 - Users cannot synchronize Apple iPhone iOS 4.0 with the Exchange Server mailbox
 
This issue has been resolved.

#### Issue 2.4 - You receive a "synchronization failed" email message when you synchronize your mobile device
 
This issue has been resolved.

#### Issue 2.3 - "This message has not been downloaded from the server" error when you try to open a message
 
This issue has been resolved.

#### Issue 2.2 - Users cannot connect by using Exchange ActiveSync because of Exchange resource consumption
 
You may experience resource exhaustion issues that are caused by devices that connect by using Exchange ActiveSync.

Solution

Administrators should review the following article in the Microsoft Knowledge Base to determine whether the users are experiencing the same server symptoms:

[2469722](https://support.microsoft.com/help/2469722) Unable to connect using Exchange ActiveSync due to Exchange resource consumption

Note This article also describes a known issue that occurs after you update to iOS 4.0. For more information, go to the [iOS 4.0: Exchange Mail, Contacts, or Calendars may not sync after update](https://support.apple.com/ts3398) website. We also discuss this issue in Issue 2.5 later in this section.

Exchange 2007 administrators should review the following article in the Microsoft Knowledge Base to determine whether they are experiencing the same server symptoms:

[2656040](https://support.microsoft.com/help/2656040) An Exchange Server 2007 Client Access server responds slowly or stops responding when users try to synchronize Exchange ActiveSync devices with their mailboxes

IT administrators should also review Issue 1.8 in the previous section.

Another possible avenue to investigate is whether the device is continuously re-synchronizing. Apple has documented the behavior in the following article:

[https://support.apple.com/en-us/TS4511](https://support.apple.com/ts4511)

#### Issue 2.1 - Failures to provision and synchronize with Android OS
 
Exchange ActiveSync policies can cause provisioning and synchronization to fail when devices are customized. Devices are not provisioned if a policy that exceeds these limitations is applied to the users of these devices. This issue is discussed in comment 9 from the following post on the Google Android forum:

[https://code.google.com/p/android/issues/detail?id=9426](https://code.google.com/p/android/issues/detail?id=9426)

Solution

Updates to the Android OS version seem to resolve this problem. We encourage device users to update to the latest version that is available from their provider and to follow vendor forums that discuss synchronization issues. If the decision is made to use older devices in the organization, administrators can canvass device users or use tools such as Log Parser or Export-ActiveSyncLog to make sure that such devices are identified in the organization. Users of older devices can be grouped into a policy that can work for them. 

## References

The following links provide more information about Exchange ActiveSync experiences.

ActiveSync and our partners

[https://blogs.technet.com/b/exchange/archive/2005/10/25/413056.aspx](https://blogs.technet.com/b/exchange/archive/2005/10/25/413056.aspx)
Why all Exchange ActiveSync experiences aren’t the same, and how to know what you’re receiving

[https://blogs.technet.com/b/exchange/archive/2010/07/15/3410397.aspx](https://blogs.technet.com/b/exchange/archive/2010/07/15/3410397.aspx)
Exchange ActiveSync logo program

[https://technet.microsoft.com/en-us/exchange/gg187968.aspx](https://technet.microsoft.com/exchange/gg187968.aspx)
Android Support:

Android OS devices are typically supported through forums or through the mobile carrier. Device vendor or mobile carrier websites may offer help.
Apple Enterprise Support for Exchange ActiveSync and iOS

Apple Enterprise support is available through an [Enterprise Support Agreement](https://www.apple.com/support/products/enterprise/ossupport.html) or through a [Cross Platform and Command Line Interface PPI (pay per incident)](https://www.apple.com/support/products/pay-per-incident.html).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information. 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The link below will navigate your web browser to a guided tutorial which will help you solve your problem:

[Start guided walkthrough](https://support.microsoft.com/help/10047)