% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

%% Nitrogen implementation for the jQuery progressbar demo from here http://www.youtube.com/watch?v=bYTRKfcG6Rg

-module(progressbar).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body(Tag) ->

    Actions = #event{type=keyup, trigger = password,
		     actions = [wf:f("$(function(){var len = jQuery(obj('~s')).val().length;
                                      jQuery(obj('~s')).progressbar({value : len * 10});
                                      })", [password, progressbar])]},
    %% output html markup
    [
	%% set of controls for test progressbar without postback
	#panel{ body = [
	    #label { text = "Password Box : " },
	    #password {id = password, text="", actions = Actions },
	    #p{},
	    #progressbar{ id = progressbar, style = "width:230px; height:5px;", options=[{value, 0}]}
	]},
	#p{},
	%% set of controls for test progressbar with postback
	#panel{body = [
	    #label { text="Example for password box with postback: " },
	    #p{},
	    #label { text="Password Box: " },
	    #password {id = password_1, text="", actions = [#event{type = keyup, postback = {Tag, {password_1, keyup}}}]},
	    #p{},
	    #progressbar{ id = progressbar_1, style = "width:230px; height:5px;", options=[{value, 0}]}
	]}
    ].

event({_ID, keyup}) ->
    %% get current values from password box with id = password_1
    Len = length(wf:q(password_1)),
    ?PRINT({password_length, Len}),
    wf:wire(progressbar_1, #progressbar_value{value = Len * 10});
event(Event) ->
    ?PRINT({Event}).
