# MetaCall Python NodeJS Scala Example

This example shows how call Python and NodeJS functions from Scala.

## Docker

Building and running with Docker:

```bash
docker build --build-arg DISABLE_CACHE=`date +%s` -t metacall/python-nodejs-scala-example .
docker run --rm -it metacall/python-nodejs-scala-example
```
