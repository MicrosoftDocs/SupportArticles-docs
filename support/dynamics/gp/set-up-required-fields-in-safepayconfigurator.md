---
title: SafePay configuration for Canadian Banks in Microsoft Dynamics GP
description: There are certain fields required by Canadian Banks in the SafePay file that customers need assistance to set up.
ms.reviewer: cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# SafePay configuration for Canadian Banks in Microsoft Dynamics GP

This article describes steps to set up the required fields in the SafePay configurator.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2584867

## Symptoms

There are certain fields required in the Safepay file by Canadian banks that customers need assistance in setting up. Some of these fields may also apply to US bank requirements.

## Cause

Not all fields are available in the SafePay configurator.

## Resolution

Use the steps below to set up the respective fields:

1. **TOTAL NUMBER OF TRANSACTIONS** - This field is a count of the number of checks in the SafePay file. It will count in the Batch Trailer or File Trailer Record Lines only. It won't count in the File Header or Batch Header Record lines by design. It can only count after the detail lines have been provided.

    Field Name: **Total number of Transactions**  
    Standard Fields: **Check Number**  
    Field Type: **Numeric**  
    Field Format: **Item Count**  
    Number of Characters: **8** (or as defined by your bank's specific requirements)
    Filler Type: **zeroes** (or as defined by your bank's specific requirements)
    Justification: **Left** (or as defined by your bank's specific requirements)

2. **TOTAL DOLLAR AMOUNT OF TRANSACTIONS** - This field is a sum total of the check amounts in the SafePay file. It will sum in the Batch Trailer or File Trailer Record Lines only. It won't sum in the File Header or Batch Header Record lines by design. It can only sum after the detail lines have been provided.

    Field Name: **Total Dollar Amount of Transactions**  
    Standard Fields: **Check Amount**  
    Field Type: **Currency - no $/no decimal** (or as defined by your bank's specific format requirements)
    Field Format: **Net Total**  
    Number of Characters: **13** (or as defined by your bank's specific requirements)
    Filler Type: **zeroes** (or as defined by your bank's specific requirements)
    Justification: **Right** (or as defined by your bank's specific requirements)

3. **FILE CREATION NUMBER** - This field will increment by one (1) for every subsequent SafePay file generated for each CRS account number. The bank will reject any files with a used file creation number within the last 16 submitted files to safeguard against the same file being processed twice. Unfortunately, this incrementing field isn't currently available in SafePay at this time. Your options include:

    **Option 1** - Contact MBS Professional Services to have a customization done. A temp table will need to be created to store this incrementing value. You can contact the Partner Advisory Team to open a consulting engagement.

    **Option 2** - Another option is to hard-code a constant value in the file such as '000X'. Then you can manually track the incrementing value separately and edit the SafePay file with this value each time before sending the file to the bank.

    Field Name: **File Creation Number**  
    Standard Fields: **Constant**  
    Field Type: **Text**  
    Number of Characters: **4** (or as defined by your bank's specific requirements)
    Constant Value*: **000X** (Key as many digits as defined by your bank's requirements for the length of this field)
    Filler Type: **zeroes** (or as defined by your bank's specific requirements)
    Justification: **Right** (or as defined by your bank's specific requirements)

    > [!NOTE]
    > Due to the length requirement on the line in the output file, be sure the user doesn't remove or add any extra spaces when they edit this field before sending the file to the bank. For example, let's say this field is hard-coded as 000X and this is the 14th file, so they need to edit this field to be 14, they will need to overwrite this field as 0014. It has to remain 4 characters (or the number of characters defined by their bank requirements.) So if the total line length is 94, and the user keys 00014 (which makes that particular field 5 characters wide instead of 4) then this will push the total line length to 95 characters wide (instead of the required 94), so the bank will not accept the file. Be cautious to only overwrite the exact number of characters needed when editing the file so that the total line width is not jeopardized.
    >
    > If you would like to see the File Creation Number field added to Microsoft Dynamics GP as a future enhancement, go to the MS Connect Product Suggestion database and vote on this product suggestion. The more votes it gets over time, the higher in priority this enhancement will be considered as a future enhancement. The link to use is:
    >
    > `https://connect.microsoft.com/dynamicssuggestions/feedback/details/676328/microsoft-dyamics-gp-savepay-needs-to-have-a-file-creation-number-field-that-increments-for-each-successive-safepay-file-generated`

4. **TRANSACTION TYPE** - The bank will provide specific required codes to indicate what type of document the Detail lines in the SafePay file are, such as Issues, Stop-Pays, Voids, or Deletes, and so on. The SafePay file in Microsoft Dynamics GP will only pull Checks, Voids, or EFTs, so they're the only types that can be entered. Here are the steps to set up the Transaction Type codes:

    1. Enter the Transaction Codes in the Configurator:
        1. In the Safe Pay Configurator window, click **Codes Entry** in the top menubar and click **Transaction Codes Entry**.
        1. In the Transaction Types Entry window, click the drop-down list next to **Transaction Type**, and choose **Check, Void** or **EFT** as needed.
        1. Key in the bank's required code for that document type in the **Matching Code** field.
        1. Proceed to enter the next Transaction Type and Matching code as needed. (Usually values for Check and Void are entered.)
        1. Click **Save**.
    1. Now in the Detail Record Line of the Configurator file, you'll need to map one of the fields as defined by your bank's requirements to pull the corresponding Transaction Type Codes you entered above.
    1. In the Safe Pay Configurator window, click to select the Detail Line in the 'Step 2 - Create Output Records Lines' section.
    1. In the 'Step 3 - Edit Record Fields' section, double-click on the field that you wish to map as indicated by our bank's requirements.
    1. Enter the field as follows and save:

        Field Name: **Transaction Code**
        Standard Fields: **Transaction Type**  
        Field Type: **Text**  
        Number of Characters: **3** (or as defined by your bank's specific requirements)

        The **Filler Type** and **Justification** fields can be left blank. (Usually if the bank requires the field to be 3-character wide, for example, then the codes they supply are also same the width, so a filler type or margin justification isn't needed. The code will fill the entire field.)

5. **FIELD WITH ALL ZEROES** - These steps show how to create a Filler type field with all zeroes in it.
    Field Name: **Filler**  
    Standard Fields: **Filler**  
    Field Type: **Text**  
    Number of Characters: **8** (or as defined by your bank's specific requirements)
    Filler Type: **zeroes**  

6. **BLANK FIELD** - These steps show how to create a Filler type field that is blank or has spaces in it.
    Field Name: **Filler**  
    Standard Fields: **Filler**  
    Field Type: **Text**  
    Number of Characters: **8** (or as defined by your bank's specific requirements)
    Filler Type: **spaces**  

7. **ABSOLUTE VALUE OF DEBITS AND CREDITS** - Some banks require the absolute total of the debits and credits (added together) in the footer line. However, GP only has a 'Net Total' field available. There's a free cnk file that will allow for absolute values in the Safepay file. Partners can download the SpTotals.zip.

## More information

For more information on how to set up the SafePay Configurator, click the following article number to view the article in the Microsoft Knowledge Base:

[850752](https://support.microsoft.com/help/850752)  Steps to set up the SafePay Configurator in Microsoft Dynamics GP

You can contact the Partner Advisory Team to inquire on a billable consulting engagement for any other customizations needed. All services are handled through the Partner, as the only form of currency accepted is to decrement your Partner Advisory hours (PAH hours).
