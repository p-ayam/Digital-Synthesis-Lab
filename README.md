
## Digital Synthesis Lab: From Excel's User Interface to MySQL Database 
<br>


This work provides a simple, digital solution to keep the workflow of a synthetic chemistry laboratory in a normalized MySQL database. Laboratory users will interact with Excel sheets as the user-end to provide the data flow. The incoming data will be extracted, transformed and loaded (ETL) on the database using two Python codes. In the following, a description of the Excel files (1) as well as the ETL process and the MySQL database (2) is provided:

### 1. Excel Files as the User End
The assumption is that a summary of every item in the list of **Reactions**, **Reagents**, and **Users** is recorded -on the go- by the chemists in a commonly accessible Excel file (`/Data/lab.xlsx`). The file is equipped with data validation features to avoid the intake of faulty data. Here is a brief description of each sheet:

Excel sheet **Reactions** is filled with dummy data here:
<br>
<img src="https://github.com/p-ayam/images/blob/main/excel_reaction.jpg" alt="alt text" width="900" height="whatever">
<br>
The **Reactions** sheet contains two columns with the title "User" and "Reagent_id" that both contain
comma-separated id-numbers from the corresponding chemists who conducted the reaction and the reagents used for the synthesis. The column "Temperature" contains values recorded in centigrades.
<br>
Excel sheet **Reagents** is filled with dummy data here:
<br>
<img src="https://github.com/p-ayam/images/blob/main/excel_reagent.jpg" alt="alt text" width="630" height="whatever">
<br>
Excel sheet **Users** is filled with sample dummy data here:
<br>
<img src="https://github.com/p-ayam/images/blob/main/excel_user.jpg" alt="alt text" width="630" height="whatever">
<br>


### 2. ETL Process and MySQL Database
A collection of python codes (`main.py` and `writexl.py`) **extract, transform and load (ETL)** the data between the Excel file and the MySQL database. In this process, the comma-separated values in the two columns of the
**Reactions** Excel sheet ("User", "Reagent_id") get identified and saved separately in the database tables `reactions_users` and `reactions_reagents`, respectively. Also, the temperature is converted from Celsius to Kelvin. The transformed
data are then loaded to a normalized MySQL Workbench database (`laboratory.sql`) that contains 5 tables: `reaction`, `reagents`, `users`, `reactions_reagents`, `reactions_users`, with the first three having a many-to-many relationship. The database schema is the following:

<img src="https://github.com/p-ayam/images/blob/main/schema.jpg" alt="alt text" width="630" height="whatever">


The data from the reactions, the reagents and the users that are collected in the Excel file (`lab.xlsx`) could be deleted on the go to keep a lean file size.

Additional features like View and Function are also defined for the database which will be discussed in the following:
<br>
<img src="https://github.com/p-ayam/images/blob/main/schema%20on%20workbench.jpg" alt="alt text" width="200" height="whatever">
<br>

### 2.1. View (MySQL)

Apart from the ETL process, additional features like **Views** and **Functions** are defined for the database that allows for an overall statistical overview of the
laboratory's performance. These calculations are conducted in the MySQL database, making use of the entire dataset available from the beginning of the record-keeping. The results of these calculations are then updated and shown in the Excel file's **Overview** sheet, each time that new data come to the database (refer to the `main.py` file where _Making Use of Views_ is discussed). Three pieces of information are exclusively derived from the Views:

**a)** The Overview sheet in the Excel file shows an updated total number of reactions and people that use each reagent in the lab (View=`reagent_user`). This View is generated based on the following MySQL code:
```
CREATE VIEW `reagent_use` AS
    SELECT 
        `chem`.`Reagent_id` AS `REAGENT_ID`,
        `chem`.`Location_ID` AS `LOCATION_ID`,
        COUNT(`rr`.`Reaction_id`) AS `NO_REACTIONS`,
        COUNT(DISTINCT `ru`.`User_id`) AS `NO_USERS`
    FROM
        (((`reagents` `chem`
        JOIN `reactions_reagents` `rr` ON ((`chem`.`Reagent_id` = `rr`.`Reagent_id`)))
        JOIN `reactions` `rea` ON ((`rr`.`Reaction_id` = `rea`.`Reaction_id`)))
        JOIN `reactions_users` `ru` ON ((`rr`.`Reaction_id` = `ru`.`Reaction_id`)))
    GROUP BY `chem`.`Reagent_id`
    ORDER BY `chem`.`Reagent_id`
```
The result of this simple analysis is shown in the `Overview` excel sheet as follows:
<br>
<img src="https://github.com/p-ayam/images/blob/main/excel_overvoew1.jpg" alt="alt text" width="400" height="whatever">
<br>

**b)** It also shows the total number of the reactions that each chemist has performed and the dates in which the reactions were carried out (View=`user_metrics`). 
This View is generated based on the following MySQL code:
```
CREATE VIEW `user_metrics` AS
    SELECT 
        `u`.`user_id` AS `user_id`,
        CONCAT(`u`.`First_Name`, ' ', `u`.`Family_Name`) AS `Full_Name`,
        COUNT(`ru`.`Reaction_id`) AS `No_Reactions`,
        GROUP_CONCAT(DISTINCT `rea`.`Date`
            ORDER BY `rea`.`Date` DESC
            SEPARATOR ', ') AS `REACTION_DATES`
    FROM
        ((`users` `u`
        JOIN `reactions_users` `ru` ON ((`u`.`user_id` = `ru`.`User_id`)))
        JOIN `reactions` `rea` ON ((`rea`.`Reaction_id` = `ru`.`Reaction_id`)))
    GROUP BY `u`.`user_id`
    ORDER BY `u`.`user_id`
```
The result of this simple analysis is shown in the `Overview` excel sheet as following:
<img src="https://github.com/p-ayam/images/blob/main/excel_overvoew2.jpg" alt="alt text" width="700" height="whatever">

**c)** The Overview sheet also shows the average number of chemical reagents that have been used in the reactions, the average overall number of chemists working on the syntheses, as well as the average temperature and yield of the reactions (View=`reactions_overview`). This View is generated based on the following MySQL code:
```
CREATE VIEW `reactions_overview` AS
    SELECT 
        (COUNT(`rr`.`Reagent_id`) / COUNT(DISTINCT `rr`.`Reaction_id`)) AS `Avg_No_Chem_per_Reaction`,
        (SELECT 
                (COUNT(`ru`.`User_id`) / COUNT(DISTINCT `ru`.`Reaction_id`))
            FROM
                `reactions_users` `ru`) AS `Avg_No_User_per_Reaction`,
        (SELECT 
                (AVG(`reactions`.`Temperature`) - 273.15)
            FROM
                `reactions`) AS `AVG_TEMP_DEG_C`,
        (SELECT 
                AVG(`reactions`.`Yield`)
            FROM
                `reactions`) AS `AVG_YIELD_PER_CENT`
    FROM
        `reactions_reagents` `rr`
```
The result of this simple analysis is shown in the `Overview` excel sheet as follows:
<img src="https://github.com/p-ayam/images/blob/main/excel_overvoew3.jpg" alt="alt text" width="700" height="whatever">

### 2.2. Function (MySQL)

The database provides a function like `format_date_diff(date2, date1)` for the data analysts who will get access to the MySQL database. The function takes in two dates (date2 > date1) and returns the differences between two, as a string in the form of YYYY-MM-DD. This might be helpful in inventory management, raising alarms for the chemicals that are out of their shelf life or for regulatory purposes.

```
CREATE FUNCTION `format_date_diff`(date2 date, date1 date) RETURNS varchar(10) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	
  DECLARE yyyy integer; # year number
  DECLARE mm INTEGER;      # month number
  DECLARE dd integer; # day number
  DECLARE diff varchar(15);
 
  set yyyy=floor(datediff(date2,date1)/365);
  set mm=floor(mod(datediff(date2,date1),365)/30);
  set dd=datediff(date2,date1)-365*yyyy-30*mm;
  set diff=concat(yyyy,'-',mm,'-',dd);
 
  RETURN diff;
END
```
