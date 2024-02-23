---
title: Can't replicate public folders to Exchange Server 2010
description: Discusses an issue where you get an error - The store driver couldn't deliver the public folder replication message when you replicate public folder content to Exchange 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: bilong, charray, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Fail to replicate the public folder content to Exchange Server 2010

_Original KB number:_ &nbsp;2487271

## Symptoms

When you try to replicate the public folder content to Microsoft Exchange Server 2010, it won't replicate.

Looking at the application log, you may find an event like this:

```console
Log Name: Application
Source: MSExchange Store Driver
Event ID: 1020
Level: Error
Description:

The store driver couldn't deliver the public folder replication message "Hierarchy (PublicFolder@contoso.com)" because the following error occurred: The Active Directory user wasn't found.
```

## Cause

In an environment in which Exchange Server 2000 or Exchange Server 2003 previously existed, and all those servers have been removed, there's a chance that an Administrative Group (First Administrative Group or another custom Administrative Group) remains with a **Servers** container, but no servers inside it.

During the replication, when the Exchange 2010 Store Driver sees the empty **Servers** container in Active Directory, it's expecting a **System Attendant** object inside the container. If the driver can't find the object, the error occurs.

## Workaround

To work around the issue, delete the empty **Servers** container. This can't be done through Exchange System Manager. Use the ADSI Edit tool to remove it using the following steps:

> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2003 Server, Microsoft Windows Server 2008, Microsoft Exchange 2010 Server or both Windows and Exchange. Microsoft can't guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.

1. Start the [ADSI Edit](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)) tool. To do this, click **Start** > **Run**, type *adsiedit.msc*, and then click **OK**.
1. Expand Configuration Container [`servername.domainname.com`], and then expand **CN=Configuration,DC=DomainName,DC=com**.
1. Expand **CN=Services** > **CN=Microsoft Exchange** > **CN=OrganizationName**, where OrganizationName is the name of your Exchange organization.
1. You'll see the empty Administrative Group. Expand the **CN=AdministrativeGroupName**.
1. Expand **CN=Servers**.
1. Verify there are no server objects listed under the **Servers** container.
1. Right-click the empty **CN=Servers** Container and choose **Delete**.

## More information

[ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10))

[How to Remove the Last Legacy Exchange Server from an Organization](/previous-versions/office/exchange-server-2007/bb288905(v=exchg.80))