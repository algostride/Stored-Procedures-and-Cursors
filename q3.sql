DELIMITER #

DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;
CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE existingMaxSubscriberID INT DEFAULT 0;
    IF NOT EXISTS(SELECT 1 FROM Subscribers WHERE SubscriberName = subname) THEN
        SELECT MAX(SubscriberID) INTO existingMaxSubscriberID FROM Subscribers;
        INSERT INTO Subscribers(SubscriberID, SubscriberName, SubscriptionDate) VALUES (existingMaxSubscriberID + 1, subName, CURDATE());
        SELECT 'Subscriber added' AS message;
    ELSE
        SELECT 'Subscriber with this name already exists' AS message;
    END IF;
END #

DELIMITER ;
