#!/usr/bin/env python3
"""
Download grouped daily (market summary) from Massive API
Author: Your Name
Date: 2026-02-xx
"""

import requests
import json
import time
from datetime import datetime, timedelta

# ======== CONFIGURATION ========
API_KEY = "bwwpb2Xk6p5WL3ZsFrOk207ilN92ZJzE"  # ← Replace with your API key
BASE_URL = "https://api.massive.com/v2/aggs/grouped/locale/us/market/stocks" 
OUTPUT_DIR = "./massive_daily"   # Directory to store output files

HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Accept": "application/json"
}

# ======== DATE RANGE SETUP ========
# Set your date range here (YYYY-MM-DD)
START_DATE = "2026-01-01"
END_DATE   = "2026-01-10"  # inclusive

# Convert strings to date objects
start_dt = datetime.fromisoformat(START_DATE)
end_dt   = datetime.fromisoformat(END_DATE)

# ======== UTILS ========
def ensure_output_dir():
    import os
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)

def formatted_date(dt):
    return dt.strftime("%Y-%m-%d")

def fetch_daily_summary(date_str):
    """
    Fetch grouped daily market summary for a given date.
    """
    url = f"{BASE_URL}/{date_str}"
    params = {
        "adjusted": True,
        "include_otc": False
    }

    response = requests.get(url, headers=HEADERS, params=params)
    response.raise_for_status()
    return response.json()

# ======== MAIN LOOP ========
def run():
    ensure_output_dir()
    dt = start_dt

    while dt <= end_dt:
        date_str = formatted_date(dt)
        output_file = f"{OUTPUT_DIR}/{date_str}.json"

        try:
            print(f"Fetching {date_str} ...")
            data = fetch_daily_summary(date_str)
            
            # Save to disk
            with open(output_file, "w") as f:
                json.dump(data, f, indent=2)
            print(f"Saved: {output_file}")

        except requests.HTTPError as e:
            print(f"Failed on {date_str}: {e}")
        
        # next day
        dt += timedelta(days=1)
        time.sleep(20)  # be polite and avoid rate limits

if __name__ == "__main__":
    run()
