# Sample repo to work on prometheus-net issues

## building

`./build.sh` will 

* build and publish the project
* build the dockerfile for the app
* start the container

## testing

`./test.sh` will

* fire 100 requests to the running app's metrics endpoint

## debugging

Attach to the container:

```shell
docker exec -it prom-test /bin/bash
```

Now you can take dumps easily using `dotnet dump` because in the container the app is always PID 1:

```shell
dotnet dump collect --process-id 1
```

And you can analyze the app with `dotnet dump` as well:

```shell
dotnet dump analyze path/to/core/file
```

If necessary, you can get symbols for the dump via `dotnet symbol`:

```shell
dotnet symbol path/to/core/file
```

And finally you can launch lldb with the libsosplugin.so file already loaded:

```shell
lldb prometheus-net-example --core path/to/core/file
```


## tracing

run the container via the `build.sh` script, but add `/bin/bash` to the end so that you launch into a shell.

Run the app, get the PID, start tracing:

```shell
./prometheus-net-example >/dev/null & export PROC_ID=$(echo "$!") && ~/.dotnet/tools/dotnet-trace collect --process-id $PROC_ID --format speedscope --output /output/trace
```

load the `./output/trace.speedscope.json` file via speedscope.

see the single-thread


