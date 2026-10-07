---
title: Troubleshoot Microsoft Purview Auto-Labeling
description: Resolve unexpected results from Microsoft Purview auto-labeling policies. Check simulation matches, file labeling, existing labels, and Exchange activity.
author: nickjrobinson
ms.author: nickrob
audience: ITPro
ms.service: purview
ms.topic: troubleshooting-general
ms.custom:
  - sap:Sensitivity Labels\Auto-Labeling
  - CSSTroubleshoot
  - msecd-doc-authoring-1030
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 10/07/2026
ai-usage: ai-generated
#customer intent: As an administrator, I want to understand why my auto-labeling policy isn't producing the results I expect so that I can resolve the problem and continue deploying or using it confidently.
---

# Troubleshoot auto-labeling policies in Microsoft Purview

As an administrator, use these checks to resolve unexpected results from a Microsoft Purview auto-labeling policy. These policies apply sensitivity labels to files stored in SharePoint and OneDrive, and to email as Exchange sends or receives it. They don't label email already stored in mailboxes.

If you need help with labels that are applied or recommended while someone works in Word, Excel, PowerPoint, or Outlook, use [auto-labeling for Office apps](/purview/apply-sensitivity-label-automatically#how-to-configure-auto-labeling-for-office-apps) instead.

## Troubleshooting checklist

Start with one policy and one example item. Use the following steps to choose the checks that fit your problem.

### Check the policy and choose your symptom

Find the policy and check which stage it's reached:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/). Go to **Solutions** > **Information Protection** > **Policies** > **Auto-labeling policies**.
1. Select the policy. Check its status, target label, locations, and rules. Note whether you're reviewing simulation results or results after the policy was turned on.
1. Choose your symptom from the table.

| What you see | Where to start |
| --- | --- |
| You can't create a policy or turn it on. | [Can't create or turn on a policy](#cant-create-or-turn-on-a-policy) |
| Simulation is still running. | [Simulation hasn't completed](#simulation-hasnt-completed) |
| Simulation misses expected items or finds unexpected matches. | [Simulation results aren't what you expect](#simulation-results-arent-what-you-expect) |
| The policy is on, but an expected file isn't labeled. | [Policy is on but files aren't labeled](#policy-is-on-but-files-arent-labeled) |
| An existing label stays, changes, or doesn't provide the protection you expected. | [Existing label or protection isn't what you expect](#existing-label-or-protection-isnt-what-you-expect) |
| Counts differ between views, or you can't find Exchange activity. | [Numbers don't agree or Exchange activity is missing](#numbers-dont-agree-or-exchange-activity-is-missing) |

Simulation finds matches without changing labels. A match isn't confirmation that a label was applied. After you turn on the policy, check the labeling result separately.

If you can't open policy review pages, ask your administrator to check the [policy review permissions](/purview/apply-sensitivity-label-automatically#policy-level-labeling-activity-for-sharepoint-and-onedrive).

## Causes and solutions

Follow the section for your symptom. Portal layouts can vary; the steps describe the newer policy review pages.

### Can't create or turn on a policy

Check access, the selected label, and the simulation status before changing the policy.

1. If the auto-labeling page is missing or you can't manage policies, check the [licensing and availability guidance](/purview/apply-sensitivity-label-automatically#licensing-and-where-to-find-each-surface). Ask your administrator to confirm the permissions required for your task. Turning on a policy requires **Compliance Administrator** or **Compliance Data Administrator**.
1. If the label can't be used, check that it's created and published. A parent label that has sublabels can't be applied to content; select an appropriate sublabel or a label without sublabels. Its scope needs **Files & other data assets** for files or **Emails** for email.
1. If you can't turn on the policy, check whether simulation completed. Every policy needs at least one simulation before it can apply labels. If results exceed the [simulation limit](/purview/apply-sensitivity-label-automatically#learn-about-simulation-mode), narrow the locations or conditions, then rerun simulation.

After correcting the identified issue, save the policy and review a completed simulation before turning it on. If an error remains, record its exact text for Microsoft Support rather than deleting the policy.

### Simulation hasn't completed

Check the current run, not just the number of matches.

1. Select the policy, then **Summary** > **View details**. On **Simulation overview**, check **Status** and **Duration**. Simulation can take 12 hours to complete; this is not a deadline for labels to appear, because simulation doesn't apply them.
1. If simulation is still running, allow it to complete before judging its results. Don't restart it just because the match count isn't changing.
1. When **Status** shows **Simulation complete**, [review the results](/purview/auto-label-simulation-results). A scheduled **Turn on date** doesn't confirm that activation succeeded; check the policy's status separately.

If the run doesn't complete or shows an error, collect its status, start time, duration, and error text for Microsoft Support. Don't treat the expected simulation duration as a guaranteed completion or escalation time.

### Simulation results aren't what you expect

Check what the policy looked for and when it looked.

1. On **Simulation overview**, compare **Configuration details** with the item's location. Check included and excluded locations, conditions, and exceptions. Use **Policy matches per rule** to identify which rule matched.
1. Open **Review sample items**, when available, to see **Items to review**. Compare an unexpected match with the rule's conditions. Viewing matched content requires the **Data Classification Content Viewer** role; a missing preview isn't evidence that an item didn't match.
1. For a missing SharePoint or OneDrive file, compare its modified date with the simulation run. If the file changed after the run, rerun simulation to evaluate the updated content. Also check whether the file was last modified before a sensitive information type was created or changed. To classify older unchanged files, use [on-demand classification](/purview/on-demand-classification). Review that feature's permissions, billing, and scan scope before starting.
1. For Exchange, check messages sent or received during the run, not older mailbox messages. Exchange simulation counts use sampled data, so a missing sample doesn't by itself establish a policy failure.

If a rule matches the wrong content, refine its conditions or exceptions, then rerun simulation. Review the new matches before deployment. Simulation shows one policy at a time; other active policies can affect the final label.

### Policy is on but files aren't labeled

For SharePoint and OneDrive, separate a missing match from a failed attempt to apply a label.

1. Select the policy, then **View details**. Open **Labeled items** to check successful label applications. Open **Labeling failures** to check failed attempts. Select the file and find **Failure reason**, under **Details** when that tab is available.
1. If there's a failure reason, follow its recommended action in [Resolve auto-labeling failures in SharePoint and OneDrive files](auto-labeling-failures-sharepoint-onedrive.md#resolve-auto-labeling-failures). Some failures are retried automatically; others need a specific correction. Don't apply a remedy for a different failure code.
1. If the file isn't listed, check its location and the policy conditions. Then check whether the file can be labeled:
   - Auto-labeling supports Word `.docx`, Excel `.xlsx`, PowerPoint `.pptx`, and PDF files. Attachments to SharePoint list items aren't supported.
   - Confirm that [sensitivity labels are enabled for SharePoint and OneDrive](/purview/sensitivity-labels-sharepoint-onedrive-files). PDFs also need [PDF support enabled](/purview/sensitivity-labels-sharepoint-onedrive-files#adding-support-for-pdf).
   - A file open for editing can't be auto-labeled. Close it or check it in, as appropriate.
   - If the policy's label applies encryption, check the [encryption prerequisites](/purview/apply-sensitivity-label-automatically#prerequisites--detailed-reference): **Assign permissions now** and **User access to content expires** set to **Never**.
1. After correcting the identified issue, return to **Labeled items** to check for successful application. Processing isn't immediate. If the result remains unexplained, collect the evidence in [Advanced troubleshooting and data collection](#advanced-troubleshooting-and-data-collection).

An empty **Labeling failures** list doesn't prove that a file was labeled. If the file never matched, use the [simulation checks](#simulation-results-arent-what-you-expect). If it already has a label, check whether the policy is intended to replace it.

### Existing label or protection isn't what you expect

Check the existing label and the intended outcome before changing protection settings.

1. Compare the existing label's priority with the policy's label, and check whether it was applied manually. By default, automatic labeling doesn't replace a manually applied label. It can replace a lower-priority automatically applied or default label, but not a higher-priority label.
1. If your organization intends to replace lower-priority manual labels, review **Additional label settings** and [existing-label behavior](/purview/apply-sensitivity-label-automatically#will-an-existing-label-be-overridden). Check other active policies too: a single policy's simulation doesn't resolve conflicts with them.
1. Check the specific protection or marking you expected. Auto-labeling policies don't add headers, footers, or watermarks to SharePoint and OneDrive documents. For email from outside your organization, label encryption isn't applied by default. If encryption is required, review **Apply encryption to email received from outside your organization** in the [policy settings](/purview/apply-sensitivity-label-automatically#creating-an-auto-labeling-policy).

Test intended configuration changes in simulation, then confirm the actual label and required protection on representative items after deployment. Don't remove protection just to make labeling succeed. If you're troubleshooting a label-removal policy, review its [encryption impact](/purview/apply-sensitivity-label-automatically#removing-or-downgrading-sensitivity-labels-with-an-auto-labeling-policy) before making changes.

### Numbers don't agree or Exchange activity is missing

Choose the view that answers your question before comparing totals.

1. Compare the policy, locations, and time period in each view. Simulation counts are estimates, not a count of successful label applications. The [Insights tab](/purview/auto-label-insights-tab) also contains metrics with different time ranges, such as **Total labeled to date** and recent activity.
1. For Exchange, don't use **Labeled items** or policy-level enforcement counts. Those views cover SharePoint and OneDrive files only. Open [Activity explorer](/purview/data-classification-activity-explorer), filter for **Sensitivity label applied**, and narrow by date, label, location, and item details. Check **How applied** for automatic application.
1. Allow for [Activity explorer reporting delay](/purview/data-classification-activity-explorer#when-activities-appear): for Exchange, SharePoint, and OneDrive, allow 60 to 90 minutes after the activity. This isn't a guaranteed availability time or a label-application deadline.

Use the resulting activity to confirm the label and how it was applied. Activity explorer doesn't identify the specific auto-labeling policy or rule that labeled an Exchange message.

If an enabled policy has stopped matching expected Exchange messages, check its scope and conditions and use newly sent or received messages to confirm the symptom. If it remains unexplained, contact Microsoft Support. Support can determine whether a rule failed to load; missing activity alone doesn't establish that cause. Follow [support-confirmed rule guidance](/purview/apply-sensitivity-label-automatically#policy-rule-fails-to-load) only after Support identifies the affected rule.

## Advanced troubleshooting and data collection

If the checks don't explain the result, contact Microsoft Support with a small, focused description:

- The policy status and affected location: SharePoint, OneDrive, or Exchange.
- What you expected and what you observed for one representative item.
- Relevant simulation or activity times, including the time zone.
- The exact error or failure reason, if one is shown, and checks already completed.

Share item or policy details only through your organization's approved support channel. Remove sensitive content and personal information from screenshots. Don't post files, message contents, or identifiers in public forums.

## Related content

- [Create or edit an auto-labeling policy](/purview/apply-sensitivity-label-automatically#creating-an-auto-labeling-policy).
- [Review simulation results before deployment](/purview/auto-label-simulation-results).
- [Monitor your policy after deployment](/purview/apply-sensitivity-label-automatically#monitoring-your-auto-labeling-policy).
