# Corona_tracker
## A R+NodeJs app tracking the cases of the corona virus

The data is sourced and scrapped from multiple sources which include Worldometer and WHO. The ETL process is done using a Nodejs app hosted on Heroku and the data is presented using Shiny in R

![screenshot](https://github.com/vic7ord1st/Corona_tracker/blob/master/screenshot.png)

The app refreshes with the up-to-date data everyday. It shows the number of individuals currently infected with the virus, individuals with mild condition, cases with outcome (Recovered or Death) and those with critical conditions.

The App also contains interactive graphs which shows the distribution of the corona virus cases across countries with confirmed cases and the total deaths by date.
