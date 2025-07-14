---
title: Slow performance of the spDeleteUpdate procedure
description: Resolves the slow performance issue when executing the `spDeleteUpdate` procedure.
ms.date: 02/11/2025
author: helenclu
ms.author: luche
ms.reviewer: kaushika, lamosley
ms.custom: sap:Software Update Management (SUM)\WSUS Database Maintenance
---
# The spDeleteUpdate stored procedure runs slowly

When the `spDeleteUpdate` stored procedure runs, it may take tens of seconds for it to delete a single update. When you use `spDeleteUpdate` to delete hundreds or thousands of updates during Windows Server Update Services (WSUS) maintenance, it may take days to finish.

## Cause

The slow performance occurs because a primary key isn't set on a temporary table that's created by `spDeleteUpdate`.

## Resolution

To fix the issue, run the following SQL script against the WSUS database (SUSDB) on every affected WSUS server. This script sets a primary key on the `@revisionList` temporary table.

```sql
USE [SUSDB]
GO

/****** Object:  StoredProcedure [dbo].[spDeleteUpdate]    Script Date: 11/2/2020 8:55:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
ALTER PROCEDURE [dbo].[spDeleteUpdate]
    @localUpdateID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
SAVE TRANSACTION DeleteUpdate
DECLARE @retcode INT
DECLARE @revisionID INT
DECLARE @revisionList TABLE(RevisionID INT PRIMARY KEY)
INSERT INTO @revisionList (RevisionID)
    SELECT r.RevisionID FROM dbo.tbRevision r
        WHERE r.LocalUpdateID = @localUpdateID
IF EXISTS (SELECT b.RevisionID FROM dbo.tbBundleDependency b WHERE b.BundledRevisionID IN (SELECT RevisionID FROM @revisionList))
   OR EXISTS (SELECT p.RevisionID FROM dbo.tbPrerequisiteDependency p WHERE p.PrerequisiteRevisionID IN (SELECT RevisionID FROM @revisionList))
BEGIN
    RAISERROR('spDeleteUpdate got error: cannot delete update as it is still referenced by other update(s)', 16, -1)
    ROLLBACK TRANSACTION DeleteUpdate
    COMMIT TRANSACTION
    RETURN(1)
END
INSERT INTO @revisionList (RevisionID)
    SELECT DISTINCT b.BundledRevisionID FROM dbo.tbBundleDependency b
        INNER JOIN dbo.tbRevision r ON r.RevisionID = b.RevisionID
        INNER JOIN dbo.tbProperty p ON p.RevisionID = b.BundledRevisionID
        WHERE r.LocalUpdateID = @localUpdateID
            AND p.ExplicitlyDeployable = 0
IF EXISTS (SELECT IsLocallyPublished FROM dbo.tbUpdate WHERE LocalUpdateID = @localUpdateID AND IsLocallyPublished = 1)
BEGIN
    INSERT INTO @revisionList (RevisionID)
        SELECT DISTINCT pd.PrerequisiteRevisionID FROM dbo.tbPrerequisiteDependency pd
            INNER JOIN dbo.tbUpdate u ON pd.PrerequisiteLocalUpdateID = u.LocalUpdateID
            INNER JOIN dbo.tbProperty p ON pd.PrerequisiteRevisionID = p.RevisionID
            WHERE u.IsLocallyPublished = 1 AND p.UpdateType = 'Category'
END
DECLARE #cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT t.RevisionID FROM @revisionList t ORDER BY t.RevisionID DESC
OPEN #cur
FETCH #cur INTO @revisionID
WHILE (@@ERROR=0 AND @@FETCH_STATUS=0)
BEGIN
    IF EXISTS (SELECT b.RevisionID FROM dbo.tbBundleDependency b WHERE b.BundledRevisionID = @revisionID
                   AND b.RevisionID NOT IN (SELECT RevisionID FROM @revisionList))
       OR EXISTS (SELECT p.RevisionID FROM dbo.tbPrerequisiteDependency p WHERE p.PrerequisiteRevisionID = @revisionID
                      AND p.RevisionID NOT IN (SELECT RevisionID FROM @revisionList))
    BEGIN
        DELETE FROM @revisionList WHERE RevisionID = @revisionID
        IF (@@ERROR <> 0)
        BEGIN
            RAISERROR('Deleting disqualified revision from temp table failed', 16, -1)
            GOTO Error
        END
    END
    FETCH NEXT FROM #cur INTO @revisionID
END
IF (@@ERROR <> 0)
BEGIN
    RAISERROR('Fetching a cursor to value a revision', 16, -1)
    GOTO Error
END
CLOSE #cur
DEALLOCATE #cur
DECLARE #cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT t.RevisionID FROM @revisionList t ORDER BY t.RevisionID DESC
OPEN #cur
FETCH #cur INTO @revisionID
WHILE (@@ERROR=0 AND @@FETCH_STATUS=0)
BEGIN
    EXEC @retcode = dbo.spDeleteRevision @revisionID
    IF @@ERROR <> 0 OR @retcode <> 0
    BEGIN
        RAISERROR('spDeleteUpdate got error from spDeleteRevision', 16, -1)
        GOTO Error
    END
    FETCH NEXT FROM #cur INTO @revisionID
END
IF (@@ERROR <> 0)
BEGIN
    RAISERROR('Fetching a cursor to delete a revision', 16, -1)
    GOTO Error
END
CLOSE #cur
DEALLOCATE #cur
COMMIT TRANSACTION
RETURN(0)
Error:
    CLOSE #cur
    DEALLOCATE #cur
    IF (@@TRANCOUNT > 0)
    BEGIN
        ROLLBACK TRANSACTION DeleteUpdate
        COMMIT TRANSACTION
    END
    RETURN(1)
GO
```
