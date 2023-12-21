---
title: Unable to save email to CRM due to invalid mailbox settings
description: Troubleshoot and resolve error messages in Copilot for Sales due to invalid mailbox settings in Dynamics 365.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Unable to save email to CRM due to invalid mailbox settings

This article helps you troubleshoot and resolve error messages in Copilot for Sales due to disabled mailbox in Dynamics 365.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | All users   |

## Symptom

When you open Copilot for Sales in Outlook, and try to save an email or a meeting to CRM, you see the following error message:

:::image type="content" source="media/tsg-disabled-mailbox-error-detail.png" alt-text="Error details":::

## Cause

This occurs when the user's mailbox is disabled or the mailbox is missing a server profile.

## Solution

1. Open the CRM instance you connected to Copilot for Sales.

    > [!NOTE]
    > To get the CRM instance URL, select **Options** (**…**) in the upper-right corner of the **Copilot for Sales** pane. The URL is displayed under **Signed in to Dynamics 365**.

2. Select **Settings** > **Personalization Settings**.

    :::image type="content" source="media/tsg-disabled-mailbox1.png" alt-text="Personalization settings":::

3. Select the **Email** tab, and then select **View your Mailbox**.

    :::image type="content" source="media/tsg-disabled-mailbox2.png" alt-text="Email tab":::

4. Under **Synchronization method**, ensure a value is selected for **Server Profile**. If not, select **Microsoft Exchange Online**.

    :::image type="content" source="media/tsg-disabled-mailbox4.png" alt-text="Select a server profile.":::

5. In the ribbon, if **Activate** is available, select it.

    :::image type="content" source="media/tsg-disabled-mailbox3.png" alt-text="Activate mailbox":::

    > [!NOTE]
    > To see any errors or warnings related to server-side synchronization, select **Alerts** in the left pane. Each alert has a link to more information about the issue and how to resolve it.

6. Select **Save & Close**.

## Is your issue still not resolved?

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
