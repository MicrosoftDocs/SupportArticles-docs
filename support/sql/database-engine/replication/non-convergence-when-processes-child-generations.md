---
title: Non-convergence when SQL Server processes child generations
description: This article provides workarounds for the Non-convergence problem that occurs when SQL Server processes child and parent generations in separate generation batches.
ms.date: 01/20/2021
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
---
# Non-convergence when SQL Server processes child and parent generations in separate generation batches

This article helps you resolve the Non-convergence problem that occurs when SQL Server processes child and parent generations in separate generation batches.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 308266

## Symptoms

A loss of INSERT commands into child tables at a subscriber may occur under the following conditions:

- The merge replication topology is hierarchical, with a publisher, one or more republishers, and one or more subscribers.
- One or more parent and child articles exist in a merge replication publication, with a join filter defined between them.
- A `NOT FOR REPLICATION` foreign key constraint exists at the republisher and subscriber for the relationship between these two articles.
- INSERTs into a child article occur in a generation separate from its associated parent generation by more than the value specified in the `-DownloadGenerationsPerBatch` merge agent parameter. So, the merge agent processes the child generation in a batch of generations separate from its associated parent generation.
- There is an interruption of merge processing between the publisher and republisher and between the processing of the child and parent generation batches.

## Workaround

The merge replication architecture does not provide a mechanism to keep parent and child changes together across generation batch boundaries. To work around this problem, you can either:

- Increase the `-UploadGenerationsPerBatch` and `-DownloadGenerationsPerBatch` Merge Agent parameters to their maximum value of 2000, which virtually eliminates the possibility of processing a child article's generation in a batch separate from the parent article's generation.

-OR-

- Remove the `NOT FOR REPLICATION` property on the foreign-key constraints at the republisher. In this case, the Merge Agent is not able to insert rows into the child article because there are no associated parent-article rows. Keep in mind, however, that there could be performance degradation associated with this change. If the Merge Agent is unable to insert these child rows, those changes must be *retried*. The Merge Agent retry process is much less efficient than its normal mode of batch processing.

## More information

Here is a more detailed sequence of events under which this problem can occur. The default values for the `-UploadGenerationsPerBatch` and `-DownloadGenerationsPerBatch` Merge Agent parameters (which bear heavily on this problem) are 100. In the following example, assume that the `-UploadGenerationsPerBatch` and `-DownloadGenerationsPerBatch` parameters have not been altered.

- INSERTs occur at the top-level publisher into a child and a parent article. A child article is any article in a publication that has a foreign-key constraint to another table, referred to as a parent article. These two articles are related by a merge replication join filter and the actual server-side foreign key constraints at the republisher and subscriber are marked with the NOT FOR REPLICATION property. You can execute the **sp_help** stored procedure on the tables to determine whether the constraints are not for replication, if you are unsure.
- The INSERTs into the child table occur (for example) in generation 110. The INSERTs into the parent table occur (for example) in generation 250. The separation between these generations is greater than the `-DownloadGenerationsPerBatch` parameter.
- The publisher-republisher Merge Agent processes the batch of generations that contain generations 101 to 200. After successful processing of this batch, and a download of the associated changes in those generations to the republisher, the publisher-republisher Merge Agent is interrupted. The interruption occurs before the Merge Agent can process generations 201 to 300 (containing the parent-article changes). The interruption may be due to loss of network connectivity, a query timeout, and so forth. The Merge Agent can commit the child-article rows without the parent rows because the server-side foreign-key constraint is marked as NOT FOR REPLICATION, thereby "suspending" the check of the constraint.
- Before the publisher-republisher Merge Agent begins processing again, the republisher-subscriber Merge Agent begins a merge session. It begins the process of downloading changes from the republisher.
- When the republisher-subscriber Merge Agent processes generation 110 (the child article INSERTs), it evaluates the join filter present between the child article and the parent article. Because the parent-article changes have not yet arrived at the republisher, the Merge Agent determines that these child INSERTs do not "qualify" the join filter. The Merge Agent downloads the **MSmerge_genhistory** row that represents generation 110, but none of the changes in that generation. This Merge Agent completes its session successfully.
- A subsequent run of the Merge Agent between the publisher and republisher successfully processes the batch of generations that contain the parent-article INSERTs (generations 201 to 300) and commits those changes at the republisher.
- Finally, a subsequent Merge Agent session between the republisher and subscriber considers generation 250 and downloads the parent-article INSERTs to the subscriber. However, because the subscriber also knows generation 110 (the child article's generation), the Merge Agent does not re-evaluate the child article's partition.

This results in the correct parent-article rows being present at the subscriber with `orphaned` child rows at the republisher.
