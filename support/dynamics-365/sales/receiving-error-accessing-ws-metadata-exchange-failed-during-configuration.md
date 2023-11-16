---
title: Receiving error accessing_ws_metadata_exchange_failed when configuring the Microsoft Dynamics 365 Outlook client
description: You may receive the error - accessing_ws_metadata_exchange_failed when configuring the Microsoft Dynamics 365 Outlook client. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Receiving error accessing_ws_metadata_exchange_failed when configuring the Microsoft Dynamics 365 Outlook client

This article provides a resolution for the **accessing_ws_metadata_exchange_failed** error that may occur when you try to set up the Microsoft Dynamics 365 Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4293912

## Symptoms

You are trying to configure the Microsoft Dynamics 365 Outlook client in a deployment that utilizes ADFS for authentication and it is failing with an error. The generic error that the user sees occurring is **An error occurred. Contact your administrator for more information**. If you review the config log Microsoft.Crm.Application.Outlook.ConfigWizard-Client.log, you will see the following error logged.

> \>Crm Exception: Message: accessing_ws_metadata_exchange_failed: Accessing WS metadata exchange failed, ErrorCode: -2147204335, InnerException: Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: accessing_ws_metadata_exchange_failed: Accessing WS metadata exchange failed ---> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host
>
> \>Crm Exception: Message: Authentication was canceled., ErrorCode: -2147167708
>
> \>Exception during Signin Microsoft.Crm.Outlook.ClientAuth.CrmClientAuthException: Authentication was canceled.

If you happen to take a Fiddler trace during the troubleshooting, you will see the following error code in the header response of the GET request to the ADFS server.

> X-MS-Forwarded-Status-Code: 500

## Cause

One possible cause of this issue is that Forms Authentication was not enabled for the Intranet zone on the ADFS server in the ADFS Management console.

## Resolution

Enable forms authentication within the ADFS Management Console.

1. On the server where ADFS is enabled, open the Management Console. Select **Start**, type *Administrative Tools* and press Enter.
2. Double-click AD FS Management to open it.
3. In the management console, select **Authentication Policies**.
4. Now in the right window pane, in the Global Settings under Primary Authentication, select the **Edit** button.
5. Verify that Forms Authentication is checked both in the Extranet and Intranet sections. By default Forms Authentication is unchecked in the Intranet section.
6. Select **OK**.

:::image type="content" source="media/receiving-error-accessing-ws-metadata-exchange-failed-during-configuration/edit-global-authentication-policy-window.png" alt-text="Screenshot to verify that Forms Authentication is checked both in the Extranet and Intranet sections." border="false":::
