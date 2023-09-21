---
title: Words are not returned by an English word breaker
description: This article provides workarounds for the problem where a search by using an English word breaker doesn't return words that have leading decimal points in SQL Server 2017 on Windows, SQL Server 2016, 2014, and 2012.
ms.date: 09/09/2020
ms.custom: sap:Administration and Management
---
# Words that have leading decimal points aren't returned by an English word breaker in SQL Server

This article helps you resolve the problem where a search by using an English word breaker doesn't return words that have leading decimal points in SQL Server 2017 on Windows, SQL Server 2016, 2014, and 2012.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3191316

## Symptoms

In an English language word breaker, you use a full-text index to index content that contains words that have leading decimal points, such as `.325`, `.434`, and `.646`. When you try to locate rows in the index by searching on the decimal value (for example, `.325`), no rows are returned.

## Workaround

To work around this problem, use one of the following methods:

- Use the neutral word breaker.
- Put a zero in front of the decimal point when you use an English word breaker. For example, use `0.325` instead of `.325` in your search. The English word breaker correctly handles indexing and searching when it encounters leading zeros.

## Steps to reproduce the problem

1. Create a full-text index to create an index that contains words that have leading decimal points, such as `.325`, `.434`, `.646`, and so on.

2. Use the following full-text query to search on these values by using an English word breaker whose LCID is 1033:

    ```sql
    SELECT * FROM sys.dm_fts_parser('"Ring, .325 x .434 .646 Platinum"', 1033, 0,0)
    ```

    Results

    | keyword| group_id| phrase_id| occurrence| special_term| display_term| Notes |
    |---|---|---|---|---|---|---|
    |0x007700610073006800650072|1|0|1|Exact Match|Ring||
    |0x002E003300310033|1|0|2|Exact Match|.325|Keeps the decimal|
    |0x006E006E00300064003300310033|1|0|2|Exact Match|nn0d325||
    |0x0078|1|0|3|Noise Word|x||
    |0x006E006E003400330038|1|0|4|Exact Match|.434|Keeps the decimal|
    |0x006E006E003400330038|1|0|4|Exact Match|nn434||
    |0x003000340036|1|0|5|Exact Match|.646|Keeps the decimal|
    |0x006E006E00340036|1|0|5|Exact Match|nn46||
    |0x007300680069006D|1|0|6|Exact Match|Platinum||

3. Try to search on `.325` (including the decimal point):

    ```sql
    SELECT * FROM sys.dm_fts_parser('.325', 1033, 0,0) -- Using English word breaker to specify the ".325" search term.
    ```

    > [!NOTE]
    > We don't get a match.

    Results

    | keyword| group_id| phrase_id|occurrence| special_term| display_term| Notes |
    |---|---|---|---|---|---|---|
    |0x003300310033|1|0|1|Exact Match|325|Removes the decimal when searching and 325 <> .325, so no row returned|
    |0x006E006E003300310033|1|0|1|Exact Match|nn325||

    In this example, if you enter `.325` as the search value, no rows are returned. This is because we indexed the data by keeping the decimal point, but the English word breaker removes the decimal point during the search process. Therefore, we inadvertently search on 325 instead of `.325`, and no matches are found.

    Searching a full-text index by using an English word breaker for words that have leading decimal points works correctly if we use the neutral word breaker.

4. Run the following query by using the neutral word breaker:

    ```sql
    SELECT * FROM sys.dm_fts_parser('"Ring, .325 x .434 .646 Platinum"', 0, 0,0)
    ```

    Results

    | keyword| group_id| phrase_id| occurrence| special_term| display_term| Notes |
    |---|---|---|---|---|---|---|
    |0x007700610073006800650072|1|0|1|Exact Match|Ring||
    |0x002E003300310033|1|0|2|Exact Match|.325|Keeps the decimal|
    |0x006E006E00300064003300310033|1|0|2|Exact Match|nn0d325||
    |0x0078|1|0|3|Noise Word|x||
    |0x002E003400330038|1|0|4|Exact Match|.434|Keeps the decimal|
    |0x006E006E00300064003400330038|1|0|4|Exact Match|nn0d434||
    |0x002E003000340036|1|0|5|Exact Match|.646|Keeps the decimal|
    |0x006E006E00300064003000340036|1|0|5|Exact Match|nn0d646||
    |0x007300680069006D|1|0|6|Exact Match|Platinum||

    Now, searching on `.325` works as expected.

    ```sql
    SELECT * FROM sys.dm_fts_parser('.325', 0, 0,0) -- Specifying Neutral word breaker.
    ```

    Results

    | keyword| group_id| phrase_id| occurrence| special_term| display_term| Notes |
    |---|---|---|---|---|---|---|
    |0x002E003300310033|1|0|1|Exact Match|.325||
    |0x006E006E00300064003300310033|1|0|1|Exact Match|nn0d325||
