NYC Education Test
======

This app is designed to make sure the JSON returned by http://ayuinc.com/nyceducation is accurate. This app compares almost 10 thousand records so setting up the app might take a little while.

To install the app the first thing you want to do is create the database

```console
rake db:create
rake db:migrate
```

Then you need to populate the correct school data

```console
rake csv:import
```

Now import the data from the NYC Education API

```console
rake education_api:import
```

