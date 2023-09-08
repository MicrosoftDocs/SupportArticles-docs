---
title: Cash receipts are automatically depositing into bank reconciliation
description: Provides a resolution for the issue that cash receipt batches are posting to bank reconciliation as individual deposits.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 06/22/2022
---
# Cash receipts are automatically depositing into bank reconciliation in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3098833

## Symptoms

You have the option turned on to automatically post cash receipt to bank reconciliation and expect the batch to post to bank reconciliation as one lump sum deposit, but it's still posting to bank reconciliation as individual deposits (per transaction).

## Cause

By design, cash receipt batches in Microsoft Dynamics GP 2013 - Microsoft Dynamics GP 2015 should post as individual deposits (per transaction) to bank reconciliation. This was changed in Microsoft Dynamics GP 2016 RTM, where each cash receipt batch should now post to bank reconciliation in one lump sum deposit per batch. In Microsoft Dynamics GP 18.4.1361, you'll now have the option to post cash receipt batches in either lump sum/summary deposits or in detail/transaction deposits.

## Resolution

If your cash receipt batches are still posting to bank reconciliation as individual deposits, check the following options below that drive this functionality:

### For Microsoft Dynamics GP 2013 and prior versions

The option to post cash receipts automatically to bank reconciliation was only available in the Analytical Accounting setup window. (**Tools** > **Setup** > **Company** > **Analytical Accounting** > **Options**)

Verify that the checkbox for Post Cash Receipt Deposits automatically in BR is marked. If it's marked, the cash receipts will post to bank reconciliation automatically, but by design, you'll get individual deposits per cash receipt in the batch.

> [!NOTE]
> There is no "lump sum deposit" functionality for posting batches in Microsoft Dynamics GP 2013 and prior versions. This option was removed from Analytical Accounting in Microsoft Dynamics GP 2015 R2.

### For Microsoft Dynamics GP 2015 R2 (14.00.0725)

The option to post cash receipts automatically to bank reconciliation was removed from the Analytical Accounting setup window and added to the Company setup options. (**Tools** > **Setup** > **Company** > **Company** > **Options**)

Make sure the **Automatically post cash receipt deposits** option is marked. With this option marked, all cash receipt batches posted will automatically update bank reconciliation as "individual deposits" per cash receipt in the batch.

> [!NOTE]
> There is no "lump sum deposit" functionality for posting batches in Microsoft Dynamics GP 2015.

### For Microsoft Dynamics GP 2016 RTM (16.00.0404) and higher versions

The functionality for the company setup option for Automatically post cash receipt deposits was changed to now post a [lump sum deposit](https://community.dynamics.com/blogs/post/?postid=a08964fa-e239-4486-9692-f39ae79fbc67) in bank reconciliation for all the cash receipts in the batch. (**Tools** > **Setup** > **Company** > **Company** > **Options**)

Make sure the **Automatically post cash receipt deposits** option is marked. With this option marked, a single "lump sum deposit" for all cash receipts in the batch will update bank reconciliation.

An alternate solution: If you wish to have individual deposits per transaction in bank reconciliation, then you must either use transaction level posting for each cash receipt (and manually post the "CMTRX" batch that stopped in GL) or put each cash receipt in its own batch. (One deposit is created per batch.)

> [!NOTE]
> The new feature for [posting post through to GL files](https://community.dynamics.com/blogs/post/?postid=7628b8bc-7a40-42a2-a2de-8b40dcac1a38) was added for transaction level posting in Microsoft Dynamics GP 2018 R2 (18.00.0628).

### For Microsoft Dynamics GP 18.4 and higher versions (new feature/enhancement)

Enhanced functionality was added in the Oct 2021 release (18.4.1361) to give the user the option to post a cash receipt batch in either as either a lump sum deposit to bank reconciliation for the whole batch, or to have each transaction in the batch post as an individual deposit in bank reconciliation. A new field for "Post Deposit" was added to the cash receipt batch setup, where the user can select either "summary or transaction" from the drop-down list prior to posting the batch.

## General questions and answers

**Q1: I have the option marked to have a cash receipt batch post in SUMMARY, but it is still posting as individual deposits to bank reconciliation.**

**A1: Troubleshooting (for Microsoft Dynamics GP 2016 and higher versions):**

Review these reasons on why a cash receipt batch may still post to bank reconciliation as individual deposits when you've it marked to post in summary:

**Reason #1** - Multicurrency Management isn't enabled.

Cash receipts may still post as single deposits if Multi-currency Management isn't enabled. You're required to activate Multi-currency Management if you want a single lump-sum deposit per batch. This won't be changed.

**Reason #2** - If you have Project Accounting installed, security to PA windows may also cause individual deposits to update bank reconciliation per batch. Set security to the non-PA window for Cash Receipts Entry and Receivables Batch entry windows as the workaround. This will be considered for a future update.

**Reason #3** - You have a third party product installed, and security is set to their window. Test without the third party product installed, or change security to the window back to the "Microsoft Dynamics GP" version. (Test MEM if you've it installed.)

**Reason #4** - If your cash receipts are automatically posting to bank reconciliation as individual deposits, verify if the Payment Document Management (PDM) module is installed or not. (Review modules listed in **Tools** > **Setup** > **System** > Edit launch File or in the Dynamics.set file.) Having PDM installed will affect the behavior of payment windows in both Payables and Receivables Management (that is, hanging when saving or posting or just odd behavior in general), so it isn't recommended for a U.S. install. (Don't install PDM for the sake of getting your cash receipts to auto-deposit individually as it may cause other issues). Often all modules get installed during an upgrade or initial installation and PDM often gets installed by mistake. If you need to remove it, you can remove it from your Dynamics.set file and test again, or uninstall it from Microsoft Dynamics GP in Programs and Features.

**Reason #5** - Review the Resolution section above for the Microsoft Dynamics GP version you are on, and what functionality is available to you on that version.

**Q2: How does the POSTING DATE work for the deposit when I auto-deposit cash receipts?**

**A2:** This is how the posting date works when the **Automatically post cash receipt deposits** option is marked:

Posting setup (under **Tools** > **setup** > **posting** > **Posting**) for Sales - Receivables cash receipts:

|Posting Date from:| Posting method:|Deposit date used:|
|-|-|-|
|Transaction| Transaction level|Transaction date|
|Batch|Batch level | Posting date on batch|
|Batch|Transaction level|GP user date|

**Q3: How do I get cash receipts batches to post as "individual deposits" to bank reconciliation?**

**A3:** On Microsoft Dynamics GP 18.4.1361 or higher, there's a **Post Deposit** field on the cash receipt batch that will allow the user to post the batch in either summary or as individual deposits per transaction to bank reconciliation. The default is to set to **Summary** but the user can edit it as preferred. For any prior Microsoft Dynamics GP versions, review the Resolution section above.

