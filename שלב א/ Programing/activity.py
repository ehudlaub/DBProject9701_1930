import pandas as pd
import random
from datetime import datetime, timedelta

# Function to generate a random date
def random_date(start, end):
    delta = end - start
    return start + timedelta(days=random.randint(0, delta.days))

# List of elderly home activities
activity_titles = ["Cooking", "Drama", "Art", "Reading", "Gardening", "Dancing", "Music", "Chess", "Exercise", "Creative Writing"]

# Date range for activities
start_date_range = datetime(2024, 1, 1)
end_date_range = datetime(2026, 12, 31)

# Generate data for the table
data = []
for i in range(1, 401):  # 400 rows
    start_date = random_date(start_date_range, end_date_range)  # Random start date
    end_date = start_date + timedelta(days=random.randint(1, 12))  # Duration of 1-12 days
    
    max_participants = random.randint(5, 30)  # Max participants (adjusted for elderly home)
    current_participants = random.randint(0, max_participants)  # Current participants (≤ max)
    
    data.append([
        i,  # activityId
        end_date.strftime("%Y-%m-%d"),  # endDate
        random.choice(activity_titles),  # title (elderly home activity)
        start_date.strftime("%Y-%m-%d"),  # startDate
        max_participants,  # maxParticipants
        current_participants,  # currentParticipants
        random.randint(1, 15)  # instructorId (assuming 15 instructors available)
    ])

# Create DataFrame
df = pd.DataFrame(data, columns=["activityId", "endDate", "title", "startDate", "maxParticipants", "currentParticipants", "instructorId"])

# Save to CSV file
df.to_csv("activity_data_elderly_home.csv", index=False)

print("✅ File 'activity_data_elderly_home.csv' has been created successfully!")
print(df.head())  # Display the first five rows
