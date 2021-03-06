%% vim: ts=4 sw=4 et

-module(nitrogen_cowboy).
-behaviour(cowboy_http_handler).
-include_lib("nitrogen_core/include/wf.hrl").
-export([init/3, handle/2, terminate/3]).

-record(state, {headers, body}).

init(_Transport, Req, Opts) ->
    {ok, Req, #state{}}.

handle(Req, State) ->
    RequestBridge = simple_bridge:make_request(cowboy_request_bridge, Req),
    %% Becaue Cowboy usese the same "Req" record, we can pass the
    %% previously made RequestBridge to make_response, and it'll
    %% parse out the relevant bits to keep both parts (request and
    %% response) using the same "Req"
    ResponseBridge = simple_bridge:make_response(cowboy_response_bridge, RequestBridge),
    %% Establishes the context with the Request and Response Bridges
    nitrogen:init_request(RequestBridge, ResponseBridge),
    {ok, NewReq} = nitrogen:run(),
    %% This will be returned back to cowboy
    {ok, NewReq, State}.

terminate(_Reason, _Req, _State) ->
    ok.
