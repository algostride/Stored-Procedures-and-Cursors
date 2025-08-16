DELIMITER #

DROP PROCEDURE IF EXISTS ListAllSubscribers;
CREATE PROCEDURE ListAllSubscribers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE subscriber_name varchar(100);
  DECLARE cursor_subscriber CURSOR FOR
      SELECT SubscriberName FROM Subscribers;
      
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  CREATE TEMPORARY TABLE TempSubscriberName (SubscriberName VARCHAR(100));
  OPEN cursor_subscriber;
  
  sub_loop: LOOP
    FETCH cursor_subscriber into subscriber_name;
    IF done 
        THEN LEAVE sub_loop;
    END IF;
    INSERT INTO TempSubscriberName (SubscriberName) VALUES (subscriber_name);
  END LOOP sub_loop;

  CLOSE cursor_subscriber;
  
  SELECT * FROM TempSubscriberName;
  DROP TEMPORARY TABLE TempSubscriberName;
END #

DELIMITER ;
