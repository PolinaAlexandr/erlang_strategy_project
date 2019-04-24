%%%-------------------------------------------------------------------
%% @doc strategy top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(strategy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    io:format("sup start link~n"),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    io:format("sup init~n"),
        SupervisorSpecification = #{
            strategy => one_for_one,
            intensity => 10,
            period => 60},
    
        ChildSpecifications = 
            [#
                {id => strategy_worker_1,
                start => {strategy_worker, start_link, [1,"BOB"]},
                restart => permanent,
                shutdown => 2000,
                type => worker,
                modules => [strategy_worker]}
            ],
            [#
                {id => strategy_worker_2,
                start => {strategy_worker, start_link, [2, "JACK"]},
                restart => permanent,
                shutdown => 2000,
                type => worker,
                modules => [strategy_worker]}
        ],
            
        {ok, {SupervisorSpecification, ChildSpecifications}}.

%%====================================================================
%% Supervisor callbacks
%%====================================================================
%%====================================================================
%% Internal functions
%%====================================================================
