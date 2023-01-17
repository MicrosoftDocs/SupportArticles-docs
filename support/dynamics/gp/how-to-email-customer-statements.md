---
title: Email Receivables Management customer statements
description: Introduces the options for sending customer statements in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 06/22/2022
---
# How to email Receivables Management customer statements in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4100822

There are two ways to send customer statements in current versions of Microsoft Dynamics GP:

## Option 1 - Word Templates (using the new Word Template functionality)

### General questions and answers

Q1: Which Microsoft Dynamics GP versions does this apply to?

A1: Microsoft Dynamics GP 2013 RTM (recommend R2) and later versions.

Q2: Is Adobe PDF Writer required?

A2: No.

Q3: Can I edit the Subject line of the email message?

A3: Yes (in the E-mail Message Setup).

Q4: Can I edit the body of the email message?

A4: Yes (in the E-mail Message Setup).

Q5: How do I set this up?

A5: Setup documents are outlined in the [GP2013_Finanicals.zip](https://mbs2.microsoft.com/fileexchange/?fileID=cdf1a9bd-bfe1-4223-8b8c-be4e2dc41817) file under Receivables. Additional enhancements are outlined in [Microsoft Dynamics GP 2013 R2 - Email Document New Features](https://community.dynamics.com/gp/b/dynamicsgp/posts/draft-microsoft-dynamics-gp-2013-r2-email-document-new-features).

## Option 2 - Microsoft Dynamics GP functionality (using original Dynamics GP functionality)

You can email customer statements as HTML, PDF, XPS and DOCX in Microsoft Dynamics GP. However, Adobe PDF Writer is required to be able to send the statement in PDF format using the Microsoft Dynamics GP way.

### General questions and answers

Q1: Which Dynamics GP versions does this apply to?

A1: All GP versions (past and current).

Q2: Is Adobe PDF Writer required?

A2: Yes, if you want to send in PDF format. No, if you want to send in TXT format.

Q3: Can I edit the Subject line of the email message?

A3: Yes (in **E-mail Options** tab in the **Print Receivables Statements** window).

Q4: Can I edit the body of the email message?

A4: No.

Q5: How do I set up this email functionality?

A5: For the setup steps, see [Use e-mail messages to send letters, statements, and invoices to customers in Microsoft Dynamics GP](/troubleshoot/dynamics/gp/use-e-mail-messages-send-letters-statements).
