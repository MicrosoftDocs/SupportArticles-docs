---
title: Determine whether Microsoft 365 account is compromised
description: Describes how to determine whether your Microsoft 365 account has been compromised.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# How to determine whether your Microsoft 365 account has been compromised

## Problem 

You may have issues when you try to sign in to Microsoft 365. Or, you notice that suspicious activity occurs in your account, such as large amounts of spam that originates from your account.

You may also experience one or more of the following issues:

- The Sent or Deleted Items folders in Microsoft Outlook or in Microsoft Outlook Web App contain common hacked-account messages, such as "I'm stuck in London, send money."
- Unusual profile changes, such as the name, the telephone number, or the postal code were updated.
- Unusual credential changes, such as multiple password changes are required.
- Mail forwarding was recently added.
- An unusual signature was recently added, such as a fake banking signature or a prescription drug signature.

## Solution

Even after you've regained access to your account, the attacker may have added back-door entries that enable the attacker to resume control of the account.

To help resolve these issues, you must perform all the following steps within five minutes of regaining access to your account to make sure that the hijacker doesn't resume control your account. These steps help you remove any back-door entries that the hijacker may have added to your account. After you perform these steps, we recommend that you run a virus scan to make sure that your computer isn't compromised.

### Step 1: Make sure that your computer isn't compromised

1. Make sure that you have Windows Update turned on.
1. If antivirus software isn't installed on your computer, we recommend that you install antivirus software and then run a scan to make sure that no malicious software is installed on the computer. You can download free anti-malware or antivirus software from Microsoft.

### Step 2: Make sure that the attacker can't log on to your Microsoft 365 account

1. Change your password immediately. Make sure that the password is strong and that it contains upper and lowercase letters, at least one number, and at least one special character.
1. Don't reuse any of your last five passwords. Even though the password history requirement lets you reuse a more recent password, you should select something that the attacker can't guess.
1. If your on-premises identity is federated with Microsoft 365, you must change your password on-premises, and then you must notify your administrator of the compromise.

### Step 3: Make sure that the attacker can't resume access to your account

1. Make sure that the Exchange account doesn't auto-forward addresses. For more information, go to the following webpage:

    [Forward messages automatically with a rule](https://support.office.com/article/use-rules-to-create-an-out-of-office-message-9f124e4a-749e-4288-a266-2d009686b403?ocmsassetID=HA103465692&CorrelationId=4b6954bc-fd83-43b7-ab43-571f0cfec47f)
1. Make sure that the Exchange server isn't sending auto-replies.
1. Make sure that your contact information, such as telephone numbers and addresses, is correct.

### Step 4: Additional precautionary steps

1. Make sure that you verify your sent items. You may have to inform people on your contacts list that your account was compromised. The attacker may have asked them for money, spoofing, for example, that you were stranded in a different country/region and needed money, or the attacker may send them a virus to also hijack their computers.
1. Any other service that used this Exchange account as its alternative email account may have been compromised. First, perform these steps for your Microsoft 365 subscription, and then perform these steps for your other accounts.

## More information

These issues may occur when your Microsoft 365 subscription has been compromised. In this case, your compromised accounts may be blocked to protect you and your contacts and help you recover your account. 

For more information about phishing scams and fraudulent email messages, go to the following websites:

- [Internet Crime Complaint Center](https://www.ic3.gov/)
- [Securities and Exchange Commission - "Phishing" Fraud](https://www.sec.gov/investor/pubs/phishing.htm)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).