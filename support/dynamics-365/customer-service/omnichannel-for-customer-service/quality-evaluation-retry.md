---
title: Quality Evaluation Agent Errors and Recommended Actions
description: Troubleshoot failed quality evaluations by checking AI agent errors, locating failed records, and deciding whether to retry or contact support.
ms.reviewer: deepabansal, sdas
ai-usage: ai-assisted
ms.topic: how-to
ms.collection: CEnSKM-ai-copilot
ms.update-cycle: 180-days
ms.date: 07/30/2026
ms.custom: sap:Customer Service Admin Center (CSAC)\Issue with Quality Evaluation Agent (QEA)
---

# Troubleshoot failed quality evaluations

## Summary

Quality evaluations can fail when the AI agent can't complete processing. Error details help supervisors and administrators identify the cause, decide whether to retry the evaluation, and choose the next steps.

## Quality evaluation failure causes

Quality evaluations can fail for several reasons, including:

- Missing metadata for the record being evaluated.
- Network or connectivity issues.
- Temporary internal service interruptions.
- Missing user permissions.
- Invalid evaluation configurations.
- Disabled flows.
- An unpublished Quality Evaluation Agent.

Some failures are temporary and can be resolved by retrying the evaluation. Other failures require administrative action before you retry.

## Review evaluation errors

When an evaluation fails, the **AI agent status** is set to **Error**.

To review the failure reason, add the **Error details** column to the evaluation grid view. This column displays detailed error information that helps you understand why the evaluation failed.

For bulk evaluation runs, the run history includes a **Records failed** column. Use this column to identify the failed records in the evaluation run. The evaluation list associated with the run displays relevant error messages for records that encountered issues.

## Retry failed evaluations

You can retry failed evaluations from the evaluation grid or from the evaluation list associated with a bulk evaluation run.

Retry failed evaluations only when the error can be resolved through reprocessing, such as temporary service issues or connectivity interruptions.

When you retry an evaluation:

- The original evaluation configuration is reused.
- The existing evaluation record is overwritten.
- The original **Created On** date remains unchanged.
- The **Modified On** and **Requested By** fields are updated automatically.
- The evaluation expiration date can be changed.

If a newer version of the evaluation criteria exists, the retry continues to use the originally referenced criteria version. The system doesn't automatically upgrade or replace the criteria version. This behavior helps maintain consistency with the original evaluation context.

## Review retry results

After you retry a failed evaluation:

- If the retry succeeds, the **AI agent status** changes to **Complete**.
- If the retry fails, the **AI agent status** remains as **Error**. The error reason is updated with the latest message, and a notification indicates that the retry was unsuccessful.

## Error codes and recommended actions

| Error code | Error details | Recommended action |
| --- | --- | --- |
| 424000 | Agent not Published | Ask an administrator to publish the Quality Evaluation Agent in Copilot Studio. Don't retry the evaluation until the agent is published. |
| 429000 | Too Many Requests | The system is temporarily experiencing high demand. Retry the evaluation later. |
| 500001 | Internal server error. Contact Microsoft Support. | Contact Microsoft Support. Retry the evaluation if advised. |
| 400001 | Cross-Geo Data Movement Disabled | Cross-geo data movement isn't enabled. Contact your system administrator to enable the setting before retrying the evaluation. |
| 403000 | Authentication Issue - Missing Privileges | The user doesn't have the required permissions to run the evaluation. Contact your system administrator. Don't retry until the required access is granted. |
| 404000 | Source record missing data | The source record can't be found or accessed. The record might be deleted or might not be within the accessible business unit. Contact your system administrator before retrying the evaluation. |
| 400031 | Input configuration incorrect. Contact administrator. | The evaluation configuration is invalid. Contact your system administrator. Don't retry until the configuration is corrected. |
| 500012, 500024 | Internal server error. Contact Microsoft Support. | Contact Microsoft Support. Retry the evaluation if advised. |

## Next steps

- Monitor evaluation run history to identify failed records.
- Review error details before retrying an evaluation.
- Contact your administrator or Microsoft Support when the error message indicates that reprocessing won't resolve the issue.

## Related content

- [Use evaluation plan](/dynamics365/contact-center/use/evaluation-plan)
- [Use on-demand evaluation](/dynamics365/contact-center/use/on-demand-evaluation)
- [Use evaluation criteria](/dynamics365/contact-center/use/evaluation-criteria)
- [Use evaluations](/dynamics365/contact-center/use/use-evaluations)
