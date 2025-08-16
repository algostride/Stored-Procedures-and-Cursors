                            STORED PROCEDURES AND CURSORS
                          ==================================

================================================================================
GIT REPOSITORY: https://github.com/algostride/Stored-Procedures-and-Cursors.git 
================================================================================
             
EXECUTING AND CALLING PROCEDURES
---------------------------------

The scripts are provided as '.sql' files. To execute them, run the following command in MySQL command line:  
mysql> SOURCE <path_to_sql_file>;


To call the procedure:
mysql> CALL <procedure_name>();    


NOTE: For the questions, the path is considered to be '/media/user'. 

Also, in each script file, the procedure is preceeded with a command to drop already existing procedures with the same name, so that the CREATE PROCEDURE command will always be executed.
The tables and data used for the activity are the same as mentioned in the question.
                                                                                       
                                                                                       
QUESTION 1: LIST ALL SUBSCRIBERS
--------------------------------

Procedure Name: ListAllSubscribers
Inputs: N/A
Saved file: q1.sql

Create a temporary table 'TempSubscriberName' to hold the subscriber names.
Use a cursor to fetch the subscriber names and a variable 'done' to track the progress. When the cursor has fetched all values, set 'done' to TRUE.
In a loop, fetch names of subscribers one by one and insert into 'TempSubscriberName', until the value of 'done' is TRUE.
Print the contents of 'TempSubscriberName', drop the table and close the cursor.

To execute the script and call the procedure, run the following command in MySQL command line:
               
mysql> SOURCE /media/user/q1.sql;
mysql> CALL ListAllSubscribers(); 

Output format : 
+----------------+
| SubscriberName |
+----------------+
| Emily Clark    |
| Chris Adams    |
+----------------+



QUESTION 2: GET WATCH HISTORY BY SUBSCRIBER
-------------------------------------------
Procedure Name: GetWatchHistoryBySubscriber;
Inputs: sub_id INT 
Saved file: q2.sql

Use JOIN to get data from WatchHistory table and Shows table. Set the condition to be equality on ShowID for the table. Also, JOIN on Subscribers table to get SubscriberName and set the condition be equality on SubscriberID and th input to the procedure sub_id.

To execute the script and call the procedure, run the following command in MySQL command line:
               
mysql> SOURCE /media/user/q2.sql;
mysql> CALL GetWatchHistoryBySubscriber(<subscriber_id>); 

Output format : 
+--------------+----------------+-----------------+-----------+
| SubscriberID | SubscriberName | ShowTitle       | WatchTime |
+--------------+----------------+-----------------+-----------+
|            1 | Emily Clark    | Stranger Things |       100 |
|            1 | Emily Clark    | The Crown       |        10 |
+--------------+----------------+-----------------+-----------+

NOTE: The JOIN used is LEFT JOIN to output NULL data for subscribers who has not watched any movies, to use in upcoming questions. In that case, the output would be:
+--------------+---------------+-----------+-----------+
| SubscriberID | SubscriberName| ShowTitle | WatchTime |
+--------------+---------------+-----------+-----------+
|            4 | NewSubscriber | NULL      |      NULL |
+--------------+---------------+-----------+-----------+



QUESTION 3: ADD A SUBSCRIBER IF NOT ALREADY PRESENT
---------------------------------------------------
Procedure Name: AddSubscriberIfNotExists;
Inputs: subName VARCHAR(100)
Saved file: q3.sql

Use IF NOT EXISTS to make sure that the subscriber with name equal to the inpur subName does not exist in the table. Use INSERT to add the new subscriber with SubscriberId being one more than the current max subscriber id present in the table. Print the executed action result as message in either cases.

To execute the script and call the procedure, run the following command in MySQL command line:
               
mysql> SOURCE /media/user/q3.sql;
mysql> CALL AddSubscriberIfNotExists(<subscriber_name>); 

Output format : 
+------------------+
| message          |
+------------------+
| Subscriber added |
+------------------+


QUESTION 4: SEND WATCH TIME REPORT (IF WATCHED)
---------------------------------------------------
Procedure Name: SendWatchTimeReport;
Inputs: N/A
Saved file: q4.sql

Use a cursor to fetch SubscriberID from Subscribers table one by one. Check whether the subscriber has watched any shows using SELECT from WatchHistory table and call GetWatchHistoryBySubscriber() internally for each of these subscribers. Loop until cursor has fetched all subscribers, tracked using another variable.

The result is dispayed in different tabs/sets, equal to number of subscribers who has watched atleast one show. Apart from shows and watchtime, the table also contains SubscriberID and SubscriberName to distinguish between different tabs/sets.

To execute the script and call the procedure, run the following command in MySQL command line:
               
mysql> SOURCE /media/user/q4.sql;
mysql> CALL SendWatchTimeReport(); 

Output format : 
+--------------+----------------+-----------------+-----------+
| SubscriberID | SubscriberName | ShowTitle       | WatchTime |
+--------------+----------------+-----------------+-----------+
|            1 | Emily Clark    | Stranger Things |       100 |
|            1 | Emily Clark    | The Crown       |        10 |
+--------------+----------------+-----------------+-----------+
2 rows in set (0.00 sec)

+--------------+----------------+-----------------+-----------+
| SubscriberID | SubscriberName | ShowTitle       | WatchTime |
+--------------+----------------+-----------------+-----------+
|            2 | Chris Adams    | Stranger Things |        20 |
|            2 | Chris Adams    | The Crown       |        40 |
|            2 | Chris Adams    | The Witcher     |        10 |
+--------------+----------------+-----------------+-----------+
3 rows in set (0.00 sec)


QUESTION 5: SEND WATCH TIME REPORT FOR ALL SUBSCRIBERS
-------------------------------------------------------
Procedure Name: SendWatchTimeReportForAllSubscribers;
Inputs: N/A
Saved file: q5.sql

Use a cursor to fetch SubscriberID from Subscribers table one by one. Call GetWatchHistoryBySubscriber() internally for each of these subscribers. Loop until cursor has fetched all subscribers, tracked using another variable.

The result is dispayed in different tabs/sets, equal to number of subscribers. Apart from shows and watchtime, the table also contains SubscriberID and SubscriberName to distinguish between different tabs/sets.

The difference from Question 4 is that for Question 4, GetWatchHistoryBySubscriber() was called for subscribers who have watched atleast one show. For Question 5, GetWatchHistoryBySubscriber() is called for eacha nd every subscriber, irrespective of whether they have watched any shows or not, which implies the output may contains tables with null values (explained in Question 2).

To execute the script and call the procedure, run the following command in MySQL command line:
               
mysql> SOURCE /media/user/q5.sql;
mysql> CALL SendWatchTimeReportForAllSubscribers(); 

Output format : 
+--------------+----------------+-----------------+-----------+
| SubscriberID | SubscriberName | ShowTitle       | WatchTime |
+--------------+----------------+-----------------+-----------+
|            3 | Jordan Smith   | The Crown       |        10 |
|            3 | Jordan Smith   | Stranger Things |        10 |
+--------------+----------------+-----------------+-----------+
2 rows in set (0.00 sec)

+--------------+----------------+-----------+-----------+
| SubscriberID | SubscriberName | ShowTitle | WatchTime |
+--------------+----------------+-----------+-----------+
|            4 | NewSubscriber  | NULL      |      NULL |
+--------------+----------------+-----------+-----------+
1 row in set (0.00 sec)

