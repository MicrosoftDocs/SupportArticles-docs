---
title: Remove CEIP task from Dynamics GP
description: Describes the steps to remove the Customer Experience Improvement Program (CEIP) task from the Reminders window in Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: how-to
ms.date: 03/13/2024
---
# How to remove the Customer Experience Improvement Program (CEIP) task from Microsoft Dynamics GP

This article describes how to remove the Customer Experience Improvement Program (CEIP) task from the Reminders window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916997

## Introduction

The CEIP task appears after you install Microsoft Dynamics GP. CEIP collects information about how a customer uses Microsoft products and about any problems that customers experience.

To remove the CEIP task, use one of the following methods.

## Method 1

Follow these steps for each Microsoft Dynamics GP user:

1. Start Microsoft Dynamics GP.
2. On the **View** menu, select **Reminders**.
3. In the Reminders window, select the CEIP task, and then select **Task** on the **Open** menu.
4. In the Task window, select **Name**.
5. In the Customer Experience Improvement Program window, select an option, and then select **OK**.
6. In the Task window, select **Completed** in the **Status** list, and then select **Save**.

## Method 2

1. Open Microsoft SQL Query Analyzer or SQL Server Management Studio.
2. To delete the CEIP reminder, run the following script.

    ```sql
    delete from DYNAMICS..SY01403 where LinkTo = 2 and CmdID = 269 and CmdFormID = 1568 and CmdDictID = 0
    ```

3. To select all users not to participate in the CEIP program, run the following script.

    ```sql
    USE DYNAMICS
    set nocount on
    declare @Userid char(15)
    declare cCEIP cursor for 
    select A.USERID
    from SY01400 A left join SY01402 B on A.USERID = B.USERID and B.syDefaultType = 48
    where B.USERID is null or B.SYUSERDFSTR not like '1:%'
    open cCEIP
    while 1 = 1
    begin
    fetch next from cCEIP into @Userid
    if @@FETCH_STATUS <> 0 begin
    close cCEIP
    deallocate cCEIP
    break
    end
    
    if exists (select syDefaultType from DYNAMICS.dbo.SY01402 where USERID = @Userid and syDefaultType = 48)
    begin
    print 'adjusting ' + @Userid
    update DYNAMICS.dbo.SY01402 
    set SYUSERDFSTR = '1:'
    where USERID = @Userid and syDefaultType = 48
    end
    else begin
    print 'adding ' + @Userid
    insert DYNAMICS.dbo.SY01402 ( USERID, syDefaultType, SYUSERDFSTR )
    values ( @Userid, 48 , '1:' )
    end
    end /* while */
    set nocount off
    ```
