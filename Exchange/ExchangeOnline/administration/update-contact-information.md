---
title: How to update contact information in Exchange Online in Microsoft 365
description: Describes the kind of contact information that administrators and users can change by using the Exchange admin center in Microsoft 365. Also describes how administrators can limit the kind of contact information that users can change.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# How to update contact information in Exchange Online in Microsoft 365

## Introduction

This article describes how administrators and users can update personal contact information by using the Exchange admin center in Microsoft 365. It also discusses how administrators can limit the kind of contact information that users can update.

## More information

Administrators and users can update the following personal contact information by using the Exchange admin center:

Photo

General:

- First name
- Initial
- Last name
- Display name

Contact location:

- Street
- City
- State/Province
- ZIP/ Postal code
- Country/Region
- Office

Contact numbers:

- Work phone
- Fax
- Home phone
- Mobile number

> [!NOTE]
> Only managed users can update their personal contact information. Users who are in organizations that use directory synchronization can't update their contact information by using the Exchange admin center. For organizations that use directory synchronization, use on-premises tools to update contact information.

### How to update contact information

To update contact information, see [View and update your profile in Delve](https://support.microsoft.com/office/view-and-update-your-profile-in-delve-4e84343b-eedf-45a1-aeb9-8627ccca14ba). For more information about Delve, see [What is Delve](https://support.microsoft.com/office/what-is-delve-1315665a-c6af-4409-a28d-49f8916878ca).

> [!NOTE]
> The offline address book (OAB) will not be updated for at least 24 hours.

### How administrators can update users' contact information

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. Click **Admin**, and then click **Exchange**.
3. In the left navigation pane, click **Recipients**, and then click **Mailboxes**.
4. Double-click the user whose contact information you want to change.
5. In the **User Mailbox** window, click **Contact Information**.
6. Make the changes that you want, and then click **Save**.

### How administrators can limit users' ability to update their own contact information

This procedure must be applied to all user role policies in an organization.

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. Click **Admin**, and then click **Exchange**.
3. In the left navigation pane, click **permissions**, and then click **user roles**.
4. Select the role that's assigned to the user. By default, the Default Role Assignment Policy is assigned to all users.
5. Click **Edit** (:::image type="icon" source="media/update-contact-information/edit.png":::).
6. In the **Role Assignment Policy** window, under **Contact Policy**, make sure that the **MyContactInformation** and the **MyProfileInformation** check boxes are cleared.

    > [!NOTE]
    > You can also control the level of access for the user by clicking to select the two check boxes and then clicking to clear specific options that are listed under the two check boxes.
7. Click **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
