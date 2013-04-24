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
-export([get/2, set/3]).

q(PoolName, Query)->
    Worker = poolboy:checkout(PoolName),
    Reply = gen_server:call(Worker, {rquery, Query}),
    poolboy:checkin(PoolName, Worker),
    Reply.

get(PoolName, Key) ->
    q(PoolName, ["GET", Key]).

set(PoolName, Key, Value) ->
    q(PoolName, ["SET", Key, Value]).
