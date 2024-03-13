---
title: How to uninstall Manufacturing if installed accidentally
description: Describes how to uninstall Manufacturing in Microsoft Dynamics GP if Manufacturing is installed accidentally.
ms.reviewer: theley, beckyber
ms.topic: how-to
ms.date: 03/13/2024
---
# How to uninstall Manufacturing in Microsoft Dynamics GP if Manufacturing is installed accidentally

This article describes how to uninstall Manufacturing in Microsoft Dynamics GP if Manufacturing is installed accidentally. When you uninstall Manufacturing, the following components are uninstalled:

- Tables
- Data
- Stored procedures

Additionally, all references to Manufacturing are deleted.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950742

To uninstall Manufacturing, follow these steps:

1. Insert Microsoft Dynamics GP 10.0 CD 1 into the CD drive.
2. In the **What do you want to do** list, select **Change Existing Installation**.
3. On the **Program Maintenance** page, select **Add/Remove Features**.
4. On the **Select Features** page, select **Entire feature will not be available** in the **Manufacturing** field.
5. Select **Next**.
6. On the **Install Program** page, select **Install**.
7. On the **Installation Complete** page, select **Finish**.
8. In the **Welcome to Microsoft Dynamics GP Utilities** dialog box, type the password, and then select **OK**.
9. On the **Welcome to Microsoft Dynamics GP Utilities** page, select **Next**.
10. On the **Upgrade Microsoft Dynamics GP** page, select **Next**.
11. On the **Additional Tasks** page, select **Launch Microsoft Dynamics GP**.
12. In the **Welcome to Microsoft Dynamics GP Utilities** dialog box, type the password, and then select **OK**.
13. In the **Company Login** dialog box, select **OK**.

    > [!NOTE]
    > If you are prompted to include new code, select **Yes**.
14. Exit Microsoft Dynamics GP.
15. Delete the Manufacturing triggers from each company in which Manufacturing is installed. To do this, follow these steps:

    1. Follow the appropriate step:

       - If you are using Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
       - If you are using Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
       - If you are using Microsoft SQL Server 2000 Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    2. Run the following statement against each company database in which Manufacturing is installed.

        ```console
        --BM010115
        drop trigger [dbo].[ SCSU0030Delete]
        drop trigger [dbo].[ MRP_BM010115_Delete]
        drop trigger [dbo].[ MRP_BM010115_Insert]
        drop trigger [dbo].[ MRP_BM010115_Update]
        
        --GL10000
        drop trigger [dbo].[mfg_delete_GL10000_record]
        
        --ICJC1002
        drop trigger [dbo].[ ICJC_DELETE_LINKS]
        
        --ICIV0323 
        drop trigger [dbo].[mfg_update_ICIV0323]
        
        --IS010001
        drop trigger [dbo].[ MRP_IS010001_Update]
        
        --IV10001
        drop trigger [dbo].[ICJC_IV_DELETE_LINKS]
        
        --IV00101
        drop trigger [dbo].[mfg_update_location_update]
        drop trigger [dbo].[mfg_remove_orphaned_records]
        drop trigger [dbo].[mfg_add_matching_item_records]
        drop trigger [dbo].[ MRP_IV00101_Delete]
        drop trigger [dbo].[ MRP_IV00101_Insert]
        drop trigger [dbo].[ MRP_IV00101_Update]
        
        --IV00102
        drop trigger [dbo].[mfg_insert_IV00102_location]
        drop trigger [dbo].[mfg_delete_IV00102]
        drop trigger [dbo].[ MRP_IV00102_Delete]
        drop trigger [dbo].[ MRP_IV00102_Insert]
        drop trigger [dbo].[ MRP_IV00102_Update]
        
        --IV00103
        drop trigger [dbo].[ MRP_IV00103_Delete]
        drop trigger [dbo].[ MRP_IV00103_Insert]
        drop trigger [dbo].[ MRP_IV00103_Update]
        
        --IV40700
        drop trigger [dbo].[ MRP_IV40700_Delete]
        
        --MOP1020 
        drop trigger [dbo].[MOP1020UpdateForScrap]
        drop trigger [dbo].[MOP1020UpdateLinks]
        drop trigger [dbo].[MOP1020UpdateROWID]
        
        --MOP1025
        drop trigger [dbo].[MOP1025UpdateROWID]
        
        --MOP1027
        drop trigger [dbo].[MOP1027UpdateROWID]
        
        --MOP1040
        drop trigger [dbo].[MOP1040UpdateLinks]
        drop trigger [dbo].[MOP1040UpdateParent_Component_ID]
        
        --MOP1900
        drop trigger [dbo].[MOP1410Insert]
        drop trigger [dbo].[MOP1410Update]
        drop trigger [dbo].[MOP1410Delete]
        
        --MP030000
        drop trigger [dbo].[ MRP_MP030000_InsertUpdateDelete]
        
        --MPSF1000
        drop trigger [dbo].[ MRP_BM010115_Delete]
        drop trigger [dbo].[ MRP_BM010115_Insert]
        drop trigger [dbo].[ MRP_BM010115_Update]
        
        --PK010033
        drop trigger [dbo].[mfg_insert_PK010033_record]
        drop trigger [dbo].[mfg_delete_PK010033_record]
        drop trigger [dbo].[mfg_update_PK010033_record]
        drop trigger [dbo].[mfg_update_and_insert_PK010033_record]
        drop trigger [dbo].[ MRP_PK010033_Delete]
        drop trigger [dbo].[ MRP_PK010033_Insert]
        drop trigger [dbo].[ MRP_PK010033_Update]
        
        --POP10100
        drop trigger [dbo].[ MRP_POP10110_Delete]
        drop trigger [dbo].[ MRP_POP10110_Insert]
        drop trigger [dbo].[ MRP_POP10110_Update]
        
        --POP10500
        drop trigger [dbo].[ MRP_POP10500_Insert]
        drop trigger [dbo].[ MRP_POP10500_Update]
        
        --SC020230
        drop trigger [dbo].[ MRP_SC020230_Delete]
        drop trigger [dbo].[ MRP_SC020230_Insert]
        drop trigger [dbo].[ MRP_SC020230_Update]
        --SOP10200
        drop trigger [dbo].[mfg_delete_SOP10200_record]
        drop trigger [dbo].[ MRP_SOP10200_Delete]
        drop trigger [dbo].[ MRP_SOP10200_Insert]
        drop trigger [dbo].[ MRP_SOP10200_Update]
        drop trigger [dbo].[ mfg_update_SOP10200_record]
        
        --SOP30200
        drop trigger [dbo].[remove_cost_rollup_records]
        drop trigger [dbo].[remove_comp_price_records]
        
        --SOP10100
        drop trigger [dbo].[mfg_delete_ICJC1002]
        
        --SOP10200
        drop trigger [dbo].[mfg_update_SOP10200_record]
        drop trigger [dbo].[ MRP_SOP10200_Delete]
        drop trigger [dbo].[ MRP_SOP10200_Insert]
        drop trigger [dbo].[ MRP_SOP10200_Update]
        
        --WO010032
        drop trigger [dbo].[DeleteSerialNumber]
        drop trigger [dbo].[ MRP_WO010032_Delete]
        drop trigger [dbo].[ MRP_WO010032_Insert]
        drop trigger [dbo].[ MRP_WO010032_Update]
        drop trigger [dbo].[ mfg_update_MO_status]
        drop trigger [dbo].[mfg_update_MO_status]
        
        --WO010302
        drop trigger [dbo].[WO010302UpdateROWID]
        
        --WO010515
        drop trigger [dbo].[WO010515UpdateROWID]
        
        --DYNAMICS.ACTIVITY
        USE [DYNAMICS] drop trigger [dbo].[mfg_delete_orphaned_MO_locks]
        ```

        > [!NOTE]
        > Manufacturing is deleted from the company databases when this statement finishes running.
