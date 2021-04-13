---
title: Considerations when you change an Office 365 sign-in address
description: Describes how sign-in addresses and user IDs are managed in Skype for Business Online.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Considerations for Skype for Business Online when you change an Office 365 sign-in address

## Introduction

When a user's Office 365 sign-in address (also known as the User Principal Name, UPN, or user ID) is changed, the Skype for Business Online (formerly Lync Online) SIP address for the user is automatically synchronized. Previously, when a user's Office 365 sign-in address was changed, the IT administrator had to update the user's SIP address separately to match the new Office 365 sign-in address. Otherwise, the two values would be mismatched. A mismatch between a user ID and the user's SIP address may cause confusion for the Skype for Business Online user during sign in.

## Procedure 

After the user ID of a Skype for Business Online user is updated, there are some actions that the user must take to make sure that the service continues to work without any interruptions. These actions are as follows:

- Reschedule Skype for Business Online meetings. Because of the way that the Skype for Business Online service generates meeting URLs, any meetings that were scheduled by using the old Skype for Business Online SIP address must be rescheduled. If these meetings aren't rescheduled, meeting participants may receive an error message when they try to join any Skype for Business Online conferences that are scheduled by that user.   
- Communicate changes to external contacts in Skype for Business Online contact lists. External contacts (this includes other federated Lync organizations), Windows Live users, and MSN users must be notified about the change to the user's SIP address. Until external contacts remove and update the old contact, the contact object for the user is displayed as either **Presence Unknown** or **Offline**.   


Some companies may want a configuration that uses disjointed sign-in addresses for Skype for Business Online and Office 365 and although this configuration is supported, the end-user experience on initial sign-in will be less than ideal for some Lync clients. Skype for Business Online users will have to enter the UPN and SIP address separately in the user interface for a successful sign-in. Running the Office 365 Desktop Setup Tool will resolve this issue on computers that are running Lync 2010.

> [!NOTE]
> The Office 365 Desktop Setup Tool isn't available for mobile devices or Lync 2013.

If you want to manually configure the setting for Lync 2013, see the following Office 365 website:

[Manually update and configure desktop applications](https://onlinehelp.microsoft.com/office365-enterprises/ff637585.aspx#bkmk_configure)

If the Office 365 organization is using Directory Synchronization and has or previously had a Office Communications Server 2007 R2, Lync Server 2010, or Lync Server 2013 deployment on-premises, the SIP Address can be updated independently by populating the msRTCSIP-PrimaryUserAddress value in Active Directory. Review the following Knowledge Base article to make sure that the values in Office 365 aren't in conflict with on-premises values:

[2430520 ](https://support.microsoft.com/help/2430520) Error in the Office 365 portal: "Value of msRTCSIP-PrimaryUserAddress or the SIP address in the ProxyAddresses field in your local Active Directory is not unique"

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).