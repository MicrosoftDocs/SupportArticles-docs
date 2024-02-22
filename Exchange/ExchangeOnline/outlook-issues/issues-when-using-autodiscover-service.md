---
title: Issues when using Autodiscover service
description: Describes an issue in which users can't create new Outlook profiles, view free busy, or connect to a shared mailbox or a public folder in Microsoft 365. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: camlat, munatara, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't create new Outlook profiles, view free/busy, or connect to a shared mailbox or a public folder

_Original KB number:_ &nbsp; 3049615

## Symptoms  

When you use the Autodiscover service in Microsoft 365, you experience one of the following issues:

- You can't create a new Outlook profile.
- When you create a new Outlook profile, an Internet Message Access Protocol (IMAP) profile is used.
- You can't view free/busy information.
- You can't connect to a shared mailbox or a public folder.
- You can't create an Exchange ActiveSync profile.

## Cause

This issue occurs because the Autodiscover process that's used by Outlook receives an unexpected result from a third-party web server when it performs the root domain lookup. For example, Outlook receives a result such as https://<**RootDomain**>/AutoDiscover/AutoDiscover.xml.

Typically, the root domain lookup would fail in this case, and Outlook would perform an Autodiscover lookup against `https://AutoDiscover.<RootDomain>/AutoDiscover/AutoDiscover.xml`. However, because Outlook receives a successful Autodiscover response from the root domain lookup, Outlook tries to authenticate against the advertised protocols such as POP and IMAP, and the operation fails.

For more information about the Autodiscover service, see [Autodiscover service in Exchange Server](/Exchange/architecture/client-access/autodiscover).

## Resolution

Contact your web service provider or the web hosting provider of your domain website, and make sure that the web server is not responding to Autodiscover requests.

## Workaround

To work around this issue if the web service provider or web hosting provider can't resolve it, take one of the following actions:

- Use Outlook on the web (formerly known as Outlook Web App) to access mail.
- Create an Outlook registry key to exclude the HTTPS root domain. For more information about how to do this, see [Unexpected Autodiscover behavior when you have registry settings under the \Autodiscover key](/outlook/troubleshoot/domain-management/unexpected-autodiscover-behavior).

  > [!IMPORTANT]
  > Excluding the HTTPS root domain is not a long-term solution for this issue, and we do not recommend it. This workaround is provided as immediate relief for the issue. As soon as the web service provider or web hosting provider resolves the issue, the Outlook registry key must be removed.

## Use Microsoft Remote Connectivity Analyzer to identify the cause

If you're experiencing symptoms that are related to this issue, you can run Microsoft Remote Connectivity Analyzer to verify and identify the cause. To do this, follow these steps:

1. Connect to [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).
2. Select the **Microsoft 365** tab.
3. Under **Microsoft Office Outlook Connectivity Tests**, select **Outlook Autodiscover**, and then select **Next**.
4. Specify the following information for a mailbox-enabled user account in your domain.
   1. Enter an email address for the SMTP domain in which you're experiencing the issue.

      > [!NOTE]
      > The email address doesn't have to be a valid email address, because no authentication occurs against the Microsoft 365 server.

   2. Enter the user principal name (UPN) that's associated with the email address.

      > [!NOTE]
      > The UPN doesn't have to be associated with a valid email address because no authentication occurs against the Microsoft 365 server.

   3. Enter a password for the account, and then enter the password again in the **Confirm password** box.  

        > [!NOTE]
        > The actual password isn't required because no authentication against Microsoft 365 servers occurs if you're experiencing this issue. Only the SMTP domain name has to be valid.

   4. Select the **Ignore Trust for SSL** checkbox.
   5. Select the **I understand that I must use the credentials of a working account from my Exchange domain to be able to test connectivity to it remotely. I also acknowledge that I am responsible for the management and security of this account** checkbox.

   6. Enter the verification code that you see on the page. Be aware that the code is not case-sensitive.

   7. If you entered the data correctly, you receive the following message:

      > You are now verified for the rest of this browser session (30 minute maximum)

   8. In the lower-right corner of the page, select **Perform Test**.

5. A **Connectivity Test Successful** message is displayed when the Autodiscover test passes. You may see errors. However, this is expected behavior because not every test that the Remote Connectivity Analyzer performs will succeed.

6. In the upper-right area of the page, select **Expand All** to view the complete Remote Connectivity Analyzer test results.

### Examine the Remote Connectivity Analyzer test results

To confirm that you're experiencing this issue, examine the test results. Search the text in the test results for the text string **IMAP**. Typically, **IMAP** doesn't appear in the test results unless Autodiscover requests are responded to by a third-party web server.

To search for **IMAP** in the test results, follow these steps:

1. Rest the pointer in the Remote Connectivity Analyzer test results page, and then press Ctrl+F.
2. In the **Find** dialog box, enter IMAP.
3. If **\<Type>IMAP\</Type>** is present in the test results, you've confirmed that you're likely experiencing this issue unless you actually set up the mailbox for IMAP access.

   Additionally, near the end of the Remote Connectivity Analyzer test, you'll likely see a reference to Apache, UNIX, or Linux.  

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? [Microsoft Community](https://go.microsoft.com/fwlink/?linkid=2003907) website.
