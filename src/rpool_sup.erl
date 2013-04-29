
-module(rpool_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).


%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, Pools} = application:get_env(rpool, pools),
    PoolSpecs = lists:map(fun({PoolName, PoolConfig}) ->
        Args = [{name, {global, PoolName}},
                {worker_module, rpool_worker}]
                ++ PoolConfig,
        {PoolName, {poolboy, start_link, [Args]},
                    permanent, 5000, worker, [poolboy]}
    end, Pools),
    {ok, {{one_for_one, 10, 10}, PoolSpecs}}.

