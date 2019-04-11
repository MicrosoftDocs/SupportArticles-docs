---
title: "Use Telnet to test SMTP communication on Exchange servers"
ms.author: chrisda
author: chrisda
manager: serdars
ms.date: 6/8/2018
ms.audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.assetid: 8a5f6715-baa4-48dd-8600-02c6b3d1aa9d
description: "Summary: Learn how to use Telnet to test SMTP connectivity and mail flow on Exchange servers."
---

# Use Telnet to test SMTP communication on Exchange servers

You can use Telnet to test Simple Mail Transfer Protocol (SMTP) communication between messaging servers. SMTP is the protocol that's used to send email messages from one messaging server to another. Using Telnet can be helpful if you're having trouble sending or receiving messages because you can manually send SMTP commands to a messaging server. In return, the server will reply with responses that would be returned in a typical connection. These results can sometimes help you to figure out why you can't send or receive messages.

You can use Telnet to test SMTP communication to:

- Test mail flow from the Internet into your Exchange organization.

- Test mail flow from your Exchange to another messaging server on the Internet.

> [!TIP]
> Did you know that, instead of using Telnet to test SMTP connectivity, you can use the Microsoft Remote Connectivity Analyzer at [https://testconnectivity.microsoft.com/](https://testconnectivity.microsoft.com/)? With the Remote Connectivity Analyzer, you can choose the connectivity test you want to do, in this case **Inbound SMTP Email**, and follow the instructions shown. It'll step you through the information you need to enter, run the test for you, and then give you the results. Give it a try! 

## What do you need to know before you begin?

- Estimated time to complete: 15 minutes

- Exchange permissions don't apply to the procedures in this topic. These procedures are performed in the operating system of the Exchange server or a client computer.

- This topic shows you how to use Telnet Client, which is included with Windows. Third-party Telnet clients might require syntax that's different from what's shown in this topic.

- The steps in this topic show you how to connect to an Internet-facing server that allows anonymous connections using TCP port 25. If you're trying to connect to this server from the Internet, you need to make sure your Exchange server is reachable from the Internet on TCP port 25. Similarly, if you're trying to reach a server on the Internet from your Exchange server, you need to make sure your Exchange server can open a connect to the Internet on TCP port 25.

- You might notice some Receive connectors that use TCP port 2525. These are internal Receive connectors and aren't used to accept anonymous SMTP connections.

- If you're testing a connection on a remote messaging server, you should run the steps in this topic on your Exchange server. Remote messaging servers are often set up to make sure the IP address where the SMTP connection is coming from matches the domain in the sender's email address.

- For information about keyboard shortcuts that may apply to the procedures in this topic, see [Keyboard shortcuts in the Exchange admin center](../about-documentation/exchange-admin-center-keyboard-shortcuts.md).

> [!TIP]
> Having problems? Ask for help in the Exchange forums. Visit the forums at: [Exchange Server](https://go.microsoft.com/fwlink/p/?linkId=60612), [Exchange Online](https://go.microsoft.com/fwlink/p/?linkId=267542), or [Exchange Online Protection](https://go.microsoft.com/fwlink/p/?linkId=285351).

## Step 1: Install the Telnet Client on your computer

On most versions of Windows, you'll need to install the Telnet client before you can use it. To install it, see [Install Telnet Client](https://go.microsoft.com/fwlink/p/?linkId=179054).

## Step 2: Find the FQDN or IP address of the destination SMTP server

To connect to an SMTP server by using Telnet on port 25, you need to use the fully-qualified domain name (FQDN) (for example, mail.contoso.com) or the IP address of the SMTP server. If you don't know the FQDN or IP address, you can use the Nslookup command-line tool to find the MX record for the destination domain.

> [!NOTE]
> Network policies might prevent you from using the Nslookup tool to query public DNS servers on the Internet. As an alternative, you can use one of the freely-available DNS lookup or MX record lookup web sites on the Internet.

1. At a command prompt, type nslookup, and then press Enter. This command opens the Nslookup session.

2. Type set type=mx, and then press Enter.

3. Type the name of the domain for which you want to find the MX record. For example, to find the MX record for the fabrikam.com domain, type fabrikam.com., and then press Enter.

    > [!NOTE]
    > When you use a trailing period ( . ), you prevent any default DNS suffixes from being unintentionally added to the domain name.

    The output of the command looks like this:

  ```
  fabrikam.com mx preference=10, mail exchanger = mail1.fabrikam.com
  fabrikam.com mx preference=20, mail exchanger = mail2.fabrikam.com
  mail1.fabrikam.com internet address = 192.168.1.10
  mail2 fabrikam.com internet address = 192.168.1.20
  ```

    You can use any of the host names or IP addresses that are associated with the MX records as the destination SMTP server. A lower value for preference (preference = 10 vs. 20) indicates a preferred SMTP server. Multiple MX records and different values of preference are used for load balancing and fault tolerance.

4. When you're ready to end the Nslookup session, type exit, and then press Enter.

## Step 3: Use Telnet on Port 25 to test SMTP communication

In this example, we're going to use the following values. When you run the commands on your server, replace these values with ones for your organization's SMTP server, domain, etc.

- **Destination SMTP server**: mail1.fabrikam.com

- **Source domain**: contoso.com

- **Sender's e-mail address**: chris@contoso.com

- **Recipient's e-mail address**: kate@fabrikam.com

- **Message subject**: Test from Contoso

- **Message body**: This is a test message

> [!TIP]
> The commands in the Telnet Client aren't case-sensitive. The SMTP command verbs in this example are capitalized for clarity. You can't use the backspace key in the Telnet session after you connect to the destination SMTP server. If you make a mistake as you type an SMTP command, you need to press Enter, and then type the command again. Unrecognized SMTP commands or syntax errors result in an error message that looks like this: `500 5.3.3 Unrecognized command`

1. Open a Command Prompt window, type `telnet`, and then press Enter.

     This command opens the Telnet session.

2. Type `set localecho`, and then press Enter.

     This **optional** command lets you view the characters as you type them, and it might be required for some SMTP servers.

3. Type `set logfile <filename>`, and then press Enter.

     This **optional** command enables logging and specifies the log file for the Telnet session. If you only specify a file name, the log file is located in the current folder. If you specify a path and file name, the path needs to be on the local computer, and you might need to enter the path and file name in the Windows DOS 8.3 format (short name with no spaces). The path needs to exist, but the log file is created automatically.

4. Type `OPEN mail1.fabrikam.com 25`, and then press Enter.

5. Type `EHLO contoso.com`, and then press Enter.

6. Type `MAIL FROM:<chris@contoso.com>`, and then press Enter.

7. Type `RCPT TO:<kate@fabrikam.com> NOTIFY=success,failure`, and then press Enter.

     The optional NOTIFY command specifies the particular delivery status notification (DSN) messages (also known as bounce messages, nondelivery reports, or NDRs) that the SMTP is required to provide. In this example, you're requesting a DSN message for successful or failed message delivery.

8. Type `DATA`, and then press Enter.

9. Type `Subject: Test from Contoso`, and then press Enter.

10. Press Enter again.

     A blank line is needed between the **Subject:** field and the message body.

11. Type `This is a test message`, and then press Enter.

12. Type a period ( . ), and then press Enter.

13. To disconnect from the SMTP server, type `QUIT`, and then press Enter.

14. To close the Telnet session, type `quit`, and then press Enter.

Here's what a successful session using the steps above looks like:

```
C:\Windows\System32> telnet
Microsoft Telnet> set localecho
Microsoft Telnet> set logfile c:\TelnetTest.txt
Microsoft Telnet> OPEN mail1.fabrikam.com 25
220 mail1.fabrikam.com Microsoft ESMTP MAIL Service ready at Fri, 5 Aug 2016 16:24:41 -0700
EHLO contoso.com
250-mail1.fabrikam.com Hello [172.16.0.5]
250-SIZE 37748736
250-PIPELINING
250-DSN
250-ENHANCEDSTATUSCODES
250-STARTTLS
250-X-ANONYMOUSTLS
250-AUTH NTLM
250-X-EXPS GSSAPI NTLM
250-8BITMIME
250-BINARYMIME
250-CHUNKING
250 XRDST
MAIL FROM: <chris@contoso.com>
250 2.1.0 Sender OK
RCPT TO: <kate@fabrikam.com> NOTIFY=success,failure
250 2.1.5 Recipient OK
DATA
354 Start mail input; end with <CRLF>.<CRLF>
Subject: test
 
This is a test message.
.
250 2.6.0 <c89b4fcc-3ad1-4758-a1ab-1e820065d622@mail1.fabrikam.com> [InternalId=5111011082268, Hostname=mail1.fabrikam.com] Queued mail for delivery
QUIT
221 2.0.0 Service closing transmission channel
```

## Step 4: Success and error messages in the Telnet Session

This section provides information about the success and failure responses to the commands that were used in the previous example.

> [!NOTE]
> The three-digit SMTP response codes that are defined in RFC 5321 are the same for all SMTP messaging servers, but the text descriptions in the responses might be slightly different.

### SMTP reply codes

SMTP servers respond to commands with a variety of numerical reply codes in the format of x.y.z where:

- X indicates whether the command was good, bad, or incomplete.

- Y indicates the kind of response that was sent.

- Z provides additional information about the command

When a response is received by the server that opened the connection, it can tell whether the remote server accepted the command and is ready for the next one, or if an error occurred.

The first digit (X) is particularly important to understand because it indicates the success or failure of the command that was sent. Here are its possible values, and their meanings.

|**Reply code**|**Meaning**|
|:-----|:-----|
|2.y.z|The command that was sent was successfully completed on the remote server. The remote server is ready for the next command.|
|3.y.z|The command was accepted but the remote server needs more information before the operation can be completed. The sending server needs to send a new command with the needed information.|
|4.y.z|The command wasn't accepted by the remote server for a reason that might be temporary. The sending server should try to connect again later to see if the remote server can successfully accept the command. The sending server will continue to retry the connection until either a successful connection is completed (indicated by a 2.y.z code) or fails permanently (indicated by a 5.y.z code).  <br/> An example of a temporary error is low storage space on the remote server. Once more space is made available, the remote server should be able to successfully accept the command.|
|5.y.z|The command wasn't accepted by the remote server for a reason that is isn't recoverable. The sending server won't retry the connection and will send a non-delivery report back to the user who sent the message.  <br/> An example of an unrecoverable error is a message that's sent to an email address that doesn't exist.|
 
The table above is based on information provided by [RFC 5321 (Simple Mail Transfer Protocol), section 4.2.1](https://go.microsoft.com/fwlink/p/?LinkID=824668). Additional information, including descriptions of the second (Y) and third (Z) digits of SMTP reply codes is included in this section, and in sections [4.2.2](https://go.microsoft.com/fwlink/p/?LinkId=824669) and [4.2.3](https://go.microsoft.com/fwlink/p/?LinkId=824670).

### OPEN command

 **Successful response**: `220 mail1.fabrikam.com Microsoft ESMTP MAIL Service ready at <day-date-time>`

 **Failure response**: `Connecting to mail1.fabrikam.com...Could not open connection to the host, on port 25: Connect failed`

 **Possible reasons for failure**

- The destination SMTP service is unavailable.

- Restrictions on the destination firewall.

- Restrictions on the source firewall.

- Incorrect FQDN or IP address for the destination SMTP server.

- Incorrect port number.

### EHLO command

 **Successful response**: `250 mail1.fabrikam.com Hello [<sourceIPaddress>]`

 **Failure response**: `501 5.5.4 Invalid domain name`

 **Possible reasons for failure**

- Invalid characters in the domain name.

- Connection restrictions on the destination SMTP server.

> [!NOTE]
> EHLO is the Extended Simple Message Transfer Protocol (ESMTP) verb that's defined in RFC 5321. ESMTP servers can advertise their capabilities during the initial connection. These capabilities include the maximum accepted message size and supported authentication methods. HELO is the older SMTP verb that is defined in RFC 821. Most SMTP messaging servers support ESMTP and EHLO. If the non-Exchange server that you're trying to connect to doesn't support EHLO, you can use HELO instead.

### MAIL FROM command

 **Successful response**: `250 2.1.0 Sender OK`

 **Failure response**: `550 5.1.7 Invalid address`

 **Possible reasons for failure**: A syntax error in the sender's e-mail address.

 **Failure response**: `530 5.7.1 Client was not authenticated`

 **Possible reasons for failure**: The destination server doesn't accept anonymous message submissions. You receive this error if you try to use Telnet to submit a message directly to a Mailbox server that doesn't have a Receive connector that's configured to accept anonymous connections.

### RCPT TO command

 **Successful response**: `250 2.1.5 Recipient OK`

 **Failure response**: `550 5.1.1 User unknown`

 **Possible reasons for failure**: The specified recipient doesn't exist.


