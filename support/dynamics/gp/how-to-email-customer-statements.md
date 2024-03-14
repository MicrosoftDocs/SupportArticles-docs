---
title: Email Receivables Management customer statements
description: Introduces the options for sending customer statements in Microsoft Dynamics GP.
ms.reviewer: theley 
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# How to email Receivables Management customer statements in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4100822

There are two ways to send customer statements in current versions of Microsoft Dynamics GP:

## Option 1 - Use the [Word Template functionality](/dynamics-gp/installation/word-templates)

#### General questions and answers

- Q1: Which Microsoft Dynamics GP versions does this functionality apply to?

  A1: Microsoft Dynamics GP 2015 or a later version.

- Q2: Is Adobe PDF Writer required?  

  A2: No.

- Q3: Can I edit the Subject line of the email message? 

  A3: Yes, you can edit it in the E-mail Message Setup.

- Q4: Can I edit the body of the email message? 

  A4: Yes, you can edit it in the E-mail Message Setup.

- Q5: How do I set up?

  A5: The setup documents are outlined in the [GP2013_Finanicals.zip](https://mbs2.microsoft.com/fileexchange/?fileID=cdf1a9bd-bfe1-4223-8b8c-be4e2dc41817) file under Receivables. Additional enhancements are outlined in [Microsoft Dynamics GP 2013 R2 - Email Document New Features](https://community.dynamics.com/blogs/post/?postid=f3603488-0ed1-4e86-8722-332f9199361c).

## Option 2 - Use the original Microsoft Dynamics GP functionality

> [!IMPORTANT]
> This option doesn't work with the [Multi-factor Authentication (MFA) required for Dynamics GP email](/dynamics-gp/installation/email-troubleshooting-guide#mfa---multi-factor-authentication-modern-authentication).

You can send customer statements in HTML, PDF, XPS, and DOCX formats in Microsoft Dynamics GP. However, Adobe PDF Writer is required to send the statement in PDF format using the Microsoft Dynamics GP method.

#### General questions and answers

- Q1: Is Adobe PDF Writer required?  

  A1: Yes, if you want to send customer statements in PDF format. No, if you want to send customer statements in TXT format.

- Q2: Can I edit the Subject line of the email message?

  A2: Yes. You can edit it in the **E-mail Options** tab of the **Print Receivables Statements** window.

- Q3: Can I edit the body of the email message?

  A3: No.

- Q4: How do I set up this email functionality?

  A4: For the setup steps, see [Use e-mail messages to send letters, statements, and invoices to customers in Microsoft Dynamics GP](use-e-mail-messages-send-letters-statements.md).
