---
title: Planning considerations to deploy Outlook for Windows
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
ms.reviewer: 
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Help
  - Outlook for Windows
  - CI 167136
  - CSSTroubleshoot
ms.collection: Ent_Office_Outlook
description: Helps IT Pros learn about what they should consider when they deploy Outlook for Windows to users in their organization
search.appverid: 
  - MET150
appliesto:
  - Outlook 2013
  - Outlook 2016
  - Outlook 2019
  - Outlook 2021
  - Outlook for Microsoft 365
  - Microsoft 365
ms.date: 03/19/2025
---

# Planning considerations to deploy Outlook for Windows

A close review of the organization's messaging requirements will help you plan your Outlook deployment to users in your enterprise.

## Determining an organization's needs

The organization's messaging environment helps shape Outlook deployment. Factors to consider include whether you're upgrading Microsoft Outlook, installing the application for the first time, planning for roaming or remote users, or choosing a combination of these and other factors.

> [!IMPORTANT]
>
> - Outlook 2016 and later versions don't support connecting to Exchange Server 2007.
> - Outlook 2016 and later versions now require AutoDiscover to be configured, or they'll be unable to connect to Exchange Server. They retrieve Exchange connectivity settings directly from AutoDiscover instead of the registry, making profiles more reliable, but that also makes AutoDiscover a required feature. For more information, see [Autodiscover service](/Exchange/architecture/client-access/autodiscover).

### MSI versus Click-to-Run deployment methods

There are two primary installation technologies for Office: Windows Installer (MSI) and Click-to-Run. Volume licensed versions of Office, such as Office Standard 2016, use Windows Installer (MSI). Office that comes with Microsoft 365 enterprise plans uses Click-to-Run. For example, Outlook that's included in [Microsoft 365 Apps for enterprise](/DeployOffice/about-office-365-proplus-in-the-enterprise) uses Click-to-Run.

The MSI and Click-to-Run versions of Office and Outlook 2016 have different configuration options and administration tools. For MSI-based deployments, use the [Office Customization Tool (OCT)](/deployoffice/oct/oct-2016-help-overview) before installation to set your users' default settings, install Outlook, then enforce those settings and prevent users changing them after installation by using [Group Policy](https://www.microsoft.com/download/details.aspx?id=49030). For Click-to-Run deployments, first use the [Office Deployment Tool](/DeployOffice/overview-of-the-office-2016-deployment-tool) to set a small number of settings, install Outlook, then set the full range of customization settings and prevent users changing them after installation by using [Group Policy](https://www.microsoft.com/download/details.aspx?id=49030).

### Upgrade or initial installation of Outlook

If you're upgrading from an earlier version of Outlook, consider whether you'll migrate previous settings, change user profiles, and use new customization options. By default, user settings are migrated automatically, except for security settings. Customization of Outlook settings is optional and only needed if you want to change the default settings. Also, Outlook can automatically create a new Outlook profile by using the [Autodiscover service](/Exchange/architecture/client-access/autodiscover).

If you're deploying a volume-licensed version of Office that uses Windows Installer (MSI), the [Office Customization Tool (OCT)](/deployoffice/oct/oct-2016-help-overview) enables you to migrate users' current settings and make other customizations. For example, you can define new Microsoft Exchange servers or customize new features. If you're deploying Microsoft 365 Apps for enterprise and must change settings from the default configuration, you can use Group Policy or the registry.

### Migrating data

When you upgrade from Outlook 2003, Outlook 2007, Outlook 2010, or Outlook 2013, Outlook migrates data for you. Data migration from versions of Outlook earlier than Outlook 2003 and other email applications isn't supported.

### Remote and roaming users

Cached Exchange Mode is recommended for all configurations, but it especially benefits remote users. Cached Exchange Mode creates a local copy of users' mailboxes. This gives users more reliable access to their Outlook data, whether or not they're connected to a network. For more information, see [Plan and configure Cached Exchange Mode in Outlook 2016 for Windows](cached-exchange-mode.md).

You can customize Outlook to optimize the experience for remote and roaming users and to set up Outlook for multiple users on the same computer. When multiple users share the same computer, use Windows logon features on the computer's operating system to manage user logon verification.

### Multilingual requirements

Outlook supports Unicode throughout the product to help multilingual organizations seamlessly exchange messages and other information in a multilingual environment.

Office consists of the language-neutral core package plus one or more language-specific packages. In addition to the proofing tools that are included in each language version, you can download and deploy proofing tools for other languages to help multilingual groups work with and edit files in many languages. For more information, see [Plan for multilanguage deployment of Office 2016](/DeployOffice/office2016/plan-for-multilanguage-deployment-of-office-2016).

### Client and messaging server platforms

Although Outlook works well with many versions of Exchange and other email servers, some features of Outlook require specific versions of Exchange. For more information, see [Exchange Online Service Description](/office365/servicedescriptions/exchange-online-service-description/exchange-online-service-description).

If you have an on-premises Exchange Server and plan to add Exchange Online to coexist in your environment, there are two things to consider:

- There's no cross-premises manager delegation. If the manager's account is connected to Exchange Online, the delegate's account must be on Exchange Online too.
- An account that is on-premises can't have "Send As" permissions for an account that is connected to Exchange Online.

Also be aware that the user authentication method is different between an on-premises Exchange Server and Exchange Online. Exchange Online users enter their email address (as the user name) and password. However, the users can decide to save the password so that they only have to enter it once.

## Choosing when and how to install Outlook

You have options for when and how you install Outlook. For example, consider which of the following would be best for your organization:

- Install or upgrade Outlook for different groups of users in stages or at the same time.
- Install Outlook as a standalone application.
- Install Outlook before, during, or after an Office installation.

Each organization has a different environment and might make a different choice about timing Outlook upgrades. For example, you might have a messaging group that is responsible for upgrading Outlook and a separate group that plans deployment for other Office applications. In this case, it might be easier to upgrade Outlook separately from the rest of Office instead of trying to coordinate deployment between the two groups.

Note that an MSI version of Outlook, such as Office Standard 2016, can't coexist with earlier MSI versions of Outlook on the same computer. However, you can install a Click-to-Run version of Outlook, such as with Microsoft 365 Apps for enterprise, to run side-by-side with MSI versions of Outlook prior to Outlook 2016. However, you can't have Click-to-Run versions of Outlook 2013 and Outlook 2016 installed on the same computer. If you have two versions of Outlook installed on the same computer, you can't run them at the same time.

> [!NOTE]
> As a best practice, you should have only one version of Office installed on a computer. For migration scenarios, you might need multiple versions of Office on the same computer for a short period of time. However, we recommend that you uninstall the earlier version of Office as soon as possible after you've migrated to the latest version of Office.

### Customizing Outlook settings and profiles

You can customize an MSI installation of Outlook to handle Outlook user settings by specifying these settings in the OCT.

When you use the OCT to customize Outlook, you save choices and other installation preferences in the customization .msp file that is applied during setup. Later, you update settings by opening the file in the OCT and saving a new copy of the file.

For Click-to-Run installations of Outlook, such as with Microsoft 365 Apps for enterprise, you can use Group Policy or registry keys to customize Outlook settings.

> [!NOTE]
> PRF files don't work and are no longer needed in Outlook 2016 and later versions because accounts should be configured automatically in the account wizard when you use AutoDiscover.

### Configuring subscriptions and other sharing features for Outlook

Outlook includes features that let you easily subscribe to new sources of content and share the features with users inside and outside your organization. Content sources include SharePoint contacts, tasks, and calendars, together with local and Internet-based calendars (iCals).

Really Simple Syndication (RSS) is another sharing feature that enables users to subscribe to internal or Internet-based sources of syndicated content (.xml files) to avoid having to check a site for new information. You can deploy specific RSS feeds or calendar subscriptions to users, configure settings to manage how users can share these subscriptions or content, specify how often the servers update users' copies of the data, and more.

### Using Outlook with Remote Desktop Services

Remote Desktop Services (RDS), formerly known as Terminal Services, in Windows Server enables you to install a single volume licensed copy of Outlook on an RDS-enabled computer. Instead of running Outlook on local computers, multiple users connect to the server and run Outlook from that server. For more information, see [Office 2016 in RDSH and VDI Deployments](/windows-server/remote/remote-desktop-services/rds-office-vdi-rdsh) and [Dealing with Outlook search in non-persistent environments](/windows-server/remote/remote-desktop-services/rds-outlook-data-fslogix).

### AutoArchive in Outlook

Outlook mailboxes grow as users create and receive items. To keep mailboxes manageable, users need another place to store or archive older items that are important but rarely used. It's typically most convenient to automatically move these older items to the archive folder and to discard items whose content has expired and is no longer valid. [AutoArchive](https://support.office.com/article/444BD6AA-06D0-4D8F-9D84-903163439114) in Outlook can manage this process automatically for users. However, we recommend that you use the In-Place Archiving feature in Exchange Server because it eliminates the need for Personal Folder files (.pst). By using In-Place Archiving, users can view an archive mailbox and move or copy messages between their primary mailboxes and the archive. For more information, see [In-Place Archiving in Exchange](/Exchange/policy-and-compliance/in-place-archiving/in-place-archiving).

### Retention policies in Outlook

Retention policy settings can help users follow retention policy guidelines that your organization establishes for document retention. You can't deploy AutoArchive-based retention settings through Outlook by using Group Policy. If you must deploy retention policies, explore the Messaging Records Management (MRM) features in Exchange Server. For more information, see [Messaging records management in Exchange Server](/Exchange/policy-and-compliance/mrm/mrm).

## Outlook security considerations

Outlook includes many security features, some of which are highlighted in the following sections.

### Virus prevention

You can configure virus-prevention and other security settings in Outlook by using Group Policy. You can also use the Outlook Security Template to configure settings, as in earlier releases of Outlook. By using either configuration method, you can, for example, modify the list of file types that are blocked in email messages.

The Object Model (OM) Guard that helps prevent viruses from using the Outlook Address Book (OAB) to spread is updated. Outlook checks for up-to-date antivirus software to help determine when to display OAB access warnings and other Outlook security warnings.

#### Outlook antivirus planning considerations

When you plan antivirus scanning for Outlook files and email messages, take precautions to prevent the issues that can arise.

**Scanning Outlook files** Outlook Data Files (\*.pst) and Offline Folder files (\*.ost) are the most frequently-accessed Outlook files. If you use antivirus software to perform file-level scanning on them, while Outlook is in use, data corruption issues might occur.

Data corruption issues might also occur if you scan Outlook address book files (\*.oab ), Send/receive settings files (\*.srs ), \*.xml files, and the Outlprnt file, although the possibility is smaller because people access these files less frequently.

**Scanning email messages** We don't recommend that you scan \*.pst, \*.ost, and other Outlook files directly. Instead, we recommend that you scan email message attachments on the email server and on the Outlook client computer.

- To scan email messages that are on an email server, you must use antivirus software that was developed to scan incoming and outgoing email.

  - To scan email messages that are on the Exchange Server, use an antivirus software program that works with Exchange.
  - If your email messages are on an email server that is located at an Internet service provider (ISP), verify that the ISP is using antivirus software to scan incoming and outgoing email messages.

- To scan the attachments that are included in email messages on the client computer, use antivirus software on the client computer. We recommend this in case an unwanted message reaches your email client because antivirus software on the email server failed to identify it.

### Junk email and phishing protection

Outlook includes a junk email filter that replaces the rules that were used in earlier versions of Outlook to filter mail. Messages caught by the filter are moved to the Junk Email folder, where they can be viewed or deleted later.

Junk email senders often add a web beacon in HTML email messages that includes external content, such as graphic images. When users open or view the email, the web beacons verify that their email addresses are valid. This increases the probability that users will receive more junk email messages. Outlook reduces the probability that users will become targets for future junk email by blocking automatic picture downloads from external servers by default.

Outlook helps protect against issues that are created by phishing email messages and deceptive domain names. By default, Outlook screens phishing email messages. These messages seem legitimate but they attempt to trick users to provide personal information, such as a user's bank account number and password. Outlook also helps prevent the receipt of email messages from deceptive users by warning about suspicious domain names in email addresses. Outlook supports internationalized domain names (IDNs) in email addresses. IDNs allow people to register and use domain names in their native languages instead of English. IDN support allows phishers to send homograph attacks, a situation in which a look-alike domain name is created by using alphabet characters from different languages, not just English, with the intention of deceiving users into thinking that they're visiting a legitimate website.

### Configuring cryptographic features for Outlook

Outlook provides cryptographic features for sending and receiving security-enhanced email messages over the Internet or intranet. You can customize features in an Outlook deployment to set cryptographic options that are appropriate for your organization.

You can also implement additional features to help improve security in email messaging. For example, you can provide security labels that match your organization's security policy. An Internal Use Only label might be implemented as a security label to apply to email messages that shouldn't be sent outside your company.

### Restricting permission on email messages

Information Rights Management (IRM) helps users prevent sensitive email messages and other Office content, such as documents and worksheets, from being forwarded, edited, or copied by unauthorized people. In Outlook, users can use IRM to mark email messages with "Do not forward," which automatically restricts permission for recipients to forward, print, or copy the message. In addition, you can define customized IRM permission policies in Office for your organization's needs and can deploy the new permission policies for users to use with email messages or other Office documents. For more information, see [Protect sensitive messages and documents by using Information Rights Management (IRM) in Office 2016](/DeployOffice/security/protect-sensitive-messages-and-documents-by-using-irm-in-office).

### Outlook and email protocols and servers

The primary email servers and services supported by Outlook include the following:

- Simple Mail Transfer Protocol (SMTP)
- Post Office Protocol version 3 (POP3)
- Internet Mail Access Protocol version 4 (IMAP4)
- MAPI for Exchange Server (version 2007 and later versions)
- Exchange Active Sync for connection to services such as Outlook.com (Hotmail) to access mail, calendar, contacts, and tasks
- Other messaging and information sources, made possible by how Outlook uses the MAPI extensibility interface.

Users can use the Contacts, Tasks, and Calendar features in Outlook 2016 without being connected to an email server.

## Upgrading from an earlier version of Outlook

You can install Outlook 2016 or later versions over any previous installation of Outlook. User settings that are stored in the registry are migrated when you upgrade from Outlook 2003 or later versions to Outlook 2016 or later versions. If a MAPI profile already exists on a user's computer, you typically can configure a deployment to continue to use the profile.

Note that an MSI version of Outlook, such as Office Standard 2016, can't coexist with earlier MSI versions of Outlook on the same computer. However, you can install a Click-to-Run version of Outlook, such as with Microsoft 365 Apps for enterprise, to run side-by-side with MSI versions of Outlook prior to Outlook 2016. However, you can't have Click-to-Run versions of Outlook 2013 and Outlook 2016 installed on the same computer. If you have two versions of Outlook installed on the same computer, you can't run them at the same time.

> [!NOTE]
> As a best practice, you should have only one version of Office installed on a computer. For migration scenarios, you might need multiple versions of Office on the same computer for a short period of time. However, we recommend that you uninstall the earlier version of Office as soon as possible after you've migrated to the latest version of Office.

When you upgrade users from an earlier version of Outlook, you must make choices about how to configure user profiles, consider Cached Exchange Mode issues, and be aware of fax and forms changes.

### Upgrading to Office with Cached Exchange Mode enabled

The process of upgrading users who currently have Cached Exchange Mode enabled in Outlook 2003, Outlook 2007, Outlook 2010, or Outlook 2013 is straightforward. If you don't change Cached Exchange Mode settings, the same settings are kept for Outlook 2016 and later versions.

By default, when Outlook 2016 or later versions are installed, a new compressed version of the Outlook data file (.ost) is created. This compressed version of the .ost is up to 40% smaller than the size of the .ost files that were created in earlier versions of Outlook. If you must keep Outlook from creating a new compressed Outlook data file (.ost), use the Outlook Group Policy template (Outlk16.admx) to enable the **Do not create new OST file on upgrade** policy. You can find this setting under User Configuration\Policies\Administrative Templates\Microsoft Outlook 2016\Account Settings\Exchange.

For additional Cached Exchange Mode planning considerations, see [Plan and configure Cached Exchange Mode in Outlook 2016 for Windows](cached-exchange-mode.md).

## Installing multiple versions of Outlook on the same computer

With Outlook, if you're using the volume licensed version (MSI-based installation), such as Office Standard 2016, you can't have two versions of Outlook installed. The upgrade process will, by default, remove the earlier version. But if you're moving from volume licensed to a subscription license version such as with Microsoft 365 Apps for enterprise, which uses Click-to-Run installation, it's possible to have two versions of Outlook installed on the same computer.

> [!NOTE]
> As a best practice, you should have only one version of Office installed on a computer. For migration scenarios, you might need multiple versions of Office on the same computer for a short period of time. However, we recommend that you uninstall the earlier version of Office as soon as possible after you've migrated to the latest version of Office.

## Additional considerations when planning an Outlook upgrade

To prepare for an upgrade, you must answer the following additional questions:

- Should you change Outlook user profiles as part of an upgrade? For example, you might define a new Exchange Server (like Exchange Online) or enable new features of Outlook.
- How should you create and store a backup of your existing installation? Before you upgrade to any new release, we recommend that you back up existing data.
- How will users learn about the new interface and features of Office? For more information, see [Outlook help center](https://support.office.com/outlook) and [Outlook for Windows video training](https://support.office.com/article/8a5b816d-9052-4190-a5eb-494512343cca).
- Will you have to assess Outlook add-ins in your environment?

## Considerations for 32-bit Outlook applications when upgrading to a 64-bit platform

If you developed 32-bit Messaging Application Programming Interface (MAPI) applications, add-ins, or macros for Outlook, are actions that you should take to change and rebuild the 32-bit applications to run on a 64-bit platform.

Outlook is available as a 32-bit application and a 64-bit application. Which version of Outlook you choose depends on the edition of the Windows operating system (32-bit or 64-bit) and the edition of Office (32-bit or 64-bit) that is installed on the computer, if Office is already installed on that computer.

Factors that determine the feasibility of installing a 32-bit or a 64-bit version of Outlook include the following:

- You can install 32-bit Office and 32-bit Outlook on a supported 32-bit or 64-bit version of the Windows operating system. You can install the 64-bit version of Office and 64-bit Outlook only on a supported 64-bit Windows operating system.
- The default installation of Office on a 64-bit version of the Windows operating system is 32-bit Office.
- The installed version of Outlook is always the same as the version of Office, if Office is installed on the same computer. That is, a 32-bit version of Outlook can't be installed on the same computer on which 64-bit versions of other Office applications are already installed, such as 64-bit Word 2016 or 64-bit Excel 2016. Similarly, a 64-bit version of Outlook can't be installed on the same computer on which 32-bit versions of other Office applications are already installed.
