# Google Reviews Averager
This tool will scrape a Google Review URL and will generate the total number of reviews before a certain reviewer's comment and the average of the reviews before that reviewer's comment


# Installation

Install rbenv. See [here](https://brew.sh/) if you need to install homebrew.
```
brew install rbenv
```

Install ChromeDriver.
```
brew tap homebrew/cask && brew cask install chromedriver
```

# Run the Script

Export the variables by typing the following into a terminal
```
export URL="THE_GOOGLE_REVIEW_URL"
```
```
export REVIEWER_NAME="THE_PARTITIONING_GOOGLE_REVIEWERS_NAME"
```
If there is no comment for the reviewer, enter an empty string `export REVIEWER_COMMENT=`
```
export REVIEWER_COMMENT="THE_PARTITIONING_GOOGLE_REVIEWERS_COMMENT"
```