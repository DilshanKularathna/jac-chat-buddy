import json

# Data to be saved
data = {
    "user_data": {
        "First_name": "David",
        "age_years": 45,
        "Gender": "Male",
        "Height_cm": 175,
        "Weight_kg": 85,
        "BMI": 27.8,
        "Blood_Pressure_mmHg": (145, 90),
        "Married": True,
        "Smoking_Status": "Former",
        "Alcohol_Intake": "Moderate",
        "Physical_Activity_Level": "Low",
        "Cholesterol_Level_mg_dL": 240,
        "HDL_mg_dL": 40,
        "LDL_mg_dL": 160,
        "Triglycerides_mg_dL": 200,
        "Blood_Glucose_mg_dL": 180,
        "HbA1c_percent": 8.0,
        "Medications": ["Metformin", "Atorvastatin"],
        "Family_History": {
            "Diabetes": True,
            "Heart_Disease": True,
            "Stroke": False
        },
        "Allergies": ["Penicillin"],
        "Regular_Checkups": True,
        "Last_Checkup_Date": "2024-05-10"
    },
    "todo_list": [
        "Monitor blood pressure daily : 04/06/2024",
        "Take medication (Metformin, Atorvastatin) : 05/06/2024",
        "Schedule cardiology appointment : 10/06/2024",
        "Complete blood tests : 15/06/2024",
        "Attend diabetes education class : 20/06/2024",
        "Follow up with dietitian : 25/06/2024",
        "Exercise (30 minutes walk) : 26/06/2024",
        "Annual physical checkup : 01/07/2024",
        "Renew prescription for medications : 02/07/2024",
        "Check cholesterol levels : 05/07/2024",
        "Plan weekend getaway : 28/06/2024"
    ]
}

# Save to JSON file
with open('./user_info.json', 'w') as f:
    json.dump(data, f, indent=4)
