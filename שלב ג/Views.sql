CREATE VIEW resident_activities_view AS
SELECT 
    r.residentid,
    r.name,
    r.birthDate,
    a.activityid,
    a.title,
    a.startdate,
    a.activity_location
FROM resident r
JOIN participates p ON r.residentid = p.residentid
JOIN activity a ON p.activityid = a.activityid;


SELECT residentid, name, COUNT(*) AS total_activities
FROM resident_activities_view
GROUP BY residentid, name
ORDER BY total_activities DESC;


SELECT activity_location, COUNT(*) AS activity_count
FROM resident_activities_view
GROUP BY activity_location
ORDER BY activity_count DESC;


CREATE VIEW staff_tasks_view AS
SELECT 
    s.staff_member_id,
    s.staff_member_name,
    s.job_title,
    r.request_id,
    r.req_description,
    r.req_status
FROM staff_member s
JOIN maintenance_req r ON s.staff_member_id = r.staff_member_id;

SELECT * FROM staff_tasks_view;


SELECT 
  staff_member_id,
  staff_member_name,
  COUNT(*) AS total_requests
FROM staff_tasks_view
GROUP BY staff_member_id, staff_member_name
ORDER BY total_requests DESC;


SELECT 
  job_title,
  COUNT(*) AS open_requests
FROM staff_tasks_view
WHERE req_status = 'open'
GROUP BY job_title
ORDER BY open_requests DESC;