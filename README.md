# Working with APIs

## APIs and the Web

Until now, we've been working with APIs via some lovely Ruby gems. But what's really going on behind the scenes? According to [Wikipedia](https://en.wikipedia.org/wiki/Web_API): `A server-side web API is a programmatic interface to a defined request-response message system, typically expressed in JSON or XML, which is exposed via the web—most commonly by means of an HTTP-based web server.`

What does this mean? That by sending out a series of GET and POST requests, we can communicate with APIs to receive and send information.

## Authentication without the OAuth Gem

Take a look at the [OAuth section of the Github API Documentation](https://developer.github.com/v3/oauth/), specifically the first sub-section, called 'Web Application Flow'. This documentation lists three steps to make API calls: redirect users to request GitHub access, GitHub redirects back to your site, and use the access token to access the API.

#### Redirect users to request GitHub access

First off, we need to [register our application with Github](https://github.com/settings/applications/new). In this case, our redirect URL is `http://localhost:3000/auth`, which takes us to `sessions#create`. Our homepage URL is `http://localhost:3000/`. We also need to create a `.env` [file](https://github.com/bkeepers/dotenv) that holds our `GITHUB_CLIENT` and `GITHUB_SECRET`.

Ultimately, a user will be considered "logged in" if they have an access token stored in their session. So, let's create a private method `#logged_in?` in our `ApplicationController` that will return false if `session[:token]` is nil and true otherwise:

```ruby
private
  def logged_in?
    !!session[:token]
  end
```

Now, write another private method `#authenticate_user` that will redirect the user to `https://github.com/login/oauth/authorize` _if_ the user is not already logged in. You'll need to send a few parameters along with your redirection: `client_id` should have a value of `ENV[GITHUB_CLIENT]`, and `scope` should have a value of `repo`. You can send these parameters via a [query string](https://en.wikipedia.org/wiki/Query_string).
