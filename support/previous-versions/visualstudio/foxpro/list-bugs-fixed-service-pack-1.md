---
title: List of bugs that are fixed in Service Pack 1
description: This article provides details about the release and the bugs fixed in Visual FoxPro 9.0 Service Pack 1.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.reviewer: TrevorH
ms.prod: visual-studio-family
---
# List of bugs that are fixed in Microsoft Visual FoxPro 9.0 Service Pack 1

This article provides details about the release and the bugs fixed in Visual FoxPro 9.0 Service Pack 1.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 907737

## Summary

This article contains information about the bugs that are fixed in Microsoft Visual FoxPro 9.0 Service Pack 1 (SP1). For more information, see [How to obtain Service Pack 1 for Visual FoxPro 9.0](https://support.microsoft.com/help/906478).  

Visual FoxPro (VFP) 9.0 SP1 contains fixes for the following problems.

## Control and classes

- Cannot use mouse to get focus to other controls from the DHTML control.
- Wizard-generated forms fail when you try to add a record if the underlying table has AutoInc field(s).
- Web Browser control: implementing DWebBrowserEvents2 causes parameter count mismatch.
- Saving form to an in-use file causes eventual fatal exception.
- Fatal exception occurs when building a project that contains VCX with properties that are separated by only carriage returns.
- Collections: Removing items from collection with >=500 items crashes VFP under Application Verifier.
- CursorAdapter: TABLEUPDATE(0) ignores SendUpdate setting for table buffered cursor.
- TextBox: C0000005 exception with AutoComplete TextBox where TextBox has ControlSource set to a field which allows NULLs.
- ComboBox: "Data type mismatch" error message when setting value in drop-down when ControlSource is null member property.
- Fatal exception error occurs with MODI FORM command when MSXML3.dll file is not registered.
- SEARCH function in Wizard-generated forms does work with new VFP9 data types. The search does not find varchar data.
- Control class does not resize anchored controls within itself.
- QUIT fired in DESTROY of form does not close VFP or application.
- READ of converted form is released in VFP 9.0, but not in earlier versions of VFP.
- Grid loses data when selected alias is changed from one populating grid to alias of the same table used again, and a CALCULATE command is used against the second alias.
- C0000005 exception pressing ENTER key when ListBox ListIndex = 0.
- Unexpected Anchor behavior for values 256/512 and odd Width/Height.
- Form: Internal Consistency error and then fatal exception occur when you edit form after adding relation to DataEnvironment of form using aselobj() reference.
- IMPLEMENTS failed with Word. Application object with Office 2003.
- Grid goes blank when custom method of parent formset is set as ControlSource of a grid column.
- ActiveX Controls: LeadTools ActiveX control makes two empty bars appear in Window menu.
- CheckBox: Graphical CheckBox and option button do not appear with darker back color when depressed with themes enabled.
- "Internal Consistency" error message working with a class library that is stored in a hidden folder.
- ComboBox: DownClick( ) does not fire unless user first passes mouse over contents of drop-down list.
- Pageframe with TabStretch=0 (multiple) and with many tabs keeps growing when form is opened for edit.
- Add support for adVarNumeric for ADO data source.
- Refresh problems on PageFrame in FormSet causes TextBox ghosting.
- Refresh issues with various controls on a form when .exe is run over network (UNC or mapped drive).
- Value for drop-down list style ComboBox does not appear in Accessible Event Viewer.
- Orphaned form DataEnvironment causes VFP to crash when exited.
- "Internal Consistency" error message when Ctrl+Tab off is disabled page on pageframe.
- A formset object exhibits memory corruption of user properties the second time it is run after a CLEAR ALL.
- "Internal Consistency" error message when modifying or running a form with object having invalid Zorder setting.
- Toolbar not active with Modal Form inside Top Level Form.
- Grid: "Data type mismatch" error message 9 editing a DOUBLE field through grid or browse.
- Top Level forms with contained modal form should be resizable and movable.
- "Internal Consistency" error message setting value property in init of control in grid column.
- "Internal Consistency" error message clicking relation in data environment window with persistent relation on compound index key.
- CursorAdapter: Base table names are converted to lowercase in auto-generated SQL.
- "Internal Consistency" error message in bound autocomplete TextBox if form uses private datasession.
- EditBox wordwrap causes blank lines to disappear.

## Engine

- Data engine no longer optimizes some queries involving DELETED() function and OR clauses.
- Indexes on STR() are not Rushmore optimized with SET ANSI OFF.
- TOP N in subquery is ignored when UNION is used.
- Memo values are not translated when copied between tables with different code pages (SQL SELECT, APPEND FROM).
- Fatal exception with REPLACE with undefined variable if row validation rule is present.
- Hang occurs when UNLOCK is executed.
- "Internal Consistency" error message accessing free table in transaction if table is made transactable in different data session.
- Requery() on prepared remote view fails.
- LOCATE fails to find a match when index on Currency is used for optimization and the right part of comparison is certain Numeric value.
- USE command can assign duplicate alias for the work area.
- Unexpected error message "Table has a file length / record count inconsistency" on END TRANSACTION.
- Unexpected "SQL expression is too complex" error message on CREATE SQL VIEW against large tables.
- Reopening or FLUSH of table after ZAP with SET TABLEVALIDATE >= 8 causes "Table ... has become corrupted" error message.
- SQL SELECT returns incorrect result when correlated sub-query returning COUNT(*) is compared with 0.
- Data corruption when CursorAdapter that is bound to Grid is updated in a TRANSACTION.
- Unexpected "SQL: Error correlating fields" error message with two EXISTS subqueries.
- Correlation is not verified to meet "correlation is supported only to immediate parent query" limit.
- Unexpected "Subquery returned more than one record" error message when aggregate is used in HAVING, but not in SELECT list.
- Query returns incorrect result when ORDER BY+TOP N evaluation is merged with GROUP BY evaluation and TOP is optimized.
- SELECT COUNT(ICASE(.T.,1)) returns incorrect result.
- SELECT INTO ARRAY changes current work area if it uses sub-query in FROM.
- Index on table buffered cursor is corrupted after REPLACE with scope.
- A Query with OUTER JOIN produces incorrect result if NOT EMPTY(...) is used in WHERE.
- Unexpected "SQL expression is too complex" error message with correlated subquery.
- "Microsoft Visual C++ Runtime Library Buffer overrun detected!" and C0000005 exception running SCAN loop against large table.
- CAST() to date of a blank datetime field returns datetime type.
- ALTER TABLE ... ALTER COLUMN to change character field to integer also changes value.
- "Error building key for index..." error message when indexing using str() on a NULL value.
- "Internal Consistency" error message on REQUERY() after tableupdate() to remote view with batchupdatecount = -1 and table buffering.
- "Internal Consistency" error message on SQL SELECT when record size * record count is high.
- Enable optimization for tables with non-current code page when ENGINEBEHAVIOR < 90.
- "Internal Consistency" error message when indexing with a nested collection filter.
- Filter condition that temporarily changes current work area may break relation, or may break nested XML generation with XMLAdapter.
- Query processor fails to find column in SELECT list if it is enclosed in parentheses and reports false "SQL: ORDER BY clause is invalid" error message.
- Unexpected "SQL: GROUP BY clause is missing or invalid" error message trying to create a view or USE view with NODATA.
- Query produces incorrect result when ENGINEBEHAVIOR < 90, sub-query returns Aggregate function and no records match sub-query's WHERE condition.
- COPY TO ... AS nCodepage fails to encode memo with correct codepage and uses CPCURRENT() instead.
- Memo values are not translated when copied from tables with current code page to a table with different code page (COPY TO, SQL SELECT, APPEND FROM).
- SELECT ... WITH BUFFERING unexpectedly pulls buffered data from a cursor, which was not explicitly referenced in the FROM clause.

## IDE

- Project Manager: Fatal exception building application that uses icon that is still in memory.
- Properties Window: Fatal exception closing Zoom window with Enter key under App Verifier with SET KEYCOMP TO DOS.
- "Menu manager internal consistency error" crash when issuing CLEAR POPUPS.
- Prompt for saving query references tmp file.
- Tooltips appear in right monitor when you run VFP in left monitor in multi monitor setup where primary monitor is on the right.
- C0000005 error in the View Designer with long expression.
- Project Manager: Fatal exception changing font on Project Manager after Dock/Undock operation.
- Project Manager: New Project managers do not remember their positions when **Override Individual Settings** is selected for the **Projects** type on the **IDE** tab of the **Options** dialog box.
- RI builder uses incorrect syntax for UNLOCK command.
- Picbtns class of Wizbtns.vcx displays warnings when used with the CursorAdapter.
- Project Manager: VFP stops responding (hangs) when rebuilding app after error message that classlib is being used.
- Access violation C0000005 when activating IntelliSense in the Program Editor.
- IntelliSense: C0000005 Access Violation exiting Class Designer after failed attempt to access LPARAMETER IntelliSense for member method.
- Fatal exception when debugging a large code file.
- Builders: MemberData Editor - Code bug in GetHierarchy() of MemberDataEditor.scx causes MemberData Editor to get hierarchy wrong.
- Properties Window: C0000005 exception closing Class Designer with CursorAdapter, XMLAdapter, XMLTable, and XMLField after you press ESC on a property that has value over 255 characters long.
- Editor: 100% CPU usage hang when using Expression Builder from code editor window that contains only two blank lines.
- IntelliSense: Fatal exception in List Members after creating early binding mapi.session object with CreateObjectex().
- "Browse table is closed" error message followed by unhandled exception (c05) when messing with Resource file during table browse.
- On Simplified Chinese platform, reducing the width of a TextBox that contains dbcs string causes IDE to stop responding.
- On Simplified Chinese platform, fatal exception when executing program.
- Resizing Project Manager does not update treeview of files.
- Option Button Sample in Solution Samples throws DATATYPE MISMATCH error.
- Component Gallery: "Error building key for index" when selecting **Clean Up** from context menu.
- Builders: Problems with **Properties** dialog boxes in ReportBuilder.app.
- "Printer is not ready" error message when printing to EMF-Citrix printer driver inside Citrix client session to Metaframe 4.0 Presentation Server. Other applications can print to this printer fine.
- "'local thisview' is not allowed in the view script or is in the wrong place" error message in View Designer.
- Make ReportBuilder.app localizable.

## Language

- SQLEXEC() function allows reentrance for the same connection handle.
- DEBUGOUT outputs binary data as strings.
- CursorToXML() and XMLAdapter does not output seconds for xsd:dateTime values if SET SECONDS is OFF.
- C0000005 followed by "Mismatched pushjmp/popjmp call" error message when executing program from "do <program.prg>" on **Program Editor** menu and then followed by call to EXESCRIPT().
- WEXIST() finds ToolTipText windows.
- Memory leak when you set ActiveConnection property of ADO RecordSet object to NULL.
- "Internal Consistency" error message followed by crash of VFP calling methods of object that are returned with GetObject("IIS://LocalHost/W3SVC/1").
- XMLToCursor() and XMLAdapter fail to load values of type xsd:date if time portion is present.
- SQLCOLUMNS() fails with complex names if at least one part of the name contains a space or other "illegal" character.
- ADIR returns invalid file size for >2gig files (virtual PCs).
- GETOBJECT() has parameter limit based on file spec (261 chars).
- String optimization for recursion produces erroneous results.
- Literal number causes BINTOC() errors.
- Converting Bintoc to Character by using CTOBIN() throws junk value.

## VFP OLE DB Provider

- OLE DB Provider: SYS(3050) should default to 128 MB in provider.
- OLE DB Provider: Apparent memory leak leads to connectivity error "could not convert the data value..." with repeated openrowset or openquery to SQL linked server.
- Unable to create dataset with the VFP OLE DB Provider.
- GetSchema(string, string[]) failed to filter based on INDEX_NAME.
- OLE DB Provider: Enable SYS(3055) ("FOR and WHERE Clause Complexity") inside provider.
- VFP OLE DB Provider incorrectly handles binary parameters.
- Enable DROP VIEW and DROP PROCEDURE commands.
- DBSCHEMA_PROCEDURES rowset returns obsolete procedures.
- DBSCHEMA_PROCEDURES rowset returns incomplete procedure definition.
- APPEND PROCEDURES ignores compilation errors in procedures.
- Accessing database container (DBC) that has no tables may cause a buffer overrun error.

## Reporting

- Report Builder dialog boxes should respect regional settings.
- Report Preview has incorrect title in some cases.
- When object assisted report is previewed, initial Print Preview toolbar differs from that opened by selecting **Toolbar** from **Report Preview surface** menu.
- Object on report set to "Scale Contents, retain shape" appears differently between report preview and HTML made by an HTMLListener.
- Multiple detail bands do not work correctly when "Start on new page" is on.
- **Go To Page** dialog box opens out of visible range in when Preview Container TopForm property is .T. and windowstate is NORMAL.
- New-style Report Preview toolbar is inaccessible when report is previewed in SDI form without NOWAIT clause on REPORT FORM command.
- Code window filled with garbage characters when you try to close Report Designer and you click **NO** in the **Do you want to save changes to \<proc>?** prompt.
- Data Grouping limit for a report is listed as 74 in the documentation topic "How to: Add Data Groups to Reports," but ReportBuilder.app limits you to 20.
- Justification for numeric format is **Left justify**. This differs from previous VFP versions and default Report Designer.
- No error given when closing **Report Properties** dialog box after you set the **Initial Value** of a Report Variable to an invalid value.
- **Report Expression** dialog box for field with error is not displayed after preview error with while REPORTBEHAVIOR = 90.
- Calculated values in report detail header reset unexpectedly when reprint detail header option is on.
- ReportListener, AdjustObjectSize, and MaxHeightAvailable properties do not work with floating objects.
- Previewing a report that contains an image that is located on the disk causes a GDI handle leak every time the preview is refreshed.
- REPORT PREVIEW GDI handles limitation with many pages.
- Associated header and footer report option: sequential numbers do not print across pages.
- ReportListener.OutputPage to HDC uses 96 DPI instead of printer DPI.
- "Property WindowState does not exist in line 325 of ResourceManager::SaveWindowState()" error message.
- Multiselect dialog allows setting of protection flags, even when report is PROTECTED.
- You are prompted for FRX if switching from "load from FRX" to "link to Class".
- After canceling from the first GETFILE(FRX) prompt, you are prompted with GETFILE again.
- Report Preview overwrites m.oForm if it is previously declared outside the preview.
- Programs should respect "real" screen DPI at runtime instead of the design-time 96 DPI.
- Various errors occur when loading a DataEnvironment from a class that has specific attributes.
- The full path of the linked DE class library is written into the linking code. This is not always appropriate.
- Properties of preview form are not saved to resource file correctly under some circumstances.
- You receive "Unknown member .cmdPrint" error message if you have selected AllowPrintFromPreview = .F.
- Not all variables in FRXOUTPUT.prg had "m.".
- Enhance app to be smarter about unknown output type if a valid listener reference is passed.
- Ensure "m." in all methods and #DEFINEs that include expressions.
- Filebased listeners derived from XmlListener that used its ApplyUserXSLT property could not specify directory-only for TargetFileName.
- **Report Preview** menu can no longer be displayed by the Shift-F10 key after the **Go To Page** dialog has been displayed.
- Report band size does not change correctly with floating objects that stretch.
- C0000005 exception during report print preview with corrupted EXPR field in frx file.
- Enhance reportoutput.app to handle unknown output type if a valid listener reference is passed.

## Runtime and COM

- Toolbar or Status Bar not visible in application run on Windows 98 Second Edition.
- "The procedure entry point GetLongPathNameA could not be located in the dynamic link library KERNEL32.dll" error message in runtime in Windows NT 4.0.
- Memory leak with IMPLEMENTS in COM servers.
- Invalid COM parameter passing with unsigned long and unsigned int types.
- Deadlock in REMClearConnect and csCritSectionEnter when COM+ recycles dllhost worker process.
- COMARRAY. On Visual Basic 6.0 COM Server, Date type does not work.
- OCXAPI cannot be initialized for early binding objects.
- "Array dimensions are invalid" error message 230 when you pass large array >65000.
