---
title: Unable to open an Access database
description: Fixes a problem that occurs when you use the DAO library to convert a database that you created in Access 97 or an earlier version by using the CompactDatabase method.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: keithf
appliesto: 
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# "The database is in an unexpected state" error when you open a database in Access

This article fixes an issue that occurs when you use the DAO library to convert a database.

_Original KB number:_ &nbsp; 888634

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file. Requires basic macro, coding, and interoperability skills.

## Symptoms

When you try to open a database in Microsoft Access 2000 or a later version, you receive the following error message:

> The database is in an unexpected state

## Cause

This problem may occur when you use the Data Access Object (DAO) library to convert a database that you created in Microsoft Access 97 or an earlier version by using the `CompactDatabase` method. The
`CompactDatabase` method may leave the new database in a partially converted state.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Use the Convert Database command when you have the original database

If you still have a copy of the original database in its original format, use the `Convert Database` command. To do this, follow these steps:

#### Access 2000, Access 2002, or Access 2003

1. Make a backup copy of the original database.
2. Start Access 2000 or a later version.
3. On the **Tools** menu, click **Database Utilities**, click **Convert Database**, and then click **To Access 2000 File Format**.

   > [!NOTE]
   > If you are using Access 2000, only **To Current Access Database Version** appears on the **Convert Database** menu.

4. In the **Database to Convert From** dialog box, click the database file name that you want to convert, and then click **Convert**.
5. In the **Convert Database Into** dialog box, type the new name of the database file, and then click **Save**.

#### Access 2007

1. Make a backup copy of the original database.
2. Try to open that database.
3. When you open an Access 97 or Access 95 file format .mdb database, Access displays the **Database Enhancement** dialog box. You are prompted to upgrade the database.
4. Click **Yes** to upgrade the database to whichever file format you have selected as the default file format in Access 2007. After you convert the database, you can make design changes to the file in Access 2007. However, you can no longer open the database by using a version of Access earlier than the version to which you converted the database.

### Method 2: Recover the database data and the database queries when you do not have the original nonsecured database

If you do not have a copy of the original nonsecured database in its original format and you have tried standard corruption troubleshooting techniques, try to recover the database data and the database queries. To do this, follow these steps:

1. Make a backup copy of the original database.
2. Start Access 2000 or a later version.
3. Access 2000, Access 2002, or Access 2003
   - Click **Blank Access database**, type the new database name in the **File name** box, and then click **Create**.
   
   Access 2007
   - Click Office button, click **New**, click **Blank Database**, and then click **Create** to create a new blank database.

4. Access 2000, Access 2002, or Access 2003
   - On the **Insert** menu, click **Module**. The Microsoft Visual Basic Editor starts, and a new module is created.
  
   Access 2007
   - On the **Create** tab, click the down arrow below **Macro**, and then click **Module**. The Microsoft Visual Basic Editor starts, and a new module is created.
5. On the **Tools** menu, click **References**.
6. In the **Available References** list, locate **Microsoft DAO 3.6 Object Library**, and then click to select the **Microsoft DAO 3.6 Object Library** check box.

   > [!NOTE]
   > DAO 3.6 is also available on Windows XP Home Edition.

7. To close the **References** dialog box, click **OK**.
8. Paste the following code into the new module that you created.

   ```vb
   Sub RecoverCorruptDB()
    Dim dbCorrupt As DAO.Database
    Dim dbCurrent As DAO.Database
    Dim td As DAO.TableDef
    Dim tdNew As DAO.TableDef
    Dim fld As DAO.Field
    Dim fldNew As DAO.Field
    Dim ind As DAO.Index
    Dim indNew As DAO.Index
    Dim qd As DAO.QueryDef
    Dim qdNew As DAO.QueryDef
    Dim strDBPath As String
    Dim strQry As String

    ' Replace the following path with the path of the
    ' corrupted database.
    strDBPath = "C:\My Documents\yourDatabase.mdb"

    On Error Resume Next
    Set dbCurrent = CurrentDb
    Set dbCorrupt = OpenDatabase(strDBPath)

    For Each td In dbCorrupt.TableDefs
        If Left(td.Name, 4) <> "MSys" Then
            strQry = "SELECT * INTO [" & td.Name & "] FROM [" & td.Name & "] IN '" & dbCorrupt.Name & "'"
            dbCurrent.Execute strQry, dbFailOnError
            dbCurrent.TableDefs.Refresh
            Set tdNew = dbCurrent.TableDefs(td.Name)

    ' Re-create the indexes on the table.
            For Each ind In td.Indexes
                Set indNew = tdNew.CreateIndex(ind.Name)
                For Each fld In ind.Fields
                    Set fldNew = indNew.CreateField(fld.Name)
                    indNew.Fields.Append fldNew
                Next
                indNew.Primary = ind.Primary
                indNew.Unique = ind.Unique
                indNew.IgnoreNulls = ind.IgnoreNulls
                tdNew.Indexes.Append indNew
                tdNew.Indexes.Refresh
            Next
        End If
    Next

    ' Re-create the queries.
    For Each qd In dbCorrupt.QueryDefs
        If Left(qd.Name, 4) <> "~sq_" Then
            Set qdNew = dbCurrent.CreateQueryDef(qd.Name, qd.SQL)
        End If
    Next

    dbCorrupt.Close
    Application.RefreshDatabaseWindow
    MsgBox "Procedure Complete."
   End Sub
   ```

   > [!NOTE]
   > The code will try to import all tables and all queries from the corrupted database into the current database. Replace `C:\My Documents\yourDatabase.mdb` with the correct path and file name of your database.
9. To run the code, click **Run Sub/UserForm** on the **Run** menu.

### Method 3: Recover the database data when you do not have the original secured database

If you do not have a copy of the original secured database in its original format and you have tried standard corruption troubleshooting techniques, try to recover the database data. To do this, follow these steps:

1. Make a backup copy of the original database.
2. Start Access 2000 or a later version.
3. Access 2000, Access 2002, or Access 2003
   - Click **Blank Access database**, type the new database name in the **File name** box, and then click **Create**.
   
   Access 2007
   - Click the **Microsoft Office Button**, click **New**, click **Blank Database**, and then click **Create** to create a new blank database.
4. Access 2000, Access 2002, or Access 2003
   - On the **Insert** menu, click **Module**. The Microsoft Visual Basic Editor starts, and a new module is created.
   
   Access 2007
   - On the **Create** tab, click the down arrow below **Macro**, and then click **Module**. The Microsoft Visual Basic Editor starts, and a new module is created.

5. On the **Tools** menu, click **References**.
6. In the **Available References** list, locate **Microsoft DAO 3.6 Object Library**, and then click to select the **Microsoft DAO 3.6 Object Library** check box.
7. To close the **References** dialog box, click **OK**.
8. Paste the following code into the new module that you created.

   ```vb
   Option Compare Database

   Function BackupSecureDatabase()

    On Error GoTo Err_BackupSecureDatabase
    Dim wrkDefault As DAO.Workspace
    Dim dbsNew As DAO.Database
    Dim dbeSecure As DAO.PrivDBEngine
    Dim wrkSecure As DAO.Workspace
    Dim dbsSecure As DAO.Database
    Dim tdfSecure As DAO.TableDef
    Dim strSecureUser As String
    Dim strSecurePwd As String
    Dim strSecurePathToDatabase As String
    Dim strSecurePathToWorkgroupFile As String
    Dim strTableName As String
    Dim strSQL As String
    Dim dbsTemp As DAO.Database
    Dim strTempPathToDatabase As String
    Dim strBackupPathToDatabase As String
    Dim strLogPath As String
    Dim SourceRec As DAO.Recordset
    Dim DestRec As DAO.Recordset

    ' Set the variables (change for environment).
    strSecurePathToDatabase = "C:\MyDatabases\Northwind.mdb"
    strSecurePathToWorkgroupFile = "C:\MyDatabases\Secured.mdw"
    strSecureUser = "Administrator"
    strSecurePwd = "password"
    strTempPathToDatabase = "C:\MyDatabases\Temp.mdb"
    strBackupPathToDatabase = "C:\MyDatabases\Backup.mdb"
    strLogPath = "C:\MyDatabases\Backup.log"

    ' Open the log file.
    Open strLogPath For Output As #1
    Print #1, Time, "Log file opened"
    Print #1, Time, "Variables set"

    ' Delete old files.
    If Dir(strTempPathToDatabase) <> "" Then Kill strTempPathToDatabase
    If Dir(strBackupPathToDatabase) <> "" Then Kill strBackupPathToDatabase
    Print #1, Time, "Old backup files deleted"

    ' Create the new temp database.
    Set wrkDefault = DBEngine.Workspaces(0)
    Set dbsNew = wrkDefault.CreateDatabase(strTempPathToDatabase, dbLangGeneral)
    Set dbsNew = Nothing
    Print #1, Time, "Temp database created"

    ' Open the secured database.
    Set dbeSecure = New PrivDBEngine
    dbeSecure.SystemDB = strSecurePathToWorkgroupFile
    dbeSecure.DefaultUser = strSecureUser
    dbeSecure.DefaultPassword = strSecurePwd

    Set wrkSecure = dbeSecure.Workspaces(0)
    Set dbsSecure = wrkSecure.OpenDatabase(strSecurePathToDatabase)
    Print #1, Time, "Secured database opened from " & strSecurePathToDatabase

    ' Open the temp database.
    DBEngine(0).CreateUser
    Set dbsTemp = DBEngine(0).OpenDatabase(strTempPathToDatabase)

    Print #1, Time, "Temp database opened from " & strTempPathToDatabase

    ' Loop through the tables in the secured database.
    For Each tdfSecure In dbsSecure.TableDefs
       strTableName = tdfSecure.Name
       If Left(strTableName, 4) <> "MSys" Then
           Print #1, Time, "Export of " & strTableName
           ' Copy the table definition to the temp database.
           If CopyTableDef(tdfSecure, dbsTemp, strTableName) Then
               ' Then append all the data into the table.
                Set SourceRec = tdfSecure.OpenRecordset(dbOpenTable, dbReadOnly)
                Set DestRec = dbsTemp.OpenRecordset(strTableName)
                AppendRecordsFromOneRecordSetToAnother SourceRec, DestRec 
                SourceRec.Close
                DestRec.Close

           End If
       End If
    Next tdfSecure

    ' Close open objects.
    dbsSecure.Close
    Print #1, Time, "Secured database closed"
    dbsTemp.Close
    Print #1, Time, "Temp database closed"

    ' Compact the database into the backup database.
    DBEngine.CompactDatabase strTempPathToDatabase, strBackupPathToDatabase, dbLangGeneral
    Print #1, Time, "New backup database created at " & strBackupPathToDatabase

    ' Delete the temp database.
    If Dir(strTempPathToDatabase) <> "" Then Kill strTempPathToDatabase
    Print #1, Time, "Temp database deleted"
    Print #1, Time, "Log file closed"
    Close #1

   Exit_BackupSecureDatabase:

    Set wrkDefault = Nothing
    Set dbsNew = Nothing
    Set dbeSecure = Nothing
    Set wrkSecure = Nothing
    Set dbsSecure = Nothing
    Set tdfSecure = Nothing
    Set dbsTemp = Nothing
    Exit Function

   Err_BackupSecureDatabase:
      Print #1, Time, "     ***ERROR: " & Err.Number, Err.Description, strTableName
      Resume Next

   End Function

   Function CopyTableDef(SourceTableDef As TableDef, TargetDB As Database, TargetName As String) As Integer
   Dim SI As DAO.Index, SF As DAO.Field, SP As DAO.Property
   Dim T As DAO.TableDef, I As DAO.Index, F As DAO.Field, P As DAO.Property
   Dim I1 As Integer, f1 As Integer, P1 As Integer

    If SourceTableDef.Attributes And dbAttachedODBC Or SourceTableDef.Attributes And dbAttachedTable Then
     CopyTableDef = False
     Exit Function
    End If
    Set T = TargetDB.CreateTableDef(TargetName)

    ' Copy Jet Properties.
     On Error Resume Next
     For P1 = 0 To T.Properties.Count - 1
      If T.Properties(P1).Name <> "Name" Then
        T.Properties(P1).Value = SourceTableDef.Properties(P1).Value
      End If
     Next P1
    On Error GoTo 0

    ' Copy Fields.
      For f1 = 0 To SourceTableDef.Fields.Count - 1
       Set SF = SourceTableDef.Fields(f1)

       ' DAO 3.0 and later versions. ****
       If (SF.Attributes And dbSystemField) = 0 Then
        Set F = T.CreateField()
        ' Copy Jet Properties.
          On Error Resume Next
          For P1 = 0 To F.Properties.Count - 1
            F.Properties(P1).Value = SF.Properties(P1).Value
          Next P1
          On Error GoTo 0
        T.Fields.Append F
       End If ' Corresponding End If ****
    Next f1

   ' Copy Indexes.
    For I1 = 0 To SourceTableDef.Indexes.Count - 1
      Set SI = SourceTableDef.Indexes(I1)

   ' Foreign indexes are added by relationships.
      If Not SI.Foreign Then
        Set I = T.CreateIndex()
        ' Copy Jet Properties.
          On Error Resume Next
          For P1 = 0 To I.Properties.Count - 1
            I.Properties(P1).Value = SI.Properties(P1).Value
          Next P1
          On Error GoTo 0
        ' Copy Fields.
          For f1 = 0 To SI.Fields.Count - 1
            Set F = T.CreateField(SI.Fields(f1).Name, T.Fields(SI.Fields(f1).Name).Type)
            I.Fields.Append F
          Next f1
        T.Indexes.Append I
      End If
    Next I1

   ' Append TableDef.
    TargetDB.TableDefs.Append T

   ' Copy Access/User Table Properties.
    For P1 = T.Properties.Count To SourceTableDef.Properties.Count - 1
      Set SP = SourceTableDef.Properties(P1)
      Set P = T.CreateProperty(SP.Name, SP.Type)
      P.Value = SP.Value
      T.Properties.Append P
    Next P1

   ' Copy Access/User Field Properties.
    For f1 = 0 To T.Fields.Count - 1
      Set SF = SourceTableDef.Fields(f1)
      Set F = T.Fields(f1)
      For P1 = F.Properties.Count To SF.Properties.Count - 1
        Set SP = SF.Properties(P1)
        Set P = F.CreateProperty(SP.Name, SP.Type)
        P.Value = SP.Value
        F.Properties.Append P
      Next P1
    Next f1

   ' Copy Access/User Index Properties.
    For I1 = 0 To T.Indexes.Count - 1
      Set SI = SourceTableDef.Indexes(T.Indexes(I1).Name)

   ' Do not copy foreign indexes. They are created by relationships.
      If Not SI.Foreign Then
        Set I = T.Indexes(I1)
        For P1 = I.Properties.Count To SI.Properties.Count - 1
          Set SP = SI.Properties(P1)
          Set P = I.CreateProperty(SP.Name, SP.Type)
          P.Value = SP.Value
          I.Properties.Append P
        Next P1
      End If
     Next I1
    CopyTableDef = True
   End Function

   Function AppendRecordsFromOneRecordSetToAnother(SR As DAO.Recordset, DR As DAO.Recordset)
   Dim x As Integer

   Do While Not SR.EOF
   DR.AddNew
    For x = 0 To SR.Fields.Count - 1
        DR(x).Value = SR(x).Value
    Next x
   DR.Update
   SR.MoveNext
   Loop
   End Function
   ```

   > [!NOTE]
   > The code will try to import all tables from the corrupted database into a backup database. Replace the variables in the table after step 10 with your database file locations and your user settings.
9. In the list of functions, select **BackupSecureDatabase**.
10. To run the code, click **Run Sub/UserForm** on the **Run** menu.

    |Variable|Description|
    |-----|-----|
    |`strSecurePathToDatabase`|Location of secured database file|
    |`strSecurePathToWorkgroupFile`|Location of workgroup file|
    |`strSecureUser`|Secured user logon name|
    |`strSecurePwd`|Secured user logon password|
    |`strTempPathToDatabase`|Location of temporary database file|
    |`strBackupPathToDatabase`|Location of backup database file|
    |`strLogPath`|Location of log file|

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More Information

For more information about how to troubleshoot corruption in a Microsoft Access database, see the following article:

[Compact and repair a database](https://support.office.com/article/Compact-and-repair-a-database-6EE60F16-AED0-40AC-BF22-85FA9F4005B2)
