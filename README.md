# דוח הפרויקט 

## שער

- **שמות מגישים:** אהוד לאוב ובן גולדשטיין
- **שם המערכת:** בית אבות
- **היחידה הנבחרת:** ניהול פעילויות

---

## תוכן עניינים

### שלב 1 – עיצוב, בנייה ואכלוס נתונים
- [1.1 מבוא](#11-מבוא)
- [1.2 תרשימי ERD וDSD](#12-תרשימי-erd-וdsd)
- [1.3 החלטות עיצוב](#13-החלטות-עיצוב)
- [1.4 שיטות אכלוס הנתונים](#14-שיטות-אכלוס-הנתונים)
- [1.5 גיבוי ושיחזור הנתונים](#15-גיבוי-ושיחזור-הנתונים)

### שלב 2 – שאילתות, אילוצים וטרנזקציות
- [2.1 שאילתות SELECT](#21-שאילתות-select)  
- [2.2 שאילתות DELETE וUPDATE](#22-שאילתות-delete-וupdate)      
- [2.3 טרנזקציות: COMMIT וROLLBACK](#23-טרנזקציות-commit-וrollback)
- [2.4 אילוצים באמצעות ALTER TABLE](#24-אילוצים-באמצעות-alter-table) 

### שלב 3 – אינטגרציה ומבטים
- [3.1 תרשימים](#31-תרשימים)
- [3.2 החלטות אינטגרציה](#32-החלטות-אינטגרציה)
- [3.3 עדכון טבלאות לצורך אינטגרציה](#33-עדכון-טבלאות-לצורך-אינטגרציה)
- [3.4 יצירת views ו-שאילתות חדשות](#34-יצירת-views-ו-שאילתות-חדשות)


### שלב 4 – פונקציות, פרוצדורות וטריגרים
- [4.1 רישום דייר לפעילות](#41-רישום-דייר-לפעילות)
- [4.2 דוח על המדריכים](#42-דוח-על-המדריכים)
- [4.3 ניהול תשלומים לספקים](#43-ניהול-תשלומים-לספקים)


### שלב 1 – עיצוב, בנייה ואכלוס נתונים

## 1.1 מבוא

מערכת זו נועדה לנהל את הפעילות החברתית בבית אבות, כולל דיירים, מדריכים, ספקים, פעילויות ומשוב.  
המערכת עוקבת אחר מי משתתף באיזו פעילות, מי מדריך אותה, אילו ספקים סיפקו שירותים ואילו דיירים שלחו משוב.  
מטרת המערכת היא לייעל את תכנון הפעילויות, תיעוד הספקים והערכת שביעות רצון הדיירים.

---
## 1.2 תרשימי ERD וDSD


### ERD – תרשים ישויות וקשרים:

![ERD](שלב%20א/ERD.png)

### DSD – תרשים סכמת הנתונים:

![DSD](שלב%20א/DSD.png)

---

## 1.3 החלטות עיצוב

- הקשר בין דייר לפעילות הוא N:M ולכן הופרד לטבלת `Participates` הכוללת תאריך רישום.
- כל פעילות מנוהלת ע"י מדריך (Instructor) – בקשר 1:N.
- קשר `supplies` מתאר אילו ספקים סיפקו שירות לפעילות מסוימת, כולל תאריך ועלות.
- לכל דייר ניתן להוסיף משוב (`Feedback`) על פעילות, כולל דירוג ותגובה מילולית.
- שמרנו על מפתחות ראשיים ו־Foreign Keys כדי להבטיח עקביות במסד הנתונים.

---

## 1.4 שיטות אכלוס הנתונים

### 1.4.1 יצירת סקריפט בפייתון

![script](./screenshots/script.jpeg)

### 1.4.2 שימוש ב־Mockaroo

![Mockaroo](./screenshots/Mockaroo.png)

---

## 1.5 גיבוי ושיחזור הנתונים

### גיבוי הנתונים

![גיבוי](./screenshots/backup.png)

### שיחזור הנתונים

![שיחזור](./screenshots/toreturn.png)









### שלב 2 – שאילתות, אילוצים וטרנזקציות

## 2.1 שאילתות SELECT

### שאילתה 1 – ממוצע פידבק למדריכים
ברצוננו לבדוק אילו מדריכים קיבלו פידבק חיובי באופן עקבי. נבחן מהם המדריכים אשר ממוצע ציוני הפידבק עבור הפעילויות שהם הובילו גבוה מ־3.
![שאילתה 1](./screenshots/query1.png)

---

### שאילתה 2 – דיירים שנולדו באפריל או מאי ורשומים לפעילות פעילה
נרצה לאתר דיירים שנולדו בחודשים אפריל או מאי, ורשומים לפעילות שעדיין לא הסתיימה, כדי שנוכל להפתיע אותם במהלך הפעילות ולציין את יום הולדתם.
![שאילתה 2](./screenshots/query2.png)

---

### שאילתה 3 – ספקים פעילים השנה וסיכום הוצאות
נרצה לבחון אילו ספקים היו פעילים השנה וסיפקו שירותים לפעילויות שונות בבית האבות. בנוסף, נרצה לדעת כמה פעמים כל ספק סיפק שירות ומה הייתה עלות השירות הכוללת — לצורך בקרה תקציבית ואפשרות להמשך התקשרות.
![שאילתה 3](./screenshots/query3.png)

---

### שאילתה 4 – דיירים חדשים שלא השתתפו בפעילות
נרצה לבדוק אילו דיירים הצטרפו בשלוש השנים האחרונות ועדיין לא השתתפו באף פעילות. מידע זה יסייע בזיהוי דיירים חדשים שאינם משולבים בפעילות החברתית וייתכן שיזדקקו לעידוד או ליווי נוסף.
![שאילתה 4](./screenshots/query4.png)

---

### שאילתה 5 – ספקים שסיפקו ציוד אומנות לפעילות אמנותית
נרצה לדעת אילו ספקים מסוג "Art Supplies" סיפקו בפועל שירותים לפעילויות בתחום האמנות ("Art"), וכמה פעמים כל ספק סיפק שירות כזה, כדי שנוכל ליצור קשר עם ספקים מנוסים ולבחון חידוש או הרחבת ההתקשרות.
![שאילתה 5](./screenshots/query5.png)

---

### שאילתה 6 – דיירים ששלחו פידבק נמוך בשלוש השנים האחרונות
נרצה לבדוק אילו דיירים נתנו פידבק נמוך (ציון 2 ומטה) לפעילויות שהשתתפו בהן בשלוש השנים האחרונות. המידע מאפשר לזהות חוסר שביעות רצון מתמשך ולקבל החלטות בנוגע לשיפור תכנים או הדרכה.
![שאילתה 6](./screenshots/query6.png)

---

### שאילתה 7 – מדריכים פנימיים לפעילויות מוזיקה
נרצה להציג את כל המדריכים הפנימיים (שאינם חיצוניים) שהדריכו פעילויות מהתחום "Music", ולבחון את ממוצע ציוני הפידבק שקיבלו.
![שאילתה 7](./screenshots/query7.png)

---

### שאילתה 8 – מדריכים עם שיעור השתתפות ממוצע גבוה
נרצה לבדוק אילו מדריכים הובילו פעילויות שבהן שיעור ההשתתפות הממוצע היה מעל 50% מכלל המקומות האפשריים. נציג עבור כל מדריך את תחום ההתמחות שלו, מספר הפעילויות שהעביר, ואת שיעור ההשתתפות הממוצע.
![שאילתה 8](./screenshots/query8.png)


## 2.2 שאילתות DELETE וUPDATE
### שאילתת מחיקה 1 - מחיקת ספק ללא חוזה
נרצה למחוק ספק שאין לו חוזה משנת 2003 ובנוסף סך ההוצאות מכל הההפקות שהוא סיפק קטן ממיליון ש"ח.
שאילתת משנה שמחפשת את כל הספקים שהחוזה שלהם התחיל לפני 2003.
מצטרפת לטבלת supplies כדי לחשב את סך כל ההוצאות (SUM(sp.cost)) על אותו ספק.
מסננת רק ספקים עם סכום כולל של פחות ממיליון ש"ח.
לבסוף, מוחקת אותם מהטבלה Supplier.
![שאילתת מחיקה 1](./screenshots/delete1.png)
### שאילתת מחיקה 2 - מחיקת מדריך עם פידבק נמוך מ-3
אנחנו בודקים את טבלת Activity, שמכילה את העמודות instructorId ו־feedback.
מחשבים את ממוצע הפידבק לכל instructorId.
בוחרים רק את המדריכים שהממוצע שלהם נמוך מ־3.
לאחר מכן מוחקים את אותם מדריכים מטבלת Instructor.
![שאילתת מחיקה 2](./screenshots/delete2.png)
### שאילתת מחיקה 3 -נמחק פידבקים לפעילויות עם דירוג נמוך מ־3
לאחר שמחקנו מדריך עם פידבק נמוך נרצה גם למחוק את הפדבקים עצמם שלא רלוונטים יותר ולכן נמחק אותם על ידי חיבור בין Feedback ל־Activity.
מסננים רק פידבקים לפעילויות שקיבל פידבק נמוך.
![שאילתת מחיקה 3](./screenshots/delete3.png)
### שאילתת עדכון 1 - עדכון דיירים עם השתתפות גבוהה כפעילים 
נרצה לעדכן את סטטוס הפעילות של הדיירים על ידי הוספת עמודה חדשה לטבלת Resident בשם isActive מסוג BOOLEAN.
לאחר הוספת העמודה, נעדכן אותה כך שכל דייר שהשתתף לפחות בשתי פעילויות בשנתיים האחרונות יסומן כפעיל (TRUE), ואחרים יסומנו כלא פעילים (FALSE).
עדכון זה מאפשר לזהות דיירים פחות מעורבים בפעילויות ולהתאים עבורם פעולות עידוד או מעקב.
![שאילתת עדכון 1](./screenshots/update1.png)
### שאילתת עדכון 2 - עדכון תוכן המשוב לאותיות קטנות
נבצע עדכון על עמודת ה־comment בטבלת Feedback כך שכל התגובות יכילו רק אותיות קטנות. מטרת העדכון היא לאחיד את פורמט התוכן ולשפר את קריאות הנתונים לצורך עיבוד או הצגה.
![שאילתת עדכון 2](./screenshots/update2.png)
### שאילתת עדכון 3 - עדכון ספקים יקרים
נוסיף עמודה חדשה לטבלת `Supplier` בשם `isExpensive`, שתציין האם ספק נחשב ליקר.  
העמודה תתמלא אוטומטית לפי ממוצע עלות העסקאות של אותו ספק: אם הממוצע גבוה מ־500 – הערך יסומן כ־TRUE, אחרת FALSE.  
כך נוכל להבחין בין ספקים יקרים וזולים לצורכי בקרה תקציבית והחלטות התקשרות עתידיות.
![שאילתת עדכון 3](./screenshots/update3.png)
## 2.3 טרנזקציות: COMMIT וROLLBACK
בפרק הקודם (2.2) ביצענו מספר עדכונים ומחיקות כחלק מטרנזקציות, ובסיום כל אחת מהן החלטנו אם לשמור או לבטל את השינויים לפי התאמתם למערכת.

בוצע COMMIT (שמירה סופית של השינויים) עבור:

שאילתת מחיקה 1
![מחיקה 1](./screenshots/commit1.png)
שאילתת מחיקה 2
![מחיקה 2](./screenshots/commit2.png)
שאילתת עדכון 2
![עדכון 2](./screenshots/commit3.png)


בוצע ROLLBACK (ביטול השינויים) עבור:

שאילתת מחיקה 3
![מחיקה 3](./screenshots/rollback1.png)
שאילתת עדכון 1
![עדכון 1](./screenshots/rollback3.png)
שאילתת עדכון 3
![עדכון 3](./screenshots/rollback4.png)




## 2.4 אילוצים באמצעות ALTER TABLE
### אילוץ 1: NOT NULL בטבלת Activity  
הוספת אילוץ שמחייב את שדה `title` להיות לא ריק.

![הוספת אילוץ 1](./screenshots/constraint1_add.png) 
הוספת שורה עם ערך ריק לשדה title, דבר שגרם לשגיאה עקב אילוץ NOT NULL
![שגיאה אילוץ 1](./screenshots/constraint1_error.png)

### אילוץ 2: CHECK בטבלת Feedback  
הוספת תנאי שמוודא שהדירוג (`rating`) נמצא בין 1 ל־5.

![הוספת אילוץ 2](./screenshots/constraint2_add.png)  
הוספת שורה עם ערך דירוג 7, החורג מהטווח המותר באילוץ CHECK.
![שגיאה אילוץ 2](./screenshots/constraint2_error.png)


### אילוץ 3: DEFAULT בטבלת Supplier  
הוספת ערך ברירת מחדל `General` לעמודה `serviceType`.

![הוספת אילוץ 3](./screenshots/constraint3_add.png)  
הוספת שורה ללא ציון סוג שירות – הערך הושלם אוטומטית כ־General בהתאם לערך ברירת המחדל.
![שגיאה אילוץ 3](./screenshots/constraint3_error.png)

---
### שלב 3 – אינטגרציה ומבטים

בשלב זה ביצענו אינטגרציה בין מסד הנתונים שלנו לבין מסד הנתונים של אגף נוסף (שהתקבל מגיבוי). האינטגרציה כללה בניית תרשימים, תכנון מחדש של המערכת, ביצוע שינויים בסכמת הנתונים, והוספת מבטים לייצוג מידע בצורה ממוקדת.

---

## 3.1 תרשימים

#### 3.1.1 תרשים DSD שהתקבל לאחר ניתוח הגיבוי.
![NEW DSA](שלב%20ג/newDepartmentDsd.png)


#### 3.1.2 סכמת ERD שהתקבלה לאחר הינדוס לאחור.
![NEW ERD](שלב%20ג/newDepartmentErd.png)


#### 3.1.3 סכמת ERD משולבת.
![ERD](שלב%20ג/newErd.png)

#### 3.1.4 תרשים DSD משולב.
![DSA](שלב%20ג/newDsd.png)


## 3.2 החלטות אינטגרציה

---
במהלך המיזוג נדרשו מספר התאמות:

Resident:

הישות שלהם הייתה פשוטה יותר ולכן בחרנו לשלב את השדות שלה בתוך הישות שלנו. שמרנו על שמות השדות הקיימים אצלנו, תוך התאמה במידת הצורך.

Activity / Event:

אוחדו לישות אחת בשם Activity. בוצעו התאמות לשמות שדות: השדה name הפך ל־title, eventDate הפך ל־startDate, והוספנו את השדה eventLocation לישות המאוחדת, שלא היה קיים במערכת שלנו.

VisitingEvent / Participates:

שתי היישויות מתארות השתתפות דייר בפעילות. בחרנו לשמור את הישות Participates שלנו, שכן היא מכילה תכונה נוספת (registrationDate) וכן מתארת טוב יותר את הקשר הקיים.

שאר הישויות (כגון: room, maintenance_rep, inventory, staff_member, meal) הן ייחודיות למערכת של האגף החדש, ולכן שולבו בתרשים המשותף כפי שהן – ללא שינוי.

החלטות אלו נועדו לשמר עקביות, למנוע כפילויות ולשלב את המידע בצורה אינטגרטיבית בין האגפים.


## 3.3 עדכון טבלאות לצורך אינטגרציה
---
בשלב זה ביצענו שינויים במסד הנתונים כדי לשלב את טבלת `resident` שהתקבלה מהאגף הנוסף, תוך שמירה על הקשרים הקיימים בטבלה שלנו. להלן סדר הפעולות:


שלב 1 - מיזוג ישות resident:
-   הוספת עמודה room_id לטבלת resident1
```sql
ALTER TABLE resident1 ADD COLUMN room_id INT;
```

- הוספת מפתח זר לטבלה resident
```sql
ALTER TABLE resident1
ADD CONSTRAINT fk_room FOREIGN KEY (room_id)
REFERENCES room(room_id);
```

- עדכון הערכים בעמודה room_id מהטבלה שהתקבלה
```sql
UPDATE resident1 r1
SET room_id = r2.room_id
FROM resident r2
WHERE r1.residentId = r2.resident_id;
```
שלב 2 - מיזוג 'event' ו'activity' לישות אחת:
-   הוספת עמודה activity_location לטבלת activity
```sql
ALTER TABLE Activity ADD COLUMN activity_location VARCHAR(100);
``` 
- מיזוג טבלת event לתוך Activity
```sql
INSERT INTO Activity (
  activityId, startDate, endDate, title,
  maxParticipants, currentParticipants, instructorId, activity_location
)
SELECT 
  event_id,
  event_date,
  event_date,
  event_name,
  100,
  0,
  1,
  event_location
FROM event
WHERE event_id NOT IN (SELECT activityId FROM Activity);
```
שלב 3 - מיזוג הקשר 'visiting_event' והישות החלשה 'participates' לישות חלשה אחת:
- מיזוג טבלת 'visiting_event' לתוך טבלת 'participates'
```sql
INSERT INTO Participates (residentId, activityId, registrationDate)
SELECT 
  ve.resident_id,
  ve.event_id,
  a.startDate
FROM visiting_event ve
JOIN Activity a ON ve.event_id = a.activityId
WHERE (ve.resident_id, ve.event_id) NOT IN (
  SELECT p.residentId, p.activityId
  FROM Participates p
);
``` 

## 3.4  יצירת views ו-שאילתות חדשות
---
נבנה view ושאילתות חדשות על בסיס הוספת הטבלאות והעמודות החדשות.
#### 3.4.1 מבט מהאגף המקורי שלנו
ניצור מבט בשם resident_activities_view שמשלב בין מידע על דיירים לבין מידע על פעילויות שהם משתתפים בהן.
```sql
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
```
נשלוף את הנתונים מהמבט.
![resident_activities_view](שלב%20ג/resident_activities_view.png)


ניצור שאילתה המבוססת על המבט resident_activities_view, השאילתה מציגה את מספר הפעיליות בהם השתתף כל דייר.

```sql
SELECT residentid, name, COUNT(*) AS total_activities
FROM resident_activities_view
GROUP BY residentid, name
ORDER BY total_activities DESC;
```
![resident_activities_query1](שלב%20ג/resident_activities_query1.png)

ניצור שאילתה נוספת המבוססת על מבט resident_activities_view, שאילתה זאת מציגה את מספר הפעיליות לפי מקום.
```sql
SELECT activity_location, COUNT(*) AS activity_count
FROM resident_activities_view
GROUP BY activity_location
ORDER BY activity_count DESC;
```
![resident_activities_query2](שלב%20ג/resident_activities_query2.png)


#### 3.4.2 מבט מהאגף שהתקבל
ניצור מבט נוסף בשם staff_tasks_view שמשלב בין מידע על בקשות תחזוקה לבין מידע על פרטי העובדים המטפלים בבקשות התחזוקה.
```sql
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
```
נשלוף את הנתנונים מהמבט.
![staff_tasks_view](שלב%20ג/staff_tasks_view.png)
ניצור שאילתה המבוססת על המבט staff_tasks_view, השאילתה מציגה את מספר בקשות התחזוקה שכל עובד טיפל בהן בפועל.
```sql
SELECT 
  staff_member_id,
  staff_member_name,
  COUNT(*) AS total_requests
FROM staff_tasks_view
GROUP BY staff_member_id, staff_member_name
ORDER BY total_requests DESC;
```
![staff_tasks_query1](שלב%20ג/staff_tasks_query1.png)
ניצור שאילתה נוספת המבוססת על מבט staff_tasks_view, שאילתה זאת מציגה את מספר בקשות התחזוקה שעדיין פתוחות, עבור כל תפקיד במערכת.
```sql
SELECT 
  job_title,
  COUNT(*) AS open_requests
FROM staff_tasks_view
WHERE req_status = 'open'
GROUP BY job_title
ORDER BY open_requests DESC;
```
![staff_tasks_query2](שלב%20ג/staff_tasks_query2.png)


### שלב 4 – פונקציות, פרוצדורות וטריגרים
בשלב זה נכתוב תוכניות PL/pgSQL על טבלאות בסיס הנתונים המורחב שלנו. נרצה לאפשר מגוון פעולות ופרוצדורות בהם נוכל להשתמש.
## 4.1 רישום דייר לפעילות
---
- פרוצדורת רישום דייר לפעילות
הפרוצדורה `register_resident_to_activity` נועדה לרשום דייר לפעילות, בתנאי שהפעילות עדיין מתקיימת וטרם הגיעה למכסת המשתתפים. אם אחד התנאים לא מתקיים, נזרקת חריגה מתאימה. לאחר ההרשמה, מתבצע עדכון של מספר המשתתפים הנוכחי.

```sql
CREATE OR REPLACE PROCEDURE register_resident_to_activity(
    p_resident_id INT,
    p_activity_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_max INT;
    v_current INT;
    v_end DATE;
BEGIN
    SELECT maxparticipants, currentparticipants, enddate
    INTO v_max, v_current, v_end
    FROM Activity
    WHERE activityid = p_activity_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Activity % not found', p_activity_id;
    END IF;

    IF v_end < CURRENT_DATE THEN
        RAISE EXCEPTION 'Activity % has already ended', p_activity_id;
    END IF;

    IF v_current >= v_max THEN
        RAISE EXCEPTION 'Activity % is full', p_activity_id;
    END IF;

    INSERT INTO participates(residentid, activityid, registrationdate)
    VALUES (p_resident_id, p_activity_id, CURRENT_DATE);

    UPDATE Activity
    SET currentparticipants = currentparticipants + 1
    WHERE activityid = p_activity_id;

    RAISE NOTICE 'Resident % successfully registered to activity %', p_resident_id, p_activity_id;
END;
$$;
```
כעת ננסה לרשום דייר לפעילות שכבר הסתיימה ונראה הודעה מתאימה.
![register_resident_to_activity](שלב%20ד/register_resident_to_activity.png)

- טריגר לרישום/מחיקת דייר לפעילות/מפעילות
הטריגר update_current_participants_trigger מופעל לאחר הכנסת או מחיקת רשומה בטבלת participates. מטרתו לשמור על עדכון אוטומטי של עמודת currentparticipants בטבלת activity – מספר המשתתפים הנוכחיים בפעילות:
כאשר דייר נרשם לפעילות (INSERT), הטריגר מעלה את מספר המשתתפים הנוכחי ב־1.
כאשר דייר מוסר מפעילות (DELETE), הטריגר מפחית את מספר המשתתפים ב־1.
```sql
CREATE OR REPLACE FUNCTION update_current_participants()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Activity
        SET currentparticipants = currentparticipants + 1
        WHERE activityid = NEW.activityid;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Activity
        SET currentparticipants = currentparticipants - 1
        WHERE activityid = OLD.activityid;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_inc_current_participants
AFTER INSERT ON participates
FOR EACH ROW
EXECUTE FUNCTION update_current_participants();

CREATE TRIGGER trg_dec_current_participants
AFTER DELETE ON participates
FOR EACH ROW
EXECUTE FUNCTION update_current_participants();
```
כעת נראה שכאשר נרשום דייר לפעילות השדה currentparticipants בטבלת activity יועדכן בהתאם.
![trigar1_resident_to_activity](שלב%20ד/trigar1_resident_to_activity.png)
![trigar2_resident_to_activity](שלב%20ד/trigar2_resident_to_activity.png)

## 4.2 דוח על המדריכים
---
נרצה לספק דוח מסכם על כלל המדריכים במערכת. הדוח כולל מידע רלוונטי כגון מספר הפעילויות שהעביר כל מדריך, ותק בשנים, ממוצע הפידבקים שקיבל, וממוצע המשתתפים בפעילויות שהעביר. הדוח מתבצע באמצעות פונקציה print_all_instructors_report.
```sql
CREATE OR REPLACE FUNCTION print_all_instructors_report()
RETURNS VOID AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT 
            i.instructorId,
            i.name AS instructor_name,
            COUNT(a.activityId) AS total_activities,
            DATE_PART('year', AGE(CURRENT_DATE, i.startDate)) AS years_of_experience,
            ROUND(AVG(f.rating), 2) AS avg_feedback,
            ROUND(AVG(a.currentParticipants), 2) AS avg_participants
        FROM Instructor i
        LEFT JOIN Activity a ON i.instructorId = a.instructorId
        LEFT JOIN Feedback f ON a.activityId = f.activityId
        GROUP BY i.instructorId, i.name, i.startDate
        ORDER BY COUNT(a.activityId) DESC
    LOOP
        RAISE NOTICE 'Instructor: %, Activities: %, Experience: %, Avg Feedback: %, Avg Participants: %',
            rec.instructor_name, rec.total_activities, rec.years_of_experience, rec.avg_feedback, rec.avg_participants;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
```
לבחינה ויזואלית של תוצאת הדוח ניתן להפעיל את הפונקציה באמצעות בלוק אנונימי:

```sql
DO $$
DECLARE
    cur refcursor;
    rec RECORD;
BEGIN
    cur := get_all_instructors_report();

    RAISE NOTICE '--- Instructors Report ---';

    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'ID: %, Name: %, Activities: %, Experience: %, Avg Feedback: %, Avg Participants: %',
            rec.instructorId, rec.instructor_name, rec.total_activities,
            rec.years_of_experience, rec.avg_feedback, rec.avg_participants;
    END LOOP;

    CLOSE cur;
END;
$$;
```
ומתקבלת ההדפסה:

![print_all_instructors_report](שלב%20ד/print_all_instructors_report.png) 

## 4.3 ניהול תשלומים לספקים
---
נרצה להוסיף למערכת יכולת לנהל תשלומים עבור אספקת מוצרים לפעילויות. 
- הרחבת הסכימה
נוסיף עמודה wasPaid מסוג BOOLEAN לטבלה Supplies, לציון האם התשלום בוצע. בנוסף ניצור טבלה חדשה payment_log לשמירת יומן פעולות תשלום, הכוללת את שדות log_id, supplier_id, activity_id, supply_date, log_date ו־final_paid.

```sql
ALTER TABLE supplies ADD COLUMN wasPaid BOOLEAN DEFAULT FALSE;

CREATE TABLE payment_log (
    log_id SERIAL PRIMARY KEY,
    supplier_id INT NOT NULL,
    supply_date DATE NOT NULL,
    activity_id INT NOT NULL,
    original_cost NUMERIC NOT NULL,
    final_paid NUMERIC NOT NULL,
    log_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (supplier_id, supply_date, activity_id)
        REFERENCES supplies(supplierId, supplyDate, activityId)
);
```

- פונקציה לחישוב ריבית
הפונקציה calculate_late_fee מחזירה את הסכום לתשלום לאחר הוספת ריבית של 3% עבור כל שנת איחור:

```sql
CREATE OR REPLACE FUNCTION calculate_late_fee(
    p_cost NUMERIC,
    p_supply_date DATE
) RETURNS NUMERIC AS $$
DECLARE
    years_late INT;
BEGIN
    years_late := DATE_PART('year', AGE(CURRENT_DATE, p_supply_date));
    RETURN ROUND(p_cost * POWER(1.03, years_late), 2);
END;
$$ LANGUAGE plpgsql;
```

- פרוצדורת תשלום
הפרוצדורה mark_supply_as_paid_row מסדירה את התשלום עבור שורת אספקה נתונה:
היא מבצעת בדיקות תקינות (קיום ההזמנה, וידוא שטרם שולם), מחשבת את סכום התשלום בפועל באמצעות הפונקציה calculate_late_fee, מעדכנת את סטטוס התשלום (wasPaid), ומחזירה את הסכום ששולם בפועל כערך OUT.
```sql
CREATE OR REPLACE PROCEDURE mark_supply_as_paid_row(
    IN p_supply_row supplies,
    OUT p_amount_paid NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_exists supplies%ROWTYPE;
BEGIN
    SELECT * INTO v_exists
    FROM supplies
    WHERE supplierId = p_supply_row.supplierId
      AND supplyDate = p_supply_row.supplyDate
      AND activityId = p_supply_row.activityId;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Supply not found';
    END IF;

    IF v_exists.waspaid THEN
        RAISE EXCEPTION 'Supply was already marked as paid';
    END IF;

    UPDATE supplies
    SET waspaid = TRUE
    WHERE supplierId = p_supply_row.supplierId
      AND supplyDate = p_supply_row.supplyDate
      AND activityId = p_supply_row.activityId;

    p_amount_paid := calculate_late_fee(v_exists.cost, v_exists.supplyDate);

END;
$$;
```

- טריגר לתיעוד התשלום
הטריגר trg_log_payment מופעל לאחר עדכון השדה wasPaid ל־TRUE. בעת ההפעלה נרשמת הפעולה בטבלת payment_log, יחד עם חישוב הסכום הסופי:
```sql
CREATE OR REPLACE FUNCTION log_payment_update() RETURNS TRIGGER AS $$
DECLARE
    v_paid NUMERIC;
BEGIN
    v_paid := calculate_late_fee(NEW.cost, NEW.supplyDate);

    INSERT INTO payment_log (
        supplier_id,
        supply_date,
        activity_id,
        original_cost,
        final_paid
    ) VALUES (
        NEW.supplierId,
        NEW.supplyDate,
        NEW.activityId,
        NEW.cost,
        v_paid
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_log_payment
AFTER UPDATE OF waspaid ON supplies
FOR EACH ROW
WHEN (NEW.waspaid = TRUE AND OLD.waspaid = FALSE)
EXECUTE FUNCTION log_payment_update();
```
- תוכנית ראשית להרצת התשלום.
```sql
DO $$
DECLARE
    v_row supplies;
    v_paid NUMERIC;
BEGIN
    SELECT * INTO v_row
    FROM supplies
    WHERE supplierId = 99
      AND supplyDate = DATE '2020-06-15'
      AND activityId = 999;

    CALL mark_supply_as_paid_row(v_row, v_paid);
    RAISE NOTICE 'its paid % ₪', v_paid;
END;
$$;
```
וכעת התשלום התעדכן בטבלה

![payment](שלב%20ד/payment.png) 



