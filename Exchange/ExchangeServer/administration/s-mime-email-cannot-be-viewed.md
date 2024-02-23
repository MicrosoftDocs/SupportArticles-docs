---
title: S/MIME encoded email cannot be viewed
description: When a recipient tries to view an email that is encoded by using S/MIME in Exchange Server 2010 Service Pack 2, the recipient receives the Cannot open this item error message or This message can't be decrypted error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: benwinz, wduff, bradhugh, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 2
search.appverid: MET150
ms.date: 01/24/2024
---
# A recipient cannot view an email message that is encoded by using S/MIME

_Original KB number:_ &nbsp; 2621062

## Symptoms

Consider these scenarios：

Scenario 1

- You access a mailbox that is hosted on Exchange Server 2010 Service Pack 2 (SP2).
- You download and install the Secure/Multipurpose Internet Mail Extensions (S/MIME) control in Outlook Web App (OWA). Then, you do one of the following:
  - You use the S/MIME control in OWA to encrypt an email message.
  - You use Outlook to encrypt an email message.
- You send the email message to a distribution list.
- A recipient tries to open the email message in Outlook.

In this scenario, the recipient may receive this error message:

> Cannot open this item. Your Digital ID name cannot be found by the underlying security system

Scenario 2

- You access a mailbox that is hosted on Exchange Server 2010 SP2.
- You download and install the S/MIME control in Outlook Web App (OWA). Then, you do one of the following:
  - You use the S/MIME control in OWA to encrypt an email message.
  - You use Outlook to encrypt an email message.
- You send the email message to a distribution list.
- A recipient tries to open the email message in Outlook Web App (OWA).

In this scenario, the recipient may receive this error message:

> This message can't be decrypted because its encryption algorithm isn't supported or your digital ID can't be found. If you have a smart card-based digital ID, insert the card and try again to open the message.

## Cause

This issue can occur if all these conditions are true:

- An Exchange Administrator has defined an Address Book policy.
- The scope of the Address Book policy does not include all members of the distribution group.

> [!NOTE]
> This behavior is by design.

## Resolution - Method 1

Use the Contacts feature. To do this, follow these steps:

1. Use Outlook to open a digitally signed message from a sender who is not in your Address Book.
2. In the **From:** line, right-click the sender's name, and then select **Add to Outlook Contacts**.
3. In the **Contact** window, select **Certificates** in the **Show** group.
4. Verify the public key certificate for the contact.
5. Select **Save & Close**.
6. Use the Contacts feature to add the user to a list of email message recipients that includes the distribution group. To do this, follow these steps:
   1. In Outlook, select **New**, select **Mail Message**, and then select **To**.
   2. Under **Address Book**, select **Contacts**.
   3. Double-click the user whom you want to add.

## Resolution - Method 2

Do not create distribution lists that contain members when those members span multiple Address Book policies.

## More information

In Exchange Server 2010 SP2, administrators can implement a new feature known as Address Book Policies. This feature lets administrators use a policy to define which Exchange objects a mailbox user can see. This policy is then evaluated by the Address Book Service on the Client Access Server when a mailbox user performs an Address Book query. If the object that is requested in the query does not match the scope that is defined for the policy, the mailbox user cannot see that object.

For Distribution Groups (DG), mailbox users may not see the whole membership of the group if the scope of their Address Book Policy does include all members of that group. The Address Book service in Exchange Server 2010 SP2 implements Named Service Provider Interface (NSPI) segregation. When the mail client tries to perform DL expansion and look up the public certificates for all members of the Distribution List, the mail client cannot see users who do not match the scope of its policy. Therefore, the mail client does not try to look up certificates for the users it cannot see.

After the message is sent, Hub Transport is not subject to Address Book Policies. Therefore, Transport can send the message to the actual membership of the Distribution List when Distribution List expansion is performed.

When you send to a Distribution List that contains members that you cannot see, Outlook and Outlook Web App cannot locate the recipient's certificate information in Active Directory Domain Services. Therefore, the certificate information is not used to encode the lockbox, and the recipient cannot locate the certificate and private key to decrypt the message.

When you use either of the methods that are listed in the Resolution section to encrypt email messages, the recipient can determine how to locate the certificate and private key for decrypting the message.

## References

For more information about Address Book Policies, see [Understanding Address Book Policies](/Exchange/email-addresses-and-address-books/address-book-policies/address-book-policies?).
