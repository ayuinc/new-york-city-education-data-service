NYC Education Test
======

This app has three features: search by address with geolocation data, fuzzy
search by name, and a report generator that compareds JSON for the 7032 JSON school records from ayu.com/nyceducation and compares them with the actual data from a CSV.

Eventually the aim is to be able to make the testing of data more scalable by allowing a user to load a CSV on the browser and generating a report that is emailed to the user. 

For now you need to run it locally on your machine or you can look at the report generated for you here:

[Data Report](report.md)

How to run it on your machine

This app generates almost 20 thousand records so setup can take a while. If your
new to Rails you'll need to do the following:

First you need to install all the dependencies. Go to the root of the app and in the console type:

```console
bundle install
```

Next you want to create the database:

```console
rake db:create
rake db:migrate
```

Then you need to populate the correct school data from the csv in lib/csv/

```console
rake csv:import
```

To import the geolocation data for the schools

```console
rake geocode:all CLASS=School SLEEP=0.25 BATCH=100
```

Now import the data from the NYC Education API (Note this can take almost half an hour)

```console
rake api_data:import
```

Finally, to run the test:

```console
rake data_test:run
```
