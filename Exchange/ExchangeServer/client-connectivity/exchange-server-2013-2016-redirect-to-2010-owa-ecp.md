---
title: Exchange Server 2013 or 2016 redirects to Exchange 2010 for OWA, Outlook on the web, and ECP
description: Describes an issue that you're redirected to Exchange Server 2010 OWA or Exchange Control Panel When you connect to Exchange Server 2016 Outlook on the web, Exchange Server 2013 Outlook Web App, or Admin Center page.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, excontent, message, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Server 2013 or Exchange Server 2016 redirects to Exchange 2010 for OWA, Outlook on the web, and ECP

_Original KB number:_ &nbsp;2931385

## Symptoms

When you try to connect to the Microsoft Exchange Server 2016 Outlook on the web, Exchange Server 2013 Outlook Web App (OWA), or Admin Center (EAC) page, you're redirected to Exchange Server 2010 OWA or Exchange Control Panel (ECP). This issue occurs under the following circumstances:

- Exchange Server 2013 or Exchange Server 2016 is installed into an existing Exchange Server 2010 organization.
- You recently accessed Outlook Web App or Exchange Control Panel when your mailbox was on Exchange Server 2010.
- You move your mailbox from Exchange Server 2010 to Exchange Server 2013 or Exchange Server 2016.

## Cause

There are three scenarios in which this unexpected behavior can occur when you try to connect to Outlook on the web, OWA, or EAC:

Scenario 1:  The Exchange Server client access service contacts a domain controller that doesn't have the latest user object attributes after the mailbox is moved.

Scenario 2: The Exchange Server client access service is using cached information for the mailbox location.

Scenario 3: Permission Inheritance is blocked on the user object.

## Resolution

The resolution for this issue corresponds to the scenario listed above in the "Cause" section:

### Solution 1: Verify that Active Directory replication is completed by checking the user object's homeMDB attribute. This value should contain the DN value of the Exchange Server 2013 or Exchange Server 2016 mailbox database

### Solution 2: On Exchange Server 2013 or Exchange Server 2016, wait 30 minutes for the cache to clear or restart the MSExchangeOWAAppPool. Refer to the following screenshot in Exchange Server 2013

:::image type="content" source="media/exchange-server-2013-2016-redirect-to-2010-owa-ecp/application-pools.png" alt-text="Screenshot of the IIS Manager window with MSExchangeOWAAppPool selected.":::

> [!NOTE]
> The client is also provided a cookie from the Exchange 2013 Client Access Server with the location of the backend server. This cookie is valid for 10 minutes. Restarting the MSExchangeOWAAppPool may not resolve the issue if you try to connect within 10 minutes of the mailbox move. In this scenario, you must remove cookies from your browser. To remove the cookies in Microsoft Internet Explorer, follow these steps:
>
> 1. Go to Internet Explorer, open **Internet Options**.
> 1. On **General** tab, click **Delete**.
> 1. Select the **Cookies and website data** option, and then click **Delete**.

### Solution 3:  Re-enable permissions inheritance for the user object who has problem when access OWA or ECP

1. Start ADSI Edit by clicking **Start**, click **Run**, type *adsiedit.msc*, and then click **OK**.
1. Locate the user object in question, right-click the object, and then click **Properties**.
1. On the **Security** tab, click **Advanced**.
1. Click **Allow inheritable permissions from the parent to propagate to this object and all child objects** to re-enable permissions inheritance.
1. Click **OK** two times to apply the change.
1. Wait for Active Directory replication to propagate the changes, or force Active Directory replication if it's necessary.

If the Allow inheritable permissions option is re-disabled automatically within 60 minutes, check whether the user account is in the [AD protected group](/previous-versions/technet-magazine/ee361593(v=msdn.10)) such as the AdminSDHolder. If yes, remove the account from the AD protected group.

## Workaround

To work around this issue, you can access the EAC by adding the Exchange version to the URL. For example, to access the EAC whose virtual directory is hosted on the Exchange Server 2013 Client Access server, use the URL: `https:///ecp?ExchClientVer=15`.

If you want to access the Exchange 2010 ECP and your mailbox resides on an Exchange 2013 Mailbox server, use the URL: `https:///ecp?ExchClientVer=14`.

For more information about Exchange Admin Center, see [Exchange Admin Center in Exchange 2013](/exchange/exchange-admin-center-in-exchange-2013-exchange-2013-help).