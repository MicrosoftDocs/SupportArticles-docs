---
title: Users can't join online meetings in Skype for Business Online
description: Describes how to troubleshoot issues that occur when users try to join online meetings in Skype for Business Online in a Microsoft 365 environment.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Users can't join online meetings in Skype for Business Online

## Scoping the problem

Let's assume that you want to troubleshoot issues that occur when users try to join a Skype for Business Online (formerly Lync Online) meeting by using Lync 2010, Lync 2013, the Lync for Windows Store app, or Lync for Mac 2011. Before you start, ask yourself and any external users who are experiencing the issue the following questions:

- How many users does the problem affect?   
- Are the users internal or external to your organization?   
- Can the affected users reproduce the problem on a single computer or on multiple computers?   

When you have the answers to these questions, see the following table to determine the kind of issue that you're dealing with. This table is provided to help scope the problem to a certain category. However, some categories may be outside the technical support boundaries of a Skype for Business Online support engineer.

Read the table as in the following example:

Multiple users... (but not a single user) ...from outside our organization...Can't join a Skype for Business Online meeting from multiple computers: (is usually caused by) Lync federation issue or external network issue.

Be aware that each column and each row are mutually exclusive. That is, the issue affects either a single user or multiple users, and the issue can be reproduced either on one computer or on multiple computers.

|   Issue  |A single user from inside our organization |A single user from outside our organization|Multiple single user from inside our organization|Multiple users from outside our organization|Multiple users from both inside and outside our organization
|---|---|---|---|---|---|
|Can't join a Skype for Business Online meeting from a single computer   |Client issue   |Client issue   |Client issue   |Client issue  |Client issue  |
|Can't join a Skype for Business Online meeting from multiple computers   |User identity issue or provisioning issue   |Lync federation issue or external network issue     |Network issue or Service outage         |Lync federation issue or external network issue|Service outage or network issue|

## Problem

> [!NOTE]
> If you don't experience one of the symptoms that are listed in the following table, use the scoping table in the "Scope" section to narrow the problem to a specific kind of issue. Then, you can troubleshoot the issue by following the steps that are outlined here.

|Symptom|Category|Troubleshooting|
|---|---|---|
|When you try to click the **Join Online Meeting** link in a meeting invitation in Skype for Business Online, you receive "Page not found" or "Page cannot be displayed" in Microsoft Internet Explorer.|Network connectivity|[Troubleshoot network issues](#troubleshooting-network-issues)|
|When Skype for Business Online tries to start an online meeting, the client program freezes.|Client issue|[Troubleshoot client issues](#troubleshooting-windows-client-issues)|
|When you try to click the **Join Online Meeting** link in a meeting invitation, you are repeatedly presented with a security warning and can't join the meeting.|Client issue|[Troubleshoot client issues](#troubleshooting-windows-client-issues)|
|When you try to click the **Join Online Meeting** link in a meeting invitation, you receive the error "Meeting URL is not valid". |User Identity or Provisioning Issue|[Troubleshoot identity issues](#troubleshooting-identity-issues)|
|When you use Skype for Business Online to join a Lync conference that is organized by another company, you receive the error "reference ID 43 (source ID 241)".  |Lync Federation issue|[Make sure that Domain Federation or External Communications are configured correctly](#troubleshooting-lync-federation-issues)|
|When you click the Join Online Meetinglink in a meeting invitation, a File Opendialog box appears. Additionally, Skype for Business Online doesn't start the online meeting.|Incorrect file association|[Fixing OCSMEET file associations in Windows](#fixing-ocsmeet-file-associations-in-windows)|
|You tried all steps in this document and still can't join the Skype for Business Online meeting. You are determined to connect to the conference, even if you can't participate in audio, video, or chat.|Not applicable|[Join meetings by using the Lync Web App](#joining-meetings-by-using-the-lync-web-app)|

### Troubleshooting Windows client issues

To resolve any client or computer issue, first make sure that the computer is up to date. The computer should have the latest operating system updates, audio and video drivers, and software application updates to make connecting to a Skype for Business Online meeting a successful experience. To do this, follow these steps:

1. Run Windows Update, and then verify that all optional hardware updates are installed. Specifically, make sure that video, audio, and network drivers are up to date.    
2. Verify that Lync is up to date. See [Lync Downloads and Updates](/SkypeForBusiness/software-updates) for the latest Lync updates.

    Select your version (2013 or 2010), and then select **Lync client** under **Category**.

Now that the computer is up to date and meets all minimum system requirements, clear any cached credentials or certificates from previous logons:

1. Verify that the user has the correct certificates in Certificate Manager. To do this, follow these steps:
   1. Open Windows Certificate Manager. To do this, click **Start**, click **Run**, type certmgr.msc, and then click **OK**.   
   2. Expand **Personal**, and then expand **Certificates**.   
   3. Sort by the **IssuedBy** column, and then look for a certificate that is issued by Communications Server.   
   4. Verify that the certificate is present and that it isn't expired.   
   5. Delete the certificate, and then try to sign in to Skype for Business Online. If you can't sign in to Skype for Business Online, go to step 2.   
   
2. Remove the user's Skype for Business Online credentials from the Windows Credential Manager. To do this, follow these steps:
   1. Click **Start**, click **Control Panel**, and then click **Credential Manager**.   
   2. Locate the set of credentials that are used to connect to Skype for Business Online.   
   3. Expand the set of credentials, and then click **Remove from Vault**.   
   4. Try to sign in to Skype for Business Online, and then type the new set of credentials.   
   
Skype for Business Online falls back to "anonymous join" if it can't authenticate. As long as anonymous participants aren't explicitly blocked from joining the meeting, they should always be able to join the meeting.

### Troubleshooting network issues

1. Verify that the computer is connected to the network. Determine whether the computer can access other websites.   
2. Verify that the network meets the requirements for connecting to Skype for Business Online. For more information, see [You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection ](https://support.microsoft.com/help/2409256).  

### Fixing OCSMEET file associations in Windows

1. Verify that Skype for Business Online is the default program that is used to open .ocsmeet files. To do this, follow these steps:
   1. Click **Start**, click **Control Panel**, and then click **Default Programs**.   
   2. Click **Associate a file type or protocol with a program**.   
   3. Scroll down to **.ocsmeet**, and then verify that **Microsoft Lync **is selected as the Current Default option.   
   
2. If step 1 doesn't resolve the issue, perform an [Repair an Office application](https://office.microsoft.com/redir/ha010357402.aspx), or reinstall Lync 2010.   

### Troubleshooting Identity issues

This specific issue occurs when two users of the same Microsoft 365 organization share the same user name (alias). Because of how Lync generates meeting URLs, two users on the same Microsoft 365 organization who have the same user name will share the same meeting URLs. This causes the Skype for Business Online conference to become corrupted.

To resolve this issue, change the user name of one of the users who has the duplicate user name.

### Troubleshooting Lync federation issues

If external users (and only external users) can't join a Skype for Business Online meeting, first determine whether they're trying to join as authenticated users or as anonymous users.

- If the user is trying to join as an authenticated user from another Lync or OCS organization:
  - Your Skype for Business Online organization must have External Communications enabled, and external communication must be completely open. Or, the external user's domain must be in the **Allow** list.
  - The external organization must have federation configured correctly from their side, too.   
  - For more information about federating with a Skype for Business Online organization, go to the following Microsoft TechNet website: [Configuring Federation support for a Skype for Business Online customer](/previous-versions/office/lync-server-2013/lync-server-2013-configuring-federation-support-for-a-lync-online-customer)   
  - If authenticated join doesn't work, Lync should automatically try to join as an anonymous or guest user.
- If the user is trying to join as an anonymous user from Lync Attendee, or if the Lync Web App or is dialing in to a Skype for Business Online conference with an ACP access number:
  - For anonymous join to work, a specific DNS SRV record must be present in DNS.    
  - For various methods of confirming your Skype for Business Online DNS records, see [Troubleshooting Skype for Business Online DNS configuration issues in Microsoft 365](https://support.microsoft.com/help/2566790). 

### Joining meetings by using the Lync Web App

If these troubleshooting steps don't resolve the issue, and if joining the meeting immediately is a bigger concern, use the Lync Web App. Be aware that the Lync Web App doesn't include Voice over IP (VoIP) functionality. That means that participants can only view sharing sessions. To do this, follow these steps:

1. Copy the Join URL from the meeting invite, and then paste it into Internet Explorer. (Warning: Don't press Enter yet.)   
2. Add "?sl=1" to the end of the URL, and then press Enter.

    > [!NOTE]
    > You must have Silverlight installed to use the advanced features of the Lync Web App.   

### Troubleshooting issues with third-party software

If you're using third-party software, you may be asked to update, disable, or remove the software as a troubleshooting step. If the issue is resolved after you take one of these actions, you may be referred to the third-party manufacturer for more help or to perform additional troubleshooting.  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).