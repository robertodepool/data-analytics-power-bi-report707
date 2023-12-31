# Project Title
blablabla

## Project Preparation
As I am using a Mac OS, project preparation involves creating a Windows Azure Virtual Machine to download Power BI Desktop.

## Milestone 1

## Milestone 2
This milestone comprises four tables with a focus on learning how to load and prepare data in Power BI.
### Table 1 - Orders
- The Orders table is the primary fact table, providing information on each order. It includes details such as order and shipping dates, customer information, store and product IDs for association with dimension tables, and the quantity of each ordered product. Each order in this table corresponds to a single product type, resulting in only one product code per order.

  1. I connect to the Azure SQL Database using Get Data > More... > Azure > Azure SQL Database. Using credentials provided. 

  2. Navigate to the Power Query Editor using the Transform Data icon in the ribbon. Then remove the column named [Card Number] to ensure data privacy using the Remove Column option in the ribbon.
  
  3. Using Split Column feature to separate the [Order Date] and [Shipping Date] columns into two distinct columns. This is done by Select Column > Split Column in the ribbon > by delimiter > Select the Space option due to the nature of out initial column. 

  4. Filter out and remove any rows where the [Order Date] column has missing or null. Done by Remove rows in ribbon > Remove Blank rows. 

  5. Rename the columns in your dataset to align with Power BI naming conventions, ensuring consistency and clarity in your report. A lot of the column are named using underscores for spaces, amongst other insconsistencies. 
  ### Table 2 - Products
  This part focuses on the Products table, which contains details about each product sold by the company. Information includes the product code, name, category, cost price, sale price, and weight.

    1. Download the Products.csv file and use Power BI's Get Data > More > Text/csv file. 

    2. In the Data view, ensure the uniqueness of each product code by using the Remove Duplicates function on the product_code column.

    3. Follow the steps below to clean and transform the data in the weight column:

        a. In Power Query Editor, leverage the Column From Examples feature to generate two new columns from the weight column - one for the weight values and another for the units (e.g. kg, g, ml). Sort the weight column by descending to obtain a variety of examples. Add Column in ribbon > Column from Examples > From Selection (having selected Weight column). Then make sure the Units and Value columns that are added have the desired values within the column.

        b. For the newly created Units column, replace any blank entries with kg. Replace values in ribbon > Replace value to find empty (for blank entries) and replace with "kg"

        c. Convert the data type of the Values column to a decimal number. Select Values > Data type: decimal number in ribbon 


    4. From the Data view, create a new calculated column. If the unit in the units column is not kg, divide the corresponding value in the values column by 1000 to convert it to kilograms. Column tools > New Columns > Use following function: Weight in kg = IF(Products[Units] <> "kg", Products[Values] / 1000, Products[Values]).
    The IF statement in DAX format explains that if the value in the Units column is not (<>) "kg" then the corresponding value in the Values column is divided by a 1000 otherwise it remains the same.    

    5. Return to the Power Query Editor and delete any columns that are no longer needed.

    6. Rename the columns in your dataset to match Power BI naming conventions, ensuring a consistent and clear presentation in your report. Columns renamed accordingly. 

### Table 3 - Stores
This part focuses on the Stores table, which contains comprehensive information about each store. Details include the store code, store type, country, region, and address.

1. Utilize Power BI's Get Data option to connect to Azure Blob Storage and import the Stores table into your project. Get Data > More... > Azure Blob Storage > Enter the Blob Storage credentials provided: Account Name, Account Key and Container Name

    - Once this is done go to Transform data and double click on Binary on the table so it shows the Stores.csv file.

2. Rename the columns in your dataset to align with Power BI naming conventions, ensuring clarity and consistency in your report.

### Table 4 - Customers 
This part involves downloading the Customers.zip file from a link and unzipping it on your local machine. Inside the zip file, you'll find a folder containing three CSV files, each with the same column format, representing the regions in which the company operates.

1. Use the Get Data option in Power BI to import the Customers folder into your project. Utilise the Folder data connector, navigate to your folder, and select Combine and Transform to import the data. Power BI will automatically append the three files into one query. Get Data > More > File > Folder > Select the unzipped Folder.

2. Once the data is loaded into Power BI, create a Full Name column by combining the [First Name] and [Last Name] columns. Column tools > New Column > Use following function: Full Name = Customers[First Name] & " " & Customers[Last Name]

3. Delete any obviously unused columns (e.g., index columns) and rename the remaining columns to align with Power BI naming conventions.

## Milestone 3

### Task 1 - Date table creation
This part inolves creating a date table using the Power BI's intelligence functions. We will be making a continous date table covering the entire time period of our data. 
1. To create the table. Report view > Modeling on ribbon > New table > Following formula: Dates = CALENDAR(MIN(Orders[Order Date]), MAX(Orders[Shipping Date]))

2. Creating the following columns by going to New Column. And creating: 
    - Day of Week
    - Month Number (i.e. Jan = 1, Dec = 12 etc.)
    - Month Name
    - Quarter
    - Year
    - Start of Year
    - Start of Quarter
    - Start of Month
    - Start of Week
The DAX formula to create each of this is in the .pbix file

### Task 2 - Creating the star schema
1. By going on model view and dragging the relationships desired the following relationships were created: 
    - Orders[product_code] to Products[product_code]
    - Orders[Store Code] to Stores[store code]
    - Orders[User ID] to Customers[User UUID]
    - Orders[Order Date] to Date[date]
    - Orders[Shipping Date] to Date[date]
It was made sure that the Orders[Date] and Date[Date] was the active relationships by looking at the properties when clicking on the relationship.

### Task 3 - Creating a measure table
- A measures table was created 

### Task 4 - Creating Key measures
- The following measures were created using DAX formulas that can be seen on the .pbix file. 
- The measure Total Orders counts the number of orders in the Orders table
- The measure Total Revenue multiplies the Orders[Product Quantity] column by the Products[Sale Price] column for each row, and then sums the result
- The measure Total Profit performs the following calculation: for each row, subtract the Products[Cost Price] from the Products[Sale Price], and then multiply the result by the Orders[Product Quantity], then 
sums the result for all rows
- The measure Total Customers counts the number of unique customers in the Orders table. 
- The measure Total Quantity counts the number of items sold in the Orders table
- The measure Profit YTD calculates the total profit for the current year
- The measure Revenue YTD calculates the total revenue for the current year

### Task 5 - Creating Date and Geography hierarchies
1. Date hierarchy created right clicking on the highest point of hierarchy, renaming and adding the columns lower down in order. 
    - Start of Year
    - Start of Quarter
    - Start of Month
    - Start of Week
    - Date

2. New calculated column created called Country using the Country Code column, the DAX fomular is in the .pbix

3. Similarly with Geography hierarchy
    - World Region
    - Country
    - Country Region

4. New column called Geography created where the Country Region and Country column in the Stores 

5. In the column tools the following categories were assigned:
    - World Region : Continent
    - Country : Country
    - Country Region : State or Province

## Milestone 4



