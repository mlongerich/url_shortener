# URL Shortener

### Description

##### URL shortener application in Ruby that can generate a unique "short" address.

Short address are generated using the record id. Short URLs are 6 characters long. The record id is converted into a base36 digit and prepended by 0’s. For example, ID 012345 will generate a short url of 0009IX. This allows for 36^6 or 2,176,782,336 different links.

URLs are validated before creation. A protocol (http, https, ftp, etc.) and hostname (blacktangent.com, www.google.com, etc.) are required. Invalid URL’s will not generate a short URL. Instead they will generate an error. Duplicate URLs will not generate a short URL. Instead, they will return the short URL that was generated the first time the URL was submitted.

Submitting a POST request with JSON

For example:
```
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"url":"https://www.blacktangent.com"}' localhost:3000/add
```

Will return `{"short_url":"localhost:3000/000001","url":"https://www.blacktangent.com"}` every time it is submitted.

Successful response follow the format
```
{
    "short_url": "localhost:3000/ABC123"
    "url": "http://www.google.com",   
}
```
Unsuccessful response follow the format

```
{ "error": "URL can’t be blank"}
```


Short URLs are accessible from the root application path. For example: `localhost:3000/ABC123`. Entering the short URL will redirect to the “long” URL. If short URL does not exist an error will be generated stating so.

To easily submit URLs a form is available at the root path `localhost:3000` This page includes:
- submitted to the localhost:3000/add endpoint.
- If the endpoint returns an error, the page indicates this error to the user.
- If the endpoint does not return any errors, it indicate the newly created short URL to the user.

The page uses React and Bulma to improve the look and feel.

On additional `localhost:3000/links` page exists which outputs JSON file of all URLs and short URLs.

### Prerequisite	
- Git installed
  - <https://git-scm.com/book/en/v1/Getting-Started-Installing-Git>
- Yarn installed
  - <https://yarnpkg.com/lang/en/docs/install/#mac-stable>
- Postgresql installed
  - <https://www.postgresql.org/download/>
- Ruby and Rails installed
  - <https://www.ruby-lang.org/en/documentation/installation/>

### Getting Started
In your terminal run the following
1. `git clone https://github.com/mlongerich/url_shortener.git`
2. `cd url_shortener/`
3. `rake db:setup`
4. `yarn install`
5. `rails s`
6. In a second terminal navigate to url_shortener directory and run `bin/webpack-dev-server`. This allows live-reload of files as you edit your assets while the server is running.
7. Open localhost:3000 in your favorite browser.