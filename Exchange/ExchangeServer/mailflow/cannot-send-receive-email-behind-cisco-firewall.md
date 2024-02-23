---
title: Can't send or receive email messages behind a Cisco PIX or Cisco ASA firewall
description: Explains that you can't send or receive email messages if an Exchange Server is placed behind a Cisco PIX or ASA firewall device and the PIX or ASA firewall has the Mailguard feature turned on.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: alanmalm, v-darmac, v-six
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2010
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't send or receive email messages behind a Cisco PIX or Cisco ASA firewall with the Mailguard feature turned on

_Original KB number:_ &nbsp;320027

This article discusses the cause of the behavior that you can't send or receive email messages if an Exchange server is placed behind a Cisco PIX or Cisco ASA firewall device and the PIX or ASA firewall has the Mailguard feature turned on. It provides steps to turn off the Mailguard feature of the PIX or ASA firewall.

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect the computer.

## Symptoms

You may experience one or more of the following behaviors:

- You can't receive Internet-based email messages.
- You can't send email messages with attachments.
- You can't establish a telnet session with the Microsoft Exchange server on port 25.
- When you send an EHLO command to the Exchange server, you receive a **Command unrecognized** or an **OK** response.
- You can't send or receive mail on specific domains.
- Problems with Post Office Protocol version 3 (POP3) authentication - 550 5.7.1 relaying denied from local server.
- Problems with duplicate email messages being sent (sometimes five to six times).
- You receive duplicate incoming Simple Mail Transfer Protocol (SMTP) messages.
- Microsoft Outlook clients or Microsoft Outlook Express clients report an 0x800CCC79 error when trying to send email.
- There are problems with binary mime (8bitmime). You receive the text in a non-delivery report (NDR): **554 5.6.1 Body type not supported by Remote Host**.
- There are problems with missing or garbled attachments.
- There are problems with the link state routing between routing groups when a Cisco PIX or Cisco ASA firewall device is between the routing groups.
- The X-LINK2STATE verb isn't passed.
- There are authentication problems between servers over a routing group connector.

## Cause

This issue may occur in the following situation:

- The Exchange server is placed behind a Cisco PIX or Cisco ASA firewall device.

-and-

- The PIX or ASA firewall has the Mailguard feature turned on.
- The Auth and Auth login commands (Extended Simple Mail Transfer Protocol [ESMTP] commands) are stripped by the firewall, and this makes the system think that you're relaying from a non-local domain.

To determine whether Mailguard is running on your Cisco PIX or Cisco ASA firewall, Telnet to the IP address of the MX record, and then verify whether the response looks similar to the following:

   ```console
   220*******************************************************0*2******0***********************

   2002*******2***0*00

   Old versions of PIX or ASA:

   220 SMTP/cmap_________________________________________ read
   ```

> [!NOTE]
> If you have an ESMTP server behind the PIX or ASA firewall, you may have to turn off the Mailguard feature to permit mail to flow correctly. Also, establishing a Telnet session to port 25 may not work with the `fixup protocol smtp` command, especially with a Telnet client that uses character mode.
>
> Besides the Cisco PIX or Cisco ASA firewall, there are several firewall products that have SMTP Proxy capabilities that may produce the issues that are mentioned earlier in this article. The following is a list of firewall manufacturers whose products have SMTP Proxy features:
>
> - Watchguard Firebox
> - Checkpoint
> - Raptor

For additional information, visit the websites listed in the "More information" section.

## Resolution

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We don't recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

> [!NOTE]
> A firewall is designed to help protect your computer from attack by malicious users or by malicious software such as viruses that use unsolicited incoming network traffic to attack your computer. Before you disable your firewall, you must disconnect your computer from all networks, including the Internet.

To resolve this issue, turn off the Mailguard feature of the PIX or ASA firewall.

> [!WARNING]
> If you have an ESMTP server behind the PIX or ASA, you may have to turn off the Mailguard feature to make it possible for mail to correctly flow. If you use the Telnet command to port 25, this may not work with the fixup protocol smtp command, and this is more noticeable with a Telnet client that performs character mode.

To turn off the Mailguard feature of the PIX or ASA firewall:

1. Sign in to the PIX or ASA firewall by establishing a telnet session or by using the console.
2. Type *enable*, and then press Enter.
3. When you're prompted for your password, type your password, and then press Enter.
4. Type *configure terminal*, and then press Enter.
5. Type *no fixup protocol smtp 25*, and then press Enter.
6. Type *write memory*, and then press Enter.
7. Restart or reload the PIX or ASA firewall.

## More information

The PIX or ASA Software Mailguard feature (also called Mailhost in early versions) filters Simple Mail Transfer Protocol (SMTP) traffic. For PIX or ASA Software versions 4.0 and 4.1, the `mailhost` command is used to configure Mailguard. In PIX or ASA Software version 4.2 and later, the `fixup protocol smtp 25` command is used.

> [!NOTE]
> You must also have static IP address assignments and conduit statements for your mail server.

When Mailguard is configured, Mailguard allows only the seven SMTP minimum-required commands as described in request for comment (RFC) 821, section 4.5.1. These seven required commands are as follows:

- HELO
- MAIL
- RCPT
- DATA
- RSET
- NOOP
- QUIT

Other commands, such as KILL and WIZ aren't forwarded to the mail server by the PIX or ASA firewall. Early versions of the PIX or ASA firewall return an **OK** response, even to commands that are blocked. This is intended to prevent an attacker from the knowledge that the commands have been blocked.

To view RFC 821, visit the RFC website: [RFC 821 - Simple Mail Transfer Protocol](http://www.faqs.org/rfcs/rfc821.html).

All other commands are rejected with the **500 Command unrecognized** response.

On Cisco PIX and ASA firewalls with firmware versions 5.1 and later, the `fixup protocol smtp` command changes the characters in the SMTP banner to asterisks except for the "2", "0", "0 " characters. Carriage return (CR) and linefeed (LF) characters are ignored. In version 4.4, all characters in the SMTP banner are converted to asterisks.

### Test Mailguard for proper function

Because the Mailguard feature may return an **OK** response to all commands, it may be hard to determine whether it's active. To determine whether the Mailguard feature is blocking commands that aren't valid, follow these steps.

> [!NOTE]
> The following steps are based on PIX or ASA software version 4.0 and 4.1. To test later versions of PIX or ASA software (version 4.2 and later), use the `fixup protocol smtp 25` command and the appropriate
 **static** and **conduit** statements for your mail server.

#### With Mailguard turned off

1. On the PIX or ASA firewall, use the static and conduit commands to allow all hosts in on TCP port 25 (SMPT).
2. Establish a telnet session on the external interface of the PIX or ASA firewall on port 25.
3. Type a command that's not valid, and then press ENTER. For example, type *goodmorning*, and then press Enter.

    You receive the response: **500 Command unrecognized**.

#### With Mailguard turned on

1. Use the mailhost or the `fixup protocol smtp 25` command to turn on the Mailguard feature on the external interface of the PIX or ASA firewall.
2. Establish a telnet session on the external interface of the PIX or ASA firewall on port 25.
3. Type a command that's not valid, and then press Enter. For example, type *goodmorning*, and then press Enter.

    You receive the response: **OK**.

 When the Mailguard feature is turned off, the mail server responds to the command that's not valid with the **500 Command unrecognized** message. However, when the Mailguard feature is turned on, the PIX or ASA firewall intercepts the command that's not valid, because the firewall passes only the seven minimum required SMTP commands. The PIX or ASA firewall responds with **OK** whether the command is valid or not.

By default, the PIX, or ASA firewall blocks all outside connections from accessing inside hosts. Use the static, access-list, and access-group command statements to permit outside access.

For more information about firewall products that have SMTP Proxy capabilities, visit the following websites:

- [WatchGuard Resources](http://www.watchguard.com)
- [Check Point](http://www.checkpoint.com)
- [Symantec](https://www.broadcom.com/)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
