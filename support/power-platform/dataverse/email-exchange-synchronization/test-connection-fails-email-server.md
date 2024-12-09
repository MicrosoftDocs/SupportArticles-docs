---
title: Test Connection fails in email server profile
description: Provides a solution to an issue where test connection fails from an email server profile in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/09/2024
ms.custom: sap:Email and Exchange Synchronization
---
# Test Connection fails with 401 or time-out error in email server profile in Microsoft Dynamics 365

This article provides a solution to an issue where **Test Connection** fails from an email server profile in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4493267

## Symptoms

When you select **Test Connection** on an email server profile record in Dynamics 365, the test fails and you might see one of the following errors:

> Remote server error: (401) Unauthorized. Make sure the user name and password you entered are correct and try again.

Or

> System.Net.WebException: The operation has timed out  
> at System.Net.HttpWebRequest.GetResponse()  
> at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeConnectivityDiscoverer.ValidateServerUrl(EmailDirectionCode emailDirection)

## Cause 1: Incorrect username or password

To solve this issue, verify the username and password are correct.

> [!NOTE]
> The **User Name** value needs to be in the UPN (User Principal Name) format. For example, use `username@contoso.com` instead of `contoso\username`.

## Cause 2: Firewall blocking connectivity

If you use Dynamics 365 (online) with Exchange on-premises, ensure your firewall allows connectivity from the list of IP ranges documented in [Microsoft Dynamics CRM Online IP Address Ranges](https://support.microsoft.com/help/2728473) including the referenced [Azure IP Ranges](https://support.microsoft.com/topic/microsoft-dynamics-crm-online-ip-address-ranges-0b22a844-e61d-443b-482f-945de79f764d).

## Cause 3: Unreliable test connection results

The test connection results aren't always reliable. If the same username and password works when [testing connection with Microsoft Remote Connectivity Analyzer](/power-platform/admin/test-connection-exchange-server-onpremises#test-connection-with-the-microsoft-remote-connectivity-analyzer), use the **Test & Enable Mailboxes** option in Dynamics 365 instead of the **Test Connection** option. If the **Test & Enable Mailboxes** is successful for your mailboxes, you can disregard the results from the **Test Connection** dialog.

> [!NOTE]
> If any failures occur using the **Test & Enable Mailboxes** button, see the **Alerts** tab in the mailbox record and review any help links that are included.
