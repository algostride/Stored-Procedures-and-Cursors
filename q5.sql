DELIMITER #

DROP PROCEDURE IF EXISTS SendWatchTimeReportForAllSubscribers;
CREATE PROCEDURE SendWatchTimeReportForAllSubscribers()
BEGIN
  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE subscriber_id INT;
  DECLARE cursor_subscriber CURSOR FOR
      SELECT SubscriberID FROM Subscribers;
      
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cursor_subscriber;
  
  sub_loop: LOOP
     FETCH cursor_subscriber into subscriber_id;
     
     IF done THEN 
         LEAVE sub_loop;
     END IF;
      
     CALL GetWatchHistoryBySubscriber(subscriber_id);
  END LOOP sub_loop;

  CLOSE cursor_subscriber;
END #

DELIMITER ;
