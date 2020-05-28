---
title: Can't Verify Subscription or No Subscription Found in Office Mobile
description: Discusses the Can't Verify Subscription or No Subscription Found error message that you receive when you try to use Office Mobile on an iPhone. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office Mobile for iPhone
---

# "Can't Verify Subscription" or "No Subscription Found" error messages in Office Mobile

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you use Office Mobile for iPhone, you receive one of the following error messages:  

**Can't Verify Subscription**

**Please sign in to reactivate this app.**

**No Subscription Found**

**We couldn't find a subscription connected to your account.** 

## Cause

This issue occurs because a previously activated version of Office Mobile exists on the device, possibly from another subscription. Therefore, the new Office Professional Plus license cannot be applied. 

## Solution

To resolve this issue, follow these steps:

1. Verify that you have a license assigned to youin the Office 365 portal. To do this, follow these steps:
    
    > [!NOTE]
    > If you cannot sign in or do not see the **Settings** button, then you may not have administrative permissions or may not have a license assigned to you.
   1. Sign in to the [Office 365 portal](https://portal.office.com/account/#subscriptions).
   2. In the left pane, select **Subscriptions**.

      ![assigned licenses](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4058714_en_1)
   3. In the list of subscriptions and licenses, scroll down to the **Office 365 \<edition>** section, and then look for **The latest desktop version of Office**. If you see this entry in the list, you have an Office subscription that's assigned correctly.

        > [!NOTE]
        > If you don't see a vertical scroll bar, hover the pointer over the list, press and hold the left mouse button, and then scroll.

        ![Office status](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4058715_en_3)    
   4. If an entry for **The latest desktop version of Office** does not appear in the list, contact your administrator or go to the following website:

        - [Assign or remove licenses, or view a list of unlicensed users](https://docs.microsoft.com/office365/admin/subscriptions-and-billing/assign-licenses-to-users?redirectSourcePath=%252fen-us%252farticle%252fassign-licenses-to-users-in-office-365-for-business-997596b5-4173-4627-b915-36abac6786dc&view=o365-worldwide)         
     
2. Verify the status of the service health for the Office Subscription service.


**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).