# Digital-Synthesis-Lab

This work aims at making a simple, digital solution to keep synthetic records of a large chemistry departmnet in a normalized database. 
The assumption is that every reaction's summary is recorded by the chemists in a commonly accessible excel file (/Data/lab.xlsx) as the user end.
A collection of python codes (main.py and writexl.py) read the data and write it to a normalized MySQL database (Workbench).
Over the course of years, a huge set of data is expected to be piled up, making their storage on an excel file problematic.
