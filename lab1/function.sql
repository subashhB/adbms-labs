CREATE OR REPLACE FUNCTION add_notification_function()
	RETURNS TRIGGER
	LANGUAGE plpgsql
	AS
$$
BEGIN
	INSERT INTO notifications (device_token, headers, "message", deeplink, is_notification_sent, created_at, updated_at)
	SELECT udt.device_token, 'Merit Point Updated', 'Your merit point has been updated by teacher', 'https://deeplink.testdeeplink.com/deeplink', false, now(), now()
		FROM merit_points mp
		LEFT JOIN students s ON s.id = mp.student_id
		LEFT JOIN users u ON u.id = s.user_id
		LEFT JOIN user_device_tokens udt ON udt.user_id = u.id
		ORDER BY mp.id desc
		LIMIT 1;
 		
	RETURN NEW;
END;
$$