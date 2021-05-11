# Creating a Rails App

## Learning Goals

- Create a new Rails application from scratch
- Navigate the file structure of a Rails app
- Show how Rails handles requests
- Show how to send JSON or HTML as a response

## Video Walkthrough

This video will cover same the content in the readme below, so it's recommended
that you watch the video and then review the readme for additional clarity on
any parts of the video that were unclear.

<iframe width="560" height="315" src="https://www.youtube.com/embed/gZoxTXnLXLg?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

## Creating Your First Rails Project

> **Before you continue**, this assumes that you have Ruby, RubyGems, and Bundler
> installed on your system.

To get started with Rails, we'll need to first make sure the gem is installed on
your computer. To install the latest version, run:

```bash
gem install rails
```

Once the gem is installed you can create Rails applications!

## Generating a New Rails Application

Our application is going to be called CheeseShop. To create the application, run
the following command:

```bash
rails new cheese-shop --skip-javascript
```

When you run this command, a lot of things will start happening:

- Rails will generate a new directory with all the code required to build your
  application
- It will then run `bundle install` to download all the required gems
- It will also initialize `git` in the newly created directory

There are a number of common naming conventions for Rails app names. Typically
you will want to use all lower case letters, separated by '-', as shown in our
`cheese-shop` naming structure. In the same way that there are rules for naming
methods, variables, classes, etc. in Ruby, there are naming rules for
application names. Since the application name is used as the app constant
throughout the application, the best approach is to keep your naming simple and
to follow a standard naming practice.

> The --skip-javascript flag tells Rails that we won't be using JavaScript for
> this project. Since our JavaScript code will be written in a separate project
> from our Rails code, we don't need any JavaScript dependencies for this app.

## Rails File Structure Overview

Be sure to change into your new Rails app directory, and open the project in your
text editor:

```bash
cd cheese-shop
code .
```

Since you will be working with this file structure on a daily basis, it is very
important to understand and become familiar with the file system. Below is a
breakdown for each directory:

- **app**: contains the Models, Views, and Controllers, along with the rest
  of the core functionality of the application. The majority of
  your time will be spent working in this directory.

- **bin**: some built-in Rails tasks that you most likely will never have to
  work with.

- **config**: the config directory manages a number of settings that control
  the default behavior, including: the environment settings, a set of modules that
  are initialized when the application starts, the ability to set language values,
  the application settings, the database settings, the application routes, and
  lastly the secret key base.

- **db**: within the db directory you will find the database schema file that
  lists the database tables, their columns, and each column's associated data
  type. The schema file can be found at `db/schema.rb`. The db directory also
  contains the `seeds.rb` file, which lets you create some data that can be
  utilized in the application. This is a great way to quickly integrate data in
  the application without having to manually add records through a web form
  element.

- **lib**: while many developers could build full applications without ever
  entering the lib directory, you will discover that it can be incredibly
  helpful. The lib/tasks directory is where custom rake tasks are created. You
  have already used a built-in rake task when you ran the database creation and
  migration tasks; however, creating custom rake tasks can be very helpful and
  sometimes necessary. For example, you could create a custom rake task that
  runs in the background, making calls to an external API and syncing the
  returned data into the application’s database.

- **log**: within the log directory you will discover the application logs.
  This can be helpful for debugging purposes, but for a production application
  it's often better to use an outside service since they can offer more advanced
  services like querying and alerts.

- **public**: this directory contains some of the custom error pages, such as
  404 errors, along with the robots.txt file which allows you to control how
  search engines index the application on the web.

- **test**: by default Rails will install the test suite in this directory.
  This is where all of your specs, factories, test helpers, and test configuration
  files can be found. _Side note: Our labs use RSpec, which means this directory
  will actually be called `spec` in future lessons._

- **tmp**: this is where the temporary items are stored and is rarely accessed
  by developers.

- **vendor**: a folder for third-party code, such as code for JavaScript plugins
  and CSS frameworks.

- **Gemfile**: the Gemfile contains all of the gems that are included in the
  application; this is where you will place outside libraries that are utilized
  in the application. After any change to the Gemfile, you will need to run
  `bundle install`. This will download all of the code dependencies in the
  application. The Gem process can seem like a mystery to new developers, but it
  is important to realize that the Gems that are brought into an application are
  simply Ruby files that help extend the functionality of the app.

- **Gemfile.lock** – this file should not be edited. It is created when you run
  `bundle install` and it displays all of the dependencies that each of the Gems
  contain along with their associated versions. Messing around with the lock
  file can lead to application bugs due to missing or altered Gem dependencies.

- **README.md** – the readme file is an important place to document the
  details of the application. If the application is an open-source project, this
  is where you can place instructions to other developers, such as how to get the
  app up and running locally.

## Starting Up the Rails Server

To startup the Rails server, make sure that you are in the root of the
application in the terminal and run:

```bash
rails s
```

This will startup the rails server and you will see output such as the following:

```txt
=> Booting Puma
=> Rails 6.1.3.1 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.2.2 (ruby 2.7.3-p183) ("Fettisdagsbulle")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 74372
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
```

Now that the server is running properly, you can verify that it's working
properly in the browser by navigating to
[`http://localhost:3000`](http://localhost:3000).

Here you will see the 'Yay! You're on Rails!' page that ships with Rails. It
shows that we're ready to start building the application!

In order to **shutdown** your server, you will need to hit `control + c`.

## Our First Request

At its most basic level, the primary responsibility of Rails is to take a **HTTP
request** and generate a properly-formatted **response**. To demonstrate how the
Rails server handles the request-response cycle, let's take an "error-driven
development" approach, and try making a request to our server that we know won't
work yet.

With your server running, try to visit
[`http://localhost:3000/cheese`](http://localhost:3000/cheese) in the browser.
You'll see an error message like this:

![route missing error](https://curriculum-content.s3.amazonaws.com/phase-4/creating-a-rails-app-readme/routing-error-1.png)

To fix this error, we need to define a **route** in our Rails app. A **route**
is some code that tells Rails: "When a user makes a request with this HTTP verb
and this path, run the code in this controller".

Routes are defined in the `config/routes.rb` file. Open that file, and add this
code:

```rb
# config/routes.rb
Rails.application.routes.draw do
  get "/cheese", to: "cheese#index"
end
```

Here, we're telling Rails, "When a `GET` request to the `/cheese` path comes in,
run the `index` in the method in the `CheeseController`."

Now, back in the browser, visit that [same URL](http://localhost:3000/cheese)
again. A new error message! Progress!

![controller missing error](https://curriculum-content.s3.amazonaws.com/phase-4/creating-a-rails-app-readme/routing-error-2.png)

This error message tells us we're missing a **Controller** to handle this route.

Let's create a controller. In the `app/controllers` folder, add a new file called
`cheese_controller.rb` with the following code:

```rb
# app/controllers/cheese_controller.rb
class CheeseController < ApplicationController

  def index
  end

end
```

Now, when we make a `GET` request to `/cheese`, the code in the
`CheeseController#index` method will run. Try visiting that
[same URL](http://localhost:3000/cheese) again...

![template missing error](https://curriculum-content.s3.amazonaws.com/phase-4/creating-a-rails-app-readme/template-error.png)

Take a minute and read through this error message.

Once again, Rails is helping out (bless up, Rails!) and telling us we need to
create a **template** to handle this particular request. **By convention**,
Rails will look for a special **view** file in a folder that matches the name of
our controller. To create that template, make a new `cheese` folder in
`app/views` and add a `index.html.erb` file with this code:

```erb
<!-- app/views/index.html.erb -->
<h1>Hello Cheese World!</h1>
```

Try visiting that [same URL](http://localhost:3000/cheese) once more...

![cheese html page](https://curriculum-content.s3.amazonaws.com/phase-4/creating-a-rails-app-readme/cheese-page-html.png)

Success at last! We've now gone through the entire request-response cycle in Rails!

Let's take a moment and retrace our steps. From the browser, we made a `GET`
request to `/cheese`. For Rails to handle this request:

- We added a new route in the `config/routes.rb` file
- In that route, we specified a **controller method**
- We created a controller in `app/controllers/cheese_controller.rb` with an
  `index` method
- By convention, Rails will look for a **view template** that matches the name
  of the controller and action
- In that view template, we can write some HTML
- Rails will send that HTML as a response to the browser

### Sending JSON Data

You may be wondering at this point: if we're using Rails as an API, how can we
send back something other than HTML? Rails actually makes this quite easy for us!

Let's go back to the controller, and update the `index` action:

```rb
# app/controllers/cheese_controller.rb
class CheeseController < ApplicationController

  def index
    render json: { hello: "Cheese World" }
  end

end
```

By using the `render` method, we're telling Rails: "instead of rendering an HTML
template, you should send back JSON data as the response".

Try visiting that [same URL](http://localhost:3000/cheese) one last time:

![cheese json page](https://curriculum-content.s3.amazonaws.com/phase-4/creating-a-rails-app-readme/cheese-page-json.png)

That `render` method is a powerful bit of code. Keep in mind that as a server,
it's always our job to send back a response to every request. When we're
developing Rails APIs, using `render` to send back JSON data will be our goal
for almost every request!

Throughout this phase, we'll be focusing on Rails as an API, so don't worry too
much about the `.erb` view files for the time being.

## Conclusion

At this point, we've learned how to use Rails to send back HTML or JSON data as
a response when our server receives a request. We've also covered the basics of
Rails file structure, and a few important places where we'll be writing the
majority of our code as Rails developers. This lesson covered a lot of ground at
a high level, so don't worry if all the pieces aren't totally clear yet.
Throughout the rest of the section, we'll dive deeper into each of the pieces
that make up a Rails API.

## Resources

- [The Rails Command Line](https://guides.rubyonrails.org/command_line.html)
