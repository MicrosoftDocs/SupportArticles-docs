---
title: Use the HashTable collection in Visual C#
description: This article describes how to use the HashTable collection by using Visual C#.
ms.date: 04/22/2020
ms.reviewer: imtiazs
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to work with the HashTable collection

This article introduces how to use the `HashTable` collection in Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 309357

## Summary

Because hashing eliminates the need for costly searching of data to retrieve the data, you can use hashing to efficiently retrieve data. Hashing uses the value of the key itself to locate of the data.

The Base Class Libraries offer a `HashTable` class that is defined in the `System.Collections` namespace so that you are not required to code your own hash tables.

## Steps to build the sample

A `HashTable` collection stores a (`Key`, `Value`) pair and uses the `Key` to hash and obtain the storage location. The `Key` is immutable and cannot have duplicate entries in the `HashTable`. This sample uses several instances of a simple `Person` class to store in a `HashTable`. The last name is used as the `Key`.

1. Open Microsoft Visual Studio, and create a Windows Forms Application project in Visual C#. Form1 is added to the project by default.

2. In Solution Explorer, right-click the project name, point to **Add**, and then select **Class** to add a class module. `Class1` is added to the project by default.

3. Replace any code in the `Class1` module with the following code:

    ```cs
    public class Person
    {
        public string Fname, Lname;d
        public Person (string FirstName, string LastName)
        {
            Fname = FirstName;
            Lname = LastName;
        }
        public override string ToString ()
        {
            return Fname + " " + Lname;
        }
    }
    ```

    The `Person` class has one constructor that takes the `FirstName` and `LastName` parameters and assigns these parameters to the local variables. The `ToString` function overrides `ToString` from the `Object` class to return `Fname` and `Lname` concatenated together.

4. Create a form-level `Hashtable` object, and declare three variables of type `Person`. Add the following code to the `Form1` class:

    ```cs
    <?xm-deletion_mark author="v-bobbid" time="20080711T172143-0800"
    data="private Hashtable MyTable = new Hashtable();

    //For simplicity, create three Person objects to add to the HashTable collection.

    Person Person1,Person2,Person3; "?>
    <?xm-insertion_mark_start author="v-bobbid" time="20080711T172143-0800"?>
    System.Collections.Hashtable MyTable = new
    System.Collections.Hashtable();

    //For simplicity, create three Person objects to add to the HashTable collection.
    Person Person1,Person2,Person3;
    <?xm-insertion_mark_end?>
    ```

5. In the following steps, use the `Add` method of the `Hashtable` object to add three `Person` objects to the `Hashtable` in a `try-catch` block. The `try-catch` block catches the exception and displays a message if duplicate keys exist:
   1. Place a Button control on Form1, and change the **Text** property to **Add Items**.
   2. Double-click the button to open its Code window, and paste the following code in the `Button1_Click` event:

        ```cs
        Person1 = new Person("David", "Burris");
        Person2 = new Person("Johnny", "Carrol");
        Person3 = new Person("Ji", "Jihuang");

        //The Add method takes Key as the first parameter and Value as the second parameter.

        try
        {
            MyTable.Add(Person1.Lname, Person1);
            MyTable.Add(Person2.Lname, Person2);
            MyTable.Add(Person3.Lname, Person3);
        }
        catch (ArgumentException ae)
        {
            MessageBox.Show("Duplicate Key");
            MessageBox.Show(ae.Message);
        }
        ```

6. The `Hashtable` object provides an indexer. In the following steps, index with the `Key` to access the value that is stored at the hashed location:

   1. Add a Button control to Form1, and change the **Name** property to **Get Items**.
   2. Double-click the button, and paste the following code in the `Button2_Click` event:

        ```cs
        //Use the indexer of the Hashtable class to retrieve your objects. The indexer takes
        //Key as a parameter and accesses it with the Hashed location.
        try
        {
            MessageBox.Show(MyTable[Person1.Lname].ToString());
            MessageBox.Show(MyTable[Person2.Lname].ToString());
            MessageBox.Show(MyTable[Person3.Lname].ToString());
        }
        catch (NullReferenceException ex)
        {
            MessageBox.Show("Key not in Hashtable");
            MessageBox.Show(ex.Message);
        }
        ```

7. In the following steps, use the `Remove` method to remove a single item from the `HashTable` collection:

   1. Add a Button control to Form1, and change the **Text** property to **Remove Item**.
   2. Double-click the button, and paste the following code in the `Button3_Click` event:

        ```cs
        <?xm-deletion_mark author="v-bobbid" time="20080711T173011-0800" data="if (MyTable.Count == 0)
        {
            MessageBox.Show(&quot;There are no items in HashTable&quot;);
        }
        else
        {
            MessageBox.Show(&quot;The count before removing an Item is&quot; + &quot; &quot; + MyTable.Count);
            MessageBox.Show(&quot;Removing value stored at key value (Burris)&quot;);
            Remove the object that is stored at the Key value Person1.Lname.
            MyTable.Remove(Person1.Lname);
        }
        "?>
        <?xm-insertion_mark_start author="v-bobbid" time="20080711T173011-0800"?>if (MyTable.Count == 0)
        {
            MessageBox.Show("There are no items in HashTable");
        }
        else
        {
            MessageBox.Show("The count before removing an Item is" + " " + MyTable.Count);
            MessageBox.Show("Removing value stored at key value (Burris)");
            // Remove the object that is stored at the Key value Person1.Lname.
            MyTable.Remove(Person1.Lname);
        }
        <?xm-insertion_mark_end?>
        ```

8. In the following steps, enumerate the items that are stored in the `HashTable` collection:

   1. Add a Button control to Form1, and change the **Text** property to **Enumerate**.
   2. Double-click the button, and paste the following code in the `Button4_Click` event:

        ```cs
        <?xm-deletion_mark author="v-bobbid" time="20080711T174252-0800"
        data="IDictionaryEnumerator Enumerator;
        if (MyTable.Count == 0)
        MessageBox.Show(&quot;The hashtable is empty&quot;);
        else
        {
            MessageBox.Show(&quot;Enumerating through the Hashtable collection&quot;);
            Enumerator = MyTable.GetEnumerator();

            while (Enumerator.MoveNext())
            {
                MessageBox.Show(Enumerator.Value.ToString());
            }
        }

        ICollection MyKeys;

        if (MyTable.Count == 0)
         MessageBox.Show(&quot;The hashtable is empty&quot;);
        else
        {
            MessageBox.Show(&quot;Accessing keys property to return keys collection&quot;);
            MyKeys = MyTable.Keys;

            foreach (object Key in MyKeys)
            {
                MessageBox.Show(Key.ToString());
            }
        }
        "?>
        <?xm-insertion_mark_start author="v-bobbid" time="20080711T174252-0800"?>
        System.Collections.IDictionaryEnumerator Enumerator;

        if (MyTable.Count == 0)
            MessageBox.Show("The hashtable is empty");
        else
        {
            MessageBox.Show("Enumerating through the Hashtable collection");
            Enumerator = MyTable.GetEnumerator();

            while (Enumerator.MoveNext())
            {
                MessageBox.Show(Enumerator.Value.ToString());
            }
        }

        System.Collections.ICollection MyKeys;

        if (MyTable.Count == 0)
            MessageBox.Show("The hashtable is empty");
        else
        {
            MessageBox.Show("Accessing keys property to return keys collection");
            MyKeys = MyTable.Keys;

            foreach (object Key in MyKeys)
            {
                MessageBox.Show(Key.ToString());
            }
        }
        <?xm-insertion_mark_end?>
        ```

        This code declares a variable of type `IDictionaryEnumerator` and calls the `GetEnumerator` method of the `HashTable` collection. With the `Enumerator` returned, the code enumerates through the items in the collection and uses the `Keys` method of the `HashTable` to enumerate through the keys.

9. In the following steps, use the `Clear` method to clear the `HashTable`:

   1. Add a Button control to Form1, and change the **Text** property to **Clear**.
   2. Double-click the button, and paste the following code in the `Button5_Click` event:

        ```cs
        MyTable.Clear();
        MessageBox.Show("HashTable is now empty");
        ```

10. Follow these steps to build and run the application:

    1. Select **Add Items**. Three `Person` objects are added to the `HashTable` collection.
    2. Select **Get Items**. The indexer obtains the items in the `HashTable` collection. The three newly added items are displayed.
    3. Select **Remove Item**. The item at the `Burris` key location is deleted.
    4. Select **Enumerate**. `IDictionaryEnumerator` enumerates through the items in the `HashTable` collection, and the `Keys` property of the `HashTable` returns a Keys Collection.
    5. Select **Clear**. All the items are cleared from the `HashTable` collection.

> [!NOTE]
> The example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious. No association with any real company, organization, product, domain name, email address, logo, person, places, or events is intended or should be inferred.
