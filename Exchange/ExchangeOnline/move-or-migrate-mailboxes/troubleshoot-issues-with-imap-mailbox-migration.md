---
title: Troubleshoot issues with IMAP mailbox migration
description: Troubleshoots issues with migrating a mailbox from an on-premises or third-party IMAP system to Exchange Online.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
---
# Troubleshooting issues with IMAP mailbox migration

_Original KB number:_ &nbsp; 10062

**Who is it for?**

Tenant admins who help resolve migration issues for their users.

**How does it work?**

We'll begin by asking you the issue that you are facing. Then we'll take you through a series of steps that are specific to your situation.

**Estimated time of completion:**

30-45 minutes.

## Welcome to the IMAP migration troubleshooter

If you are having issues determining what the best Migration approach is for your environment, see [Exchange Deployment Assistant](/exchange/exchange-deployment-assistant?preserve-view=true&view=exchserver-2019).

> [!NOTE]
> This troubleshooter will not help you with troubleshooting Staged, Cutover, or Hybrid migrations.

**What do you want to do?**

- [I am looking for information on how to perform an IMAP migration](#i-am-looking-for-information-on-how-to-perform-an-imap-migration).
- [Help me troubleshoot my IMAP migration issue](#which-type-of-issue-are-you-having-with-your-imap-migration)

### Which type of issue are you having with your IMAP migration

If you are having trouble starting the IMAP migration batch, or you are running into problems after starting it, then choose the first option below.

If your migration is taking longer than expected, choose the second option.

- [I am having problems with the IMAP Migration batch](#were-you-able-to-createstart-the-imap-migration-batch)
- [My migration is slow](#my-migration-is-slow-if-migration-is-taking-longer-than-expected))

### Were you able to create/start the IMAP migration batch

If you are not sure where to create a batch or you are not sure if you have an existing batch, sign in to the Exchange Admin Center (EAC) using your Microsoft 365 tenant administrator credentials and navigate to **Recipients** > **Migration**.

If you are needing to create a new IMAP migration batch, you can select the + to get started. For more information, see [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes) on how to create an IMAP migration batch.

If you have an existing batch, and it's not started, you can highlight the batch and then select the play :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/play-button.png" border="false"::: button.

:::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/start-an-existing-batch.png" alt-text="Screenshot of starting an existing batch.":::

Select **yes** on the pop-up box to start it.

:::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/warning.png" alt-text="Screenshot of the warning text for migration batch.":::

**Were you able to successfully create and/or start the batch?**

- If yes, see [What issue are you seeing after creating/starting the migration batch](#what-issue-are-you-seeing-after-creatingstarting-the-migration-batch).
- If no, see [No, I was not able to create/start my migration batch](#no-i-was-not-able-to-createstart-my-migration-batch).

### What issue are you seeing after creating/starting the migration batch

Since you were able to create/start the migration batch, you may run into one of the below error messages. To see what errors you are running into, you can download the error report by logging into the account that you started the migration batch with. Look for an email with a subject of **E-mail migration batch "Batch name" has finished - with errors**. You can download the error report by selecting **Click here to download the error report**.

- [A recipient wasn't found for user@contoso.com on the target...](#a-recipient-wasnt-found)
- [We had trouble signing in to this account...](#we-had-trouble-signing-in-to-this-account-error)
- [I'm seeing duplicate emails](#im-seeing-duplicate-emails)
- [This mailbox is full...](#this-mailbox-is-full)
- [My problem is none of the above](#my-problem-is-none-of-the-above-errors)

### <a id="a-recipient-wasnt-found"></a> A recipient wasn't found for user@contoso.com on the target

If you run into the below error, create a mailbox in Microsoft 365 with the specified proxy address and retry creating/starting the batch. To create a new mailbox in Microsoft 365, follow the steps in [Create user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/create-user-mailboxes).

A recipient wasn't found for `user@contoso.com` on the target. Create a recipient of the appropriate type for this migration on the target and try again.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [A recipient wasn't found for user@contoso.com on the target](#a-recipient-wasnt-found-if-issue-isnt-resolved)

### <a id="a-recipient-wasnt-found-if-issue-isnt-resolved"></a>A recipient wasn't found for user@contoso.com on the target (if issue isn't resolved)

In the CSV file, you are using for the IMAP migration, verify that the value in the EmailAddress column is correctly entered. It should be one of the proxy addresses on the cloud mailbox that you are trying to migrate the data to.

> [!NOTE]
> You will also get this error if you add DL/DG/non-mailbox accounts to the CSV file.

Here's an example of the format for the CSV file.

> EmailAddress,UserName,Password  
> user@contoso.com,contoso/terry.adams,1091990

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### We had trouble signing in to this account error

You will run into the below error if you enter the username and/or password incorrectly in the CSV file. Make sure that the username and password in the CSV file are correct.

We had trouble signing in to this account. Confirm that you're using the correct user name and password.

In the CSV file, you have to provide the username and password for the user's on-premises/hosted account. This enables the migration process to access the account. There are two ways to do this:

> [!NOTE]
> The below examples are for migrating mailboxes from an Exchange system. See [CSV files for IMAP migration batches](/previous-versions/exchange-server/exchange-150/jj200730(v=exchg.150)) for additional examples on the formatting of the CSV files for third party systems as they may be different. Ensure that the proper format is used. Also, you cannot use super-user/administrator credentials when migrating from certain third party IMAP systems.

**Option 1:** Use end-user credentials - This requires that you obtain users' passwords or that you change their passwords to a value that you know so you can include it in the CSV file.

**Example:**

EmailAddress,UserName,Password  
`usera@contoso.com,contoso/usera,P@ssw0rd1`  
`userb@contoso.com,contoso/userb,P@ssw0rd2`

**Option 2:** Use super-user or administrator credentials - This requires that you use an account in your IMAP messaging system that has the necessary rights to access all user mailboxes. In the CSV file, you use the credentials for this account for each row.

**Example:**

EmailAddress,UserName,Password  
`usera@contoso.com,contoso/mailadmin/usera,P@ssw0rd`  
`userb@contoso.com,contoso/mailadmin/userb,P@ssw0rd`

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [We had trouble signing in to this account](#we-had-trouble-signing-in-to-this-account-if-issue-not-resolved).

### We had trouble signing in to this account (if issue not resolved)

Make sure that the on-premises/hosted mailbox exists. If you have on-premises Exchange, then you can go to the appropriate location depending on the Exchange version you have.

> [!NOTE]
> The below paths are examples. The exact path to locate the mailbox may differ slightly based on your configuration.

- Exchange 2003: Open **System Manager** and go to **Administrative Groups** > **First Administrative Group** > **Servers** > **Server Name** > **First Storage Group** > **Mailbox Store (ServerName)** > **Mailboxes**.

- Exchange 2007: Open **Exchange Management Console (EMC)** and go to **Microsoft Exchange** > **Recipient Configuration** > **Mailbox**.

- Exchange 2010: Open **Exchange Management Console (EMC)** and go to **Microsoft Exchange** > **Microsoft Exchange On-Premises (ServerName)** > **Recipient Configuration** > **Mailbox**.

- Exchange 2013: Go to **Exchange Admin Center** (For example: `https://onpremises-servername/ecp`) and enter the admin credentials, and then go to **Recipients** > **Mailboxes**.

If the mailbox is hosted on a third-party system (For example: Gmail, Lotus Notes), review their documentation to locate the mailbox.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [We had trouble signing in to this account](#we-had-trouble-signing-in-to-this-account-if-issue-still-not-resolved).

### We had trouble signing in to this account (if issue still not resolved)

You will need to ensure that IMAP access is enabled for the users you are trying to migrate.

If you are using Google Apps, you will need to makes sure that IMAP access is enabled for your organization. See the **Turn POP and IMAP access on and off** section of [Turn POP and IMAP on and off for users](https://support.google.com/a/answer/105694). If IMAP is enabled for your organization through the [Google Admin console](https://admin.google.com/), you may need to check each individual user's IMAP settings to make sure that it is enabled locally. For more information, see [Check Gmail through other email platforms](https://support.google.com/mail/answer/7126229?visit_id=637339435695975585-1540877283&rd=1).

If you are migrating users from a personal Gmail.com account, make sure that IMAP access is enabled on each user's mailbox. For more information, see [Check Gmail through other email platforms](https://support.google.com/mail/answer/7126229?visit_id=637339435695975585-1540877283&rd=1).

> [!NOTE]
> If your source environment is not Gmail/Google Apps, refer to their documentation for how to verify if IMAP is properly enabled for the organization and/or user.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [We had trouble signing in to this account](#we-had-trouble-signing-in-to-this-account-if-issue-is-still-not-resolved).

### We had trouble signing in to this account (if issue is still not resolved)

If you use super-user credentials in the CSV file, the account that you use must have the necessary permissions to access the on-premises/hosted mailboxes. The permissions required to access user mailboxes will be determined by the particular IMAP server. The following list shows the administrative privileges required to migrate Exchange mailbox data using an IMAP migration. There are three options:

- The administrator account must be assigned the **Full Access** permission for each user mailbox on the Exchange server.

Or

- The administrator account must be assigned the **Receive As** permission on the Exchange mailbox database that stores the user mailboxes.

Or

- The administrator account must be a member of the **Domain Admins** group in Active Directory in the on-premises Exchange organization.

For more information about assigning Exchange permissions, see [Assign permissions to migrate mailboxes to Exchange Online](/previous-versions/exchange-server/exchange-150/jj898489(v=exchg.150)).

> [!NOTE]
> If you are using a third party system, see their documentation for more information.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### I'm seeing duplicate emails

If you are migrating from Gmail/Google Apps, email duplication is known to occur when [labels](https://support.google.com/mail/answer/118708?hl=en) are used in the Gmail/Google Apps mailbox and/or when a folder called **[Gmail]** is not added to the list of excluded folders when the migration batch is created (see screenshot below). This will cause the Microsoft 365 mailbox to double, or more, in size and may prevent the user's mailbox from completely migrating. Users that have already been migrated will need to manually clean up the duplication in their Microsoft 365 mailboxes.

If you have additional mailboxes that you have not yet migrated, you can use the below steps to avoid email duplication:

1. When creating the IMAP migration batch, make sure to exclude the **[Gmail]** folder as shown below. See [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes) for how to create an IMAP migration batch.

   :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/creat-new-imap-migration-batch.png" alt-text="Screenshot of creating an IMAP migration batch.":::

2. Remove the labels from all emails in the source mailbox.

    1. Log in to your Gmail/Google Apps account and filter for the emails that have labels.
    2. Select all emails with labels.
    3. Select  the **Labels** icon.  
    4. Select the boxes next to each label until the boxes for all labels have been cleared.
    5. Select **Apply**.  

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### This mailbox is full

You will run into the below error if you have exceeded the storage limit for the Microsoft 365 mailbox.

> This mailbox is full. Please free up some space so that email can be downloaded.

If you are migrating from Gmail/Google Apps, email duplication is known to occur when [labels](https://support.google.com/mail/answer/118708?hl=en) are used in the Gmail/Google Apps mailbox and/or when a folder called **[Gmail]** is not added to the list of excluded folders when the IMAP migration batch is created. Below are the steps for how to take care of the issue for existing users (that is, users that are currently being migrated in a batch) as well as to prevent duplication in future migrations:

#### Existing users

1. Remove the existing batch.

    1. First you will need to log into the Exchange Admin Center (EAC) using your Microsoft 365 tenant administrator credentials.

    2. Navigate to **Recipients** > **Migration**.

    3. Highlight the migration batch and select the stop button.

       > [!NOTE]
       > A warning box will pop up asking you if you want to stop the batch. Select **yes** and wait until the status of the batch says **Stopped**.

    4. Select **Delete** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/delete-icon.png" border="false":::.

        > [!NOTE]
        > A warning box will pop up asking you if you want to delete the batch. Select **yes**.

2. Remove the labels from all emails in the Gmail/Google Apps mailbox(es).

    1. Log into the Gmail/Google Apps mailbox.
    2. Select all emails with labels.
    3. Select the **Labels** icon.
    4. Select the boxes next to each label until the boxes for all labels have been cleared.
    5. Select **Apply**.
    6. Repeat the previous five steps for each additional mailbox.

3. Make room in your Microsoft 365 mailbox by deleting the duplicate emails and the **[Gmail]** folder. To complete the removal of the duplicate emails and the **[Gmail]** folder, clear them from your Deleted Items folder.

4. Recreate the batch, making sure to exclude the **[Gmail]** folder as shown below:

   :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/creat-new-imap-migration-batch.png" alt-text="Screenshot of recreating a new batch.":::

> [!NOTE]
> See [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes) for steps on how to create an IMAP migration batch.

#### Future migrations

1. Remove the labels from all emails in the Gmail/Google Apps mailbox (see the **Existing users** section above for specific details).

1. When creating the IMAP migration batch, make sure to exclude the **[Gmail]** folder as shown in the above screenshot.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### My problem is none of the above errors

Some problems can be fixed by removing and recreating the batch. Below are steps on how to do so. First you will need to log into the Exchange Admin Center (EAC)) using your Microsoft 365 tenant administrator credentials.

**Remove existing batch:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Highlight the migration batch and select the stop button.
   > [!NOTE]
   > A warning box will pop up asking you if you want to stop the batch. Select **yes** and wait until the status of the batch says **Stopped**.
3. Select **Delete** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/delete-icon.png" border="false":::.

   > [!NOTE]
   > A warning box will pop up asking you if you want to delete the batch. Select **yes**.

**Recreate batch:**

For information on how to create an IMAP migration batch, see [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes).

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My problem is none of the above](#my-problem-is-none-of-the-above-if-issue-not-resolved).

### My problem is none of the above (if issue not resolved)

Be aware of the following restrictions that apply to IMAP migrations:

- Only items in a user's inbox or other mail folders can be migrated. You can't migrate contacts, calendar items, or tasks.
- A maximum of 500,000 items can be migrated from a user's mailbox.
- The maximum message size that can be migrated is 35 MB.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My problem is none of the above](#my-problem-is-none-of-the-above-if-issue-isnt-resolved).

### My problem is none of the above (if issue isn't resolved)

Sometimes the connection settings in an existing IMAP migration endpoint can change and you will need to remove and recreate the endpoint. Below are steps on how to do so. First you will need to log into the Exchange Admin Center (EAC) using your Microsoft 365 tenant administrator credentials. Follow the below steps to remove and recreate the endpoint.

**Remove existing endpoint:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Select **More...** and then select **Migration** **endpoints**.
3. Highlight the existing migration endpoint and select **Delete** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/delete-icon.png" border="false":::.

   > [!NOTE]
   > If you have more than one IMAP migration endpoint, delete the appropriate one.

4. Select the **yes** button in the warning page asking you if you want to delete the endpoint.

**Recreate endpoint:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Select **More...** and then select **Migration endpoints**.
3. On the **Migration endpoints** page, select **New** **+**.
4. On the **Select the migration endpoint type** page, select **IMAP**, and then select **Next**.
5. On the **IMAP migration configuration page**, enter the connection settings for the server you want to migrate email from, including the FQDN of your IMAP server (for example, `imap.contoso.com`) and select **Next**.
6. On the **Enter general information** page, you must type in the name for the Migration endpoint. Optionally, you can enter values for the maximum number of concurrent migrations and incremental syncs and select **new**. The default values for the optional fields are 20 and 10 respectively.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My problem is none of the above](#my-problem-is-none-of-the-above-if-issue-is-still-not-resolved).

### My problem is none of the above (if issue is still not resolved)

There potentially may be a problem with the account that is being used to create/perform the IMAP migrations in the EAC. Often using a different account to perform the migrations will resolve the issue. You can use an existing account, other than the one you are using now, or create a new account and add the account to either the Organization Management or the Recipient Management role group.

Below are the steps on how to add the account to the appropriate role group so that you can rerun the migration batch with this account:

1. Sign in to the [Exchange Administration Center](https://outlook.office365.com/ecp/) (EAC) with the Microsoft 365 tenant administrator credentials.
2. In the EAC, navigate to **Permissions** > **Admin Roles**.
3. Select the role group you want to add members to, and then select **Edit** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/edit-icon.png" border="false":::.
4. In the Members section, select **Add** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/add-icon.png" border="false":::.
5. Select the user you want to add to the role group, select **Add**, and then select **OK**.
6. Select **Save** to save the changes to the role group.

For more information, see [Manage role group members](/exchange/manage-role-group-members-exchange-2013-help) on how to manage role group members.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My problem is none of the above](#my-problem-is-none-of-the-above).

### My problem is none of the above

If you are using a super-user account, in the CSV file, to migrate the users' mailboxes, there may be a problem with the account or its permissions. The account that you use must have the necessary permissions to access the on-premises mailboxes. The permissions required to access user mailboxes will be determined by the particular IMAP server. The following list shows the administrative privileges required to migrate Exchange mailbox data using an IMAP migration. There are three options:

- The administrator account must be assigned the **FullAccess** permission for each user mailbox on the Exchange server.

  Or

- The administrator account must be assigned the **Receive As** permission on the Exchange mailbox database that stores the user mailboxes.

  Or

- The administrator account must be a member of the **Domain Admins** group in Active Directory in the on-premises Exchange organization.

For more information about assigning Exchange permissions, see [Assign permissions to migrate mailboxes to Exchange Online](/previous-versions/exchange-server/exchange-150/jj898489(v=exchg.150)).

> [!NOTE]
> If you are using a third party system, see their documentation for more information.

If you have confirmed that the super user account has the correct permissions, try creating a new super user account, give it the necessary permissions, and retry the migration.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### No, I was not able to create/start my migration batch

Below are some of the possible errors you can run into while attempting to create/start an IMAP migration batch. If an error pops up when you select the CSV file, during the batch creation, then go to the CSV errors section for troubleshooting assistance. Otherwise select the appropriate option.

- [The connection to the server Servername.contoso.com timed out...](#the-connection-to-the-server-servernamecontosocom-timed-out)
- [Connection to the server couldn't be completed](#the-connection-to-the-server-could-not-be-completed)
- [CSV errors](#csv-errors)
- [Batch \<name> already exists](#the-migration-batch-batch-name-already-exists)

### The connection to the server <Servername.contoso.com> timed out

You will run into the below error if your firewall does not allow for IMAP connections from the Microsoft datacenters to your IMAP server.

> The connection to the server `Servername.contoso.com` timed out after 00:00:15.

To see if this applies to you, you can use a tool such as Telnet to verify whether you are able to reach the appropriate port (993 or 143) on the IMAP server/service. Below are the steps on how to install the Telnet tool and use it to verify if you are able to connect to the port.

1. Install the Telnet client by following the steps in [Install Telnet Client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771275(v=ws.10)).

2. Open a command prompt (**Start** > **Run** > *Cmd*).
3. Type the following command:

    ```console
    telnet server.contoso.com <port #>
    ```

    where,<port#> will either be 993 (SSL) or 143. If you see a blank command prompt box, then you were able to successfully connect to the port on the IMAP server/service.

However, if you get the below error, when trying to perform the telnet test, you will need to publish the appropriate port (993 or 143) through your on-premises firewall or the provider that hosts the IMAP service you are migrating from. For a list of IP addresses used by Microsoft datacenters, see [Exchange Online URLs and IP Address Ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?preserve-view=true&view=o365-worldwide).

> C:\>telnet `server.contoso.com` 993
>
> Connecting To `server.contoso.com`...Could not open connection to the host, on port 993: Connect failed

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [Connection to the server Servername.contoso.com timed out...](#connection-to-the-server-servernamecontosocom-timed-out).

### Connection to the server <Servername.contoso.com> timed out

This error can also occur if the IMAP service is not running. Make sure the IMAP server/service is started in the source environment (Ex: Exchange Server, Lotus Notes, Google Apps).

If you are migrating from an Exchange server, launch the Services application (**Start** > type *Services.msc* in the search box and select **enter**). Make sure the **Microsoft Exchange IMAP4** service is started.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [The connection to the server Servername.contoso.com timed out](#the-connection-to-the-server-servernamecontosocom-timed-out-if-issue-not-resolved).

### The connection to the server Servername.contoso.com timed out (if issue not resolved)

If you are using an existing IMAP migration endpoint, remove and recreate the endpoint, and then try to create the IMAP migration batch. Follow the steps below to remove the existing endpoint and recreate it with the appropriate settings. First you will need to log into the [EAC](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials.

**Remove existing endpoint:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Select **More...** and then select **Migration** **endpoints**.
3. Highlight the existing IMAP migration endpoint and select **Delete** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/delete-icon.png" border="false":::.
   > [!NOTE]
   > If you have more than one endpoint, delete the appropriate one.
4. Select the **yes** button in the warning page asking you if you want to delete the endpoint.

**Recreate endpoint:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Select **More...** and then select **Migration** **endpoints**.
3. On the **Migration endpoints** page, select **New** **+**.
4. On the **Select the migration endpoint type page**, select **IMAP**, and then select **Next**.
5. On the **IMAP migration configuration page**, enter the connection settings for the server you want to migrate email from, including the FQDN of your IMAP server (for example, `imap.contoso.com`) and select **Next**.
6. On the **Enter general information** page, you must type in the name for the Migration endpoint. Optionally, you can enter values for the maximum number of concurrent migrations and incremental syncs and select **new**. The default values for the optional fields are 20 and 10 respectively.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### The connection to the server could not be completed

You will encounter the below error when you are specifying the IMAP server's FQDN while creating either the IMAP migration endpoint, creating a batch when there are no existing IMAP endpoints, or you have an existing IMAP endpoint where the FQDN no longer resolves in DNS. Verify the IMAP server FQDN is correct and can be resolved publicly in DNS.

The connection to the server `imap.contoso.com` could not be completed.

If you are creating the IMAP migration batch, and you have no existing IMAP endpoints, follow the below steps to specify the appropriate public FQDN.

1. Log into the [EAC](https://outlook.office365.com/ecp/) using the account you are performing the migration with.
2. Go to **recipients** > **migration**.
3. Select the **+** and choose **Migrate to Exchange Online**.
4. Select **IMAP migration** and select **next**.
5. Select **Choose file**, select the CSV file for the migration, and select **next**.
6. Enter the publicly resolvable FQDN of the IMAP server as shown below and continue with creating the migration batch.

   :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/enter-fqdn-of-imap-server.png" alt-text="A screenshot of entering F Q D N of the I M A P server.":::

If you are creating an IMAP migration endpoint, follow the below steps to specify the appropriate public FQDN:

1. Log into the EAC using the account you are performing the migration with.
2. Go to **recipients** > **migration**.
3. Select the **...** and select **Migration** **endpoints**.
4. Select **+** to create a new migration endpoint.
5. Select **IMAP** and select **next**.
6. Enter the publicly resolvable FQDN of the IMAP server as shown below and continue with creating the migration endpoint.

   :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/enter-fqdn-of-imap-server-2.png" alt-text="Another screenshot of entering F Q D N of the I M A P server.":::

If you are creating the IMAP migration batch, and have an existing IMAP endpoint, follow the below steps to determine what the public FQDN of the IMAP server is:

1. Log into the EAC using the account you are performing the migration with.
2. Go to **recipients** > **migration**.
3. Select the ... and select **Migration** **endpoints**.
4. Select on the appropriate IMAP migration endpoint.
5. You will see the FQDN of the IMAP server. If it is incorrect, or no longer publicly resolvable, you will need to either remove and recreate the IMAP migration endpoint with an FQDN that is publicly resolvable or you will need to create a host (A) record that resolves the FQDN of your existing IMAP migration endpoint to the public IP of the IMAP server.

    :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/find-fqdn-of-imap-server.png" alt-text="Screenshot that shows F Q D N of the I M A P server.":::

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### CSV errors

During the creation of the IMAP migration batch, while browsing for the CSV file, you may run into one of several errors.

Select the appropriate option below for possible solutions.

- [Upload file can't be empty](#upload-file-cant-be-empty)
- [The CSV file contains more than 50,000 rows](#the-csv-file-contains-more-than-50000-rows)
- [Column \<Column name> is missing from the CSV file](#column-is-missing-from-the-csv-file)
- [Row X has the wrong number of columns](#row-x-has-the-wrong-number-of-columns)

### Upload file can't be empty

You will see the below error if your CSV file is completely blank:

> Upload file can't be empty

Make sure you have the appropriate information in the CSV file and resubmit the file. See [CSV files for IMAP migration batches](/previous-versions/exchange-server/exchange-150/jj200730(v=exchg.150)) for information on how to create a CSV file for an IMAP migration batch.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### The CSV file contains more than 50,000 rows

You will see the below error if you have more than 50,000 rows of user data in the CSV file:

> The CSV file contains more than 50,000 rows. Please divide the file into two or more files and submit them separately.

The CSV file can contain up to 50,000 rows, one row for each user, and can be as large as 10 MB. But it's a good idea to migrate users in several smaller batches.

If you plan to migrate lots of users, decide which ones to include in each batch. For example, if you have 10,000 accounts to migrate, you could run four batches with 2,500 users each. You could also divide the batches alphabetically; by user type, such as faculty, students, and alumni; by class, such as freshman, sophomore, junior, and senior; or in other ways that meet your organization's needs.

> [!NOTE]
> One strategy is to create Exchange Online mailboxes and migrate email for the same group of users. For example, if you import 100 new users to your Microsoft 365 organization, create a migration batch for those same 100 users. This is an effective way to organize and manage your migration from an on-premises messaging system to Exchange Online.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### Column is missing from the CSV file

You will see the below error if one or more of the required columns (EmailAddress,UserName,Password) are missing from the CSV file:

> Column "Column name" is missing from the CSV file. The import process can't continue because this column is required. Please edit the CSV file and re-submit it.

Make sure that the required columns are located on the first row of the CSV file and resubmit the file. See [this article](/previous-versions/exchange-server/exchange-150/jj200730(v=exchg.150)) for more information on the appropriate format of the CSV file.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### Row X has the wrong number of columns

You will see the below error if one, or more, rows are missing at least one column of user information:

> Row X has the wrong number of columns. Expected number: 3. Actual number: Y. Please edit this row and re-submit the file.

Make sure that each row of user data has the appropriate information for each of the three expected columns (EmailAddress,UserName,Password) and resubmit the file. For information on the appropriate format of the CSV file, see [CSV files for IMAP migration batches](/previous-versions/exchange-server/exchange-150/jj200730(v=exchg.150)).

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### The migration batch \<batch name> already exists

You will run into the below error if a migration batch with the same name already exists:

> The migration batch already exists.

In order to determine if a batch already exists with the same name, log into the EAC (`https://onpremises-servername/ecp`) and go to **recipients** > **migration**. If you want to use the same batch name, you must first remove the existing batch by highlighting it and selecting the icon. If the batch is running, select the stop button and then delete it.

> [!NOTE]
> If you have removed the migration batch, it may take a few minutes for the batch to completely remove. You will either need to wait for the existing migration batch with that name to completely remove or use a new name for the batch you are trying to create.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### My migration is slow (if migration is taking longer than expected)

You can often improve the performance of your IMAP migration by allowing for more simultaneous moves, without negatively impacting the source environment performance. The default number of simultaneous moves is 20. This value is located on the migration endpoint. Below are the steps on how to change it:

1. Log into the [Exchange Admin Center](https://outlook.office365.com/ecp/) (EAC) using your Microsoft 365 tenant administrator credentials.
2. In the EAC, navigate to **Recipients** > **Migration**.
3. Select **...** and then select **Migration endpoints**.
4. Double-click on the IMAP migration endpoint.
5. In the **Maximum concurrent migrations** box put in a value greater than 20 (maximum allowed value is 100) and select **save**.

If the migration batch is already started, you will need to stop it, make the above change and restart it.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My migration is slow](#my-migration-is-slow-if-issue-not-resolved).

### My migration is slow (if issue not resolved)

We recommend that you have your users clean up their mailboxes before migration as this will help speed up the migration process. Also, as a tenant administrator, you may want to exclude certain folders such as Deleted Items, and shared or public folders. See the below steps on how to exclude folders:

1. Log into the [Exchange Admin Center](https://outlook.office365.com/ecp/) (EAC) using your Microsoft 365 tenant administrator credentials.
2. Go to **recipient** > **migration**.
3. Select **+** and choose **Migrate to Exchange Online**.
4. Select **IMAP** **migration** and select **next**.
5. Select **choose** **file**, select the csv file, and select **next**.
6. If you have a migration endpoint, select a migration endpoint and select **next**.
7. On the screen that shows the IMAP endpoint configuration, select **next**.
8. Under Exclude Folder, in the box next to the **+**, type in the name of the folder(s) that you want to exclude, one at a time, and select **+** and add each folder to the list of folders you want to exclude. Once you've added all the folders, select **next** and complete the creation of the IMAP migration batch.

If you're migrating email from an on-premises Microsoft Exchange server, we recommend that you exclude public folders from the migration. If you don't exclude public folders, the contents of the public folders are copied to the Exchange Online mailbox of every user in the CSV file.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My migration is slow](#my-migration-is-slow-if-issue-isnt-resolved).

### My migration is slow (if issue isn't resolved)

Migration batches are not handled at the same priority as other core functions (Ex: client connectivity and mail flow tasks). Therefore if your server or the Microsoft datacenter is under heavy load, the migration of the source mailbox data may be delayed. It will more than likely continue relatively soon. It is best to not start troubleshooting a stalled migration until there had been a long enough delay (such as 8 hours) with no progress or activity. Often migrating data during non-peak hours such as nights and weekends yield better performance.

In order to determine if a particular user migration is not progressing, or is progressing slowly, you can look at the **E-mail Migration Per-User Status Report**. To access the report,go to the [Exchange Admin Center](https://outlook.office365.com/ecp/) (EAC) > **recipients** > **migration** > highlight the IMAP migration batch > select **View** **details**. For each user, make sure that the value under the **Status** column says **Syncing**. If it is, then look at the value under the **Items** **Synced** column. After a couple of hours, refresh the report to see if the number under the Items Synced column has changed.

> [!NOTE]
> If you control the system that you are migrating from, see [Microsoft 365 and Office 365 email migration performance and best practices](/Exchange/mailbox-migration/office-365-migration-best-practices) to help you determine if the on-premises server is overtaxed.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My migration is slow](#my-migration-is-slow-if-issue-is-still-not-resolved).

### My migration is slow (if issue is still not resolved)

Try increasing the connection limits to your IMAP server. Many firewalls and email servers have per-user limits, per-IP address limits, and overall connection limits. Before you migrate mailboxes, make sure that your firewall and IMAP server/service are configured to allow the optimal number of connections for the following settings:

- The total number of connections to the IMAP server.
- The number of connections by a particular user. This is important if you use a super-user account in the CSV migration file because all connections to the IMAP server are made by this user account.
- The number of connections from a single IP address. This limit is typically enforced by the firewall, intrusion detection system, or an email server such as Exchange.

#### Server settings

If your IMAP server is running Exchange 2010 or Exchange 2007, the default settings for connection limits are low. Be sure to increase these limits before you migrate email. By default, Exchange 2003 doesn't limit the number of connections.

For more information, see:

- Exchange 2010: [View or Configure IMAP4 Properties](/previous-versions/office/exchange-server-2010/bb691401(v=exchg.141))
- Exchange 2007: [How to Set Connection Limits for IMAP4](/previous-versions/office/exchange-server-2007/bb123712(v=exchg.80))
- Exchange 2003: [How to Set Connection Limits](/previous-versions/tn-archive/bb124303(v=exchg.65))

#### IDS settings

Intrusion detection functionality configured on a network firewall often causes significant network delays and affects migration performance.

IMAP Migrations can sometimes be treated like a denial of service attack by certain devices. The following logic can be applied to any intrusion detection system, but it was written for TMG specifically.

1. Open the **Forefront TMG management console**, and then in the tree select **Intrusion Prevention System**.
2. Select the **Behavioral Intrusion Detection** tab, and then select **Configure Flood Mitigation Settings**.
3. In the Flood Mitigation dialog box, follow these steps:

   - Select the **IP Exceptions** tab, and then type the IP addresses that the Microsoft 365 environment uses to connect during the mailbox move operation. To view a list of the IP address ranges and URLs that are used by Exchange Online in Microsoft 365, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?preserve-view=true&view=o365-worldwide).

   - Select the **Flood Mitigation** tab, and then, next to **Maximum TCP Requests per minute per IP address**, select **Edit**. In the **Custom limit** box, type a number to increase the limit.

> [!NOTE]
> The custom limit applies to IP addresses that are listed on the **IP** **Exceptions** tab. Increase only the custom limit. By default the custom limit is set to 6000. Depending on the number of mailboxes that are being moved, this number may not be sufficient. You may try increasing this limit to see if it will help speed up the migration.

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My migration is slow](#my-migration-is-slow-if-issue-is-still-not-solved).

### My migration is slow (if issue is still not solved)

> [!NOTE]
> You can skip this page if you don't control the IMAP system that you are migrating from.

The Microsoft 365 Network Analysis Tool is designed to help analyze networking related issues between an external network and the Microsoft 365 services.

1. Select one of the below appropriate regional URLs.

   North America: `http://na1-fasttrack.cloudapp.net`
   EMEA: `http://em1-fasttrack.cloudapp.net`
   APAC: `http://ap1-fasttrack.cloudapp.net`

2. You may then be prompted to install an ActiveX control. If so, install it.
3. Once you install it, you will get a security warning as shown below. Select **OK**.

   :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/security-warning.png" alt-text="Screenshot of the security warning that is displayed after installation.":::

4. Install [Java](https://www.java.com/download/) and reboot.
5. After the machine reboots, go back to the appropriate regional URL listed above. You will then be prompted to run the application as shown below:

    :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/prompted-waring-to-run-this-application.png" alt-text="Screenshot of a security warning prompted to run the application.":::
6. Once you install the application, you will then enter the Microsoft 365 tenant name in the Microsoft 365 Network Analysis tool as shown below:

    :::image type="content" source="media/troubleshoot-issues-with-imap-mailbox-migration/enter-office-365-tenant-name.png" alt-text="Screenshot of entering the Microsoft 365 tenant name in the Microsoft 365 Network Analysis tool.":::

For more information on IMAP migration performance and best practices, see [Microsoft 365 and Office 365 email migration performance and best practices](/Exchange/mailbox-migration/office-365-migration-best-practices).

If you are migrating from Google apps refer to these articles concerning [bandwidth](https://support.google.com/a/answer/1071518?hl=en) and [sync limits](https://support.google.com/a/answer/2751577?hl=en&ref_topic=6013516).

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete.
- If no, see [My migration is slow](#my-migration-is-slow-if-issue-still-not-solved).

### My migration is slow (if issue still not solved)

Some problems can be fixed by removing and recreating the batch. Below are steps on how to do so.
First you will need to log into the [EAC](https://outlook.office365.com/ecp/) using your Microsoft 365 tenant administrator credentials.

**Remove existing batch:**

1. In the EAC, navigate to **Recipients** > **Migration**.
2. Highlight the migration batch and select the stop button.

   > [!NOTE]
   > A warning box will pop up asking you if you want to stop the batch. Select **yes** and wait until the status of the batch says **Stopped**.
3. Select **Delete** :::image type="icon" source="media/troubleshoot-issues-with-imap-mailbox-migration/delete-icon.png" border="false":::.

   > [!NOTE]
   > A warning box will pop up asking you if you want to delete the batch. Select **yes**.

**Recreate batch:**

For information on how to create a batch, see [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes).

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.

### I am looking for information on how to perform an IMAP migration

Below is some information that may help you in performing an IMAP migration:

General Information

- [What you need to know about migrating your IMAP mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrating-imap-mailboxes)
- [CSV Files for IMAP Migration Batches](/previous-versions/exchange-server/exchange-150/jj200730(v=exchg.150))
- [Create migration endpoint](/exchange/mailbox-migration/migrating-imap-mailboxes/migrate-other-types-of-imap-mailboxes#:~:text=to%20create%20a%20new%20migration,of%20the%20source%20email%20server.)

Google-Specific Information

- [Migrate consumer G Suite mailboxes to Microsoft 365 or Office 365](/Exchange/mailbox-migration/migrating-imap-mailboxes/migrate-g-suite-mailboxes)
- [IMAP Bandwidth limits](https://support.google.com/a/answer/1071518?hl=en)
- [Sync limits](https://support.google.com/a/answer/2751577)

**Did this solve your problem?**

- If yes, congratulations! Your scenario is complete
- If no, sorry, we couldn't resolve your issue with this guide. For more help to resolve this issue:

    1. Use the self-help options in the [Microsoft 365 and Office Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
    2. Create a support incident with Microsoft Online Services support. Request your IT administrator to create a new support incident.
