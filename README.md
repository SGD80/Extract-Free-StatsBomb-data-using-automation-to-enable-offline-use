# ⚽ Batch Download & Save StatsBomb Champions League Event Data (R Script)

This R project automates the extraction, cleaning, and local storage of Champions League match event data from the [StatsBomb Open Data](https://github.com/statsbomb/open-data) repository using the `StatsBombR` package. It allows you to control which competitions and seasons are downloaded by editing a CSV configuration file.

---

## 📌 Features

- ✅ Accesses the full list of available competitions from StatsBomb
- ✅ Filters for **Champions League** matches only
- ✅ Saves a configurable list of competitions to a local CSV file
- ✅ Loops through each entry in the CSV to:
  - Download match and event data
  - Clean and format the data
  - Save each dataset as an `.RData` file
  - Log any errors during the process to a `.txt` file
- ✅ Includes robust error handling and logging for failed downloads

---

## 🛠️ How It Works

### Step 1: Load Competitions

Fetches the full list of StatsBomb competitions and filters for Champions League games.

### Step 2: Create Configuration File

Saves the filtered list to a local CSV so you can review and select which competitions to include.

> 📄 **Manual step**: Open the CSV and ensure the correct `competition_id`, `season_id`, and `year` values are provided.

### Step 3: Batch Download and Save

Loops through each row of the configuration CSV to:

- Extract match and event data using `FreeMatches()` and `free_allevents()`
- Clean the data using `allclean()` and `cleanlocations()`
- Save the output to a named `.RData` file
- Log any failed attempts to a plain-text error log file

---

## ✍️ Customization

🔁 You can manually modify the competitions_config.csv file to select only specific:

Countries

Seasons

Competitions (e.g., group stage vs final)

🕒 Includes a 3-second delay between downloads to avoid overloading the API

## 📚 Data Source

StatsBomb Open Data

Competition: Champions League

Data License: CC BY 4.0

## 📜 License

This project is for educational and research purposes only, using publicly available open data from StatsBomb.
All R code is released under the MIT License
.

## 👤 Author

Scott Dunn
R Programmer | Football Data Enthusiast | Automation Builder
📫 LinkedIn - https://www.linkedin.com/in/scott-dunn-a5936b23/
