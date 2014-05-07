Pyc
===
Database group project - basically an imgur clone

# Instructions for running locally

Installing and running Pyc locally will require installing Ruby, Rails, and this codebase.

To install Ruby, choose one of the installation methods on [this website](https://www.ruby-lang.org/en/installation/). RVM was used for Linux machines working on this project.

To install Rails, visit [this informative page](http://guides.rubyonrails.org/getting_started.html) to get started.

Lastly, to get Pyc running locally follow these steps:

1. Navigate to the project directory for Pyc
2. Run ```bundle install```
3. Run ```rake db:migrate```

You should now be able to run the command ```rails s``` and visit ```localhost:3000``` in your browser to see Pyc running locally.
