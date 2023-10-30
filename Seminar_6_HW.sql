DROP FUNCTION IF EXISTS delete_user;

DELIMITER //
CREATE FUNCTION delete_user (deleted_user_id BIGINT UNSIGNED)
RETURNS BIGINT DETERMINISTIC
	BEGIN
		DECLARE result_id INT;
		
		DELETE FROM vk.messages WHERE from_user_id = deleted_user_id OR to_user_id = deleted_user_id;
		DELETE FROM vk.likes WHERE user_id = deleted_user_id;
		DELETE FROM vk.media WHERE user_id = deleted_user_id;
		DELETE FROM vk.profiles WHERE user_id = deleted_user_id;
		DELETE FROM users  WHERE id = deleted_user_id;
	
		SET result_id = deleted_user_id;
	
		RETURN result_id;
	END//
DELIMITER ;

SELECT delete_user(1);


DROP PROCEDURE IF EXISTS pr_delete_user;

DELIMITER //

CREATE PROCEDURE pr_delete_user(in deleted_user_id BIGINT UNSIGNED)
	BEGIN 
		START TRANSACTION;
	  		DELETE FROM vk.messages WHERE from_user_id = deleted_user_id OR to_user_id = deleted_user_id;
			DELETE FROM vk.likes WHERE user_id = deleted_user_id;
			DELETE FROM vk.media WHERE user_id = deleted_user_id;
			DELETE FROM vk.profiles WHERE user_id = deleted_user_id;
			DELETE FROM users  WHERE id = deleted_user_id;
	  	COMMIT;
	 	SELECT id FROM users
	 	WHERE id = deleted_user_id;
	 END// 
  
DELIMITER ;

 

--	Вызов продедуры / результаты
--	Каждый раз при вызове процедуры с одним и тем же параметром мы видим разный результат.
CALL sp_friendship_offers(1);
CALL sp_friendship_offers(3);
