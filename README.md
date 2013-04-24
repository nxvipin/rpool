# Rpool - Eredis over Poolboy

## Introduction

Rpool is Eredis over Poolboy. `redis_pool` defines the front end API. Only the `get` and `set` functions have a public API now. `redis_pool:q(PoolName, Query)` provides a similar interface to that of `eredis:q` but is not exported.


## Usage

```erl-sh
1> application:start(rpool).
ok
2> redis_pool:get(redispool,"testkey").
{ok,<<"testvalue">>}
```

## Authors

Vipin Nair (swvist) <swvist@gmail.com>

## License

Rpool is available under MIT License. Rpool uses Poolboy which is in public domain and Eredis which is under the MIT License.