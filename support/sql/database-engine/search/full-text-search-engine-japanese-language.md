---
title: Considerations when using the Full-Text
description: This article describes the considerations that apply when you use the SQL Server Full-Text Search engine for the Japanese language.
ms.date: 01/15/2021
ms.custom: sap:Administration and Management
ms.reviewer: kayokon
ms.topic: article 
---
# Considerations when you use the SQL Server Full-Text search engine for the Japanese language

This article describes the considerations that apply when you use the SQL Server Full-Text Search engine for the Japanese language.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2252955

## Introduction

In the Japanese language, a phrase may consist of two or more words without spaces between those words. In Microsoft SQL Server, when you use the SQL Server Full-Text search engine to perform a prefix search for a Japanese phrase, the Full-Text search engine does not consider the phrase to be a prefix term. Instead, the Full-Text search engine considers the phrase to be word terms. This is because a word is defined as a string of characters without spaces or punctuation. Additionally, the search engine works only in the prefix-matching mode. The search engine does not work in the suffix-matching mode.

## More information

For example, you create a table and insert some Japanese phrases by running the following statements in SQL Server:

```sql
CREATE TABLE test(c1 int PRIMARY KEY,c2 nvarchar(255))

INSERT test VALUES(1,N'添付テスト')
INSERT test VALUES(2,N'Fw: テスト')
INSERT test VALUES(3,N'KK-Information:テスト')
INSERT test VALUES(4,N'[Q] ポリシーテスト')
INSERT test VALUES(5,N'KK-Information:タイトルフィルタテスト２')
INSERT test VALUES(6,N'テスト')
INSERT test VALUES(7,N'フィルタテスト３')
INSERT test VALUES(8,N'テストフィルタ１')
INSERT test VALUES(9,N'RE: テストメール')
INSERT test VALUES(10,N'テストメール')
INSERT test VALUES(11,N'White Listテスト')
INSERT test VALUES(12,N'フィルタリングテスト')

CREATE FULLTEXT CATALOG test AS DEFAULT;
GO

CREATE FULLTEXT INDEX ON test(c2) KEY INDEX PK__<IndexName>;
GO
```

Then, you run the following three queries:

- Query 1

    ```sql
    SELECT * FROM test WHERE CONTAINS(c2, N'テスト')
    ```

    The result of Query 1 is as follows:

    > c1c2
    >
    > 2Fw: :::no-loc text="テスト":::  
    3KK-Information::::no-loc text="テスト":::  
    6:::no-loc text="テスト":::

- Query 2

    ```sql
    SELECT * FROM test WHERE CONTAINS(c2, 'テスト*')
    ```

    The result of Query 2 is as follows:

    > c1c2  
    2 Fw: :::no-loc text="テスト":::  
    3 KK-Information::::no-loc text="テスト":::  
    6 :::no-loc text="テスト":::  
    8 :::no-loc text="テストフィルタ１":::  
    9 RE: :::no-loc text="テストメール":::  
    10 :::no-loc text="テストメール":::  

- Query 3

    ```sql
    SELECT * FROM test WHERE CONTAINS(c2, '*テスト*')
    ```

    The result of Query 3 is as follows:

    > c1c2  
    2 Fw: :::no-loc text="テスト":::  
    3 KK-Information::::no-loc text="テスト":::  
    6 :::no-loc text="テスト":::  
    8 :::no-loc text="テストフィルタ１":::  
    9 RE: :::no-loc text="テストメール":::  
    10 :::no-loc text="テストメール":::

    From the results of the queries, you can find that the result of Query 2 is the same as the result of Query 3 because the Full-Text query does not work in the suffix-matching mode. Additionally, **:::no-loc text="テスト":::** is a token that differs from **:::no-loc text="ポリシーテスト":::** or from **:::no-loc text="テスト":::** in the matchings.

    To tokenize phrases, a word breaker for the language family must be used. Work breakers use spaces and other signs to recognize phrases. Therefore, some phrases cannot be recognized by the word breaker and cannot be searched by using Full-Text engine in the Japanese language. For more information about word breakers, see the **Word Breakers and Stemmers** topic in the **Reference** section.

    The best practice to use the Full-Text search engine in the Japanese language is to test the phrases to see whether the phrases are affected by the limitation. If a phrase consists of words without spaces, you cannot use the Full-Text functionality to search the phrase. Instead, you can use the LIKE keyword together with wildcard characters. However, the performance of the `like` operation is lower than the performance of the Full-Text searching. You must consider the performance effect for your application.

    The following are some sample queries of the `like` keyword to search for phrases.

- Query 4

    ```sql
    SELECT * FROM test WHERE c2 like 'テスト%'
    ```

    The result is as follows:

    > c1c2  
    6 :::no-loc text="テスト":::  
    8 :::no-loc text="テストフィルタ１":::  
    10 :::no-loc text="テストメール":::

- Query 5

    ```sql
    SELECT * FROM test WHERE c2 like '%テスト%'
    ```

    The result is as follows:

    > c1c2  
    1 :::no-loc text="添付テスト":::  
    2 Fw: :::no-loc text="テスト":::  
    3 KK-Information::::no-loc text="テスト":::  
    4 [Q] :::no-loc text="ポリシーテスト":::  
    5 KK-Information::::no-loc text="タイトルフィルタテスト２":::  
    6 :::no-loc text="テスト":::  
    7 :::no-loc text="テスト":::フィルタテスト３  
    8 :::no-loc text="テスト":::テストフィルタ１  
    9 RE: :::no-loc text="テスト":::テストメール  
    10 :::no-loc text="テスト":::テストメール  
    11 :::no-loc text="テスト":::  
    12 :::no-loc text="フィルタリングテスト":::

> [!NOTE]
> If you use the Full-Text search engine in SQL Server, you can find more information about the content of a full-text index by using the following query:

```sql
SELECT * FROM sys.dm_fts_index_keywords(db_id('test'), object_id('test'))
GO
```

The result is as follows:

> keyword display_term column_id document_count  
0x00660077 fw 2 1  
0x0069006E0066006F0072006D006100740069006F006E information 2 2  
0x006B006B kk 2  
0x006C00690073007430C630B930C8 listテスト 2 1  
0x00770068006900740065 white 2 1  
0x30BF30A430C830EB30D530A330EB30BF30C630B930C80032 タイトルフィルタテスト2 2 1  
0x30C630B930C8 テスト 2 3  
0x30C630B930C830D530A330EB30BF0031 テストフィルタ1 2 1  
0x30C630B930C830E130FC30EB テストメール 2 2  
0x30D530A330EB30BF30C630B930C80033 フィルタテスト3 2 1  
0x30D530A330EB30BF30EA30F330B030C630B930C8 フィルタリングテスト 2 1  
0x30DD30EA30B730FC30C630B930C8 ポリシーテスト 2 1  
0x6DFB4ED830C630B930C8 添付テスト 2 1  
0xFF END OF FILE 2 12  
(14 row(s) affected)

In the sample result, only three rows contain the word **:::no-loc text="テスト":::." The Full-Text search engine treats the word ":::no-loc text="テスト":::" as a different token from the word ":::no-loc text="テストメール":::**.
For more information about the SQL Server Full-Text search engine, visit the following Microsoft websites:

- [Full-Text Search](/sql/relational-databases/search/full-text-search)
- [Supported Forms of Query Terms (Full-Text Search)](/previous-versions/sql/sql-server-2008-r2/cc879300(v=sql.105))
- [Configure & manage word breakers & stemmers for search (SQL Server)](/sql/relational-databases/search/configure-and-manage-word-breakers-and-stemmers-for-search)
- [How Search Query Results Are Ranked (Full-Text Search)](/previous-versions/sql/sql-server-2008-r2/ms142524(v=sql.105))
- [CONTAINS (Transact-SQL)](/sql/t-sql/queries/contains-transact-sql)
- [sys.dm_fts_index_keywords (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-fts-index-keywords-transact-sql)
- [SQL Server Customer Advisory Team](/archive/blogs/sqlcat/)
