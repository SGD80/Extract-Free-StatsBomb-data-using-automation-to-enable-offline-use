# Load required libraries
library(readr)
library(StatsBombR)
library(dplyr)

## Filtering Champions League matches from StatsBomb free data 
Comp <- FreeCompetitions() %>% 
  filter(competition_name == "Champions League")

# Creating a CSV file to control the which competition is extracted and saved locally.
# 
write.csv(Comp, " Enter your own local location here ")

# Load data index once
data_index <- read_csv(" Same as the local location above ")

# Clean file-safe name function
safe_name <- function(x) {
  gsub("[^a-zA-Z0-9]", "_", x)
}

# Load all available competitions once
all_comps <- FreeCompetitions()

# Error log file path
log_file <- " Enter your own local location here use this end for text document - /error_log.txt"
writeLines("=== StatsBomb Data Download Log ===", log_file)

# Loop through data index
for (i in seq_len(nrow(data_index))) {
  
  # Extract and clean identifiers
  country <- safe_name(data_index$country_name[i])
  competition <- safe_name(data_index$competition_name[i])
  year <- safe_name(data_index$year[i])  # Ensure this column exists in CSV
  comp_id <- data_index$competition_id[i]
  season_id <- data_index$season_id[i]
  
  cat("Processing:", country, "-", competition, "-", year, "\n")
  
  tryCatch({
    # Filter the competition for current loop iteration
    Comp <- all_comps %>%
      filter(competition_id == !!comp_id, season_id == !!season_id)
    
    if (nrow(Comp) == 0) stop("No matching competition found in FreeCompetitions.")
    
    # Download match and event data
    Matches <- FreeMatches(Comp)
    
    if (nrow(Matches) == 0) stop("No match data returned.")
    
    StatsBombData <- free_allevents(MatchesDF = Matches, Parallel = TRUE)
    
    if (nrow(StatsBombData) == 0) stop("No event data returned.")
    
    # Clean data
    StatsBombData <- allclean(StatsBombData)
    StatsBombData <- cleanlocations(StatsBombData)
    
    # Save data
    save_path <- paste0("  Enter your own local location here - for CSV file end - .csv   ", 
                        country, "_", competition, "_", year, ".RData")
    save(StatsBombData, file = save_path)
    
    cat("Saved:", save_path, "\n")
    
  }, error = function(e) {
    # Handle and log errors
    msg <- paste(Sys.time(), "-", country, competition, year, "FAILED:", e$message)
    cat(msg, "\n")
    write(msg, file = log_file, append = TRUE)
  })
  
  # Clear and pause
  rm(list = setdiff(ls(), c("data_index", "safe_name", "log_file", "all_comps")))
  gc()
  Sys.sleep(3)
}
