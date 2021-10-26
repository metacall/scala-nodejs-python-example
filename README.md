# MetaCall Scala NodeJS Python Example

This example shows how call NodeJS and Python functions from Scala.

## Docker

Building and running with Docker:

```bash
docker build --build-arg DISABLE_CACHE=`date +%s` -t metacall/scala-nodejs-python-example .
docker run --rm -it metacall/scala-nodejs-python-example
```
