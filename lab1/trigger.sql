CREATE OR REPLACE TRIGGER add_notification_trigger
  AFTER INSERT
  ON public.merit_points
  FOR EACH ROW
  EXECUTE PROCEDURE add_notification_function();