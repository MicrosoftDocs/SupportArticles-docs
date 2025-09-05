---
title: Test And Enable Failed Because No User Was Found Error
description: Explains how to resolve Test and Enable failures in Dataverse caused by unrecognized Microsoft 365 email addresses.
ms.date: 09/05/2025
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronization
author: debrau
ms.author: debrau
ms.reviewer: debrau
---
# "Test and Enable failed because no user was found" error when configuring mailbox synchronization

This article explains how to resolve the "Test and Enable failed because no user was found" error that occurs when you configure mailbox synchronization in Dataverse with Microsoft 365.

## Symptoms

When you attempt to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dataverse, you might receive the following error message:

> Test and Enable failed because no user was found with the email address "`<user@domain.com>`" in the Microsoft 365 tenant associated with this mailbox's Email Server Profile. Verify the user exists in [...]

## Cause

This error occurs if:

- The specified email address doesn't exist in the Microsoft 365 tenant linked to the mailbox's email server profile.
- The email address isn't properly configured as a User Principal Name (UPN), SMTP address, or mail address on the user object.
- The mailbox belongs to a different Microsoft 365 tenant, and a cross-tenant email server profile isn't configured.

## Resolution

An administrator should verify that the user exists in the correct Microsoft 365 tenant and that the email address is properly configured.

To confirm the UPN, SMTP, or mail address for the user:

1. Sign in to the Microsoft 365 Admin Center.

2. Navigate to **Users** > **Active Users**.

3. Search for the user using the email address in question.

4. Open the user profile and confirm the user has at least one email address matching the email address in the Dataverse mailbox record:

    - **User Principal Name (UPN)** or username matches the email address.
    - Under the **Mail** tab, select **Edit Exchange properties**. In **Manage mailboxes**, open the mailbox. On the **General** tab, confirm the **User ID** or **Email addresses** fields contain the email address.

   > [!NOTE]
   > If a matching address is found in the **Email addresses**, select **Manage email address types** to confirm the address type is **SMTP**.

If the user exists in the same tenant as your Dataverse instance but doesn't have a matching UPN, SMTP, or mail address, update the Dataverse mailbox record to use a valid email address for the user.

If the user doesn't exist in the same tenant as your Dataverse instance, you should [configure a cross-tenant email server profile](/power-platform/admin/connect-exchange-online-server-profile-oauth).
