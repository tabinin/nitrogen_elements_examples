% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body() ->

    %% wf:wire(jqgrid, #jqgrid_event{type = ?ONSELECTROW, postback = jqgrid }),
    %% wf:wire(jqgrid, #jqgrid_event{type = ?ONSELECTROW, event_name="myEvent"}),
    %% wf:wire(jqgrid, #jqgrid_event{type = ?ONCELLSELECT, event_name="myEvent"}),

    [
	#jqgrid{
	    id = jqgrid,
	    options=[
		{url, 'get_jqgrid_data'},
		{datatype, <<"json">>},
		{colNames, ['ID', 'Name', 'Values']},
		{colModel, [
		    [{name, 'id'}, {index, 'id'}, {width, 55}],
		    [{name, 'name'}, {index, 'name1'}, {width, 80}],
		    [{name, 'values1'}, {index, 'values1'}, {width, 100}]
		]},
		{rowNum, 10},
		{rowList, [10, 20, 30]},
		{sortname, 'id'},
		{viewrecords, true},
		{sortorder, <<"desc">>},
		{caption, <<"JSON Example">>}
	    ],
	    actions = [#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONSELECTROW}]
	}
    ].

%% event(?ONCELLSELECT, RowId, ICol, Cellcontent) ->
%%     ?PRINT({jqgrid_event, ?ONCELLSELECT, RowId, ICol, Cellcontent}).
%% event(?ONSELECTROW, RowId, Status) ->
%%     ?PRINT({jqgrid_event, ?ONSELECTROW, RowId, Status}).

event(Event) ->
    ?PRINT({jqgrid_event, Event}).

%% api_event(history_back, _B, [[_,{data, Data}]]) ->
%%     %% ?PRINT({history_back_event, B, Data}),
%%     TabIndex = proplists:get_value(tabindex, Data),
%%     wf:wire(tabs, #tab_event_off{event = ?EVENT_TABSSHOW}),
%%     wf:wire(tabs, #tab_select{tab = TabIndex}),
%%     wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW});
%% api_event(A, B, C) ->
%%     ?PRINT(A), ?PRINT(B), ?PRINT(C).
