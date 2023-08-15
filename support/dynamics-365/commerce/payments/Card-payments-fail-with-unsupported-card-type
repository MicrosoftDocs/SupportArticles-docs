---
title: Card Payments fail with the error Unsupported Card Type
description: Provides a resolution for addressing the error message of Unsupported Card Types when processing credit or debit card transactions\. 
author: bstorie
ms.author: brstor
ms.date: 08/15/2023 
---
#  Credit and Debit card transactions fails with the error "Unsupported Card Types"

## Symptoms
Card (or gift card) payments are failing with this error in POS:

> "The card type is not an accepted form of payment. Use a different payment card and then try again."

This error is also found in the logs:

> "Card type with id 'Unknown' not found"

Note that the payment is authorized successfully before this error is shown. After the error, the payment is voided with the payment service.

## Cause
No card types configured for the channel's payment method match the payment information returned by the payment connector for the payment.

Card types are matched by the combination of bin range, card type ID (i.e. Credit, Debit, etc), and entry type (i.e. Swipe or Manual).

## Resolution 1

To solve this issue, verify that the card types are configured correctly for the tender type and channel being used.

1. Check the Events Logs on the POS or POS Clients Logs in LCS for event names like the following:
  -  **posPaymentCardTypeFilterByBinRangeIsDebitOrCredit**
     -  indicates whether the payment processor received the card type as Credit, Debit, or Gift card. If this value is not as expected, the funding source may be set or sent incorrectly.
  - **posPaymentCardTypeFilterByBinRangeIsSwipe**
     - indicates whether the user selected to swipe or manually enter the card via POS. If the card type with matching bin range does not allow manual entry but the card was entered via swipe this could result in no matching card types.

  > POS looks for matching bin range based on the card type returned by payment processor/connector. If the card type is credit card we look for all the card types of type "International credit card" that are setup for the store and look for bin range match within these card types. If the card type is "Debit Card" we look for all the card types setup for the store as "International debit card" and match within these bin ranges. If payment connector doesn't set card type we consider it by default as credit card and look for match within card types of type "International credit card.

2. In **Commerce HQ**, navigate to the **Card types** form
3. Check the following:
  - Card brand exists, if missing add it
  - Check the correct card type is assigned to the brand (International credit card or debit card) 
 - **Click** on **Card Numbers** in the tool bar - Ensure a Bin Range is set up to cover the unaccepted card number

  > If Credit or Debit card is properly setup and you are still receiving an error, the error can be caused by the payment connector returning the wrong card type id. Example: returning Debit card type, but only credit card type is setup in Commerce HQ.  In this situation you need to create a card type for both Credit and Debit cards with the same bin range.

4. In **Commerce HQ Navigate** to the **channel/store** form having the issue and go to **Setup** > **Payment methods**.
5. **Select** the **payment method** being used for cards and go to **Electronic payment setup**.
6. **Add both credit** and **debit card types** to the payment method.
7. **Run CDX 1090 Job** and **verify** it shows as **applied status**  


## Resolution 2

Check Adyen Funding source property
 In the Adyen payment connector we set card type based on FundingSource property in Adyen Auth response. If this "FundingSource" property is not set by Adyen in Auth response we don't set card type within connector but POS defaults to "credit" when looking for bin ranges.
 If you started seeing "missing bin range" issue with out any recent changes in the card type bin range setup, it could be because of three known reasons:
 
1. Check if there was recent Adyen firmware upgrade that started sending the "FundingSource".
2. If the "FundingSource" was enabled in Adyen portal recently which triggered the issue.
3. If there is no change in either of them it could because the bin range was never setup for that specific card/card type.

For Adyen firmware version 1.42.4 and below "FundingSource" is not mandatory and Adyen used to not send it. The funding source will be sent back in the response as mandatory field for a POS terminal in the Firmware version 1.44 and above version and is not controlled by any config in the portal.

To turn on/off Funding Source on the Adyen portal, do the following:
 1. Log into the Adyen portal.
 2. On the top navbar, select **Account** 
 3. Select   **API URLs**
 4. On the API URLs and response page, select the  **Additional data settings** 
 tab.
 5. Scroll down until you find  **Funding Source**, (un)check it, and save changes.


## More information

For more information, see [Payment Methods Setup](/dynamics365/commerce/payment-methods.md).
