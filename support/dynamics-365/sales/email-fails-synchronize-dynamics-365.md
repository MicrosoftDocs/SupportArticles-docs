---
title: Email fails to synchronize to Dynamics 365
description: Provides a solution to an issue where email fails to synchronize to Microsoft Dynamics 365 when encoded with PEC.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Email fails to synchronize to Microsoft Dynamics 365 when encoded with PEC

This article provides a solution to an issue where email fails to synchronize to Microsoft Dynamics 365 when encoded with PEC.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4490718

## Introduction

What are PEC emails?

PEC emails are certified emails that are used in some countries and they have the same legal validity as registered emails (s/mime).

[S/MIME](/microsoft-365/security/office-365-security/s-mime-for-message-signing-and-encryption) (Secure/Multipurpose Internet Mail Extensions) is a widely accepted method, or more precisely a protocol, for sending digitally signed and encrypted messages.

S/MIME allows you to encrypt emails and digitally sign them.

## Symptoms

PEC Emails aren't getting synchronized with Server-Side Synchronization or Email Router.

## Cause

Server-Side Synchronization and Email Router use Exchange Web Services to connect to an Exchange Server.

PEC and RFC6109 don't use APIs via REST or SOAP, as such Server-Side Synchronization and Email Router won't be able to Synchronize these emails properly.

## Resolution

When an email is encrypted, it creates a token that is sent to the recipient of that email.

This one-to-one relationship makes it possible for a user to send an email to another user and be encrypted.

What happens when an encrypted email is sent:

As Dynamics is a third-party application, when it tries to access the email, it will only get this email in an encrypted state.

As the token won't exist in Dynamics 365, the email won't be decrypted.

- A unique cipher encrypts an email message.
- The email is encoded into ciphertext.
- Email is sent and received.
- Receiver enters a cipher key to decode the message.

PEC and RFC6109 don't use APIs via REST or SOAP, as such Server-Side Synchronization and Email Router doesn't Support this email type for synchronization.

To have this email synchronized with your Dynamics 365 Organization, you'll have to remove the encryption from the email, which can be achieved by forwarding the email.
