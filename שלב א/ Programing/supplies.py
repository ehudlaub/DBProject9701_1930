import pandas as pd
import random
from datetime import datetime, timedelta

# פונקציה ליצירת תאריך אקראי עד 12 ימים לפני פעילות
def get_valid_supply_date(activity_start_date):
    return activity_start_date - timedelta(days=random.randint(0, 12))

# קריאת נתוני הפעילויות כדי להבטיח קשרים תקפים
activity_df = pd.read_csv("activity_data_elderly_home.csv")  # ודא שהקובץ קיים
valid_activity_ids = set(activity_df["activityId"])  # מזהים תקפים של פעילויות

# שמירת רשומות ייחודיות
data = set()

# מספר מקסימלי של ניסיונות להימנע משגיאות
MAX_TRIES = 10000

tries = 0
while len(data) < 400 and tries < MAX_TRIES:  # נייצר 400 שורות ייחודיות או שנעצור לאחר יותר מדי ניסיונות
    tries += 1
    activity_id = random.choice(list(valid_activity_ids))  # מזהה פעילות תקף
    supplier_id = random.randint(1, 30)  # מזהה ספק (בין 1 ל-30)

    # מציאת תאריך התחלת הפעילות
    activity_start_date = pd.to_datetime(activity_df[activity_df["activityId"] == activity_id]["startDate"].values[0])

    # קביעת תאריך אספקה
    supply_date = get_valid_supply_date(activity_start_date)

    # עלות אקראית
    cost = random.randint(100, 5000)

    # בדיקה קפדנית למניעת כפילות במפתח הראשי
    key = (supply_date.strftime("%Y-%m-%d"), supplier_id, activity_id)
    if key not in data:
        data.add((cost, *key))

# המרת הנתונים ל-DataFrame
df = pd.DataFrame(list(data), columns=["cost", "supplyDate", "supplierId", "activityId"])

# שמירה לקובץ CSV
df.to_csv("supplies_data_limited_fixed.csv", index=False)

print("✅ קובץ supplies_data_limited_fixed.csv נוצר בהצלחה וללא שגיאות ייחודיות!")
print(df.head())  # הצגת חמש השורות הראשונות
