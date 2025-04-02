import pandas as pd
import random
from datetime import datetime, timedelta

# קריאת נתוני "Participates" כדי להבטיח שהמפתחות הזרים קיימים
participates_df = pd.read_csv("participates_data_limited.csv")  # ודא שהקובץ קיים
valid_participations = set(zip(participates_df["activityId"], participates_df["residentId"], participates_df["registrationDate"]))

# משתנים לשמירת הנתונים
feedback_data = set()  # שימוש בסט למניעת כפילויות

# יצירת 400 שורות נתוני דמה
while len(feedback_data) < 400:
    feedback_id = len(feedback_data) + 1
    activity_id, resident_id, registration_date = random.choice(list(valid_participations))
    registration_date = pd.to_datetime(registration_date)  # המרת תאריך לפורמט מתאים
    feedback_date = registration_date + timedelta(days=random.randint(0, 12))  # תאריך בטווח של 12 ימים מהרישום
    rating = random.randint(1, 5)  # דירוג בין 1 ל-5
    comment = random.choice([
        "Great activity!", "Very enjoyable", "Could be better", "Loved it!", "Not bad", "Excellent experience"
    ])
    
    feedback_data.add((feedback_date.strftime("%Y-%m-%d"), comment, feedback_id, rating, activity_id, resident_id))

# יצירת DataFrame ושמירתו כקובץ CSV
df = pd.DataFrame(list(feedback_data), columns=["feedbackDate", "comment", "feedbackId", "rating", "activityId", "residentId"])
df.to_csv("feedback_data_limited.csv", index=False)

print("✅ קובץ feedback_data_limited.csv נוצר בהצלחה!")
print(df.head())  # הצגת חמש השורות הראשונות
