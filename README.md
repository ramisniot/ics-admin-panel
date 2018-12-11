Sensors Admin Panel
===================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


Ruby on Rails
-------------

This application requires:

- Ruby 2.4.1
- Rails 4.2.8

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

About
-----

This is an example of an Admin panel for display and manage values from sensors connected to an Arduino. 

Original Author
---------------

Rami, *a.k.a* Ramesh K - [rameshkror@gmail.com](rameshkror@gmail.com)

Getting Started
---------------

To start using this Admin panel, you only have to do the typical ***Rails*** things:

* Install ***Ruby*** version 2.4.1 (using [RVM](https://github.com/rvm/rvm) or [RBenv](https://github.com/sstephenson/rbenv) or whatever).

* Clone the repo and do the ***bundle install*** thing:

```sh
user@computer:~$ git clone git@github.com:ramisniot/ics-admin-panel.git
user@computer:~$ cd ics-admin-panel
user@computer:/ics-admin-panel$ bundle install
user@computer:/ics-admin-panel$ rake db:setup
```

* When all this finish, you're ready to launch the app!

```sh
user@computer:/ics-admin-panel$ rails s
```

* Open your web browser and go to [http://localhost:3000](http://localhost:3000) like in all the regular ***Rails*** apps.



Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

License
-------

**ICS Admin Panel** is released under the [MIT License](http://www.opensource.org/licenses/MIT).
