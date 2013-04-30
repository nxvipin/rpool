%%%-------------------------------------------------------------------
%%% @author Vipin Nair <swvist@gmail.com>
%%% @copyright (C) 2013, Vipin Nair
%%% @doc
%%% Front end API for rpool
%%% @end
%%% Created : 24 Apr 2013 by Vipin Nair <swvist@gmail.com>
%%%-------------------------------------------------------------------

-module(redis_pool).


%% API
-export([
	 get/2,
	 set/3,
	 del/2,
	 sadd/3,
	 srem/3,
	 sismember/3,
	 smembers/2
	]).


						% Generic Query
q(PoolName, Query)->
    Worker = poolboy:checkout(PoolName),
    Reply = gen_server:call(Worker, {rquery, Query}),
    poolboy:checkin(PoolName, Worker),
    Reply.

%% String Operations
get(PoolName, Key) ->
    q(PoolName, ["GET", Key]).

set(PoolName, Key, Value) ->
    q(PoolName, ["SET", Key, Value]).

del(PoolName, Key) ->
	q(PoolName, ["DEL", Key]).

%% Set Operations
sadd(PoolName, Key, Value) ->
    q(PoolName, ["SADD", Key, Value]).

srem(PoolName, Key, Value) ->
    q(PoolName, ["SREM", Key, Value]).

sismember(PoolName, Key, Value) ->
    q(PoolName, ["SISMEMBER", Key, Value]).

smembers(PoolName, Key) ->
	q(PoolName, ["SMEMBERS", Key]).
