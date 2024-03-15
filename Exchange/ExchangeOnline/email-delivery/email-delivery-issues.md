---
localization_priority: Normal
ms.topic: troubleshooting
author: cloud-writer
ms.author: meerak
f1_keywords: 
  - O365P_MessageTrace
ms.assetid: e7758b99-1896-41db-bf39-51e2dba21de6
ms.reviewer: v-six
description: Admins can learn how to fix email delivery issues in Exchange Online.
title: Find and fix email delivery issues as a Microsoft 365 for business admin
ms.collection: 
  - exchange-online
  - M365-email-calendar
search.appverid: 
  - BCS160
  - MOE150
  - MED150
  - MBS150
  - MET150
audience: Admin
ms.custom: 
  - MiniMaven
  - CSSTroubleshoot
  - SaRASetup
manager: dcscontentpm
appliesto: 
  - Exchange Online
ms.date: 03/14/2024
---
# Find and fix email delivery issues as a Microsoft 365 for business admin

When users report that they aren't receiving email, it can be challenging to determine the cause. You might run through several troubleshooting scenarios in your mind. Is something wrong with Outlook? Is the Microsoft 365 service down? Is there a problem in the mail flow or spam filter settings? Or is the problem caused by something that's outside your control, such as that the sender is on a global block list? Fortunately, Microsoft 365 provides powerful automated tools that can help you identify and fix a variety of problems.

## Check whether there's a problem in Outlook or another email app

If only one user reports having trouble receiving email, there might be a problem in their email account or their email app. Have the affected user try the following methods before you move on to admin-specific tasks.

### Use Outlook on the web to look for missing messages - 5 minutes

If a user is receiving email in their Outlook on the web mailbox but not on the email app that's installed on their computer, this could indicate that the issue is the user's computer or email app. Ask the user to sign in to Outlook on the web to verify that their Microsoft 365 email account is working correctly.

 **Instructions:** [Sign in to Outlook on the web for business](https://support.office.com/article/e08eb8ac-ac27-49f4-a400-a47311e1ee7e.aspx)

### Run Support and Recovery Assistant to fix Outlook problems or account issues - 10 minutes

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../../includes/sara-note-new-outlook.md)]

If a single user in your organization is having trouble receiving email, the cause could be a licensing issue, a profile problem, the wrong version of Outlook, or a mixture of other issues. Fortunately, the Microsoft Support and Recovery Assistant finds and helps you fix most issues that affect Outlook or Microsoft 365. As a first step in troubleshooting email delivery problems for Microsoft 365 for business, we recommend that you download and run Support and Recovery Assistant on the affected computer.

Notice that if you're experiencing issues that affect Outlook for Mac or are having mobile access issues, you can use the app to check your account settings. However, you have to install the app on a PC. After you sign in to the affected account, the app will check for issues. Users can typically download and run Support and Recovery Assistant without help from their Microsoft 365 admin.

:::image type="icon" source="./media/email-delivery-issues/get-start.png"::: **Let us fix your issue** [Download and run Microsoft Support and Recovery Assistant](https://AKA.MS/SaRASetup)

## If Support and Recovery Assistant doesn't fix the issue, try these admin tools

As a Microsoft 365 for business admin, you have access to several tools that can help you investigate why users are not receiving email. The following video provides a brief overview of the tools that are available to you.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/8b10af9a-455c-410a-8c17-24d5e5be098a]

The following list of tools is sorted from the simplest and quickest option to the most in-depth.

### Check Microsoft 365 service health for Exchange Online issues - 5 minutes

The service health page lists the status of Microsoft 365 services and indicates any recent service incidents.  To check the service health, follow these steps:

1. Sign in through the appropriate link on [Where to sign in to Microsoft 365 for business](https://support.office.com/article/e9eb7d51-5430-4929-91ab-6157c5a050b4) by using your work or school account.

2. Select the app launcher icon in the upper-left corner, and select **Admin**.

    > [!TIP]
    > **Admin** appears only to Microsoft 365 administrators.

    Can't find the app that you're looking for? From the app launcher, select **All apps** to see an alphabetical list of the Microsoft 365 apps that are available to you. From there, you can search for a specific app.

3. Under **Service health**, go to **View the service health**.

    :::image type="content" source="./media/email-delivery-issues/service-health.png" alt-text="Screenshot shows the View the service health option that's selected in the admin center." border="false":::

If there's an indication that the ExchangeOnline service is degraded, email delivery might be delayed for your organization, and you can expect that engineers are already working to restore service. Check the service health page for progress updates. In this case, you won't have to open a service request because we'll already be working to resolve the issue.

### Run email delivery troubleshooter

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

You can run an automated diagnostic to identify issues that affect email delivery, and find suggested solutions to fix the issues.

Select **Diag: Troubleshoot Email Delivery** to launch the diagnostic in the Microsoft 365 admin center. Enter the email address of the sender and recipient in addition to other relevant information, and then select **Run Tests**.

>[!div class="nextstepaction"]
>[Run Tests: Troubleshoot Email Delivery](https://aka.ms/PillarEmailDelivery)

:::image type="content" source="media/email-delivery-issues/email-delivery-troubleshooter.png" alt-text="Screenshot of an automated diagnostic named e-mail delivery troubleshooter.":::

### Use message trace for in-depth email delivery troubleshooting - 15 minutes

Sometimes, an email message gets lost in transit, or it can take a lot longer than expected for delivery. In such cases, users might wonder what occurred. The message trace feature lets you follow messages as they pass through your Exchange Online service. Getting detailed information about a specific message lets you efficiently answer your user's questions, troubleshoot mail flow issues, validate policy changes, and prevent you from  haviineeding to contact technical support for assistance.

#### Open the message trace tool

If you're a Microsoft 365 admin, you access and run the message trace tool through the Exchange admin center. To get there:

1. Sign in through the appropriate link on [Where to sign in to Microsoft 365 for business](https://support.office.com/article/e9eb7d51-5430-4929-91ab-6157c5a050b4) by using your work or school account.

2. Select the app launcher icon  in the upper-left corner, and select **Admin**.

    > [!TIP]
    > **Admin** appears only to Microsoft 365 administrators.

    Can't find the app that you're looking for? From the app launcher, select **All apps** to see an alphabetical list of the Microsoft 365 apps that are available to you. From there, you can search for a specific app.

3. Go to **Exchange**.

    :::image type="content" source="./media/email-delivery-issues/exchange-selected.png" alt-text="Screenshot of the admin center with Exchange selected.":::

4. Under **mail flow**, go to **message trace**.

If you're a Microsoft 365 Small Business admin, do the following to find message trace:

1. Go to **Admin** \> **Service settings** \> **Email, calendar, and contacts**.

2. Under **Email troubleshooting**, select **Troubleshoot message delivery**.

#### Run a message trace and view delivery details of messages that were sent in the past week

By default, message trace is set to search for all messages that were sent or received by your organization in the past 48 hours. You can select **Search** at the bottom of the page to generate this report. This report can give you a general idea about what's occurring to the mail flow in your organization. However, to troubleshoot a specific user's mail delivery issue, you'll want to first scope the message trace results for that user's mailbox within the time frame in which they expected to receive the message.

:::image type="content" source="./media/email-delivery-issues/message-trace-option.png" alt-text="Screenshot shows the options available in message trace." border="false":::

1. On the **Date range** menu, select a date range that's closest to the time at which the missing message was sent.

2. Use **Add sender** and **Add recipient** to add one or more senders or recipients, respectively.

3. Select **Search** to run the message trace.

4. The **message trace results** page shows all the messages that match the criteria that you selected. Typical messages are marked **Delivered** in the **STATUS** column.

    :::image type="content" source="./media/email-delivery-issues/message-trace-results.png" alt-text="Screenshot shows an example of message trace results." border="false":::

5. To see details about a message, select the message, and then select :::image type="icon" source="./media/email-delivery-issues/pencil-icon.png"::: ( **Details**).

6. Details appear together with an explanation of what occurred to the message. To fix the issue, follow the instructions in the **How to fix it** section.

    :::image type="content" source="./media/email-delivery-issues/message-trace-details-page.png" alt-text="Screenshot of the message trace details page showing an example of what message trace details look like." border="false":::

To search for a different message, select the **Clear** button on the **message trace** page, and then specify new search criteria.

#### View the results of a message trace that's more than seven days old

Message traces for items more than seven days old are available only as a downloadable .csv file. Because data about older messages is stored in a different database, message traces for older messages can take up to an hour. To download the .csv file, do one of the following.

- Select the link inside the email notification that's sent when the trace is completed.

- To view a list of traces that were run for items that are more than seven days old, select **View pending or completed traces** in the message trace tool.

    :::image type="content" source="./media/email-delivery-issues/message-trace-tool.png" alt-text="Screenshot of the message trace tool that has a cursor hovering over the View pending or completed traces link." border="false":::

    In the resulting UI, the list of traces is sorted based on the date and time that they were submitted, starting at the most recent submissions.

    When you select a specific message trace, additional information appears in the right pane. Depending on what search criteria you specified, this may include details such as the date range for which the trace was run, and the sender and intended recipients of the message.

> [!NOTE]
> Message traces that contain data that's more than seven days old are automatically deleted. They cannot be manually deleted.

#### Common questions about message tracing

 **After a message is sent, how long before a message trace can pick it up?**

Message trace data can appear as soon as 10 minutes after a message is sent, or it can take up to one hour.

 **Why am I getting a time-out error when I run a message trace?**

The search is probably taking too long. Try simplifying your search criteria.

 **Why is my message taking so long to arrive at its destination?**

Possible causes include the following:

- The intended destination isn't responsive. This is the most likely scenario.

- A large message takes a long time to process.

- Latency in the service is causing delays.

- The message was blocked by the filtering service.
