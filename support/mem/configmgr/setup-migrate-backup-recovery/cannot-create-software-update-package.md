---
title: Can't create software update packages or applications
description: Provides the steps to solve the issue that you can't create a software update package or application after Configuration Manager SQL Server site database is moved.
ms.date: 12/05/2023
ms.reviewer: kaushika, jchornbe, karanr
ms.custom: sap:Configuration Manager Database\Site Database Move
---
# Can't create a software update package or application after moving the site database

This article provides a solution for the issue that you cannot create a software update group, software update package, or application after you move the Configuration Manager SQL Server site database.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2709082

## Symptoms

After you move the Configuration Manager SQL Server site database to a different drive, and then you try to create a software update group, software update package, or application, the operation fails, and these log entries are logged in the SMSProv.log file:

> \*** \*** Unknown SQL Error! SMS Provider 14-03-2012 07:56:47 2016 (0x07E0)  
> \*~\*~\*** Unknown SQL Error! ThreadID : 2016 , DbError: 50000 , Sev: 16~\*~\* SMS Provider 14-03-2012 07:56:47 2016 (0x07E0)  
> *** [24000][0][Microsoft][SQL Server Native Client 10.0]Invalid cursor state SMS Provider 14-03-2012 07:56:48 2016 (0x07E0)  
> \*~\*~[24000][0][Microsoft][SQL Server Native Client 10.0]Invalid cursor state \*** Unknown SQL Error! ThreadID : 2016 , DbError: 0 , Sev: 0~\*~\* SMS Provider 14-03-2012 07:56:48 2016 (0x07E0)  

SQL Server Profiler provides the following additional details:

> An error occurred in the Microsoft .NET Framework while trying to load assembly id 65539. The server may be running out of resources, or the assembly may not be trusted with PERMISSION_SET = EXTERNAL_ACCESS or UNSAFE. Run the query again, or check documentation to see how to solve the assembly trust issues. For more information about this error:  
> System.IO.FileLoadException: Could not load file or assembly 'cryptoutility, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. An error relating to security occurred. (Exception from HRESULT: 0x8013150A)  
> System.IO.FileLoadException:  
> at System.Reflection.Assembly._nLoad(AssemblyName fileName, String codeBase, Evidence assemblySecurity, Assembly locationHint, StackCrawlMark& stackMark, Boolean throwOnFileNotFound, Boolean forIntrospection)  
> at System.Reflection.Assembly.InternalLoad(AssemblyName assemblyRef, Evidence assemblySecurity, StackCrawlMark& stackMark, Boolean forIntrospection)  
> at System.Reflection.Assembly.InternalLoad(String assemblyString, Evidence assemblySecurity, StackCrawlMark& stackMark, Boolean forIntrospection)  
> at System.Reflection.Assembly.Load(String assemblyString)

## Cause

This problem may occur if the SQL Server site database MDF and LDF files are moved to a different drive. For example, this problem may occur if the Configuration Manager site database is created on `C:\Program files\MSSQL server\data`, and then the MDF and LDF files are moved to `D:\CM2012DB` to save space.

> [!NOTE]
> This is a supported SQL Server operation. For more information, see [Move a Database Using Detach and Attach (Transact-SQL)](/previous-versions/sql/sql-server-2012/ms187858(v=sql.110)).

This problem occurs because the TRUSTWORTHY database property of the site database that is set to **ON** by default is reset to **OFF** when you detach and reattach the database. When the database is not configured to have the property set to **ON**, \<ConfigMgr_Install>\bin\x64\CryptoUtility.dll fails to load into SQL Server, and you receive the **invalid cursor state** error message that is mentioned in the Symptoms section.

## Resolution

To resolve this problem, follow these steps:

1. Manually reset the property to **ON** by running this command against your Configuration Manager database:

    ```sql
     ALTER DATABASE <ConfigMgr DB>
     SET TRUSTWORTHY ON
    ```

2. Make sure that the database that was moved is owned by the SA account.

3. Make sure that the Isolation Level value is set to **READ_COMMITTED_SNAPSHOT**. To check this value, run this command:

    ```sql
     DBCC USEROPTIONS
    ```

4. If the Isolation Level value is set to anything other than **READ COMMITTED SNAPSHOT**, run the following commands in the given order:

    ```sql
    ALTER DATABASE <ConfigMgr DB>
    SET ALLOW_SNAPSHOT_ISOLATION ON

    ALTER DATABASE <ConfigMgr DB>
    SET READ_COMMITTED_SNAPSHOT ON
    ```

> [!NOTE]
> You may have to change the SQL Server database to Single User mode before you run the commands in step 4. For more information about how to detach and attach a database in SQL Server, see [Database Detach and Attach (SQL Server)](/previous-versions/sql/sql-server-2012/ms190794(v=sql.110)?redirectedfrom=MSDN).

## More information

An iDNA (Time Travel) trace of the SQL Server process shows the following exception:

> Number of exceptions of this type:  3  
> Exception MethodTable: 000007fef2524e30  
> Exception object: 0000000201027798  
> Exception type: System.IO.FileLoadException  
> Message: Could not load file or assembly 'cryptoutility, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. An error relating to security occurred. (Exception from HRESULT: 0x8013150A)  
> InnerException: \<none>  
> StackTrace (generated):  
> SP IP Function  \
> 00000000204F8DC0 0000000000000001  
> System.Reflection.Assembly._nLoad(System.Reflection.AssemblyName, System.String,  
> System.Security.Policy.Evidence, System.Reflection.Assembly, System.Threading.StackCrawlMark ByRef, Boolean, Boolean)  \
> 00000000204F8DC0 000007FEF23DBF61  
> System.Reflection.Assembly.InternalLoad(System.Reflection.AssemblyName, System.Security.Policy.Evidence, System.Threading.StackCrawlMark ByRef, Boolean)  \
> 00000000204F8E50 000007FEF23DC127 System.Reflection.Assembly.InternalLoad(System.String, System.Security.Policy.Evidence, System.Threading.StackCrawlMark ByRef, Boolean)  \
> 00000000204F8EB0 000007FEF2443A54 System.Reflection.Assembly.Load(System.String)  \
> 00000000204F8EF0 000007FF002D9FF7  
> System.Data.SqlServer.Internal.SqlAppDomain.LoadRawAssembly(Char*, Int32, IntPtr ByRef,  
> System.Data.SqlServer.Internal.EClrReturnCode ByRef
