# דוח הפרויקט – שלב א'

## שער

- **שמות מגישים:** אהוד לאוב ובן גולדשטיין
- **שם המערכת:** בית אבות
- **היחידה הנבחרת:** ניהול פעילויות

---

## תוכן עניינים

1. מבוא
2. תרשימי ERD ו־DSD
3. החלטות עיצוב
4. שיטות אכלוס הנתונים
5. גיבוי ושחזור

---

## 1. מבוא

מערכת זו נועדה לנהל את הפעילות החברתית בבית אבות, כולל דיירים, מדריכים, ספקים, פעילויות ומשוב.  
המערכת עוקבת אחר מי משתתף באיזו פעילות, מי מדריך אותה, אילו ספקים סיפקו שירותים ואילו דיירים שלחו משוב.  
מטרת המערכת היא לייעל את תכנון הפעילויות, תיעוד הספקים והערכת שביעות רצון הדיירים.

---

## 2. תרשימי ERD ו־DSD

### ERD – תרשים ישויות וקשרים:

![ERD](שלב%20א/ERD.png)

### DSD – תרשים סכמת הנתונים:

![DSD](שלב%20א/DSD.png)

---

## 3. החלטות עיצוב

- הקשר בין דייר לפעילות הוא N:M ולכן הופרד לטבלת `Participates` הכוללת תאריך רישום.
- כל פעילות מנוהלת ע"י מדריך (Instructor) – בקשר 1:N.
- קשר `supplies` מתאר אילו ספקים סיפקו שירות לפעילות מסוימת, כולל תאריך ועלות.
- לכל דייר ניתן להוסיף משוב (`Feedback`) על פעילות, כולל דירוג ותגובה מילולית.
- שמרנו על מפתחות ראשיים ו־Foreign Keys כדי להבטיח עקביות במסד הנתונים.

---

## 4. שיטות אכלוס הנתונים

### 4.1 הכנסת נתונים ידנית

![הזנה ידנית](./screenshots/manual_insert.png)

### 4.2 טעינת CSV דרך pgAdmin

![הזנת CSV](./screenshots/csv_import.png)

### 4.3 שימוש ב־Mockaroo

![Mockaroo](./screenshots/mockaroo.png)

---

## 5. גיבוי ושחזור נתונים

### גיבוי הנתונים

![גיבוי](./screenshots/backup.png)

### שחזור הנתונים

![שחזור](./screenshots/restore.png)

---
