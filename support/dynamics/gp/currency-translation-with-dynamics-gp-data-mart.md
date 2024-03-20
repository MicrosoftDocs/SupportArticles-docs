---
title: Currency translation for Management Reporter 2012 with data mart
description: Describes how to use currency translation with Microsoft Management Reporter 2012 Data Mart and Microsoft Dynamics GP.
ms.reviewer: theley, jopankow
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# Currency translation for Microsoft Management Reporter 2012 with Microsoft Dynamics GP data mart

This article describes how to configure currency translation for Microsoft Management Reporter 2012 with Microsoft Dynamics GP 2013 or Microsoft Dynamics GP 2015 when using the data mart.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2986068

## More information

Additional information on how currency translation rates are calculated, can be found in the blog articles below. Setup and configuration of currencies and rates are in the main body of this article.

- Using the current rate (typically used with Balance Sheet accounts)

  [Management Reporter currency translation using the Current translation type](https://community.dynamics.com/blogs/post/?postid=567e5d44-e1f5-4b9d-8c3f-a5429591a073)

- Using the historical rate (typically used with Retained Earnings, Property, Plant & Equipment, and Equity accounts tha may be required to use this based on FASB or GAAP guidelines):

  [Management Reporter currency translation using the Historical translation type](https://community.dynamics.com/blogs/post/?postid=ce241043-963f-47d4-94a7-7db49300b782)

- Using the average rate (typically used with Income Statement (Profit/Loss) accounts)

  [Management Reporter currency translation using the Average translation type](https://community.dynamics.com/blogs/post/?postid=567e5d44-e1f5-4b9d-8c3f-a5429591a073)

- How to use Cumulative Translation Adjustment (CTA) in Management Reporter:

  [How to use a Cumulative Translation Adjustment (CTA) account in Management Reporter](https://community.dynamics.com/blogs/post/?postid=e47a4e6e-99de-4ff8-9af2-f4771ea1c0b6)

> [!NOTE]
> Only the values in Microsoft Dynamics GP used by Management Reporter 2012 are explained in this article. All other fields not referenced are not used by Management Reporter 2012.

### Set up the Microsoft Dynamics GP company

1. Verify that a currency has been created for the company. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **System** > **Currency**.
2. Assign access to the currency for the company. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **System** > **Multicurrency Access**.
3. Assign a functional currency to the company. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Multicurrency**.

4. Decide the Average Calculation Method that you will use. This determines how average rates are calculated, and may influence how you will enter rates into the exchange tables depending on the average rate you want used. You can select the Average Calculation method by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Multicurrency** > **Average Calculation Method drop-down**.

    There are three options available in Microsoft Dynamics:

    Exchange Table: Not used by Management Reporter 2012. If selected, the average calculation method will default to Rate Average.

    Rate Average: This is the same average calculation method that was used by the Management Reporter 2012 legacy provider for Microsoft Dynamics GP. This is calculated as sum of exchange rates / # of exchange rates.

    Rate Days Average: Weighted average. This is calculated as (Exchange rate * Days in effect) / Days in period.

5. Create an exchange table. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **System** > **Exchange Table**.

    1. Enter an exchange table name and description.
    2. Select the currency ID that will be the end result of the translation process.
    3. Set the Rate Frequency. This option sets the default expiration date that will be entered when entering a new exchange rate. For example, if you select **Weekly**, each new rate entered will automatically enter the expiration date one week after the date selected. The expiration date is only honored for accounts using the Current translation method if no other exchange rates are found after the last entered rate.
    4. Set the Rate Calculation Method. Microsoft Dynamics GP assumes that you are entering rates to go from your reporting or originating currency back to your functional currency. Because of this, when you configure an exchange table, take into consideration the type of rates you are entering. If you want to have an exchange table that takes **Functional currency * Rate = Reporting Currency**, then select **Divide** as this would equate to **Reporting Currency / Rate = Functional Currency**.
    5. Set the Transaction Rate Default. Microsoft Dynamics GP has a feature where it can look for rates using the Previous, Next, or Exact Date option. The Management Reporter 2012 legacy data provider for Microsoft Dynamics GP utilized this feature, but Management Reporter 2012 Currency Translation with the data mart does *not* use this setting. Management Reporter 2012 will only use the date entered for the rate, or the closest previous date available.

6. Enter rates for the exchange table. To do this, you can select **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **System** > **Exchange Table** > **Rates button**.

    Date: Enter the date the exchange rate will begin.

    Exchange Rate: Enter the rate that will be used for the date(s) entered

    Time: The Time value is not read by Management Reporter 2012. All rates will start at 12:00 a.m. on the start date. Only one rate is read per date by Management Reporter 2012.

    Expiration Date:

    The expiration date is honored only if no exchange rates are found after the last entered rate.

    The expiration date displayed is automatically calculated by Microsoft Dynamics GP based on the Rate Frequency value of the Exchange Table window.

    In CU11 and later, the expiration date for all methods are now honored.

7. Grant the company access to the exchange tables for each currency. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **System** > **Multicurrency Access**.

    1. In the **Currencies** section, select the currency ID that amounts will be translated to.
    2. In the **Exchange Table IDs** section, select the exchange table to assign to the company.
    3. Place a checkmark in the **Access** box next to each company that will use the exchange table.

8. Associate the exchange table to the currency for the company. To do this, select **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Multicurrency**.

    1. In the **Currency Translation Default Exchange Table IDs** section, place a check next to the Currency ID that balances will be translated into.
    2. Select an exchange table to be used for Current, Historical, Average and Budget. It is required to assign an exchange table for each.

9. Configure the default rate types for the Microsoft Dynamics GP company. You can do this by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Multicurrency**  in the Default Transaction Rate Types section.

    The default rate types included with Multicurrency for Microsoft Dynamics GP are AVERAGE, BUY, and SELL.

    > [!NOTE]
    > Setting the Default Transaction Rate Types are a required setting on the Multicurrency Setup window, but are not used by Management Reporter 2012.

10. Select the currency translation type for the Microsoft Dynamics GP accounts in Account Currencies.

    1. To assign the translation type for an individual account, go to **Cards** > **Financial** > **Account** and select **Currency**.
    2. To assign the translation type for multiple accounts at a time, go to **Cards** > **Financial** > **Currency Account Update**.
    3. Set the Currency Translation Type for the accounts that you want to translate. This setting controls whether an account will use an Average, Current or Historical translation. The setting works with the Multicurrency Setup window (from step 8) to determine which exchange table to use.

> [!NOTE]
> Each account may only be assigned to a single translation type.

> [!NOTE]
> If you change the Account Currency, you must wait for the data mart task **AccountProvider to Account** to complete before you generate a report.

### Summary of the available translation methods for an account

#### Current

The Current translation method is a month end rate calculation method, calculated as the rate on or before the date selected in the report definition, or date set for a column in the column definition (if different than the report date).

This translation type is typically used with balance sheet accounts and a YTD column.

YTD columns are calculated by translating the beginning balance amount at the rate active for the beginning balance date.

#### Average

The Average translation method is a single exchange rate calculated for each period. Management Reporter calculates the average rate based on the Average Calculation Method option selected in Microsoft Dynamics GP on the Multicurrency Setup window (**Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Multicurrency** > **Average Calculation Method drop-down**). This is explained further in the Setup section.

This translation type is typically used with income statement accounts.

The average rate used for each period is calculated based on the Average Calculation Method selected in Microsoft Dynamics GP.

The balance displayed for a YTD column is calculated by translating each period at the average rate for that period, and summarizing the translated balances for all periods.

#### Historical

The Historical translation method is an exchange rate based on the transaction date. If a rate is not entered for the transaction date, the rate used is the previously entered rate closest to transaction date.

The Historical translation type is typically used with non-monetary assets such as inventory, fixed assets, long-term liabilities, or equity/retained earnings.

#### Beginning Balances (BB) and Currency translation

Management Reporter 2012 data mart Currency Translation does not use the translated beginning balance values from the Currency Translation routine window in Microsoft Dynamics GP (**Microsoft Dynamics GP menu** > **Tools** > **Routines** > **Financial** > **Currency Translation**).

In a year-to-date (YTD) column, beginning balances are translated just like any other transaction. The beginning balance amount will be translated using the same translation method and rate used for other transactions for the account that occur in the same period. In a row or column where the beginning balance is being isolated (a row with the Account Modifier of /BB, or a column using PERIODIC/BB or YTD/BB), the beginning balance amount will be translated at the rate entered for the year-end date; typically 12/31 for a calendar fiscal year.

### Report design in Management Reporter 2012

- Row definition

  You do not need to configure anything in the row definition for currency translation to work. Each account will be automatically translated based on how it is configured in Microsoft Dynamics GP.

- Column definition

  Depending on how you want to view the report, there are two options

  1. All columns displayed in the same currency, with the option to dynamically change all columns to a different currency in the Management Reporter web viewer. To do this, leave the **Currency Display** field blank. This will generate the report and display the balances in the functional currency for the company. After the report has been generated, view the report in the Web Viewer and select the **Currency** button and select a different currency for the report. All columns that do not have a currency defined will be switched to the currency you have selected. The report must have already been generated.

  2. Select a Currency ID in the **Currency Display** field. This will force the column to display only in the currency that you have selected.

  > [!NOTE]
  > If reports were designed to use the Management Reporter 2012 Legacy data provider for Microsoft Dynamics GP, you may need to update the **Currency Display** and **Currency Filter** to use the ISO code of the currency (For example: USD). The previous release populated these fields with the Currency ID (For example: Z-US$).

- Report definition

  Check the **Include all reporting currencies** option in the report definition, on the **Report** tab. By selecting this, the report will be automatically generated for all currencies configured for the company. This will cause the report to generate once for each currency that has exchange tables configured for the company. Changing the display of a report to a different reporting currency is only available in the web viewer.

### Report viewing in Management Reporter 2012

The Management Reporter 2012 Web Viewer gives you the option to dynamically view reports in multiple currencies by using the **Currency** button on the toolbar. You cannot dynamically view a Management Reporter 2012 report in a different currency with the Management Reporter 2012 Report Viewer (desktop viewer) client. If the **Currency** button is not available in the Web Viewer, press Ctrl+F5 to reload the page.

When you select a different currency, one of two things will happen:

1. If the report definition had the option **Include all reporting currencies** checked, the report will be immediately displayed in the selected currency.
2. If the report definition did not have the option **Include all reporting currencies** checked, the report will be sent to the Report Queue, and displayed in the selected currency after the report finishes generating.

### Currency translation and Retained Earnings

You can define the Retained Earnings account(s) by clicking **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **General Ledger**. It must be assigned to account category number 27 (the default Retained Earnings category number). You can find the account category number by selecting **Microsoft Dynamics GP menu** > **Tools** > **Setup** > **Financial** > **Category**.

Microsoft Management Reporter 2012 does not support posting transactions to the retained earnings account. If transactions are posted to the retained earnings account, the translated balances will not be calculated correctly. We recommend that you set up additional retained earnings accounts for posting adjustments.

Starting with CU11, the account category is no longer required for Retained Earnings. The translation now uses the original document information to properly calculate the translated values. Posting to Retained Earnings is also now supported in CU11 and later.

Additional information can be found here:

- Using the current rate

  [Management Reporter currency translation using the Current translation type](https://community.dynamics.com/blogs/post/?postid=567e5d44-e1f5-4b9d-8c3f-a5429591a073)

- Using the historical rate

  [Management Reporter currency translation using the Historical translation type](https://community.dynamics.com/blogs/post/?postid=ce241043-963f-47d4-94a7-7db49300b782)

- Using the average rate

  [Management Reporter currency translation using the Average translation type](https://community.dynamics.com/blogs/post/?postid=567e5d44-e1f5-4b9d-8c3f-a5429591a073)
