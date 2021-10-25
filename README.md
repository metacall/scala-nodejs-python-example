# MetaCall Scala NodeJS Python Example

This example shows how call NodeJS and Python functions from Scala.

## Docker

Building and running with Docker. Note, replace `<your_github_token>` by your GitHub token (it must only have `read:packages` permission):

```bash
docker build --build-arg DISABLE_CACHE=`date +%s` --build-arg GITHUB_TOKEN=<your_github_token> -t metacall/scala-nodejs-python-example .
docker run --rm -it metacall/scala-nodejs-python-example
```
