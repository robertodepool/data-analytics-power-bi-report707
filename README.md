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

### Task 1 - Report pages
Report pages where added, in Model view by pressing the plus button. The pages added:
- Executive Summary
- Customer Detail
- Product Detail
- Stores Map
Also a theme was chosen in the View tab. The team chosen was the Colorblind safe one, in case any viewer of these is colourblind. 

### Task 2 - Adding Navigation Sidebar
- Rectangle shape added in all pages. Insert > Shapes > Choose rectangle > In properties select desired colour. 

## Milestone 5

### Task 1 - Creating Headline Card Visuals
1.  Two rectangles in top left corner of the page were created (similar process as Adding navigation bar)
2. Two card visuals to go on over these rectangles were added one for Total customers and one for the Revenue per Customer measure (this measure was created by dividing the Total Customers / Total Revenue). 
3. The Total Customers field was renamed to Unique Customers.

### Task 2 - Adding Summary Charts
1. Donut chart visual was added using the Users[Country] column to filter the [Total Customers] measure
2. Column chart visual was created using the Products[Category] column to filter the [Total Customers] measure

### Task 3 - Creating  Line Chart 
1. Line chart visual was created where 
    - X axis: Date Hierarchy
    - Y axis: Total Customers measures
    Where it was selected that the user could only drill down up to Start of Month, hence deselecting Date and Start of Week on the Data pane
2. A trend line, and a forecast for the next 10 periods with a 95% confidence interval were added. This can be selected to be turned on, on the Format pane. 

### Task 4 - Creating a Top 20 Customer table 
1. A visuals table was created with the followiung columns:
    - Customers[Full Name]
    - Total Orders measure
    - Total Revenue measure
2. A TopN Filter was applied to get the Top 20 Customers based on the Total Revenue 

### Task 5 - Creating Top Customer Cards
1. A card (new) visual was added. This was done by using a Q&A card to get the Top customer by Top Revenue (this is the prompt).
2. Then the card visual icon is pressed and Full Name, Total Quantity and Total Revenue are selected.

### Task 6 - Adding a Data Slicer
1. A data slicer was added. By pressing on the visual followed by selecting Year which is what we want the data to be sliced on. 

## Milestone 6 - Customer Detail Page
### Task 1 - Creating task visuals
1. Adding card visuals using the card (new)
2. Total Revenue, Total Orders and Total Profit are the measures selected
3. On  Format > Callout Values we select 2 decimal points for Total Profit and Total Revenue, 1 decimal point for Total Orders
4. The formatting of the card visuals to kept the same as in the Customer Detail page

### Task 2 - Adding a Revenue Trending Line Chart 
1. Copying the Customer Details line graph.
2. The Y axis is changed to Total Revenue, The X axis is kept the same.

### Task 3 - Adding Donut charts for Total Revenue by Country and Total Revenue by Store Type
1. Revenue by Country donut chart:
    - Copy donut chart from Customer detail page
    - Change Total Customers to Total Revenue 
2. Revenue by Store Type donut chart
    - Copy donut chart made on Step 1
    - Change Stores[Country] to Stores[Store Type]

### Task 4 - Adding a Bar Chart of Orders by Product categories
1. Clustered bar chart visual was created
    - Y axis: Products[Category]
    - X axis: Total Orders measure

### Task 5 - Adding KPI Visuals
1. New measures to be created in the Measures tables using DAX formulas, formulas available in the .pbix file. 
    - Previous Quarter Profit
    - Previous Quarter Revenue
    - Previous Quarter Orders
    - Target Profit - which is 5%, this is achieved by multiplying the Previous Quarter Profit measure by 1.05. This is done respectively to both measures below. 
    - Target Revenue 
    - Target Orders
2. KPI visual is created where:
    - Value: Total Profit
    - Trend axis: Start of Quarter
    - Target: Target Profit
3. In the Format pane the Trend axis is turned on, the direction: high is good, the bad colour is set to red and the Transparency is set to 15%
4. Step 2 and 3 are repetead for revenue and orders. 

## Milestone 7 - Create a Product Detail Page
### Task 1 - Add Gauge Visuals
1. In the Measures Table the following measures were created:
    - Current Quarter Profit
    - Current Quarter Revenue 
    - Current Quarter Orders
    - Quarterly Target Profit - which is 10%, measure achieved by multiplying Current Quarter Profit by 1.1. This is done respectively to both measures below
    - Quarterly Target Revenue
    - Quarterly Target Orders
2. Three gauge visuals were inserted where respectively:
    - Values:
        - Current Quarter Profit
        - Current Quarter Revenue 
        - Current Quarter Orders
    - Maximum Value
        - Quarterly Target Profit
        - Quarterly Target Revenue
        - Quarterly Target Orders
3. Conditional formatting was done to the callout value of each Gauge. This is done by going to Callout Value in the Format pane and pressing the fx button the choosing Rules and the rules applied were
    - What field should we base this on? Current Quarter Orders
    - If value >= 3299.6 (this is the Quarterly Target Orders value) and < 999999999 (largest number possible) then the colour red
    - If value >= 0 and < 3299.6 then black
    - This is done respectively to each Gauge

### Task 2 - Plan out the Filter State Cards


### Task 3 - Adding an Area Chart of Revenue by Product Category
1. Area Chart was inserted with the following fields:
    - X axis Dates[Start of Quarter]
    - Y axis Total Revenue measure
    - Legend Products[Category]

### Task 4 - Adding a Top Product tables 
1. A table visual is added witht he following columns selected:
    - Product Description
    - Total Revenue
    - Total Customers
    - Total Orders
    - Profit per Order
2. On the filters pane on Description the Filter Type is put to Top N, in Show Items, select Top and put the number 10, in By Value Total Revenue is chosen. 

### Task 5 - Adding a scatter graph of Quantity Sold vs Profit per Item 
1. The Profit per Item column was created in the Products table by subtracting the Sale Price by the Cost Price. The DAX formula is available in the .pbix file 
2. A Scatter chart visual is added with the following specifications:
    - Values: Products[Description]
    - X-Axis: Products[Profit per Item]
    - Y-Axis: Products[Total Quantity]
    - Legend: Products[Category]

### Task 6 - Creating a Slicer Tool Bar
1. A custom button is added to the Navigation bar. The custom icon is a Filter icon. The tooltip text is changed to Open Slicer Panel. 
2. A rectangle shape is added (what is going to be the slicer bar). Where the shape is the height of the page and 3 times the width of the navigation bar. The shape is brought to the top of the stacking order. 
3. Two new Slicers added
- Products[Category] - renamed: Product Category
    - Slicer set to vertical list
    - Multi-select
- Stores[Country] - renamed Country 
    - Slicer set to vertical list
    - Select All option
    - Single select
4. A back button is added to the right top corner of the slicer bar. 
5. The Slicer bar, the back button and both slicers are grouped. By selecting them all and grouping them in the selection pane. Rename Slicer Bar Group
6. Bookmark pane opened in View tab. Two bookmarks were added 
    - Slicer Bar Closed 
        - Hide Slicer Bar Group in Selection pane by clicking the eye
        - Right click and tick off Data
    - Slicer Bar Open
        - Make sure Slicer Bar Group visible
        - Right click and tick off Data
7. Actions for the buttons were assigned where:
    - Back button: 
    - Filter button:


## Milestone 8 - Creating a Store Map page
### Task 1 - Adding a Map visual 
1. A Map visual is added where:
    - Location: Geography Hierarchy 
    - Bubble Size: Profit YTD
    - In Format pane:
        - Show Labels: On
        - Auto Zoom: On
        - Zoom buttons: Off
        - Lasso button: Off

### Task 2 - Adding a Country Slicer
1. Above the Map visual a slicer visual is added where the slicer field is Stores[Country] and the slicer style is Tile. Also, the Selection settings are Multi-select with Ctrl and Show "Select All" as an option in the slicer.

### Task 3 - Creating a Store Drillthrough page 
1. A new page called Store Drillthrough is created. In the Format pane the page type is set to drillthrough, drillthrough from: Country Region and Drillthrough when: Used as Category.
2. Two new measures are created:
- Profit Goal (20%) where the Profit YTD is multiplied by 1.2 to obtain this. DAX formula available in file. 
- Profit Revenue, same procedure as above. 
3. A table visual with the Top 5 products, the Top N filter is used top obtain the top 5 on the Total Revenue measure. The table columns are:
    - Description 
    - Profit YTD
    - Total Orders
    - Total Revenue
4. A column chart was added where: 
    - X axis: Products[Category]
    - Y axis: Total Orders measure
5. Two Guage visuals were added where:
    - Value: Profit YTD Target: Profit Goal
    - Value: Revenue YTD Target: Revenue Goal
6. A Card visual was added selecting Stores[Geography]. But, Geography is renamed to Stored Location so when selecting any item from the table visual the card shows the store Location. 

### Task 4 - Creating a Tooltip page
1. A new page called Tooltip page is created. The page type is set to Tooltip.
2. The Profit Gauge is copied and pasted from the Drillthrough page to the Tooltip page
3. In Stores Map page, on the Map visuals, Tooltips in the format page is set to On. Options:
- Type: Report Page
- Page: Tooltip Page



