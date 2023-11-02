---
title: Can't make a remote connection from a CLR trigger
description: This article provides resolutions for problem where you may not be able to make a remote connection to SQL Server from a CLR trigger.
ms.date: 09/25/2020
ms.custom: sap:Database Design and Development
---

# You may not be able to make a remote connection to SQL Server from a CLR trigger

This article helps you resolve the problem where you may not be able to make a remote connection to SQL Server from a Common Language Runtime (CLR) trigger.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2000373

## Symptoms

When you deploy a CLR trigger that access data from a remote SQL Server using Windows authentication after impersonating the user account using `WindowsImpersonationContext`, you will get the following error message when the trigger is executed.

> Msg 6522, Level 16, State 1, Procedure mytrigger, Line 1  
 A .NET Framework error occurred during execution of user-defined routine or aggregate "mytrigger":  
 System.InvalidOperationException: Data access is not allowed in this context. Either the context is a function or method not marked with DataAccessKind.Read or SystemDataAccessKind.Read, is a callback to obtain data from FillRow method of a Table Valued Function, or is a UDT validation method.  
 System.InvalidOperationException:  
at System.Data.SqlServer.Internal.ClrLevelContext.CheckSqlAccessReturnCode(SqlAccessApiReturnCode eRc)  
at System.Data.SqlServer.Internal.ClrLevelContext.GetCurrentContext(SmiEventSink sink, Boolean throwIfNotASqlClrThread, Boolean fAllowImpersonation)  
at System.Data.SqlServer.Internal.ClrLevelContext.GetCurrentContext(Boolean throwIfNotASqlClrThread, Boolean fAllowImpersonation)  
at System.Data.SqlServer.Internal.ClrLevelContext.SuperiorTransaction.Promote()  
at System.Transactions.TransactionStatePSPEOperation.PSPEPromote(InternalTransaction tx)  
at System.Transactions.TransactionStateDelegatedBase.EnterState(InternalTransaction tx)  
at System.Transactions.EnlistableStates.Promote(InternalTransaction tx)  
at System.Transactions.Transaction.Promote()  
at System.Transactions.TransactionInterop.ConvertToOletxTransaction(Transaction transaction)  
at System.Transactions.TransactionInterop.GetExportCookie(Transaction transaction, Byte[] whereabouts)  
at System.Data.SqlClient.SqlInternalConnection.GetTransactionCookie(Transaction transaction, Byte[] whereAbouts)  
at System.Data.SqlClient.SqlInternalConnection.EnlistNonNull(Transaction tx)  
at System.Data.SqlClient.SqlInternalConnection.Enlist(Transaction tx)  
at System.Data.SqlClient.SqlInternalConnectionTds.Activate(Transaction transaction)  
at System.Data.ProviderBase.DbConnectionInternal.ActivateConnection(Transaction transaction)  
at System.Data.ProviderBase.DbConnectionPool.GetConnection(DbConnection owningObject)  
at System.Data.ProviderBase.DbConnectionFactory.GetConnection(DbConn...  
The statement has been terminated.

## Cause

This behavior is by design. CLR code executing inside SQL Server is always invoked in the context of the process account. When a CLR trigger that contains code to access data from a remote SQL server is executed, SQL Server automatically promotes the DML or DDL transaction to a distributed transaction and connects to the remote server using SQL Server identity. In case where `WindowsImpersonationContext` is used to impersonate the identity of the calling user, for connections to remote SQL Server, the promotion of the context transaction to a distribution transaction fails, resulting in the error mentioned in the [Symptoms](#symptoms) section.

## Resolution

If you require the functionality of impersonating the caller's identity inside a SQL CLR trigger, manage the transactions explicitly in your code. Use the `TransactionScopeOption.Supress` method to suppress inbuilt SQL transaction handling and manage the remote transaction with commit or rollback as per your requirements. Refer to the [Steps to reproduce](#steps-to-reproduce) section for an example on how you can reproduce this problem and for an example on how to use the previous method to resolve the issue.  

## Steps to reproduce

1. Open SQL Server Management Studio (SSMS), and then connect to your instance of SQL Server 2008.
1. Create a test database using the following script.

    ```sql
     CREATE DATABASE dbTriggerTest 
     GO 
     ALTER DATABASE dbTriggerTest SET TRUSTWORTHY ON 
     GO 
     USE dbTriggertest 
     GO 
     CREATE TABLE t(c1 int) 
     GO  
     sp_configure 'clr enabled', 1 
     GO  
     reconfigure 
     GO  
    ```

1. In Microsoft Visual Studio 2008, create a Visual C# project using the SQL Server Project template.
1. Name the project *SQLCLRTriggerProject*.
1. From the **Project** menu, select **SQLCLRTriggerProject** and configure the **Database** section to point to the database created earlier in the procedure (dbTriggerTest) and set the **Permission Level** to **External**.
1. From the **Project** menu, select **Add New Item**.
1. Select **Trigger** in the **Add New Item** dialog box.
1. Type a name for the new trigger.
1. Replace the code of the newly created trigger with the following code example.

    *Problematic code listing*:
  
    ```csharp
    using System; 
    using System.Data; 
    using System.Data.SqlClient; 
    using Microsoft.SqlServer.Server; 
    using System.Security.Principal;  
  
    public partial class Triggers 
    { 
        [Microsoft.SqlServer.Server.SqlTrigger(Name = "mytrigger", Target = "t", Event = "FOR insert")] 
        public static void mytrigger() 
        { 
            WindowsIdentity clientId = null; 
            WindowsImpersonationContext impersonatedUser = null;  
  
            // Get the client ID. 
            clientId = SqlContext.WindowsIdentity;  

            // This outer try block is used to thwart exception filter 
            // attacks which would prevent the inner finally 
            // block from executing and resetting the impersonation  
  
            try 
            { 
                try 
                { 
                    impersonatedUser = clientId.Impersonate(); 
                    if (impersonatedUser != null) 
                    { 
                        SqlConnection conn = new SqlConnection(@"Data Source=<Your server name>;Initial Catalog=master;Integrated Security=SSPI"); 
                        conn.Open(); 
                        SqlCommand cmd = conn.CreateCommand(); 
                        cmd.CommandText = "select * from sys.sysobjects"; 
                        cmd.CommandType = CommandType.Text; 
                        cmd.ExecuteNonQuery(); 
                    } 
                } 
                finally 
                { 
                    // Undo impersonation. 
                    if (impersonatedUser != null) 
                        impersonatedUser.Undo(); 
                } 
            } 
            catch 
            { 
                throw; 
            }  
        }  
    }  
    ```

1. Deploy the project to the database created in Step 2 using Deploy SQLCLR Trigger Project option in the **Build** menu.
1. Open SSMS and then connect to the instance of SQL Server 2008 where the trigger is deployed to.
1. You should see the following two items created under the test database `dbTriggerTest`:
   - Triggers - mytrigger
   - Assemblies - SQLCLRTriggerProject

1. Using the **Properties** pane of the assembly in SSMS, verify that the permission set on the `SQLCLRTriggerProject` assembly shows External access.

1. Run the following statement to reproduce the problem.
    `insert into t values (1)`

1. Replace the problematic code listing with the following code example to resolve the problem.

    *Fixed code listing:*  
  
    ```csharp
    using System; 
    using System.Data; 
    using System.Data.SqlClient; 
    using Microsoft.SqlServer.Server; 
    using System.Security.Principal; 
    using System.Transactions;  
  
    public partial class Triggers 
    {  
        [Microsoft.SqlServer.Server.SqlTrigger(Name = "mytrigger", Target = "t", Event = "FOR insert")] 
        public static void mytrigger() 
        {  
            using (new TransactionScope(TransactionScopeOption.Suppress)) 
            { 
                WindowsIdentity clientId = null; 
                WindowsImpersonationContext impersonatedUser = null; 
                // Get the client ID. 
                clientId = SqlContext.WindowsIdentity; 
                // This outer try block is used to thwart exception filter 
                // attacks which would prevent the inner finally 
                // block from executing and resetting the impersonation 
                try 
                { 
                    SqlTransaction tran = null;  
                    try 
                    { 
                        impersonatedUser = clientId.Impersonate(); 
                        if (impersonatedUser != null) 
                        {  
                            SqlConnection conn = new SqlConnection(@"Data Source=<Your server name>;Initial Catalog=master;Integrated Security=SSPI");  
                            conn.Open(); 
                            tran = conn.BeginTransaction(); 
                            SqlCommand cmd = conn.CreateCommand(); 
                            cmd.Transaction = tran; 
                            cmd.CommandText = "select * from sys.sysobjects"; 
                            cmd.CommandType = CommandType.Text; 
                            cmd.ExecuteNonQuery(); 
                            tran.Commit(); 
                        } 
                    } 
                    catch (Exception ex) 
                    { 
                        if (null != tran) 
                        tran.Rollback(); 
                        throw ex; 
                    }  
                    finally 
                    { 
                    // Undo impersonation. 
                    if (impersonatedUser != null) 
                    impersonatedUser.Undo(); 
                    } 
                } 
                catch 
                { 
                    throw; 
                }  
            }  
        }
    }
    ```
