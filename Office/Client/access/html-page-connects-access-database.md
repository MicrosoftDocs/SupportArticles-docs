---
title: How To Connect an HTML Page to a Microsoft Access Database
description: Describes how to use data access pages to connect an HTML page to tables in a database
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How To Connect an HTML Page to a Microsoft Access Database

## Summary

A data access page is an HTML page that has an Office Web Component embedded into it. The Office Web Component stores connection information about a data source. This article describes how to use data access pages to connect an HTML page to tables in a database.

### Requirements

Prior knowledge required:

- Database concepts
- Familiarity with Microsoft Access concepts and user interface

### Create the Microsoft Access Database

1. Start Microsoft Access, and then create a new blank database named "HTMLAccess.mdb".
2. Create a new table named "Contacts" by following these steps:

   1. Under Objects, click Tables.
   2. Double-click **Create table by using wizard**. The Table Wizard dialog box appears, and you are asked what types of fields you want to create.
   3. In the Sample Tables list, click Contacts. Click the single chevron button (>) 10 times to copy the first 10 items from the Sample Fields list into the **Fields in my new table** list. Click Next.
   4. Accept the defaults on the second page of the wizard, and then click Next.
   5. Select the **Enter data into the table using a form the wizard creates for me** check box, and then click Finish.

3. Verify that a new table named "Contacts" has been created. Also verify that a new form named "Contacts" has been created.
4. Type information for two contacts in the form (you do not need to type Contact ID values). Use the TAB key to move from one field to the next.
5. Click the Close button on the Contacts form. Save the form as Contacts.

### Method 1: Create the Data Access Page by Using the Wizard

To create the data access page by using the wizard, follow these steps:

1. Start Microsoft Access. Under Objects, click Pages. Double-click **Create data access page by using wizard**. The Page Wizard dialog box appears.
2. Verify that the "Contacts" table is selected in the Tables/Queries list box. Click the double chevron button (>>) to copy all the fields into the Selected Fields list box. Select ContactID, and then click the single chevron (<) to cancel the selection of this field. Click Next.
3. The second page of the wizard allows you to organize your data into groups, such as organizing contacts by country. To keep the design simple, click Next. The third page asks for the sort order of the records. Click Next.
4. The final page asks for the title of the HTML page and allows you to apply a theme to the HTML page. Click Open the Page, and then click Finish. The data access page is now created and displayed.
5. Use the record navigation bar at the bottom of the data access page to move through the records and to create two more contacts.
6. On the File menu, click Save. Save the data access page as "Contacts.htm" in the My Documents folder.
7. Read the message that appears, and then click OK. Close the data access page.

### Method 2: Create the Data Access Page by Using an Existing HTML Page

To create the data access page by using an existing HTML page, follow these steps:

1. Start Notepad, and then type the following HTML:

   ```html
   <html>
     <head>
       <h1>Accessing Data through HTML and Access</h1>
     </head>
     <body>
       Looking at Excel Web Components to create a DAP
     </body>
   </html>
   ```

2. Save the file as MyHTML.htm in your My Documents folder.
3. In Windows Explorer, double-click MyHTML.htm. The HTML page appears in Microsoft Internet Explorer. Quit Internet Explorer.

To create the data access page link, follow these steps:

1. Start Microsoft Access. Under Objects, click Pages. Double-click **Edit Web page that already exists**. The Locate Web Page dialog box appears. Click MyHTML.htm in the My Documents folder, and then click Open. The HTML page opens in Design view.
2. Click at the end of the line "Looking at Excel Web Components to create a DAP", and then press ENTER to create a new paragraph.
3. Create a hyperlink to the Contacts HTML page by following these steps:

   1. On the Insert menu, click Hyperlink. The Insert Hyperlink dialog box appears.
   2. In the **Text to display** text field, type Click here to view Contacts HTML Page.
   3. Click the HTML file Contacts.htm in the My Documents folder.
   4. Click OK to return to the data access page.

4. Click at the end of the newly inserted text, and then press ENTER to create a new line on the data access page.

To edit and test the data access page, follow these steps:

1. With the data access page open in Design view, select items from the Field List. If you cannot see the Field List, click Field List on the View menu. In the Field List, expand the Contacts table.
2. Drag the FirstName and LastName fields onto the data access page, under the last line of text. Two pairs of labels and text boxes will be created, as well as a record navigation bar.
3. Drag the Contacts table from the Field List onto the data access page, and then drop it after the last text box. The Layout Wizard dialog box appears. Click Office Spreadsheet, and then click OK.
4. The Relationship Wizard appears. Accept the relationship, and then click OK to return to the data access page. An Office Web Spreadsheet component will be created and displayed.
5. On the View menu, click Page View to test the page.
6. Click New on the record navigation bar to clear the First Name and Last Name text boxes. Type a new first name and last name. Click Saveon the record navigation bar. The new data will be displayed in the spreadsheet control.
7. Save and close the data access page. In Microsoft Access, click Tables, and then double-click the Contacts table. Verify that the new data was added to the Contacts table, and then quit Microsoft Access.

### Verification

To open the data access page, follow these steps:

1. Open Internet Explorer. In the My Documents folder, open the file MyHTML.htm.
2. Test all parts of the page.
3. Click the hyperlink to verify that it links to the Contacts.htm file.

   > [!NOTE]
   > Before you publish this data access page to the Web server, verify that all paths are correct, and change the hyperlinks to URLs.

To change a connection, follow these steps:

1. Start Microsoft Access. In the data access page Design view, open the MyHTML.htm file.
2. If the Field List is not visible, click Field List on the View menu.
3. In the Field List, click the Page connection properties icon that appears under the title bar of the Field List pane. The Data Link Properties dialog box appears.
4. Verify that the connection corresponds to the correct path to the database.
5. If you scale the database up to Microsoft SQL Server, verify that the OLEDB Provider is correct on the Provider tab.
6. Click OK to complete the connection property changes.

To change a URL, follow these steps:

1. Select the friendly text for the hyperlink.
2. On the Insert menu, click Hyperlink. The Edit Hyperlink dialog box appears.
3. Type a URL in the Address box, and then click OK.

## References

Sample data access pages are available in the Northwind database.

> [!NOTE]
> The Northwind database is installed with a full installation of Microsoft Office XP Professional.