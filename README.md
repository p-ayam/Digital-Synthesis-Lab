# Digital-Synthesis-Lab
<br>
This work aims at making a simple, digital solution to keep synthetic records of a large chemistry departmnet in a normalized database. 

The assumption is that a summary of every reaction, reagent and user is recorded on the go by the chemists in a commonly accessible excel file as the user end (/Data/lab.xlsx).

A collection of python codes (main.py and writexl.py) extract, transform and load (ETL) the data to a normalized MySQL Workbench database (laboratory.sql).

The data from the reactions, the reagents and the users that are collected in the Excel file (lab.xlsx) could be deleted on the go to keep a lean file size.

Apart from the ETL process, additional features like Views and Functions are defined for the database that allow for an overall statistical overview of the
reactions, reagents and users. These calculations are performed in the database, making use of the entire dataset available from the beginning. The result of these calculations
will be updated in the Excel file's Overview sheet as following:
* The Overview sheet shows an updated perspective of the number of reactions that use a certain chemical reagent or the number of people who use this reagent (View=`reagent_user`). 
* It also shows the number of the reactions that chemists have performed and the due dates in which they were carried out (View=`user_metrics`).
* The Overview sheet also shows the average number of chemical reagents that have been used in the reactions, the average number of chemists working on the syntheses, as well as the average 
temperature and yeild of the reactions.

