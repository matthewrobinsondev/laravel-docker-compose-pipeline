# Laravel Docker Compose Environment

This project provides a Docker Compose environment for Laravel applications, similar to Sail but without the magic. It allows you to quickly set up and run your Laravel applications in a containerized environment.

## Getting Started
To get started with the Laravel Docker Compose environment, follow the steps below:

### Prerequisites
Make sure you have the following software installed on your machine:

- Docker
- Docker Compose
### Setup
Clone the repository to your local machine:

``` shell
git clone https://github.com/your-username/your-repo.git
```
Navigate to the project directory:

```shell
cd your-repo
```
Build the Docker containers:

``` shell
docker-compose build
```
Start the containers:

``` shell
docker-compose up -d
```

Access your Laravel application at http://localhost:8000.

## Nginx Configuration
The Nginx configuration file used in the Dockerfile sets up the web server for your Laravel application. Here are some important details from the configuration:

- worker_connections: The maximum number of simultaneous connections that each Nginx worker process can handle.

- keepalive_timeout and keepalive_requests: The keep-alive timeout and maximum number of requests per keep-alive connection.

- client_max_body_size and client_body_buffer_size: The maximum allowed size for client request bodies.

- sendfile: Enables the use of sendfile() for serving static files.

- server_tokens: Disables sending Nginx version information in the response headers.

- upstream php-fpm: Defines the upstream PHP-FPM server that Nginx will pass PHP requests to.

- server: Defines the server block for your Laravel application.

  - listen: The port on which Nginx listens for incoming requests.

  - server_name: The domain name associated with your Laravel application.

  - root: The document root directory for your Laravel application.

  - index: The index file to serve when a directory is accessed.

  - error_log and access_log: The paths for Nginx error and access logs.

  - location /: Handles the main requests and attempts to serve static files directly. If the file is not found, it passes the request to index.php.
    
  - location ~ \.php$: Handles PHP files and passes the request to the PHP-FPM server.

You can modify the Nginx configuration according to your specific needs by editing the **nginx.conf** file.

## Additional Information
The Docker Compose environment creates a bridge network named laravel to connect the containers.

The MySQL database data is persisted using a named volume called db-data. This ensures that the data is not lost when the containers are restarted.

## License
This project is licensed under the MIT License.

Feel free to modify and adapt the Docker Compose environment according to your requirements.

Replace your-username and your-repo in the clone command with your GitHub username and repository name, respectively.
