---
title: Test Connection fails from Email Server
description: Provides a solution to an issue where Test Connection fails from Email Server Profile in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Test Connection fails from Email Server Profile in Microsoft Dynamics 365

This article provides a solution to an issue where Test Connection fails from Email Server Profile in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4493267

## Symptoms

When using the Test Connection option from an Email Server Profile in Dynamics 365, the test fails and you may see an error like the following example:

> "Remote server error: (401) Unauthorized. Make sure the user name and password you entered are correct and try again."
or

> "System.Net.WebException: The operation has timed out
at System.Net.HttpWebRequest.GetResponse()  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeConnectivityDiscoverer.ValidateServerUrl(EmailDirectionCode emailDirection)"

## Cause

- **Cause 1:** The username or password isn't correct.

- **Cause 2:** If you're using Dynamics 365 (online) to connect to Exchange on-premises, this error can occur if your firewall doesn't allow connectivity from Dynamics 365 to your Exchange server.

- **Cause 3:** In some cases, the test connection may fail even though the credentials are correct and connectivity isn't a problem. See Resolution 3 in the Resolution section.

## Resolution

- **Resolution 1:** Verify the username and password are correct.

    > [!NOTE]
    > The User Name value needs to be in UPN (User Principal Name) format. Ex. `username@contoso.com` instead of `contoso\username`.

- **Resolution 2**: If you're using Dynamics 365 (online) with Exchange on-premises, verify your firewall allows connectivity from the list of IP ranges documented in [Microsoft Dynamics CRM Online IP Address Ranges](https://support.microsoft.com/help/2728473) including the referenced [Azure IP ranges](https://support.microsoft.com/help/2728473).

- **Resolution 3:** The Test Connection results aren't always reliable. If the same username and password works when doing a test connection from [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365), use the Test & Enable Mailboxes option in Dynamics 365 instead of the Test Connection option. If the Test & Enable is successful for your mailboxes, you can disregard the results from the **Test Connection** dialog.

    > [!NOTE]
    > If any failures occur using the Test & Enable Mailboxes button, see the **Alerts** tab within the mailbox record and review any help links that are included.
