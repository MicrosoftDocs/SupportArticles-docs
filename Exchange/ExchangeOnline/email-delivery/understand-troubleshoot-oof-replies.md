---
title: Understanding and troubleshooting Out of Office (OOF) replies
description: Discusses how the Out of Office works and some of the main reasons why an Out of Office reply might not get delivered to users. 
author: helenclu
ms.author: damande
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 119624
- CSSTroubleshoot
ms.reviewer: damande
appliesto:
- Exchange Online
search.appverid: 
- MET150
---
# Understanding and troubleshooting Out of Office (OOF) replies

Out of Office (OOF) replies can be a bit of a mystery. How do they work? Why do they sometimes not get delivered to other users, and what do you do if they don't? This article discusses the bits and pieces of OOF replies from the perspective of an Exchange Online configuration. However, much of this discussion also applies to an on-premises configuration.

(By the way if you've ever wondered why "Out of Office" is abbreviated as "OOF" instead of as "OOO," see
[this blog post](https://techcommunity.microsoft.com/t5/exchange-team-blog/why-is-oof-an-oof-and-not-an-ooo/ba-p/610191)).

## What are Out of Office replies?

OOF — or automatic — replies are Inbox rules that are set in the user's mailbox by the client. OOF rules are server-side rules. Therefore, they are triggered regardless of whether the client is running.

Automatic replies can be configured as follows:

- By using the automatic reply feature from within Outlook [as explained here](https://support.office.com/article/Send-automatic-out-of-office-replies-from-Outlook-9742f476-5348-4f9f-997f-5e208513bd67)
- By using other clients, such as Outlook on the web (OWA)
- By running a PowerShell command ([Set-MailboxAutoReplyConfiguration](/powershell/module/exchange/set-mailboxautoreplyconfiguration))

Admins can set up OOF replies from the M365 Admin Portal on behalf of users.

If automatic replies are enabled, only one reply is sent to each sender even if a recipient receives multiple messages from a sender.

In addition to using the built-in OOF functionality in their client, people sometimes [use rules to create an Out of Office message](https://support.office.com/article/use-rules-to-create-an-out-of-office-message-9f124e4a-749e-4288-a266-2d009686b403) while they are away.

By design, Exchange Online Protection uses the [high risk delivery pool](/microsoft-365/security/office-365-security/high-risk-delivery-pool-for-outbound-messages) (HRDP) to send OOF replies. This is because OOF replies are lower-priority messages.

## Types of OOF rules

There are three types of OOF rules:

- Internal
- External
- Known Senders (contact list)

These rules are set individually in the user's mailbox. Each rule has an associated message class and name. The rule name is stored in the **PR_RULE_MSG_NAME property**. The following table lists the message class and name that are associated with each OOF rule.

|Type |Message class  |PR_RULE_MSG_NAME|
|---------|---------|---------|
|Internal |IPM.Rule.Version2.Message |Microsoft.Exchange.OOF.KnownExternalSenders.Global |
|External |IPM.Rule.Version2.Message |Microsoft.Exchange.OOF.AllExternalSenders.Global |
|Known Senders |IPM.ExtendedRule.Message |Microsoft.Exchange.OOF.KnownExternalSenders.Global|
||||

> [!NOTE]
> In addition to the OOF rules, other rules (such as the Junk Email rule) also have the **IPM.ExtendedRule.Message** message class. The **MSG_NAME** variable determines how the rule is used.

## OOF rule details

All Inbox rules can be viewed by using the [MFCMapi](https://github.com/stephenegriffin/mfcmapi/releases) tool, as follows::

1. Log on to the tool .
2. Select the profile that is associated with the mailbox that has the OOF rules
3. At the top of the information store, select **Inbox**, and then right-click **Open associated contents table**.

OOF rules in MFCMapi:

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF01.jpg" alt-text="Screenshot of OOF rules in MFCMapi.":::

OOF rules templates in MFCMapi:

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF02.jpg" alt-text="Screenshot 1 of OOF rule templates in MFCMapi.":::

## OOF response history

An OOF response is sent one time per recipient. The list of recipients to whom the OOF response is sent are stored in the OOF history, which is cleared out either when the OOF state changes (enabled or disabled) or when the OOF rule is modified. OOF history is stored in the user's mailbox, and can be viewed by using the MFCMapi tool at: **Freebusy Data** > **PR_DELEGATED_BY_RULE**.

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF03.jpg" alt-text="Screenshot 2 of OOF rule templates in MFCMapi.":::

> [!NOTE]
> If you want to send a response to the sender every time instead of only one time, you can apply the "have server reply using a specific message" mailbox server-side rule instead of using the OOF rule. This alternative rule sends a response every time that a message is received.

## Troubleshoot OOF issues

The following sections discuss some of the scenarios in which OOF replies are not sent to the sender. They include possible fixes and some more frequently seen OOF configuration issues that you may have experienced.

### OOF issues related to transport rules

If an OOF reply appears not to have been sent for all users in the tenant, a transport rule is usually to blame. Check all the transport rules that may apply to the affected mailbox by using step 2 of [this article](https://support.microsoft.com/help/2866165/senders-don-t-receive-out-of-office-notifications-from-an-office-365-u).

If you suspect a delivery problem, run a [message trace](/microsoft-365/security/office-365-security/message-trace-scc) from the Office 365 tenant. For OOF messages, the sender of the original message becomes the recipient during tracking. You should be able to determine whether the OOF reply has been triggered and sent to an external or internal recipient. The message trace will clearly indicate whether a transport rule is blocking the OOF response.

There is one scenario that is worth highlighting when it comes to transport rules blocking OOF replies. Let's assume that you moved the MX record to a third-party anti-spam program. You have created a transport rule to reject any email message that is sent from any IP address other than the third-party anti-spam program.

The transport rule will look something like this:

> Description:
>
> If the message: Is received from 'Outside the organization'  
> Take the following actions: reject the message and include the explanation 'You are not > permitted to bypass the MX record!' with the status code: '5.7.1'  
> Except if the message: sender ip addresses belong to one of these ranges: '1xx.1xx.7x.3x'  
> ManuallyModified: False  
> SenderAddressLocation: Envelope

Because OOF rules have a blank (<>) return path, the OOF rule unexpectedly matches the transport rule, and OOF responses get blocked.

To fix this issue, change the "Match sender address in message" transport rule property to "Header or envelope" so that the checks will also be done against the **From**(also known as "Header From"), **Sender**, or **Reply-To** fields. For more information about mail flow rule conditions, see the "Senders" section of
[this article](/Exchange/policy-and-compliance/mail-flow-rules/conditions-and-exceptions).

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF04.png" alt-text="Screenshot 3 of OOF rule templates in MFCMapi.":::

### JournalingReportNdrTo mailbox setting

If the affected mailbox is one that is configured under the `JournalingReportNdrTo` setting, OOF replies will not be sent for that mailbox. Additionally, journaling email messages may also be affected. A recommended practice is to create a dedicated mailbox for the `JournalingReportNdrTo` setting. Alternatively, you can set the dedicated mailbox to an external address.

For more information about how to resolve this issue, see [this article](https://support.microsoft.com/help/2829319/transport-and-mailbox-rules-in-exchange-online-or-in-on-premises-excha).

### Forwarding SMTP address is enabled on the mailbox

If the affected user mailbox has [SMTP forwarding](/microsoft-365/admin/email/configure-email-forwarding?preserve-view=true&view=o365-worldwide#configure-email-forwarding) enabled, OOF replies won't be generated. This can be checked in any of the following locations:

- In the user mailbox settings in the client (such as OWA):

    :::image type="content" source="media/understand-troubleshoot-oof-replies/OOF05.png" alt-text="Screenshot of forwarding SMTP address.":::

- In PowerShell:

    ```powershell
    Get-Mailbox -Identity Daniel | fl DeliverToMailboxAndForward, ForwardingSmtpAddress, ForwardingAddress
    ```

    :::image type="content" source="media/understand-troubleshoot-oof-replies/OOF06.jpg" alt-text="Screenshot of checking forwarding SMTP address using PowerShell.":::

- In User Properties in the M365 Portal:

    :::image type="content" source="media/understand-troubleshoot-oof-replies/OOF07.png" alt-text="Screenshot of checking forwarding SMTP address using portal." :::

For information about how to resolve this issue, see [this article](https://support.microsoft.com/help/2866165/senders-don-t-receive-out-of-office-notifications-from-an-office-365-u).

### OOF reply type that is set on remote domains

You have to pay attention to which OOF reply type is set up on [remote domains](/exchange/mail-flow-best-practices/remote-domains/manage-remote-domains) because this will affect the OOF reply. If the configuration of the OOF reply type is incorrect, an OOF reply may not be generated at all.

There are four OOF reply types:

- External
- ExternalLegacy
- InternalLegacy
- None

For more information about these OOF types, see the **AllowedOOFType** entry in the "Parameters" section of [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain?preserve-view=true&view=exchange-ps#parameters).

You can check the OOF reply type from **Exchange Admin Center** > **Mail flow** > **Remote domains**.

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF08.png" alt-text="Screenshot of checking OOF reply type using portal." border="false":::

Alternatively, you can run the following PowerShell cmdlet:

```powershell
Get-RemoteDomain | ft -AutoSize Name, DomainName, AllowedOOFType
```

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF09.png" alt-text="Screenshot of checking OOF reply using PowerShell.":::

As an example, assume that you have a hybrid organization that includes mailboxes that are hosted both in Exchange on-premises and Exchange Online. By design, only external messages in this scenario will be sent to Exchange on-premises if **AllowedOOFType** is set to **External**. To send internal OOF messages to Exchange on-premises in a hybrid environment, you have to set **AllowedOOFType** to **InternalLegacy**.

You also have the option at the mailbox configuration level (ExternalAudience: Known) to send external OOF replies only to people who are listed as your Contacts. The command to check the configuration is as follows:

```powershell
Get-MailboxAutoReplyConfiguration daniel | fl ExternalAudience
```

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF10.jpg" alt-text="Screenshot of checking OOF reply configuration using PowerShell.":::

### Remote domain blocks OOF replies

Another setting on remote domains is one that you use to allow or prevent messages that are automatic replies from client email programs in your organization.

This can be found in **Exchange Admin Center** > **Mail flow** > **Remote domains**.

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF11.jpg" alt-text="Screenshot of checking OOF reply blocking using portal.":::

Alternatively, you can run the following PowerShell cmdlet:

```powershell
Get-RemoteDomain | ft -AutoSize Name, DomainName, AutoReplyEnabled
```

:::image type="content" source="media/understand-troubleshoot-oof-replies/OOF12.jpg" alt-text="Screenshot of checking OOF reply blocking using PowerShell.":::

> [!NOTE]
> If the value of the setting is **false**, no automatic replies will be sent to users in that domain. This setting takes precedence over the automatic replies that are set up at the mailbox level or over the OOF type (as discussed earlier).
> Keep in mind that **false** is the default value for new remote domains that you create and also for the built-in remote domain named "Default" in Exchange Online.

### If the email message is marked as spam and sent to Junk, an automatic reply is not generated at all

This is pretty self-explanatory.

### Message trace shows delivery failure

As you investigate an OOF reply issue, you might find the following error entry in the message trace:

> "550 5.7.750 Service unavailable. Client blocked from sending from unregistered domains."

If you find this entry, you should reach out to [Microsoft Support](https://support.microsoft.com/contactus/) to learn why the unregistered domain block was enforced.

## Additional OOF issues

When you create, configure, or manage OOF replies, you might also experience the following issues.

### An old or duplicate OOF message is sent

If either an old or duplicate OOF reply is sent, check for a duplicate Inbox rule, and delete it if you find one.

If there isn't an additional Inbox rule, this issue may also occur if the OOF history reaches its limit. The OOF history has a limit of 10,000 entries. If this threshold is reached, new users can't be added to the history list. In this situation, OOF replies will continue to be sent to recipients who are not already in the list – one reply for every message sent by the recipients. All users who are already in the list will not receive duplicate OOF replies.

To resolve this issue, use one of the following methods.

#### Method 1

1. Remove the OOF rules and the OOF rules templates from the mailbox. To locate the rules, see the [OOF rule details](#oof-rule-details) section.
2. Disable and then re-enable the OOF feature for the mailbox.
3. Check again whether the OOF feature works as expected and the symptoms do not occur.

#### Method 2

If Method 1 doesn't resolve the issue, remove the OOF response history.

1. Disable automatic replies in Outlook if currently enabled and exit Outlook.
2. Log on to the [MFCMapi](https://github.com/stephenegriffin/mfcmapi/releases)  tool and select **Tools** > **Options**.
3. Select the following check boxes:

     - **Use the MDB_ONLINE flag when calling OpenMsgStore**
     - **Use the MAPI_NO_CACH flag when calling OpenEntry**

4. Select **Session** > **Logon**.
5. Select the Outlook profile for the mailbox and double-click to open it.
6. Expand **Root Container** and then select **Freebusy Data**.
7. In the **Other Names** column, right-click the **PR_DELEGATED_BY_RULE** property that has the **0x3FE30102** tag, point to **Edit as stream**, and then select **Binary**.
8. Select all the text in the **Stream (Binary)** box and delete it.

### Two different OOF messages are sent

If two different OOF messages are sent, and you don't find an additional Inbox rule, the culprit is likely an OOF rule in the Outlook client. To check for and delete such a rule, follow these steps:

1. In the Outlook client, select **File** > **Automatic Replies** > **Rules**.
2. Select the OOF rule and then select **Delete Rule**.

    :::image type="content" source="media/understand-troubleshoot-oof-replies/auto-reply-rule.png" alt-text="Delete auto-reply rule":::

### Automatic replies cannot be enabled and an error message is received

When you try to access automatic replies from the Outlook client, you receive the following error message:

> "Your automatic reply settings cannot be displayed because the server is currently unavailable. Try again later."

To help narrow down this issue, follow these steps:

- Verify that the EWS protocol is enabled on the mailbox. OOF replies rely on this protocol. (Notice that it might take several hours for the protocol to be re-enabled.)
- Enable the OOF feature by running the following cmdlet:

    ```powershell
    Set-MailboxAutoReplyConfiguration <identity> -AutoReplyState Enabled
    ```

- Check whether the OOF feature works as expected.
- If the issue still exists, review the rules quota on the mailbox:

    ```powershell
    Get-mailbox -identity <mailbox> | fl RulesQuota
    ```

    :::image type="content" source="media/understand-troubleshoot-oof-replies/OOF13.jpg" alt-text="Screenshot of checking mailbox identity.":::

    By default, the RulesQuota parameter has a maximum value of 256 KB (262,144 bytes). This is determined by the size of the rules, not the number of rules.

- Remove the OOF rules and the OOF rules templates from the mailbox.
To locate the rules, see the [OOF rule details](#oof-rule-details) section. After you remove the rules, you can re-enable the OOF feature and then test again.

### An automatic reply is sent even if OOF is disabled

In some scenarios, OOF messages are still sent even though the feature is disabled. This might occur if the rule is created manually by using the [out-of-office template](https://support.office.com/article/use-rules-to-create-an-out-of-office-message-9f124e4a-749e-4288-a266-2d009686b403).