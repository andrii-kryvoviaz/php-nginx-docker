# PHP + Nginx + Docker Starter

All you need to start a PHP project with Nginx and Docker. Nginx is backed into the image, so you don't need to install it.
Might not be a good idea to use this in production and especially in scalable systems. But it's good for development and small projects. Otherwise, you should use a separate Nginx container and link it to the PHP container.

## Usage

To build the image, run the following command:

```bash
docker build -t <image_name> .
```

Later, you can run the container with the following command:

```bash
docker run -d -p 8080:80 <image_name>
```
