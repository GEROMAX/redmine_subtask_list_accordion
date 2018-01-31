# Redmine Subtask List Accordion

This plugin provide accordion to subtask list of issue.

* http://www.redmine.org/plugins/redmine_subtask_list_accordion

## Features

* Add accordion feature to subtask-list.
* Add function 'Expand this tree', 'Collapse this tree' and 'Expand next level all' to context-menu.
* Add preferences of expand tree at first time.
* Add plugin setting for server/client processing mode switch. (server mode default)  
Server mode is faster than client mode, but server mode is tradeoff other subtask's plugin. (for exsample 'subtask_list_columns' plugin)

## Compatibility

Redmine 3.3 or 3.4 stable

Tested on:
* 3.3.6
* 3.4.4

## Installation

1. Follow the Redmine plugin installation steps at: http://www.redmine.org/wiki/redmine/Plugins
2. Run the plugin migrations `rake redmine:plugins:migrate RAILS_ENV=production`
3. Restart your Redmine web server
