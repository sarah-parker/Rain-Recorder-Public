# Rain Recorder

A Flutter project designed for recording rainfall, storing in Firebase, and displaying in useful graphs. 

For personal use only, so certain bugs have been deemed acceptable. 
The app could be reusable if more work was done to lock down the Weather Station integration to the one user.

## Features:

### General:
<ul>
  <li> Allows for signing up, in and out, storing credentials in Firebase</li>
  <li> Stores rain data in Firebase</li>
  <li> Rain data is stored separately for each authenticated user, allowing for multiple users if the Weather Station integration is removed</li>
</ul>

### Calendar Screen
<ul>
  <li> Manually enter or delete rainfall</li>
  <li> Integrates with at home Weather Station API, automatically adds rain each day (API sends data at 1 min past each hour)</li>
  <li> Card displaying current temperature, feels like temperature, daily rainfall, and year to date rainfall </li>
  <li> Manually update 7 day historical rain data on button press </li>
  <li> Calendar allows for quick selection of month or year, back to today, as well as scrolling across through months</li>
</ul>

### Graphs Screen
<ul>
  <li> Choice of viewing data for a single month, year, all years, or comparing each month in up to three years</li>
  <li> Graph options (eg particular year or month) shouldn't be displayed if there is no data to see, this is a work around for a known bug</li>
</ul>

## Import/ Export Screen
<ul>
  <li> Import data stored in a text or csv file (useful when moving from one rain app to another)</li>
  <li> Export data into a csv, file saved into users Downloads folder</li>
</ul>

## Visual
![app_WS_integrated](https://user-images.githubusercontent.com/61951940/152063400-c3345682-5601-4c36-b6db-22cab6ab6846.gif)
