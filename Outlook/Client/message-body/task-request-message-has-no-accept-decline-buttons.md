---
title: Outlook doesn't show the Accept and Decline buttons in a task request
description: Describes an issue in which Outlook doesn't show the Accept and Decline buttons in a task request.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - Exchange Online
  - CSSTroubleshoot
  - CI 167428
ms.reviewer: pedrocorreia, arindamt, meerak
appliesto: 
  - Outlook for Microsoft 365
  - Exchange Online
search.appverid: MET150
ms.date: 10/19/2022
---
# Outlook doesn't show the Accept and Decline buttons in a task request

## Symptoms

When you send a task request message in Outlook, the recipient's task request doesn't contain the **Accept** and **Decline** buttons or have legible task details. This issue can occur for recipients who are internal or external to your Exchange organization.

For example, the recipient's task request might look like the following.

:::image type="content" source="media/task-request-message-has-no-accept-decline-buttons/task-tnef-disabled.png" alt-text="Screenshot of a task request message that doesn't contain the Accept and Decline buttons or have legible task details.":::

The next screenshot shows what the task request should have looked like.

:::image type="content" source="media/task-request-message-has-no-accept-decline-buttons/task-tnef-enabled.png" alt-text="Screenshot of a task request message that does contain the Accept and Decline buttons and has legible task details.":::

## Cause

Outlook sent the task request as a Rich Text Format (RTF) message, but a transport component changed the message format to HTML. The conversion to HTML removed the button elements and scrambled the message layout.

If the recipient is *internal* to your Exchange organization, your Exchange configuration might have:

- An [outbound connector](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/use-connectors-to-configure-mail-flow) that routes messages through an external service. Internal mail flow preserves the format of RTF messages, but external services often convert RTF messages to HTML. For example, signature and privacy disclaimer services convert RTF messages to HTML.

If the recipient is *external* to your Exchange organization, your Exchange configuration might have:

- An outbound connector that routes messages through an external service that changes the message format to HTML, or

- A [remote domain](/exchange/mail-flow-best-practices/remote-domains/remote-domains) `TNEFEnabled` setting that converts outbound RTF messages to HTML.

## Resolution

To resolve the issue, check the following settings and make the appropriate changes:

- **For internal and external recipients**, check whether an outbound connector routes messages through an external service. If so, consider adding an [exception](/exchange/security-and-compliance/mail-flow-rules/conditions-and-exceptions) to the mail flow rule that routes messages to that connector. For example, you can exclude task request messages from being routed through external services by creating an exception for messages that have a subject that starts with "`Task request:`".

- **For external recipients**, check the `TNEFEnabled` setting for all remote domains by running the following command:

  ```powershell
  Get-RemoteDomain | Where {$_.TNEFEnabled -ne $true}
  ```

If the `TNEFEnabled` setting for a remote domain is `$null` or `$false`, then Exchange will convert RTF messages to HTML for recipients in that domain. For example, if the `TNEFEnabled` setting for your default remote domain is `$null` and if it's your only remote domain, then Exchange will convert all external RTF messages to HTML. To fix the issue for an affected external recipient:

1. [Create a remote domain](/powershell/module/exchange/new-remotedomain) for the affected external recipient's domain.

2. Set `TNEFEnabled` to `$true` for that domain by running the following command:

   ```powershell
   Set-RemoteDomain -Identity <name of the new remote domain> -TNEFEnabled $true
   ```

> [!NOTE]
>
> Avoid setting `TNEFEnabled` to `$true` on the default remote domain because that will affect all external recipients including those whose email client might not support RTF messages.
