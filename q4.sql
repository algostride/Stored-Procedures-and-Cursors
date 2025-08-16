DELIMITER #

DROP PROCEDURE IF EXISTS SendWatchTimeReport;
CREATE PROCEDURE SendWatchTimeReport()
BEGIN
  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE subscriber_id INT;
  DECLARE cursor_subscriber CURSOR FOR
      SELECT SubscriberID FROM Subscribers;
      
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cursor_subscriber;
  
  sub_loop: LOOP
     FETCH cursor_subscriber INTO subscriber_id;
     
     IF done THEN 
        LEAVE sub_loop;
     END IF;
     
     IF EXISTS(SELECT 1 FROM WatchHistory WHERE SubscriberId = subscriber_id) THEN
        CALL GetWatchHistoryBySubscriber(subscriber_id);
     END IF;
  END LOOP sub_loop;
  
  CLOSE cursor_subscriber;
END #

DELIMITER ;
