---
title: Card payments fail due to an unsupported card type in Dynamics 365 Commerce
description: Provides a resolution for the card type is not an accepted form of payment error that occurs when processing credit or debit card transactions in Microsoft Dynamics 365 Commerce.
author: bstorie
ms.author: brstor
ms.date: 08/30/2023 
---
# A card payment fails due to an unsupported card type

This article helps resolve "The card type is not an accepted form of payment" error that occurs when processing credit or debit card transactions in Microsoft Dynamics 365 Commerce.

## Symptoms

A card (or gift card) payment fails with the following error message in the point of sale (POS):

> The card type is not an accepted form of payment. Use a different payment card and then try again.

You can also see the following error message in the event log:

> Card type with id 'Unknown' not found.

> [!NOTE]
> The card payment is [authorized](/dynamics365/commerce/dev-itpro/manage-payment-authorizations) successfully before you receive the error message. After the error message occurs, the card payment is voided by the payment service.

## Cause

The [card types](/dynamics365/commerce/payment-methods#card-types) configured for the channel's payment method don't match the payment information returned by the payment connector.

Card types are matched by a combination of bin range, card type ID (for example, **Credit** or **Debit**), and entry type (`Swipe` or `Manual`).

## Resolution 1

To solve this issue, make sure the card types are configured correctly for the tender type and channel.

- Check the [event log on the POS](/dynamics365/commerce/dev-itpro/retail-component-events-diagnostics-troubleshooting) or the [POS client log in Microsoft Dynamics Lifecycle Services (LCS)](/dynamics365/commerce/dev-itpro/retail-component-events-diagnostics-troubleshooting#access-lcs-log-search) for the following event names to see what card type values are being used.

  - `posPaymentCardTypeFilterByBinRangeIsDebitOrCredit`

     This event indicates whether the payment processor received the card type as **Credit**, **Debit**, or **Gift card**. If the value isn't as expected, the funding source might not be set or sent correctly.

  - `posPaymentCardTypeFilterByBinRangeIsSwipe`

     This event indicates whether the user selected to swipe or manually enter the card through the POS. If the card type with a matching bin range doesn't allow a manual entry, but the card was entered through a swipe entry, this could result in no matching card types.

   > [!NOTE]
   > The POS looks for a matching bin range based on the card type returned by the payment processor or connector.
   > - If the card type is "Credit card," the POS looks for all the card types set for the store as "International credit card" and looks for a bin range match within these card types.
   > - If the card type is "Debit card," the POS looks for all the card types set for the store as "International debit card" and matches within these bin ranges. 
   > - If the payment connector doesn't set a card type, the POS considers it by default as a credit card and looks for a match within the "International credit card" type.

- In Commerce headquarters, navigate to **Retail and Commerce** > **Channel Setup** > **Payment methods** > **Card types**.

  - Check if a card brand exists. Add a card brand if it's missing.
  - Check if the card type (**International credit card** or **International debit card**) is correctly assigned to the brand.
  - Select **Card numbers** in the toolbar, and ensure that a bin range is set to cover the unaccepted card number.

   > [!NOTE]
   > If a credit or debit card is properly set but you still receive an error, the error can be caused by the payment connector returning the wrong card type ID. For example, the payment connector returns the "Debit card" type, but only the "Credit card" type is set in Commerce headquarters. In this situation, create a card type with the same bin range for both credit and debit cards.

- In Commerce headquarters, navigate to the channel or store form that has the issue.  

   1. Select **Setup** > **Payment methods** and select the payment method used by the cards.
   2. Select **Electronic payment setup** and add both credit and debit card types to the payment method.

If any changes to Card Types or Payment method was made, run the CDX 1090 job and verify that its status showns as **applied**.

## Resolution 2

To solve this issue, check the `fundingSource` identifier set in [Adyen](https://www.adyen.com/).

In the Dynamics 365 Payment Connector for Adyen, a card type is set based on the `fundingSource` identifier in the Adyen authorization response. If the `fundingSource` identifier isn't set by Adyen in authorization responses, a card type won't be set in the connector. However, the POS defaults to "credit" when looking for bin ranges.

If you have a "missing bin range" issue, but you haven't changed the card type bin range settings recently, the issue might be caused by one of the following reasons:

1. A recent Adyen firmware upgrade has started sending the `fundingSource` identifier.
2. The `fundingSource` identifier has recently been enabled in the Adyen portal.
3. The bin range isn't set for that specific card or card type.

In Adyen firmware version 1.42.4 and earlier versions, the `fundingSource` identifier isn't mandatory, and Adyen used not to send it. In Adyen firmware version 1.44 and later versions, the funding source will be sent back in the authorization response as a mandatory field for a POS terminal, and the property isn't controlled by any configuration in the Adyen portal.

Follow these steps to turn the **Funding Source** on or off in the Adyen portal:

1. Sign in to the Adyen portal.
2. On the top navigation bar, select **Account** > **API URLs** > **Additional data settings**.
3. Scroll down to find the **Funding Source** setting, enable or disable it, and then save the changes.

## More information

For more information, see [Payment methods setup](/dynamics365/commerce/payment-methods).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
