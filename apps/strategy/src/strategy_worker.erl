-module(strategy_worker).
-behavior(gen_server).

-export([start_link/2, hello/0]).
-export([init/2, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    userid,
    user_name
}).

start_link(UserId, UserName)->
    gen_server:start_link(?MODULE,{UserId, UserName}, []).

hello() ->
    loger:info("Hello"),
    42.

init(UserId, UserName) ->
    State = #state{userid = UserId, user_name = UserName},
    lager:info(" init ~p ~p ~n", [self(), State]),
    {ok, State}.


handle_call(_Request, _From, #state{} = State) ->
    {reply, ok, State}.

handle_cast(_Request,  #state{} = State) -> 
    {reply, ok,  State}.


handle_info(_Request, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.


code_change(_OldVersion, State, _Extra) ->
    {ok, State}.