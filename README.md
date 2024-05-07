# Books and Authors API
The Books and Authors API allows for the management of user accounts, books, and authors. This document outlines how to set up and run the project, as well as a comprehensive guide to the available API endpoints.

### Getting Started
Prerequisites
- Ruby on Rails
- PostgreSQL

Installation
1. Clone the repository
```
git clone https://github.com/alejandrotoledoweb/books_authors_api.git
cd books_authors_api
```

2. Install dependencies
```
bundle install
```

3. Create and setup the database
Run the following commands to create and setup the database.
```
rails db:create
rails db:migrate
rails db:seed
```
To start the Rails server, run:

```
rails s
```
The API will be available at http://localhost:3000.

### API Endpoints
All API endpoints require authentication. Include the following header on all requests:

# Important:
### To access all endpoint and create new users only the admin can do it

```
username: "Admin"
password: "admin123456"
```
With this credential to will generate the jwt to access all others endpoints

### Below are the descriptions of the available API endpoints.


#### User Management
```
Create User
Method: POST
URL: /api/v1/create
Headers: Authentication: "Bearer <token>"
Body:

{
  "username": "user5",
  "password": "foobar123",
  "password_confirmation": "foobar123"
}
```

```
Description: Registers a new user with the system.
Authenticate
Method: POST
URL: /api/v1/authenticate
Headers: Authentication: "Bearer <token>"
Body:
{
  "username": "Admin",
  "password": "admin123456"
}
````

#### Book Management
```
Get All Books
Method: GET
URL: /api/v1/books
pagination_params: offset, limit
Headers: Authentication: "Bearer <token>"
````
```
Create a Book
Method: POST
URL: /api/v1/books
Headers: Authentication: "Bearer <token>"
Body:
{
  "title": "Javascript Elocuent",
  "published_year": 2015,
  "author_id": 1
}
```
```
Get Book by Title
Method: GET
URL: /api/v1/books/show/?title=javasr
Headers: Authentication: "Bearer <token>"
````
```
Delete a Book
Method: DELETE
URL: /api/v1/books/4
Headers: Authentication: "Bearer <token>"
```
#### Author Management
```
Show All Authors
Method: GET
URL: /api/v1/authors
pagination_params: offset, limit
Headers: Authentication: "Bearer <token>"
````
```
Create a New Author
Method: POST
URL: /api/v1/authors
Headers: Authentication: "Bearer <token>"
Body:
{
  "name": "David Flanagan 2",
  "birthdate": "1980-24-01"
}
```
### Testing
Run unit tests for the project using the following command:

```
rspec
```
This command will execute all the defined tests in the spec directory.

Additional Documentation
For further API documentation, refer to the Postman collection or other specified API documentation tools.

