# Working with APIs

## APIs and the Web

Until now, we've been working with APIs via some lovely Ruby gems. But what's really going on behind the scenes? According to [Wikipedia](https://en.wikipedia.org/wiki/Web_API): `A server-side web API is a programmatic interface to a defined request-response message system, typically expressed in JSON or XML, which is exposed via the web—most commonly by means of an HTTP-based web server.`

What does this mean? That by sending out a series of GET and POST requests, we can communicate with APIs to receive and send information.

## Authentication without the OAuth Gem

Take a look at the [OAuth section of the Github API Documentation](https://developer.github.com/v3/oauth/), specifically the first sub-section, called 'Web Application Flow'. This documentation lists three steps to make API calls: redirect users to request GitHub access, GitHub redirects back to your site, and use the access token to access the API.

#### Redirect users to request GitHub access

First off, we need to [register our application with Github](https://github.com/settings/applications/new). In this case, our redirect URL is `http://localhost:3000/auth`, which takes us to `sessions#create`. Our homepage URL is `http://localhost:3000/`.

