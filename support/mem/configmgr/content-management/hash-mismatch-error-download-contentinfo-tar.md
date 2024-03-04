---
title: Hash mismatch error when downloading Contentinfo.tar
description: Describes an issue in which you receive a hash mismatch error when the Configuration Manager clients try to download the Contentinfo.tar file from cloud DPs that are assigned to multiple primary sites.
ms.date: 12/05/2023
ms.custom: sap:System Center Configuration Manager
ms.reviewer: kaushika
---
# Hash mismatch error when clients download Contentinfo.tar from cloud DPs that are assigned to multiple primary sites

This article provides the steps to solve the hash mismatch error that occurs when you try to download the Contentinfo.tar file from the cloud distribution points (DPs).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4458143

## Symptoms

Consider the following scenario:

- You have multiple cloud DPs in Configuration Manager. Each DP is assigned to a different primary site.
- The DP role isn't installed on the primary site server. Or, the DP role is installed on the primary site server, but the **Enable and configure BranchCache for this Distribution Point** option isn't enabled.
- The **BranchCache** feature is installed on the primary site servers. And **BranchCache** is enabled on client computers.

In this scenario, you receive hash mismatch error when clients try to download the Contentinfo.tar file from the cloud DPs. An error entry is logged in the ContentTransferManager.log file:

> CCTMJob::_ProcessContentInfo - failed to verify hash (algorithm ID = 32780, provider type = 24). Actual value - \<value1>, Computed value - \<value2>

## Cause

This issue occurs because the **BranchCache** key isn't synchronized across the primary site servers. When Package Transfer Manager uploads the Contentinfo.tar file to the cloud DPs, the file hash is different on each primary site because the **BranchCache** key is different.

## Resolution

To fix this issue, follow these steps:

1. Run the following SQL query on the central administration site to get the **BranchCache** key that each primary site should use:

    ```sql
    SELECT * FROM SC_Properties WHERE Name = 'BranchCacheKey'
    ```

2. Run the following command on each primary site to set the **BranchCache** key to the value that you get in step 1:

    ```sql
    netsh branchcache set key passphrase="<value>"
    ```

    > [!NOTE]
    > In this command, \<*value*> is the result that you get in step 1.

3. Redistribute all content to the cloud DPs so that the content is uploaded by having the correct hash values.
