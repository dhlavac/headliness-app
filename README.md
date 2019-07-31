# Headiness application

Is a simple application which will store and present headlines and comments. The headline is a simple string with length up to 250 characters (Unicode) with additional information like origin, publisher, date of creation and date of update. 

To every headline, there is a possibility to have several comments that discuss or updates the information in the headline. The necessary information about the comment is the author, date of creation and upvotes or downvotes to this comment. The comment itself is a string with no limit whatsoever regarding the length, it can be one sentence or it can be several pages long essay.

##Deployment

Install ruby environment and specific ruby version e.g. 2.5

Then install rails
`gem install rails`
This will install Rails and any other gems it requires.

Install Postgres

Finally, you'll want to install the pg gem so that you can interface with Postgres from Ruby code. To do so:

`gem install pg`

Add following gems to Gemfile
`gem "passenger"`
`gem "sqlite3"`

Setting Up Postgres
Create a Postgres user for the Rails app we'll create in the next step. To do this, switch into the Postgres user:

`su - postgres`



You should give the user account the same name as your app. But for demonstration purposes, this tutorial names the user account myappuser.

sudo adduser myappuser
We also ensure that that user has your SSH key installed:

`sudo mkdir -p ~myappuser/.ssh
touch $HOME/.ssh/authorized_keys
sudo sh -c "cat $HOME/.ssh/authorized_keys >> ~myappuser/.ssh/authorized_keys"
sudo chown -R myappuser: ~myappuser/.ssh
sudo chmod 700 ~myappuser/.ssh
sudo sh -c "chmod 600 ~myappuser/.ssh/*"`

`sudo -u myappuser -H bash -l`

Run `bundle install --deployment --without development test`

Rails also needs a unique secret key with which to encrypt its sessions. Starting from Rails 4, this secret key is stored in config/secrets.yml. But first, we need to generate a secret key. Run:

`bundle exec rake secret`
...
This command will output a secret key. Copy that value to your clipboard. Next, open config/secrets.yml:

nano config/secrets.yml
If the file already exists, look for this:
`
production:
  secret_key_base: <%=ENV["SECRET_KEY_BASE"]%>`
Then replace it with the following. If the file didn't already exist, simply insert the following.

production:
  secret_key_base: the value that you copied from 'rake secret'
To prevent other users on the system from reading sensitive information belonging to your app, let's tighten the security on the configuration directory and the database directory:

`chmod 700 config db
chmod 600 config/database.yml config/secrets.yml`

While in your application's code directory, start Passenger. As configured, it will start on port 80 and will daemonize into the background.

Note that, because Passenger is configured to listen on port 80, this command must be run with root privileges. Only root privileged processes can listen on ports lower than 1024.

`cd /var/www/myapp/code
sudo bundle exec passenger start`


##Maintenance

Dont require any