DELIMITER #

DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;
CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
  SELECT 
    s.SubscriberID,
    s.SubscriberName,
    shows.Title AS ShowTitle,
    wh.WatchTime
  FROM Subscribers s
  LEFT JOIN WatchHistory wh ON wh.SubscriberID = s.SubscriberID
  LEFT JOIN Shows shows ON wh.ShowID = shows.ShowID
  WHERE s.SubscriberID = sub_id;   
END #

DELIMITER ;
