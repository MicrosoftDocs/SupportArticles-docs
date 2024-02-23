---
title: Can't open additional mailboxes in Outlook Web App
description: Resolves an issue in which you receive an error message when you try to open an additional mailbox in Outlook Web App. This issue occurs after you install Update Rollup 4 for Exchange Server 2010 SP2.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: shashikg, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Service Pack 2
ms.date: 01/24/2024
---
# You can't open an additional mailbox in Outlook Web App after you install Update Rollup 4 for Exchange Server 2010 SP2

_Original KB number:_ &nbsp; 2777852

## Symptoms

Assume that you apply Update Rollup 4 for Exchange Server 2010 SP2. Then, you try to open an additional mailbox in Outlook Web App. The primary SMTP email address of the additional mailbox isn't in the accepted domain list. In this situation, you receive the following error message:

```console
Request:
Url: https://localhost:443/owa/auth.owa
User host address: ::1
OWA version: 14.2.318.2
Exception:
Exception type: System.ArgumentNullException
Exception message: Value cannot be null. Parameter name: organizationId
Call stack:
Microsoft.Exchange.Data.Directory.ScopeSet.GetOrgWideDefaultScopeSet(OrganizationId organizationId, QueryFilter recipientReadFilter)
Microsoft.Exchange.Data.Directory.ADSessionSettings.FromOrganizationIdWithoutRbacScopesServiceOnly(OrganizationId scopingOrganizationId)
Microsoft.Exchange.Clients.Owa.Core.Utilities.CreateADRecipientSession(Boolean readOnly, ConsistencyMode consistencyMode, SmtpDomain smtpDomain)
Microsoft.Exchange.Clients.Owa.Core.OwaMiniRecipientIdentity.UpgradePartialIdentity()
Microsoft.Exchange.Clients.Owa.Core.FBASingleSignOnFilterChain.GetExchangePrincipalFromWindowsIdentity(WindowsIdentity windowsIdentity, String smtpAddress)
Microsoft.Exchange.Clients.Owa.Core.FBASingleSignOnFilterChain.HandleIfLegacyRedirect(WindowsIdentity identity, String explicitLogonUser, Configuration owaConfiguration, HttpApplication httpApplication)
Microsoft.Exchange.Clients.Owa.Core.FBASingleSignOnFilterChain.FilterRequest(Object source, EventArgs e, RequestEventType eventType)
Microsoft.Exchange.Clients.Owa.Core.RequestFilterChain.ExecuteRequestFilterChain(Object source, EventArgs e, RequestEventType eventType)
Microsoft.Exchange.Clients.Owa.Core.OwaRequestEventInspector.OnPostAuthorizeRequest(Object sender, EventArgs e)
System.Web.HttpApplication.SyncEventExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)
```

## Cause

This issue occurs because of a design change that was introduced in Update Rollup 4 for Exchange 2010 Service Pack 2.

## Resolution

To resolve this issue, add the primary SMTP email domain of the additional mailbox to the accepted domain list. To do this, follow these steps:

1. Click **Start**, click **All Programs**, click **Microsoft Exchange Server 2010**, and then click **Exchange Management Console**.
2. In the **Exchange Management Console** tree, click **Organization Configuration**, and then click **Hub Transport**.
3. In the result pane, click the **Accepted Domains** tab, right-click an empty area, click **New Accepted Domain**, and then follow the **New Accepted Domain** wizard to create the accepted domain.

    > [!NOTE]
    > For more information about how to create a new accepted domain, see [How to Create Accepted Domains](/previous-versions/office/exchange-server-2007/aa996910(v=exchg.80)).
