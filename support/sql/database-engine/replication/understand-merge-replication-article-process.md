---
title: Understand merge Replication article processing order
description: This article describes how to understand merge Replication article processing order.
ms.date: 01/25/2021
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
ms.reviewer: dansha
ms.topic: how-to
---
# Understand Merge Replication article processing order

This article introduces how to understand merge Replication article processing order.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 307356

## Summary

The Merge Agent follows a specific set of rules that govern the order in which the merge process applies changes to articles during the synchronization process.

This article discusses why article processing order is important.

## More information

There are two primary reasons why article processing order is important:

- In many instances, the Merge Agent must process changes to articles that participate in Declarative Referential Integrity (DRI) constraints in a specific order to attain optimal performance. If not, the Merge Agent may have to retry Data Manipulation Language (DML) operations it tried in an incorrect order (that is, try to INSERT a child row ahead of that of its parent).

- Applications that use triggers to maintain referential integrity require the Merge Agent to send changes in a specific order. If the Merge Agent sends changes in an incorrect order, the trigger will most likely rollback the change and the change does not propagate throughout the replication topology.

> [!NOTE]
> The Merge Agent can bypass FOREIGN KEY constraint evaluation and user trigger execution when it applies SQL DML change operations to a partner replica. For this to occur, the FOREIGN KEY constraint and the user trigger, or both, must have been created with the **NOT FOR REPLICATION** option. In both cases, the merge process assumes that SQL Server has evaluated the business logic successfully when it executes the original user-initiated change against the object, and that it does not have to reevaluate these conditions when it replicates the data to the partner replica. The primary benefit of using **NOT FOR REPLICATION** in this manner is increased performance. For more information about the NOT FOR REPLICATION option, and how to use it appropriately, see the **NOT FOR REPLICATION** option topic in SQL Server 2000 Books Online.

For the two reasons that were listed earlier, the order in which the Merge Agent delivers changes to a partner replica is important.

Before beginning a discussion of article processing order, it is important to have an understanding of two key concepts. The two key concepts are as follows:

- An article nickname.

- A generation.

Here is a description of the two concepts.

- Article Nicknames

    A nickname is an integer value that the Merge Agent uses to identify an article (a SQL Server table) to merge replication. The merge setup process assigns an article nickname when it adds the article to a merge publication. If an article participates in DRI constraints, the merge setup process tries to generate an article nickname that reflects defined DRI constraints. The merge process assigns tables referenced by a FOREIGN KEY constraint (a parent) a smaller article nickname than that of the referencing table (the child table, or the table on which the FOREIGN KEY constraint is defined).

    If a table does not participate in DRI constraints, the merge setup process assigns the article nickname based on the order in which it adds the article to the publication (in ascending order).

- Generation

A generation is an integer value that the Merge Agent uses to track a logical group of changes to a particular article. All of the changes made to a particular article at a particular replica between merge synchronizations are associated with the same generation. Each time the Merge Agent runs, it closes the existing open generation, and then opens a new generation with which to associate the next set of changes.

## Processing INSERTs, UPDATEs, and DELETEs

The Merge Agent partitions the articles for a particular publication into two distinct groups:

- The Merge Agent places articles that are not involved in any join filter relationships, and not related through DRI to any articles involved in join filters into one group.

- The Merge Agent places articles that are explicitly involved in join filter relationships, and articles related to join filter articles through DRI into a second distinct group.

The Merge Agent adds each article defined to the publication to only one of the preceding groups.

The Merge Agent uses the groups to determine the overall processing order of `UPDATEs`, `INSERTs`, and `DELETEs` for all articles defined to the publication.

In each of the two respective groups, the Merge Agent processes `INSERTs` and `UPDATEs` in ascending article nickname order, and processes `DELETEs` in descending article nickname order. First, the Merge Agent processes all `DELETEs` in their entirety in a particular group, followed by `UPDATEs` and `INSERTs` (also in a particular group). Conceptually, the Merge Agent appends the two aforementioned groups to one another (not merged) in the order listed previously. The Merge Agent begins by processing `DELETEs` for the first group, and then extends `DELETE` processing to the second group and the remainder of changes for the two groups are processed in parallel. Although the Merge Agent maintains article processing order in each respective group, the Merge Agent does not maintain strict article processing order across the two respective groups. As such, in the case of an `INSERT` or `UPDATE`, it is possible that changes from the first group with a higher article nickname can arrive ahead of those from the second group with a lower nickname. The converse situation can also occur for a `DELETE`. Both of these behaviors are by design.

## Possible effects of generation batching on article processing order

As stated earlier, with a generation you can logically group changes (`INSERTs`, `UPDATEs` and `DELETEs`) that occur for a particular article at a particular replica between synchronization sessions. Ultimately, the Merge Agent works with generations when it determines which changes it must exchange between two replicas. The Merge Agent negotiates a common generation at the following points in the synchronization process:

- Before it uploads changes from the subscriber to the publisher.

- Before it downloads changes from the publisher to the subscriber.

The Merge Agent uses this common generation as the starting point when enumerating the generations to send to a partner replica during the upload and download phases of merge synchronization.

The Merge Agent processes generations in batches, also referred to as generation batches. By default, 100 generations are included in each generation batch that the Merge Agent uploads to the publisher from the subscriber, or downloads to the subscriber from the publisher. The generation batch size is configurable through the `-UploadGenerationsPerBatch` and the `-DownloadGenerationsPerBatch` Merge Agent parameters, or through the Merge Agent profile. In the default case, if there are more than 100 generations that you need to exchange (that is, download and upload, or both) between a publisher (or a re-publisher) and a subscriber, the Merge Agent processes multiple generation batches. The number of batches depends on the number of generations that the Merge Agent has to exchange, and the generations per batch settings in-force for a particular merge session.

In a situation where multiple generation batches are exchanged, the Merge Agent may split related parent and child changes across two separate generation batches. If that is the case, the Merge Agent may deliver a child change in a generation batch ahead of the generation batch that contains the associated parent change. In hierarchical merge topologies that use re-publishers, there is one rare situation in which the splitting of parent and child changes across generation batches can lead to non-convergence. For more information about non-convergence, see the following article:

[Non-convergence when SQL Server processes child and parent generations in separate generation batches](https://support.microsoft.com/help/308266).  

You can increase the `-UploadGenerationsPerBatch` and the `-DownloadGenerationsPerBatch` parameters discussed previously to avoid splitting parent and child changes across generation batches.

Article processing order is maintained in a particular generation batch pursuant to the rules discussed previously. However, the Merge Agent cannot maintain article processing order across generation batches.
